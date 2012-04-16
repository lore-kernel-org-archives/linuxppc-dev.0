Return-Path: <glikely@secretlab.ca>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42AFDB700A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 06:14:20 +1000 (EST)
Received: by obbef5 with SMTP id ef5so7868555obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2012 13:14:18 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1334607198-18694-1-git-send-email-grant.likely@secretlab.ca>
References: <1334607198-18694-1-git-send-email-grant.likely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 16 Apr 2012 14:13:57 -0600
Message-ID: <CACxGe6u7EUYqyZ_8tC8PFRHwS+xq7u9+fCJk+UFbrtrV-YJFvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/8xx: Fix NR_IRQ bugs and refactor 8xx
 interrupt controller
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben, I can take these two patches via my irqdomain tree if you prefer.

g.

On Mon, Apr 16, 2012 at 2:13 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> The mpc8xx driver uses a reference to NR_IRQS that is buggy. =A0It uses
> NR_IRQs for the array size of the ppc_cached_irq_mask bitmap, but
> NR_IRQs could be smaller than the number of hardware irqs that
> ppc_cached_irq_mask tracks.
>
> Also, while fixing that problem, it became apparent that the interrupt
> controller only supports 32 interrupt numbers, but it is written as if
> it supports multiple register banks which is more complicated.
>
> This patch pulls out the buggy reference to NR_IRQs and fixes the size
> of the ppc_cached_irq_mask to match the number of HW irqs. =A0It also
> drops the now-unnecessary code since ppc_cached_irq_mask is no longer
> an array.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> =A0arch/powerpc/sysdev/mpc8xx_pic.c | =A0 61 +++++++++++++---------------=
----------
> =A01 file changed, 21 insertions(+), 40 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8x=
x_pic.c
> index d5f5416..91cade8 100644
> --- a/arch/powerpc/sysdev/mpc8xx_pic.c
> +++ b/arch/powerpc/sysdev/mpc8xx_pic.c
> @@ -18,69 +18,47 @@
> =A0extern int cpm_get_irq(struct pt_regs *regs);
>
> =A0static struct irq_domain *mpc8xx_pic_host;
> -#define NR_MASK_WORDS =A0 ((NR_IRQS + 31) / 32)
> -static unsigned long ppc_cached_irq_mask[NR_MASK_WORDS];
> +static unsigned long ppc_cached_irq_mask;
> =A0static sysconf8xx_t __iomem *siu_reg;
>
> =A0int cpm_get_irq(struct pt_regs *regs);
>
> -static void mpc8xx_unmask_irq(struct irq_data *d)
> +static inline unsigned long mpc8xx_irqd_to_bit(struct irq_data *d)
> =A0{
> - =A0 =A0 =A0 int =A0 =A0 bit, word;
> - =A0 =A0 =A0 unsigned int irq_nr =3D (unsigned int)irqd_to_hwirq(d);
> -
> - =A0 =A0 =A0 bit =3D irq_nr & 0x1f;
> - =A0 =A0 =A0 word =3D irq_nr >> 5;
> + =A0 =A0 =A0 return 0x80000000 >> irqd_to_hwirq(d);
> +}
>
> - =A0 =A0 =A0 ppc_cached_irq_mask[word] |=3D (1 << (31-bit));
> - =A0 =A0 =A0 out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
> +static void mpc8xx_unmask_irq(struct irq_data *d)
> +{
> + =A0 =A0 =A0 ppc_cached_irq_mask |=3D mpc8xx_irqd_to_bit(d);
> + =A0 =A0 =A0 out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask);
> =A0}
>
> =A0static void mpc8xx_mask_irq(struct irq_data *d)
> =A0{
> - =A0 =A0 =A0 int =A0 =A0 bit, word;
> - =A0 =A0 =A0 unsigned int irq_nr =3D (unsigned int)irqd_to_hwirq(d);
> -
> - =A0 =A0 =A0 bit =3D irq_nr & 0x1f;
> - =A0 =A0 =A0 word =3D irq_nr >> 5;
> -
> - =A0 =A0 =A0 ppc_cached_irq_mask[word] &=3D ~(1 << (31-bit));
> - =A0 =A0 =A0 out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
> + =A0 =A0 =A0 ppc_cached_irq_mask &=3D ~mpc8xx_irqd_to_bit(d);
> + =A0 =A0 =A0 out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask);
> =A0}
>
> =A0static void mpc8xx_ack(struct irq_data *d)
> =A0{
> - =A0 =A0 =A0 int =A0 =A0 bit;
> - =A0 =A0 =A0 unsigned int irq_nr =3D (unsigned int)irqd_to_hwirq(d);
> -
> - =A0 =A0 =A0 bit =3D irq_nr & 0x1f;
> - =A0 =A0 =A0 out_be32(&siu_reg->sc_sipend, 1 << (31-bit));
> + =A0 =A0 =A0 out_be32(&siu_reg->sc_sipend, mpc8xx_irqd_to_bit(d));
> =A0}
>
> =A0static void mpc8xx_end_irq(struct irq_data *d)
> =A0{
> - =A0 =A0 =A0 int bit, word;
> - =A0 =A0 =A0 unsigned int irq_nr =3D (unsigned int)irqd_to_hwirq(d);
> -
> - =A0 =A0 =A0 bit =3D irq_nr & 0x1f;
> - =A0 =A0 =A0 word =3D irq_nr >> 5;
> -
> - =A0 =A0 =A0 ppc_cached_irq_mask[word] |=3D (1 << (31-bit));
> - =A0 =A0 =A0 out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask[word]);
> + =A0 =A0 =A0 ppc_cached_irq_mask |=3D mpc8xx_irqd_to_bit(d);
> + =A0 =A0 =A0 out_be32(&siu_reg->sc_simask, ppc_cached_irq_mask);
> =A0}
>
> =A0static int mpc8xx_set_irq_type(struct irq_data *d, unsigned int flow_t=
ype)
> =A0{
> - =A0 =A0 =A0 if (flow_type & IRQ_TYPE_EDGE_FALLING) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_number_t hw =3D (unsigned int)irqd_t=
o_hwirq(d);
> + =A0 =A0 =A0 /* only external IRQ senses are programmable */
> + =A0 =A0 =A0 if ((flow_type & IRQ_TYPE_EDGE_FALLING) && !(irqd_to_hwirq(=
d) & 1)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int siel =3D in_be32(&siu_reg->sc=
_siel);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* only external IRQ senses are programmabl=
e */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((hw & 1) =3D=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 siel |=3D (0x80000000 >> hw=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&siu_reg->sc_siel,=
 siel);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __irq_set_handler_locked(d-=
>irq, handle_edge_irq);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 siel |=3D mpc8xx_irqd_to_bit(d);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&siu_reg->sc_siel, siel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __irq_set_handler_locked(d->irq, handle_edg=
e_irq);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -132,6 +110,9 @@ static int mpc8xx_pic_host_xlate(struct irq_domain *h=
, struct device_node *ct,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQ_TYPE_EDGE_FALLING,
> =A0 =A0 =A0 =A0};
>
> + =A0 =A0 =A0 if (intspec[0] > 0x1f)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0*out_hwirq =3D intspec[0];
> =A0 =A0 =A0 =A0if (intsize > 1 && intspec[1] < 4)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*out_flags =3D map_pic_senses[intspec[1]];
> --
> 1.7.9.5
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
