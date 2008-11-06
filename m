Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00F68DDF6A
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Nov 2008 08:35:54 +1100 (EST)
Date: Thu, 6 Nov 2008 13:35:24 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/1] irq: Maintain user set affinity
Message-Id: <20081106133524.75588d96.akpm@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0811041030520.25054@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0811041030520.25054@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 4 Nov 2008 10:31:05 -0600 (CST)
Kumar Gala <galak@kernel.crashing.org> wrote:

> >From 819ad3ed4660f4238e053728a8b5aa93d22b13d7 Mon Sep 17 00:00:00 2001
> From: Kumar Gala <galak@kernel.crashing.org>
> Date: Tue, 4 Nov 2008 10:13:53 -0600
> Subject: [PATCH 1/1] irq: Maintain user set affinity
> 
> This addresses a regression in that if a user specified an affinity
> for an interrupt that affinity information would get reset between
> a request_irq(), free_irq() and request_irq() for the same irq.
> 
> On example of this is bringing up an ethernet interface, taking
> it down and bringing it back up again.
> 
> Instead of always using the irq_default_affinity we use the
> previous setting of the IRQs affinity with the assumption that
> at boot the IRQs affinity will be set to irq_default_affinity.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  kernel/irq/manage.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index c498a1b..ea7d11b 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -115,9 +115,12 @@ int irq_select_affinity(unsigned int irq)
>  	if (!irq_can_set_affinity(irq))
>  		return 0;
> 
> -	cpus_and(mask, cpu_online_map, irq_default_affinity);
> -
>  	desc = irq_to_desc(irq);
> +
> +	mask = desc->affinity;
> +
> +	cpus_and(mask, cpu_online_map, mask);
> +
>  	desc->affinity = mask;
>  	desc->chip->set_affinity(irq, mask);
> 

Are you able to identify when this regression occurred?  It isn't
immediately obvious to me.

If the regression is present in 2.6.27 or earlier, do you think we
should backport the fix?  If so, a different patch would be needed due
to the presence of

commit 08678b0841267c1d00d771fe01548d86043d065e
Author: Yinghai Lu <yhlu.kernel@gmail.com>
Date:   Tue Aug 19 20:50:05 2008 -0700

    generic: sparse irqs: use irq_desc() together with dyn_array, instead of irq_desc[]
