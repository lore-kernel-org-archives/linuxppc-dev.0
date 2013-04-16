Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1AD872C0148
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2013 09:30:40 +1000 (EST)
Date: Tue, 16 Apr 2013 18:30:21 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <1365474152-21524-1-git-send-email-dongsheng.wang@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259EE77D8@039-SN2MPN1-021.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EE77D8@039-SN2MPN1-021.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Apr 16 05:58:52 2013)
Message-ID: <1366155021.23030.24@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ACK

-Scott

On 04/16/2013 05:58:52 AM, Wang Dongsheng-B40534 wrote:
> Hi scott,
>=20
> Could you ACK these patches?
>=20
> [PATCH v3 2/4] powerpc/mpic: add global timer support
> [PATCH v3 3/4] powerpc/mpic: create mpic subsystem object
> [PATCH v3 4/4] powerpc/fsl: add MPIC timer wakeup support
>=20
> Thanks.
>=20
> > -----Original Message-----
> > From: Wang Dongsheng-B40534
> > Sent: Tuesday, April 09, 2013 10:22 AM
> > To: Wood Scott-B07421
> > Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> > Subject: [PATCH v3 1/4] powerpc/mpic: add irq_set_wake support
> >
> > Add irq_set_wake support. Just add IRQF_NO_SUSPEND to =20
> desc->action->flag.
> > So the wake up interrupt will not be disable in suspend_device_irqs.
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > ---
> > v3:
> > * Modify: Change "EINVAL" to "ENXIO" in mpic_irq_set_wake()
> >
> > v2:
> > * Add: Check freescale chip in mpic_irq_set_wake().
> > * Remove: Support mpic_irq_set_wake() in ht_chip.
> >
> >  arch/powerpc/sysdev/mpic.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 3b2efd4..ae709d2 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -920,6 +920,22 @@ int mpic_set_irq_type(struct irq_data *d, =20
> unsigned
> > int flow_type)
> >  	return IRQ_SET_MASK_OK_NOCOPY;
> >  }
> >
> > +static int mpic_irq_set_wake(struct irq_data *d, unsigned int on) {
> > +	struct irq_desc *desc =3D container_of(d, struct irq_desc, =20
> irq_data);
> > +	struct mpic *mpic =3D mpic_from_irq_data(d);
> > +
> > +	if (!(mpic->flags & MPIC_FSL))
> > +		return -ENXIO;
> > +
> > +	if (on)
> > +		desc->action->flags |=3D IRQF_NO_SUSPEND;
> > +	else
> > +		desc->action->flags &=3D ~IRQF_NO_SUSPEND;
> > +
> > +	return 0;
> > +}
> > +
> >  void mpic_set_vector(unsigned int virq, unsigned int vector)  {
> >  	struct mpic *mpic =3D mpic_from_irq(virq); @@ -957,6 +973,7 @@ =20
> static
> > struct irq_chip mpic_irq_chip =3D {
> >  	.irq_unmask	=3D mpic_unmask_irq,
> >  	.irq_eoi	=3D mpic_end_irq,
> >  	.irq_set_type	=3D mpic_set_irq_type,
> > +	.irq_set_wake	=3D mpic_irq_set_wake,
> >  };
> >
> >  #ifdef CONFIG_SMP
> > @@ -971,6 +988,7 @@ static struct irq_chip mpic_tm_chip =3D {
> >  	.irq_mask	=3D mpic_mask_tm,
> >  	.irq_unmask	=3D mpic_unmask_tm,
> >  	.irq_eoi	=3D mpic_end_irq,
> > +	.irq_set_wake	=3D mpic_irq_set_wake,
> >  };
> >
> >  #ifdef CONFIG_MPIC_U3_HT_IRQS
> > --
> > 1.8.0
>=20
>=20
>=20

=
