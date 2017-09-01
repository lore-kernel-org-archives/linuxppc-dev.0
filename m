Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkNtt6PlzzDql1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Sep 2017 01:48:22 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v81Fi9Ws081905
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Sep 2017 11:48:20 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cq9gavdbm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Sep 2017 11:48:19 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 1 Sep 2017 09:48:19 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 John Allen <jallen@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V13 4/4] powerpc/vphn: Fix numa update end-loop bug
In-Reply-To: <fc21bb6f-9df8-ab7d-5987-6bdce5d39842@linux.vnet.ibm.com>
Date: Fri, 1 Sep 2017 10:48:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <b967cb9b-efc4-3ff3-27c8-876a81250133@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/vphn: On Power systems with shared configurations of CPUs
and memory, there are some issues with the association of additional
CPUs and memory to nodes when hot-adding resources.  This patch
fixes an end-of-updates processing problem observed occasionally
in numa_update_cpu_topology().

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 3a5b334..fccf23f 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1410,6 +1410,13 @@ int numa_update_cpu_topology(bool cpus_locked)
 		cpu = cpu_last_thread_sibling(cpu);
 	}
 
+	/*
+	 * Prevent processing of 'updates' from overflowing array
+	 * in cases where last entry filled in a 'next' pointer.
+	 */
+	if (i)
+		updates[i-1].next = NULL;
+
 	pr_debug("Topology update for the following CPUs:\n");
 	if (cpumask_weight(&updated_cpus)) {
 		for (ud = &updates[0]; ud; ud = ud->next) {
