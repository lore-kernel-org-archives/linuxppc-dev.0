Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpqCS1tDxzDrcT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 06:48:04 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v88KiTUu145077
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Sep 2017 16:48:02 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cv0tgmaym-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 16:48:01 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 8 Sep 2017 14:48:01 -0600
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 John Allen <jallen@linux.vnet.ibm.com>
In-Reply-To: <74fb879c-19bf-3abf-4491-1f0db162e7d8@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V14 4/4] powerpc/vphn: Fix numa update end-loop bug
Date: Fri, 8 Sep 2017 15:47:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <b6e0b987-8e45-77f1-c627-0df38979369a@linux.vnet.ibm.com>
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
Changes in V14:
  -- More code cleanup
---
 arch/powerpc/mm/numa.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 32f5f8d..ec098b3 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1401,16 +1401,22 @@ int numa_update_cpu_topology(bool cpus_locked)
 
 		for_each_cpu(sibling, cpu_sibling_mask(cpu)) {
 			ud = &updates[i++];
+			ud->next = &updates[i];
 			ud->cpu = sibling;
 			ud->new_nid = new_nid;
 			ud->old_nid = numa_cpu_lookup_table[sibling];
 			cpumask_set_cpu(sibling, &updated_cpus);
-			if (i < weight)
-				ud->next = &updates[i];
 		}
 		cpu = cpu_last_thread_sibling(cpu);
 	}
 
+	/*
+	 * Prevent processing of 'updates' from overflowing array
+	 * where last entry filled in a 'next' pointer.
+	 */
+	if (i)
+		updates[i-1].next = NULL;
+
 	pr_debug("Topology update for the following CPUs:\n");
 	if (cpumask_weight(&updated_cpus)) {
 		for (ud = &updates[0]; ud; ud = ud->next) {
