Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C1A20DDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 20:34:46 +1000 (EST)
Date: Wed, 11 Jul 2007 14:34:22 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
Subject: Re: MPC82xx ADS SCC ports initialisation
Message-ID: <20070711143422.6b00620e@localhost.localdomain>
In-Reply-To: <200707110911.19477.laurent.pinchart@technotrade.biz>
References: <200707101619.52438.laurent.pinchart@technotrade.biz>
	<20070710181133.GB14935@ld0162-tx32.am.freescale.net>
	<200707110911.19477.laurent.pinchart@technotrade.biz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_ZNO9u.nm5yBSke.LPQZmW=o";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_ZNO9u.nm5yBSke.LPQZmW=o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Jul 2007 09:11:18 +0200
Laurent Pinchart wrote:

> On Tuesday 10 July 2007 20:11, Scott Wood wrote:
> > On Tue, Jul 10, 2007 at 04:19:51PM +0200, Laurent Pinchart wrote:
> > > clrbits32(&immap->im_cpmux.cmx_scr, (0x00000007 << (4 -
> > > data->clk_tx))); clrbits32(&immap->im_cpmux.cmx_scr, (0x00000038
> > > << (4 - data->clk_rx))); setbits32(&immap->im_cpmux.cmx_scr,
> > >           ((data->clk_tx - 1) << (4 - data->clk_tx)));
> > > setbits32(&immap->im_cpmux.cmx_scr,
> > >           ((data->clk_rx - 1) << (4 - data->clk_rx)));
> > >
> > > The shift right-hand operand doesn't seem to be correct. Could
> > > anyone confirm this ?
> >
> > You are correct; it's broken.
>=20
> That code should be replaced with calls to cpm2_clk_setup=20
> (arch/powerpc/sysdev/cpm2_common.c). cpm2_clk_setup currently
> supports FCC clock setup only, but I've got a patch to add SCC clock
> setup support. Should I send it ?
>=20
If you have functional approach, please feel free to send it...

> > > If my assumption is right, could anyone tell me if the MPC82xx
> > > processors are actually supported by the powerpc architecture, or
> > > if the MPC82xx ADS code is just a non-functional work in progress.
> >
once my last changes were committed, 82xx was supported and worked fine.
Pretty long time I had no access to the hardware, hence some minor things m=
ight require catch-up.



> > I have a bunch of 8xx/82xx changes pending; I hope to get them
> > cleaned up before the merge window ends.
>=20
Since I'm the only person covering 8xx/82xx for a while, I definitely want =
to look at those changes...
> That would be nice. I'll wait for your changes to continue my ppc ->
> powerpc port.
>=20
> > > I also noticed that U-Boot doesn't have flatten device tree
> > > support for the MPC82xx family.
> >

At the moment, I have a patch to add such a thing, but no ability to valida=
te it still works. If you guys will assist a little,
I'll go ahead and submit it to the u-boot list.

> > No, but cuImage for 82xx is on its way.
>=20
> Ok, nice to know. Adding FDT support to U-Boot for the MPC82xx family
> will be on my todo-list once I get Linux working with cuImage.
>=20
> Laurent Pinchart

--Sig_ZNO9u.nm5yBSke.LPQZmW=o
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGlLIue8XNc4YXvvgRAliRAKCBUOz18i5M7MznXFUihNn4NkNp8QCglG51
iJMxuR3wlo8/L8460l/pRnQ=
=Zzfn
-----END PGP SIGNATURE-----

--Sig_ZNO9u.nm5yBSke.LPQZmW=o--
