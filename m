Message-Id: <199905191823.UAA03800@mitra.phys.uit.no>
To: linuxppc-dev@lists.linuxppc.org
Cc: linuxppc-user@lists.linuxppc.org
Subject: Patch: PB G3 volume and mute buttons (2nd attempt)
From: Alvin Brattli <Alvin.Brattli@phys.uit.no>
Date: Wed, 19 May 1999 20:23:46 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Since I have received very little feedback regarding my patches
implementing support for the mute and volume buttons on the PowerBook
G3, I'm reposting the patches here, in case they have been overlooked.
The patches are relative to kernel 2.2.8 from ftp.kernel.org.

The code implements the following:
* Pressing volume up/down increases/decreases the volume on the built-in
  loudspeakers.  Since they autorepeat, the volume will increase/decrease
  steadily until max volume is reached, or until the button is released.
  Pressing alt-volume up/down sets the volume to the highest/lowest
  possible volume.  Pressing the volume buttons in combination with shift
  (and shift-alt) does the same thing with line out.
* Pressing the mute button toggles muting of the loudspeakers (line out
  if pressed in combination with shift).  If muted, the speakers (line out)
  can be unmuted by either pressing mute (shift-mute) again, or changing
  the volume using the volume (shift-volume) buttons.  If muted this
  way, software cannot unmute simply by setting the volume - the
  speakers have to be unmuted explicitly.  Things are done this way to
  let the user be in control (if the user mutes the speakers with the
  mute button, it's fair to assume that that's the way the user _wants_
  it to be). 
* Autorepeat is also added to the LCD backlight button.  Pressing
  backlight up/down in combination with the alt key sets the intensity
  to maximum/minimum (without switching it off) intensity.



--- drivers/macintosh/mac_keyb.c.orig	Thu Apr 29 21:53:48 1999
+++ drivers/macintosh/mac_keyb.c	Fri May 14 22:48:39 1999
@@ -226,6 +226,10 @@
 static struct timer_list repeat_timer = { NULL, NULL, 0, 0, kbd_repeat };
 static int last_keycode;
 
+/* buttons_input needs to know if shift or option key is down */
+static int shift_down;
+static int option_down;
+
 static void mackeyb_probe(void);
 
 static void keyboard_input(unsigned char *, int, struct pt_regs *, int);
@@ -234,6 +238,7 @@
 static void mac_put_queue(int);
 
 static void buttons_input(unsigned char *, int, struct pt_regs *, int);
+static void buttons_handler(unsigned char *, int);
 
 static void init_trackpad(int id);
 static void init_trackball(int id);
@@ -338,6 +343,12 @@
 	if (!repeat)
 		del_timer(&repeat_timer);
 
+	/* buttons_handler() needs to know state of shift and option keys */
+	if (keycode == 0x38)
+		shift_down = !up_flag;
+	if (keycode == 0x3a)
+		option_down = !up_flag;
+
 #ifdef CONFIG_ADBMOUSE
 	/*
 	 * XXX: Add mouse button 2+3 fake codes here if mouse open.
@@ -558,9 +569,31 @@
 }
 #endif /* CONFIG_ADBMOUSE */
 
+
+/* Autorepeat delays for ADB buttons */
+#define BUTTON_DELAY0	(HZ/2)
+#define BUTTON_DELAY1	(HZ/6)
+
 /* XXX Needs to get rid of this, see comments in pmu.c */
 extern int backlight_level;
 
+/* Timer for buttons autorepeat */
+static struct timer_list button_timer;
+/* Store buttons data here between each interrupt */
+static unsigned char button_data[4];
+
+/* Interrupt handler for ADB button autorepeat */
+static void
+buttons_repeat(unsigned long x)
+{
+	unsigned long flags;
+
+	save_flags(flags);
+	cli();
+	buttons_handler(button_data, BUTTON_DELAY1);
+	restore_flags(flags);
+}
+
 static void
 buttons_input(unsigned char *data, int nb, struct pt_regs *regs, int autopoll)
 {
@@ -572,47 +605,86 @@
 	/* Ignore data from register other than 0 */
 	if ((adb_hardware != ADB_VIAPMU) || (data[0] & 0x3) || (nb < 2))
 		return;
-		
-	switch (data[1]&0xf )
+
+	buttons_handler(data, BUTTON_DELAY0);
+}
+
+static void
+buttons_handler(unsigned char *data, int repeat_delay)
+{
+	int down_flag;
+	int repeat_flag = 0;
+
+	extern int pmac_togglemute(int);
+	extern int pmac_addto_volume(int, int);
+
+	del_timer(&button_timer);
+
+	down_flag = data[1] == (data[1] & 0xf);
+	switch (data[1]&0xf)
 	{
 		/* mute */
 		case 0x8:
 			/* down event */
-			if ( data[1] == (data[1]&0xf) ) {
+			if (down_flag) {
+				if (pmu_get_model() == PMU_HEATHROW_BASED)
+					pmac_togglemute(shift_down? 2:4);
 			}
 			break;
-		/* contrast decrease */
+		/* contrast decrease (volume decrease on PowerBook G3) */
 		case 0x7:
 			/* down event */
-			if ( data[1] == (data[1]&0xf) ) {
+			if (down_flag) {
+				if (pmu_get_model() == PMU_HEATHROW_BASED)
+					pmac_addto_volume(shift_down? 2:4, option_down? -1000:-7);
+				repeat_flag = !option_down;
 			}
 			break;
-		/* contrast increase */
+		/* contrast increase (volume increase on PowerBook G3) */
 		case 0x6:
 			/* down event */
-			if ( data[1] == (data[1]&0xf) ) {
+			if (down_flag) {
+				if (pmu_get_model() == PMU_HEATHROW_BASED)
+					pmac_addto_volume(shift_down? 2:4, option_down? 1000:7);
+				repeat_flag = !option_down;
 			}
 			break;
 		/* brightness decrease */
 		case 0xa:
 			/* down event */
-			if ( data[1] == (data[1]&0xf) ) {
-				if (backlight_level > 2)
+			if (down_flag) {
+				if (!option_down && backlight_level > 2)
 					pmu_set_brightness(backlight_level-2);
 				else
-					pmu_set_brightness(0);
+					pmu_set_brightness(option_down? 1:0);
+				repeat_flag = !option_down;
 			}
 			break;
 		/* brightness increase */
 		case 0x9:
 			/* down event */
-			if ( data[1] == (data[1]&0xf) ) {
-				if (backlight_level < 0x1e)
+			if (down_flag) {
+				if (!option_down && backlight_level < 0x1e)
 					pmu_set_brightness(backlight_level+2);
 				else 
 					pmu_set_brightness(0x1f);
+				repeat_flag = !option_down;
 			}
 			break;
+		default:
+			/* another button */
+			break;
+	}
+
+	if (repeat_flag) {
+		button_data[0] = data[0];
+		button_data[1] = data[1];
+		button_data[2] = data[2];
+		button_data[3] = data[3];
+		button_timer.expires = repeat_delay + jiffies;
+		button_timer.data = 0;
+		button_timer.function = buttons_repeat;
+		add_timer(&button_timer);
 	}
 }
 
--- drivers/sound/dmasound.c.orig	Fri May 14 22:24:46 1999
+++ drivers/sound/dmasound.c	Fri May 14 22:42:18 1999
@@ -243,6 +243,9 @@
 static volatile struct dbdma_cmd *beep_dbdma_cmd;
 static void (*orig_mksound)(unsigned int, unsigned int);
 
+/* Mute/unmute status */
+static int is_mute;
+
 /* Burgundy functions */
 static void awacs_burgundy_wcw(unsigned addr,unsigned newval);
 static unsigned awacs_burgundy_rcw(unsigned addr);
@@ -3143,6 +3146,7 @@
 		awacs_write((n << 12) | rn);
 		volume = awacs_get_volume(rn, lshift);
 	}
+	r1 |= is_mute;
 	if (r1 != awacs_reg[1]) {
 		awacs_reg[1] = r1;
 		awacs_write(r1 | MASK_ADDR1);
@@ -3194,6 +3198,70 @@
 	restore_flags(flags);
 }
 
+
+/* Toggle muting of headphones (n==2) or speakers (n==4) */
+int
+pmac_togglemute(int n)
+{
+	int mask;
+
+	if (n == 2)
+		mask = MASK_AMUTE;
+	else if (n == 4)
+		mask = MASK_CMUTE;
+	else
+		return 0;
+
+	is_mute ^= mask;
+	awacs_reg[1] ^= mask;
+	awacs_write(awacs_reg[1] | MASK_ADDR1);
+
+	return is_mute & mask;
+}
+
+/* Adjust volume of headphones (n==2) or speakers (n==4) */
+int
+pmac_addto_volume(int n, int incr)
+{
+	int volume, v1, v2, mask;
+
+	if (n == 2)
+		mask = MASK_AMUTE;
+	else if (n == 4)
+		mask = MASK_CMUTE;
+	else
+		return 0;
+		
+	if (is_mute & mask)
+		is_mute &= ~mask;
+	if (incr > 100)
+		volume = 0x6464;
+	else if (incr < -100)
+		volume = 0x0101;
+	else {
+		volume = awacs_get_volume(awacs_reg[n], 6);
+		v1 = ((volume >> 8) & 0x0ff) + incr;
+		v2 = (volume & 0x0ff) + incr;
+		if (v1 > 100)
+			v1 = 100;
+		if (v2 > 100)
+			v2 = 100;
+		if (v1 <= 0 && v2 <= 0) {
+			volume = 0;
+		} else {
+			if (v1 < 1)
+				v1 = 1;
+			if (v2 < 1)
+				v2 = 1;
+			volume = (v1 << 8) | v2;
+		}
+	}
+	awacs_volume_setter(volume, n, mask, 6);
+
+	return volume;
+}
+
+
 static void
 pmac_awacs_tx_intr(int irq, void *devid, struct pt_regs *regs)
 {

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
