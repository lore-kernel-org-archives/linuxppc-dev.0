Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECB101A0601
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 05:00:34 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Tue, 19 May 2015 15:00:31 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B4501C90045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 14:51:36 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JJ0S5i60883014
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 19:00:28 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JJ0R2p009015
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 15:00:28 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH] powerpc: Make doorbell check preemption safe
Date: Wed, 20 May 2015 00:30:14 +0530
Message-Id: <1432062014-9115-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org, paulus@samba.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Doorbell can be used to cause ipi on cpus which are sibling threads on
the same core. So icp_native_cause_ipi checks if the destination cpu
is a sibling thread of the current cpu and uses doorbell in such cases.

But while running with CONFIG_PREEMPT=y, since this section is
preemtible, we can run into issues if after we check if the destination
cpu is a sibling cpu, the task gets migrated from a sibling cpu to a
cpu on another core.

Fix this by using get_cpu()/ put_cpu()

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/sysdev/xics/icp-native.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 2fc4cf1..62fd478 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -147,12 +147,16 @@ static void icp_native_cause_ipi(int cpu, unsigned long data)
 {
 	kvmppc_set_host_ipi(cpu, 1);
 #ifdef CONFIG_PPC_DOORBELL
-	if (cpu_has_feature(CPU_FTR_DBELL) &&
-	    (cpumask_test_cpu(cpu, cpu_sibling_mask(smp_processor_id()))))
-		doorbell_cause_ipi(cpu, data);
-	else
+	if (cpu_has_feature(CPU_FTR_DBELL)) {
+		if (cpumask_test_cpu(cpu, cpu_sibling_mask(get_cpu()))) {
+			doorbell_cause_ipi(cpu, data);
+			put_cpu();
+			return;
+		}
+		put_cpu();
+	}
 #endif
-		icp_native_set_qirr(cpu, IPI_PRIORITY);
+	icp_native_set_qirr(cpu, IPI_PRIORITY);
 }
 
 /*
-- 
1.9.3
