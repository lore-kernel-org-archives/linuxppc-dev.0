Message-Id: <v03130300b2c93cc809b5@[159.134.229.118]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 18 Jan 1999 20:16:32 +0000
To: linuxppc-dev@lists.linuxppc.org
From: Brian Foley <brianfoley@tinet.ie>
Subject: Patch for sound on the iMac
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

below is a patch against 2.2.0-pre7 that seems to get audio, and the
console beep working on the iMac. The main change that was needed is to
support the fact that the Burgundy chip in the iMac can only output sound
at 44.1KHz.
I've tested it out with a G3 Series PowerBook as well, and it doesn't seem
to introduce any problems there.

I have, however, found one issue. On my iMac (rev A), it works fine if
Linux is loaded by the BootX INIT, but if I use the BootX app from within
MacOS, the sound never gets initialised properly. I think it is probably
MacOS setting up Burgundy after loading INITs, and not resetting it
properly during shutdown. At the moment, I'm at a loss as to how to fix it.

Also I'm trying to see if I can get the driver to automatically switch
output to the headphone socket if you plug in headphones, and possibly the
SRS support assuming its not part of MacOS.

I've spent a while trying to find some documentation on the AWACS. The
closest I've found so far is the AWACS driver in MkLinux, which I don't
understand very well. I've seen references to the 'IT&T ASCO 2300
Audio-Stereo Codec Specification' in several of Apple's Hardware docs, does
anyone know where I might find this on the net?

Any comments, bug reports, etc would be welcome, but be gentle please, its
my first kernel patch :-)

Anyhow, enjoy!

Brian.

--- drivers/sound/dmasound.c	Fri Jan 15 00:53:19 1999
+++ drivers/sound/dmasound.c	Mon Jan 18 18:50:31 1999
@@ -230,10 +230,12 @@
 	-269,	-245,	-218,	-187,	-153,	-117,	-79,	-40,
 };

-#define BEEP_SPEED	2	/* 22050 Hz sample rate */
 #define BEEP_BUFLEN	512
 #define BEEP_VOLUME	15	/* 0 - 100 */

+int beep_speed = 2; /* 22050 Hz sample rate */
+int beep_rate = 22050;
+
 static int beep_volume = BEEP_VOLUME;
 static int beep_playing = 0;
 static short *beep_buf;
@@ -3019,6 +3021,7 @@
 static int awacs_freqs[8] = {
 	44100, 29400, 22050, 17640, 14700, 11025, 8820, 7350
 };
+int awacs_is_valid_freq[8] = {1, 1, 1, 1, 1, 1, 1, 1};

 static void PMacInit(void)
 {
@@ -3044,7 +3047,8 @@
 	i = 8;
 	do {
 		tolerance = catchRadius * awacs_freqs[--i] / 100;
-	} while (sound.soft.speed > awacs_freqs[i] + tolerance && i > 0);
+	} while ((sound.soft.speed > awacs_freqs[i] + tolerance && i > 0)
|| !awacs_is_valid_freq[i]);
+
 	if (sound.soft.speed >= awacs_freqs[i] - tolerance)
 		sound.trans = &transAwacsNormal;
 	else
@@ -3226,6 +3230,7 @@
 	while (in_le32(&awacs->codec_ctrl) & MASK_NEWECMD)
 		;	/* XXX should have timeout */
 	out_le32(&awacs->codec_ctrl, val | (awacs_subframe << 22));
+	eieio();
 }

 static void awacs_nosound(unsigned long xx)
@@ -3247,7 +3252,7 @@
 static void awacs_mksound(unsigned int hz, unsigned int ticks)
 {
 	unsigned long flags;
-	int srate = awacs_freqs[BEEP_SPEED];
+	int srate = awacs_freqs[beep_speed];
 	int period, ncycles, nsamples;
 	int i, j, f;
 	short *p;
@@ -3308,7 +3313,7 @@
 		out_le32(&awacs_txdma->control, (RUN|WAKE|FLUSH|PAUSE) << 16);
 		out_le32(&awacs->control,
 			 (in_le32(&awacs->control) & ~0x1f00)
-			 | (BEEP_SPEED << 8));
+			 | (beep_speed << 8));
 		out_le32(&awacs->byteswap, 0);
 		out_le32(&awacs_txdma->cmdptr, virt_to_bus(beep_dbdma_cmd));
 		out_le32(&awacs_txdma->control, RUN | (RUN << 16));
@@ -4525,6 +4530,29 @@
 			if (sfprop != 0 && *sfprop >= 0 && *sfprop < 16)
 				awacs_subframe = *sfprop;
 		}
+
+		/*
+		 * Some Macs have AWACS variants that can only output sound
+		 * at a subset of the 8 frequencies supported by AWACS. The
+		 * burgundy chip, for instance, can only play at 44.1KHz.
+		 * On at least the iMac, the OpenFirmware compatible property
+		 * is set correctly. This lets us to find out which IC is
+		 * used and then only allow the relevant frequencies. If we
+		 * don't know what chip is used, we assume all 8 frequencies
+		 * are supported.
+		 */
+
+		if (sound !=0 && sound->parent == np) {
+			if (device_is_compatible(sound, "burgundy")) {
+				int i;
+				printk("AWACS: burgundy IC\n");
+				for(i=1; i<8; i++)
+					awacs_is_valid_freq[i] = 0;
+				beep_speed = 0;
+			}
+		}
+
+
 	}
 	if (np != NULL && np->n_addrs >= 3 && np->n_intrs >= 3) {
 		int vol;


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
