Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EB211A0058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 23:32:16 +1100 (AEDT)
In-Reply-To: <1427261761-22952-8-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 07/27] powerpc: ppc_md.pci_dma_dev_setup ->
 pci_controller_ops.dma_dev_setup
Message-Id: <20150330123216.3C7E11401AB@ozlabs.org>
Date: Mon, 30 Mar 2015 23:32:16 +1100 (AEDT)
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-25-03 at 05:35:41 UTC, Daniel Axtens wrote:

Write changelogs!

Also this doesn't do what the subject suggests, it just introduces the ops
version and adds the shim. It doesn't do all the conversions.

> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/powerpc/include/asm/pci-bridge.h | 14 ++++++++++++++
>  arch/powerpc/kernel/pci-common.c      |  3 +--
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 3ab8a2d..2474f29 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -18,6 +18,7 @@ struct device_node;
>   * PCI controller operations
>   */
>  struct pci_controller_ops {
> +	void		(*dma_dev_setup)(struct pci_dev *dev);
>  };
>  
>  /*
> @@ -265,5 +266,18 @@ static inline int pcibios_vaddr_is_ioport(void __iomem *address)
>  }
>  #endif	/* CONFIG_PCI */
>  
> +/*
> + * Shims to prefer pci_controller version over ppc_md where available.
> + */
> +static inline void dma_dev_setup(struct pci_dev *dev)

This should be called pci_dma_dev_setup() while it exists IMHO.

> +{
> +	struct pci_controller *hose = pci_bus_to_host(dev->bus);

I know historically we've called them "hose", but there's also a lot of code
that uses "phb" and that is a MUCH better name, so please use that.

cheers
