Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Introduce ppc_pci_flags accessors
From: Michael Ellerman <michael@ellerman.id.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081210185446.13e33cb2@zod.rchland.ibm.com>
References: <20081210191148.GA1769@yoda.jdub.homelinux.org>
	<1228952788.7999.0.camel@localhost>
	<20081210185446.13e33cb2@zod.rchland.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-YqxQk/lF6cuTuXSz/aUA"
Date: Thu, 11 Dec 2008 11:04:05 +1100
Message-Id: <1228953845.7999.5.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-YqxQk/lF6cuTuXSz/aUA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-12-10 at 18:54 -0500, Josh Boyer wrote:
> On Thu, 11 Dec 2008 10:46:28 +1100
> Michael Ellerman <michael@ellerman.id.au> wrote:
>=20
> > On Wed, 2008-12-10 at 14:11 -0500, Josh Boyer wrote:
> > > Currently there are a number of platforms that open code access to
> > > the ppc_pci_flags global variable.  However, that variable is not
> > > present if CONFIG_PCI is not set, which can lead to a build break.
> > >=20
> > > This introduces a number of accessor functions that are defined
> > > to be empty in the case of CONFIG_PCI being disabled.  The
> > > various platform files in the kernel are updated to use these.
> > >=20
> > > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > >=20
> > > ---
> > >=20
> > > diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/inc=
lude/asm/pci-bridge.h
> > > index fa8b3b7..8f2c7ca 100644
> > > --- a/arch/powerpc/include/asm/pci-bridge.h
> > > +++ b/arch/powerpc/include/asm/pci-bridge.h
> > > @@ -13,7 +13,6 @@
> > > =20
> > >  struct device_node;
> > > =20
> > > -extern unsigned int ppc_pci_flags;
> > >  enum {
> > >  	/* Force re-assigning all resources (ignore firmware
> > >  	 * setup completely)
> > > @@ -36,6 +35,16 @@ enum {
> > >  	/* ... except for domain 0 */
> > >  	PPC_PCI_COMPAT_DOMAIN_0		=3D 0x00000020,
> > >  };
> > > +#ifdef CONFIG_PCI
> > > +extern unsigned int ppc_pci_flags;
> > > +#define ppc_pci_set_flags(flags) ppc_pci_flags =3D (flags)
> > > +#define ppc_pci_add_flags(flags) ppc_pci_flags |=3D (flags)
> > > +#define ppc_pci_flag_is_set(flag) (ppc_pci_flags & (flag))
> > > +#else
> > > +#define ppc_pci_set_flags(flags) do {} while (0)
> > > +#define ppc_pci_add_flags(flags) do {} while (0)
> > > +#define ppc_pci_flag_is_set(flag) (0)
> > > +#endif
> >=20
> > I hate to be picky, but I don't see any reason why these shouldn't be
> > static inlines.
>=20
> There's a perfectly good reason.  I AM LAZY.

Fair enough, I'll do the typing for you :)

#ifdef CONFIG_PCI
extern unsigned int ppc_pci_flags;

static inline void ppc_pci_set_flags(int flags)
{
	ppc_pci_flags =3D flags;
}

static inline void ppc_pci_add_flags(int flags)
{
	ppc_pci_flags |=3D flags;
}

static inline int ppc_pci_flag_is_set(int flag)
{
	return (ppc_pci_flags & flag);
}
#else
static inline void ppc_pci_set_flags(int flags) { }
static inline void ppc_pci_add_flags(int flags) { }
static inline int ppc_pci_flag_is_set(int flag)
{
	return 0;
}
#endif


One other thought, should the check routine be
ppc_pci_flags_are_set(flags)?=20

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-YqxQk/lF6cuTuXSz/aUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklAWPUACgkQdSjSd0sB4dKTtgCfc17n0EtFcCHMiSZ6OJBz+HYk
yq8AoMPZi6YBPw0F1pKXMU0x1t3RxElL
=RP4V
-----END PGP SIGNATURE-----

--=-YqxQk/lF6cuTuXSz/aUA--
