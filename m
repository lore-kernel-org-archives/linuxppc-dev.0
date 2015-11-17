Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B4D11A02BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 11:28:43 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so191191524pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 16:28:41 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 19/50] powerpc/powernv: Track DMA32 segment consumption
In-Reply-To: <1446642770-4681-20-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-20-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Tue, 17 Nov 2015 11:28:20 +1100
Message-ID: <87ziydbhaz.fsf@gamma.ozlabs.ibm.com>
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

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> Similar to the mechanism tracking consumed IO/M32/M64 segments,
> this introduces an array for each PHB to track the consumed DMA32
> segments, which are going to be released on PCI unplugging time.
> The index of the array is the DMA32 segment number while the value
> stored in the element is the assigned PE number.
>


> +	/* Setup TCE32 segment mapping */
Do you mean DMA32 rather than TCE32?
> +	for (i =3D base; i < base + segs; i++)
> +		phb->ioda.dma32_segmap[i] =3D pe->pe_number;
> +
I'm pretty sure this is right, but can you just confirm that you
intended to index into the array starting at base and going to base + segs,
and not going from 0 to segs? (i.e. not dma32_segmap[i - base]).

Otherwise looks good.

Regards,
Daniel

>  	/* Setup linux iommu table */
>  	pnv_pci_setup_iommu_table(tbl, addr, tce32_segsz * segs,
>  				  base * PNV_IODA1_DMA32_SEGSIZE,
> @@ -2378,13 +2382,13 @@ static void pnv_pci_ioda1_setup_dma(struct pnv_ph=
b *phb)
>  	 * then we assign at least one segment per PE, plus more based
>  	 * on the amount of devices under that PE
>  	 */
> -	if (dma_pe_count > phb->ioda.tce32_count)
> +	if (dma_pe_count > phb->ioda.dma32_count)
>  		residual =3D 0;
>  	else
> -		residual =3D phb->ioda.tce32_count - dma_pe_count;
> +		residual =3D phb->ioda.dma32_count - dma_pe_count;
>=20=20
>  	pr_info("PCI: Domain %04x has %ld available 32-bit DMA segments\n",
> -		hose->global_number, phb->ioda.tce32_count);
> +		hose->global_number, phb->ioda.dma32_count);
>  	pr_info("PCI: %d PE# for a total weight of %d\n",
>  		dma_pe_count, total_weight);
>=20=20
> @@ -2394,7 +2398,7 @@ static void pnv_pci_ioda1_setup_dma(struct pnv_phb =
*phb)
>  	 * out one base segment plus any residual segments based on
>  	 * weight
>  	 */
> -	remaining =3D phb->ioda.tce32_count;
> +	remaining =3D phb->ioda.dma32_count;
>  	base =3D 0;
>  	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>  		weight =3D pnv_pci_ioda_pe_dma_weight(pe);
> @@ -3094,7 +3098,8 @@ static void __init pnv_pci_init_ioda_phb(struct dev=
ice_node *np,
>  {
>  	struct pci_controller *hose;
>  	struct pnv_phb *phb;
> -	unsigned long size, m64map_off, m32map_off, pemap_off, iomap_off =3D 0;
> +	unsigned long size, m64map_off, m32map_off, pemap_off;
> +	unsigned long iomap_off =3D 0, dma32map_off =3D 0;
>  	const __be64 *prop64;
>  	const __be32 *prop32;
>  	int i, len;
> @@ -3177,6 +3182,10 @@ static void __init pnv_pci_init_ioda_phb(struct de=
vice_node *np,
>  	phb->ioda.io_segsize =3D phb->ioda.io_size / phb->ioda.total_pe_num;
>  	phb->ioda.io_pci_base =3D 0; /* XXX calculate this ? */
>=20=20
> +	/* Calculate how many 32-bit TCE segments we have */
> +	phb->ioda.dma32_count =3D phb->ioda.m32_pci_base /
> +				PNV_IODA1_DMA32_SEGSIZE;
> +
>  	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
>  	size =3D _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
>  	m64map_off =3D size;
> @@ -3186,6 +3195,9 @@ static void __init pnv_pci_init_ioda_phb(struct dev=
ice_node *np,
>  	if (phb->type =3D=3D PNV_PHB_IODA1) {
>  		iomap_off =3D size;
>  		size +=3D phb->ioda.total_pe_num * sizeof(phb->ioda.io_segmap[0]);
> +		dma32map_off =3D size;
> +		size +=3D phb->ioda.dma32_count *
> +			sizeof(phb->ioda.dma32_segmap[0]);
>  	}
>  	pemap_off =3D size;
>  	size +=3D phb->ioda.total_pe_num * sizeof(struct pnv_ioda_pe);
> @@ -3201,6 +3213,10 @@ static void __init pnv_pci_init_ioda_phb(struct de=
vice_node *np,
>  		phb->ioda.io_segmap =3D aux + iomap_off;
>  		for (i =3D 0; i < phb->ioda.total_pe_num; i++)
>  			phb->ioda.io_segmap[i] =3D IODA_INVALID_PE;
> +
> +		phb->ioda.dma32_segmap =3D aux + dma32map_off;
> +		for (i =3D 0; i < phb->ioda.dma32_count; i++)
> +			phb->ioda.dma32_segmap[i] =3D IODA_INVALID_PE;
>  	}
>  	phb->ioda.pe_array =3D aux + pemap_off;
>  	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
> @@ -3208,10 +3224,6 @@ static void __init pnv_pci_init_ioda_phb(struct de=
vice_node *np,
>  	INIT_LIST_HEAD(&phb->ioda.pe_list);
>  	mutex_init(&phb->ioda.pe_list_mutex);
>=20=20
> -	/* Calculate how many 32-bit TCE segments we have */
> -	phb->ioda.tce32_count =3D phb->ioda.m32_pci_base /
> -				PNV_IODA1_DMA32_SEGSIZE;
> -
>  #if 0 /* We should really do that ... */
>  	rc =3D opal_pci_set_phb_mem_window(opal->phb_id,
>  					 window_type,
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platform=
s/powernv/pci.h
> index 2038ef2..0802fcd 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -148,6 +148,10 @@ struct pnv_phb {
>  			int			*m32_segmap;
>  			int			*io_segmap;
>=20=20
> +			/* DMA32 segment maps - IODA1 only */
> +			unsigned long		dma32_count;
> +			int			*dma32_segmap;
> +
>  			/* IRQ chip */
>  			int			irq_chip_init;
>  			struct irq_chip		irq_chip;
> @@ -164,9 +168,6 @@ struct pnv_phb {
>  			 */
>  			unsigned char		pe_rmap[0x10000];
>=20=20
> -			/* 32-bit TCE tables allocation */
> -			unsigned long		tce32_count;
> -
>  			/* TCE cache invalidate registers (physical and
>  			 * remapped)
>  			 */
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

iQIcBAEBCgAGBQJWSnSkAAoJEPC3R3P2I92FQbAQAKyQDAQYAA88PgO5qHX+0nUH
BQLJCH8uXSaLflsgCOpnWy9lv5jMzl5MpF1phbadTYTiVO6W/aZEUq+HhQ4ZBMgP
fdhae3yUCQXAxsdeaSCvsFMDnVRacuh0Lqg4eznwrt0OEaCvtrROjpSl2A2kpgNv
ZkMBblBcuQp3FXdqi6WPK2FS87jLgGPS1SxQQTnhNXrfxkGKXiQqhI1FRYRU18fz
fP5tCik9BXdLU63qXTS8zbzvdE2jpqXoZjsDCrlfUp7NZ0Jy1pfD8KOXN5zBmHmu
kYy03HAfvQO56foy5NEjTTgTFJwnmK9p9m+Rfc9nKmqm4QYN/0dAvKIcKRbfewVb
Y/hd/DYpje/VwJ0dZk170f4uhuRcS8tqTsFqjYriNG/uyVisQQAs3a1S4/vaxc7L
pOXH8iXPgD55zZWVyvqHQec1/Tu+FjVaEMiDBeqv37apbDViPonoy85BSTcUG9Bl
AJ/Lkz/uFlDaEkFQBSFCuMHi5kSDpvm57T2lLbN83pGt35fW9OFq/o+yWYa/SRbO
jL7Ppqko06sbr17h3/2oHTkpMINx124GKlBp1m+ih2hz0P3cKSoWk+kEzzClTLvY
BQLN/RVQiGKye5aTcoiebAHuQrXlcwU18Y9fkcHmMg5PbNCHzFUASBnvmj8A5t5k
RMQktBepybjKYACRwG69
=RUYs
-----END PGP SIGNATURE-----
--=-=-=--
