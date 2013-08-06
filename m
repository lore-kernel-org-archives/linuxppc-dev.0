Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 35/63] powerpc: Fix endian issues in VMX copy loops
Date: Wed,  7 Aug 2013 02:01:52 +1000
Message-Id: <1375804940-22050-36-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the permute loops for little endian.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/lib/copyuser_power7.S | 54 +++++++++++++++++++++----------------
 arch/powerpc/lib/memcpy_power7.S   | 55 ++++++++++++++++++++++----------------
 2 files changed, 63 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index d1f1179..e8e9c36 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -19,6 +19,14 @@
  */
 #include <asm/ppc_asm.h>
 
+#ifdef __BIG_ENDIAN__
+#define LVS(VRT,RA,RB)		lvsl	VRT,RA,RB
+#define VPERM(VRT,VRA,VRB,VRC)	vperm	VRT,VRA,VRB,VRC
+#else
+#define LVS(VRT,RA,RB)		lvsr	VRT,RA,RB
+#define VPERM(VRT,VRA,VRB,VRC)	vperm	VRT,VRB,VRA,VRC
+#endif
+
 	.macro err1
 100:
 	.section __ex_table,"a"
@@ -552,13 +560,13 @@ err3;	stw	r7,4(r3)
 	li	r10,32
 	li	r11,48
 
-	lvsl	vr16,0,r4	/* Setup permute control vector */
+	LVS(vr16,0,r4)		/* Setup permute control vector */
 err3;	lvx	vr0,0,r4
 	addi	r4,r4,16
 
 	bf	cr7*4+3,5f
 err3;	lvx	vr1,r0,r4
-	vperm	vr8,vr0,vr1,vr16
+	VPERM(vr8,vr0,vr1,vr16)
 	addi	r4,r4,16
 err3;	stvx	vr8,r0,r3
 	addi	r3,r3,16
@@ -566,9 +574,9 @@ err3;	stvx	vr8,r0,r3
 
 5:	bf	cr7*4+2,6f
 err3;	lvx	vr1,r0,r4
-	vperm	vr8,vr0,vr1,vr16
+	VPERM(vr8,vr0,vr1,vr16)
 err3;	lvx	vr0,r4,r9
-	vperm	vr9,vr1,vr0,vr16
+	VPERM(vr9,vr1,vr0,vr16)
 	addi	r4,r4,32
 err3;	stvx	vr8,r0,r3
 err3;	stvx	vr9,r3,r9
@@ -576,13 +584,13 @@ err3;	stvx	vr9,r3,r9
 
 6:	bf	cr7*4+1,7f
 err3;	lvx	vr3,r0,r4
-	vperm	vr8,vr0,vr3,vr16
+	VPERM(vr8,vr0,vr3,vr16)
 err3;	lvx	vr2,r4,r9
-	vperm	vr9,vr3,vr2,vr16
+	VPERM(vr9,vr3,vr2,vr16)
 err3;	lvx	vr1,r4,r10
-	vperm	vr10,vr2,vr1,vr16
+	VPERM(vr10,vr2,vr1,vr16)
 err3;	lvx	vr0,r4,r11
-	vperm	vr11,vr1,vr0,vr16
+	VPERM(vr11,vr1,vr0,vr16)
 	addi	r4,r4,64
 err3;	stvx	vr8,r0,r3
 err3;	stvx	vr9,r3,r9
@@ -611,21 +619,21 @@ err3;	stvx	vr11,r3,r11
 	.align	5
 8:
 err4;	lvx	vr7,r0,r4
-	vperm	vr8,vr0,vr7,vr16
+	VPERM(vr8,vr0,vr7,vr16)
 err4;	lvx	vr6,r4,r9
-	vperm	vr9,vr7,vr6,vr16
+	VPERM(vr9,vr7,vr6,vr16)
 err4;	lvx	vr5,r4,r10
-	vperm	vr10,vr6,vr5,vr16
+	VPERM(vr10,vr6,vr5,vr16)
 err4;	lvx	vr4,r4,r11
-	vperm	vr11,vr5,vr4,vr16
+	VPERM(vr11,vr5,vr4,vr16)
 err4;	lvx	vr3,r4,r12
-	vperm	vr12,vr4,vr3,vr16
+	VPERM(vr12,vr4,vr3,vr16)
 err4;	lvx	vr2,r4,r14
-	vperm	vr13,vr3,vr2,vr16
+	VPERM(vr13,vr3,vr2,vr16)
 err4;	lvx	vr1,r4,r15
-	vperm	vr14,vr2,vr1,vr16
+	VPERM(vr14,vr2,vr1,vr16)
 err4;	lvx	vr0,r4,r16
-	vperm	vr15,vr1,vr0,vr16
+	VPERM(vr15,vr1,vr0,vr16)
 	addi	r4,r4,128
 err4;	stvx	vr8,r0,r3
 err4;	stvx	vr9,r3,r9
@@ -649,13 +657,13 @@ err4;	stvx	vr15,r3,r16
 
 	bf	cr7*4+1,9f
 err3;	lvx	vr3,r0,r4
-	vperm	vr8,vr0,vr3,vr16
+	VPERM(vr8,vr0,vr3,vr16)
 err3;	lvx	vr2,r4,r9
-	vperm	vr9,vr3,vr2,vr16
+	VPERM(vr9,vr3,vr2,vr16)
 err3;	lvx	vr1,r4,r10
-	vperm	vr10,vr2,vr1,vr16
+	VPERM(vr10,vr2,vr1,vr16)
 err3;	lvx	vr0,r4,r11
-	vperm	vr11,vr1,vr0,vr16
+	VPERM(vr11,vr1,vr0,vr16)
 	addi	r4,r4,64
 err3;	stvx	vr8,r0,r3
 err3;	stvx	vr9,r3,r9
@@ -665,9 +673,9 @@ err3;	stvx	vr11,r3,r11
 
 9:	bf	cr7*4+2,10f
 err3;	lvx	vr1,r0,r4
-	vperm	vr8,vr0,vr1,vr16
+	VPERM(vr8,vr0,vr1,vr16)
 err3;	lvx	vr0,r4,r9
-	vperm	vr9,vr1,vr0,vr16
+	VPERM(vr9,vr1,vr0,vr16)
 	addi	r4,r4,32
 err3;	stvx	vr8,r0,r3
 err3;	stvx	vr9,r3,r9
@@ -675,7 +683,7 @@ err3;	stvx	vr9,r3,r9
 
 10:	bf	cr7*4+3,11f
 err3;	lvx	vr1,r0,r4
-	vperm	vr8,vr0,vr1,vr16
+	VPERM(vr8,vr0,vr1,vr16)
 	addi	r4,r4,16
 err3;	stvx	vr8,r0,r3
 	addi	r3,r3,16
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
index 0663630..e4177db 100644
--- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -20,6 +20,15 @@
 #include <asm/ppc_asm.h>
 
 _GLOBAL(memcpy_power7)
+
+#ifdef __BIG_ENDIAN__
+#define LVS(VRT,RA,RB)		lvsl	VRT,RA,RB
+#define VPERM(VRT,VRA,VRB,VRC)	vperm	VRT,VRA,VRB,VRC
+#else
+#define LVS(VRT,RA,RB)		lvsr	VRT,RA,RB
+#define VPERM(VRT,VRA,VRB,VRC)	vperm	VRT,VRB,VRA,VRC
+#endif
+
 #ifdef CONFIG_ALTIVEC
 	cmpldi	r5,16
 	cmpldi	cr1,r5,4096
@@ -485,13 +494,13 @@ _GLOBAL(memcpy_power7)
 	li	r10,32
 	li	r11,48
 
-	lvsl	vr16,0,r4	/* Setup permute control vector */
+	LVS(vr16,0,r4)		/* Setup permute control vector */
 	lvx	vr0,0,r4
 	addi	r4,r4,16
 
 	bf	cr7*4+3,5f
 	lvx	vr1,r0,r4
-	vperm	vr8,vr0,vr1,vr16
+	VPERM(vr8,vr0,vr1,vr16)
 	addi	r4,r4,16
 	stvx	vr8,r0,r3
 	addi	r3,r3,16
@@ -499,9 +508,9 @@ _GLOBAL(memcpy_power7)
 
 5:	bf	cr7*4+2,6f
 	lvx	vr1,r0,r4
-	vperm	vr8,vr0,vr1,vr16
+	VPERM(vr8,vr0,vr1,vr16)
 	lvx	vr0,r4,r9
-	vperm	vr9,vr1,vr0,vr16
+	VPERM(vr9,vr1,vr0,vr16)
 	addi	r4,r4,32
 	stvx	vr8,r0,r3
 	stvx	vr9,r3,r9
@@ -509,13 +518,13 @@ _GLOBAL(memcpy_power7)
 
 6:	bf	cr7*4+1,7f
 	lvx	vr3,r0,r4
-	vperm	vr8,vr0,vr3,vr16
+	VPERM(vr8,vr0,vr3,vr16)
 	lvx	vr2,r4,r9
-	vperm	vr9,vr3,vr2,vr16
+	VPERM(vr9,vr3,vr2,vr16)
 	lvx	vr1,r4,r10
-	vperm	vr10,vr2,vr1,vr16
+	VPERM(vr10,vr2,vr1,vr16)
 	lvx	vr0,r4,r11
-	vperm	vr11,vr1,vr0,vr16
+	VPERM(vr11,vr1,vr0,vr16)
 	addi	r4,r4,64
 	stvx	vr8,r0,r3
 	stvx	vr9,r3,r9
@@ -544,21 +553,21 @@ _GLOBAL(memcpy_power7)
 	.align	5
 8:
 	lvx	vr7,r0,r4
-	vperm	vr8,vr0,vr7,vr16
+	VPERM(vr8,vr0,vr7,vr16)
 	lvx	vr6,r4,r9
-	vperm	vr9,vr7,vr6,vr16
+	VPERM(vr9,vr7,vr6,vr16)
 	lvx	vr5,r4,r10
-	vperm	vr10,vr6,vr5,vr16
+	VPERM(vr10,vr6,vr5,vr16)
 	lvx	vr4,r4,r11
-	vperm	vr11,vr5,vr4,vr16
+	VPERM(vr11,vr5,vr4,vr16)
 	lvx	vr3,r4,r12
-	vperm	vr12,vr4,vr3,vr16
+	VPERM(vr12,vr4,vr3,vr16)
 	lvx	vr2,r4,r14
-	vperm	vr13,vr3,vr2,vr16
+	VPERM(vr13,vr3,vr2,vr16)
 	lvx	vr1,r4,r15
-	vperm	vr14,vr2,vr1,vr16
+	VPERM(vr14,vr2,vr1,vr16)
 	lvx	vr0,r4,r16
-	vperm	vr15,vr1,vr0,vr16
+	VPERM(vr15,vr1,vr0,vr16)
 	addi	r4,r4,128
 	stvx	vr8,r0,r3
 	stvx	vr9,r3,r9
@@ -582,13 +591,13 @@ _GLOBAL(memcpy_power7)
 
 	bf	cr7*4+1,9f
 	lvx	vr3,r0,r4
-	vperm	vr8,vr0,vr3,vr16
+	VPERM(vr8,vr0,vr3,vr16)
 	lvx	vr2,r4,r9
-	vperm	vr9,vr3,vr2,vr16
+	VPERM(vr9,vr3,vr2,vr16)
 	lvx	vr1,r4,r10
-	vperm	vr10,vr2,vr1,vr16
+	VPERM(vr10,vr2,vr1,vr16)
 	lvx	vr0,r4,r11
-	vperm	vr11,vr1,vr0,vr16
+	VPERM(vr11,vr1,vr0,vr16)
 	addi	r4,r4,64
 	stvx	vr8,r0,r3
 	stvx	vr9,r3,r9
@@ -598,9 +607,9 @@ _GLOBAL(memcpy_power7)
 
 9:	bf	cr7*4+2,10f
 	lvx	vr1,r0,r4
-	vperm	vr8,vr0,vr1,vr16
+	VPERM(vr8,vr0,vr1,vr16)
 	lvx	vr0,r4,r9
-	vperm	vr9,vr1,vr0,vr16
+	VPERM(vr9,vr1,vr0,vr16)
 	addi	r4,r4,32
 	stvx	vr8,r0,r3
 	stvx	vr9,r3,r9
@@ -608,7 +617,7 @@ _GLOBAL(memcpy_power7)
 
 10:	bf	cr7*4+3,11f
 	lvx	vr1,r0,r4
-	vperm	vr8,vr0,vr1,vr16
+	VPERM(vr8,vr0,vr1,vr16)
 	addi	r4,r4,16
 	stvx	vr8,r0,r3
 	addi	r3,r3,16
-- 
1.8.1.2
