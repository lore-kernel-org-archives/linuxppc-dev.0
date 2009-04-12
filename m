Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 2095FDE1B4
	for <linuxppc-dev@ozlabs.org>; Sun, 12 Apr 2009 16:18:27 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1008924yxg.39
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Apr 2009 23:18:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090403225517.26D941870050@mail94-sin.bigfish.com>
References: <20090403225517.26D941870050@mail94-sin.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 12 Apr 2009 00:18:11 -0600
Message-ID: <fa686aa40904112318g9fb75abwc93b4700b2d9d679@mail.gmail.com>
Subject: Re: [PATCH] Powerpc: Xilinx: Intc: Fix level irqs which have
	duplicates
To: John Linn <john.linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think this looks good.  I'll need to pull it into my tree and try it out.

g.

On Fri, Apr 3, 2009 at 4:55 PM, John Linn <john.linn@xilinx.com> wrote:
> The interrupt controller was not handling level interrupts correctly
> such that duplicate interrupts were happening. This fixes the problem
> and adds edge type interrupts which are needed in Xilinx hardware.
>
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---
> =A0arch/powerpc/sysdev/xilinx_intc.c | =A0112 +++++++++++++++++++++++++++=
+++++++---
> =A01 files changed, 103 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/xilinx_intc.c b/arch/powerpc/sysdev/xili=
nx_intc.c
> index a22e1a2..7c99a1e 100644
> --- a/arch/powerpc/sysdev/xilinx_intc.c
> +++ b/arch/powerpc/sysdev/xilinx_intc.c
> @@ -41,8 +41,30 @@
>
> =A0static struct irq_host *master_irqhost;
>
> +/* The following table allows the interrupt type, edge or level,
> + * to be cached after being read from the device tree until the interrup=
t
> + * is mapped
> + */
> +static int xilinx_intc_typetable[32];
> +
> +/* Map the interrupt type from the device tree to the interrupt types
> + * used by the interrupt subsystem
> + */
> +static unsigned char xilinx_intc_map_senses[] =3D {
> + =A0 =A0 =A0 IRQ_TYPE_EDGE_RISING,
> + =A0 =A0 =A0 IRQ_TYPE_EDGE_FALLING,
> + =A0 =A0 =A0 IRQ_TYPE_LEVEL_HIGH,
> + =A0 =A0 =A0 IRQ_TYPE_LEVEL_LOW,
> +};
> +
> =A0/*
> - * IRQ Chip operations
> + * The interrupt controller is setup such that it doesn't work well with
> + * the level interrupt handler in the kernel because the handler acks th=
e
> + * interrupt before calling the application interrupt handler. To deal w=
ith
> + * that, we use 2 different irq chips so that different functions can be
> + * used for level and edge type interrupts.
> + *
> + * IRQ Chip common (across level and edge) operations
> =A0*/
> =A0static void xilinx_intc_mask(unsigned int virq)
> =A0{
> @@ -52,15 +74,54 @@ static void xilinx_intc_mask(unsigned int virq)
> =A0 =A0 =A0 =A0out_be32(regs + XINTC_CIE, 1 << irq);
> =A0}
>
> -static void xilinx_intc_unmask(unsigned int virq)
> +static int xilinx_intc_set_type(unsigned int virq, unsigned int flow_typ=
e)
> +{
> + =A0 =A0 =A0 struct irq_desc *desc =3D get_irq_desc(virq);
> +
> + =A0 =A0 =A0 desc->status &=3D ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
> + =A0 =A0 =A0 desc->status |=3D flow_type & IRQ_TYPE_SENSE_MASK;
> + =A0 =A0 =A0 if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->status |=3D IRQ_LEVEL;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * IRQ Chip level operations
> + */
> +static void xilinx_intc_level_unmask(unsigned int virq)
> =A0{
> =A0 =A0 =A0 =A0int irq =3D virq_to_hw(virq);
> =A0 =A0 =A0 =A0void * regs =3D get_irq_chip_data(virq);
> =A0 =A0 =A0 =A0pr_debug("unmask: %d\n", irq);
> =A0 =A0 =A0 =A0out_be32(regs + XINTC_SIE, 1 << irq);
> +
> + =A0 =A0 =A0 /* ack level irqs because they can't be acked during
> + =A0 =A0 =A0 =A0* ack function since the handle_level_irq function
> + =A0 =A0 =A0 =A0* acks the irq before calling the inerrupt handler
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 out_be32(regs + XINTC_IAR, 1 << irq);
> +}
> +
> +static struct irq_chip xilinx_intc_level_irqchip =3D {
> + =A0 =A0 =A0 .typename =3D "Xilinx Level INTC",
> + =A0 =A0 =A0 .mask =3D xilinx_intc_mask,
> + =A0 =A0 =A0 .mask_ack =3D xilinx_intc_mask,
> + =A0 =A0 =A0 .unmask =3D xilinx_intc_level_unmask,
> + =A0 =A0 =A0 .set_type =3D xilinx_intc_set_type,
> +};
> +
> +/*
> + * IRQ Chip edge operations
> + */
> +static void xilinx_intc_edge_unmask(unsigned int virq)
> +{
> + =A0 =A0 =A0 int irq =3D virq_to_hw(virq);
> + =A0 =A0 =A0 void *regs =3D get_irq_chip_data(virq);
> + =A0 =A0 =A0 pr_debug("unmask: %d\n", irq);
> + =A0 =A0 =A0 out_be32(regs + XINTC_SIE, 1 << irq);
> =A0}
>
> -static void xilinx_intc_ack(unsigned int virq)
> +static void xilinx_intc_edge_ack(unsigned int virq)
> =A0{
> =A0 =A0 =A0 =A0int irq =3D virq_to_hw(virq);
> =A0 =A0 =A0 =A0void * regs =3D get_irq_chip_data(virq);
> @@ -68,27 +129,60 @@ static void xilinx_intc_ack(unsigned int virq)
> =A0 =A0 =A0 =A0out_be32(regs + XINTC_IAR, 1 << irq);
> =A0}
>
> -static struct irq_chip xilinx_intc_irqchip =3D {
> - =A0 =A0 =A0 .typename =3D "Xilinx INTC",
> +static struct irq_chip xilinx_intc_edge_irqchip =3D {
> + =A0 =A0 =A0 .typename =3D "Xilinx Edge =A0INTC",
> =A0 =A0 =A0 =A0.mask =3D xilinx_intc_mask,
> - =A0 =A0 =A0 .unmask =3D xilinx_intc_unmask,
> - =A0 =A0 =A0 .ack =3D xilinx_intc_ack,
> + =A0 =A0 =A0 .unmask =3D xilinx_intc_edge_unmask,
> + =A0 =A0 =A0 .ack =3D xilinx_intc_edge_ack,
> + =A0 =A0 =A0 .set_type =3D xilinx_intc_set_type,
> =A0};
>
> =A0/*
> =A0* IRQ Host operations
> =A0*/
> +
> +/**
> + * xilinx_intc_xlate - translate virq# from device tree interrupts prope=
rty
> + */
> +static int xilinx_intc_xlate(struct irq_host *h, struct device_node *ct,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 *intspe=
c, unsigned int intsize,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_hw_numb=
er_t *out_hwirq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned in=
t *out_flags)
> +{
> + =A0 =A0 =A0 if (intsize !=3D 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> + =A0 =A0 =A0 /* keep a copy of the interrupt type til the interrupt is m=
apped
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 xilinx_intc_typetable[intspec[0]] =3D xilinx_intc_map_sense=
s[intspec[1]];
> +
> + =A0 =A0 =A0 /* Xilinx uses 2 interrupt entries, the 1st being the h/w
> + =A0 =A0 =A0 =A0* interrupt number, the 2nd being the interrupt type, ed=
ge or level
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 *out_hwirq =3D intspec[0];
> + =A0 =A0 =A0 *out_flags =3D xilinx_intc_map_senses[intspec[1]];
> +
> + =A0 =A0 =A0 return 0;
> +}
> =A0static int xilinx_intc_map(struct irq_host *h, unsigned int virq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_hw=
_number_t irq)
> =A0{
> =A0 =A0 =A0 =A0set_irq_chip_data(virq, h->host_data);
> - =A0 =A0 =A0 set_irq_chip_and_handler(virq, &xilinx_intc_irqchip, handle=
_level_irq);
> - =A0 =A0 =A0 set_irq_type(virq, IRQ_TYPE_NONE);
> +
> + =A0 =A0 =A0 if (xilinx_intc_typetable[irq] =3D=3D IRQ_TYPE_LEVEL_HIGH |=
|
> + =A0 =A0 =A0 =A0 =A0 xilinx_intc_typetable[irq] =3D=3D IRQ_TYPE_LEVEL_LO=
W) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_chip_and_handler(virq, &xilinx_intc=
_level_irqchip,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_level_irq);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_irq_chip_and_handler(virq, &xilinx_intc=
_edge_irqchip,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_edge_irq);
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0static struct irq_host_ops xilinx_intc_ops =3D {
> =A0 =A0 =A0 =A0.map =3D xilinx_intc_map,
> + =A0 =A0 =A0 .xlate =3D xilinx_intc_xlate,
> =A0};
>
> =A0struct irq_host * __init
> --
> 1.6.2.1
>
>
>
> This email and any attachments are intended for the sole use of the named=
 recipient(s) and contain(s) confidential information that may be proprieta=
ry, privileged or copyrighted under applicable law. If you are not the inte=
nded recipient, do not read, copy, or forward this email message or any att=
achments. Delete this email message and any attachments immediately.
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
