Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VJ1244NJzF3JF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 21:27:50 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6HBP4Uf077503
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 07:27:47 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k9dxj48ur-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 07:27:47 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 17 Jul 2018 07:27:45 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Florian Weimer <fweimer@redhat.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] powerpc/powernv : Save/Restore SPRG3 on entry/exit from stop.
Date: Tue, 17 Jul 2018 16:57:29 +0530
Message-Id: <1531826849-31838-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On 64-bit Servers, SPRN_SPRG3 and its userspace read-only mirror
SPRN_USPRG3 are used as userspace VDSO write and read registers
respectively.

SPRN_SPRG3 is lost when we enter stop4 and above, and is currently not
restored.  As a result, any read from SPRN_USPRG3 returns zero on an
exit from stop4 and above.

Thus in this situation, any call from sched_getcpu() always returns
zero, as on powerpc, we call __kernel_getcpu() which relies upon
SPRN_USPRG3 to report the CPU and NUMA node information.

Fix this by saving the SPRN_SPRG3 before entering a deep stop state,
and restoring it back on wakeup from the stop state.

Reported-by: Florian Weimer <fweimer@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h | 1 +
 arch/powerpc/kernel/asm-offsets.c  | 1 +
 arch/powerpc/kernel/idle_book3s.S  | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index e210a83..03fa904 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -77,6 +77,7 @@ struct stop_sprs {
 	u64 mmcr1;
 	u64 mmcr2;
 	u64 mmcra;
+	u64 sprg3;
 };
 
 extern u32 pnv_fastsleep_workaround_at_entry[];
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 89cf155..a35ebfc 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -776,6 +776,7 @@ int main(void)
 	STOP_SPR(STOP_MMCR1, mmcr1);
 	STOP_SPR(STOP_MMCR2, mmcr2);
 	STOP_SPR(STOP_MMCRA, mmcra);
+	STOP_SPR(STOP_SPRG3, sprg3);
 #endif
 
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index d85d551..5069d42 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -120,6 +120,9 @@ power9_save_additional_sprs:
 	mfspr	r4, SPRN_MMCR2
 	std	r3, STOP_MMCR1(r13)
 	std	r4, STOP_MMCR2(r13)
+
+	mfspr	r3, SPRN_SPRG3
+	std	r3, STOP_SPRG3(r13)
 	blr
 
 power9_restore_additional_sprs:
@@ -144,7 +147,9 @@ power9_restore_additional_sprs:
 	mtspr	SPRN_MMCR1, r4
 
 	ld	r3, STOP_MMCR2(r13)
+	ld	r4, STOP_SPRG3(r13)
 	mtspr	SPRN_MMCR2, r3
+	mtspr	SPRN_SPRG3, r4
 	blr
 
 /*
-- 
1.9.4
