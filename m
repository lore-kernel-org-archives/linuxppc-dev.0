Date: Thu, 23 Aug 2001 11:51:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: [PATCH,RFC] Move 8xx/8260 into arch/ppc/boot/simple
Message-ID: <20010823115127.P14302@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey all.  I finally got around to doing a bit more work on killing the
'mbx' subdir.  The inlined patch fixes the 8xx mask (whoops), adds a
_setup_8xx function, and grabs a few other things that the 8xx code did.
Now, I really would like people to test this patch on things which either
should or are known to work with the 'simple' subdir.  I've only tested
this on 8xx, and for other reasons (I'm still hunting this down, but it
happens w/ or w/o this patch) 8xx seems to hang after trying to boot the
kernel, so test it there as well please.  For this to work, you'll need to
do bk mv all of the .c files in the 'mbx' subdir to 'simple' and rename
misc.c to misc-embedded.c.  Next up I'll try and merge all of the
only slightly different sometimes misc.c's

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/boot/Makefile 1.18 vs edited =====
--- 1.18/arch/ppc/boot/Makefile	Sun Aug 19 12:08:07 2001
+++ edited/arch/ppc/boot/Makefile	Thu Aug 23 11:43:41 2001
@@ -34,9 +34,9 @@
 subdir-$(CONFIG_ALL_PPC)	+= chrp pmac prep
 tools-$(CONFIG_ALL_PPC)		:= addnote piggyback mknote hack-coff mkprep
 subdir-$(CONFIG_4xx)		+= simple
-subdir-$(CONFIG_8xx)		+= mbx
+subdir-$(CONFIG_8xx)		+= simple
 tools-$(CONFIG_GEMINI)		:= mksimage
-subdir-$(CONFIG_8260)		+= mbx
+subdir-$(CONFIG_8260)		+= simple
 subdir-$(CONFIG_K2)		+= pmon
 tools-$(CONFIG_K2)		:= mkpmon
 subdir-$(CONFIG_MCPN765)	+= simple
===== arch/ppc/boot/common/util.S 1.1 vs edited =====
--- 1.1/arch/ppc/boot/common/util.S	Thu Aug  2 16:02:25 2001
+++ edited/arch/ppc/boot/common/util.S	Thu Aug 23 09:51:47 2001
@@ -82,30 +82,45 @@
 	blr

 /*
- * Flush instruction cache
- * *** I'm really paranoid here!
+ * Flush and enable instruction cache
+ * First, flush the data cache in case it was enabled and may be
+ * holding instructions for copy back.
  */
 _GLOBAL(flush_instruction_cache)
-	mflr	r5
+	mflr	r6
 	bl	flush_data_cache
-	mfspr	r3,HID0	/* Caches are controlled by this register */
-	li	r4,0
-	ori	r4,r4,(HID0_ICE|HID0_ICFI)
-	or	r3,r3,r4	/* Need to enable+invalidate to clear */
-	mtspr	HID0,r3
-	andc	r3,r3,r4
-	ori	r3,r3,HID0_ICE	/* Enable cache */
-	mtspr	HID0,r3
-	mtlr	r5
+
+#ifdef CONFIG_8xx
+	lis	r3, IDC_INVALL@h
+	mtspr	IC_CST, r3
+	lis	r3, IDC_ENABLE@h
+	mtspr	IC_CST, r3
+	lis	r3, IDC_DISABLE@h
+	mtspr	DC_CST, r3
+#else
+	/* Enable, invalidate and then disable the L1 icache/dcache. */
+	li	r3,0
+	ori	r3,r3,(HID0_ICE|HID0_DCE|HID0_ICFI|HID0_DCI)
+	mfspr	r4,HID0
+	or	r5,r4,r3
+	isync
+	mtspr	HID0,r5
+	sync
+	isync
+	ori	r5,r4,HID0_ICE	/* Enable cache */
+	mtspr	HID0,r5
+	sync
+	isync
+#endif
+	mtlr	r6
 	blr

 #define NUM_CACHE_LINES 128*8
-#define CACHE_LINE_SIZE 32
 #define cache_flush_buffer 0x1000

 /*
  * Flush data cache
- * *** I'm really paranoid here!
+ * Do this by just reading lots of stuff into the cache.
  */
 _GLOBAL(flush_data_cache)
 	lis	r3,cache_flush_buffer@h
@@ -113,7 +128,6 @@
 	li	r4,NUM_CACHE_LINES
 	mtctr	r4
 00:	lwz	r4,0(r3)
-	addi	r3,r3,CACHE_LINE_SIZE	/* Next line, please */
+	addi	r3,r3,L1_CACHE_BYTES	/* Next line, please */
 	bdnz	00b
 10:	blr
-	.comm	.stack,4096*2,4
===== arch/ppc/boot/simple/Makefile 1.3 vs edited =====
--- 1.3/arch/ppc/boot/simple/Makefile	Tue Aug 14 10:35:11 2001
+++ edited/arch/ppc/boot/simple/Makefile	Thu Aug 23 11:44:01 2001
@@ -19,6 +19,12 @@
 # Normally, we use the 'misc-simple.c' file for decompress_kernel and
 # whatnot.  Sometimes we need to override this however.
 MISC				:= ../common/misc-simple.o
+ifeq ($(CONFIG_8xx)$(CONFIG_8260)$(CONFIG_4xx),y)
+ZIMAGE				:= zImage-EMBEDDED
+ZIMAGEINITRD			:= zImage.initrd-EMBEDDED
+TFTPIMAGE			:= /tftpboot/zImage.embedded
+MISC				:= misc-embedded.o
+endif
 ifeq ($(CONFIG_MENF1),y)
 ZIMAGE				:= zImage-MENF1
 ZIMAGEINITRD			:= zImage.initrd-MENF1
@@ -63,13 +69,31 @@
 TFTPIMAGE			+= .smp
 endif

+# Setup a default address to put ourselves, change it as needed.
 ZLINKFLAGS			:= -T $(TOPDIR)/arch/$(ARCH)/vmlinux.lds \
 					-Ttext 0x00800000
+ifdef CONFIG_8xx
+ZLINKFLAGS			:= -T $(TOPDIR)/arch/$(ARCH)/vmlinux.lds \
+					-Ttext 0x00180000
+endif
+ifdef CONFIG_8260
+ZLINKFLAGS			:= -T $(TOPDIR)/arch/$(ARCH)/vmlinux.lds \
+					-Ttext 0x00400000
+endif
 OBJCOPY_ARGS			:= -O elf32-powerpc

-obj-y				:= head.o $(HEADHELP) ../common/misc-common.o \
-				$(MISC) ../common/string.o ../common/util.o
+obj-y				:= head.o $(HEADHELP) $(MISC) \
+				../common/misc-common.o ../common/string.o \
+				../common/util.o
+obj-$(CONFIG_8xx)		+= m8xx_tty.o embed_config.o
+obj-$(CONFIG_8260)		+= m8260_tty.o embed_config.o
+obj-$(CONFIG_BSEIP)		+= iic.o
+obj-$(CONFIG_MBX)		+= iic.o pci.o qspan_pci.o
+obj-$(CONFIG_RPXCLASSIC)	+= iic.o pci.o qspan_pci.o
+obj-$(CONFIG_RPXLITE)		+= iic.o
+ifneq ($(CONFIG_8xx)$(CONFIG_8260),y)
 obj-$(CONFIG_SERIAL_CONSOLE)	+= ../common/ns16550.o
+endif
 LIBS				:= ../lib/zlib.a

 # Tools
@@ -81,7 +105,7 @@
 MKIRIMG				:= ../utils/mkirimg

 # Common rules
-../common/misc-simple.o: ../common/misc-simple.c
+misc-embedded.o ../common/misc-simple.o: misc-embedded.c ../common/misc-simple.c
 	$(CC) $(CFLAGS) -DINITRD_OFFSET=0 -DINITRD_SIZE=0 -DZIMAGE_OFFSET=0 \
 		-DZIMAGE_SIZE=0 -c -o $@ $*.c

@@ -137,6 +161,19 @@
 else
 	cp ../images/zImage.* $(TFTPIMAGE)
 endif
+
+zImage-EMBEDDED: zvmlinux
+ifeq ($(CONFIG_RPXCLASSIC),y)
+	dd if=zvmlinux of=../images/zImage.embedded bs=65536 skip=1
+endif
+	cp zvmlinux ../images/zvmlinux.embedded
+
+zImage.initrd-EMBEDDED: zvmlinux.initrd
+ifeq ($(CONFIG_RPXCLASSIC),y)
+	dd if=zvmlinux.initrd of=../images/zImage.initrd.embedded bs=65536 skip=1
+endif
+	cp zvmlinux.initrd ../images/zvmlinux.embedded
+

 zImage-MENF1: zvmlinux
 	$(MKPREP) -pbp zvmlinux ../images/zImage.menf1
===== arch/ppc/boot/simple/head.S 1.5 vs edited =====
--- 1.5/arch/ppc/boot/simple/head.S	Tue Aug 21 14:22:55 2001
+++ edited/arch/ppc/boot/simple/head.S	Thu Aug 23 11:50:45 2001
@@ -39,7 +39,7 @@
  */
 #define	IBM403	0x00000200	/* IBM 403 series */
 #define	IBM405	0x00004000	/* IBM 405 series */
-#define	MPC8XX	0x00000500	/* Motorola MPC8xx */
+#define	MPC8XX	0x00000050	/* Motorola MPC8xx */
 #define	PPC750	0x00000008	/* PowerPC 740/750 */
 #define	PPC7400	0x0000000C	/* PowerPC 7400 */
 #define	PPC7410	0x0000800C	/* PowerPC 7410 */
@@ -80,13 +80,14 @@
 	/* We have some really bad firmware.  We must disable the L1
 	 * icache/dcache now or the board won't boot.
 	 */
-	li      r4,0x0000
+	li	r4,0x0000
 	isync
-	mtspr   HID0,r4
+	mtspr	HID0,r4
 	sync
 	isync
 #endif

+	mr	r25,r3		/* Possibly save something. */
 /*
  * Determine what CPU we're on.
  */
@@ -104,6 +105,8 @@
 	 * on either of those, setup the default MSR, and test more.
 	 * Or we could even test for r8 == 6 later on.
 	 */
+	cmplwi	r8,0x0002	/* Test if we're == 2, if so we're 8xx */
+	beq	_setup_8xx
 	cmplwi	r8,0x0006	/* Test if we're == 6, if so, do generic 6xx */
 	beq	_setup_6xx	/* early setup. */
 	cmplwi	r8,0x0003	/* Test if we're >= 3, if so assume we */
@@ -152,6 +155,13 @@
 	blr

 start_ldr:
+/* Some boards don't boot up with the I-cache enabled.  Do that
+ * now because the decompress runs much faster that way.
+ * As a side effect, we have to ensure the data cache is not enabled
+ * so we can access the serial I/O without trouble.
+ */
+	bl	flush_instruction_cache
+
 	/* Clear all of BSS and set up stack for C calls */
 	lis	r3,edata@h
 	ori	r3,r3,edata@l
@@ -177,6 +187,7 @@
 	mr	r3,r8		/* Load point */
 	mr	r4,r7		/* Program length */
 	mr	r5,r6		/* Checksum */
+	mr	r6,r11		/* Residual data */
 	bl	decompress_kernel

 	lis	r6,cmd_line@h
@@ -194,22 +205,14 @@
 	lis	r2,initrd_end@h
 	ori	r2,r2,initrd_end@l
 	lwz	r5,0(r2)
-
-	li	r9,0xc
-	mtlr	r9
-	lis	r10,0xdeadc0de@h
-	ori	r10,r10,0xdeadc0de@l
-	li	r9,0
-	stw	r10,0(r9)

 	/*
-	 * Jump to kernel start
+	 * Start at the begining.
 	 */
+	li	r9,0x0000
+	mtlr	r9
 	blr

-hang:
-	b	hang
-
 /* Setup various CPU types. */

 _setup_L2CR:
@@ -242,7 +245,7 @@
 	li	r3,MSR_IP|MSR_FP
 	mtmsr	r3

- 	/* Clear BATs */
+	/* Clear BATs */
 	li	r8,0
 	mtspr	DBAT0U,r8
 	mtspr	DBAT0L,r8
@@ -302,3 +305,22 @@
 	isync

 	b	doneEarly	/* Done with early init stuffs */
+
+/* MPC8xx CPUs */
+_setup_8xx:
+	mfmsr	r3		/* Turn off interrupts */
+	li	r4,0
+	ori	r4,r4,MSR_EE
+	andc	r3,r3,r4
+	mtmsr	r3
+
+	/* We do this because some boot roms don't initialize the
+	 * processor correctly. Don't do this if you want to debug
+	 * using a BDM device.
+	 */
+	li	r4,0		/* Zero DER to prevent FRZ */
+	mtspr	SPRN_DER,r4
+
+	b	doneEarly	/* Done with early init stuffs */
+
+	.comm	.stack,4096*2,4

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
