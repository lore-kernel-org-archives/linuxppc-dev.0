Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS33p2glfzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 17:36:22 +1000 (AEST)
Message-ID: <1502264039.2563.38.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: xive: ensure active irqd when setting affinity
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 09 Aug 2017 17:33:59 +1000
In-Reply-To: <87a839nu5z.fsf@concordia.ellerman.id.au>
References: <20170803013822.GD28905@us.ibm.com>
 <87zibamjfi.fsf@concordia.ellerman.id.au>
 <20170809000034.GB17162@us.ibm.com>
 <87a839nu5z.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-09 at 16:15 +1000, Michael Ellerman wrote:
> I'm not sure I'm convinced. We can't handle every possible case of the
> higher level code calling us in situations we don't expect.
> 
> For example irq_data could be NULL, but we trust the higher level code
> not to do that to us.
> 
> Also I don't see any other driver doing this check.
> 
>   $ git grep irqd_is_started
>   include/linux/irq.h:static inline bool irqd_is_started(struct irq_data *d)
>   kernel/irq/chip.c:      if (irqd_is_started(d)) {
>   kernel/irq/chip.c:      if (irqd_is_started(&desc->irq_data)) {
>   kernel/irq/cpuhotplug.c:        if (irqd_is_per_cpu(d) || !irqd_is_started(d) || !irq_needs_fixup(d)) {

irqd_is_started is brand new so you won't find any :-)

For most cases the problem is a non-issue. Due to how xive works, it's
more of a problem for us because a non-started interrupt has no
targetting information at all.

So this is *somewhat* related to xive internal and I'd rather have
that sanity check in there.

Cheers,
Ben.
