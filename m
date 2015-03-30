Return-Path: <dja@axtens.net>
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E4B61A0332
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 09:12:48 +1100 (AEDT)
Received: by pdcp1 with SMTP id p1so97130822pdc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 15:12:46 -0700 (PDT)
Message-ID: <1427753572.11226.10.camel@axtens.net>
Subject: Re: [PATCH 02/27] powerpc/powermac: move pmac_pci_probe_mode from
 setup.c to pci.c
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 31 Mar 2015 09:12:52 +1100
In-Reply-To: <20150330123214.9EE4014009B@ozlabs.org>
References: <20150330123214.9EE4014009B@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-eJb9Rmb+/pUVSWHrhLrH"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-eJb9Rmb+/pUVSWHrhLrH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2015-03-30 at 23:32 +1100, Michael Ellerman wrote:
> On Wed, 2015-25-03 at 05:35:36 UTC, Daniel Axtens wrote:
>=20
> Why did we move it? Just for cleanliness?
>=20

I move it because in (what is currently) patch 14, I want to hook it
into the PCI controller ops structure, which I define in pci.c. In that
patch I make the definition static again and remove the prototype from
the header.

I saw two other options:
 - Move it to pci.c as part of patch 14
 - Keep it in setup.c and just accept that it won't be static and will
need a prototype in the header.

I thought this was the least bad option, but I'm happy to do it another
way. Either way I will explain it better in the next series.

Regards,
Daniel

> > Signed-off-by: Daniel Axtens <dja@axtens.net>
> > ---
> >  arch/powerpc/platforms/powermac/pci.c   | 17 +++++++++++++++++
> >  arch/powerpc/platforms/powermac/pmac.h  |  4 ++++
> >  arch/powerpc/platforms/powermac/setup.c | 18 ------------------
> >  3 files changed, 21 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platf=
orms/powermac/pci.c
> > index f4071a6..a792f45 100644
> > --- a/arch/powerpc/platforms/powermac/pci.c
> > +++ b/arch/powerpc/platforms/powermac/pci.c
> > @@ -1223,3 +1223,20 @@ static void fixup_u4_pcie(struct pci_dev* dev)
> >  	pci_write_config_dword(dev, PCI_PREF_MEMORY_BASE, 0);
> >  }
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_U4_P=
CIE, fixup_u4_pcie);
> > +
> > +#ifdef CONFIG_PPC64
> > +int pmac_pci_probe_mode(struct pci_bus *bus)
> > +{
> > +	struct device_node *node =3D pci_bus_to_OF_node(bus);
> > +
> > +	/* We need to use normal PCI probing for the AGP bus,
> > +	 * since the device for the AGP bridge isn't in the tree.
> > +	 * Same for the PCIe host on U4 and the HT host bridge.
> > +	 */
> > +	if (bus->self =3D=3D NULL && (of_device_is_compatible(node, "u3-agp")=
 ||
> > +				  of_device_is_compatible(node, "u4-pcie") ||
> > +				  of_device_is_compatible(node, "u3-ht")))
> > +		return PCI_PROBE_NORMAL;
> > +	return PCI_PROBE_DEVTREE;
> > +}
> > +#endif /* CONFIG_PPC64 */
> > diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/plat=
forms/powermac/pmac.h
> > index 8327cce..46d2193 100644
> > --- a/arch/powerpc/platforms/powermac/pmac.h
> > +++ b/arch/powerpc/platforms/powermac/pmac.h
> > @@ -39,4 +39,8 @@ extern void low_cpu_die(void) __attribute__((noreturn=
));
> >  extern int pmac_nvram_init(void);
> >  extern void pmac_pic_init(void);
> > =20
> > +#ifdef CONFIG_PPC64
> > +extern int pmac_pci_probe_mode(struct pci_bus *bus);
> > +#endif
>=20
> You don't need to ifdef declarations, and you don't need extern.
>=20
> So just:
>=20
> > +int pmac_pci_probe_mode(struct pci_bus *bus);
>=20
> Is fine.
>=20
> cheers


--=-eJb9Rmb+/pUVSWHrhLrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVGcpkAAoJEPC3R3P2I92FNCwQAJZEi/JadChdqSjjXPN9nBe4
RNowtYh9sH1KprYNTMc6NdoqI7cbJHmY4bTz8q+kdouUSEXev5uqp0Czvf62CY/5
9m9Z/JIEW25Trkxg9WmoanvLe8KLKVXTOkKeq9kfShxnpiN7sX0cKQhWHP2a0nnL
9n+w3WRC7r7C6+NTn4QnBZR/UT7m10oIXOy576uW1WaBSj0MOnk9/xrR75H0rmzY
ftSlDAA3dSIGbGD4bVOMMzwhxZQui/1Eby6oT8jp4RiHloT6HA9Lft5bVpTawtpc
sbrQqoEcWWRJaEpMyDzjqrp71eTebrvCQ6LeKsuF0T7B33D6TG4Jfwgl561gRdki
rJ5tLAhEWd+yMbOV3V5h6wz4Tg8i509idxGxriEW0w2fvq7JLsBDjIluOyq3O6YC
Zxt3PIx46YJ1S6xgQwZfzaA1cQEy8l96WZgHFpPoWw/y1p2vcz3bmEmOir0+UmZ+
+RXhD9eKg7HCVdriRZo7h7MFPELJXxShIgX7FI5+xuOCVEYYfYj0VNOmkYmhUk0h
0STBsLOrbeAyvNKn613scn5w+QuylSdKZEwk3+D9WgW47dCrgNzKIUVVu2xGG40b
NAgdx/n0F3eglvocWAn6Pgk4bQvZrliiUTOowNbqwjVNNCnWu6ZUpq+d338y8YvL
bKw0WJLeDsrUbNCRcM6j
=BoWw
-----END PGP SIGNATURE-----

--=-eJb9Rmb+/pUVSWHrhLrH--
