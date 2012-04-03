Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 76011B6FE9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Apr 2012 11:41:58 +1000 (EST)
Date: Tue, 3 Apr 2012 11:41:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] powerpc/boot: Only build board support files when
 required.
Message-Id: <20120403114150.cbf53c999ed842b25e9932b5@canb.auug.org.au>
In-Reply-To: <20120403005558.GA9194@thor.bakeyournoodle.com>
References: <20120403005558.GA9194@thor.bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__3_Apr_2012_11_41_50_+1000_TPUDjNaPNt_3xsTS"
Cc: Frank =?UTF-8?B?U3ZlbmRzYsO4ZQ==?= <frank.svendsboe@gmail.com>,
 Wolfgang Denk <wd@denx.de>, robert.karl.berger@gmail.com,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__3_Apr_2012_11_41_50_+1000_TPUDjNaPNt_3xsTS
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Tue, 3 Apr 2012 10:55:59 +1000 Tony Breeds <tony@bakeyournoodle.com> wro=
te:
>
>  arch/powerpc/boot/Makefile |   69 +++++++++++++++++++++++++++++++++-----=
------
>  1 files changed, 52 insertions(+), 17 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index e8461cb..3d4d9ea 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -65,23 +65,58 @@ $(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simple=
boot.o epapr.o): \
>  src-wlib :=3D string.S crt0.S crtsavres.S stdio.c main.c \
>  		$(libfdt) libfdt-wrapper.c \
>  		ns16550.c serial.c simple_alloc.c div64.S util.S \
> -		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
> -		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
> -		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
> -		fsl-soc.c mpc8xx.c pq2.c ugecon.c
> -src-plat :=3D of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx=
.c holly.c \
> -		cuboot-ebony.c cuboot-hotfoot.c epapr.c treeboot-ebony.c \
> -		prpmc2800.c \
> -		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
> -		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c \
> -		cuboot-bamboo.c cuboot-mpc7448hpc2.c cuboot-taishan.c \
> -		fixed-head.S ep88xc.c ep405.c cuboot-c2k.c \
> -		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
> -		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
> -		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
> -		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c \
> -		gamecube-head.S gamecube.c wii-head.S wii.c treeboot-iss4xx.c \
> -		treeboot-currituck.c
> +		gunzip_util.c elf_util.c $(zlib) devtree.c stdlib.c \
> +		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
> +		uartlite.c mpc52xx-psc.c
> +src-plat :=3D of.c
> +ifeq ($(CONFIG_40x),y)
> +src-wlib  +=3D 4xx.c planetcore.c
> +src-plat +=3D fixed-head.S ep405.c cuboot-hotfoot.c treeboot-walnut.c \
> +		cuboot-acadia.c cuboot-kilauea.c \
> +		simpleboot.c virtex405-head.S virtex.c
> +endif

It is more ususal in the kernel makefiles to do something like:

src-wlib-$(CONFIG_40x) +=3D 4xx.c planetcore.c
src-plat-$(CONFIG_40x) +=3D fixed-head.S ep405.c cuboot-hotfoot.c treeboot-=
walnut.c \

...

and then use $(src-wlib-y) and $(src-plat-y)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__3_Apr_2012_11_41_50_+1000_TPUDjNaPNt_3xsTS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPelVeAAoJEECxmPOUX5FEWt8P/2Tk9kZzkh5jds0hWbtfG7ug
JbHQSz5h55psfIyKm0mdWRq1SP/Wi6YIKpwCoAzEwad/VfX9vS/4CqP3rZWllluP
owq4JspXHKW70pre2ecc7En/o8lNciX/AksEyFhJuWBftSFZtvK/3aiAdWG92PMv
ae9QAOhvTkRYlahc6b3Q5UjVj2p1YHCR0B4EGNLLrQ2lRRj9Xb5Q6yAQH2a4DsF4
JBWxvWtzv6+tLyYhjTShJnw08lTA6nhM+icJMCm1h4VSbXupOAmsHGOQYEbtCFAk
VTXxrkqtidAcxDruLXtcULVEQx8+1Sx49SJLOZNMeFvzC+vfKJePT6XGurwQV7k0
BH8Zh0QOcajXIjCuIHDWxJLF0gfxA6LnJpmETuHqg6QPAKHosS4nkLl6Qk3FZqCS
M3R+p0YlMcRhZJUyAJvmGAsiq1cMLje0MnTatlD5tCrvDDCY+nAQdr2oNsm3rXaD
fmH2J4I+luGCjMrwVORF3gXT24BRYuxiFvWnxBQEm+Akd8pNHqSKOqjiyqylEaI4
qAVLhb5AWGB0bdjSiCakFKwqkoPndKACjs11vkULO/GOpzvW/ApfaputvHwrOgMv
hUKeVk2XOkBk13SV6O1fDoDVlzcgGLzz/pjrmKg8YqcYf2kh+BOdfDDseuO0voxm
dgG6FRWxTw5zSyCExmiE
=qluG
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Apr_2012_11_41_50_+1000_TPUDjNaPNt_3xsTS--
