Date: Tue, 7 Mar 2000 22:49:34 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux/PPC for APUS <linux-apus@sunsite.auc.dk>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dmasound split
In-Reply-To: <Pine.LNX.4.05.10003072104330.484-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.05.10003072247180.484-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 7 Mar 2000, Geert Uytterhoeven wrote:
> This is my first test release for splitting the DMA sound driver in different
> parts:

And here's a first patch:

  - Fix the locking problem by adding open()/release() functions to the machine
    specific modules
  - Fix the incorrect size of the requested memory region for the Amiga driver
  - Rename HAS_READ_SOUND to HAS_RECORD

--- dmasound.h	Tue Mar  7 20:54:03 2000
+++ dmasound.h	Tue Mar  7 22:13:33 2000
@@ -74,14 +74,14 @@
 #undef HAS_8BIT_TABLES
 #undef HAS_14BIT_TABLES
 #undef HAS_16BIT_TABLES
-#undef HAS_READ_SOUND
+#undef HAS_RECORD

 #if defined(CONFIG_AMIGA) || defined(CONFIG_ATARI)
 #define HAS_8BIT_TABLES
 #endif
 #if defined(CONFIG_PPC)
 #define HAS_16BIT_TABLES
-#define HAS_READ_SOUND
+#define HAS_RECORD
 #endif


@@ -95,6 +95,8 @@
 typedef struct {
     const char *name;
     const char *name2;
+    void (*open)(void);
+    void (*release)(void);
     void *(*dma_alloc)(unsigned int, int);
     void (*dma_free)(void *, unsigned int);
     int (*irqinit)(void);
@@ -148,7 +150,7 @@
     SETTINGS soft;	/* software settings */
     SETTINGS dsp;	/* /dev/dsp default settings */
     TRANS *trans_write;	/* supported translations */
-#ifdef HAS_READ_SOUND
+#ifdef HAS_RECORD
     TRANS *trans_read;	/* supported translations */
 #endif
     int volume_left;	/* volume (range is machine dependent) */
--- dmasound_atari.c	Tue Mar  7 20:54:09 2000
+++ dmasound_atari.c	Tue Mar  7 22:14:31 2000
@@ -119,6 +119,8 @@
 /*** Low level stuff *********************************************************/


+static void AtaOpen(void);
+static void AtaRelease(void);
 static void *AtaAlloc(unsigned int size, int flags);
 static void AtaFree(void *, unsigned int size);
 static int AtaIrqInit(void);
@@ -815,6 +817,16 @@
  * Atari (TT/Falcon)
  */

+static void AtaOpen(void)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void AtaRelease(void)
+{
+	MOD_DEC_USE_COUNT;
+}
+
 static void *AtaAlloc(unsigned int size, int flags)
 {
 	return atari_stram_alloc( size, NULL, "dmasound" );
@@ -1480,6 +1492,8 @@
 static MACHINE machTT = {
 	name:		"Atari",
 	name2:		"TT",
+	open:		AtaOpen,
+	release:	AtaRelease,
 	dma_alloc:	AtaAlloc,
 	dma_free:	AtaFree,
 	irqinit:	AtaIrqInit,
--- dmasound_awacs.c	Tue Mar  7 20:54:09 2000
+++ dmasound_awacs.c	Tue Mar  7 22:14:37 2000
@@ -220,6 +220,8 @@
 /*** Low level stuff *********************************************************/


+static void PMacOpen(void);
+static void PMacRelease(void);
 static void *PMacAlloc(unsigned int size, int flags);
 static void PMacFree(void *ptr, unsigned int size);
 static int PMacIrqInit(void);
@@ -805,6 +807,16 @@
  * PCI PowerMac, with AWACS and DBDMA.
  */

+static void PMacOpen(void)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void PMacRelease(void)
+{
+	MOD_DEC_USE_COUNT;
+}
+
 static void *PMacAlloc(unsigned int size, int flags)
 {
 	return kmalloc(size, flags);
@@ -1899,6 +1911,8 @@
 static MACHINE machPMac = {
 	name:		awacs_name,
 	name2:		"AWACS",
+	open:		PMacOpen,
+	release:	PMacRelease,
 	dma_alloc:	PMacAlloc,
 	dma_free:	PMacFree,
 	irqinit:	PMacIrqInit,
--- dmasound_core.c	Tue Mar  7 20:54:09 2000
+++ dmasound_core.c	Tue Mar  7 22:23:50 2000
@@ -138,7 +138,7 @@

 int dmasound_catchRadius = 0;
 static int numWriteBufs = 4, writeBufSize = 32;
-#ifdef HAS_READ_SOUND
+#ifdef HAS_RECORD
 static int numReadBufs = 4, readBufSize = 32;
 #endif

@@ -415,7 +415,7 @@
  */

 struct sound_queue dmasound_write_sq;
-#ifdef HAS_READ_SOUND
+#ifdef HAS_RECORD
 struct sound_queue dmasound_read_sq;
 #endif

@@ -531,6 +531,7 @@
 static int mixer_open(struct inode *inode, struct file *file)
 {
 	MOD_INC_USE_COUNT;
+	dmasound.mach.open();
 	mixer.busy = 1;
 	return 0;
 }
@@ -538,6 +539,7 @@
 static int mixer_release(struct inode *inode, struct file *file)
 {
 	mixer.busy = 0;
+	dmasound.mach.release();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -742,7 +744,7 @@
 }


-#ifdef HAS_READ_SOUND
+#ifdef HAS_RECORD

 /* Here is how the values are used for reading.
  * The value 'active' simply indicates the DMA is running.  This is
@@ -807,7 +809,7 @@
 	}
 	return uRead;
 }
-#endif /* HAS_READ_SOUND */
+#endif /* HAS_RECORD */


 static inline void sq_init_waitqueue(struct sound_queue *sq)
@@ -864,18 +866,18 @@
 #define write_sq_open(file)	\
 	sq_open2(&write_sq, file, FMODE_WRITE, numWriteBufs, writeBufSize, 0)

-#ifdef HAS_READ_SOUND
+#ifdef HAS_RECORD
 #define read_sq_init_waitqueue()	sq_init_waitqueue(&read_sq)
 #define read_sq_wake_up(file)		sq_wake_up(&read_sq, file, FMODE_READ)
 #define read_sq_release_buffers()	sq_release_buffers(&read_sq, 1)
 #define read_sq_open(file)	\
 	sq_open2(&read_sq, file, FMODE_READ, numReadBufs, readBufSize, 1)
-#else /* !HAS_READ_SOUND */
+#else /* !HAS_RECORD */
 #define read_sq_init_waitqueue()	do {} while (0)
 #define read_sq_wake_up(file)		do {} while (0)
 #define read_sq_release_buffers()	do {} while (0)
 #define read_sq_open(file)		(0)
-#endif /* !HAS_READ_SOUND */
+#endif /* !HAS_RECORD */


 static int sq_open(struct inode *inode, struct file *file)
@@ -883,7 +885,9 @@
 	int rc;

 	MOD_INC_USE_COUNT;
+	dmasound.mach.open();
 	if ((rc = write_sq_open(file)) || (rc = read_sq_open(file))) {
+		dmasound.mach.release();
 		MOD_DEC_USE_COUNT;
 		return rc;
 	}
@@ -955,6 +959,7 @@

 	read_sq_release_buffers();
 	write_sq_release_buffers();
+	dmasound.mach.release();
 	MOD_DEC_USE_COUNT;

 	/* There is probably a DOS atack here. They change the mode flag. */
@@ -1075,7 +1080,7 @@
 	ioctl:		sq_ioctl,
 	open:		sq_open,
 	release:	sq_release,
-#ifdef HAS_READ_SOUND
+#ifdef HAS_RECORD
 	read:		sq_read,
 #endif
 };
@@ -1125,6 +1130,7 @@
 		return -EBUSY;

 	MOD_INC_USE_COUNT;
+	dmasound.mach.open();
 	state.ptr = 0;
 	state.busy = 1;

@@ -1181,6 +1187,7 @@
 static int state_release(struct inode *inode, struct file *file)
 {
 	state.busy = 0;
+	dmasound.mach.release();
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -1276,7 +1283,6 @@
 	printk(KERN_INFO "DMA sound driver installed, using %d buffers of %dk.\n",
 	       numWriteBufs, writeBufSize);

-	MOD_INC_USE_COUNT;
 	return 0;
 }

@@ -1302,7 +1308,6 @@
 	if (sq_unit >= 0)
 		unregister_sound_dsp(sq_unit);

-	MOD_DEC_USE_COUNT;
 	dmasound_active = 0;
 }

@@ -1354,7 +1359,7 @@
 EXPORT_SYMBOL(dmasound_init);
 EXPORT_SYMBOL(dmasound_deinit);
 EXPORT_SYMBOL(dmasound_write_sq);
-#ifdef HAS_READ_SOUND
+#ifdef HAS_RECORD
 EXPORT_SYMBOL(dmasound_read_sq);
 #endif
 EXPORT_SYMBOL(dmasound_catchRadius);
--- dmasound_paula.c	Tue Mar  7 20:54:09 2000
+++ dmasound_paula.c	Tue Mar  7 22:45:09 2000
@@ -72,6 +72,8 @@
 /*** Low level stuff *********************************************************/


+static void AmiOpen(void);
+static void AmiRelease(void);
 static void *AmiAlloc(unsigned int size, int flags);
 static void AmiFree(void *obj, unsigned int size);
 static int AmiIrqInit(void);
@@ -281,6 +283,16 @@
 /*** Low level stuff *********************************************************/


+static void AmiOpen(void)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void AmiRelease(void)
+{
+	MOD_DEC_USE_COUNT;
+}
+
 static inline void StopDMA(void)
 {
 	custom.aud[0].audvol = custom.aud[1].audvol = 0;
@@ -639,6 +651,8 @@
 static MACHINE machAmiga = {
 	name:		"Amiga",
 	name2:		"AMIGA",
+	open:		AmiOpen,
+	release:	AmiRelease,
 	dma_alloc:	AmiAlloc,
 	dma_free:	AmiFree,
 	irqinit:	AmiIrqInit,
@@ -665,7 +679,7 @@
 int __init paula_dmasound_init(void)
 {
 	if (MACH_IS_AMIGA && AMIGAHW_PRESENT(AMI_AUDIO)) {
-	    if (!request_mem_region(CUSTOM_PHYSADDR+0xa0, 0x20,
+	    if (!request_mem_region(CUSTOM_PHYSADDR+0xa0, 0x40,
 				    "dmasound [Paula]"))
 		return -EBUSY;
 	    dmasound.mach = machAmiga;
@@ -685,7 +699,7 @@
 void cleanup_module(void)
 {
 	dmasound_deinit();
-	release_mem_region(CUSTOM_PHYSADDR+0xa0, 0x20);
+	release_mem_region(CUSTOM_PHYSADDR+0xa0, 0x40);
 }

 #endif /* MODULE */
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
