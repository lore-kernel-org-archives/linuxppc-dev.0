Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJGww6kyzzDqG9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 21:02:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/irq: Improve/fix migrate_irqs()
In-Reply-To: <1486427804.4850.104.camel@kernel.crashing.org>
References: <1486427804.4850.104.camel@kernel.crashing.org>
Date: Wed, 08 Feb 2017 21:02:55 +1100
Message-ID: <874m059f00.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> migrate_irqs() is used by some platforms to migrate interrupts
> away from a CPU about to be offlined.
>
> The current implementation had various issues such as not taking
> the descriptor lock before manipulating it.

... and not checking for a NULL chip (but presumably that's never
happened), and always calling irq_set_affinity() even for IRQs not on
the CPU.

But, any reason we can't use irq_migrate_all_off_this_cpu() ?
Which is in generic code.

cheers
