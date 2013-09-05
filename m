Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 557292C00D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 04:34:39 +1000 (EST)
Subject: Re: [PATCH V2 2/2] powerpc/85xx: workaround for chips with MSI
 hardware errata
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1364954598-31914-2-git-send-email-hongtao.jia@freescale.com>
Date: Thu, 5 Sep 2013 13:34:41 -0500
Message-Id: <C12D1FFD-4D98-48C1-8681-54489600F722@kernel.crashing.org>
References: <1364954598-31914-1-git-send-email-hongtao.jia@freescale.com>
 <1364954598-31914-2-git-send-email-hongtao.jia@freescale.com>
To: Jia Hongtao <hongtao.jia@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 2, 2013, at 9:03 PM, Jia Hongtao wrote:

> The MPIC version 2.0 has a MSI errata (errata PIC1 of mpc8544), It =
causes
> that neither MSI nor MSI-X can work fine. This is a workaround to =
allow
> MSI-X to function properly.
>=20
> Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
> Changes for V2:
> * change the name of function mpic_has_errata() to =
mpic_has_erratum_pic1().
> * move MSI_HW_ERRATA_ENDIAN define to fsl_msi.h with all other =
defines.
>=20
> arch/powerpc/sysdev/fsl_msi.c | 40 =
+++++++++++++++++++++++++++++++++++++---
> arch/powerpc/sysdev/fsl_msi.h |  2 ++
> 2 files changed, 39 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_msi.c =
b/arch/powerpc/sysdev/fsl_msi.c
> index 178c994..ca1157a 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -98,8 +98,18 @@ static int fsl_msi_init_allocator(struct fsl_msi =
*msi_data)
>=20
> static int fsl_msi_check_device(struct pci_dev *pdev, int nvec, int =
type)
> {
> -	if (type =3D=3D PCI_CAP_ID_MSIX)
> -		pr_debug("fslmsi: MSI-X untested, trying anyway.\n");
> +	struct fsl_msi *msi;
> +
> +	if (type =3D=3D PCI_CAP_ID_MSI) {
> +		/*
> +		 * MPIC version 2.0 has erratum PIC1. For now MSI
> +		 * could not work. So check to prevent MSI from
> +		 * being used on the board with this erratum.
> +		 */
> +		list_for_each_entry(msi, &msi_head, list)
> +			if (msi->feature & MSI_HW_ERRATA_ENDIAN)
> +				return -EINVAL;
> +	}
>=20
> 	return 0;
> }
> @@ -142,7 +152,17 @@ static void fsl_compose_msi_msg(struct pci_dev =
*pdev, int hwirq,
> 	msg->address_lo =3D lower_32_bits(address);
> 	msg->address_hi =3D upper_32_bits(address);
>=20
> -	msg->data =3D hwirq;
> +	/*
> +	 * MPIC version 2.0 has erratum PIC1. It causes
> +	 * that neither MSI nor MSI-X can work fine.
> +	 * This is a workaround to allow MSI-X to function
> +	 * properly. It only works for MSI-X, we prevent
> +	 * MSI on buggy chips in fsl_msi_check_device().
> +	 */
> +	if (msi_data->feature & MSI_HW_ERRATA_ENDIAN)
> +		msg->data =3D __swab32(hwirq);
> +	else
> +		msg->data =3D hwirq;
>=20
> 	pr_debug("%s: allocated srs: %d, ibs: %d\n",
> 		__func__, hwirq / IRQS_PER_MSI_REG, hwirq % =
IRQS_PER_MSI_REG);
> @@ -361,6 +381,15 @@ static int fsl_msi_setup_hwirq(struct fsl_msi =
*msi, struct platform_device *dev,
> 	return 0;
> }
>=20
> +/* MPIC version 2.0 has erratum PIC1 */
> +static int mpic_has_erratum_pic1(void)
> +{
> +	if (fsl_mpic_primary_get_version() =3D=3D 0x0200)
> +		return 1;
> +
> +	return 0;
> +}
> +
> static const struct of_device_id fsl_of_msi_ids[];
> static int fsl_of_msi_probe(struct platform_device *dev)
> {
> @@ -423,6 +452,11 @@ static int fsl_of_msi_probe(struct =
platform_device *dev)
>=20
> 	msi->feature =3D features->fsl_pic_ip;
>=20
> +	if ((features->fsl_pic_ip & FSL_PIC_IP_MASK) =3D=3D =
FSL_PIC_IP_MPIC) {
> +		if (mpic_has_erratum_pic1())

Get ride of the mpic_has_erratum_pic1() function and just put the test =
here

> +			msi->feature |=3D MSI_HW_ERRATA_ENDIAN;
> +	}
> +
> 	/*
> 	 * Remember the phandle, so that we can match with any PCI nodes
> 	 * that have an "fsl,msi" property.
> diff --git a/arch/powerpc/sysdev/fsl_msi.h =
b/arch/powerpc/sysdev/fsl_msi.h
> index 8225f86..7389e8e 100644
> --- a/arch/powerpc/sysdev/fsl_msi.h
> +++ b/arch/powerpc/sysdev/fsl_msi.h
> @@ -25,6 +25,8 @@
> #define FSL_PIC_IP_IPIC   0x00000002
> #define FSL_PIC_IP_VMPIC  0x00000003
>=20
> +#define MSI_HW_ERRATA_ENDIAN 0x00000010
> +

Why does this need to be in the header, why not just have it in the .c =
only

> struct fsl_msi {
> 	struct irq_domain *irqhost;
>=20
> --=20
> 1.8.0
>=20
