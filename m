Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tf4C82YDCzDw3P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 05:01:40 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBEHsJ20146911
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 13:01:37 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27b667cf42-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 13:01:36 -0500
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 14 Dec 2016 16:01:34 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id A5166352006C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 13:01:00 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBEI1UBL55378066
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 16:01:30 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBEI1Uxw013089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 16:01:30 -0200
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc: gabriel@krisman.be, hch@lst.de, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, gpiccoli@linux.vnet.ibm.com,
 stable@vger.kernel.org.#.v4.9+
Subject: [PATCH] genirq/affinity: fix node generation from cpumask
Date: Wed, 14 Dec 2016 16:01:12 -0200
Message-Id: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 34c3d9819fda ("genirq/affinity: Provide smarter irq spreading
infrastructure") introduced a better IRQ spreading mechanism, taking
account of the available NUMA nodes in the machine.

Problem is that the algorithm of retrieving the nodemask iterates
"linearly" based on the number of online nodes - some architectures
present non-linear node distribution among the nodemask, like PowerPC.
If this is the case, the algorithm lead to a wrong node count number
and therefore to a bad/incomplete IRQ affinity distribution.

For example, this problem were found in a machine with 128 CPUs and two
nodes, namely nodes 0 and 8 (instead of 0 and 1, if it was linearly
distributed). This led to a wrong affinity distribution which then led to
a bad mq allocation for nvme driver.

Finally, we take the opportunity to fix a comment regarding the affinity
distribution when we have _more_ nodes than vectors.

Fixes: 34c3d9819fda ("genirq/affinity: Provide smarter irq spreading infrastructure")
Reported-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # v4.9+
Cc: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org
---
 kernel/irq/affinity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 9be9bda..464eaf0 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -37,15 +37,15 @@ static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 
 static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
 {
-	int n, nodes;
+	int n, nodes = 0;
 
 	/* Calculate the number of nodes in the supplied affinity mask */
-	for (n = 0, nodes = 0; n < num_online_nodes(); n++) {
+	for_each_online_node(n)
 		if (cpumask_intersects(mask, cpumask_of_node(n))) {
 			node_set(n, *nodemsk);
 			nodes++;
 		}
-	}
+
 	return nodes;
 }
 
@@ -82,7 +82,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	nodes = get_nodes_in_cpumask(cpu_online_mask, &nodemsk);
 
 	/*
-	 * If the number of nodes in the mask is less than or equal the
+	 * If the number of nodes in the mask is greater than or equal the
 	 * number of vectors we just spread the vectors across the nodes.
 	 */
 	if (affv <= nodes) {
-- 
2.1.0
