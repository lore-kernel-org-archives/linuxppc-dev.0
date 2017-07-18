Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBjGK34WxzDrH2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 00:29:13 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6IEOoWd084212
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 10:29:11 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bsbxb8v75-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 10:29:11 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 18 Jul 2017 10:29:09 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powernv/powerpc:Save/Restore additional SPRs for stop4
 cpuidle
Date: Tue, 18 Jul 2017 19:58:48 +0530
In-Reply-To: <cover.1500361607.git.ego@linux.vnet.ibm.com>
References: <cover.1500361607.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1500361607.git.ego@linux.vnet.ibm.com>
References: <cover.1500361607.git.ego@linux.vnet.ibm.com>
Message-Id: <296f38e7ce98e69e24a8c52047e1652cbf780f7c.1500361607.git.ego@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/paca.h   |  7 ++++++
 arch/powerpc/kernel/asm-offsets.c | 12 ++++++++++
 arch/powerpc/kernel/idle_book3s.S | 46 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index dc88a31..a6b9ea6 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -48,6 +48,7 @@
 #define get_lppaca()	(get_paca()->lppaca_ptr)
 #define get_slb_shadow()	(get_paca()->slb_shadow_ptr)
 
+#define MAX_STOP_SPRS     7
 struct task_struct;
 
 /*
@@ -183,6 +184,12 @@ struct paca_struct {
 	struct paca_struct **thread_sibling_pacas;
 	/* The PSSCR value that the kernel requested before going to stop */
 	u64 requested_psscr;
+
+	/*
+	 * Save area for additional SPRs that need to be
+	 * saved/restored during cpuidle stop.
+	 */
+	u64 stop_spr_save_area[MAX_STOP_SPRS];
 #endif
 
 #ifdef CONFIG_PPC_STD_MMU_64
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index a7b5af3..0262283 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -743,6 +743,18 @@ int main(void)
 	OFFSET(PACA_SUBCORE_SIBLING_MASK, paca_struct, subcore_sibling_mask);
 	OFFSET(PACA_SIBLING_PACA_PTRS, paca_struct, thread_sibling_pacas);
 	OFFSET(PACA_REQ_PSSCR, paca_struct, requested_psscr);
+
+	OFFSET(PACA_PID, paca_struct, stop_spr_save_area[0]);
+	OFFSET(PACA_LDBAR, paca_struct, stop_spr_save_area[1]);
+	OFFSET(PACA_FSCR, paca_struct, stop_spr_save_area[2]);
+	OFFSET(PACA_HFSCR, paca_struct, stop_spr_save_area[3]);
+
+	/* On POWER9, we are already saving MMCR0 for ESL=EC=1 */
+	OFFSET(PACA_MMCRA, paca_struct, stop_spr_save_area[4]);
+	OFFSET(PACA_MMCR1, paca_struct, stop_spr_save_area[5]);
+	OFFSET(PACA_MMCR2, paca_struct, stop_spr_save_area[6]);
+
+
 #endif
 
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 5adb390e..7083f63 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -84,7 +84,50 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 	std	r3,_WORT(r1)
 	mfspr	r3,SPRN_WORC
 	std	r3,_WORC(r1)
+BEGIN_FTR_SECTION
+	blr
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
+	/* Save additional SPRs for POWER9 */
+power9_save_additional_sprs:
+	mfspr	r3, SPRN_PID
+	mfspr	r4, SPRN_LDBAR
+	std	r3, PACA_PID(r13)
+	std	r4, PACA_LDBAR(r13)
+
+	mfspr	r3, SPRN_FSCR
+	mfspr	r4, SPRN_HFSCR
+	std	r3, PACA_FSCR(r13)
+	std	r4, PACA_HFSCR(r13)
+
+	mfspr	r3, SPRN_MMCRA
+	mfspr	r4, SPRN_MMCR1
+	std	r3, PACA_MMCRA(r13)
+	std	r4, PACA_MMCR1(r13)
+
+	mfspr	r3, SPRN_MMCR2
+	std	r3, PACA_MMCR2(r13)
+	blr
 
+power9_restore_additional_sprs:
+	ld	r3,_LPCR(r1)
+	ld	r4, PACA_PID(r13)
+	mtspr	SPRN_LPCR,r3
+	mtspr	SPRN_PID, r4
+
+	ld	r3, PACA_LDBAR(r13)
+	ld	r4, PACA_FSCR(r13)
+	mtspr	SPRN_LDBAR, r3
+	mtspr	SPRN_FSCR, r4
+
+	ld	r3, PACA_HFSCR(r13)
+	ld	r4, PACA_MMCRA(r13)
+	mtspr	SPRN_HFSCR, r3
+	mtspr	SPRN_MMCRA, r4
+	/* We have already restored PACA_MMCR0 */
+	ld	r3, PACA_MMCR1(r13)
+	ld	r4, PACA_MMCR2(r13)
+	mtspr	SPRN_MMCR1, r3
+	mtspr	SPRN_MMCR2, r4
 	blr
 
 /*
@@ -791,8 +834,7 @@ no_segments:
 	bctrl
 
 BEGIN_FTR_SECTION
-	ld	r4,_LPCR(r1)
-	mtspr	SPRN_LPCR,r4
+	bl 	power9_restore_additional_sprs
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 hypervisor_state_restored:
 
-- 
1.9.4
