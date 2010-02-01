Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 973FBB7DB3
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Feb 2010 16:21:50 +1100 (EST)
Subject: Re: [PATCH] powerpc: Reduce footprint of irq_stat
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100112105642.GI12666@kryten>
References: <20100112105642.GI12666@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 01 Feb 2010 16:21:44 +1100
Message-ID: <1265001704.8287.31.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> +typedef struct {
> +	unsigned int __softirq_pending;
> +} ____cacheline_aligned irq_cpustat_t;
> +
> +DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
> +
> +#define __ARCH_IRQ_STAT
> +
> +#define local_softirq_pending()	__get_cpu_var(irq_stat).__softirq_pending
> +
> +static inline void ack_bad_irq(unsigned int irq)
> +{
> +	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
> +}

Looks like some unrelated gunk slipped into this patch :-)

Cheers,
Ben.
