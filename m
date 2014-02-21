Return-Path: <schivers@csc.com>
Received: from mail85.messagelabs.com (mail85.messagelabs.com [216.82.241.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EA7C22C0333
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 12:29:55 +1100 (EST)
Date: Fri, 21 Feb 2014 12:29:48 +1100
To: David.Laight@aculab.com, James.Yang@freescale.com, paubert@iram.es
Subject: [PATCH 1/1] powerpc: correct emulated mtfsf instruction
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20140221012948.1156FE06C0@canberra.localdomain>
From: schivers@csc.com (Stephen Chivers)
Cc: schivers@csc.com, linuxppc-dev@lists.ozlabs.org, cproctor@csc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The emulated (CONFIG_MATH_EMULATION_FULL)
PowerPC Floating Point instruction mtfsf
does not correctly copy bits from its source
register to the Floating Point Status and Register (FPSCR).

The error is in the preparation of the mask used to
select the bits to be copied from the source to the FPSCR.

Execution of the mtfsf instruction does not produce the same
results on a MPC8548 platform (emulated floating point)
as on MPC7410 or 440EP platforms (hardware floating point).

This error has been detected using a Freescale MPC8548
based platform and the patch below tested using that platform.

The patch is based on the patch(es) provided by
Gabriel Paubert and analysis by Gabriel, James Yang and David Laight.

Signed-off-by: Stephen Chivers <schivers@csc.com>
Signed-off-by: Gabriel Paubert <paubert@iram.es>
Tested-by: Stephen Chivers <schivers@csc.com>
---
 arch/powerpc/math-emu/mtfsf.c |   58 ++++++++++++++++------------------------
 1 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/math-emu/mtfsf.c b/arch/powerpc/math-emu/mtfsf.c
index dbce92e..44b0fc8 100644
--- a/arch/powerpc/math-emu/mtfsf.c
+++ b/arch/powerpc/math-emu/mtfsf.c
@@ -11,48 +11,36 @@ mtfsf(unsigned int FM, u32 *frB)
 	u32 mask;
 	u32 fpscr;
 
-	if (FM == 0)
-		return 0;
-
-	if (FM == 0xff)
-		mask = 0x9fffffff;
+	if (likely(FM == 1))
+		mask = 0x0f;
+	else if (likely(FM == 0xff))
+		mask = ~0;
 	else {
-		mask = 0;
-		if (FM & (1 << 0))
-			mask |= 0x90000000;
-		if (FM & (1 << 1))
-			mask |= 0x0f000000;
-		if (FM & (1 << 2))
-			mask |= 0x00f00000;
-		if (FM & (1 << 3))
-			mask |= 0x000f0000;
-		if (FM & (1 << 4))
-			mask |= 0x0000f000;
-		if (FM & (1 << 5))
-			mask |= 0x00000f00;
-		if (FM & (1 << 6))
-			mask |= 0x000000f0;
-		if (FM & (1 << 7))
-			mask |= 0x0000000f;
+		mask = ((FM & 1) |
+				((FM << 3) & 0x10) |
+				((FM << 6) & 0x100) |
+				((FM << 9) & 0x1000) |
+				((FM << 12) & 0x10000) |
+				((FM << 15) & 0x100000) |
+				((FM << 18) & 0x1000000) |
+				((FM << 21) & 0x10000000)) * 15;
 	}
 
-	__FPU_FPSCR &= ~(mask);
-	__FPU_FPSCR |= (frB[1] & mask);
+	fpscr = ((__FPU_FPSCR & ~mask) | (frB[1] & mask)) &
+		~(FPSCR_VX | FPSCR_FEX | 0x800);
 
-	__FPU_FPSCR &= ~(FPSCR_VX);
-	if (__FPU_FPSCR & (FPSCR_VXSNAN | FPSCR_VXISI | FPSCR_VXIDI |
+	if (fpscr & (FPSCR_VXSNAN | FPSCR_VXISI | FPSCR_VXIDI |
 		     FPSCR_VXZDZ | FPSCR_VXIMZ | FPSCR_VXVC |
 		     FPSCR_VXSOFT | FPSCR_VXSQRT | FPSCR_VXCVI))
-		__FPU_FPSCR |= FPSCR_VX;
-
-	fpscr = __FPU_FPSCR;
-	fpscr &= ~(FPSCR_FEX);
-	if (((fpscr & FPSCR_VX) && (fpscr & FPSCR_VE)) ||
-	    ((fpscr & FPSCR_OX) && (fpscr & FPSCR_OE)) ||
-	    ((fpscr & FPSCR_UX) && (fpscr & FPSCR_UE)) ||
-	    ((fpscr & FPSCR_ZX) && (fpscr & FPSCR_ZE)) ||
-	    ((fpscr & FPSCR_XX) && (fpscr & FPSCR_XE)))
+		fpscr |= FPSCR_VX;
+
+	/* The bit order of exception enables and exception status
+	 * is the same. Simply shift and mask to check for enabled
+	 * exceptions.
+	 */
+	if (fpscr & (fpscr >> 22) &  0xf8)
 		fpscr |= FPSCR_FEX;
+
 	__FPU_FPSCR = fpscr;
 
 #ifdef DEBUG
