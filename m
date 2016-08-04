Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4fTG36FKzDqRv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 16:01:38 +1000 (AEST)
Date: Thu, 4 Aug 2016 15:23:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 04/15] powerpc/powernv/ioda: Fix TCE invalidate to
 work in real mode again
Message-ID: <20160804052319.GG9189@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3xoW37o/FfUZJwQG"
In-Reply-To: <1470213656-1042-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 03, 2016 at 06:40:45PM +1000, Alexey Kardashevskiy wrote:
> "powerpc/powernv/pci: Rework accessing the TCE invalidate register"
> broke TCE invalidation on IODA2/PHB3 for real mode.
>=20
> This makes invalidate work again.
>=20
> Fixes: fd141d1a99a3
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 53b56c0..59c7e7d 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1877,7 +1877,7 @@ static void pnv_pci_phb3_tce_invalidate(struct pnv_=
ioda_pe *pe, bool rm,
>  					unsigned shift, unsigned long index,
>  					unsigned long npages)
>  {
> -	__be64 __iomem *invalidate =3D pnv_ioda_get_inval_reg(pe->phb, false);
> +	__be64 __iomem *invalidate =3D pnv_ioda_get_inval_reg(pe->phb, rm);
>  	unsigned long start, end, inc;
> =20
>  	/* We'll invalidate DMA address in PE scope */
> @@ -1935,10 +1935,12 @@ static void pnv_pci_ioda2_tce_invalidate(struct i=
ommu_table *tbl,
>  			pnv_pci_phb3_tce_invalidate(pe, rm, shift,
>  						    index, npages);
>  		else if (rm)
> +		{
>  			opal_rm_pci_tce_kill(phb->opal_id,
>  					     OPAL_PCI_TCE_KILL_PAGES,
>  					     pe->pe_number, 1u << shift,
>  					     index << shift, npages);
> +		}

These braces look a) unrelated to the actual point of the patch, b)
unnecessary and c) not in keeping with normal coding style.

>  		else
>  			opal_pci_tce_kill(phb->opal_id,
>  					  OPAL_PCI_TCE_KILL_PAGES,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3xoW37o/FfUZJwQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXotFHAAoJEGw4ysog2bOS1oQQAMUjeHXppo26JyGggINJVaRB
YpRiUfHgO0I13vVwSF7kjVhkVXW9p88IHBgO12wpXukv+9wmPxZDBeF+8ODwgRNb
wwfZffOe+KYsOgMuI43hr6gnX7JQ/vcTx+Fug/O+IyJtOeeS4DtDVKC+PPwH+zDw
H5kimTVNiqVE/uBEPffb4MbxHRMiAFBDQmDDktBrCTc5qhrxXK415OivN7rpuOHf
VYrYyO0RkDRcoC7MiIpFwB61CIO3Y+mvCxZYZSouK28PrHowCIacLfwvC/U63T7H
0g8ulQ/6bVBiiqxC7kkUBjdwXNe8F+0I6goPoibSJ4PmzQoe1aC08kirX2LWua4N
nPrmCCanp/YzG/Unnuh0BXa62echjGK3XKDEIVPWycKNnXXvJuqpH7qZnPZNlVuB
dBoIZ4bQhvjx41JgcXaJ+oRBLEuAI3xjhtWFEf8l+Y+ON3GdKxkBP2zu8nlaWNTQ
z7gmrgxJzzb5N5TXxvb0RIC95aRK1vQ+rMrxW6J/pdxcbvRevujDEpwNaNVeEZZX
+5nO4EOfvb5izlxCOtaNowSX67wjH3Ln/RNwrw04sDCCcwI33UtKFShfjrMGpBis
C+nKbrf50ockzca0WFQ+MlKRv+J8XE9tACQdEUg5HV4xsa4KRdMopKDBhrKpuaBr
OE6elM6JJvxPeMIYBd3+
=/Et+
-----END PGP SIGNATURE-----

--3xoW37o/FfUZJwQG--
