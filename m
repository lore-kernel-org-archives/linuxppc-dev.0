Message-Id: <200007091025.MAA00707@piglet.grunz.lu>
Date: Sun, 9 Jul 2000 12:25:06 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: PATCH: enabling power mgmt on G3
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-963138310=:705"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-963138310=:705
Content-Type: TEXT/plain; charset=us-ascii

Hi all,

Is there any reason for not enabling the 'Dynamic Power Management'
feature of the G3/G4 processors under Linux?

OK, the firmware might already have enabled it, but that will not be the
case for 60x machines upgraded to G3/G4.

Anyway, here is a patch that backports the specific G3/G4 feature
enables out of 2.3's head.S and adds DPM. It also re-enables speculative
adressing, since some INIT's under MacOS disable it to work around
problems in the ROM.

It didn't crash my machine, but it might crash yours.. so test with
care, and report back to me!

Have fun

Michel

PS A similar patch for 2.2/2.4 kernels should follow as soon as I get
those to boot with my IDE card.

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-963138310=:705
Content-Type: TEXT/plain; CHARSET=US-ASCII
Content-Disposition: attachment; filename="features.diff"

--- linux-2.2.16-pristine/arch/ppc/kernel/head.S	Fri May  5 15:02:28 2000
+++ linux/arch/ppc/kernel/head.S	Sun Jul  9 12:05:13 2000
@@ -1773,7 +1773,7 @@
 	mfspr	r9,PVR
 	rlwinm	r9,r9,16,16,31
 	cmpi	0,r9,1
-	beq	4f			/* not needed for 601 */
+	beq	6f			/* not needed for 601 */
 	mfspr	r11,HID0
 	andi.	r0,r11,HID0_DCE
 	ori	r11,r11,HID0_ICE|HID0_DCE
@@ -1789,15 +1789,30 @@
 	isync
 	cmpi	0,r9,4			/* check for 604 */
 	cmpi	1,r9,9			/* or 604e */
-	cmpi	2,r9,10			/* or mach5 */
+	cmpi	2,r9,10			/* or mach5 / 604r */
 	cror	2,2,6
 	cror	2,2,10
 	bne	4f
-	ori	r11,r11,HID0_SIED|HID0_BHTE /* for 604[e], enable */
+	ori	r11,r11,HID0_SIED|HID0_BHTE /* for 604[e|r], enable */
 	bne	2,5f
 	ori	r11,r11,HID0_BTCD
-5:	mtspr	HID0,r11		/* superscalar exec & br history tbl */
+	b	5f
 4:
+	cmpi	3,r9,8			/* check for 750 (G3) */
+	cmpi	4,r9,12			/* or 7400 (G4) */
+	cror	14,14,18
+	bne	3,6f
+	/* We should add ABE here if we want to use Store Gathering
+	 * and other nifty bridge features
+	 */
+	ori	r11,r11,HID0_SGE|HID0_BHTE|HID0_BTIC /* for g3/g4, enable */
+	oris	r11,r11,HID0_DPM>>16	/* enable dynamic power mgmt */
+	li	r3,HID0_SPD
+	andc	r11,r11,r3		/* clear SPD: enable speculative */
+	li	r3,0
+	mtspr	ICTC,r3			/* Instruction Cache Throttling off */
+5:	mtspr	HID0,r11
+6:
 #endif /* CONFIG_8xx */
 #ifdef __SMP__
 	/* if we're the second cpu stack and r2 are different
--- linux-2.2.16-pristine/include/asm-ppc/processor.h	Fri May  5 14:55:10 2000
+++ linux/include/asm-ppc/processor.h	Sun Jul  9 11:41:28 2000
@@ -41,10 +41,10 @@
 #define HID0_EICE	(1<<26)
 #define HID0_ECLK	(1<<25)
 #define HID0_PAR	(1<<24)
-#define HID0_DOZE	(1<<23)
-#define HID0_NAP	(1<<22)
-#define HID0_SLEEP	(1<<21)
-#define HID0_DPM	(1<<20)
+#define HID0_DOZE	(1<<23)		/* DOZE mode enable */
+#define HID0_NAP	(1<<22)		/* NAP mode enable */
+#define HID0_SLEEP	(1<<21)		/* SLEEP mode enable */
+#define HID0_DPM	(1<<20)		/* Dynamic Power Management */
 #define HID0_ICE	(1<<15)		/* Instruction Cache Enable */
 #define HID0_DCE	(1<<14)		/* Data Cache Enable */
 #define HID0_ILOCK	(1<<13)		/* Instruction Cache Lock */
@@ -52,10 +52,16 @@
 #define HID0_ICFI	(1<<11)		/* Instruction Cache Flash Invalidate */
 #define HID0_DCI	(1<<10)		/* Data Cache Invalidate */
 #define HID0_SPD	(1<<9)		/* Speculative disable */
-#define HID0_SIED	(1<<7)		/* Serial Instruction Execution [Disable] */
+#define	HID0_SGE	(1<<7)		/* Store Gathering Enable */
+#define HID0_SIED	(1<<7)		/* Serial Instr. Execution [Disable] */
+#define	HID0_BTIC	(1<<5)		/* Branch Target Instr. Cache Enable */
+#define	HID0_ABE	(1<<3)		/* Address Broadcast Enable */
 #define HID0_BHTE	(1<<2)		/* Branch History Table Enable */
 #define HID0_BTCD	(1<<1)		/* Branch target cache disable */

+/* Special Purpose Registers (SPRNs)*/
+#define SPRN_ICTC	0x3FB	/* Instruction Cache Throttling Control Reg */
+
 /* fpscr settings */
 #define FPSCR_FX        (1<<31)
 #define FPSCR_FEX       (1<<30)
@@ -146,6 +152,7 @@
 #define DEC	22	/* Decrementer */
 #define EAR	282	/* External Address Register */
 #define L2CR	1017    /* PPC 750 L2 control register */
+#define ICTC	1018	/* PPC 750 Instruction Cache Throttling Control */

 #define THRM1	1020
 #define THRM2	1021

--134458388-1804289383-963138310=:705--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
