From: "Gregory P. Smith" <greg@electricrain.com>
Date: Mon, 6 Dec 1999 15:24:14 -0800
To: iweiny@pacbell.net
Cc: linuxdev <linuxppc-dev@lists.linuxppc.org>, usb <linux-usb@suse.com>
Subject: Re: [linux-usb] OHCI fix for Belkin BusPort card on PowerMac
Message-ID: <19991206152414.B8929@yyz.electricrain.com>
References: <199912062223.OAA05538@batcave2.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
In-Reply-To: <199912062223.OAA05538@batcave2.localdomain>; from iweiny@pacbell.net on Mon, Dec 06, 1999 at 02:23:12PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 1999 at 02:23:12PM -0800, iweiny@pacbell.net wrote:
>=20
> I am running:
> PowerMac 8500 (604 processor)
> USB BusPort from Belkin (Model: F5U005-MAC) PCI USB card
> 2.2.12 kernel (self compiled)
> 2.3.29 USB stack from Paul Mackerras's rsync tree
> opendis-0.0.3-pre4 from http://digitalux.netpedia.net
=2E..
> However, when requesting more data then the camera had to give the return=
ed
> status was "9" and not "0".  The OHCI driver interpreted this as an error=
 and
> subsequently the user level program would think no data had been returned.
>=20
> After verifing the data to be correct I applied a very simple correction =
of:
>=20
> /* Thinking this is what my controler returns when it is done? */
> #define USB_ST_EOF           9
>=20
> and used that to signal the ohci.c and dc2xx.c drivers that the "End of F=
ile"
> had been reached.
>=20
> My final question is:  Could this status be the same status as
>=20
> #define USB_ST_DATAUNDERRUN   -9
>=20
> or What does "data under run" mean?

Data underrun means the controller received less data that it asked
for in a transfer.  This is not really an error in many situations;
try modifying the dc2xx driver to accept it.

> It is obvious to me that my card has some unique status codes and I may r=
un
> into this in the future.  It is for this reason I will not include patche=
s for
> any of this unless others are like me with this type of card; trying to g=
et=20
> bulk messages to work.

It's not your card, its all controllers and a general "all slightly
different" state of the HCDs at the moment.  We're working on fixing
this with a move to a new cleaner device <-> usb stack/hcd interface.

--=20
Gregory P. Smith   pgp: http://suitenine.com/greg/pgp/
                   C379 1F92 3703 52C9 87C4  BE58 6CDA DB87 105D 9163

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.0 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEAREBAAYFAjhMRZ0ACgkQbNrbhxBdkWOqiACgm1joEwiCWPttS4tGpzE/7Lzp
kGsAn06c2kbliGKMKBjb4w6G1cwCAvPq
=+6f2
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
