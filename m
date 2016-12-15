Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfT1X2wK6zDw5T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 20:39:44 +1100 (AEDT)
Date: Thu, 15 Dec 2016 10:36:52 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
cc: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linuxppc-dev@lists.ozlabs.org,
 gabriel@krisman.be
Subject: Re: [PATCH] genirq/affinity: fix node generation from cpumask
In-Reply-To: <20161214232425.GA13182@gwshan>
Message-ID: <alpine.DEB.2.20.1612151036340.3470@nanos>
References: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20161214232425.GA13182@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 Dec 2016, Gavin Shan wrote:
> > static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
> > {
> >-	int n, nodes;
> >+	int n, nodes = 0;
> >
> > 	/* Calculate the number of nodes in the supplied affinity mask */
> >-	for (n = 0, nodes = 0; n < num_online_nodes(); n++) {
> >+	for_each_online_node(n)
> > 		if (cpumask_intersects(mask, cpumask_of_node(n))) {
> > 			node_set(n, *nodemsk);
> > 			nodes++;
> > 		}
> >-	}
> >+
> 
> It'd better to keep the brackets so that we needn't add them when adding
> more code into the block next time.

Removing the brackets is outright wrong. See:
  https://marc.info/?l=linux-kernel&m=147351236615103

I'll fix that up when applying the patch.

Thanks,

	tglx
