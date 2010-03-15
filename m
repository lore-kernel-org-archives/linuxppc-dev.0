Return-Path: <michael@ellerman.id.au>
Subject: Re: 34-rc1-git3 build failure with CGROUP_MEM_RES_CTLR_SWAP=y
From: Michael Ellerman <michael@ellerman.id.au>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4B9CBEE6.1090509@in.ibm.com>
References: <4B9CBEE6.1090509@in.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-nqzhtNy1K9740rudgAhK"
Date: Mon, 15 Mar 2010 12:04:13 +1100
Message-ID: <1268615053.4644.10.camel@concordia>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	nishimura@mxp.nes.nec.co.jp, lizf@cn.fujitsu.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-nqzhtNy1K9740rudgAhK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2010-03-14 at 16:18 +0530, Sachin Sant wrote:
> On a PowerPC box, latest 34-rc1 git(d89b218b8...) fails to build
> with CGROUPS_MEM_RES_CTRL_SWAP=3Dy.=20
>=20
> LD      init/built-in.o
> LD      .tmp_vmlinux1
> mm/built-in.o: In function __xchg:
> arch/powerpc/include/asm/system.h:331: undefined reference to .__xchg_cal=
led_with_bad_pointer
> mm/built-in.o: In function __cmpxchg:
> arch/powerpc/include/asm/system.h:474: undefined reference to .__cmpxchg_=
called_with_bad_pointer
> make: *** [.tmp_vmlinux1] Error 1
>=20
> The code in question was added via commit 024914477e...
>=20
> memcg: move charges of anonymous swap

struct swap_cgroup
{                                                       =20
	unsigned short          id;
};

+unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
+                                       unsigned short old, unsigned short =
new)
+{
...
+       struct swap_cgroup *sc;
...
+       if (cmpxchg(&sc->id, old, new) =3D=3D old)


On powerpc cmpxchg() currently only handles u32 & u64.

cheers

--=-nqzhtNy1K9740rudgAhK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkudh4YACgkQdSjSd0sB4dIxQACfZS/VABlWyFgET+udrwqUhAnw
GXMAn28M1htbQpiisdvltR2fkRfzFeav
=lZR9
-----END PGP SIGNATURE-----

--=-nqzhtNy1K9740rudgAhK--
