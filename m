Return-Path: <hongtao.jia@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0130.outbound.protection.outlook.com [65.55.169.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F21631A0330
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 17:45:00 +1100 (AEDT)
From: Hongtao Jia <hongtao.jia@freescale.com>
To: Hongtao Jia <hongtao.jia@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH V3] powerpc/85xx: workaround for chips with MSI hardware
 errata
Date: Wed, 4 Mar 2015 06:44:52 +0000
Message-ID: <BLUPR03MB149E5EA1BFDEF4B1D07937DE11E0@BLUPR03MB149.namprd03.prod.outlook.com>
References: <1424935388-49100-1-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1424935388-49100-1-git-send-email-hongtao.jia@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

I sent V3 of this patch a few days ago.
Comments are welcome.

Thanks.
-Hongtao

> -----Original Message-----
> From: Jia Hongtao [mailto:hongtao.jia@freescale.com]
> Sent: Thursday, February 26, 2015 3:23 PM
> To: linuxppc-dev@lists.ozlabs.org; Wood Scott-B07421; asolokha@kb.kras.ru
> Cc: galak@kernel.crashing.org; Li Yang-Leo-R58472; Jia Hongtao-B38951
> Subject: [PATCH V3] powerpc/85xx: workaround for chips with MSI hardware
> errata
>=20
> From: Hongtao Jia <hongtao.jia@freescale.com>
>=20
> The MPIC version 2.0 has a MSI errata (errata PIC1 of mpc8544), It causes
> that neither MSI nor MSI-X can work fine. This is a workaround to allow
> MSI-X to function properly.
>=20
> Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
> Changes for V3:
> * remove mpic_has_erratum_pic1() function. Test erratum directly.
> * rebase on latest kernel update.
>=20
> Changes for V2:
> * change the name of function mpic_has_errata() to
> mpic_has_erratum_pic1().
> * move MSI_HW_ERRATA_ENDIAN define to fsl_msi.h with all other defines.
>=20
>  arch/powerpc/sysdev/fsl_msi.c | 29 ++++++++++++++++++++++++++---
>  arch/powerpc/sysdev/fsl_msi.h |  2 ++
>  2 files changed, 28 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_msi.c
> b/arch/powerpc/sysdev/fsl_msi.c
> index 4bbb4b8..f086c6f 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -162,7 +162,17 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev=
,
> int hwirq,
>  	msg->address_lo =3D lower_32_bits(address);
>  	msg->address_hi =3D upper_32_bits(address);
>=20
> -	msg->data =3D hwirq;
> +	/*
> +	 * MPIC version 2.0 has erratum PIC1. It causes
> +	 * that neither MSI nor MSI-X can work fine.
> +	 * This is a workaround to allow MSI-X to function
> +	 * properly. It only works for MSI-X, we prevent
> +	 * MSI on buggy chips in fsl_setup_msi_irqs().
> +	 */
> +	if (msi_data->feature & MSI_HW_ERRATA_ENDIAN)
> +		msg->data =3D __swab32(hwirq);
> +	else
> +		msg->data =3D hwirq;
>=20
>  	pr_debug("%s: allocated srs: %d, ibs: %d\n", __func__,
>  		 (hwirq >> msi_data->srs_shift) & MSI_SRS_MASK,
> @@ -180,8 +190,16 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev,
> int nvec, int type)
>  	struct msi_msg msg;
>  	struct fsl_msi *msi_data;
>=20
> -	if (type =3D=3D PCI_CAP_ID_MSIX)
> -		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");
> +	if (type =3D=3D PCI_CAP_ID_MSI) {
> +		/*
> +		 * MPIC version 2.0 has erratum PIC1. For now MSI
> +		 * could not work. So check to prevent MSI from
> +		 * being used on the board with this erratum.
> +		 */
> +		list_for_each_entry(msi_data, &msi_head, list)
> +			if (msi_data->feature & MSI_HW_ERRATA_ENDIAN)
> +				return -EINVAL;
> +	}
>=20
>  	/*
>  	 * If the PCI node has an fsl,msi property, then we need to use it
> @@ -446,6 +464,11 @@ static int fsl_of_msi_probe(struct platform_device
> *dev)
>=20
>  	msi->feature =3D features->fsl_pic_ip;
>=20
> +	/* For erratum PIC1 on MPIC version 2.0*/
> +	if ((features->fsl_pic_ip & FSL_PIC_IP_MASK) =3D=3D FSL_PIC_IP_MPIC
> +			&& (fsl_mpic_primary_get_version() =3D=3D 0x0200))
> +		msi->feature |=3D MSI_HW_ERRATA_ENDIAN;
> +
>  	/*
>  	 * Remember the phandle, so that we can match with any PCI nodes
>  	 * that have an "fsl,msi" property.
> diff --git a/arch/powerpc/sysdev/fsl_msi.h
> b/arch/powerpc/sysdev/fsl_msi.h
> index 420cfcb..a67359d 100644
> --- a/arch/powerpc/sysdev/fsl_msi.h
> +++ b/arch/powerpc/sysdev/fsl_msi.h
> @@ -27,6 +27,8 @@
>  #define FSL_PIC_IP_IPIC   0x00000002
>  #define FSL_PIC_IP_VMPIC  0x00000003
>=20
> +#define MSI_HW_ERRATA_ENDIAN 0x00000010
> +
>  struct fsl_msi_cascade_data;
>=20
>  struct fsl_msi {
> --
> 2.1.0.27.g96db324
