Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5BE6B2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jan 2014 09:19:37 +1100 (EST)
Date: Fri, 3 Jan 2014 16:19:23 -0600
From: Scott Wood <scottwood@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: Re: [02/12,v3] pci: fsl: add structure fsl_pci
Message-ID: <20140103221923.GB22546@home.buserror.net>
References: <1382524894-15164-2-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1382524894-15164-2-git-send-email-Minghuan.Lian@freescale.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 23, 2013 at 06:41:24PM +0800, Minghuan Lian wrote:
> PowerPC uses structure pci_controller to describe PCI controller,
> but ARM uses structure pci_sys_data. In order to support PowerPC
> and ARM simultaneously, the patch adds a structure fsl_pci that
> contains most of the members of the pci_controller and pci_sys_data.
> Meanwhile, it defines a interface fsl_arch_sys_to_pci() which should
> be implemented in architecture-specific PCI controller driver to
> convert pci_controller or pci_sys_data to fsl_pci.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> 
> ---
> change log:
> v1-v3:
> Derived from http://patchwork.ozlabs.org/patch/278965/
> 
> Based on upstream master.
> Based on the discussion of RFC version here
> http://patchwork.ozlabs.org/patch/274487/
> 
>  include/linux/fsl/pci-common.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/include/linux/fsl/pci-common.h b/include/linux/fsl/pci-common.h
> index 5e4f683..e56a040 100644
> --- a/include/linux/fsl/pci-common.h
> +++ b/include/linux/fsl/pci-common.h
> @@ -102,5 +102,46 @@ struct ccsr_pci {
>  
>  };
>  
> +/*
> + * Structure of a PCI controller (host bridge)
> + */
> +struct fsl_pci {
> +	struct list_head node;
> +	bool is_pcie;
> +	struct device_node *dn;
> +	struct device *dev;
> +
> +	int first_busno;
> +	int last_busno;
> +	int self_busno;
> +	struct resource busn;
> +
> +	struct pci_ops *ops;
> +	struct ccsr_pci __iomem *regs;
> +
> +	u32 indirect_type;
> +
> +	struct resource io_resource;
> +	resource_size_t io_base_phys;
> +	resource_size_t pci_io_size;
> +
> +	struct resource mem_resources[3];
> +	resource_size_t mem_offset[3];
> +
> +	int global_number;	/* PCI domain number */
> +
> +	resource_size_t dma_window_base_cur;
> +	resource_size_t dma_window_size;
> +
> +	void *sys;
> +};

I don't like the extent to which this duplicates (not moves) PPC's struct
pci_controller.  Also this leaves some fields like "indirect_type"
unexplained (PPC_INDIRECT_TYPE_xxx is only in the PPC header).

Does the arch-independent part of the driver really need all this?  Given
how closely this tracks the PPC code, how would this work on ARM?

-Scott
