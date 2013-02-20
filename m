Return-Path: <B40534@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2A782C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2013 16:58:03 +1100 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: RE: [PATCH][UPSTEAM] powerpc/mpic: add irq_set_wake support
Date: Wed, 20 Feb 2013 05:57:48 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259E71F4A@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1359601823-9861-1-git-send-email-dongsheng.wang@freescale.com>
 <3887203D-64E3-4BA5-AB2A-20BE668560A4@kernel.crashing.org>
In-Reply-To: <3887203D-64E3-4BA5-AB2A-20BE668560A4@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Tuesday, February 19, 2013 3:43 AM
> To: Wang Dongsheng-B40534
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH][UPSTEAM] powerpc/mpic: add irq_set_wake support
>=20
>=20
> On Jan 30, 2013, at 9:10 PM, Wang Dongsheng wrote:
>=20
> > Add irq_set_wake support. Just add IRQF_NO_SUSPEND to desc->action-
> >flag.
> > So the wake up interrupt will not be disable in suspend_device_irqs.
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > ---
> > arch/powerpc/sysdev/mpic.c |   15 +++++++++++++++
> > 1 files changed, 15 insertions(+), 0 deletions(-)
>=20
> Why are we doing this globally for all interrupts? Don't we only have=20
> some specific interrupts that wake us up?
> Also, I'm guessing the wake behavior for interrupts is FSL specific so
> should not apply to ALL users of MPIC.

That is IRQ wakeup (PM) control. Actually not all interrupts will be set.
We just let mpic have this ability. It's control by driver.
If a device has the ability to wake up system, this device driver can set
irq wake up(through enable/disable_irq_wake()), and the driver do not need
add a flag(IRQF_NO_SUSPEND) to request_irq().

for example,

suspend()
{
	...;
	enable_irq_wake(irq);
	...;
}

resume()
{
	...;
	disable_irq_wake(irq);
	...;
}

>=20
> - k
>=20

> >
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 9c6e535..2ed0220 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -920,6 +920,18 @@ int mpic_set_irq_type(struct irq_data *d, unsigned
> int flow_type)
> > 	return IRQ_SET_MASK_OK_NOCOPY;
> > }
> >
> > +static int mpic_irq_set_wake(struct irq_data *d, unsigned int on) {
> > +	struct irq_desc *desc =3D container_of(d, struct irq_desc, irq_data);
> > +
> > +	if (on)
> > +		desc->action->flags |=3D IRQF_NO_SUSPEND;
> > +	else
> > +		desc->action->flags &=3D ~IRQF_NO_SUSPEND;
> > +
> > +	return 0;
> > +}
> > +
> > void mpic_set_vector(unsigned int virq, unsigned int vector) {
> > 	struct mpic *mpic =3D mpic_from_irq(virq); @@ -957,6 +969,7 @@ static
> > struct irq_chip mpic_irq_chip =3D {
> > 	.irq_unmask	=3D mpic_unmask_irq,
> > 	.irq_eoi	=3D mpic_end_irq,
> > 	.irq_set_type	=3D mpic_set_irq_type,
> > +	.irq_set_wake	=3D mpic_irq_set_wake,
> > };
> >
> > #ifdef CONFIG_SMP
> > @@ -971,6 +984,7 @@ static struct irq_chip mpic_tm_chip =3D {
> > 	.irq_mask	=3D mpic_mask_tm,
> > 	.irq_unmask	=3D mpic_unmask_tm,
> > 	.irq_eoi	=3D mpic_end_irq,
> > +	.irq_set_wake	=3D mpic_irq_set_wake,
> > };
> >
> > #ifdef CONFIG_MPIC_U3_HT_IRQS
> > @@ -981,6 +995,7 @@ static struct irq_chip mpic_irq_ht_chip =3D {
> > 	.irq_unmask	=3D mpic_unmask_ht_irq,
> > 	.irq_eoi	=3D mpic_end_ht_irq,
> > 	.irq_set_type	=3D mpic_set_irq_type,
> > +	.irq_set_wake	=3D mpic_irq_set_wake,
> > };
> > #endif /* CONFIG_MPIC_U3_HT_IRQS */
> >
> > --
> > 1.7.5.1
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
