Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CDCD6DDED0
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 07:58:30 +1100 (EST)
Date: Fri, 25 Jan 2008 07:58:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [POWERPC] MPC8360E-RDK: device tree, board file and
	defconfig
Message-Id: <20080125075820.f85a4c97.sfr@canb.auug.org.au>
In-Reply-To: <20080124132900.GA25982@localhost.localdomain>
References: <20080123204507.GA12973@localhost.localdomain>
	<20080124132201.c3086756.sfr@canb.auug.org.au>
	<20080124132900.GA25982@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__25_Jan_2008_07_58_20_+1100_3xA+kkZTYv=AwZ=F"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__25_Jan_2008_07_58_20_+1100_3xA+kkZTYv=AwZ=F
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Thu, 24 Jan 2008 16:29:01 +0300 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> On Thu, Jan 24, 2008 at 01:22:01PM +1100, Stephen Rothwell wrote:
> > On Wed, 23 Jan 2008 23:45:07 +0300 Anton Vorontsov <avorontsov@ru.mvist=
a.com> wrote:
> > >
> > > +++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
> > > +static int __init mpc836x_rdk_declare_of_platform_devices(void)
> > > +{
> > > +	const struct of_device_id mpc836x_rdk_ids[] =3D {
> >=20
> > Please change this to static, __initdata and not const, thanks. These
> > arrays are usually defined outside a function, but that is not really a
> > problem.
>=20
> Pity... we don't need these _ids anywhere outside that function. But
> looking into objdump output I see the problem now.
>=20
> Will change this back, thanks.
>=20
> > > +static void __init mpc836x_rdk_setup_arch(void)
> > > +{
> > > +	struct device_node *np;
> >=20
> > !defined(CONFIG_PCI) && !defined(CONFIG_QUICC_ENGINE) will produce a
> > warning here.
>=20
> Good catch, thanks.
>=20
> > > +	if (ppc_md.progress)
> > > +		ppc_md.progress("mpc836x_rdk_setup_arch()", 0);
> > > +
> > > +#ifdef CONFIG_PCI
> > > +	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
> > > +		mpc83xx_add_bridge(np);
> > > +#endif
> > > +
> > > +#ifdef CONFIG_QUICC_ENGINE
> > > +	qe_reset();
> > > +
> > > +	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-pario");
> > > +	if (!np) {
> > > +		pr_warning("QE PIO not initialized!\n");
> > > +		return;
> >=20
> > You need an of_node_put(np) before the return.
>=20
> Hm, really? I think I don't. But if you insist... :-)

Sorry, I don't know what I was thinking - of course you don't need it.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__25_Jan_2008_07_58_20_+1100_3xA+kkZTYv=AwZ=F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHmPvyTgG2atn1QN8RAuKfAJ9ygfMkFVwq4SDS21P/4deojaX+igCgkVrQ
XAQh/G0PH6760BsxJhhBLsA=
=HvsP
-----END PGP SIGNATURE-----

--Signature=_Fri__25_Jan_2008_07_58_20_+1100_3xA+kkZTYv=AwZ=F--
