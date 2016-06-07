Return-Path: <jesper.nilsson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rP3y054LGzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 18:04:37 +1000 (AEST)
Date: Tue, 7 Jun 2016 10:04:30 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, David Miller <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>,
 Khalid Aziz <khalid.aziz@oracle.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linux-am33-list@redhat.com,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v12 01/15] PCI: Let pci_mmap_page_range() take extra
 resource pointer
Message-ID: <20160607080430.GI3183@axis.com>
References: <20160604000642.28162-1-yinghai@kernel.org>
 <20160604000642.28162-2-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160604000642.28162-2-yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 03, 2016 at 05:06:28PM -0700, Yinghai Lu wrote:
> This one is preparing patch for next one:
>   PCI: Let pci_mmap_page_range() take resource addr
> 
> We need to pass extra resource pointer to avoid searching that again
> for powerpc and microblaze prot set operation.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org

For the CRIS part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> diff --git a/arch/cris/arch-v32/drivers/pci/bios.c b/arch/cris/arch-v32/drivers/pci/bios.c
> index 64a5fb9..082efb9 100644
> --- a/arch/cris/arch-v32/drivers/pci/bios.c
> +++ b/arch/cris/arch-v32/drivers/pci/bios.c
> @@ -14,7 +14,8 @@ void pcibios_set_master(struct pci_dev *dev)
>  	pci_write_config_byte(dev, PCI_LATENCY_TIMER, lat);
>  }
>  
> -int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> +int pci_mmap_page_range(struct pci_dev *dev, struct resource *res,
> +			struct vm_area_struct *vma,
>  			enum pci_mmap_state mmap_state, int write_combine)
>  {
>  	unsigned long prot;
> diff --git a/arch/cris/include/asm/pci.h b/arch/cris/include/asm/pci.h
> index b1b289d..65198cb 100644
> --- a/arch/cris/include/asm/pci.h
> +++ b/arch/cris/include/asm/pci.h
> @@ -42,9 +42,6 @@ struct pci_dev;
>  #define PCI_DMA_BUS_IS_PHYS	(1)
>  
>  #define HAVE_PCI_MMAP
> -extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
> -			       enum pci_mmap_state mmap_state, int write_combine);
> -
>  
>  #endif /* __KERNEL__ */

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
