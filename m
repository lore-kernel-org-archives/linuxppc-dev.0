Return-Path: <B40534@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 464482C011F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:49:32 +1100 (EST)
Received: from mail113-db8 (localhost [127.0.0.1])	by
 mail113-db8-R.bigfish.com (Postfix) with ESMTP id 0C9E3A01EE	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 02:49:26 +0000 (UTC)
Received: from DB8EHSMHS032.bigfish.com (unknown [10.174.8.237])	by
 mail113-db8.bigfish.com (Postfix) with ESMTP id CD13322004B	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 02:49:23 +0000 (UTC)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v2 1/4] powerpc/mpic: add irq_set_wake support
Date: Wed, 3 Apr 2013 02:49:11 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259EDC21E@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1364884840-28635-1-git-send-email-dongsheng.wang@freescale.com>
 <1364949416.24520.30@snotra>
In-Reply-To: <1364949416.24520.30@snotra>
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
> From: Wood Scott-B07421
> Sent: Wednesday, April 03, 2013 8:37 AM
> To: Wang Dongsheng-B40534
> Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
> Subject: Re: [PATCH v2 1/4] powerpc/mpic: add irq_set_wake support
>=20
> On 04/02/2013 01:40:37 AM, Wang Dongsheng wrote:
> > Add irq_set_wake support. Just add IRQF_NO_SUSPEND to
> > desc->action->flag.
> > So the wake up interrupt will not be disable in suspend_device_irqs.
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > ---
> > v2:
> > * Add: Check freescale chip in mpic_irq_set_wake().
> > * Remove: Support mpic_irq_set_wake() in ht_chip.
> >
> >  arch/powerpc/sysdev/mpic.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 3b2efd4..50d1ee1 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -920,6 +920,22 @@ int mpic_set_irq_type(struct irq_data *d,
> > unsigned int flow_type)
> >  	return IRQ_SET_MASK_OK_NOCOPY;
> >  }
> >
> > +static int mpic_irq_set_wake(struct irq_data *d, unsigned int on) {
> > +	struct irq_desc *desc =3D container_of(d, struct irq_desc,
> > irq_data);
> > +	struct mpic *mpic =3D mpic_from_irq_data(d);
> > +
> > +	if (!(mpic->flags & MPIC_FSL))
> > +		return -EINVAL;
>=20
> I was thinking more along the lines of using MPIC_FSL during init to
> decide whether to write this function to .irq_set_wake,

I think the static registration method is more reasonable. We must consider
readability. And mpic_irq_set_wake() will not be frequent calls. So within=
=20
mpic_irq_set_wake() to decide is reasonable.

> though that could probably wait until there's a second type of MPIC
> that needs this (if ever).
Even if the mpic_irq_set_wake() register in the first type of MPIC that is =
not
belong MPIC_FSL, the function can return errno. I think the errno should be
"-ENXIO".
See kernel/irq/manage.c, set_irq_wake_real() the return value.
The desc->irq_data.chip->irq_set_wake is null, the errno is -ENXIO.

s/-EINVAL/-ENXIO/
