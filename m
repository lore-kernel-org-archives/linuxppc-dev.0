Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6FF7DDF01
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 04:02:22 +1100 (EST)
Date: Wed, 19 Mar 2008 12:02:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Mike Hench <mhench@engagenet.com>
Subject: Re: [PATCH] MPC8313 NAND fixes
Message-ID: <20080319170210.GD7962@ld0162-tx32.am.freescale.net>
References: <6629C06B144F5C4098DFF95C4FF9DAF702BA1D02@mailsrv.engagenet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6629C06B144F5C4098DFF95C4FF9DAF702BA1D02@mailsrv.engagenet.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2008 at 10:28:19AM -0500, Mike Hench wrote:
> 
> From: Mike Hench 
> Sent: Wednesday, March 19, 2008 10:22 AM
> To: 'mhench@wi.rr.com'
> Subject: [PATCH] MPC813 NAND fixes

This patch is whitespace-mangled.  Also, please don't post HTML.

> -           unsigned int irq_status; /* status read from LTESR by irq
> handler */
> 
> +          volatile unsigned int irq_status; /* status read from LTESR
> by irq handler */

This change is not needed; both out_be32() and wait_event() act as
optimization barriers.

> @@ -379,13 +379,13 @@ static int fsl_elbc_run_command(struct m
> 
>                      in_be32(&lbc->fbar), in_be32(&lbc->fpar),
> 
>                      in_be32(&lbc->fbcr), priv->bank);
> 
>  
> 
> +          ctrl->irq_status = 0;
> 
>             /* execute special operation */
> 
>             out_be32(&lbc->lsor, priv->bank);
> 
>  
> 
>             /* wait for FCM complete flag or timeout */
> 
> -           ctrl->irq_status = 0;

ACK this change.

>             wait_event_timeout(ctrl->irq_wait, ctrl->irq_status,
> 
> -                              FCM_TIMEOUT_MSECS * HZ/1000);
> 
> +                             (FCM_TIMEOUT_MSECS * HZ)/1000);

This change is a no-op.  Multiplication and division are evaluated at the
same precedence, left-to-right.

>             if (mtd->writesize == 512) {
> 
>                         priv->page_size = 0;
> 
> -                       clrbits32(&lbc->bank[priv->bank].or,
> ~OR_FCM_PGS);
> 
> +                      clrbits32(&lbc->bank[priv->bank].or, OR_FCM_PGS);

D'oh!  Thanks for finding this.
ACK this change.

> -           /* The default u-boot configuration on MPC8313ERDB causes
> errors;
> 
> -           * more delay is needed.  This should be safe for other
> boards
> 
> -           * as well.
> 
> -           */
> 
> -           setbits32(&lbc->bank[priv->bank].or, 0x70);

And this one.

-Scott
