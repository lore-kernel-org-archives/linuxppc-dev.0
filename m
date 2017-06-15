Return-Path: <srs0=bzsy=5u=ozlabs.ru=aik@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wp62Q136tzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 11:52:30 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wp62P703fz8t64
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 11:52:29 +1000 (AEST)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wp62P0Fvjz9sCZ
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2017 11:52:27 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y7so117730pfd.3
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2017 18:52:27 -0700 (PDT)
Subject: Re: [PATCH] powernv/npu-dma.c: Remove spurious WARN_ON when a PCI
 device has no of_node
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org
References: <1497415670-723-1-git-send-email-alistair@popple.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <22ecf96f-1a09-df03-fa37-22ee878284a0@ozlabs.ru>
Date: Thu, 15 Jun 2017 11:52:21 +1000
MIME-Version: 1.0
In-Reply-To: <1497415670-723-1-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/06/17 14:47, Alistair Popple wrote:
> "4c3b89e powerpc/powernv: Add sanity checks to pnv_pci_get_{gpu|npu}_dev"
> introduced explicit warnings in pnv_pci_get_npu_dev() when a PCIe device
> has no associated device-tree node. However not all PCIe devices have an
> of_node and pnv_pci_get_npu_dev() gets indirectly called at least once for
> every PCIe device in the system. This results in spurious WARN_ON()'s so
> remove it.
> 
> The same situation should not exist for pnv_pci_get_gpu_dev() as any NPU
> based PCIe device requires a device-tree node.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index 78fa939..e6f444b 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -75,7 +75,8 @@ struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index)
>  	if (WARN_ON(!gpdev))
>  		return NULL;
>  
> -	if (WARN_ON(!gpdev->dev.of_node))
> +	/* Not all PCI devices have device-tree nodes */
> +	if (!gpdev->dev.of_node)
>  		return NULL;
>  
>  	/* Get assoicated PCI device */
> 


-- 
Alexey
