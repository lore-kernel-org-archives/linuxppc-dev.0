Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 3 Aug 2010 16:17:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Dont require a dma_ops struct to set dma mask
Message-Id: <20100803161743.aae24903.sfr@canb.auug.org.au>
In-Reply-To: <1280769682-2839-1-git-send-email-galak@kernel.crashing.org>
References: <1280769682-2839-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__3_Aug_2010_16_17_43_+1000_RSMBAn/H0w6znSzl"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__3_Aug_2010_16_17_43_+1000_RSMBAn/H0w6znSzl
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Mon,  2 Aug 2010 12:21:22 -0500 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -131,9 +131,7 @@ static inline int dma_set_mask(struct device *dev, u6=
4 dma_mask)
>  {
>  	struct dma_map_ops *dma_ops =3D get_dma_ops(dev);
> =20
> -	if (unlikely(dma_ops =3D=3D NULL))
> -		return -EIO;
> -	if (dma_ops->set_dma_mask !=3D NULL)
> +	if (unlikely(dma_ops =3D=3D NULL) && (dma_ops->set_dma_mask !=3D NULL))

The first part of this condition is backward (should be !=3D (or just
"dma_ops") (and "likely"?)).

--=20
Stephen Rothwell <sfr@canb.auug.org.au>

--Signature=_Tue__3_Aug_2010_16_17_43_+1000_RSMBAn/H0w6znSzl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMV7SHAAoJEDMEi1NhKgbs2eIIAJpuv+ol0ZybIWnwY5dtFo2Y
vagofn+4eMYBRw/vCHjcQoigDfX6/CeoSivlsKFCQD96OdaIPrr9tuNwE5aIhAQ1
Y8Hqhx5jJj569ft33JrZHxCuUlPsRjkAxW7gIpv4qaPJM2gkreyBYcSaNRjvH+xj
3uBfM8YaslGYxVCRif0f8vFuvQzTD1gyhpJ9qWsSatJJFhaqJyPTLWc+a+Cv5EJt
5DbswFtTrGSerfbxRrxdixQQ4Lk8JwbIr0006RzNj7Fy0+BYIWnNHNkUHeB1JwmJ
a9VMePOD5WSwZnNFBuMwO0FTOpCDQlvJvyHWCsnee3GucGtPyxrOwHrrRVNa7iY=
=WYPl
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Aug_2010_16_17_43_+1000_RSMBAn/H0w6znSzl--
