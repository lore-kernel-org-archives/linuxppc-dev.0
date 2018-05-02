Return-Path: <laurentiu.tudor@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0084.outbound.protection.outlook.com [104.47.2.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bXfF45zlzF2Ss
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 19:14:28 +1000 (AEST)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Nipun Gupta <nipun.gupta@nxp.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "hch@lst.de" <hch@lst.de>, "joro@8bytes.org" <joro@8bytes.org>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: ls208xa: comply with the iommu map
 binding for fsl_mc
Date: Wed, 2 May 2018 09:14:18 +0000
Message-ID: <5AE98169.7060102@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-7-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1525069641-8523-7-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nipun,

On 04/30/2018 09:27 AM, Nipun Gupta wrote:
> fsl-mc bus support the new iommu-map property. Comply to this binding
> for fsl_mc bus.
>
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>

This looks good to me, so:

Reviewed-By: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

> ---
>   arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/=
boot/dts/freescale/fsl-ls208xa.dtsi
> index 137ef4d..6010505 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -184,6 +184,7 @@
>   		#address-cells =3D <2>;
>   		#size-cells =3D <2>;
>   		ranges;
> +		dma-ranges =3D <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
>
>   		clockgen: clocking@1300000 {
>   			compatible =3D "fsl,ls2080a-clockgen";
> @@ -357,6 +358,8 @@
>   			reg =3D <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
>   			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
>   			msi-parent =3D <&its>;
> +			iommu-map =3D <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
> +			dma-coherent;
>   			#address-cells =3D <3>;
>   			#size-cells =3D <1>;
>
> @@ -460,6 +463,8 @@
>   			compatible =3D "arm,mmu-500";
>   			reg =3D <0 0x5000000 0 0x800000>;
>   			#global-interrupts =3D <12>;
> +			#iommu-cells =3D <1>;
> +			stream-match-mask =3D <0x7C00>;
>   			interrupts =3D <0 13 4>, /* global secure fault */
>   				     <0 14 4>, /* combined secure interrupt */
>   				     <0 15 4>, /* global non-secure fault */
> @@ -502,7 +507,6 @@
>   				     <0 204 4>, <0 205 4>,
>   				     <0 206 4>, <0 207 4>,
>   				     <0 208 4>, <0 209 4>;
> -			mmu-masters =3D <&fsl_mc 0x300 0>;
>   		};
>
>   		dspi: dspi@2100000 {
>=
