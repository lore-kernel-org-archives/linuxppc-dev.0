Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlCd00MTLzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 15:52:35 +1000 (AEST)
Received: by mail-pa0-x22f.google.com with SMTP id bx7so27282643pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 22:52:35 -0700 (PDT)
Subject: Re: [PATCH v8 03/45] powerpc/pci: Cleanup on struct pci_controller_ops
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-4-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570DDE99.7070103@ozlabs.ru>
Date: Wed, 13 Apr 2016 15:52:25 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-4-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2016 02:43 PM, Gavin Shan wrote:
> Each PHB has one instance of "struct pci_controller_ops", which
> includes various callbacks called by PCI subsystem. In the definition
> of this struct, some callbacks have explicit names for its arguments,
> but the left don't have.
>
> This adds all explicit names of the arguments to the callbacks in
> "struct pci_controller_ops" so that the code looks consistent.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>

With tiny nit below,

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>



> ---
>   arch/powerpc/include/asm/pci-bridge.h | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index b688d04..4dd6ef4 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -21,18 +21,19 @@ struct pci_controller_ops {
>   	void		(*dma_dev_setup)(struct pci_dev *dev);
>   	void		(*dma_bus_setup)(struct pci_bus *bus);
>
> -	int		(*probe_mode)(struct pci_bus *);
> +	int		(*probe_mode)(struct pci_bus *bus);
>
>   	/* Called when pci_enable_device() is called. Returns true to
>   	 * allow assignment/enabling of the device. */
> -	bool		(*enable_device_hook)(struct pci_dev *);
> +	bool		(*enable_device_hook)(struct pci_dev *dev);


"pdev" is slightly better as it is of the "pci_dev" type (4130 occurrences 
of "pci_dev *pdev" and just 2833 of "pci_dev *dev" in the current kernel), 
"dev" is for "struct device".




>
> -	void		(*disable_device)(struct pci_dev *);
> +	void		(*disable_device)(struct pci_dev *dev);
>
> -	void		(*release_device)(struct pci_dev *);
> +	void		(*release_device)(struct pci_dev *dev);
>
>   	/* Called during PCI resource reassignment */
> -	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
> +	resource_size_t (*window_alignment)(struct pci_bus *bus,
> +					    unsigned long type);
>   	void		(*setup_bridge)(struct pci_bus *bus,
>   					unsigned long type);
>   	void		(*reset_secondary_bus)(struct pci_dev *dev);
> @@ -46,7 +47,7 @@ struct pci_controller_ops {
>   	int             (*dma_set_mask)(struct pci_dev *dev, u64 dma_mask);
>   	u64		(*dma_get_required_mask)(struct pci_dev *dev);
>
> -	void		(*shutdown)(struct pci_controller *);
> +	void		(*shutdown)(struct pci_controller *hose);
>   };
>
>   /*
>


-- 
Alexey
