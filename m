Return-Path: <dja@axtens.net>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CB4151A0C74
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Nov 2015 09:56:22 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so76309253pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2015 14:56:20 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 10/50] powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
In-Reply-To: <1446642770-4681-11-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-11-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Fri, 06 Nov 2015 09:56:06 +1100
Message-ID: <87r3k4hx89.fsf@gamma.ozlabs.ibm.com>
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

> The original implementation of pnv_ioda_setup_pe_seg() configures
> IO and M32 segments by separate logics, which can be merged by
> by caching @segmap, @seg_size, @win in advance. This shouldn't
> cause any behavioural changes.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 62 ++++++++++++++-----------=
------
>  1 file changed, 28 insertions(+), 34 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 7ee7cfe..553d3f3 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2752,8 +2752,10 @@ static void pnv_ioda_setup_pe_seg(struct pci_contr=
oller *hose,
>  	struct pnv_phb *phb =3D hose->private_data;
>  	struct pci_bus_region region;
>  	struct resource *res;
> -	int i, index;
> -	int rc;
> +	unsigned int segsize;
> +	int *segmap, index, i;
> +	uint16_t win;
> +	int64_t rc;

Good catch! Opal return codes are 64 bit and that should be explicit
in the type. However, I seem to remember that we preferred a different
type for 64 bit ints in the kernel. I think it's s64, and there are some
other uses of that in pci_ioda.c for return codes.

(I'm actually surprised that's not picked up as a compiler
warning. Maybe that's something to look at in future.)

The rest of the patch looks good on casual inspection - to be sure I'll
test the entire series on a machine. (hopefully, time permitting!)

Regards,
Daniel

>=20=20
>  	/*
>  	 * NOTE: We only care PCI bus based PE for now. For PCI
> @@ -2770,23 +2772,9 @@ static void pnv_ioda_setup_pe_seg(struct pci_contr=
oller *hose,
>  		if (res->flags & IORESOURCE_IO) {
>  			region.start =3D res->start - phb->ioda.io_pci_base;
>  			region.end   =3D res->end - phb->ioda.io_pci_base;
> -			index =3D region.start / phb->ioda.io_segsize;
> -
> -			while (index < phb->ioda.total_pe_num &&
> -			       region.start <=3D region.end) {
> -				phb->ioda.io_segmap[index] =3D pe->pe_number;
> -				rc =3D opal_pci_map_pe_mmio_window(phb->opal_id,
> -					pe->pe_number, OPAL_IO_WINDOW_TYPE, 0, index);
> -				if (rc !=3D OPAL_SUCCESS) {
> -					pr_err("%s: OPAL error %d when mapping IO "
> -					       "segment #%d to PE#%d\n",
> -					       __func__, rc, index, pe->pe_number);
> -					break;
> -				}
> -
> -				region.start +=3D phb->ioda.io_segsize;
> -				index++;
> -			}
> +			segsize      =3D phb->ioda.io_segsize;
> +			segmap       =3D phb->ioda.io_segmap;
> +			win          =3D OPAL_IO_WINDOW_TYPE;
>  		} else if ((res->flags & IORESOURCE_MEM) &&
>  			   !pnv_pci_is_mem_pref_64(res->flags)) {
>  			region.start =3D res->start -
> @@ -2795,23 +2783,29 @@ static void pnv_ioda_setup_pe_seg(struct pci_cont=
roller *hose,
>  			region.end   =3D res->end -
>  				       hose->mem_offset[0] -
>  				       phb->ioda.m32_pci_base;
> -			index =3D region.start / phb->ioda.m32_segsize;
> -
> -			while (index < phb->ioda.total_pe_num &&
> -			       region.start <=3D region.end) {
> -				phb->ioda.m32_segmap[index] =3D pe->pe_number;
> -				rc =3D opal_pci_map_pe_mmio_window(phb->opal_id,
> -					pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
> -				if (rc !=3D OPAL_SUCCESS) {
> -					pr_err("%s: OPAL error %d when mapping M32 "
> -					       "segment#%d to PE#%d",
> -					       __func__, rc, index, pe->pe_number);
> -					break;
> -				}
> +			segsize      =3D phb->ioda.m32_segsize;
> +			segmap       =3D phb->ioda.m32_segmap;
> +			win          =3D OPAL_M32_WINDOW_TYPE;
> +		} else {
> +			continue;
> +		}
>=20=20
> -				region.start +=3D phb->ioda.m32_segsize;
> -				index++;
> +		index =3D region.start / segsize;
> +		while (index < phb->ioda.total_pe_num &&
> +		       region.start <=3D region.end) {
> +			segmap[index] =3D pe->pe_number;
> +			rc =3D opal_pci_map_pe_mmio_window(phb->opal_id,
> +					pe->pe_number, win, 0, index);
> +			if (rc !=3D OPAL_SUCCESS) {
> +				pr_warn("%s: Error %lld mapping (%d) seg#%d to PHB#%d-PE#%d\n",
> +					__func__, rc, win, index,
> +					pe->phb->hose->global_number,
> +					pe->pe_number);
> +				break;
>  			}
> +
> +			region.start +=3D segsize;
> +			index++;
>  		}
>  	}
>  }
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

iQIcBAEBCgAGBQJWO96GAAoJEPC3R3P2I92Fp3wQAJUmEDH2VY7Sh2/y2+JpQ6tF
dMP1LatPxYmYQDhilcdXfvSewPR+Kdj/lLMDUZSRRIJ0ul8knBdiz22DP8l1oUTV
AQXyAYLmr+olseqJ1gxCM2Sqturlmpcp842ERDh/AszeyaiSQjfykh/f5gBeixnM
kmrnf1/vKshd1k/mTgaDFUhgkimTSumCqzFTYnd6StPSIcGR25RNXeb/qwTcyQ8U
k45tfD5PEX7baU+MY5Rgyppr/gYYT/2JHBeqh2hrGjA1BmCRvtPlH+RXCjOlr901
sq8QOjszl3mIWCdrtGwyqC+snPzYiMa8IVnpZAYtmfHD0KYS8chs/d8qaqZShmLt
ZUeF9YP0lsmvI3Dbj4sZI0ixUR8ksKs120+lWjQWontixjaP3K5qPAXPLBoxEsyh
Sayl+2aVuY1YVZDOVJsHoPRgr0e6c5sMKN4DrA+qvDaZJjAQ37waITS5paOavhWb
Y++THfVmLJrKDINHwK2rO/uxDJ/CfxIInbw6RaPJjJ0vIxgW97naF2rv28NSm7A4
U34qv6lLAageWNe6+PlDHihbKw3Rk5EzGIBKFPQK3YtPCUYTV2bgfeo1ruWc/Wqa
UutcCEalG0RVrVnE4ueHkFYFNP/j1cZ5dX09+04qP2PgCTAqDLpT0sZBUwxQfQbe
KfEP9vx5RHyVKK4aJ2OV
=EFtb
-----END PGP SIGNATURE-----
--=-=-=--
