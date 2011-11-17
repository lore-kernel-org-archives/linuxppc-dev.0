Return-Path: <sfr@canb.auug.org.au>
Received: from calzone.tip.net.au (calzone.tip.net.au
 [IPv6:2402:b800:7003:1::15])
 by ozlabs.org (Postfix) with ESMTP id 0683FB7266
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 08:29:42 +1100 (EST)
Date: Fri, 18 Nov 2011 08:29:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: p1022ds: enable monitor switching via
 pixis indirect mode
Message-Id: <20111118082929.5ee8d4f07d84f2bf65e18006@canb.auug.org.au>
In-Reply-To: <1321556259-4459-2-git-send-email-timur@freescale.com>
References: <1321556259-4459-1-git-send-email-timur@freescale.com>
 <1321556259-4459-2-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__18_Nov_2011_08_29_29_+1100_HjDO6020wRlZdzhn"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__18_Nov_2011_08_29_29_+1100_HjDO6020wRlZdzhn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Timur,

On Thu, 17 Nov 2011 12:57:39 -0600 Timur Tabi <timur@freescale.com> wrote:
>
> @@ -129,44 +144,117 @@ static void p1022ds_set_gamma_table(enum fsl_diu_m=
onitor_port port,
>   */
>  static void p1022ds_set_monitor_port(enum fsl_diu_monitor_port port)
>  {
> -	struct device_node *np;
> -	void __iomem *pixis;
> -	u8 __iomem *brdcfg1;
> +	struct device_node *guts_node =3D NULL;

There is no point in initialising this as it is assigned before being
used.

> +	struct device_node *indirect_node =3D NULL;
> +	struct ccsr_guts_85xx __iomem *guts =3D NULL;
> +	u8 __iomem *lbc_lcs0_ba =3D NULL;
> +	u8 __iomem *lbc_lcs1_ba =3D NULL;

And if you had multiple error path labels, you could avoid these others
as well (and the NULL checks on the error path).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__18_Nov_2011_08_29_29_+1100_HjDO6020wRlZdzhn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOxXy5AAoJEECxmPOUX5FEH8IQAIGb5GidUJO5pRzbnReJp0r8
sBSPl1vmw8zjApe1Me9qYZWPUNhWH66r6CJdXjcjswGjNCe+kGlLhRJbVqguQEta
sqJC4G7FKWQv0FpxwvgUxQSMhM3ICA4qCx7G7Alf+URiglgYoPN8ye1gOElC5sTB
872Ohc001Z7ac0Dv9xEL+mmc7Hz1du0vyjwK5SpJR7WROWe99fPch4Ua0Hi5lPjf
H0omm4aTCZwORG3jQrG+jFyy/qTO/FtC7Jdddb0pZikl+qJ3yDDzZc6Rr50cd4E8
aeDBVuH4NmpCdmplAw0GNpw3Cj8pJJO20opsJZvYgYWyASfK+mcP9fo7IprWuvCS
Nqn1lVMFDKSTexk9bx4a+/lzWTj9GMvsWZ5KEXEV/yWHIYcnje824HVJB5Dko3A9
tI/nmvPFYAACX7ufnnrqLoLZR/Yq0AD/tN2y7sVGnWlZZiRBnG983mgC+UikIuko
hrOBhy+oDg8hIrvvui/ZQDlrSMCHI1VqwZ2VEEDaQL+mowcJ4LsUVABUFQ7Y7kgN
L6KaeQnyENaWgtNA2thED3iR171kmiltge+P9yHa532h0pqx14QraBN2xpzMkCqz
uKl/7TwkB7ABmpSk8xfsANyQOlvKCvZovfJCzL9Da0cWjKOLHCG6Pn0GSReRQcv3
xjimx7JRIaHVHQGXvdC2
=F3nm
-----END PGP SIGNATURE-----

--Signature=_Fri__18_Nov_2011_08_29_29_+1100_HjDO6020wRlZdzhn--
