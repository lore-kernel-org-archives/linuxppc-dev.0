Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/pseries: Simplify denorm code
Date: Thu, 30 May 2013 17:33:18 +1000
Message-Id: <1369899199-3973-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following simplifies the denorm code by using macros to generate the long
stream of almost identical instructions.

This patch results in no changes to the output binary, but removes a lot of
lines of code.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/exceptions-64s.S |   80 +++++++---------------------------
 1 file changed, 16 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e6eba1b..3c9296b 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -454,38 +454,14 @@ BEGIN_FTR_SECTION
 	xori	r10,r10,(MSR_FE0|MSR_FE1)
 	mtmsrd	r10
 	sync
-	fmr	0,0
-	fmr	1,1
-	fmr	2,2
-	fmr	3,3
-	fmr	4,4
-	fmr	5,5
-	fmr	6,6
-	fmr	7,7
-	fmr	8,8
-	fmr	9,9
-	fmr	10,10
-	fmr	11,11
-	fmr	12,12
-	fmr	13,13
-	fmr	14,14
-	fmr	15,15
-	fmr	16,16
-	fmr	17,17
-	fmr	18,18
-	fmr	19,19
-	fmr	20,20
-	fmr	21,21
-	fmr	22,22
-	fmr	23,23
-	fmr	24,24
-	fmr	25,25
-	fmr	26,26
-	fmr	27,27
-	fmr	28,28
-	fmr	29,29
-	fmr	30,30
-	fmr	31,31
+
+#define FMR2(n)  fmr (n), (n) ; fmr n+1, n+1
+#define FMR4(n)  FMR2(n) ; FMR2(n+2)
+#define FMR8(n)  FMR4(n) ; FMR4(n+4)
+#define FMR16(n) FMR8(n) ; FMR8(n+8)
+#define FMR32(n) FMR16(n) ; FMR16(n+16)
+	FMR32(0)
+
 FTR_SECTION_ELSE
 /*
  * To denormalise we need to move a copy of the register to itself.
@@ -495,38 +471,14 @@ FTR_SECTION_ELSE
 	oris	r10,r10,MSR_VSX@h
 	mtmsrd	r10
 	sync
-	XVCPSGNDP(0,0,0)
-	XVCPSGNDP(1,1,1)
-	XVCPSGNDP(2,2,2)
-	XVCPSGNDP(3,3,3)
-	XVCPSGNDP(4,4,4)
-	XVCPSGNDP(5,5,5)
-	XVCPSGNDP(6,6,6)
-	XVCPSGNDP(7,7,7)
-	XVCPSGNDP(8,8,8)
-	XVCPSGNDP(9,9,9)
-	XVCPSGNDP(10,10,10)
-	XVCPSGNDP(11,11,11)
-	XVCPSGNDP(12,12,12)
-	XVCPSGNDP(13,13,13)
-	XVCPSGNDP(14,14,14)
-	XVCPSGNDP(15,15,15)
-	XVCPSGNDP(16,16,16)
-	XVCPSGNDP(17,17,17)
-	XVCPSGNDP(18,18,18)
-	XVCPSGNDP(19,19,19)
-	XVCPSGNDP(20,20,20)
-	XVCPSGNDP(21,21,21)
-	XVCPSGNDP(22,22,22)
-	XVCPSGNDP(23,23,23)
-	XVCPSGNDP(24,24,24)
-	XVCPSGNDP(25,25,25)
-	XVCPSGNDP(26,26,26)
-	XVCPSGNDP(27,27,27)
-	XVCPSGNDP(28,28,28)
-	XVCPSGNDP(29,29,29)
-	XVCPSGNDP(30,30,30)
-	XVCPSGNDP(31,31,31)
+
+#define XVCPSGNDP2(n) XVCPSGNDP(n,n,n) ; XVCPSGNDP(n+1,n+1,n+1)
+#define XVCPSGNDP4(n) XVCPSGNDP2(n) ; XVCPSGNDP2(n+2)
+#define XVCPSGNDP8(n) XVCPSGNDP4(n) ; XVCPSGNDP4(n+4)
+#define XVCPSGNDP16(n) XVCPSGNDP8(n) ; XVCPSGNDP8(n+8)
+#define XVCPSGNDP32(n) XVCPSGNDP16(n) ; XVCPSGNDP16(n+16)
+	XVCPSGNDP32(0)
+
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
 	mtspr	SPRN_HSRR0,r11
 	mtcrf	0x80,r9
-- 
1.7.10.4
