Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJjxR2nYCzDrcF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 07:19:22 +1000 (AEST)
Date: Tue, 23 Aug 2016 16:19:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Peter Chen <peter.chen@nxp.com>
Cc: minghuan.Lian@freescale.com, mingkai.hu@freescale.com,
 tie-fei.zang@freescale.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] pci: host: pci-layerscape: add missing of_node_put
 after calling of_parse_phandle
Message-ID: <20160823211916.GB5838@localhost>
References: <1470965681-30496-1-git-send-email-peter.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470965681-30496-1-git-send-email-peter.chen@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter,

On Fri, Aug 12, 2016 at 09:34:41AM +0800, Peter Chen wrote:
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
> 
> Cc: Minghuan Lian <minghuan.Lian@freescale.com>
> Cc: Mingkai Hu <mingkai.hu@freescale.com>
> Cc: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  drivers/pci/host/pci-layerscape.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 114ba81..573b996 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -173,6 +173,8 @@ static int ls_pcie_msi_host_init(struct pcie_port *pp,
>  		return -EINVAL;
>  	}
>  
> +	of_node_put(msi_node);
> +

Can you please look for and fix similar errors in other drivers in
drivers/pci/host/*?

For example:

  advk_pcie_probe() and iproc_pcie_msi_enable() call
  of_parse_phandle() but don't call of_node_put() in failure paths.

  dra7xx_pcie_init_irq_domain(), nwl_pcie_init_irq_domain(), and
  xilinx_pcie_init_irq_domain() call of_get_next_child() but don't
  call of_node_put() in failure paths.

  ks_pcie_get_irq_controller_info() calls of_find_node_by_name().

I think there may be others, e.g., the pci_host_bridge_msi_domain()
path calls of_parse_phandle(), but I'm not sure of_node_put() is
called on failure paths.

When we find bugs like this, it's nice to fix one occurrence, but it's
really great if we can squash similar bugs nearby so the bug isn't
copied into new drivers.

>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
