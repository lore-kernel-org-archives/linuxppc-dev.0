Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d09f853cf591c6b33c316eb4df16dbb2a43246e8.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 14/14] powerpc: Use an alternative feature section in
	entry_64.S
Date: Tue, 24 Jun 2008 11:33:05 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use an alternative feature section in _switch. There are three cases
handled here, either we don't have an SLB, in which case we jump over the
entire code section, or if we do we either do or don't have 1TB segments.

Boot tested on Power3, Power5 and Power5+.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/entry_64.S |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index c0db5b7..6ca3044 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -383,16 +383,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 
 	ld	r8,KSP(r4)	/* new stack pointer */
 BEGIN_FTR_SECTION
-	b	2f
-END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
-BEGIN_FTR_SECTION
+  BEGIN_FTR_SECTION_NESTED(95)
 	clrrdi	r6,r8,28	/* get its ESID */
 	clrrdi	r9,r1,28	/* get current sp ESID */
-END_FTR_SECTION_IFCLR(CPU_FTR_1T_SEGMENT)
-BEGIN_FTR_SECTION
+  FTR_SECTION_ELSE_NESTED(95)
 	clrrdi	r6,r8,40	/* get its 1T ESID */
 	clrrdi	r9,r1,40	/* get current sp 1T ESID */
-END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
+  ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_1T_SEGMENT, 95)
+FTR_SECTION_ELSE
+	b	2f
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_SLB)
 	clrldi.	r0,r6,2		/* is new ESID c00000000? */
 	cmpd	cr1,r6,r9	/* or is new ESID the same as current ESID? */
 	cror	eq,4*cr1+eq,eq
-- 
1.5.5
