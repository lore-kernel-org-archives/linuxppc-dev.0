Date: Sat, 16 Dec 2000 13:29:32 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] improve dmasound volume handling
Message-ID: <20001216132932.A16741@drow.them.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I was having a very strange problem with dmasound: aumix would let me
decrease but not increase the volume.  The problem was that aumix only
internally kept the volume on a 0-15 scale, but Linux used 0 (mute) and
1-100.  The rounding error made a 2% increase turn into a 0% change.

I'm not sure this is a good solution, but it's the best I could come up
with; it keeps a 1-100 scale internally, but sets the hardware according to
the converted value.  It's against the linuxppc_2_5 tree.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmasound.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name:
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.328   -> 1.329
#	drivers/sound/dmasound/dmasound_awacs.c	1.17    -> 1.18
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 00/12/13	drow@voltaire.res.cmu.edu	1.327.1.1
# dmasound_awacs.c	Cache volumes locally
# --------------------------------------------
# 00/12/13	drow@voltaire.res.cmu.edu	1.329
# Merge bk://hq.fsmlabs.com:5005
# into voltaire.res.cmu.edu:/home/drow/bk/linuxppc_2_5
# --------------------------------------------
#
diff -Nru a/drivers/sound/dmasound/dmasound_awacs.c b/drivers/sound/dmasound/dmasound_awacs.c
--- a/drivers/sound/dmasound/dmasound_awacs.c	Wed Dec 13 22:51:46 2000
+++ b/drivers/sound/dmasound/dmasound_awacs.c	Wed Dec 13 22:51:46 2000
@@ -71,6 +71,15 @@
  */
 int awacs_reg[8];

+/* Cached volumes - these simulate a 0-100 volume scale, though we only
+ * have a 15-0 volume scale internally.
+ * Should include other volumes we don't support?  Probably not.
+ */
+#define MASTER_VOLUME 0
+#define SPEAKER_VOLUME 1
+#define RECORD_VOLUME 2
+static int awacs_volumes[3];
+
 #define HAS_16BIT_TABLES
 #undef HAS_8BIT_TABLES

@@ -969,8 +978,23 @@
 	return format;
 }

-#define AWACS_VOLUME_TO_MASK(x)	(15 - ((((x) - 1) * 15) / 99))
-#define AWACS_MASK_TO_VOLUME(y)	(100 - ((y) * 99 / 15))
+/* Go from 1-100 to 15-0 and vice versa. */
+/* Volume 15 on AWACS is "softest", not muted; volume 0 on Linux is muted. */
+#define AWACS_VOLUME_TO_MASK(x)	(15 - ((((x) - 1) * 16) / 100))
+#define AWACS_MASK_TO_VOLUME(y)	(100 - ((y) * 100 / 16))
+
+static int verify_volume(int volume)
+{
+	unsigned int left, right;
+
+	left = volume & 0xFF;
+	if(left > 100)
+		left = 100;
+	right = (volume >> 8) & 0xFF;
+	if(right > 100)
+		right = 100;
+	return left | (right << 8);
+}

 static int awacs_get_volume(int reg, int lshift)
 {
@@ -989,12 +1013,20 @@
 		r1 = awacs_reg[1] | mute;
 	} else {
 		r1 = awacs_reg[1] & ~mute;
+#if 0
+		printk(KERN_DEBUG "Setting volume to %d/%d\n", volume&0xff, (volume>>8)&0xff);
+		printk(KERN_DEBUG "Old register setting was %d/%d\n", (awacs_reg[n]>>lshift)&0xf, awacs_reg[n]&0xf);
+#endif
 		rn = awacs_reg[n] & ~(0xf | (0xf << lshift));
 		rn |= ((AWACS_VOLUME_TO_MASK(volume & 0xff) & 0xf) << lshift);
 		rn |= AWACS_VOLUME_TO_MASK((volume >> 8) & 0xff) & 0xf;
 		awacs_reg[n] = rn;
 		awacs_write((n << 12) | rn);
 		volume = awacs_get_volume(rn, lshift);
+#if 0
+		printk(KERN_DEBUG "Got back volume %d/%d\n", volume&0xff, (volume>>8)&0xff);
+		printk(KERN_DEBUG "New register setting is %d/%d\n", (awacs_reg[n]>>lshift)&0xf, awacs_reg[n]&0xf);
+#endif
 	}
 	if (r1 != awacs_reg[1]) {
 		awacs_reg[1] = r1;
@@ -1005,7 +1037,10 @@

 static int PMacSetVolume(int volume)
 {
-	return awacs_volume_setter(volume, 2, MASK_AMUTE, 6);
+	volume = verify_volume(volume);
+	awacs_volume_setter(volume, 2, MASK_AMUTE, 6);
+	awacs_volumes[MASTER_VOLUME] = volume;
+	return volume;
 }

 static void PMacPlay(void)
@@ -1657,7 +1692,7 @@
 		return IOCTL_OUT(arg, 0);
 	case SOUND_MIXER_READ_VOLUME:
 		data = (awacs_reg[1] & MASK_AMUTE)? 0:
-			awacs_get_volume(awacs_reg[2], 6);
+			awacs_volumes[MASTER_VOLUME];
 		return IOCTL_OUT(arg, data);
 	case SOUND_MIXER_WRITE_VOLUME:
 		IOCTL_IN(arg, data);
@@ -1668,16 +1703,19 @@
 			data = awacs_spkr_vol;
 		else
 			data = (awacs_reg[1] & MASK_CMUTE)? 0:
-				awacs_get_volume(awacs_reg[4], 6);
+				awacs_volumes[SPEAKER_VOLUME];
 		return IOCTL_OUT(arg, data);
 	case SOUND_MIXER_WRITE_SPEAKER:
 		IOCTL_IN(arg, data);
 		if (awacs_revision == 3
 		    && sys_ctrler == SYS_CTRLER_CUDA)
 			awacs_enable_amp(data);
-		else
+		else {
+			data = verify_volume(data);
+			awacs_volumes[SPEAKER_VOLUME] = data;
 			data = awacs_volume_setter(data, 4, MASK_CMUTE, 6);
-		return IOCTL_OUT(arg, data);
+		}
+		return IOCTL_OUT(arg, awacs_volumes[SPEAKER_VOLUME]);
 	case SOUND_MIXER_WRITE_ALTPCM:	/* really bell volume */
 		IOCTL_IN(arg, data);
 		beep_volume = data & 0xff;
@@ -1721,10 +1759,12 @@
 		return IOCTL_OUT(arg, data);
 	case SOUND_MIXER_WRITE_RECLEV:
 		IOCTL_IN(arg, data);
+		data = verify_volume(data);
+		awacs_volumes[RECORD_VOLUME] = data;
 		data = awacs_volume_setter(data, 0, 0, 4);
-		return IOCTL_OUT(arg, data);
+		return IOCTL_OUT(arg, awacs_volumes[RECORD_VOLUME]);
 	case SOUND_MIXER_READ_RECLEV:
-		data = awacs_get_volume(awacs_reg[0], 4);
+		data = awacs_volumes[RECORD_VOLUME];
 		return IOCTL_OUT(arg, data);
 	case MIXER_WRITE(SOUND_MIXER_MONITOR):
 		IOCTL_IN(arg, data);
@@ -1857,10 +1897,12 @@
 		return IOCTL_OUT(arg, data);
 	case SOUND_MIXER_WRITE_RECLEV:
 		IOCTL_IN(arg, data);
+		data = verify_volume(data);
+		awacs_volumes[RECORD_VOLUME] = data;
 		data = awacs_volume_setter(data, 0, 0, 4);
-		return IOCTL_OUT(arg, data);
+		return IOCTL_OUT(arg, awacs_volumes[RECORD_VOLUME]);
 	case SOUND_MIXER_READ_RECLEV:
-		data = awacs_get_volume(awacs_reg[0], 4);
+		data = awacs_volumes[RECORD_VOLUME];
 		return IOCTL_OUT(arg, data);
 	case SOUND_MIXER_OUTMASK:
 		break;
@@ -2124,6 +2166,10 @@
 		awacs_write(awacs_reg[6] + MASK_ADDR6);
 		awacs_write(awacs_reg[7] + MASK_ADDR7);
 	}
+
+	awacs_volumes[MASTER_VOLUME] = (AWACS_MASK_TO_VOLUME(vol) << 8) + AWACS_MASK_TO_VOLUME(vol);
+	awacs_volumes[SPEAKER_VOLUME] = (AWACS_MASK_TO_VOLUME(vol) << 8) + AWACS_MASK_TO_VOLUME(vol);
+	awacs_volumes[RECORD_VOLUME] = 0;

 	/* Initialize recent versions of the awacs */
 	if (awacs_revision == 0) {

--rwEMma7ioTxnRzrJ--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
