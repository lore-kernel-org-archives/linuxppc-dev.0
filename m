Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C0A4B2C0786
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 06:54:19 +1000 (EST)
Date: Tue, 25 Jun 2013 15:54:03 -0500
From: Scott Wood <scottwood@freescale.com>
To: Xufeng Zhang <xufengzhang.main@gmail.com>
Subject: Re: mpc85xx_edac.c: Should the mpc85xx_l2_isr be shared irqs?
Message-ID: <20130625205403.GA10709@home.buserror.net>
References: <CA+=dFzhEf12XKxL5=M5vhtoYin9Ct=RucNCh=v-FVQUSPrkOww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CA+=dFzhEf12XKxL5=M5vhtoYin9Ct=RucNCh=v-FVQUSPrkOww@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 18, 2012 at 05:00:29PM +0800, Xufeng Zhang wrote:
> Hi All,
> 
> I detected below error when booting p1021mds after enabled EDAC feature:
> EDAC MC: Ver: 2.1.0 Jul 17 2012
> Freescale(R) MPC85xx EDAC driver, (C) 2006 Montavista Software
> EDAC MC0: Giving out device to 'MPC85xx_edac' 'mpc85xx_mc_err': DEV mpc85xx_mc_e
> rr
> IRQ 45/[EDAC] MC err: IRQF_DISABLED is not guaranteed on shared IRQs
> MPC85xx_edac acquired irq 45 for MC
> MPC85xx_edac MC err registered
> EDAC DEVICE0: Giving out device to module 'MPC85xx_edac' controller 'mpc85xx_l2_
> err': DEV 'mpc85xx_l2_err' (INTERRUPT)
> mpc85xx_l2_err_probe: Unable to requiest irq 45 for MPC85xx L2 err
> 
> Then kernel hang.
> 
> When request irq for l2-cache, since it share the same irq with memory
> controller,
> I think the code should be:
>  			printk(KERN_ERR
> 
> 
> 
> 
> 
> Thanks,
> Xufeng Zhang
> 
> 
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -577,7 +577,7 @@ static int __devinit mpc85xx_l2_err_probe(struct
> of_device *op,
>  	if (edac_op_state == EDAC_OPSTATE_INT) {
>  		pdata->irq = irq_of_parse_and_map(op->node, 0);
>  		res = devm_request_irq(&op->dev, pdata->irq,
> -				       mpc85xx_l2_isr, IRQF_DISABLED,
> +				       mpc85xx_l2_isr, IRQF_DISABLED | IRQF_SHARED,
>  				       "[EDAC] L2 err", edac_dev);
>  		if (res < 0) {

Sorry for the delayed response...  That "IRQF_DISABLED is not guaranteed"
message was removed in v2.6.35 (along with the rest of IRQF_DISABLED
support) which was almost two years old even back when your e-mail was
sent.  Even back then, as far as I can tell your patch would be
introducing, not fixing, that message.

It does look like this interrupt should be shared, though.

The deprecated IRQF_DISABLED should be removed.

-Scott
