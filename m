Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][BUILD FAILURE 03/12] Re: Next April 21 : PPC64
	randconfig [arch/powerpc/kernel/of_platform.o]
From: Michael Ellerman <michael@ellerman.id.au>
To: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090422161648.9231.76057.sendpatchset@subratamodak.linux.ibm.com>
References: <20090422161648.9231.76057.sendpatchset@subratamodak.linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-B1o7FI5dQRf/Am4VzBbR"
Date: Thu, 23 Apr 2009 10:43:40 +1000
Message-Id: <1240447420.6689.13.camel@localhost>
Mime-Version: 1.0
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
	Alexander Beregalov <a.beregalov@gmail.com>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-B1o7FI5dQRf/Am4VzBbR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-22 at 21:46 +0530, Subrata Modak wrote:
> On Wed, 2009-04-22 at 00:20 +0530, Subrata Modak wrote:
> > Reported this earlier on 14th April 2009:
> > http://lkml.org/lkml/2009/4/14/480,
> >=20
> > Michael,
> >=20
> > Any fix in sight ?
> > http://lkml.org/lkml/2009/4/14/676,
> >=20
> > CC      arch/powerpc/kernel/of_platform.o
> > arch/powerpc/kernel/of_platform.c: In function 'of_pci_phb_probe':
> > arch/powerpc/kernel/of_platform.c:270: error: implicit declaration of
> > function 'pci_devs_phb_init_dynamic'
> > arch/powerpc/kernel/of_platform.c:279: error: implicit declaration of
> > function 'scan_phb'
> > arch/powerpc/kernel/of_platform.c:295: error: implicit declaration of
> > function 'pci_bus_add_devices'
> > make[1]: *** [arch/powerpc/kernel/of_platform.o] Error 1
> > make: *** [arch/powerpc/kernel] Error 2
> > ---

The problem above is as I said before, that the Cell Kconfig forces on
PPC_OF_PLATFORM_PCI even if PCI is disabled. I think the proper fix is
just to have CELL_NATIVE force on PCI.

I don't know how you got the other errors, both pci_dn.c and pci_dlpar.c
are only built if CONFIG_PCI is enabled, see the Makefiles.

cheers

--=-B1o7FI5dQRf/Am4VzBbR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknvubwACgkQdSjSd0sB4dK05ACeJQN9C83Xbvm+4tBevpwZMA7u
304An3h2zIqTV87H4Q6IeiPNGnfEVsBq
=WXoj
-----END PGP SIGNATURE-----

--=-B1o7FI5dQRf/Am4VzBbR--
