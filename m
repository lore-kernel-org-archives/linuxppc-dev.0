Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B1DDDB70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 17:06:22 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o9176MU0029078
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:22 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9176MZL1536174
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:22 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9176LkB024722
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:21 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH 04/18] powerpc: Allow taishan platform to boot a little endian
	kernel
Date: Fri,  1 Oct 2010 17:05:57 +1000
Message-Id: <1285916771-18033-5-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
Cc: Albert Herranz <albert_herranz@yahoo.es>, paulus@samba.org,
	Ian Munsie <imunsie@au1.ibm.com>, Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This adds code to the boot wrapper to allow 44x CPUs to boot little
endian kernels. Presumably all 44x PowerPC platforms should also be able
to use this code unmodified, but this patch only wires up the taishan
platform as that has been tested.

The boot wrapper is still run in 32bit big endian mode and must set the
E bit in the TLB entries that the kernel may use initially. Naturally
the code setting this up can't afford to change the E bit on it's own
TLB entry while it is executing so it sets up a trampoline in address
space 1 to affect the change on all address space 0 TLB entries.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/boot/4xx.h                |    2 +
 arch/powerpc/boot/Makefile             |    2 +-
 arch/powerpc/boot/cuboot-taishan.c     |    1 +
 arch/powerpc/boot/le-44x.S             |   85 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |    1 +
 5 files changed, 90 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/le-44x.S

diff --git a/arch/powerpc/boot/4xx.h b/arch/powerpc/boot/4xx.h
index 7dc5d45..05bc068 100644
--- a/arch/powerpc/boot/4xx.h
+++ b/arch/powerpc/boot/4xx.h
@@ -29,5 +29,7 @@ void ibm440gx_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk,
 			   unsigned int tmr_clk);
 void ibm440spe_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk,
 			    unsigned int tmr_clk);
+void ibm44x_le_kentry(unsigned long r3, unsigned long r4, void *r5,
+		      kernel_entry_t kentry);
 
 #endif /* _POWERPC_BOOT_4XX_H_ */
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 79d7e69..c4b8616 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -69,7 +69,7 @@ src-wlib := string.S crt0.S crtsavres.S stdio.c main.c \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
 		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
-		fsl-soc.c mpc8xx.c pq2.c ugecon.c
+		fsl-soc.c mpc8xx.c pq2.c ugecon.c le-44x.S
 src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c cuboot-hotfoot.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
diff --git a/arch/powerpc/boot/cuboot-taishan.c b/arch/powerpc/boot/cuboot-taishan.c
index 9bc906a..7fdd614 100644
--- a/arch/powerpc/boot/cuboot-taishan.c
+++ b/arch/powerpc/boot/cuboot-taishan.c
@@ -52,6 +52,7 @@ void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	CUBOOT_INIT();
 
 	platform_ops.fixups = taishan_fixups;
+	platform_ops.le_kentry = ibm44x_le_kentry;
 	fdt_init(_dtb_start);
 	serial_console_init();
 }
diff --git a/arch/powerpc/boot/le-44x.S b/arch/powerpc/boot/le-44x.S
new file mode 100644
index 0000000..c8d2ee4
--- /dev/null
+++ b/arch/powerpc/boot/le-44x.S
@@ -0,0 +1,85 @@
+/*
+ * Copyright © 2010 Ian Munsie, IBM Corporation
+ *
+ * Assembly to begin executing a little endian kernel from a big endian boot
+ * wrapper. Uses a trampoline in address space 1 to update the E bit in each
+ * TLB entry of address space 0 before entering the kernel.
+ */
+
+#include "ppc_asm.h"
+
+#define __MASK(X)		(1<<(X))
+
+#define SPRN_SRR0		0x01A		/* Save/Restore Register 0 */
+#define SPRN_SRR1		0x01B		/* Save/Restore Register 1 */
+
+#define MSR_IS			__MASK(5)	/* Instruction Space */
+#define MSR_DS			__MASK(4)	/* Data Space */
+
+#define	PPC44x_TLB_PAGEID	0
+#define	PPC44x_TLB_XLAT		1
+#define	PPC44x_TLB_ATTRIB	2
+
+/* Page identification fields */
+#define	PPC44x_TLB_VALID	0x00000200      /* Valid flag */
+#define PPC44x_TLB_TS		0x00000100	/* Translation address space */
+
+/* Storage attribute and access control fields */
+#define PPC44x_TLB_E		0x00000080      /* Memory is little endian */
+
+	.text
+	.global ibm44x_le_kentry
+ibm44x_le_kentry:
+	/* Find an invalid TLB entry we can use */
+	li	r12,0				/* Start searching at TLB 0 */
+1:	tlbre	r10,r12,PPC44x_TLB_PAGEID	/* Read TLB page ID word */
+	andi.	r0,r10,PPC44x_TLB_VALID		/* Test if TLB is valid */
+	beq	2f				/* If not valid we are free to use it */
+	addi	r12,r12,1			/* If valid, increment */
+	cmpwi	r12,64				/* Have we reached the end of the TLBs? */
+	bne	1b				/* If not, continue searching */
+	blr					/* If so, no invalid TLB entries found :( Shouldn't happen AFAIK */
+
+	/* Locate TLB entry containing trampoline */
+2:	lis	r0,le_trampoline@h
+	ori	r0,r0,le_trampoline@l
+	tlbsx	r11,0,r0
+
+	/* Set free TLB to match our TLB, but with TS=1 */
+	tlbre	r10,r11,PPC44x_TLB_XLAT
+	tlbwe	r10,r12,PPC44x_TLB_XLAT
+	tlbre	r10,r11,PPC44x_TLB_ATTRIB
+	tlbwe	r10,r12,PPC44x_TLB_ATTRIB
+	tlbre	r10,r11,PPC44x_TLB_PAGEID
+	ori	r10,r10,PPC44x_TLB_TS
+	tlbwe	r10,r12,PPC44x_TLB_PAGEID
+
+	/* Goto trampoline in address space 1 */
+	mtspr	SPRN_SRR0,r0
+	mfmsr	r0
+	ori	r0,r0,MSR_IS | MSR_DS
+	mtspr	SPRN_SRR1,r0
+	rfi
+
+le_trampoline:
+	/* Set E bit on all valid TLB entries with TS=0 */
+	li	r12,0				/* Start searching at TLB 0 */
+1:	tlbre	r10,r12,PPC44x_TLB_PAGEID	/* Read TLB page ID word */
+	andi.	r0,r10,PPC44x_TLB_VALID		/* Test if TLB is valid */
+	beq	2f				/* If not valid, continue */
+	andi.	r0,r10,PPC44x_TLB_TS		/* If valid, test if TLB is TS=1 */
+	bne	2f				/* If TS=1, continue */
+	tlbre	r10,r12,PPC44x_TLB_ATTRIB	/* If TS=0, read TLB attributes */
+	ori	r10,r10,PPC44x_TLB_E		/* Set little endian bit */
+	tlbwe	r10,r12,PPC44x_TLB_ATTRIB	/* Write attributes back */
+2:	addi	r12,r12,1			/* Increment */
+	cmpwi	r12,64				/* Are we done? */
+	bne	1b				/* If not, continue searching */
+
+	/* Goto kentry in address space 0 */
+	mtspr	SPRN_SRR0,r6			/* arg 4 (kentry) */
+	mfmsr	r11
+	li	r12,MSR_IS | MSR_DS
+	andc	r11,r11,r12
+	mtspr	SPRN_SRR1,r11
+	rfi
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 074ff12..8ba962e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -49,6 +49,7 @@ config 44x
 	select 4xx_SOC
 	select PPC_PCI_CHOICE
 	select PHYS_64BIT
+	select ARCH_SUPPORTS_LITTLE_ENDIAN
 
 config E200
 	bool "Freescale e200"
-- 
1.7.1
