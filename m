Return-Path: <michael@ellerman.id.au>
Subject: Re: [parisc-linux] [PATCH 2/2] Make pcibios_add_platform_entries()
	return errors
From: Michael Ellerman <michael@ellerman.id.au>
To: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <1173204301.3379.33.camel@mulgrave.il.steeleye.com>
References: <20070306150725.68D97DDF36@ozlabs.org>
	<1173204301.3379.33.camel@mulgrave.il.steeleye.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-BgsAG7SQX+bolLlRm7kx"
Date: Wed, 07 Mar 2007 09:55:18 +0100
Message-Id: <1173257718.5101.16.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: discuss@x86-64.org, dev-etrax@axis.com, linux-ia64@vger.kernel.org,
	chris@zankel.net, Greg Kroah-Hartman <greg@kroah.com>,
	linux-m68k@vger.kernel.org, uclinux-v850@lsi.nec.co.jp,
	linuxppc-dev@ozlabs.org, linux-mips@linux-mips.org,
	gerg@uclinux.org, sparclinux@vger.kernel.org,
	ink@jurassic.park.msu.ru, linux-pci@atrey.karlin.mff.cuni.cz,
	rth@twiddle.net, kernel@wantstofly.org, parisc-linux@parisc-linux.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-BgsAG7SQX+bolLlRm7kx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-03-06 at 12:05 -0600, James Bottomley wrote:
> On Tue, 2007-03-06 at 16:06 +0100, Michael Ellerman wrote:
> >  int __must_check pci_create_sysfs_dev_files (struct pci_dev *pdev)
> > @@ -644,10 +644,13 @@ int __must_check pci_create_sysfs_dev_fi
> >  		}
> >  	}
> >  	/* add platform-specific attributes */
> > -	pcibios_add_platform_entries(pdev);
> > +	if (pcibios_add_platform_entries(pdev))
> > +		goto err_rom_attr;
> > =20
> >  	return 0;
> > =20
> > +err_rom_attr:
> > +	sysfs_remove_bin_file(&pdev->dev.kobj, rom_attr);
>=20
> This file is only created if the rom resource has a non-zero length.  If
> you unconditionally call sysfs_remove_bin_file() it's going to spit
> scary warnings and dump traces in this error leg if the rom resource
> doesn't exist.

Ah crud, don't write patches during meetings. I'll send a fixed version.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-BgsAG7SQX+bolLlRm7kx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBF7n32dSjSd0sB4dIRAn5sAKDLKRSrFBG7U5Cd40rDmTlteEGzOgCgsZhx
xnxBaUCAjUOpUDo/Iyyq50o=
=Lg0a
-----END PGP SIGNATURE-----

--=-BgsAG7SQX+bolLlRm7kx--
