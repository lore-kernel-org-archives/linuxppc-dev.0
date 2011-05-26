Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8FF8B6F9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 May 2011 13:32:48 +1000 (EST)
Subject: Re: [PATCH 6/8] powerpc 8xx: cascade eoi will be performed by
	generic_handle_irq handler
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <8xx-cascade-eoi@mdm.bga.com>
References: <more-irq-cleanups@mdm.bga.com>  <8xx-cascade-eoi@mdm.bga.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 May 2011 13:32:33 +1000
Message-ID: <1306380753.7481.350.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-25 at 01:34 -0500, Milton Miller wrote:
> The 8xx cpm_cascade was calling irq_eoi for the cascaded irq,
> but that will already have been called by the handle_fasteoi_irq
> that generic_handle_irq will call.  The handler is set in
> arch/powerpc/sysdev/cpm1.c by the host map routine.

No it won't unless I'm missing something. The flow handler
(handle_fasteoi_irq) is going to be replaced by the chained handler when
mpc8xx_pics_init() calls irq_set_chained_handle(irq, cpm_cascade) no ?

Cheers,
Ben.

> Signed-off-by: Milton Miller <miltonm@bga.com>
> 
> Index: work.git/arch/powerpc/platforms/8xx/m8xx_setup.c
> ===================================================================
> --- work.git.orig/arch/powerpc/platforms/8xx/m8xx_setup.c	2011-05-18 22:50:38.983498572 -0500
> +++ work.git/arch/powerpc/platforms/8xx/m8xx_setup.c	2011-05-18 22:52:48.920532258 -0500
> @@ -221,15 +221,9 @@ static void cpm_cascade(unsigned int irq
>  	struct irq_chip *chip;
>  	int cascade_irq;
>  
> -	if ((cascade_irq = cpm_get_irq()) >= 0) {
> -		struct irq_desc *cdesc = irq_to_desc(cascade_irq);
> -
> +	if ((cascade_irq = cpm_get_irq()) >= 0)
>  		generic_handle_irq(cascade_irq);
>  
> -		chip = irq_desc_get_chip(cdesc);
> -		chip->irq_eoi(&cdesc->irq_data);
> -	}
> -
>  	chip = irq_desc_get_chip(desc);
>  	chip->irq_eoi(&desc->irq_data);
>  }
