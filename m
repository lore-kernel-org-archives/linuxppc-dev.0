Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zw2wL0Z2FzDr2R
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 01:53:29 +1100 (AEDT)
Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
To: Nipun Gupta <nipun.gupta@nxp.com>, will.deacon@arm.com,
 mark.rutland@arm.com, catalin.marinas@arm.com
Cc: iommu@lists.linux-foundation.org, robh+dt@kernel.org, hch@lst.de,
 m.szyprowski@samsung.com, gregkh@linuxfoundation.org, joro@8bytes.org,
 leoyang.li@nxp.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, bharat.bhushan@nxp.com, stuyoder@gmail.com,
 laurentiu.tudor@nxp.com
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5cdeded1-ca3c-339a-bf73-73401e7dd4ed@arm.com>
Date: Mon, 5 Mar 2018 14:53:21 +0000
MIME-Version: 1.0
In-Reply-To: <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/18 14:29, Nipun Gupta wrote:
> The existing IOMMU bindings cannot be used to specify the relationship
> between fsl-mc devices and IOMMUs. This patch adds a binding for
> mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.

Given that allowing "msi-parent" for #msi-cells > 1 is merely a 
backward-compatibility bodge full of hard-coded assumptions, why would 
we want to knowingly introduce a similarly unpleasant equivalent for 
IOMMUs? What's wrong with "iommu-map"?

> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
> ---
>   .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 31 ++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> index 6611a7c..011c7d6 100644
> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> @@ -9,6 +9,24 @@ blocks that can be used to create functional hardware objects/devices
>   such as network interfaces, crypto accelerator instances, L2 switches,
>   etc.
>   
> +For an overview of the DPAA2 architecture and fsl-mc bus see:
> +drivers/staging/fsl-mc/README.txt
> +
> +As described in the above overview, all DPAA2 objects in a DPRC share the
> +same hardware "isolation context" and a 10-bit value called an ICID
> +(isolation context id) is expressed by the hardware to identify
> +the requester.

IOW, precisely the case for which "{msi,iommu}-map" exist. Yes, I know 
they're currently documented under bindings/pci, but they're not really 
intended to be absolutely PCI-specific.

Robin.

> +The generic 'iommus' property is cannot be used to describe the relationship
> +between fsl-mc and IOMMUs, so an iommu-parent property is used to define
> +the same.
> +
> +For generic IOMMU bindings, see
> +Documentation/devicetree/bindings/iommu/iommu.txt.
> +
> +For arm-smmu binding, see:
> +Documentation/devicetree/bindings/iommu/arm,smmu.txt.
> +
>   Required properties:
>   
>       - compatible
> @@ -88,14 +106,27 @@ Sub-nodes:
>                 Value type: <phandle>
>                 Definition: Specifies the phandle to the PHY device node associated
>                             with the this dpmac.
> +Optional properties:
> +
> +- iommu-parent: Maps the devices on fsl-mc bus to an IOMMU.
> +  The property specifies the IOMMU behind which the devices on
> +  fsl-mc bus are residing.
>   
>   Example:
>   
> +        smmu: iommu@5000000 {
> +               compatible = "arm,mmu-500";
> +               #iommu-cells = <1>;
> +               stream-match-mask = <0x7C00>;
> +               ...
> +        };
> +
>           fsl_mc: fsl-mc@80c000000 {
>                   compatible = "fsl,qoriq-mc";
>                   reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
>                         <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
>                   msi-parent = <&its>;
> +                iommu-parent = <&smmu>;
>                   #address-cells = <3>;
>                   #size-cells = <1>;
>   
> 
