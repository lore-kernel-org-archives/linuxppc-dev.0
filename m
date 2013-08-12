Return-Path: <paulus@ozlabs.org>
Date: Mon, 12 Aug 2013 16:12:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix denormalized exception handler
Message-ID: <20130812061206.GA20246@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The denormalized exception handler (denorm_exception_hv) has a couple
of bugs.  If the CONFIG_PPC_DENORMALISATION option is not selected,
or the HSRR1_DENORM bit is not set in HSRR1, we don't test whether the
interrupt occurred within a KVM guest.  On the other hand, if the
HSRR1_DENORM bit is set and CONFIG_PPC_DENORMALISATION is enabled,
we corrupt the CFAR and PPR.

To correct these problems, this replaces the open-coded version of
EXCEPTION_PROLOG_1 that is there currently, and that is missing the
saving of PPR and CFAR values to the PACA, with an instance of
EXCEPTION_PROLOG_1.  This adds an explicit KVMTEST after testing
whether the exception is one we can handle, and adds code to restore
the CFAR on exit.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/exceptions-64s.S | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e3c8a03..3e06b26 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -360,11 +360,7 @@ denorm_exception_hv:
 	HMT_MEDIUM_PPR_DISCARD
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
-	std	r11,PACA_EXGEN+EX_R11(r13)
-	std	r12,PACA_EXGEN+EX_R12(r13)
-	mfspr	r9,SPRN_SPRG_HSCRATCH0
-	std	r9,PACA_EXGEN+EX_R13(r13)
-	mfcr	r9
+	EXCEPTION_PROLOG_1(PACA_EXGEN, NOTEST, 0x1500)
 
 #ifdef CONFIG_PPC_DENORMALISATION
 	mfspr	r10,SPRN_HSRR1
@@ -374,6 +370,7 @@ denorm_exception_hv:
 	bne+	denorm_assist
 #endif
 
+	KVMTEST(0x1500)
 	EXCEPTION_PROLOG_PSERIES_1(denorm_common, EXC_HV)
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x1500)
 
@@ -494,6 +491,10 @@ denorm_done:
 	mtcrf	0x80,r9
 	ld	r9,PACA_EXGEN+EX_R9(r13)
 	RESTORE_PPR_PACA(PACA_EXGEN, r10)
+BEGIN_FTR_SECTION
+	ld	r10,PACA_EXGEN+EX_CFAR(r13)
+	mtspr	SPRN_CFAR,r10
+END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	ld	r10,PACA_EXGEN+EX_R10(r13)
 	ld	r11,PACA_EXGEN+EX_R11(r13)
 	ld	r12,PACA_EXGEN+EX_R12(r13)
-- 
1.8.4.rc2
