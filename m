Message-Id: <199903071729.SAA11528@mitra.phys.uit.no>
To: linuxppc-dev@lists.linuxppc.org
Subject: More patches for PB G3 volume and mute buttons
From: Alvin Brattli <Alvin.Brattli@phys.uit.no>
Date: Sun, 07 Mar 1999 18:29:06 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here is a further development of my patches for the mute and volume
buttons on the PowerBook G3.  Here, I have added some minor details,
plus autorepeat for the volume and brightness control buttons.

*** The original patch implemented the following:

Pressing the mute button toggles the muting of the internal speakers on
the PowerBook G3.  Changing the volume via xmixer, kmix, etc. does not
unmute the speakers, as this implementation gives precedence to the
user's choice of muting via the button.  However, the volume *can* be
changed this way, but this does not go into effect until the speakers
are unmuted again.

The volume buttons work as expected; they change the speaker volume.  If
the speakers are muted, they will be unmuted, and the volume will be
increased/decreased from the level set before muting (or from the level
set by xmixer/kmix while muted).

Pressing shift-mute or shift-volume up/down does the same thing with the
headphones.

*** The new stuff in this patch is:

+ The volume and brightness control buttons now autorepeat.
+ Pressing option-brightness up/down sets the brightness of the
  backlighting to the maximum/minimum (without switching it off)
  respectively.
+ Pressing option-volume up/down sets the volume of the speakers to
  maximum/minimum, and shift-option-volume up/down does the same
  thing for the headphones.

Here are the patches (relative to 2.2.1):


--- drivers/macintosh/mac_keyb.c.orig	Mon Mar  1 18:48:13 1999
+++ drivers/macintosh/mac_keyb.c	Sun Mar  7 18:20:36 1999
@@ -211,6 +211,7 @@
 static void mac_put_queue(int);
 
 static void buttons_input(unsigned char *, int, struct pt_regs *, int);
+static void buttons_handler(unsigned char *, int);
 
 static void init_trackpad(int id);
 static void init_trackball(int id);
@@ -243,6 +244,10 @@
 
 static int adb_mouse_kinds[16];
 
+/* code in buttons_input() needs to know if shift or option key is down */
+static int shift_down;
+static int option_down;
+
 struct mackbd_state {
 	int	adb_id;
 	void	*kbd_id;
@@ -326,6 +331,12 @@
 	if (keycode == 0x3f)
 		keycode = 0x48;
 
+	/* buttons_handler() needs to know if shift or option key is down */
+	if (keycode == 0x38)
+		shift_down = !up_flag;
+	if (keycode == 0x3a)
+		option_down = !up_flag;
+
 #ifdef CONFIG_ADBMOUSE
 	/*
 	 * XXX: Add mouse button 2+3 fake codes here if mouse open.
@@ -514,9 +525,31 @@
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
@@ -528,47 +561,86 @@
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
 
--- drivers/sound/dmasound.c.orig	Mon Mar  1 19:21:46 1999
+++ drivers/sound/dmasound.c	Sat Mar  6 22:37:01 1999
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








aLViN
-- 
:r .signature

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
