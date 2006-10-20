Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 7795067B61
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 13:02:51 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k9K32n7a006250
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 20:02:49 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k9K32kcV000999
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 22:02:48 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] qe_ic: Do a sync when masking interrupts.
Date: Fri, 20 Oct 2006 11:03:30 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D206EE4@zch01exm20.fsl.freescale.net>
In-Reply-To: <20061019180308.GA24256@ld0162-tx32.am.freescale.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Wood Scott-B07421" <scottwood@freescale.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of Scott
> Wood
> Sent: Friday, October 20, 2006 2:03 AM
> To: linuxppc-dev@ozlabs.org
> Subject: [PATCH] qe_ic: Do a sync when masking interrupts.
>=20
> This patch causes a sync do be done after masking a QE interrupt, to
> ensure that the masking has completed before interrupts are enabled.
> This allows the masking of the cascade IRQ to be removed without
causing
> spurious interrupts.
>=20
> The mask_and_ack function is also removed and set to the mask
function,
> as the two are identical.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/sysdev/qe_lib/qe_ic.c |   34
+++++++---------------------------
>  1 files changed, 7 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c
> b/arch/powerpc/sysdev/qe_lib/qe_ic.c
> index 6995f51..d96e48d 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
> @@ -222,24 +222,12 @@ static void qe_ic_mask_irq(unsigned int
>  	temp =3D qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
>  	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
>  		    temp & ~qe_ic_info[src].mask);
> -
> -	spin_unlock_irqrestore(&qe_ic_lock, flags);
> -}
> -
> -static void qe_ic_mask_irq_and_ack(unsigned int virq)
> -{
> -	struct qe_ic *qe_ic =3D qe_ic_from_irq(virq);
> -	unsigned int src =3D virq_to_hw(virq);
> -	unsigned long flags;
> -	u32 temp;
> -
> -	spin_lock_irqsave(&qe_ic_lock, flags);
> -
> -	temp =3D qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
> -	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
> -		    temp & ~qe_ic_info[src].mask);
> -
> -	/* There is nothing to do for ack here, ack is handled in ISR */
> +
> +	/* Flush the above write before enabling interrupts;
> +	 * otherwise, spurious interrupts will sometimes
> +	 * happen
> +	 */
> +	mb();
>=20
>  	spin_unlock_irqrestore(&qe_ic_lock, flags);
>  }
> @@ -248,7 +236,7 @@ static struct irq_chip qe_ic_irq_chip =3D
>  	.typename =3D " QEIC  ",
>  	.unmask =3D qe_ic_unmask_irq,
>  	.mask =3D qe_ic_mask_irq,
> -	.mask_ack =3D qe_ic_mask_irq_and_ack,
> +	.mask_ack =3D qe_ic_mask_irq,
>  };
>=20
>  static int qe_ic_host_match(struct irq_host *h, struct device_node
*node)
> @@ -331,8 +319,6 @@ unsigned int qe_ic_get_high_irq(struct q
>  	return irq_linear_revmap(qe_ic->irqhost, irq);
>  }
>=20
> -/* FIXME: We mask all the QE Low interrupts while handling.  We
should
> - * let other interrupt come in, but BAD interrupts are generated */
>  void fastcall qe_ic_cascade_low(unsigned int irq, struct irq_desc
*desc)
>  {
>  	struct qe_ic *qe_ic =3D desc->handler_data;
> @@ -340,14 +326,10 @@ void fastcall qe_ic_cascade_low(unsigned
>=20
>  	unsigned int cascade_irq =3D qe_ic_get_low_irq(qe_ic);
>=20
> -	chip->mask_ack(irq);
>  	if (cascade_irq !=3D NO_IRQ)
>  		generic_handle_irq(cascade_irq);
> -	chip->unmask(irq);
>  }
>=20
> -/* FIXME: We mask all the QE High interrupts while handling.  We
should
> - * let other interrupt come in, but BAD interrupts are generated */
>  void fastcall qe_ic_cascade_high(unsigned int irq, struct irq_desc
*desc)
>  {
>  	struct qe_ic *qe_ic =3D desc->handler_data;
> @@ -355,10 +337,8 @@ void fastcall qe_ic_cascade_high(unsigne
>=20
>  	unsigned int cascade_irq =3D qe_ic_get_high_irq(qe_ic);
>=20
> -	chip->mask_ack(irq);
>  	if (cascade_irq !=3D NO_IRQ)
>  		generic_handle_irq(cascade_irq);
> -	chip->unmask(irq);
>  }
>=20
>  void __init qe_ic_init(struct device_node *node, unsigned int flags)
> --
> 1.4.2.3
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
