Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4456E1A08B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 01:14:01 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 04/19] powerpc: Create pci_controller_ops.dma_dev_setup
 and shim
Date: Thu, 02 Apr 2015 16:13:52 +0200
Message-ID: <5500778.Q4t9Fg7Irn@wuerfel>
In-Reply-To: <1427778057-9505-5-git-send-email-dja@axtens.net>
References: <1427778057-9505-1-git-send-email-dja@axtens.net>
 <1427778057-9505-5-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org,
 Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 31 March 2015 16:00:42 Daniel Axtens wrote:
> Introduces the pci_controller_ops structure.
> Add pci_controller_ops.dma_dev_setup, shadowing ppc_md.pci_dma_dev_setup.
> Add a shim, and change the callsites to use the shim.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---
> 
> v1 --> v2:
>  - Better commit message
>  - Use phb in favour of hose
>  - Make shim name match ppc_md name, not pci_controller_ops name.
> ---
>  arch/powerpc/include/asm/pci-bridge.h | 21 +++++++++++++++++++++
>  arch/powerpc/kernel/pci-common.c      |  3 +--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 546d036..347d49d 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -15,6 +15,13 @@
>  struct device_node;
>  
>  /*
> + * PCI controller operations
> + */
> +struct pci_controller_ops {
> +       void            (*dma_dev_setup)(struct pci_dev *dev);
> +};
> +
> +/*

Please see https://patchwork.ozlabs.org/patch/431333/ for related work.

I think it would be better not to introduce another architecture-specific
pci host bridge operations structure, but instead consolidate into
the one that is already there. We are also adding a generic way to set up
PCI DMA, so it would seems reasonable to hook into that place.

	Arnd
