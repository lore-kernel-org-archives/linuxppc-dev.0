Return-Path: <balbi@ti.com>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6ABBBB6FBA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jun 2011 05:09:33 +1000 (EST)
Received: by mail-bw0-f42.google.com with SMTP id 18so9834649bwz.1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 13 Jun 2011 12:09:29 -0700 (PDT)
Date: Mon, 13 Jun 2011 22:09:25 +0300
From: Felipe Balbi <balbi@ti.com>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb:gadget: use min_t() macro instead of min()
Message-ID: <20110613190924.GN2353@legolas.emea.dhcp.ti.com>
References: <03db01cc29f4$d472bcb0$7d583610$@org>
	<Pine.LNX.4.44L0.1106131503040.1983-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zvl510+jvRFHh8wJ"
In-Reply-To: <Pine.LNX.4.44L0.1106131503040.1983-100000@iolanthe.rowland.org>
Cc: "'open list:FREESCALE USB PER...'" <linuxppc-dev@lists.ozlabs.org>,
	Tanya Brokhman <tlinder@codeaurora.org>, greg@kroah.com,
	linux-usb@vger.kernel.org,
	'open list' <linux-kernel@vger.kernel.org>, balbi@ti.com,
	linux-arm-msm@vger.kernel.org,
	"'open list:OMAP USB SUPPORT'" <linux-omap@vger.kernel.org>,
	ablay@codeaurora.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Zvl510+jvRFHh8wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 13, 2011 at 03:03:44PM -0400, Alan Stern wrote:
> > > The change I suggested involved replacing two typecasts with a single
> > > min_t.  All (or almost all) the places this patch touches currently
> > > contain only one typecast, so the motivation for changing them is a l=
ot
> > > weaker.
> > >=20
> > You're right. So what's the final call on this one? Do you think it can=
 be
> > merged or you prefer not change anything? I personally think the code l=
ooks
> > nicer using min_t instead of min with casting but that's just my opinio=
n and
> > of course there are arguments against this patch.
>=20
> I don't care either way.  It's up to you and Felipe.

I guess it's better to have a more critical look at the arguments first.
Looking into dummy_hcd for instance, it doesn't appear like we need to
be int, it could be unsigned int. I just skimmed through the code, but
it looks like we will always hold >=3D 0 values on that variable.

So go through that exercise first, then we look at the others. Blindly
changing to min_t() might not give us any improvements at all ;-)

--=20
balbi

--Zvl510+jvRFHh8wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN9mBkAAoJEAv8Txj19kN11+4H/R6MROCBTFIefSsDCLrhko2r
c3kGKqep/sWY33NQIYBZBkxwm8pwHpH+U9NOuBelm52VCUArTHDSzfGRBg/eplLn
y70fWG/yzuiTlJAwWXnuCTcMGRIQNqnv83EkyYcqt7agdLeMDTNJawOnmIdrDudG
bI7TyG3ma926Qt1yaUHdMR24M6gOeDxJGXF5uJ8rU6vI3HNI4k91QIFJCD5LZHZ7
eMD/K9Uzbbejr7QCV3O5Cdj3yuy8rMx1TbOQrGVMBk+dOwKsylaK48+FoM6ubN0T
CwCrJAREvvxWGrAdkqMw2UBywkzYyxHKPgCwwPKiqjau+Oci+oELzNJ/5vyzHuk=
=X898
-----END PGP SIGNATURE-----

--Zvl510+jvRFHh8wJ--
