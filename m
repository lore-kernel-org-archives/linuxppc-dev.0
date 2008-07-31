Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 32137DE04C
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 22:10:22 +1000 (EST)
Date: Thu, 31 Jul 2008 14:10:29 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH] powerpc - Initialize the irq radix tree earlier
Message-ID: <20080731141029.0a9dd4cf@bull.net>
In-Reply-To: <20080731140002.31bbe4a0@bull.net>
References: <1217497241-10685-1-git-send-email-sebastien.dugue@bull.net>
	<1217497241-10685-2-git-send-email-sebastien.dugue@bull.net>
	<1217504456.9817.22.camel@localhost>
	<20080731140002.31bbe4a0@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net, linuxppc-dev@ozlabs.org,
	paulus@samba.org, gilles.carry@ext.bull.net, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 31 Jul 2008 14:00:02 +0200 Sebastien Dugue <sebastien.dugue@bull.ne=
t> wrote:

>=20
>   Hi Michael,
>=20
> On Thu, 31 Jul 2008 21:40:56 +1000 Michael Ellerman <michael@ellerman.id.=
au> wrote:
>=20
> > On Thu, 2008-07-31 at 11:40 +0200, Sebastien Dugue wrote:
> > > The radix tree used for fast irq reverse mapping by the XICS is initi=
alized
> > > late in the boot process, after the first interrupt (IPI) gets regist=
ered
> > > and after the first IPI is received.
> > >=20
> > >   This patch moves the initialization of the XICS radix tree earlier =
into
> > > the boot process in smp_xics_probe() (the mm is already up but no int=
errupts
> > > have been registered at that point) to avoid having to insert a mappi=
ng into
> > > the tree in interrupt context. This will help in simplifying the lock=
ing
> > > constraints and move to a lockless radix tree in subsequent patches.
> > >=20
> > >   As a nice side effect, there is no need any longer to check for
> > > (host->revmap_data.tree.gfp_mask !=3D 0) to know if the tree have been
> > > initialized.
> >=20
> > Hi Sebastien,
> >=20
> > This is a nice cleanup, I think :)
>=20
>   Thanks.
>=20
> >=20
> > > diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> > > index 6ac8612..0a1445c 100644
> > > --- a/arch/powerpc/kernel/irq.c
> > > +++ b/arch/powerpc/kernel/irq.c
> > > @@ -893,28 +890,28 @@ unsigned int irq_find_mapping(struct irq_host *=
host,
> > >  }
> > >  EXPORT_SYMBOL_GPL(irq_find_mapping);
> > > =20
> > > +void __init irq_radix_revmap_init(void)
> > > +{
> > > + 	struct irq_host *h;
> > > +
> > > +	list_for_each_entry(h, &irq_hosts, link) {
> > > +		if (h->revmap_type =3D=3D IRQ_HOST_MAP_TREE)
> > > +			INIT_RADIX_TREE(&h->revmap_data.tree, GFP_ATOMIC);
> > > +	}
> > > +}
> >=20
> > Note irq_radix_revmap_init() loops over all irq_hosts ...
>=20
>   Yep, but there's only one host (xics)
>=20
> >=20
> > > diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/plat=
forms/pseries/smp.c
> > > index 9d8f8c8..b143fe7 100644
> > > --- a/arch/powerpc/platforms/pseries/smp.c
> > > +++ b/arch/powerpc/platforms/pseries/smp.c
> > > @@ -130,6 +130,7 @@ static void smp_xics_message_pass(int target, int=
 msg)
> > > =20
> > >  static int __init smp_xics_probe(void)
> > >  {
> > > +	irq_radix_revmap_init();
> > >  	xics_request_IPIs();
> >=20
> > But now it's only called from the xics setup code.
> >=20
> > Which seems a bit ugly. In practice it doesn't matter because at the
> > moment xics is the only user of the radix revmap. But if we're going to
> > switch to this sort of initialisation I think xics should only be
> > init'ing the revmap for itself.
>=20
>   You're right, that's what I intended to do from the beginning but
> stumbled upon ... hmm, can't remember what, that made me change
> my mind.

  Ah yes, I wanted to do it from xics_init_host() but backed off
because at that point the mm is not up. But it does not make a difference
as the first request_irq() happens after the mm is up. A bit shaky I
concede.

> But I agree, I'm not particularly proud of that. Will look
> again into that.
>=20
> >=20
> >=20
> > This boot ordering stuff is pretty hairy, so I might have missed
> > something, but this is how the code is ordered AFAICT:
> > =EF=BB=BF
> > start_kernel()
> > 	init_IRQ()
> > 	...
> > 	local_irq_enable()
> > 	...
> > 	rest_init()
> > 		kernel_thread()
> > 			kernel_init()
> > 				smp_prepare_cpus()
> > 					smp_xics_probe()	(via smp_ops->probe())
> >=20
> >=20
> > What's stopping us from taking an irq between local_irq_enable() and
> > smp_xics_probe() ?  Is it just that no one's request_irq()'ed them yet?
>=20
>   It's hairy, I agree, but as you've mentioned no one has done a request_=
irq()
> at that point. The first one to do it is smp_xics_probe() for the IPI.
>=20
>   Thanks for your comments.
>=20
>   Sebastien.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
