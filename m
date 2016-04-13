Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlFLC6hPrzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 17:09:55 +1000 (AEST)
Received: by mail-pa0-x234.google.com with SMTP id bx7so28426324pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 00:09:55 -0700 (PDT)
Subject: Re: [PATCH v8 11/45] powerpc/powernv: Track M64 segment consumption
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-12-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <570DF0B9.5030102@ozlabs.ru>
Date: Wed, 13 Apr 2016 17:09:45 +1000
MIME-Version: 1.0
In-Reply-To: <1455680668-23298-12-git-send-email-gwshan@linux.vnet.ibm.com>
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
> When unplugging PCI devices, their parent PEs might be offline.
> The consumed M64 resource by the PEs should be released at that
> time. As we track M32 segment consumption, this introduces an
> array to the PHB to track the mapping between M64 segment and
> PE number.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

but it would not hurt to mention in the commit log why M64 segment is not 
tracked/setup by the existing (at this point, at least) 
pnv_ioda_setup_one_res().


> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++--
>   arch/powerpc/platforms/powernv/pci.h      |  1 +
>   2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 7330a73..fc0374a 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -305,6 +305,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
>   		phb->ioda.total_pe_num) {
>   		pe = &phb->ioda.pe_array[i];
>
> +		phb->ioda.m64_segmap[pe->pe_number] = pe->pe_number;
>   		if (!master_pe) {
>   			pe->flags |= PNV_IODA_PE_MASTER;
>   			INIT_LIST_HEAD(&pe->slaves);
> @@ -3245,7 +3246,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   {
>   	struct pci_controller *hose;
>   	struct pnv_phb *phb;
> -	unsigned long size, m32map_off, pemap_off, iomap_off = 0;
> +	unsigned long size, m64map_off, m32map_off, pemap_off, iomap_off = 0;
>   	const __be64 *prop64;
>   	const __be32 *prop32;
>   	int i, len;
> @@ -3332,6 +3333,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>
>   	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
>   	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
> +	m64map_off = size;
> +	size += phb->ioda.total_pe_num * sizeof(phb->ioda.m64_segmap[0]);
>   	m32map_off = size;
>   	size += phb->ioda.total_pe_num * sizeof(phb->ioda.m32_segmap[0]);
>   	if (phb->type == PNV_PHB_IODA1) {
> @@ -3342,9 +3345,12 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>   	size += phb->ioda.total_pe_num * sizeof(struct pnv_ioda_pe);
>   	aux = memblock_virt_alloc(size, 0);
>   	phb->ioda.pe_alloc = aux;
> +	phb->ioda.m64_segmap = aux + m64map_off;
>   	phb->ioda.m32_segmap = aux + m32map_off;
> -	for (i = 0; i < phb->ioda.total_pe_num; i++)
> +	for (i = 0; i < phb->ioda.total_pe_num; i++) {
> +		phb->ioda.m64_segmap[i] = IODA_INVALID_PE;
>   		phb->ioda.m32_segmap[i] = IODA_INVALID_PE;
> +	}
>   	if (phb->type == PNV_PHB_IODA1) {
>   		phb->ioda.io_segmap = aux + iomap_off;
>   		for (i = 0; i < phb->ioda.total_pe_num; i++)
> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 36c4965..866a5ea 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -146,6 +146,7 @@ struct pnv_phb {
>   		struct pnv_ioda_pe	*pe_array;
>
>   		/* M32 & IO segment maps */
> +		int			*m64_segmap;
>   		int			*m32_segmap;
>   		int			*io_segmap;
>
>


-- 
Alexey
