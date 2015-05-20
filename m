Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7D6B1A0636
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 05:37:53 +1000 (AEST)
Date: Wed, 20 May 2015 20:34:26 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [Patch v2 08/14] genirq: Introduce helper function
 irq_data_get_affinity_mask()
Message-ID: <20150520193426.GT2067@n2100.arm.linux.org.uk>
References: <1432114845-24304-1-git-send-email-jiang.liu@linux.intel.com>
 <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432114845-24304-9-git-send-email-jiang.liu@linux.intel.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andreas Larsson <andreas@gaisler.com>, linux-mips@linux-mips.org,
 Kevin Cernekee <cernekee@gmail.com>, linux-ia64@vger.kernel.org,
 Brian Gerst <brgerst@gmail.com>, David Daney <david.daney@cavium.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Christoph Lameter <cl@linux.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 bob picco <bpicco@meloft.net>, linux-am33-list@redhat.com,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 linux-sh@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@kernel.org>,
 linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Matt Turner <mattst88@gmail.com>, Aleksey Makarov <aleksey.makarov@auriga.com>,
 Fenghua Yu <fenghua.yu@intel.com>, James Hogan <james.hogan@imgtec.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Steven Miao <realmz6@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-xtensa@linux-xtensa.org,
 Rusty Russell <rusty@rustcorp.com.au>,
 adi-buildroot-devel@lists.sourceforge.net, Jonas Gorski <jogo@openwrt.org>,
 Simon Horman <horms@verge.net.au>, Borislav Petkov <bp@alien8.de>,
 Anton Blanchard <anton@samba.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>,
 linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Juergen Gross <jgross@suse.com>,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 linux-pci@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, David Vrabel <david.vrabel@citrix.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Tejun Heo <tj@kernel.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 20, 2015 at 05:40:39PM +0800, Jiang Liu wrote:
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index 350f188c92d2..baf8edebe26f 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -140,7 +140,7 @@ int __init arch_probe_nr_irqs(void)
>  static bool migrate_one_irq(struct irq_desc *desc)
>  {
>  	struct irq_data *d = irq_desc_get_irq_data(desc);
> -	const struct cpumask *affinity = d->affinity;
> +	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
>  	struct irq_chip *c;
>  	bool ret = false;
>  
> @@ -160,7 +160,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
>  	if (!c->irq_set_affinity)
>  		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
>  	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
> -		cpumask_copy(d->affinity, affinity);
> +		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
>  
>  	return ret;
>  }

> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 43581e166298..2eb82257aaee 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -650,6 +650,18 @@ static inline int irq_data_get_node(struct irq_data *d)
>  	return irq_common_data_get_node(d->common);
>  }
>  
> +static inline struct cpumask *irq_get_affinity_mask(int irq)
> +{
> +	struct irq_data *d = irq_get_irq_data(irq);
> +
> +	return d ? d->affinity : NULL;
> +}
> +
> +static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
> +{
> +	return d->affinity;
> +}
> +
>  unsigned int arch_dynirq_lower_bound(unsigned int from);
>  
>  int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,

For the above only,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
