Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 5686E1007D9
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 11:15:25 +1100 (EST)
Date: Thu, 16 Feb 2012 11:15:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Build fail in hugetlbpage.c with linux-next and mpc85xx_defconfig
Message-Id: <20120216111513.918494b07a5331eabe3d32ac@canb.auug.org.au>
In-Reply-To: <14174.1329347321@neuling.org>
References: <14174.1329347321@neuling.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__16_Feb_2012_11_15_13_+1100_dv05nZy3IL++H+4Z"
Cc: Michael Neuling <mikey@neuling.org>, Pawel Moll <pawel.moll@arm.com>,
 linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
 McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__16_Feb_2012_11_15_13_+1100_dv05nZy3IL++H+4Z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rusty,

On Thu, 16 Feb 2012 10:08:41 +1100 Michael Neuling <mikey@neuling.org> wrot=
e:
>
> This has been broken in linux-next for a while.  Looks like a merge
> issue but you were the last to touch it...
>=20
> arch/powerpc/mm/hugetlbpage.c: In function 'reserve_hugetlb_gpages':
> arch/powerpc/mm/hugetlbpage.c:313: error: passing argument 5 of 'parse_ar=
gs' makes integer from pointer without a cast
> include/linux/moduleparam.h:317: note: expected 's16' but argument is of =
type 'int (*)(char *, char *)'
> arch/powerpc/mm/hugetlbpage.c:313: error: too few arguments to function '=
parse_args'

This was broken by commit b8076966e8e1 ("params: <level>_initcall-like
kernel parameters") from the rr tree which changed the parse_args() API wit=
hout fixing all
the callers ....

Please add a fix ...

Grep is your friend:

$ git grep -l '\<parse_args(' v3.3-rc1=20
v3.3-rc1:Documentation/target/tcm_mod_builder.py
v3.3-rc1:arch/powerpc/mm/hugetlbpage.c
v3.3-rc1:arch/x86/tools/insn_sanity.c
v3.3-rc1:arch/x86/tools/test_get_len.c
v3.3-rc1:include/linux/moduleparam.h
v3.3-rc1:init/main.c
v3.3-rc1:kernel/module.c
v3.3-rc1:kernel/params.c

(The Documentation and x86 ones are a false positives, the powerpc one is r=
eal)
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__16_Feb_2012_11_15_13_+1100_dv05nZy3IL++H+4Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPPEqRAAoJEECxmPOUX5FEmsEP/35Ra0ph/ST967T5JpYRoLsN
Js0Irr6H8VfTHUzSeyNRCfe20VroXuqw91bsqBtfBEggKeyTxpE7N9T/P4uWQ1kF
wYRM/+kOKS4rhpfjTyHi2Ykykghx4M3X21VjUWd6I4scWvDCKxjnKvolGYJs45ax
OADBrYtY8TAIng1c1Mm39PcuDviYAVHcJeaYYEhYc3QjGx4ggNjPv5eWDqsGiy8Q
yPLdXHPHPC83bOQwE7OjvWtt8/sshSKQIyJgDE945rthlYzvdsMux8Z/qOePXVSP
M/9hCQwi7ly0t8bbUsnu2rxmmuxUGGzsifjqUfU8hdSDpA5vfNJkGlbDvlqGkdL8
RBgNXm7NvATQJ5d03/MiZu18uv+i77yFd79fh/t3N57gdbwcNmrr8JCs+YM0zTC8
dqfbVuA/5DFbvXO4CehfsUIc2EOnVBNGppVcV4cRJjaStN4YV96KGQ3rn/wjbR1e
yCmqbc4laqOeDuysoY2xfXVwkJd5XnCax7AzGzbup5HZBfktbvIF26+JJUPDf+Ws
Plp0+UpX5Vgd6TX2cMoP7GuMp+6OGUsVqwbzFUMjKehIAYU2hxbFGUaZXLNtiFUK
0ioJdxOuen3jrejfjGnE//6s23VvBIGLUpb0Zfss8F9ZT2j1I2gMG0OQR03koZwt
P6hIdjdfCZ8JHHpWu1gi
=LwsZ
-----END PGP SIGNATURE-----

--Signature=_Thu__16_Feb_2012_11_15_13_+1100_dv05nZy3IL++H+4Z--
