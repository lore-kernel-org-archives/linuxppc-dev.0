In-Reply-To: <19991122120429.031138>
Date: Mon, 22 Nov 1999 12:47:02 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: cort@ppc.kernel.org, paulus@linuxcare.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: bootloader & head.S weirdness (patch)
Message-Id: <19991122124702.006073@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I re-read myself and I think I was not very clear... So below is the
patch I made that makes my bootloader appear to work in all cases.

Basically, the idea is that instead of doing all sorts of weird things
with MMU potentially enabled, once we exit from prom_init, I just shut
the MMU down, clear bats (I beleive this version of clear_bats will work
on 601), and then only try to move things down to 0.
The only requirement for this code to work is that the place the kernel
is loaded be mapped 1:1 (which can be acheived by the bootloader).

My OF bootloader loads the kernel at 0x1000000 (16Mb), but I beleive I
can load it lower in memory.

I'm also trying to get initrd to work but I didn't fully understand the
pointer calculations on r3/r4 done in identify_machine. It looks like
loading the kernel at the above address and initrd 1Mb after the kernel
(so I leave some room for prom_init to expand klimit) doesn't work (the
ramdisk presence is not recognized). Should I pass a pointer in r3 which
is already relative to KERNELBASE ? (basically, should I pass
phys_initrd_address or phys_initrd_address+KERNELBASE ?) or should I just
remove those pointer calculations from setup.c and assume r3 contains the
real physical address of initrd ?

--- paulus_stable/arch/ppc/kernel/head.S	Sat Oct 16 01:48:04 1999
+++ linux.ibook/arch/ppc/kernel/head.S	Mon Nov 22 12:36:50 1999
@@ -249,8 +249,12 @@
 	bl	prom_init
 	.globl	__secondary_start
 __secondary_start:
-/*
- * Use the first pair of BAT registers to map the 1st 16MB
+/* Switch MMU off, clear BATs and flush TLB */
+ 	bl	mmu_off
+	bl	clear_bats
+	bl	flush_tlbs
+
+/* Use the first pair of BAT registers to map the 1st 16MB
  * of RAM to KERNELBASE.  From this point on we can't safely
  * call OF any more.
  */
@@ -289,14 +293,6 @@
 	clrldi	r16,r16,63
 	mtsdr1	r16
 #else /* CONFIG_PPC64 */
-	/*
-	 * If the MMU is off clear the bats.  See clear_bat() -- Cort
-	 */
-	mfmsr	r20
-	andi.	r20,r20,MSR_DR
-	bne	100f
-	bl	clear_bats
-100:
 	/* 
 	 * allow secondary cpus to get at all of ram in early bootup
 	 * since their init_task may be up there -- Cort
@@ -1673,6 +1669,16 @@
 	blr
 #endif /* CONFIG_8xx */
 
+mmu_off:
+ 	mflr	r4
+	mfmsr	r3
+	ori	r3,r3,MSR_DR|MSR_IR
+	xori	r3,r3,MSR_DR|MSR_IR
+	mtspr	SRR0,r4
+	mtspr	SRR1,r3
+	sync
+	rfi
+
 /*
  * This code is jumped to from the startup code to copy
  * the kernel image to physical address 0.
@@ -1682,8 +1688,10 @@
 	addi	r9,r9,0x6f58		/* translate source addr */
 	cmpw	r31,r9			/* (we have to on chrp) */
 	beq	7f
+#if 0 // still needed ? breaks on me if I don't disable this
 	rlwinm	r4,r4,0,8,31		/* translate source address */
 	add	r4,r4,r3		/* to region mapped with BATs */
+#endif	
 7:	addis	r9,r26,klimit@ha	/* fetch klimit */
 	lwz	r25,klimit@l(r9)
 	addis	r25,r25,-KERNELBASE@h
@@ -2755,25 +2763,36 @@
  */
 clear_bats:
 	li	r20,0
-	
+	mfspr	r9,PVR
+	rlwinm	r9,r9,16,16,31		/* r9 = 1 for 601, 4 for 604 */
+	cmpwi	r9, 1
+	beq	1f
+
 	mtspr	DBAT0U,r20
-	mtspr	DBAT0L,r20
-	mtspr	IBAT0U,r20
-	mtspr	IBAT0L,r20
-	
+	mtspr	DBAT0L,r20	
 	mtspr	DBAT1U,r20
 	mtspr	DBAT1L,r20
+	mtspr	DBAT2U,r20
+	mtspr	DBAT2L,r20	
+	mtspr	DBAT3U,r20
+	mtspr	DBAT3L,r20
+1:	
+	mtspr	IBAT0U,r20
+	mtspr	IBAT0L,r20
 	mtspr	IBAT1U,r20
 	mtspr	IBAT1L,r20
-	
-	mtspr	DBAT2U,r20
-	mtspr	DBAT2L,r20
 	mtspr	IBAT2U,r20
 	mtspr	IBAT2L,r20
-	
-	mtspr	DBAT3U,r20
-	mtspr	DBAT3L,r20
 	mtspr	IBAT3U,r20
 	mtspr	IBAT3L,r20
 
 	blr
+
+flush_tlbs:
+	lis	r20, 0x1000
+1:	addic.	r20, r20, -0x1000
+	tlbie	r20
+	blt	1b
+	sync
+	blr
+
	

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
