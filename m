Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A044C2C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2013 08:54:42 +1100 (EST)
Date: Fri, 29 Mar 2013 16:54:34 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: workaround for chips with MSI
 hardware errata
To: Jia Hongtao <hongtao.jia@freescale.com>
In-Reply-To: <1364268527-32068-2-git-send-email-hongtao.jia@freescale.com>
 (from hongtao.jia@freescale.com on Mon Mar 25 22:28:47 2013)
Message-ID: <1364594074.13310.13@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: hongtao.jia@freescale.com, B07421@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/25/2013 10:28:47 PM, Jia Hongtao wrote:
> The MPIC version 2.0 has a MSI errata (errata PIC1 of mpc8544), It =20
> causes
> that neither MSI nor MSI-X can work fine. This is a workaround to =20
> allow
> MSI-X to function properly.
>=20
> Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_msi.c | 47 =20
> ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_msi.c =20
> b/arch/powerpc/sysdev/fsl_msi.c
> index 178c994..d2f8040 100644
> --- a/arch/powerpc/sysdev/fsl_msi.c
> +++ b/arch/powerpc/sysdev/fsl_msi.c
> @@ -28,6 +28,8 @@
>  #include "fsl_msi.h"
>  #include "fsl_pci.h"
>=20
> +#define MSI_HW_ERRATA_ENDIAN 0x00000010

This should probably be kept in the same place as the other =20
msi->features definitions (e.g. FSL_PIC_IP_*).

> +/* MPIC version 2.0 has erratum PIC1 */
> +static int mpic_has_errata(void)
> +{
> +	if (mpic_primary_get_version() =3D=3D 0x0200)
> +		return 1;
> +
> +	return 0;
> +}

mpic_has_erratum_pic1()

> +	if ((features->fsl_pic_ip & FSL_PIC_IP_MASK) =3D=3D =20
> FSL_PIC_IP_MPIC) {
> +		rc =3D mpic_has_errata();
> +		if (rc > 0) {
> +			msi->feature |=3D MSI_HW_ERRATA_ENDIAN;
> +		} else if (rc < 0) {
> +			err =3D rc;
> +			goto error_out;
> +		}

When would mpic_has_errata() ever return a negative value (maybe =20
mpic_primary_get_version could fail, but you don't allow for that in =20
the interface)?

If you're not going to add a way for errors to be returned back, just =20
do:

if (mpic_has_erratum_pic1())
	msi->feature |=3D MSI_HW_ERRATA_ENDIAN;

-Scott=
