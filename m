Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 790A3B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 12:28:18 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDD41DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 12:28:17 +1000 (EST)
Message-Id: <7AF37DF7-6BC8-4CAD-911C-8EC93B0CB199@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
In-Reply-To: <20090805194112.GA18204@www.tglx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] powerpc/ipic: unmask all interrupt sources
Date: Thu, 6 Aug 2009 21:26:48 -0500
References: <20090805194112.GA18204@www.tglx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 5, 2009, at 2:41 PM, Sebastian Andrzej Siewior wrote:

> in case the interrupt controller was used in an earlier life then it  
> is
> possible it is that some of its sources were used and are still  
> unmask.
> If the (unmasked) device is active and is creating interrupts (or one
> interrupts was pending since the interrupts were disabled) then the  
> boot
> process "ends" very soon. Once external interrupts are enabled, we  
> land in
> -> do_IRQ
>  -> call ppc_md.get_irq()
>     -> ipic_read() gets the source number
>     -> irq_linear_revmap(source)
>        -> revmap[source] == NO_IRQ
>           -> irq_find_mapping(source) returns NO_IRQ because no source
>              is registered
>  -> source is NO_IRQ, ppc_spurious_interrupts gets incremented, no
>     further action.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> This solves my kexec problem I had earlier. I could disable the device
> in ->shutdown path but the device in question could been used in the
> boot loader. Usually one gets the "nobody cared" message for unhandled
> interrupts but in this (rare) case nothing happens and box stands  
> still.
>
> arch/powerpc/sysdev/ipic.c |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)


applied to next

- k
