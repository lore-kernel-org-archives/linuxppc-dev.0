Date: Thu, 24 Aug 2000 15:07:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux/PPC on APUS <linux-apus-devel@lists.sourceforge.net>
Subject: Re: [RFC] DMAsound 2.4.0-tx => 2.2.17 back-port.
In-Reply-To: <200008070101.CAA05135@hyperion.valhalla.net>
Message-ID: <Pine.LNX.4.10.10008081558060.442-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Aug 2000, Iain Sandoe wrote:
> This patch makes a common code base for dmasound between 2.4.0 and 2.2.17.
>
> It is, essentially, the same as Geert's 2.4.0 split-up applied back to
> 2.2.17.
>
> I would like to ask Paulus to consider including this patch in pmac 2.2.17.
> However, it affects other archs.

> Changes/Fixes:
>
> There are a few small additions at the top level (affecting all archs):
>
> 1. the look-up tables have been moved to the lower levels.

Their definitions have to be static, else you get duplicate symbols when
compiling a generic kernel that includes more than one low-level driver.
Perhaps we better compile the needed tables separately and link them (to each
low-level modules for a modular kernel, else to dmasound.o)?

> 2. The conditionalisation on HAS_RECORD has been made a run-time decision

You don't need `MACHINE.can_record', just check the `MACHINE.record' function
pointer.

> This means, AFAICT that it will no longer be necessary to have different
> versions of dmasound_core.o for different machines (in the same arch).

But you can no longer disable the code for recording for a machine that
doesn't need it...

> 3.  A SNDCTL_GET_CAPS ioctl has been added: it needs filling in for Q40,
> Paula & Atari.   One line of code for someone who knows their machine :-)

> Other changes are pmac-only and I'll leave them out of this post.

Other notes/questions/comments:

  - You forgot to initialize the other low-level drivers.

  - <asm/atarihw.h> is included by <asm/atariints.h>.

  - I removed all `zero' initializations from the `MACHINE' and
    `struct sound_settings' initializers. That's why we use the `new style'
    struct initialization method anyway :-)

  - Use typedef and inline functions to emulate the 2.4.x waitqueue scheme
    under 2.2.x

  - Fix typo `SDCTL_DSP_GETCAPS' -> 'SNDCTL_DSP_GETCAPS'

  - `MACHINE.can_byteswap' is never used, so remove it.

  - You forgot to update arch/m68k/config.in.

  - Is it OK to use `AFMT_S16_LE' as startup mode for /dev/dsp? WAV-files can
    be 8-bit as well, and always have a header so you can't just cat them to
    /dev/dsp without static in the beginning anyway.

  - What's the purpose of `dmasound.catch_rad'?


And finally, my patch :-) DISCLAIMER: I don't claim that it works, not even
that it compiles...

--- iain-dmasound-2.2.x/drivers/char/mem.c	Thu Aug 24 13:51:31 2000
+++ geert-dmasound-2.2.x/drivers/char/mem.c	Thu Aug 24 13:55:22 2000
@@ -27,9 +27,18 @@
 #ifdef CONFIG_SOUND_OSS
 void soundcard_init(void);
 #endif
+#ifdef CONFIG_DMASOUND_ATARI
+void dmasound_atari_init(void);
+#endif
 #ifdef CONFIG_DMASOUND_AWACS
 void dmasound_awacs_init(void);
 #endif
+#ifdef CONFIG_DMASOUND_PAULA
+void dmasound_paula_init(void);
+#endif
+#ifdef CONFIG_DMASOUND_Q40
+void dmasound_q40_init(void);
+#endif
 #endif
 #ifdef CONFIG_SPARCAUDIO
 extern int sparcaudio_init(void);
@@ -653,8 +662,17 @@
 #ifdef CONFIG_SOUND_OSS
 	soundcard_init();
 #endif
+#ifdef CONFIG_DMASOUND_ATARI
+	dmasound_atari_init();
+#endif
 #ifdef CONFIG_DMASOUND_AWACS
 	dmasound_awacs_init();
+#endif
+#ifdef CONFIG_DMASOUND_PAULA
+	dmasound_paula_init();
+#endif
+#ifdef CONFIG_DMASOUND_Q40
+	dmasound_q40_init();
 #endif
 #endif
 #ifdef CONFIG_SPARCAUDIO
--- iain-dmasound-2.2.x/drivers/sound/dmasound/dmasound_atari.c	Thu Aug 24 13:51:31 2000
+++ geert-dmasound-2.2.x/drivers/sound/dmasound/dmasound_atari.c	Thu Aug 24 14:41:54 2000
@@ -20,10 +20,6 @@
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>

-#ifndef COMPILING_2_4_X
-#include <asm/atarihw.h>
-#endif
-
 #include <asm/atariints.h>
 #include <asm/atari_stram.h>

@@ -1509,9 +1505,7 @@
 	sq_open:	AtaSqOpen,
 	state_info:	TTStateInfo,
 	min_dsp_speed:	6258,
-	can_record :	0,			/* no */
-	capabilities:	0,			/* As per SDCTL_DSP_GETCAPS */
-	can_byteswap:	0,
+	capabilities:	DSP_CAP_BATCH,		/* As per SNDCTL_DSP_GETCAPS */
 };

 static MACHINE machFalcon = {
@@ -1536,9 +1530,7 @@
 	sq_open:	AtaSqOpen,
 	state_info:	FalconStateInfo,
 	min_dsp_speed:	8195,
-	can_record :	0,			/* machine can record */
-	capabilities:	0,			/* As per SDCTL_DSP_GETCAPS */
-	can_byteswap:	0,
+	capabilities:	DSP_CAP_BATCH,		/* As per SNDCTL_DSP_GETCAPS */
 };


--- iain-dmasound-2.2.x/drivers/sound/dmasound/dmasound.h	Thu Aug 24 13:51:31 2000
+++ geert-dmasound-2.2.x/drivers/sound/dmasound/dmasound.h	Thu Aug 24 14:46:21 2000
@@ -102,8 +102,7 @@
     int (*state_info)(char *);			/* optional */
     void (*abort_read)(void);			/* optional */
     int min_dsp_speed;
-    int can_record ;				/* machine can record */
-    int capabilities ;				/* As per SDCTL_DSP_GETCAPS */
+    int capabilities ;				/* As per SNDCTL_DSP_GETCAPS */
     int can_byteswap ;				/* some AWACS can, some can't */
 } MACHINE;

@@ -172,6 +171,10 @@
 }


+#ifndef COMPILING_2_4_X
+typedef wait_queue *wait_queue_head_t;
+#endif
+
     /*
      * Sound queue stuff, the heart of the driver
      */
@@ -199,11 +202,7 @@
      *	       Bit 1 is set: a frame is playing
      */
     int active;
-#ifdef COMPILING_2_4_X
     wait_queue_head_t action_queue, open_queue, sync_queue;
-#else
-   struct wait_queue *action_queue, *open_queue, *sync_queue;
-#endif
     int open_mode;
     int busy, syncing;
 };
--- iain-dmasound-2.2.x/drivers/sound/dmasound/14bit_tables.h	Thu Aug 24 13:51:31 2000
+++ geert-dmasound-2.2.x/drivers/sound/dmasound/14bit_tables.h	Thu Aug 24 14:15:36 2000
@@ -11,7 +11,7 @@

 /* 14 bit mu-law (LSB) */

-char dmasound_ulaw2dma14l[] = {
+static char dmasound_ulaw2dma14l[] = {
 	33,	33,	33,	33,	33,	33,	33,	33,
 	33,	33,	33,	33,	33,	33,	33,	33,
 	33,	33,	33,	33,	33,	33,	33,	33,
@@ -48,7 +48,7 @@

 /* 14 bit A-law (LSB) */

-char dmasound_alaw2dma14l[] = {
+static char dmasound_alaw2dma14l[] = {
 	32,	32,	32,	32,	32,	32,	32,	32,
 	32,	32,	32,	32,	32,	32,	32,	32,
 	16,	48,	16,	48,	16,	48,	16,	48,
--- iain-dmasound-2.2.x/drivers/sound/dmasound/16bit_tables.h	Thu Aug 24 13:51:31 2000
+++ geert-dmasound-2.2.x/drivers/sound/dmasound/16bit_tables.h	Thu Aug 24 14:15:54 2000
@@ -7,7 +7,7 @@

 /* 16 bit mu-law */

-short dmasound_ulaw2dma16[] = {
+static short dmasound_ulaw2dma16[] = {
 	-32124,	-31100,	-30076,	-29052,	-28028,	-27004,	-25980,	-24956,
 	-23932,	-22908,	-21884,	-20860,	-19836,	-18812,	-17788,	-16764,
 	-15996,	-15484,	-14972,	-14460,	-13948,	-13436,	-12924,	-12412,
@@ -44,7 +44,7 @@

 /* 16 bit A-law */

-short dmasound_alaw2dma16[] = {
+static short dmasound_alaw2dma16[] = {
 	-5504,	-5248,	-6016,	-5760,	-4480,	-4224,	-4992,	-4736,
 	-7552,	-7296,	-8064,	-7808,	-6528,	-6272,	-7040,	-6784,
 	-2752,	-2624,	-3008,	-2880,	-2240,	-2112,	-2496,	-2368,
--- iain-dmasound-2.2.x/drivers/sound/dmasound/8bit_tables.h	Thu Aug 24 13:51:31 2000
+++ geert-dmasound-2.2.x/drivers/sound/dmasound/8bit_tables.h	Thu Aug 24 14:16:36 2000
@@ -7,7 +7,7 @@

 /* 8 bit mu-law */

-char dmasound_ulaw2dma8[] = {
+static char dmasound_ulaw2dma8[] = {
 	-126,	-122,	-118,	-114,	-110,	-106,	-102,	-98,
 	-94,	-90,	-86,	-82,	-78,	-74,	-70,	-66,
 	-63,	-61,	-59,	-57,	-55,	-53,	-51,	-49,
@@ -44,7 +44,7 @@

 /* 8 bit A-law */

-char dmasound_alaw2dma8[] = {
+static char dmasound_alaw2dma8[] = {
 	-22,	-21,	-24,	-23,	-18,	-17,	-20,	-19,
 	-30,	-29,	-32,	-31,	-26,	-25,	-28,	-27,
 	-11,	-11,	-12,	-12,	-9,	-9,	-10,	-10,
--- iain-dmasound-2.2.x/drivers/sound/dmasound/dmasound_awacs.c	Thu Aug 24 13:51:31 2000
+++ geert-dmasound-2.2.x/drivers/sound/dmasound/dmasound_awacs.c	Thu Aug 24 14:53:29 2000
@@ -1984,7 +1984,7 @@
 	setFormat:	PMacSetFormat,
 	setVolume:	PMacSetVolume,
 	play:		PMacPlay,
-	record:		PMacRecord,
+	record:		NULL,		/* default to no record */
 	mixer_ioctl:	PMacMixerIoctl,
 	write_sq_setup:	PMacWriteSqSetup,
 	read_sq_setup:	PMacReadSqSetup,
@@ -2234,7 +2234,7 @@
 		}
 		/* tell the dmasound_core what we can do */
 /* FIXME: this is a lie for the first iBook... */
-		dmasound.mach.can_record = 1 ;
+		dmasound.mach.record = PMacRecord;
 		dmasound.mach.capabilities = DSP_CAP_DUPLEX | DSP_CAP_BATCH ;
 		return dmasound_init();
 	}
--- iain-dmasound-2.2.x/drivers/sound/dmasound/dmasound_core.c	Thu Aug 24 13:51:31 2000
+++ geert-dmasound-2.2.x/drivers/sound/dmasound/dmasound_core.c	Thu Aug 24 14:52:37 2000
@@ -115,7 +115,6 @@
  *			  - (temp) conditionalised changes for back-port to allow one code-base
  *			           during the transition to 2.4.0
  *	2000/08/03	  - moved the conversion tables to the lower level modules
- *			  - made "can_record" a property given by the lower level
  *			     The intention is to end up with this module mach-independent.
  *			  - added the SNDCTL_DSP_GETCAPS ioctl.
  *
@@ -143,13 +142,7 @@
      *  Declarations
      */

-struct sound_settings dmasound =
-{
-	bass: 0,
-	treble: 0,
-	gain: 0,
-	catch_rad: 0,
-};
+struct sound_settings dmasound;

 int dmasound_catchRadius = 0;
 static unsigned int numWriteBufs = 4;
@@ -558,17 +551,18 @@
 	return uRead;
 }

+#ifndef COMPILING_2_4_X
+static inline void init_waitqueue_head(wait_queue_head_t *wait_queue)
+{
+	*wait_queue = 0;
+}
+#endif
+
 static inline void sq_init_waitqueue(struct sound_queue *sq)
 {
-#ifdef COMPILING_2_4_X
 	init_waitqueue_head(&sq->action_queue);
 	init_waitqueue_head(&sq->open_queue);
 	init_waitqueue_head(&sq->sync_queue);
-#else
-	sq->action_queue = 0 ;
-	sq->open_queue = 0;
-	sq->sync_queue = 0 ;
-#endif
 	sq->busy = 0;
 }

@@ -825,7 +819,7 @@
 	ioctl:		sq_ioctl,
 	open:		sq_open,
 	release:	sq_release,
-	read:		0, /* default to no read */
+	read:		NULL,		/* default to no read */
 };

 static void __init sq_init(void)
@@ -833,9 +827,8 @@
 #ifndef MODULE
 	int sq_unit;
 #endif
-	if( dmasound.mach.can_record  ){
-		sq_fops.read = sq_read ;
-	}
+	if( dmasound.mach.record)
+		sq_fops.read = sq_read;
 	sq_unit = register_sound_dsp(&sq_fops, -1);
 	if (sq_unit < 0) {
 		printk(KERN_ERR "DMA Sound core: Sound Queue Init Failed\n") ;
@@ -843,9 +836,8 @@
 	}

 	write_sq_init_waitqueue();
-	if( dmasound.mach.can_record ) {
+	if( dmasound.mach.record)
 		read_sq_init_waitqueue();
-	}

 	/* whatever you like as startup mode for /dev/dsp,
 	 * (/dev/audio hasn't got a startup mode). note that
@@ -977,7 +969,7 @@
 	len += sprintf(buffer+len, "  write_sq.active = %d write_sq.syncing = %d\n",
 		       write_sq.active, write_sq.syncing);

-	if( dmasound.mach.can_record ) {
+	if( dmasound.mach.record ) {
 		len += sprintf(buffer+len,
 			"  read_sq.block_size = %d read_sq.max_count = %d"
 	      		" read_sq.max_active = %d\n", read_sq.block_size,
@@ -1076,7 +1068,7 @@
 	printk(KERN_INFO "DMA sound driver core [Ed %2d] [%d buffers of %2dk for output]\n",
 			DMASOUND_CORE_EDITION, numWriteBufs, writeBufSize);

-	if( dmasound.mach.can_record ) {
+	if( dmasound.mach.record ) {
 		printk(KERN_INFO "............................. [%d buffers of %2dk for  input]\n",
 			 	       numReadBufs, readBufSize);
 	}
--- iain-dmasound-2.2.x/drivers/sound/dmasound/dmasound_paula.c	Thu Aug 24 13:51:31 2000
+++ geert-dmasound-2.2.x/drivers/sound/dmasound/dmasound_paula.c	Thu Aug 24 14:41:56 2000
@@ -697,9 +697,7 @@
 	write_sq_setup:	AmiWriteSqSetup,
 	state_info:	AmiStateInfo,
 	min_dsp_speed:	8000,
-	can_record :	0,			/* no */
-	capabilities:	0,			/* As per SDCTL_DSP_GETCAPS */
-	can_byteswap:	0,
+	capabilities:	DSP_CAP_BATCH,		/* As per SNDCTL_DSP_GETCAPS */
 };


--- iain-dmasound-2.2.x/drivers/sound/dmasound/dmasound_q40.c	Thu Aug 24 13:51:31 2000
+++ geert-dmasound-2.2.x/drivers/sound/dmasound/dmasound_q40.c	Thu Aug 24 14:42:00 2000
@@ -568,9 +568,7 @@
 	setFormat:	Q40SetFormat,
 	setVolume:	Q40SetVolume,
 	play:		Q40Play,
-	can_record :	0,			/* no */
-	capabilities:	0,			/* As per SDCTL_DSP_GETCAPS */
-	can_byteswap:	0,
+	capabilities:	DSP_CAP_BATCH,		/* As per SNDCTL_DSP_GETCAPS */
 };


--- iain-dmasound-2.2.x/arch/m68k/config.in	Sun Jul 16 15:41:36 2000
+++ geert-dmasound-2.2.x/arch/m68k/config.in	Thu Aug 24 13:57:04 2000
@@ -428,7 +428,7 @@

 tristate 'Sound support' CONFIG_SOUND
 if [ "$CONFIG_SOUND" != "n" ]; then
-  dep_tristate 'Amiga or Atari DMA sound support' CONFIG_DMASOUND $CONFIG_SOUND
+  source drivers/sound/dmasound/Config.in
 fi
 endmenu


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
