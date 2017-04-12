Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w32Fk6LH9zDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:46:50 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CBdJc0122343
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:46:46 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29shx4d4ny-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:46:45 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 07:46:45 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powernv:idle: Set LPCR_UPRT on wakeup from deep-stop
Date: Wed, 12 Apr 2017 17:16:22 +0530
In-Reply-To: <cover.1491996797.git.ego@linux.vnet.ibm.com>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1491996797.git.ego@linux.vnet.ibm.com>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
Message-Id: <9be8410e0abe5ae1afa16a6f987c53046ef51757.1491996797.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On wakeup from a deep-stop used for CPU-Hotplug, we invoke
cur_cpu_spec->cpu_restore() which would set sane default values to
various SPRs including LPCR.

On POWER9, the cpu_restore_power9() call would would restore LPCR to a
sane value that is set at early boot time, thereby clearing LPCR_UPRT.

However, LPCR_UPRT is required to be set if we are running in Radix
mode. If this is not set we will end up with a crash when we enable
IR,DR.

To fix this, after returning from cur_cpu_spec->cpu_restore() in the
idle exit path, set LPCR_UPRT if we are running in Radix mode.

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle_book3s.S | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 6a9bd28..39a9b63 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -804,6 +804,19 @@ no_segments:
 #endif
 	mtctr	r12
 	bctrl
+/*
+ * cur_cpu_spec->cpu_restore would restore LPCR to a
+ * sane value that is set at early boot time,
+ * thereby clearing LPCR_UPRT.
+ * LPCR_UPRT is required if we are running in Radix mode.
+ * Set it here if that be the case.
+ */
+BEGIN_MMU_FTR_SECTION
+	mfspr	r3, SPRN_LPCR
+	LOAD_REG_IMMEDIATE(r4, LPCR_UPRT)
+	or	r3, r3, r4
+	mtspr	SPRN_LPCR, r3
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
 
 hypervisor_state_restored:
 
-- 
1.9.4
