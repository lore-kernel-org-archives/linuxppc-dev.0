Date: Mon, 7 Aug 2000 09:31:24 -0400
From: Josh Huber <huber@mclx.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] Re: Kind of success! (r128 on PPC (Re: LinuxPPC X Server))
Message-ID: <20000807093124.B248@mclx.com>
References: <Pine.LNX.4.21.0008041831040.29474-100000@idd-01.imbc.gr> <20000805184351.19510@192.168.1.10> <398E6051.6DA84197@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
In-Reply-To: <398E6051.6DA84197@student.ethz.ch>; from daenzerm@student.ethz.ch on Mon, Aug 07, 2000 at 09:08:01AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2000 at 09:08:01AM +0200, Michel D?nzer wrote:
> Benjamin Herrenschmidt wrote:
> > The Pismo allows that by scaling the LCD, but I don't think code for th=
at
> > is implemented in the XFree r128 driver (I didn't check lately).
>=20
> No it doesn't work, neither with aty128fb. Would that be hard to implemen=
t?

If it's anything like the mach 64, it shouldn't be hard to implement
at all.  you just have to program 3 registers.

Speaking of this, I'm having trouble with the stretching setup for my
wallstreet.  It works fine in console mode, but something in the X
server is messing with the chip setup in a way to screw up the
rendering.  After playing with it I was able to get proper output:

console settings:
    mclk =3D 99.844107 MHz
    vclk =3D 44.702930 MHz
    dsp_loop_latency =3D 10
    dsp_precision =3D 5
    dsp_xclks_per_row =3D 1143 =3D> 17.859375
    dsp_on =3D 69 =3D> 34.500000
    dsp_off =3D 1113 =3D> 556.500000

X (xf4.0.1) settings:
    mclk =3D 99.844107 MHz
    vclk =3D 44.702930 MHz
    dsp_loop_latency =3D 10
    dsp_precision =3D 4
    dsp_xclks_per_row =3D 1143 =3D> 8.929688
    dsp_on =3D 103 =3D> 25.750000
    dsp_off =3D 1119 =3D> 279.750000

X after tweaks to get it working properly:
    mclk =3D 99.844107 MHz
    vclk =3D 59.603906 MHz
    dsp_loop_latency =3D 10
    dsp_precision =3D 4
    dsp_xclks_per_row =3D 1143 =3D> 8.929688
    dsp_on =3D 131 =3D> 32.750000
    dsp_off =3D 1986 =3D> 496.500000

using geerts handy ati debugging application, I set the vclk post
divider to 3 (was 4), and changed the high and low watermarks back to
what the console settings were, and things worked great in X now.  Of
course, if I switch back to a VC and back to X the old (bad) settings
come back.

Where's the proper place to fix this?  I assume it's not in the fbcon
interface, because text mode is correctly displayed.

Thoughts?

--=20
Josh
6B21489A | GnuPG ID/Fingerprint | huber@mclx.com |
61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-Disposition: inline


--aM3YZ0Iwxop3KEKx--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
