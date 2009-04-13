Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 891F1DE11E
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2009 21:34:31 +1000 (EST)
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
From: Michael Ellerman <michael@ellerman.id.au>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <49DD8871.2030404@garzik.org>
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
	<1239251928.22777.2.camel@localhost>  <49DD8871.2030404@garzik.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-tcypsVlFw0YX5WFvpbIO"
Date: Mon, 13 Apr 2009 21:34:30 +1000
Message-Id: <1239622470.12120.12.camel@localhost>
Mime-Version: 1.0
Cc: x.xiao@freescale.com, Linux PPC Development <linuxppc-dev@ozlabs.org>,
	linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	Timur Tabi <timur@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-tcypsVlFw0YX5WFvpbIO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-04-09 at 01:32 -0400, Jeff Garzik wrote:
> Michael Ellerman wrote:
> > On Wed, 2009-04-08 at 23:23 -0500, Kumar Gala wrote:
> >> On Apr 8, 2009, at 6:53 PM, Michael Ellerman wrote:
> >>
> >>> On Wed, 2009-04-08 at 17:15 -0500, Timur Tabi wrote:
> >>>> On Wed, Apr 8, 2009 at 4:31 PM, Tejun Heo <tj@kernel.org> wrote:
> >>>>> Hmmm... for now,
> >>>>> I think it would be best to revert the original change.  Jeff, can =
=20
> >>>>> you
> >>>>> please do that?
> >>>> Actually, give me a few days before you do that.  A colleague gave m=
e
> >>>> some suggestions to debug this.
> >>> What device did you say it was? A "ULI M1575" ?
> >>>
> >>> Is that this one?
> >>>
> >>> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, =20
> >>> hpcd_quirk_uli1575);
> >>>
> >>> static void __devinit hpcd_quirk_uli1575(struct pci_dev *dev)
> >>> {
> >>>        u32 temp32;
> >>>
> >>>        if (!machine_is(mpc86xx_hpcd))
> >>>                return;
> >>>
> >>>        /* Disable INTx */
> >>>        pci_read_config_dword(dev, 0x48, &temp32);
> >>>        pci_write_config_dword(dev, 0x48, (temp32 | 1<<26));
> >>> ..
> >> It is the odd thing is the board he's running on is a mpc86xx_hpcd so =
=20
> >> he shouldn't be hitting the code that actually disables INTx.
> >=20
> > Sorry Kumar that's not parsing :)
> >=20
> > He is running an mpc86xx_hpcd, so he _should_ be hitting the code that
> > disables INTX?
>=20
> The reversed logic of the PCI bit itself also makes for confusing=20
> discusion.  In an attempt to be helpful, here is a restatement of what=20
> is happening:
>=20
> 1) Old 'ahci' used to clear PCI_COMMAND_INTX_DISABLE, thus ensuring INTX=20
> interrupts are enabled... if and only if MSI is unavailable.
>=20
> 2) Current 'ahci' no longer does this
>=20
> 3) As a result, Timur's 'ahci' is no longer receiving interrupts.=20
> Presumably this means that BOTH of the following conditions are true
>=20
> 	a) INTX is disabled
> 	b) MSI is not available

Agreed.

> Today I am thinking we should either revert the libata commit=20
> (a5bfc4714b3f01365aef89a92673f2ceb1ccf246), or poke PCI to twiddle INTX=20
> for us at pci_enable_device() time, perhaps.
>=20
> I lean towards the former, but maybe the platform folks prefer a third=20
> solution?

But the device should have INTX enabled, the core shouldn't need to
twiddle it. If the device comes up with INTX disabled then it needs a
quirk to turn it on.

But in this case we have a quirk to turn INTX _off_, which just seems
odd. Can anyone say _why_ we need a quirk to turn INTX off? Looking at
the git history that quirk has been there ever since the MPC8610 HPCD
support went in (0e65bfe34c1000581746b9889d095241c4cf4a5c).

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-tcypsVlFw0YX5WFvpbIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknjI0YACgkQdSjSd0sB4dIrxwCfZ0D3WNGrzEUsWb7uQmPuP7lw
LB0An0AqKh4GHNbaVsyiFMO8AJEtOyWY
=kYAd
-----END PGP SIGNATURE-----

--=-tcypsVlFw0YX5WFvpbIO--
