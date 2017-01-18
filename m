Return-Path: <robherring2@gmail.com>
Received: from mail-ot0-f194.google.com (mail-ot0-f194.google.com
 [74.125.82.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3gVr5n9RzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 08:45:08 +1100 (AEDT)
Received: by mail-ot0-f194.google.com with SMTP id 65so2442922otq.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 13:45:08 -0800 (PST)
Date: Wed, 18 Jan 2017 15:45:05 -0600
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH 28/37] dt-bindings: PCI: dra7xx: Add dt bindings for pci
 dra7xx EP mode
Message-ID: <20170118214505.5kcoowi4ooy7eepg@rob-hp-laptop>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-29-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484216786-17292-29-git-send-email-kishon@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2017 at 03:56:17PM +0530, Kishon Vijay Abraham I wrote:
> Add device tree binding documentation for pci dra7xx EP mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt |   37 ++++++++++++++++++----
>  1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> index 60e2516..62f5f59 100644
> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> @@ -1,17 +1,22 @@
>  TI PCI Controllers
>  
>  PCIe Designware Controller
> - - compatible: Should be "ti,dra7-pcie""
> - - reg : Two register ranges as listed in the reg-names property
> - - reg-names : The first entry must be "ti-conf" for the TI specific registers
> -	       The second entry must be "rc-dbics" for the designware pcie
> -	       registers
> -	       The third entry must be "config" for the PCIe configuration space
> + - compatible: Should be "ti,dra7-pcie" for RC
> +	       Should be "ti,dra7-pcie-ep" for EP
>   - phys : list of PHY specifiers (used by generic PHY framework)
>   - phy-names : must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
>  	       number of PHYs as specified in *phys* property.
>   - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
>  	       where <X> is the instance number of the pcie from the HW spec.
> + - num-lanes as specified in ../designware-pcie.txt
> +
> +HOST MODE
> +=========
> + - reg : Two register ranges as listed in the reg-names property
> + - reg-names : The first entry must be "ti-conf" for the TI specific registers
> +	       The second entry must be "rc-dbics" for the designware pcie
> +	       registers
> +	       The third entry must be "config" for the PCIe configuration space
>   - interrupts : Two interrupt entries must be specified. The first one is for
>  		main interrupt line and the second for MSI interrupt line.
>   - #address-cells,
> @@ -19,13 +24,31 @@ PCIe Designware Controller
>     #interrupt-cells,
>     device_type,
>     ranges,
> -   num-lanes,
>     interrupt-map-mask,
>     interrupt-map : as specified in ../designware-pcie.txt
>  
> +DEVICE MODE
> +===========
> + - reg : Four register ranges as listed in the reg-names property
> + - reg-names : "ti-conf" for the TI specific registers
> +	       "ep_dbics" for the standard configuration registers as
> +		they are locally accessed within the DIF CS space
> +	       "ep_dbics2" for the standard configuration registers as
> +		they are locally accessed within the DIF CS2 space
> +	       "addr_space" used to map remote RC address space
> + - interrupts : one interrupt entries must be specified for main interrupt.
> + - num-ib-windows : number of inbound address translation windows
> + - num-ob-windows : number of outbound address translation windows
> +
>  Optional Property:
>   - gpios : Should be added if a gpio line is required to drive PERST# line
>  
> +NOTE: Two dt nodes should be added for each PCI controller; one for host

s/should/may/

Don't define dts source structure here. You could also have 2 files with 
each config and just include the right one for each board.

We don't want overlapping memory regions defined in DT and this kind of 
violates that, but I guess status is sufficient.

With that,

Acked-by: Rob Herring <robh@kernel.org>

> +mode and another for device mode. So in order for PCI to
> +work in host mode, EP mode dt node should be disabled and in order to PCI to
> +work in EP mode, host mode dt node should be disabled. And host mode and EP
> +mode are mutually exclusive.
> +
>  Example:
>  axi {
>  	compatible = "simple-bus";
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
