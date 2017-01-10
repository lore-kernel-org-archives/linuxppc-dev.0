Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyYL52T9dzDqNb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 00:49:48 +1100 (AEDT)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Gabriel Krisman Bertazi <gabriel@krisman.be>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Christoph Hellwig <hch@lst.de>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.9 136/206] genirq/affinity: Fix node generation from cpumask
Date: Tue, 10 Jan 2017 14:36:59 +0100
Message-Id: <20170110131508.995530540@linuxfoundation.org>
In-Reply-To: <20170110131502.767555407@linuxfoundation.org>
References: <20170110131502.767555407@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

commit c0af52437254fda8b0cdbaae5a9b6d9327f1fcd5 upstream.

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: hch@lst.de
Link: http://lkml.kernel.org/r/1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/affinity.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -37,10 +37,10 @@ static void irq_spread_init_one(struct c
 
 static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
 {
-	int n, nodes;
+	int n, nodes = 0;
 
 	/* Calculate the number of nodes in the supplied affinity mask */
-	for (n = 0, nodes = 0; n < num_online_nodes(); n++) {
+	for_each_online_node(n) {
 		if (cpumask_intersects(mask, cpumask_of_node(n))) {
 			node_set(n, *nodemsk);
 			nodes++;
@@ -81,7 +81,7 @@ struct cpumask *irq_create_affinity_mask
 	nodes = get_nodes_in_cpumask(affinity, &nodemsk);
 
 	/*
-	 * If the number of nodes in the mask is less than or equal the
+	 * If the number of nodes in the mask is greater than or equal the
 	 * number of vectors we just spread the vectors across the nodes.
 	 */
 	if (nvec <= nodes) {
