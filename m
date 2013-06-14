Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C4242C0079
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 08:09:23 +1000 (EST)
Received: from mail88-db9 (localhost [127.0.0.1])	by mail88-db9-R.bigfish.com
 (Postfix) with ESMTP id 399893E00CC	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 14 Jun 2013 22:09:17 +0000 (UTC)
Received: from DB9EHSMHS030.bigfish.com (unknown [10.174.16.227])	by
 mail88-db9.bigfish.com (Postfix) with ESMTP id B35C1300046	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 22:09:14 +0000 (UTC)
Date: Fri, 14 Jun 2013 17:09:11 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] powerpc/fsl_msi: add MSIIR1 support for MPIC v4.3
To: Minghuan Lian <Minghuan.Lian@freescale.com>
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 <1371194159-17332-2-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1371194159-17332-2-git-send-email-Minghuan.Lian@freescale.com>
 (from Minghuan.Lian@freescale.com on Fri Jun 14 02:15:56 2013)
Message-ID: <1371247751.2996.16@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/2013 02:15:56 AM, Minghuan Lian wrote:
> @@ -421,10 +440,29 @@ static int fsl_of_msi_probe(struct =20
> platform_device *dev)
>  		}
>  		msi->msiir_offset =3D
>  			features->msiir_offset + (res.start & 0xfffff);
> +
> +		/*
> +		 * First read the MSIIR/MSIIR1 offset from dts
> +		 * If failure use the hardcode MSIIR offset

"On failure"

> +		 */
> +		if (of_address_to_resource(dev->dev.of_node, 1, &msiir))
> +			msi->msiir_offset =3D features->msiir_offset +
> +					    (res.start & =20
> MSIIR_OFFSET_MASK);
> +		else
> +			msi->msiir_offset =3D msiir.start & =20
> MSIIR_OFFSET_MASK;
>  	}
>=20
>  	msi->feature =3D features->fsl_pic_ip;
>=20
> +	if (of_device_is_compatible(dev->dev.of_node, =20
> "fsl,mpic-msi-v4.3")) {
> +		msi->srs_shift =3D MSIIR1_SRS_SHIFT;
> +		msi->ibs_shift =3D MSIIR1_IBS_SHIFT;
> +
> +	} else {
> +		msi->srs_shift =3D MSIIR_SRS_SHIFT;
> +		msi->ibs_shift =3D MSIIR_IBS_SHIFT;
> +	}

Remove the blank line just before the "} else {".

> diff --git a/arch/powerpc/sysdev/fsl_msi.h =20
> b/arch/powerpc/sysdev/fsl_msi.h
> index 8225f86..43a9d99 100644
> --- a/arch/powerpc/sysdev/fsl_msi.h
> +++ b/arch/powerpc/sysdev/fsl_msi.h
> @@ -16,7 +16,7 @@
>  #include <linux/of.h>
>  #include <asm/msi_bitmap.h>
>=20
> -#define NR_MSI_REG		8
> +#define NR_MSI_REG		16
>  #define IRQS_PER_MSI_REG	32
>  #define NR_MSI_IRQS	(NR_MSI_REG * IRQS_PER_MSI_REG)

I don't see where you update all_avail in fsl_of_msi_probe.

We should also be bounds-checking the contents of msi-available-ranges.
Currently it looks like we just silently overrun the bitmap if we get =20
bad
input from the device tree.

-Scott=
