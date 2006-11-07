Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 929A067CD4
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 01:48:01 +1100 (EST)
Date: Tue, 7 Nov 2006 17:47:41 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kalle Pokki <kalle.pokki@iki.fi>
Subject: Re: [PATCH] CPM_UART: Fixed SMC handling for CPM2 processors
Message-ID: <20061107174741.3d837e19@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0611071451130.3291@host32.eke.fi>
References: <Pine.LNX.4.64.0611061523360.12023@host32.eke.fi>
	<20061106205543.43b2aacb@localhost.localdomain>
	<Pine.LNX.4.64.0611062237300.16727@host32.eke.fi>
	<20061107150842.6ac9e8ce@vitb.ru.mvista.com>
	<Pine.LNX.4.64.0611071451130.3291@host32.eke.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_IJkRtr3EQvQEC5=ee1SpURR";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: Paul, linuxppc-embedded@ozlabs.org, Mackerras <paulus@samba.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_IJkRtr3EQvQEC5=ee1SpURR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Nov 2006 15:21:00 +0200 (EET)
Kalle Pokki wrote:

> On Tue, 7 Nov 2006, Vitaly Bordug wrote:
>=20
> > Well, yes, but are you _sure_ pram_base will be the same across all
> > the 82xx PQ2, that happen to have smc wired to Ethernet?
> >
> > If not I am considering storing it in the platform_data is better
> > approach.
>=20
> Yes, pram_base is always 0x87fc for SMC1 and 0x88fc for SMC2. This is
> for all PowerQUICC II families (8260, 8272, and 8280). I'm not sure
> how PQ2 Pro and PQ3 and handled, but I suspect they don't share these=20
> definitions.
>=20
ok
> Anyway, I'm only extending the already existing conventions to the=20
> platform device approach. These same decisions have already been made
> in the past and are used in the cpm_uart compat mode. It may be that=20
> Freescale someday releases a microcode patch that relocates the SMC=20
> parameter RAM, but even in this case it would be better to use the
> same approach with compat mode and platform device mode to avoid
> confusion.
>=20
> I could have used the numerical address offsets in the resource=20
> definition, but I wanted to emphasize the fact that the offsets are=20
> already defined by the DPRAM memory allocator (this is a little
> hackish, yes) instead of hardware directly requiring these exact
> values.
>=20

Aha, I recall now. There was nearly exactly the same discussion in the past=
.=20
The recap was since ppc_platform_devices[] approach is not flexible enough,=
 revisit issue from the=20
arch/powerpc POV.=20

> This snippet is from cpm2.h:
>=20
>  	/* Dual Port RAM addresses.  The first 16K is available for
> almost
>  	 * any CPM use, so we put the BDs there.  The first 128
> bytes are
>  	 * used for SMC1 and SMC2 parameter RAM, so we start
> allocating
>  	 * BDs above that.  All of this must change when we start
>  	 * downloading RAM microcode.
>  	 */
>  	#define CPM_DATAONLY_BASE       ((uint)128)
>=20
> My patch puts pram_base exactly here.
>=20
>=20

I know, the questionable thing was if there is enough "value" to add yet an=
other platform device for that.

Since it improves current ppc being and sort of puts a note for powerpc por=
t, I'm inclined to ACK.

Thanks,

-Vitaly

--Sig_IJkRtr3EQvQEC5=ee1SpURR
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFUJyOuOg9JvQhSEsRAoR1AKCQygzAjQ8dAWJ2vMb4obSXGZHrUQCgo3vO
R9F+Wdaf0LkDmNAlZ3P5yRs=
=oGmL
-----END PGP SIGNATURE-----

--Sig_IJkRtr3EQvQEC5=ee1SpURR--
