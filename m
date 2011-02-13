Return-Path: <michael@ellerman.id.au>
Subject: Re: Resources used by driver ?
From: Michael Ellerman <michael@ellerman.id.au>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201102101108.47647.dargaud@lpsc.in2p3.fr>
References: <201102101108.47647.dargaud@lpsc.in2p3.fr>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-P8slsxNG8AToGo0Bw+Uo"
Date: Mon, 14 Feb 2011 10:38:49 +1100
Message-ID: <1297640329.9492.15.camel@concordia>
Mime-Version: 1.0
Cc: LinuxPPC-dev <LinuxPPC-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-P8slsxNG8AToGo0Bw+Uo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-02-10 at 11:08 +0100, Guillaume Dargaud wrote:
> Thanks to the advice I received here, I now have my first 'real' Linux dr=
iver=20
> up and running and am now at the optimization stage.
>=20
> Is it possible to see the resources consumed by a module ? They don't sho=
w in=20
> 'ps/top' but I'm sure there are ways to see how much memory it uses (to c=
heck=20
> for memory leaks) and how much CPU it takes. How ?

Hi Guillaume,

It's actually not that easy to measure the resources used by a driver.
In general your driver code only runs on behalf of another process, and
so that process is where the cpu usage will be accounted.

One exception is if your driver spawns a kernel thread for something, in
that case you can see it with top.

For memory usage, you can monitor /proc/slabinfo and see if anything is
growing every time you access your driver. Another option is to enable
CONFIG_DEBUG_KMEMLEAK, which will try and detect real leaks for you.

cheers

--=-P8slsxNG8AToGo0Bw+Uo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk1Ya4kACgkQdSjSd0sB4dJmlACgrVCvUXmhZ1AhodMnMluvM8ff
mN4An2BQqFkERaan+dk5qG+mCyBZW9cY
=m1Rp
-----END PGP SIGNATURE-----

--=-P8slsxNG8AToGo0Bw+Uo--
