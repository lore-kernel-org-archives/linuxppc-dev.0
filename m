Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D962DB6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Mar 2011 12:57:45 +1100 (EST)
Subject: Re: linux-next: build failure after merge of the Linus' tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20110330110027.b83a1d20.sfr@canb.auug.org.au>
References: <20110330110027.b83a1d20.sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Mar 2011 12:56:43 +1100
Message-ID: <1301450203.2402.716.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-next@vger.kernel.org,
	Linus <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-03-30 at 11:00 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the Linus' tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> kernel/irq/chip.c: In function 'handle_edge_eoi_irq':
> kernel/irq/chip.c:517: warning: label 'out_unlock' defined but not used
> kernel/irq/chip.c:503: error: label 'out_eoi' used but not defined

There's a fix in tip/irq/urgent ...

Cheers,
Ben.

> Caused by commit 0521c8fbb3da ("genirq: Provide edge_eoi flow handler")
> which was clearly not even built with CONFIG_IRQ_EDGE_EOI_HANDLER defined.
> 
> I applied this fixup patch:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 30 Mar 2011 10:55:12 +1100
> Subject: [PATCH] genirq: fix CONFIG_IRQ_EDGE_EOI_HANDLER build
> 
> Fixes these errors:
> 
> kernel/irq/chip.c: In function 'handle_edge_eoi_irq':
> kernel/irq/chip.c:517: warning: label 'out_unlock' defined but not used
> kernel/irq/chip.c:503: error: label 'out_eoi' used but not defined
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  kernel/irq/chip.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 616ec1c..1dafc86 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -514,7 +514,7 @@ void handle_edge_eoi_irq(unsigned int irq, struct irq_desc *desc)
>  	} while ((desc->istate & IRQS_PENDING) &&
>  		 !irqd_irq_disabled(&desc->irq_data));
>  
> -out_unlock:
> +out_eoi:
>  	chip->irq_eoi(&desc->irq_data);
>  	raw_spin_unlock(&desc->lock);
>  }
> -- 
> 1.7.4.1
> 
> 
