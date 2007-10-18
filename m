Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8FDBADDE26
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 11:45:18 +1000 (EST)
Date: Wed, 17 Oct 2007 18:45:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] synchronize_irq needs a barrier
Message-Id: <20071017184512.a1c647b2.akpm@linux-foundation.org>
In-Reply-To: <1192670742.12879.5.camel@pasglop>
References: <1192670742.12879.5.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 18 Oct 2007 11:25:42 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> synchronize_irq needs at the very least a compiler barrier and a
> read barrier on SMP,

Why?

> but there are enough cases around where a
> write barrier is also needed and it's not a hot path so I prefer
> using a full smp_mb() here.
> 
> It will degrade to a compiler barrier on !SMP.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Index: linux-work/kernel/irq/manage.c
> ===================================================================
> --- linux-work.orig/kernel/irq/manage.c	2007-10-18 11:22:16.000000000 +1000
> +++ linux-work/kernel/irq/manage.c	2007-10-18 11:22:20.000000000 +1000
> @@ -33,6 +33,7 @@ void synchronize_irq(unsigned int irq)
>  	if (irq >= NR_IRQS)
>  		return;
>  
> +	smp_mb();
>  	while (desc->status & IRQ_INPROGRESS)
>  		cpu_relax();
>  }

Anyone reading this code is going to ask "wtf is that for".  It needs a
comment telling them.


mb() is the new lock_kernel().  Sigh.
