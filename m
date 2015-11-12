Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 450C51A028B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 15:18:36 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so52005014pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2015 20:18:34 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 12/50] powerpc/powernv: Track M64 segment consumption
In-Reply-To: <1446642770-4681-13-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-13-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Thu, 12 Nov 2015 15:18:20 +1100
Message-ID: <87io57j1f7.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Looks good.

Will hold off on an official review until I can test the series.

Regards,
Daniel

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> As we track M32 segment consumption, this introduces an array to
> the PHB to track the mapping between M64 segment and PE number.
> The information is going to be used to find M64 segment from the
> PE number during PCI unplugging time in subsequent patches.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++--
>  arch/powerpc/platforms/powernv/pci.h      |  3 ++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 4ab93f8..76ce694 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -315,6 +315,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus,=
 bool all)
>  		phb->ioda.total_pe_num) {
>  		pe =3D &phb->ioda.pe_array[i];
>=20=20
> +		phb->ioda.m64_segmap[pe->pe_number] =3D pe->pe_number;
>  		if (!master_pe) {
>  			pe->flags |=3D PNV_IODA_PE_MASTER;
>  			INIT_LIST_HEAD(&pe->slaves);
> @@ -3018,7 +3019,7 @@ static void __init pnv_pci_init_ioda_phb(struct dev=
ice_node *np,
>  {
>  	struct pci_controller *hose;
>  	struct pnv_phb *phb;
> -	unsigned long size, m32map_off, pemap_off, iomap_off =3D 0;
> +	unsigned long size, m64map_off, m32map_off, pemap_off, iomap_off =3D 0;
>  	const __be64 *prop64;
>  	const __be32 *prop32;
>  	int i, len;
> @@ -3103,6 +3104,8 @@ static void __init pnv_pci_init_ioda_phb(struct dev=
ice_node *np,
>=20=20
>  	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
>  	size =3D _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
> +	m64map_off =3D size;
> +	size +=3D phb->ioda.total_pe_num * sizeof(phb->ioda.m64_segmap[0]);
>  	m32map_off =3D size;
>  	size +=3D phb->ioda.total_pe_num * sizeof(phb->ioda.m32_segmap[0]);
>  	if (phb->type =3D=3D PNV_PHB_IODA1) {
> @@ -3113,9 +3116,12 @@ static void __init pnv_pci_init_ioda_phb(struct de=
vice_node *np,
>  	size +=3D phb->ioda.total_pe_num * sizeof(struct pnv_ioda_pe);
>  	aux =3D memblock_virt_alloc(size, 0);
>  	phb->ioda.pe_alloc =3D aux;
> +	phb->ioda.m64_segmap =3D aux + m64map_off;
>  	phb->ioda.m32_segmap =3D aux + m32map_off;
> -	for (i =3D 0; i < phb->ioda.total_pe_num; i++)
> +	for (i =3D 0; i < phb->ioda.total_pe_num; i++) {
> +		phb->ioda.m64_segmap[i] =3D IODA_INVALID_PE;
>  		phb->ioda.m32_segmap[i] =3D IODA_INVALID_PE;
> +	}
>  	if (phb->type =3D=3D PNV_PHB_IODA1) {
>  		phb->ioda.io_segmap =3D aux + iomap_off;
>  		for (i =3D 0; i < phb->ioda.total_pe_num; i++)
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 2e01edd..671fd13 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -147,7 +147,8 @@ struct pnv_phb {
>  			unsigned long		*pe_alloc;
>  			struct pnv_ioda_pe	*pe_array;
>=20=20
> -			/* M32 & IO segment maps */
> +			/* M64/M32/IO segment maps */
> +			int			*m64_segmap;
>  			int			*m32_segmap;
>  			int			*io_segmap;
>=20=20
> --=20
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWRBMNAAoJEPC3R3P2I92FVm8P/RuuqTklgw3NyjkrzxIly6Xd
jbQV/STBvkuOtEaK7TDgYfeELKmCUkGeRxum1ZWuRRhGQmSSNtPIggmuLdwGACvI
oMNJzbwQOodex2rBFX07qqJlsM0ywKf+slWtXdxj0jq99kfMeurnYm2Vaea6UdiP
tNpfvUAWx//ZTQl/bIEkSHLNCVgu2szEYE1k1IsFjXPXvWgaPAG+p8fnzMb+1Sip
zd+kjZ5WHkwP8C/QaIQa8DJQ0arV79jYf1EaxEYyC1Ja9dkI4Duf29UKEHQwUlbU
mNU0HURvzh0loFRfjjCd9KoOjucUrpGzSKyQZbR/2fDyu8EXOD/217Xv0+uusbE3
1sKtGqfvQNFvjNTAsc2dmulH1J6HnDO1a5NzQ1DhyqISKJHBDzStLnUUFWckYi8f
o4h/RM3AYe5Gsn83FeweX/Fl1HFXB8uoec2eMQ9nkeL42CZuA36c0+vH23WyRZ09
XrAgGOjogdQNPD2AoFd0uMih7XwWHHSQjrs6wFkrCiJoM30oeY1LvwPyK/Y+77sV
CoLFh0yosI9mkQRuy4JjxsJEmH64e2VbZCTUyaxLaYOMFJZwOk/3ZcjWffWlCAub
jn/8Jp0x5Dlwo5AJXUOdNInD1Aaw0FamaR91HpCSg2zLpVqtmmZ7g4XKMzbsh+61
inR19LtpWxBV+XWhAzsu
=dzip
-----END PGP SIGNATURE-----
--=-=-=--
