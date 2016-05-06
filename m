Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1MSw2GmdzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 16:34:39 +1000 (AEST)
Received: by mail-pa0-x22d.google.com with SMTP id xk12so44617111pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 May 2016 23:34:39 -0700 (PDT)
Subject: Re: [PATCH 4/5] pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA host
 bridge
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1461761010-5452-5-git-send-email-xyjxie@linux.vnet.ibm.com>
Cc: alex.williamson@redhat.com, bhelgaas@google.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joro@8bytes.org, warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, eric.auger@linaro.org, will.deacon@arm.com,
 gwshan@linux.vnet.ibm.com, David.Laight@ACULAB.COM, alistair@popple.id.au,
 ruscur@russell.cc
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8bafc3ec-8ee1-db91-2835-6a77a5dd2539@ozlabs.ru>
Date: Fri, 6 May 2016 16:34:21 +1000
MIME-Version: 1.0
In-Reply-To: <1461761010-5452-5-git-send-email-xyjxie@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/27/2016 10:43 PM, Yongji Xie wrote:
> Any IODA host bridge have the capability of IRQ remapping.
> So we set PCI_BUS_FLAGS_MSI_REMAP when this kind of host birdge
> is detected.
>
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index f90dc04..9557638 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3080,6 +3080,12 @@ static void pnv_pci_ioda_fixup(void)
>  	pnv_npu_ioda_fixup();
>  }
>
> +int pnv_pci_ioda_root_bridge_prepare(struct pci_host_bridge *bridge)
> +{
> +	bridge->bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
> +	return 0;
> +}
> +
>  /*
>   * Returns the alignment for I/O or memory windows for P2P
>   * bridges. That actually depends on how PEs are segmented.
> @@ -3364,6 +3370,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	 */
>  	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
>
> +	ppc_md.pcibios_root_bridge_prepare = pnv_pci_ioda_root_bridge_prepare;
> +
>  	if (phb->type == PNV_PHB_NPU)
>  		hose->controller_ops = pnv_npu_ioda_controller_ops;
>  	else
>


-- 
Alexey
