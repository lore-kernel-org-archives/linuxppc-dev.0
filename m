Message-Id: <199903041412.PAA02351@mitra.phys.uit.no>
To: linuxppc-dev@lists.linuxppc.org
Subject: Volume and mute buttons on PowerBook G3
From: Alvin Brattli <Alvin.Brattli@phys.uit.no>
Date: Thu, 04 Mar 1999 15:12:03 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Below, you will find a patch that adds support for the volume and mute
buttons on the PowerBook G3 series.  A pre-compiled kernel can be found
here: <ftp://xenu.phys.uit.no/pub/vmlinux-2.2.1>.  The kernel was built
using the 2.2.1 .config from samba, and should work with these modules.
Can people test it, and report problems and general feedback to me?

The patch implements the following:

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


The patch (relative to 2.2.1 from samba):


--- drivers/macintosh/mac_keyb.c.orig	Mon Mar  1 18:48:13 1999
+++ drivers/macintosh/mac_keyb.c	Thu Mar  4 15:06:39 1999
@@ -243,6 +243,9 @@
 
 static int adb_mouse_kinds[16];
 
+/* code in buttons_input() needs to know if shift key is down */
+static int shift_down;
+
 struct mackbd_state {
 	int	adb_id;
 	void	*kbd_id;
@@ -326,6 +329,10 @@
 	if (keycode == 0x3f)
 		keycode = 0x48;
 
+	/* code in buttons_input() needs to know if shift key is down */
+	shift_down  = !up_flag && (keycode == 0x38 || keycode == 0x7b);
+
+
 #ifdef CONFIG_ADBMOUSE
 	/*
 	 * XXX: Add mouse button 2+3 fake codes here if mouse open.
@@ -517,6 +524,9 @@
 /* XXX Needs to get rid of this, see comments in pmu.c */
 extern int backlight_level;
 
+extern int pmac_togglemute(int);
+extern int pmac_addto_volume(int, int);
+
 static void
 buttons_input(unsigned char *data, int nb, struct pt_regs *regs, int autopoll)
 {
@@ -535,18 +545,24 @@
 		case 0x8:
 			/* down event */
 			if ( data[1] == (data[1]&0xf) ) {
+				if (pmu_get_model() == PMU_HEATHROW_BASED)
+					pmac_togglemute(shift_down? 2:4);
 			}
 			break;
-		/* contrast decrease */
+		/* contrast decrease (volume decrease on PB G3) */
 		case 0x7:
 			/* down event */
 			if ( data[1] == (data[1]&0xf) ) {
+				if (pmu_get_model() == PMU_HEATHROW_BASED)
+					pmac_addto_volume(shift_down? 2:4, -7);
 			}
 			break;
-		/* contrast increase */
+		/* contrast increase (volume increase on PB G3) */
 		case 0x6:
 			/* down event */
 			if ( data[1] == (data[1]&0xf) ) {
+				if (pmu_get_model() == PMU_HEATHROW_BASED)
+					pmac_addto_volume(shift_down? 2:4, 7);
 			}
 			break;
 		/* brightness decrease */
--- drivers/sound/dmasound.c.orig	Mon Mar  1 19:21:46 1999
+++ drivers/sound/dmasound.c	Wed Mar  3 22:08:41 1999
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
@@ -3194,6 +3198,60 @@
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
+	volume = awacs_get_volume(awacs_reg[n], 6);
+	v1 = ((volume >> 8) & 0x0ff) + incr;
+	v2 = (volume & 0x0ff) + incr;
+	if (v1 > 100) v1 = 100;
+	if (v2 > 100) v2 = 100;
+	if (v1 <= 0 && v2 <= 0) {
+		volume = 0;
+	} else {
+		if (v1 < 1)   v1 = 1;
+		if (v2 < 1)   v2 = 1;
+		volume = (v1 << 8) | v2;
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

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
