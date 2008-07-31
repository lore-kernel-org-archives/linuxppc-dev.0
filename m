Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc - Initialize the irq radix tree earlier
From: Michael Ellerman <michael@ellerman.id.au>
To: Sebastien Dugue <sebastien.dugue@bull.net>
In-Reply-To: <1217497241-10685-2-git-send-email-sebastien.dugue@bull.net>
References: <1217497241-10685-1-git-send-email-sebastien.dugue@bull.net>
	<1217497241-10685-2-git-send-email-sebastien.dugue@bull.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-cyJ9/EU+3uZuS2poDX3Y"
Date: Thu, 31 Jul 2008 21:40:56 +1000
Message-Id: <1217504456.9817.22.camel@localhost>
Mime-Version: 1.0
Cc: tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	jean-pierre.dion@bull.net, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, gilles.carry@ext.bull.net, tglx@linutronix.de
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-cyJ9/EU+3uZuS2poDX3Y
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-07-31 at 11:40 +0200, Sebastien Dugue wrote:
> The radix tree used for fast irq reverse mapping by the XICS is initializ=
ed
> late in the boot process, after the first interrupt (IPI) gets registered
> and after the first IPI is received.
>=20
>   This patch moves the initialization of the XICS radix tree earlier into
> the boot process in smp_xics_probe() (the mm is already up but no interru=
pts
> have been registered at that point) to avoid having to insert a mapping i=
nto
> the tree in interrupt context. This will help in simplifying the locking
> constraints and move to a lockless radix tree in subsequent patches.
>=20
>   As a nice side effect, there is no need any longer to check for
> (host->revmap_data.tree.gfp_mask !=3D 0) to know if the tree have been
> initialized.

Hi Sebastien,

This is a nice cleanup, I think :)

> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 6ac8612..0a1445c 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -893,28 +890,28 @@ unsigned int irq_find_mapping(struct irq_host *host=
,
>  }
>  EXPORT_SYMBOL_GPL(irq_find_mapping);
> =20
> +void __init irq_radix_revmap_init(void)
> +{
> + 	struct irq_host *h;
> +
> +	list_for_each_entry(h, &irq_hosts, link) {
> +		if (h->revmap_type =3D=3D IRQ_HOST_MAP_TREE)
> +			INIT_RADIX_TREE(&h->revmap_data.tree, GFP_ATOMIC);
> +	}
> +}

Note irq_radix_revmap_init() loops over all irq_hosts ...

> diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platform=
s/pseries/smp.c
> index 9d8f8c8..b143fe7 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -130,6 +130,7 @@ static void smp_xics_message_pass(int target, int msg=
)
> =20
>  static int __init smp_xics_probe(void)
>  {
> +	irq_radix_revmap_init();
>  	xics_request_IPIs();

But now it's only called from the xics setup code.

Which seems a bit ugly. In practice it doesn't matter because at the
moment xics is the only user of the radix revmap. But if we're going to
switch to this sort of initialisation I think xics should only be
init'ing the revmap for itself.


This boot ordering stuff is pretty hairy, so I might have missed
something, but this is how the code is ordered AFAICT:
=EF=BB=BF
start_kernel()
	init_IRQ()
	...
	local_irq_enable()
	...
	rest_init()
		kernel_thread()
			kernel_init()
				smp_prepare_cpus()
					smp_xics_probe()	(via smp_ops->probe())


What's stopping us from taking an irq between local_irq_enable() and
smp_xics_probe() ?  Is it just that no one's request_irq()'ed them yet?


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-cyJ9/EU+3uZuS2poDX3Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIkaTIdSjSd0sB4dIRAlLzAJ9UCXxhuVH9Lau6Ps3Yr8aelr4a+gCfd2el
T0F4Q23W4JmI2+5fFQ89OvI=
=NyUP
-----END PGP SIGNATURE-----

--=-cyJ9/EU+3uZuS2poDX3Y--
