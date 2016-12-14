Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfCMl26m9zDw3P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 10:24:35 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBENNis8069902
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 18:24:31 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm75qtk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 18:24:31 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 15 Dec 2016 09:24:28 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0AA992BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 10:24:27 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBENOQwf54067240
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 10:24:26 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBENOQbK022442
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 10:24:26 +1100
Date: Thu, 15 Dec 2016 10:24:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, hch@lst.de, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org.#.v4.9+, gabriel@krisman.be
Subject: Re: [PATCH] genirq/affinity: fix node generation from cpumask
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-Id: <20161214232425.GA13182@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 14, 2016 at 04:01:12PM -0200, Guilherme G. Piccoli wrote:
>Commit 34c3d9819fda ("genirq/affinity: Provide smarter irq spreading
>infrastructure") introduced a better IRQ spreading mechanism, taking
>account of the available NUMA nodes in the machine.
>
>Problem is that the algorithm of retrieving the nodemask iterates
>"linearly" based on the number of online nodes - some architectures
>present non-linear node distribution among the nodemask, like PowerPC.
>If this is the case, the algorithm lead to a wrong node count number
>and therefore to a bad/incomplete IRQ affinity distribution.
>
>For example, this problem were found in a machine with 128 CPUs and two
>nodes, namely nodes 0 and 8 (instead of 0 and 1, if it was linearly
>distributed). This led to a wrong affinity distribution which then led to
>a bad mq allocation for nvme driver.
>
>Finally, we take the opportunity to fix a comment regarding the affinity
>distribution when we have _more_ nodes than vectors.
>
>Fixes: 34c3d9819fda ("genirq/affinity: Provide smarter irq spreading infrastructure")
>Reported-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
>Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>Cc: stable@vger.kernel.org # v4.9+
>Cc: Christoph Hellwig <hch@lst.de>
>Cc: linuxppc-dev@lists.ozlabs.org
>Cc: linux-pci@vger.kernel.org
>---

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

There is one picky comment as below, but you don't have to fix it :)

> kernel/irq/affinity.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
>index 9be9bda..464eaf0 100644
>--- a/kernel/irq/affinity.c
>+++ b/kernel/irq/affinity.c
>@@ -37,15 +37,15 @@ static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
>
> static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
> {
>-	int n, nodes;
>+	int n, nodes = 0;
>
> 	/* Calculate the number of nodes in the supplied affinity mask */
>-	for (n = 0, nodes = 0; n < num_online_nodes(); n++) {
>+	for_each_online_node(n)
> 		if (cpumask_intersects(mask, cpumask_of_node(n))) {
> 			node_set(n, *nodemsk);
> 			nodes++;
> 		}
>-	}
>+

It'd better to keep the brackets so that we needn't add them when adding
more code into the block next time.

> 	return nodes;
> }
>
>@@ -82,7 +82,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
> 	nodes = get_nodes_in_cpumask(cpu_online_mask, &nodemsk);
>
> 	/*
>-	 * If the number of nodes in the mask is less than or equal the
>+	 * If the number of nodes in the mask is greater than or equal the
> 	 * number of vectors we just spread the vectors across the nodes.
> 	 */
> 	if (affv <= nodes) {

Thanks,
Gavin
