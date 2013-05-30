Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc/pseries: Improve stream generation comments in
 copypage/user
Date: Thu, 30 May 2013 15:34:29 +1000
Message-ID: <17933.1369892069@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No code changes, just documenting what's happening a little better.

Signed-off-by: Michael Neuling <mikey@neuling.org>

diff --git a/arch/powerpc/lib/copypage_power7.S b/arch/powerpc/lib/copypage_power7.S
index 0ef75bf..395c594 100644
--- a/arch/powerpc/lib/copypage_power7.S
+++ b/arch/powerpc/lib/copypage_power7.S
@@ -28,13 +28,14 @@ _GLOBAL(copypage_power7)
 	 * aligned we don't need to clear the bottom 7 bits of either
 	 * address.
 	 */
-	ori	r9,r3,1		/* stream=1 */
+	ori	r9,r3,1		/* stream=1 => to */
 
 #ifdef CONFIG_PPC_64K_PAGES
-	lis	r7,0x0E01	/* depth=7, units=512 */
+	lis	r7,0x0E01	/* depth=7
+				 * units/cachelines=512 */
 #else
 	lis	r7,0x0E00	/* depth=7 */
-	ori	r7,r7,0x1000	/* units=32 */
+	ori	r7,r7,0x1000	/* units/cachelines=32 */
 #endif
 	ori	r10,r7,1	/* stream=1 */
 
@@ -43,12 +44,14 @@ _GLOBAL(copypage_power7)
 
 .machine push
 .machine "power4"
-	dcbt	r0,r4,0b01000
-	dcbt	r0,r7,0b01010
-	dcbtst	r0,r9,0b01000
-	dcbtst	r0,r10,0b01010
+	/* setup read stream 0  */
+	dcbt	r0,r4,0b01000  	/* addr from */
+	dcbt	r0,r7,0b01010   /* length and depth from */
+	/* setup write stream 1 */
+	dcbtst	r0,r9,0b01000   /* addr to */
+	dcbtst	r0,r10,0b01010  /* length and depth to */
 	eieio
-	dcbt	r0,r8,0b01010	/* GO */
+	dcbt	r0,r8,0b01010	/* all streams GO */
 .machine pop
 
 #ifdef CONFIG_ALTIVEC
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index 0d24ff1..d1f1179 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -318,12 +318,14 @@ err1;	stb	r0,0(r3)
 
 .machine push
 .machine "power4"
-	dcbt	r0,r6,0b01000
-	dcbt	r0,r7,0b01010
-	dcbtst	r0,r9,0b01000
-	dcbtst	r0,r10,0b01010
+	/* setup read stream 0 */
+	dcbt	r0,r6,0b01000   /* addr from */
+	dcbt	r0,r7,0b01010   /* length and depth from */
+	/* setup write stream 1 */
+	dcbtst	r0,r9,0b01000   /* addr to */
+	dcbtst	r0,r10,0b01010  /* length and depth to */
 	eieio
-	dcbt	r0,r8,0b01010	/* GO */
+	dcbt	r0,r8,0b01010	/* all streams GO */
 .machine pop
 
 	beq	cr1,.Lunwind_stack_nonvmx_copy
