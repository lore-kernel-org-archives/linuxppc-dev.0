Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: DSCR FSCR cleanup
Date: Mon, 26 Aug 2013 13:55:57 +1000
Message-ID: <24883.1377489357@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As suggested by paulus we can simplify the Data Stream Control Register
(DSCR) Facility Status and Control Register (FSCR) handling.

Firstly, we simplify the asm by using a rldimi.

Secondly, we now use the FSCR only to control the DSCR facility, rather
than both the FSCR and HFSCR.  Users will see no functional change from
this but will get a minor speedup as they will trap into the kernel only
once (rather than twice) when they first touch the DSCR.  Also, this
changes removes a bunch of ugly FTR_SECTION code.

Signed-off-by: Michael Neuling <mikey@neuling.org>
--
 arch/powerpc/kernel/entry_64.S | 31 ++++++-------------------------
 arch/powerpc/kernel/traps.c    |  7 ++-----
 2 files changed, 8 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2bd0b88..513dc4d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -575,34 +575,15 @@ BEGIN_FTR_SECTION
 	ld	r7,DSCR_DEFAULT@toc(2)
 	ld	r0,THREAD_DSCR(r4)
 	cmpwi	r6,0
-	li	r8, FSCR_DSCR
 	bne	1f
 	ld	r0,0(r7)
-	b	3f
 1:
-  BEGIN_FTR_SECTION_NESTED(70)
-	mfspr	r6, SPRN_FSCR
-	or	r6, r6, r8
-	mtspr	SPRN_FSCR, r6
-    BEGIN_FTR_SECTION_NESTED(69)
-	mfspr	r6, SPRN_HFSCR
-	or	r6, r6, r8
-	mtspr	SPRN_HFSCR, r6
-    END_FTR_SECTION_NESTED(CPU_FTR_HVMODE, CPU_FTR_HVMODE, 69)
-	b	4f
-  END_FTR_SECTION_NESTED(CPU_FTR_ARCH_207S, CPU_FTR_ARCH_207S, 70)
-3:
-  BEGIN_FTR_SECTION_NESTED(70)
-	mfspr	r6, SPRN_FSCR
-	andc	r6, r6, r8
-	mtspr	SPRN_FSCR, r6
-    BEGIN_FTR_SECTION_NESTED(69)
-	mfspr	r6, SPRN_HFSCR
-	andc	r6, r6, r8
-	mtspr	SPRN_HFSCR, r6
-    END_FTR_SECTION_NESTED(CPU_FTR_HVMODE, CPU_FTR_HVMODE, 69)
-  END_FTR_SECTION_NESTED(CPU_FTR_ARCH_207S, CPU_FTR_ARCH_207S, 70)
-4:	cmpd	r0,r25
+BEGIN_FTR_SECTION_NESTED(70)
+	mfspr	r8, SPRN_FSCR
+	rldimi	r8, r6, FSCR_DSCR_LG, (63 - FSCR_DSCR_LG)
+	mtspr	SPRN_FSCR, r8
+END_FTR_SECTION_NESTED(CPU_FTR_ARCH_207S, CPU_FTR_ARCH_207S, 70)
+	cmpd	r0,r25
 	beq	2f
 	mtspr	SPRN_DSCR,r0
 2:
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e435bc0..0ba68a2 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1322,13 +1322,10 @@ void facility_unavailable_exception(struct pt_regs *regs)
 	if (status == FSCR_DSCR_LG) {
 		/* User is acessing the DSCR.  Set the inherit bit and allow
 		 * the user to set it directly in future by setting via the
-		 * H/FSCR DSCR bit.
+		 * FSCR DSCR bit.  We always leave HFSCR DSCR set.
 		 */
 		current->thread.dscr_inherit = 1;
-		if (hv)
-			mtspr(SPRN_HFSCR, value | HFSCR_DSCR);
-		else
-			mtspr(SPRN_FSCR,  value | FSCR_DSCR);
+		mtspr(SPRN_FSCR, value | FSCR_DSCR);
 		return;
 	}
 
