Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F22452C0201
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 16:33:09 +1000 (EST)
Message-ID: <1343025161.2957.22.camel@pasglop>
Subject: More irqdomain problems (Was: next/mmotm unbootable on G5: irqdomain)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 23 Jul 2012 16:32:41 +1000
In-Reply-To: <1343011543.2957.2.camel@pasglop>
References: <alpine.LSU.2.00.1207211911160.1585@eggly.anvils>
 <1343011543.2957.2.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Hugh Dickins <hughd@google.com>,
 linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
 ul Mundt <lethal@linux-sh.org>, Rob Herring <rob.herring@calxeda.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allright, another one Grant:

unsigned int irq_find_mapping(struct irq_domain *domain,
			      irq_hw_number_t hwirq)
{
	struct irq_data *data;

	/* Look for default domain if nececssary */
	if (domain == NULL)
		domain = irq_default_domain;
	if (domain == NULL)
		return 0;

	switch (domain->revmap_type) {
	case IRQ_DOMAIN_MAP_LEGACY:
		return irq_domain_legacy_revmap(domain, hwirq);
	case IRQ_DOMAIN_MAP_LINEAR:
		return irq_linear_revmap(domain, hwirq);
	case IRQ_DOMAIN_MAP_TREE:
		rcu_read_lock();
		data = radix_tree_lookup(&domain->revmap_data.tree, hwirq);
		rcu_read_unlock();
		if (data)
			return data->irq;
-               break;
+               return 0;
	case IRQ_DOMAIN_MAP_NOMAP:

Please, stick a proper commit message and my s-o-b and see if you can fix
your tree before you ask Linus to pull because that's not pretty on any
pseries .... irq_find_mapping() does get called for all interrupt the
first time it's mapped to check if there's a pre-existing mapping, so
the case of the thing being unpopulated is absolutely legit.

the NOMAP case has a similar dubious exit case but since I'm not that
familiar with NOMAP I haven't touched it.

Cheers,
Ben.
