Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDS635P2CzDqvM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 20:43:07 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6LAcld9135421
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 06:43:03 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bubnt24b3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 06:43:03 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 21 Jul 2017 06:43:03 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v3 PATCH 1/2] powernv/powerpc:Save/Restore additional SPRs for stop4
 cpuidle
Date: Fri, 21 Jul 2017 16:11:37 +0530
In-Reply-To: <cover.1500631040.git.ego@linux.vnet.ibm.com>
References: <cover.1500631040.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1500631040.git.ego@linux.vnet.ibm.com>
References: <cover.1500631040.git.ego@linux.vnet.ibm.com>
Message-Id: <57ed82bcd92cd4d0af7ae5113710d597a331c433.1500631040.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

The stop4 idle state on POWER9 is a deep idle state which loses
hypervisor resources, but whose latency is low enough that it can be
exposed via cpuidle.

Until now, the deep idle states which lose hypervisor resources (eg:
winkle) were only exposed via CPU-Hotplug.  Hence currently on wakeup
from such states, barring a few SPRs which need to be restored to
their older value, rest of the SPRS are reinitialized to their values
corresponding to that at boot time.

When stop4 is used in the context of cpuidle, we want these additional
SPRs to be restored to their older value, to ensure that the context
on the CPU coming back from idle is same as it was before going idle.

In this patch, we define a SPR save area in PACA (since we have used
up the volatile register space in the stack) and on POWER9, we restore
SPRN_PID, SPRN_LDBAR, SPRN_FSCR, SPRN_HFSCR, SPRN_MMCRA, SPRN_MMCR1,
SPRN_MMCR2 to the values they had before entering stop.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
v2-->v3:
- Use a structure instead of an array for the stop sprs save area.
- Name the offsets into the paca->stop_sprs as STOP_XXX instead of
  PACA_XXX.
- Add comments in the assembly code explaining why saving/restoring
  is not needed on POWER8.
v1-->v2:
No change

 arch/powerpc/include/asm/cpuidle.h | 11 +++++++
 arch/powerpc/include/asm/paca.h    |  7 ++++
 arch/powerpc/kernel/asm-offsets.c  |  8 +++++
 arch/powerpc/kernel/idle_book3s.S  | 65 ++++++++++++++++++++++++++++++++++++--
 4 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 52586f9..8a174cb 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -67,6 +67,17 @@
 #define ERR_DEEP_STATE_ESL_MISMATCH	-2
 
 #ifndef __ASSEMBLY__
+/* Additional SPRs that need to be saved/restored during stop */
+struct stop_sprs {
+	u64 pid;
+	u64 ldbar;
+	u64 fscr;
+	u64 hfscr;
+	u64 mmcr1;
+	u64 mmcr2;
+	u64 mmcra;
+};
+
 extern u32 pnv_fastsleep_workaround_at_entry[];
 extern u32 pnv_fastsleep_workaround_at_exit[];
 
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index dc88a31..04b60af 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -31,6 +31,7 @@
 #endif
 #include <asm/accounting.h>
 #include <asm/hmi.h>
+#include <asm/cpuidle.h>
 
 register struct paca_struct *local_paca asm("r13");
 
@@ -183,6 +184,12 @@ struct paca_struct {
 	struct paca_struct **thread_sibling_pacas;
 	/* The PSSCR value that the kernel requested before going to stop */
 	u64 requested_psscr;
+
+	/*
+	 * Save area for additional SPRs that need to be
+	 * saved/restored during cpuidle stop.
+	 */
+	struct stop_sprs stop_sprs;
 #endif
 
 #ifdef CONFIG_PPC_STD_MMU_64
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index a7b5af3..e2a48df 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -743,6 +743,14 @@ int main(void)
 	OFFSET(PACA_SUBCORE_SIBLING_MASK, paca_struct, subcore_sibling_mask);
 	OFFSET(PACA_SIBLING_PACA_PTRS, paca_struct, thread_sibling_pacas);
 	OFFSET(PACA_REQ_PSSCR, paca_struct, requested_psscr);
+#define STOP_SPR(x, f)	OFFSET(x, paca_struct, stop_sprs.f)
+	STOP_SPR(STOP_PID, pid);
+	STOP_SPR(STOP_LDBAR, ldbar);
+	STOP_SPR(STOP_FSCR, fscr);
+	STOP_SPR(STOP_HFSCR, hfscr);
+	STOP_SPR(STOP_MMCR1, mmcr1);
+	STOP_SPR(STOP_MMCR2, mmcr2);
+	STOP_SPR(STOP_MMCRA, mmcra);
 #endif
 
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 5adb390e..5e6af97 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -84,7 +84,61 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	std	r3,_WORT(r1)
 	mfspr	r3,SPRN_WORC
 	std	r3,_WORC(r1)
+/*
+ * On POWER9, there are idle states such as stop4, invoked via cpuidle,
+ * that lose hypervisor resources. In such cases, we need to save
+ * additional SPRs before entering those idle states so that they can
+ * be restored to their older values on wakeup from the idle state.
+ *
+ * On POWER8, the only such deep idle state is winkle which is used
+ * only in the context of CPU-Hotplug, where these additional SPRs are
+ * reinitiazed to a sane value. Hence there is no need to save/restore
+ * these SPRs.
+ */
+BEGIN_FTR_SECTION
+	blr
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
+
+power9_save_additional_sprs:
+	mfspr	r3, SPRN_PID
+	mfspr	r4, SPRN_LDBAR
+	std	r3, STOP_PID(r13)
+	std	r4, STOP_LDBAR(r13)
 
+	mfspr	r3, SPRN_FSCR
+	mfspr	r4, SPRN_HFSCR
+	std	r3, STOP_FSCR(r13)
+	std	r4, STOP_HFSCR(r13)
+
+	mfspr	r3, SPRN_MMCRA
+	mfspr	r4, SPRN_MMCR1
+	std	r3, STOP_MMCRA(r13)
+	std	r4, STOP_MMCR1(r13)
+
+	mfspr	r3, SPRN_MMCR2
+	std	r3, STOP_MMCR2(r13)
+	blr
+
+power9_restore_additional_sprs:
+	ld	r3,_LPCR(r1)
+	ld	r4, STOP_PID(r13)
+	mtspr	SPRN_LPCR,r3
+	mtspr	SPRN_PID, r4
+
+	ld	r3, STOP_LDBAR(r13)
+	ld	r4, STOP_FSCR(r13)
+	mtspr	SPRN_LDBAR, r3
+	mtspr	SPRN_FSCR, r4
+
+	ld	r3, STOP_HFSCR(r13)
+	ld	r4, STOP_MMCRA(r13)
+	mtspr	SPRN_HFSCR, r3
+	mtspr	SPRN_MMCRA, r4
+	/* We have already restored PACA_MMCR0 */
+	ld	r3, STOP_MMCR1(r13)
+	ld	r4, STOP_MMCR2(r13)
+	mtspr	SPRN_MMCR1, r3
+	mtspr	SPRN_MMCR2, r4
 	blr
 
 /*
@@ -790,9 +844,16 @@ no_segments:
 	mtctr	r12
 	bctrl
 
+/*
+ * On POWER9, we can come here on wakeup from a cpuidle stop state.
+ * Hence restore the additional SPRs to the saved value.
+ *
+ * On POWER8, we come here only on winkle. Since winkle is used
+ * only in the case of CPU-Hotplug, we don't need to restore
+ * the additional SPRs.
+ */
 BEGIN_FTR_SECTION
-	ld	r4,_LPCR(r1)
-	mtspr	SPRN_LPCR,r4
+	bl 	power9_restore_additional_sprs
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 hypervisor_state_restored:
 
-- 
1.9.4
