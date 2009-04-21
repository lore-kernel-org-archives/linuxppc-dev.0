Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF7E7DDFE2
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 12:14:05 +1000 (EST)
Subject: Re: [PATCH 5/5] powerpc: Add 86xx support for SWIOTLB
From: Michael Ellerman <michael@ellerman.id.au>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <36CDD079-FEFD-4928-A997-8DE9C2E1D3D0@kernel.crashing.org>
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-5-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-6-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-7-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-8-git-send-email-beckyb@kernel.crashing.org>
	<856C2CF2-B219-493F-9FE5-15D21DD5C764@kernel.crashing.org>
	<36CDD079-FEFD-4928-A997-8DE9C2E1D3D0@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-X65o+dlHe2TfFARrdY8j"
Date: Tue, 21 Apr 2009 12:14:04 +1000
Message-Id: <1240280044.17367.12.camel@localhost>
Mime-Version: 1.0
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-X65o+dlHe2TfFARrdY8j
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-04-20 at 12:58 -0500, Becky Bruce wrote:
> On Apr 20, 2009, at 12:00 PM, Kumar Gala wrote:
> > On Apr 20, 2009, at 11:26 AM, Becky Bruce wrote:
> >>
> >> config PPC_NEED_DMA_SYNC_OPS
> >> 	def_bool y
> >> 	depends on (NOT_COHERENT_CACHE || SWIOTLB)
> >> diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/=20
> >> kernel/dma-swiotlb.c
> >> index 29a68e6..3065d03 100644
> >> --- a/arch/powerpc/kernel/dma-swiotlb.c
> >> +++ b/arch/powerpc/kernel/dma-swiotlb.c
> >> @@ -159,3 +159,5 @@ static int __init setup_bus_notifier(void)
> >>
> >> 	return 0;
> >> }
> >> +
> >> +machine_arch_initcall(mpc86xx_hpcn, setup_bus_notifier);
> >
> > Hmm, not sure what we chatted about here, but I don't want to have =20
> > to add every board into this file to register the bus notifiers.
>=20
> We talked about this, and this was what we decided on - I don't really =20
> like the idea, either, but there's a lot of precedent for it.  I'd =20
> like to do this differently, but I"m not sure what the solution is - =20
> we'd need to look into that more (or perhaps someone here will have =20
> some sage advice).

Give it a better name, export it, and call it from the board setup file?

Actually what depends on the board anyway? It's just the dma window
config in the pci_controller isn't it? So maybe you can always call the
notifier, and if the dma mask isn't 36 bits, and the controller has the
window configured then you use swiotlb?

cheers

--=-X65o+dlHe2TfFARrdY8j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkntK+wACgkQdSjSd0sB4dK41QCdG4T50UEBDO9GSbF2MMI1oWX3
XBcAnAnZMGGX132n6zdEfk4XQ3Pxm3Ok
=unrn
-----END PGP SIGNATURE-----

--=-X65o+dlHe2TfFARrdY8j--
