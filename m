Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C981B6F59
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 May 2011 05:14:29 +1000 (EST)
Received: by iwc10 with SMTP id 10so904162iwc.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 12:14:27 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <72549d3e9897a80a25e83c873b970463d12e30f0.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
	<72549d3e9897a80a25e83c873b970463d12e30f0.1305092637.git.miltonm@bga.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 11 May 2011 21:13:56 +0200
Message-ID: <BANLkTimCMsOY8FvtAA_ahjwH1VuLaEHMaQ@mail.gmail.com>
Subject: Re: [PATCH 33/37] powerpc: spider-pic: get pic from chip_data instead
	of irq_map
To: Milton Miller <miltonm@bga.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 11, 2011 at 7:30 AM, Milton Miller <miltonm@bga.com> wrote:
> Building on Grant's efforts to remove the irq_map array, this patch
> moves spider-pics use of virq_to_host() to use irq_data_get_chip_data
> and sets the irq chip data in the map call, like most other interrupt
> controllers in powerpc.

Looks good to me.

g.

>
> Signed-off-by: Milton Miller <miltonm@bga.com>
> ---
> ---
> =A0arch/powerpc/platforms/cell/spider-pic.c | =A0 13 +++++++------
> =A01 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/platforms/cell/spider-pic.c b/arch/powerpc/plat=
forms/cell/spider-pic.c
> index 34d2b99..442c28c 100644
> --- a/arch/powerpc/platforms/cell/spider-pic.c
> +++ b/arch/powerpc/platforms/cell/spider-pic.c
> @@ -68,9 +68,9 @@ struct spider_pic {
> =A0};
> =A0static struct spider_pic spider_pics[SPIDER_CHIP_COUNT];
>
> -static struct spider_pic *spider_virq_to_pic(unsigned int virq)
> +static struct spider_pic *spider_irq_data_to_pic(struct irq_data *d)
> =A0{
> - =A0 =A0 =A0 return virq_to_host(virq)->host_data;
> + =A0 =A0 =A0 return irq_data_get_irq_chip_data(d);
> =A0}
>
> =A0static void __iomem *spider_get_irq_config(struct spider_pic *pic,
> @@ -81,7 +81,7 @@ static void __iomem *spider_get_irq_config(struct spide=
r_pic *pic,
>
> =A0static void spider_unmask_irq(struct irq_data *d)
> =A0{
> - =A0 =A0 =A0 struct spider_pic *pic =3D spider_virq_to_pic(d->irq);
> + =A0 =A0 =A0 struct spider_pic *pic =3D spider_irq_data_to_pic(d);
> =A0 =A0 =A0 =A0void __iomem *cfg =3D spider_get_irq_config(pic, irqd_to_h=
wirq(d));
>
> =A0 =A0 =A0 =A0out_be32(cfg, in_be32(cfg) | 0x30000000u);
> @@ -89,7 +89,7 @@ static void spider_unmask_irq(struct irq_data *d)
>
> =A0static void spider_mask_irq(struct irq_data *d)
> =A0{
> - =A0 =A0 =A0 struct spider_pic *pic =3D spider_virq_to_pic(d->irq);
> + =A0 =A0 =A0 struct spider_pic *pic =3D spider_irq_data_to_pic(d);
> =A0 =A0 =A0 =A0void __iomem *cfg =3D spider_get_irq_config(pic, irqd_to_h=
wirq(d));
>
> =A0 =A0 =A0 =A0out_be32(cfg, in_be32(cfg) & ~0x30000000u);
> @@ -97,7 +97,7 @@ static void spider_mask_irq(struct irq_data *d)
>
> =A0static void spider_ack_irq(struct irq_data *d)
> =A0{
> - =A0 =A0 =A0 struct spider_pic *pic =3D spider_virq_to_pic(d->irq);
> + =A0 =A0 =A0 struct spider_pic *pic =3D spider_irq_data_to_pic(d);
> =A0 =A0 =A0 =A0unsigned int src =3D irqd_to_hwirq(d);
>
> =A0 =A0 =A0 =A0/* Reset edge detection logic if necessary
> @@ -116,7 +116,7 @@ static void spider_ack_irq(struct irq_data *d)
> =A0static int spider_set_irq_type(struct irq_data *d, unsigned int type)
> =A0{
> =A0 =A0 =A0 =A0unsigned int sense =3D type & IRQ_TYPE_SENSE_MASK;
> - =A0 =A0 =A0 struct spider_pic *pic =3D spider_virq_to_pic(d->irq);
> + =A0 =A0 =A0 struct spider_pic *pic =3D spider_irq_data_to_pic(d);
> =A0 =A0 =A0 =A0unsigned int hw =3D irqd_to_hwirq(d);
> =A0 =A0 =A0 =A0void __iomem *cfg =3D spider_get_irq_config(pic, hw);
> =A0 =A0 =A0 =A0u32 old_mask;
> @@ -171,6 +171,7 @@ static struct irq_chip spider_pic =3D {
> =A0static int spider_host_map(struct irq_host *h, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw_number_t hw)
> =A0{
> + =A0 =A0 =A0 irq_set_chip_data(virq, h->host_data);
> =A0 =A0 =A0 =A0irq_set_chip_and_handler(virq, &spider_pic, handle_level_i=
rq);
>
> =A0 =A0 =A0 =A0/* Set default irq type */
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
