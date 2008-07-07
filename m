Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 92768DDEEB
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 19:23:54 +1000 (EST)
Received: from leda.ptxnet.pengutronix.de ([10.1.0.71] ident=Debian-exim)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <wsa@pengutronix.de>) id 1KFmwl-0003Nx-Mn
	for linuxppc-dev@ozlabs.org; Mon, 07 Jul 2008 11:23:47 +0200
Received: from wsa by leda.ptxnet.pengutronix.de with local (Exim 4.67)
	(envelope-from <wsa@pengutronix.de>) id 1KFmwl-0004gY-3o
	for linuxppc-dev@ozlabs.org; Mon, 07 Jul 2008 11:23:47 +0200
Date: Mon, 7 Jul 2008 11:23:47 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Merging seperate FDT-blobs?
Message-ID: <20080707092347.GB4409@pengutronix.de>
References: <20080612090433.GA4235@pengutronix.de>
	<20080613042304.GD29451@yookeroo.seuss>
	<20080620161033.GE17701@pengutronix.de>
	<20080623050624.GA23064@yookeroo.seuss>
	<20080627170547.GF3931@pengutronix.de>
	<20080707012843.GF6267@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
In-Reply-To: <20080707012843.GF6267@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2008 at 11:28:43AM +1000, David Gibson wrote:

> > This function is surely needed in every case I considered so far. I am
> > just sceptical if the boot-loader can determine a correct parentoffset
> > all alone (which one of the two I2C busses is the correct one?). This is
>=20
> Hrm.  "all alone".  It's not clear to me what else there could be that
> would have more information than the bootloader.

What I meant is that all the information a bootloader has may not be
sufficent. To solve this, some additional infos could be added to the
tree. In this case, it could be a few aliases.

> > What I encoded using "external-name" is where possible fragments
> > _could_ be added to. Something like a mount-point. The boot-loader
> > decides if and what could be mounted there. As an "/aliases" node is
> > already in use, I would favour to add such mount-points there.
>=20
> Hrm.  I'm not convinced that the mount point model is actually a good
> one.  I would have thought that one of the most common things to graft
> would be extra optional devices onto a bus.  In this case there's no
> specific "mountpoint"  the device could be attached at any valid
> address on the bus in question.

Maybe I am really missing something here, but what is the bus in
question? How do you tell from such an entry

rtc@51{
	device_type=3D"rtc";
	compatible=3D"nxp,pcf8563";
	reg=3D<0x51>;
};

if it is connected to "/pci/pci_bridge/isa" as in mpc8548cds.dts or to
"/soc5200/i2c@3d40" as in pcm030.dts? The latter even has another
I2C-bus i2c@3d00 which could also be a possibility. This is why I'd like
to encode the fragment as:

i2c_0 {
	rtc@51{
		device_type=3D"rtc";
		compatible=3D"nxp,pcf8563";
		reg=3D<0x51>;
	};
};

with i2c_0 being an alias to the proper bus. Maybe I should add that I
am _not_ assuming that the fragment is obtained from the bus which wants to
have devices added. That is, one I2C-eeprom may contain data about
additional devices on PCI.

Kind regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIceCjD27XaX1/VRsRAidpAKDCz2YgodkpKHeJyUjYWH7QHHlAWACfSWTl
M5iOGBeVesmappkqplAdaOE=
=T3zD
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
