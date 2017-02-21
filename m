Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS5G755xQzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 14:14:55 +1100 (AEDT)
Date: Tue, 21 Feb 2017 13:52:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel] powerpc/powernv: Fix it_ops::get() callback to
 return in cpu endian
Message-ID: <20170221025258.GB27524@umbus>
References: <20170221023854.47493-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
In-Reply-To: <20170221023854.47493-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2017 at 01:38:54PM +1100, Alexey Kardashevskiy wrote:
> The iommu_table_ops callbacks are declared CPU endian as they take and
> return "unsigned long"; underlying hardware tables are big-endian.
>=20
> However get() was missing be64_to_cpu(), this adds the missing conversion.
>=20
> The only caller of this is crash dump at arch/powerpc/kernel/iommu.c,
> iommu_table_clear() which only compares TCE to zero so this change
> should not cause behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index c6d554fe585c..3f7f267a3d04 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -758,7 +758,7 @@ void pnv_tce_free(struct iommu_table *tbl, long index=
, long npages)
> =20
>  unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
>  {
> -	return *(pnv_tce(tbl, index - tbl->it_offset));
> +	return be64_to_cpu(*(pnv_tce(tbl, index - tbl->it_offset)));
>  }
> =20
>  struct iommu_table *pnv_pci_table_alloc(int nid)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYq6uHAAoJEGw4ysog2bOS/DEQALRjjbHtcVoT6xHEnylTaNEe
SQ1tjSBltoijF5W+QBTXqj4aOp0O9OGqAszpScpOE/vPtRSA8k6uMLusP2zliA2u
Y8K64slrNhKqcudHrzYz4TT6jzBpjdBM6sQU+qPV1n1vjjl40ck0bqec8SE7hf8D
45pvf2j9/CwHmYO9/AmTIA0fMksqvxsT9zfGgbvJc1JbBv4pPPR8EEJrzHLKeBNO
H1yNni330YvqKVO1/iHZ5JhSXAOb7WRja1sXFfGSs99jz0pXncTmaAPV8ZrXkbOS
6ExzfQruKRmpWdEbGWFqSt+ATosvb3PDU5HKM8d6nVEZNQBTrKLG7E35/3k/74n1
sqQkIqTiKj8f14LZv34xLXvuc8bk3NfukY4XGSvFA0Gyrim72+p1XLQOC2YKFXkE
3sG19pzLSTBtBCbp81HmGgkFuw9S/1BiUCkQX7azWAd2Xsi2qi3HuTsnRWsrQTej
xAyQoR2uppJ8bDJktkVusoEHpzsXRzKwTU7LRDGRSk0jHt5ZtuV+UiHalGGC9FWH
fraaOTrBviwVvLGXWW/nO9zNpbIuKgReKLjqb74CFB5xnT+PKjEoRcVlakdAn5/H
C+4BLmCPrghP9tR//0Kt1Gl/OSn9TP/qCmrF5ShMZhJuQrLJjf3ckAJb5hyNgwlL
2Uv84c1auLd0n7XyB3M0
=YU2r
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
