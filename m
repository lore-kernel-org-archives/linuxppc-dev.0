Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Qf2L1GDNzF1vG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 07:46:01 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id h69so12772396pfe.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 14:46:01 -0700 (PDT)
Date: Wed, 18 Apr 2018 07:45:46 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 mhairgrove@nvidia.com, arbab@linux.ibm.com
Subject: Re: [PATCH 2/2] powernv/npu: Add a debugfs setting to change ATSD
 threshold
Message-ID: <20180418074546.0efb7fb7@gmail.com>
In-Reply-To: <20180417091129.23069-2-alistair@popple.id.au>
References: <20180417091129.23069-1-alistair@popple.id.au>
 <20180417091129.23069-2-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 17 Apr 2018 19:11:29 +1000
Alistair Popple <alistair@popple.id.au> wrote:

> The threshold at which it becomes more efficient to coalesce a range of
> ATSDs into a single per-PID ATSD is currently not well understood due to a
> lack of real-world work loads. This patch adds a debugfs parameter allowing
> the threshold to be altered at runtime in order to aid future development
> and refinement of the value.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index dc34662e9df9..a765bf576c14 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -17,7 +17,9 @@
>  #include <linux/pci.h>
>  #include <linux/memblock.h>
>  #include <linux/iommu.h>
> +#include <linux/debugfs.h>
>  
> +#include <asm/debugfs.h>
>  #include <asm/tlb.h>
>  #include <asm/powernv.h>
>  #include <asm/reg.h>
> @@ -44,7 +46,8 @@ DEFINE_SPINLOCK(npu_context_lock);
>   * entire TLB on the GPU for the given PID rather than each specific address in
>   * the range.
>   */
> -#define ATSD_THRESHOLD (2*1024*1024)
> +static uint64_t atsd_threshold = 2 * 1024 * 1024;
> +static struct dentry *atsd_threshold_dentry;
>  
>  /*
>   * Other types of TCE cache invalidation are not functional in the
> @@ -682,7 +685,7 @@ static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
>  	struct npu_context *npu_context = mn_to_npu_context(mn);
>  	unsigned long address;
>  
> -	if (end - start > ATSD_THRESHOLD) {
> +	if (end - start > atsd_threshold) {
>  		/*
>  		 * Just invalidate the entire PID if the address range is too
>  		 * large.
> @@ -956,6 +959,11 @@ int pnv_npu2_init(struct pnv_phb *phb)
>  	static int npu_index;
>  	uint64_t rc = 0;
>  
> +	if (!atsd_threshold_dentry) {
> +		atsd_threshold_dentry = debugfs_create_x64("atsd_threshold",

Nit-picking can we call this atsd_threshold_in_bytes?

> +				   0600, powerpc_debugfs_root, &atsd_threshold);
> +	}
> +
>  	phb->npu.nmmu_flush =
>  		of_property_read_bool(phb->hose->dn, "ibm,nmmu-flush");
>  	for_each_child_of_node(phb->hose->dn, dn) {

Acked-by: Balbir Singh <bsingharora@gmail.com>
