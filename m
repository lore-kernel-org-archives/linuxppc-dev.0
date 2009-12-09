Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32EA1B6F1B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 07:43:27 +1100 (EST)
Subject: Re: [PATCH v2] cpm2_pic: Allow correct flow_types for port C
	interrupts
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4B1EF3E9.8050005@elphinstone.net>
Date: Wed, 9 Dec 2009 14:43:12 -0600
Message-Id: <5210EB9D-2775-48B3-AF50-5D7ABFA992A6@kernel.crashing.org>
References: <4B1EF3E9.8050005@elphinstone.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Mark Ware <mware@elphinstone.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 8, 2009, at 6:48 PM, Mark Ware wrote:

> Port C interrupts can be either falling edge, or either edge.
> Other external interrupts are either falling edge or active low.
>=20
> Signed-Off-By: Mark Ware <mware@elphinstone.net>
> ---
> Changed in v2:
> - Disallow rising edge only on Port C=20
>=20
> arch/powerpc/sysdev/cpm2_pic.c |   30 +++++++++++++++++++++++-------
> 1 files changed, 23 insertions(+), 7 deletions(-)

Anton, mind taking a look at this for me.

- k

>=20
> diff --git a/arch/powerpc/sysdev/cpm2_pic.c =
b/arch/powerpc/sysdev/cpm2_pic.c
> index 78f1f7c..eba5f24 100644
> --- a/arch/powerpc/sysdev/cpm2_pic.c
> +++ b/arch/powerpc/sysdev/cpm2_pic.c
> @@ -141,13 +141,29 @@ static int cpm2_set_irq_type(unsigned int virq, =
unsigned int flow_type)
> 	struct irq_desc *desc =3D get_irq_desc(virq);
> 	unsigned int vold, vnew, edibit;
>=20
> -	if (flow_type =3D=3D IRQ_TYPE_NONE)
> -		flow_type =3D IRQ_TYPE_LEVEL_LOW;
> -
> -	if (flow_type & IRQ_TYPE_EDGE_RISING) {
> -		printk(KERN_ERR "CPM2 PIC: sense type 0x%x not =
supported\n",
> -			flow_type);
> -		return -EINVAL;
> +	/* Port C interrupts are either IRQ_TYPE_EDGE_FALLING or
> +	 * IRQ_TYPE_EDGE_BOTH (default).  All others are =
IRQ_TYPE_EDGE_FALLING
> +	 * or IRQ_TYPE_LEVEL_LOW (default)
> +	 */
> +	if (src >=3D CPM2_IRQ_PORTC15 && src <=3D CPM2_IRQ_PORTC0) {
> +		if (flow_type =3D=3D IRQ_TYPE_NONE)
> +			flow_type =3D IRQ_TYPE_EDGE_BOTH;
> +
> +		if ((flow_type !=3D IRQ_TYPE_EDGE_BOTH) &&=20
> +			(flow_type !=3D IRQ_TYPE_EDGE_FALLING)) {
> +			printk(KERN_ERR "CPM2 PIC: sense type 0x%x not =
supported\n",
> +				flow_type);
> +			return -EINVAL;
> +		}
> +	} else {
> +		if (flow_type =3D=3D IRQ_TYPE_NONE)
> +			flow_type =3D IRQ_TYPE_LEVEL_LOW;
> +
> +		if (flow_type & (IRQ_TYPE_EDGE_RISING | =
IRQ_TYPE_LEVEL_HIGH)) {
> +			printk(KERN_ERR "CPM2 PIC: sense type 0x%x not =
supported\n",
> +				flow_type);
> +			return -EINVAL;
> +		}
> 	}
>=20
> 	desc->status &=3D ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
> --=20
> 1.5.6.5
