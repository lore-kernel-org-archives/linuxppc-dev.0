Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvWWP6Wl3zDqR2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 19:16:49 +1000 (AEST)
Date: Wed, 20 Jul 2016 19:16:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org, #@ozlabs.ru,
 4.2+@ozlabs.ru
Subject: Re: [PATCH kernel] powerpc/powernv/ioda: Fix endianness when reading
 TCEs
Message-ID: <20160720091604.GC27358@voom.fritz.box>
References: <1468988811-49142-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
In-Reply-To: <1468988811-49142-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2016 at 02:26:51PM +1000, Alexey Kardashevskiy wrote:
> The iommu_table_ops::exchange() callback writes new TCE to the table
> and returns old value and permission mask. The old TCE value is
> correctly converted from BE to CPU endian; however permission mask
> was calculated from BE value and therefore always returned DMA_NONE
> which could cause memory leak on LE systems using VFIO SPAPR TCE IOMMU v1
> driver.
>=20
> This fixes pnv_tce_xchg() to have @oldtce a CPU endian.
>=20
> Fixes: 05c6cfb9dce0d13d37e9d007ee6a4af36f1c0a58
> Cc: stable@vger.kernel.org # 4.2+
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index 1d92bd9..7b17f88 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -620,8 +620,8 @@ int pnv_tce_xchg(struct iommu_table *tbl, long index,
>  	if (newtce & TCE_PCI_WRITE)
>  		newtce |=3D TCE_PCI_READ;
> =20
> -	oldtce =3D xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
> -	*hpa =3D be64_to_cpu(oldtce) & ~(TCE_PCI_READ | TCE_PCI_WRITE);
> +	oldtce =3D be64_to_cpu(xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce)));
> +	*hpa =3D oldtce & ~(TCE_PCI_READ | TCE_PCI_WRITE);
>  	*direction =3D iommu_tce_direction(oldtce);
> =20
>  	return 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXj0FUAAoJEGw4ysog2bOS2SMP/i1/WLqhSsQ8Ssgnekn96Uvp
1Sxb451//8XF6wgzLEpif6QCIAKrt0QpSS3XLh32ZyONcLovakZ9kLo61JMSovCg
NCqCzH1PVfDrRx62iMR+oCS7sil+mdncxPUQVctRK/nsgv5WTfjgw1VSuw2SP9Kl
VDVg7+XsA6bIWh3zfkQI1NHCOorJ9w6lhzHPufZv3UJnmkq/TxeAOqILMC0eBFkc
Bx/ACBF8Rl/lX82OTcCCZi4hEORyjwZSNRzA4fHwLeHEDFz3+16JWxqWFt5lJ6OF
RunkMD7XF2F291Gk475QwaPLENnu/H8yA1lJtfKXyU3HEq2Y6ZB3JItQKFaPJM7j
bEc3eXUxJgwRMTOm15fsolwf2GFCvjuDWrErrfM5Aawn5PbSk19M8ahv9WXlMRBa
d+rl0xi4yiEUnDVEIN78tEpfbMBdr5FMknihY0539nhgmqSq4wqHfUP8vnelLI6V
3DpWeRgVHZTF8ZFEEIqJPm5nUPCbC4nVc9sFZRPeSWNTYTSYOiM7YfFNOzsOnRGs
JmLiSLq6ZGkNUpQnwoQTqSXeIqfNszUFjQPf9wJo4KX78S74qUMRnun3qefIttUP
5s1WoNt8F3F8q4MXBX4dkJIaEjNHy9EfgG8GE+K1P7HCCFavcnReuzianvo7xyI3
psaWCLZmt1LhZc/8JyhA
=a8Tx
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
