Return-Path: <niklas.cassel@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vRcb956bXzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 19:43:01 +1100 (AEDT)
Subject: Re: [PATCH 2/4] PCI: dwc: dra7xx: Populate cpu_addr_fixup ops
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>
References: <1487251752-12478-1-git-send-email-kishon@ti.com>
 <1487251752-12478-3-git-send-email-kishon@ti.com>
CC: Joao Pinto <Joao.Pinto@synopsys.com>, <nsekhar@ti.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <2636ef0f-78e1-b38a-5864-c53a645e7073@axis.com>
Date: Mon, 20 Feb 2017 09:32:35 +0100
MIME-Version: 1.0
In-Reply-To: <1487251752-12478-3-git-send-email-kishon@ti.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kishon!


It's nice to see that you are improving the dwc framework+drivers.

pcie-artpec6.c has the same quirk as dra7xx,
see define ARTPEC6_CPU_TO_BUS_ADDR.

I could create a patch, but I guess it would make more sense
if it's part of this series.

Keep up the good work!


Regards,
Niklas


On 02/16/2017 02:29 PM, Kishon Vijay Abraham I wrote:
> Populate cpu_addr_fixup ops to extract the least 28 bits of the
> corresponding cpu address.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index 0984baf..07c45ec 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -88,6 +88,11 @@ static inline void dra7xx_pcie_writel(struct dra7xx_pcie *pcie, u32 offset,
>  	writel(value, pcie->base + offset);
>  }
>  
> +static u64 dra7xx_pcie_cpu_addr_fixup(u64 pci_addr)
> +{
> +	return pci_addr & DRA7XX_CPU_TO_BUS_ADDR;
> +}
> +
>  static int dra7xx_pcie_link_up(struct dw_pcie *pci)
>  {
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
> @@ -152,11 +157,6 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
>  
> -	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
> -	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
> -	pp->cfg0_base &= DRA7XX_CPU_TO_BUS_ADDR;
> -	pp->cfg1_base &= DRA7XX_CPU_TO_BUS_ADDR;
> -
>  	dw_pcie_setup_rc(pp);
>  
>  	dra7xx_pcie_establish_link(dra7xx);
> @@ -329,6 +329,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  }
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> +	.cpu_addr_fixup = dra7xx_pcie_cpu_addr_fixup,
>  	.link_up = dra7xx_pcie_link_up,
>  };
>  
