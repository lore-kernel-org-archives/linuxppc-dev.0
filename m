Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5355DDE005
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 14:38:49 +1000 (EST)
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <E7CD85E9-BB6E-4598-A734-8D0E67090789@kernel.crashing.org>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>
	<ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
	<1239156559.10104.7.camel@localhost>
	<ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com>
	<49DD1154.3040106@kernel.org> <49DD11D1.7060105@freescale.com>
	<49DD1375.8030400@kernel.org> <49DD1465.6070001@freescale.com>
	<49DD17C3.7040607@kernel.org>
	<ed82fe3e0904081515k6e53de00g7d5256f9b61a03da@mail.gmail.com>
	<1239234793.6214.5.camel@localhost>
	<E7CD85E9-BB6E-4598-A734-8D0E67090789@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-prNLnWpbXv3DHisflPwn"
Date: Thu, 09 Apr 2009 14:38:48 +1000
Message-Id: <1239251928.22777.2.camel@localhost>
Mime-Version: 1.0
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
	Timur Tabi <timur@freescale.com>, Jeff Garzik <jeff@garzik.org>,
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


--=-prNLnWpbXv3DHisflPwn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-08 at 23:23 -0500, Kumar Gala wrote:
> On Apr 8, 2009, at 6:53 PM, Michael Ellerman wrote:
>=20
> > On Wed, 2009-04-08 at 17:15 -0500, Timur Tabi wrote:
> >> On Wed, Apr 8, 2009 at 4:31 PM, Tejun Heo <tj@kernel.org> wrote:
> >>> Hmmm... for now,
> >>> I think it would be best to revert the original change.  Jeff, can =20
> >>> you
> >>> please do that?
> >>
> >> Actually, give me a few days before you do that.  A colleague gave me
> >> some suggestions to debug this.
> >
> > What device did you say it was? A "ULI M1575" ?
> >
> > Is that this one?
> >
> > DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, =20
> > hpcd_quirk_uli1575);
> >
> > static void __devinit hpcd_quirk_uli1575(struct pci_dev *dev)
> > {
> >        u32 temp32;
> >
> >        if (!machine_is(mpc86xx_hpcd))
> >                return;
> >
> >        /* Disable INTx */
> >        pci_read_config_dword(dev, 0x48, &temp32);
> >        pci_write_config_dword(dev, 0x48, (temp32 | 1<<26));
> > ..
>=20
> It is the odd thing is the board he's running on is a mpc86xx_hpcd so =20
> he shouldn't be hitting the code that actually disables INTx.

Sorry Kumar that's not parsing :)

He is running an mpc86xx_hpcd, so he _should_ be hitting the code that
disables INTX?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-prNLnWpbXv3DHisflPwn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknde9gACgkQdSjSd0sB4dIPHACeIl8kEEZ08wZm8L9D1SofM1EV
nWMAoKpchiJfhdGbLkJNuv7bbTmPlYAO
=DnH6
-----END PGP SIGNATURE-----

--=-prNLnWpbXv3DHisflPwn--
