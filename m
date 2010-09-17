Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A6FEBB70D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Sep 2010 14:27:57 +1000 (EST)
Date: Fri, 17 Sep 2010 14:27:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the final tree
	(powerpc related)
Message-Id: <20100917142748.1d47bd6d.sfr@canb.auug.org.au>
In-Reply-To: <20100903132410.ede593ed.sfr@canb.auug.org.au>
References: <20100903132410.ede593ed.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__17_Sep_2010_14_27_48_+1000_5RblX4xH0R2VcO7d"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__17_Sep_2010_14_27_48_+1000_5RblX4xH0R2VcO7d
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Fri, 3 Sep 2010 13:24:10 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the final tree, today's linux-next build
> (powerpc64 allnoconfig) failed like this:
>=20
> arch/powerpc/kernel/built-in.o: In function `.sys_call_table':
> (.text+0x8d48): undefined reference to `.compat_sys_recv'
>=20
> Caused by commit 86250b9d12caa1a3dee12a7cf638b7dd70eaadb6 ("powerpc: Wire
> up direct socket system calls").
>=20
> I have applied this patch for today:
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 3 Sep 2010 13:19:04 +1000
> Subject: [PATCH] powerpc: define a compat_sys_recv cond_syscall
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  kernel/sys_ni.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index bad369e..c782fe9 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -50,6 +50,7 @@ cond_syscall(compat_sys_sendmsg);
>  cond_syscall(sys_recvmsg);
>  cond_syscall(sys_recvmmsg);
>  cond_syscall(compat_sys_recvmsg);
> +cond_syscall(compat_sys_recv);
>  cond_syscall(compat_sys_recvfrom);
>  cond_syscall(compat_sys_recvmmsg);
>  cond_syscall(sys_socketcall);
> --=20
> 1.7.1

Ping?
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__17_Sep_2010_14_27_48_+1000_5RblX4xH0R2VcO7d
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMku5EAAoJEDMEi1NhKgbs6EEH/Ax31SmMd7ToBM1TPgWSTCzI
M71EnjcR44X9kEdZyEc0iGek4rPBuMkY9JdnKq7AGND95GYGgCXlUhada4v90NKG
yt1FToE7VxqqEnT5U9yhTmONNFQ4bLT7W/yc76CO8s4X7YiuPJrv332KBBmbi2fh
G8USUYgfrrOPNEoDixjaXdLwUfVUE422DxX2hMjSuaFOwbir9YAJSlfqJFfPU52r
75WLZtgLYZuGwMOJx/b+HH/NhITyimYx5OPay/8BSlHbGauV1wwQu7dJe2/lqwtw
sXizvbzdCxbNrmkkvvetJJEirA1rSdW3fwNRhnbTBM/j6xQ4mOPXZ3s7NxENQD8=
=9teI
-----END PGP SIGNATURE-----

--Signature=_Fri__17_Sep_2010_14_27_48_+1000_5RblX4xH0R2VcO7d--
