Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/4] powerpc: Wire up the HV facility unavailable exception
Date: Tue, 25 Jun 2013 17:47:57 +1000
Message-Id: <1372146477-4338-4-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1372146477-4338-1-git-send-email-michael@ellerman.id.au>
References: <1372146477-4338-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similar to the facility unavailble exception, except the facilities are
controlled by HFSCR.

Adapt the facility_unavailable_exception() so it can be called for
either the regular or Hypervisor facility unavailable exceptions.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S |   15 +++++++++++++++
 arch/powerpc/kernel/traps.c          |   16 ++++++++++++----
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d55a63c..4e00d22 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -347,6 +347,12 @@ facility_unavailable_trampoline:
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	facility_unavailable_pSeries
 
+hv_facility_unavailable_trampoline:
+	. = 0xf80
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
+	b	facility_unavailable_hv
+
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1200, 0x1202, cbe_system_error)
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1202)
@@ -525,6 +531,8 @@ denorm_done:
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf40)
 	STD_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf60)
+	STD_EXCEPTION_HV_OOL(0xf82, facility_unavailable)
+	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xf82)
 
 /*
  * An interrupt came in while soft-disabled. We set paca->irq_happened, then:
@@ -836,6 +844,12 @@ facility_unavailable_relon_trampoline:
 	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	facility_unavailable_relon_pSeries
 
+hv_facility_unavailable_relon_trampoline:
+	. = 0x4f80
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
+	b	facility_unavailable_relon_hv
+
 	STD_RELON_EXCEPTION_PSERIES(0x5300, 0x1300, instruction_breakpoint)
 #ifdef CONFIG_PPC_DENORMALISATION
 	. = 0x5500
@@ -1174,6 +1188,7 @@ __end_handlers:
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
 	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
+	STD_RELON_EXCEPTION_HV_OOL(0xf80, facility_unavailable)
 
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2053bbd..e4f205a 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1295,10 +1295,18 @@ void facility_unavailable_exception(struct pt_regs *regs)
 		"EBB",
 		"TAR",
 	};
-	char *facility;
+	char *facility, *prefix;
 	u64 value;
 
-	value = mfspr(SPRN_FSCR) >> 56;
+	if (regs->trap == 0xf60) {
+		value = mfspr(SPRN_FSCR);
+		prefix = "";
+	} else {
+		value = mfspr(SPRN_HFSCR);
+		prefix = "Hypervisor ";
+	}
+
+	value = value >> 56;
 
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
@@ -1309,8 +1317,8 @@ void facility_unavailable_exception(struct pt_regs *regs)
 	else
 		facility = "unknown";
 
-	pr_err("Facility '%s' unavailable, exception at 0x%lx, MSR=%lx\n",
-		facility, regs->nip, regs->msr);
+	pr_err("%sFacility '%s' unavailable, exception at 0x%lx, MSR=%lx\n",
+		prefix, facility, regs->nip, regs->msr);
 
 	if (user_mode(regs)) {
 		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
-- 
1.7.10.4
