Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Make cpu hotplug driver lock part of ppc_md
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4B30DB8B.3030305@austin.ibm.com>
References: <4B30DB8B.3030305@austin.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-4tpWRlct+opzcv+HgFDP"
Date: Wed, 23 Dec 2009 09:29:42 +1100
Message-ID: <1261520982.17348.8.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andreas Schwab <schwab@linux-m68k.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-4tpWRlct+opzcv+HgFDP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-12-22 at 08:45 -0600, Nathan Fontenot wrote:
> The recently introduced cpu_hotplug_driver_lock used to serialize
> cpu hotplug operations, namely for the pseries platform, causes a build
> issue for other platforms.  The base cpu hotplug code attempts
> to take this lock, but it may not be needed for all platforms.  This patc=
h
> moves the lock/unlock routines to be part of the ppc_md structure
> so that platforms needing the lock can take it.  This also makes the
> previous cpu_hotplug_driver_lock, defined in pseries code, pseries specif=
ic.
>=20
> The past failure without this patch was seen when building pmac and may
> be present in other platform builds.  The error is included below for ref=
erence.
>=20
> drivers/built-in.o: In function `.store_online':
> cpu.c:(.ref.text+0xf5c): undefined reference to `.cpu_hotplug_driver_lock=
'
> cpu.c:(.ref.text+0xfc8): undefined reference to `.cpu_hotplug_driver_unlo=
ck'
> make: *** [.tmp_vmlinux1] Error 1

Why does the pmac code /not/ need a lock? And would it be harmless if it
was locked too?

If so, you could just make the mutex available to all powerpc code, and
rename it, and then we wouldn't need all this jiggery pokery just to
take & release a lock.

cheers

--=-4tpWRlct+opzcv+HgFDP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksxSFMACgkQdSjSd0sB4dLw+gCdH0wZR+hKsxcpVDHDL1ejqHp0
BeMAn0wDyILsPFVfyKA9Fn7bXLz8twtb
=zOnF
-----END PGP SIGNATURE-----

--=-4tpWRlct+opzcv+HgFDP--
