Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F0B0DDF86
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 09:53:14 +1000 (EST)
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
From: Michael Ellerman <michael@ellerman.id.au>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <ed82fe3e0904081515k6e53de00g7d5256f9b61a03da@mail.gmail.com>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>
	<ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
	<1239156559.10104.7.camel@localhost>
	<ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com>
	<49DD1154.3040106@kernel.org> <49DD11D1.7060105@freescale.com>
	<49DD1375.8030400@kernel.org> <49DD1465.6070001@freescale.com>
	<49DD17C3.7040607@kernel.org>
	<ed82fe3e0904081515k6e53de00g7d5256f9b61a03da@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-7giAax17ruEw6v62IPlA"
Date: Thu, 09 Apr 2009 09:53:13 +1000
Message-Id: <1239234793.6214.5.camel@localhost>
Mime-Version: 1.0
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-7giAax17ruEw6v62IPlA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-08 at 17:15 -0500, Timur Tabi wrote:
> On Wed, Apr 8, 2009 at 4:31 PM, Tejun Heo <tj@kernel.org> wrote:
> > Hmmm... for now,
> > I think it would be best to revert the original change.  Jeff, can you
> > please do that?
>=20
> Actually, give me a few days before you do that.  A colleague gave me
> some suggestions to debug this.

What device did you say it was? A "ULI M1575" ?

Is that this one?

DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, hpcd_quirk_uli1575);    =
                                             =20

static void __devinit hpcd_quirk_uli1575(struct pci_dev *dev)              =
                                                 =20
{
        u32 temp32;

        if (!machine_is(mpc86xx_hpcd))
                return;

        /* Disable INTx */
        pci_read_config_dword(dev, 0x48, &temp32);
        pci_write_config_dword(dev, 0x48, (temp32 | 1<<26));
..


cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-7giAax17ruEw6v62IPlA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkndOOkACgkQdSjSd0sB4dL/WwCbBHwjGifGBSsCWuJQzbgiz1vh
edMAoI+rCPUZylkCxqa00WYz2c6efmrK
=b3u/
-----END PGP SIGNATURE-----

--=-7giAax17ruEw6v62IPlA--
