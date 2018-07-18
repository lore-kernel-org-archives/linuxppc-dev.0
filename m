Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Vr5L3vmHzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 18:33:26 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6I8UQe4077043
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 04:33:24 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2k9xj6rhd2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 04:33:24 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 18 Jul 2018 04:33:23 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Florian Weimer <fweimer@redhat.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, <stable@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2] powerpc/powernv : Save/Restore SPRG3 on entry/exit from
 stop.
Date: Wed, 18 Jul 2018 14:03:16 +0530
Message-Id: <1531902796-32294-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On 64-bit servers, SPRN_SPRG3 and its userspace read-only mirror
SPRN_USPRG3 are used as userspace VDSO write and read registers
respectively.

SPRN_SPRG3 is lost when we enter stop4 and above, and is currently not
restored.  As a result, any read from SPRN_USPRG3 returns zero on an
exit from stop4 and above.

Thus in this situation, on POWER9, any call from sched_getcpu() always
returns zero, as on powerpc, we call __kernel_getcpu() which relies
upon SPRN_USPRG3 to report the CPU and NUMA node information.

Fix this by restoring SPRN_SPRG3 on wake up from a deep stop state
with the sprg_vdso value that is cached in PACA.

Fixes: e1c1cfed5432 ("powerpc/powernv: Save/Restore additional SPRs
for stop4 cpuidle")

Reported-by: Florian Weimer <fweimer@redhat.com>
Cc: <stable@vger.kernel.org> # 4.14
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
Change from v1: 
  Restoring the SPRG3 from paca->sprg_vdso instead of saving
  it separately during stop-entry, as suggested by Mikey.
  
 arch/powerpc/kernel/idle_book3s.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index d85d551..672ead8 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -144,7 +144,9 @@ power9_restore_additional_sprs:
 	mtspr	SPRN_MMCR1, r4
 
 	ld	r3, STOP_MMCR2(r13)
+	ld	r4, PACA_SPRG_VDSO(r13)
 	mtspr	SPRN_MMCR2, r3
+	mtspr	SPRN_SPRG3, r4
 	blr
 
 /*
-- 
1.8.3.1
