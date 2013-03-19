Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D4152C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 03:00:14 +1100 (EST)
Date: Tue, 19 Mar 2013 11:00:00 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH][UPSTEAM] powerpc/mpic: add irq_set_wake support
To: Wang Dongsheng-B40534 <B40534@freescale.com>
References: <1359601823-9861-1-git-send-email-dongsheng.wang@freescale.com>
 <1363649778.27435.21@snotra>
 <ABB05CD9C9F68C46A5CEDC7F15439259EB715D@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259EB715D@039-SN2MPN1-022.039d.mgd.msft.net>
 (from B40534@freescale.com on Tue Mar 19 02:10:38 2013)
Message-ID: <1363708800.16671.0@snotra>
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

On 03/19/2013 02:10:38 AM, Wang Dongsheng-B40534 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, March 19, 2013 7:36 AM
> > To: Wang Dongsheng-B40534
> > Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org
> > Subject: Re: [PATCH][UPSTEAM] powerpc/mpic: add irq_set_wake support
> >
> > On 01/30/2013 09:10:23 PM, Wang Dongsheng wrote:
> > > Add irq_set_wake support. Just add IRQF_NO_SUSPEND to
> > > desc->action->flag.
> > > So the wake up interrupt will not be disable in =20
> suspend_device_irqs.
> > >
> > > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > > ---
> > >  arch/powerpc/sysdev/mpic.c |   15 +++++++++++++++
> > >  1 files changed, 15 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/powerpc/sysdev/mpic.c =20
> b/arch/powerpc/sysdev/mpic.c
> > > index 9c6e535..2ed0220 100644
> > > --- a/arch/powerpc/sysdev/mpic.c
> > > +++ b/arch/powerpc/sysdev/mpic.c
> > > @@ -920,6 +920,18 @@ int mpic_set_irq_type(struct irq_data *d,
> > > unsigned int flow_type)
> > >  	return IRQ_SET_MASK_OK_NOCOPY;
> > >  }
> > >
> > > +static int mpic_irq_set_wake(struct irq_data *d, unsigned int on)
> > > +{
> > > +	struct irq_desc *desc =3D container_of(d, struct irq_desc,
> > > irq_data);
> > > +
> > > +	if (on)
> > > +		desc->action->flags |=3D IRQF_NO_SUSPEND;
> > > +	else
> > > +		desc->action->flags &=3D ~IRQF_NO_SUSPEND;
> > > +
> > > +	return 0;
> > > +}
> >
> > This should really be something like fsl_mpic_irq_set_wake() and =20
> only
> > set when we have an FSL MPIC.
> >
> Thanks, Add "#ifdef FSL_SOC" to control.

That's not what I meant.  Check "mpic->flags & MPIC_FSL".

-Scott=
