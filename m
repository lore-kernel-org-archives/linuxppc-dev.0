Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJfP66TvdzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 11:40:10 +1100 (AEDT)
Message-ID: <1486600803.3401.9.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/irq: Improve/fix migrate_irqs()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Thu, 09 Feb 2017 11:40:03 +1100
In-Reply-To: <874m059f00.fsf@concordia.ellerman.id.au>
References: <1486427804.4850.104.camel@kernel.crashing.org>
 <874m059f00.fsf@concordia.ellerman.id.au>
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

On Wed, 2017-02-08 at 21:02 +1100, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > migrate_irqs() is used by some platforms to migrate interrupts
> > away from a CPU about to be offlined.
> > 
> > The current implementation had various issues such as not taking
> > the descriptor lock before manipulating it.
> 
> ... and not checking for a NULL chip (but presumably that's never
> happened), and always calling irq_set_affinity() even for IRQs not on
> the CPU.
> 
> But, any reason we can't use irq_migrate_all_off_this_cpu() ?
> Which is in generic code.

Nope, I didn't notice it. I'll give that a spin.

Cheers,
Ben.
