Return-Path: <kas@node.shutemov.name>
Received: from kirsi1.inet.fi (mta-out1.inet.fi [62.71.2.195])
 by lists.ozlabs.org (Postfix) with ESMTP id E88BA1A01C9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 22:05:22 +1000 (AEST)
Date: Mon, 13 Apr 2015 14:58:11 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v3 1/2] mm: Introducing arch_remap hook
Message-ID: <20150413115811.GA12354@node.dhcp.inet.fi>
References: <cover.1428916945.git.ldufour@linux.vnet.ibm.com>
 <9d827fc618a718830b2c47aa87e8be546914c897.1428916945.git.ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9d827fc618a718830b2c47aa87e8be546914c897.1428916945.git.ldufour@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@redhat.com>, Pavel Emelyanov <xemul@parallels.com>,
 Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, criu@openvz.org,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 13, 2015 at 11:56:27AM +0200, Laurent Dufour wrote:
> Some architecture would like to be triggered when a memory area is moved
> through the mremap system call.
> 
> This patch is introducing a new arch_remap mm hook which is placed in the
> path of mremap, and is called before the old area is unmapped (and the
> arch_unmap hook is called).
> 
> The architectures which need to call this hook should define
> __HAVE_ARCH_REMAP in their asm/mmu_context.h and provide the arch_remap
> service with the following prototype:
> void arch_remap(struct mm_struct *mm,
>                 unsigned long old_start, unsigned long old_end,
>                 unsigned long new_start, unsigned long new_end);
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  mm/mremap.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 2dc44b1cb1df..009db5565893 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -25,6 +25,7 @@
>  
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
> +#include <asm/mmu_context.h>
>  
>  #include "internal.h"
>  
> @@ -286,13 +287,19 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  		old_len = new_len;
>  		old_addr = new_addr;
>  		new_addr = -ENOMEM;
> -	} else if (vma->vm_file && vma->vm_file->f_op->mremap) {
> -		err = vma->vm_file->f_op->mremap(vma->vm_file, new_vma);
> -		if (err < 0) {
> -			move_page_tables(new_vma, new_addr, vma, old_addr,
> -					 moved_len, true);
> -			return err;
> +	} else {
> +		if (vma->vm_file && vma->vm_file->f_op->mremap) {
> +			err = vma->vm_file->f_op->mremap(vma->vm_file, new_vma);
> +			if (err < 0) {
> +				move_page_tables(new_vma, new_addr, vma,
> +						  old_addr, moved_len, true);
> +				return err;
> +			}
>  		}
> +#ifdef __HAVE_ARCH_REMAP

It would be cleaner to provide dummy arch_remap() for !__HAVE_ARCH_REMAP
in some generic header.


> +		arch_remap(mm, old_addr, old_addr+old_len,
> +			   new_addr, new_addr+new_len);

Spaces around '+'?

> +#endif
>  	}
>  
>  	/* Conceal VM_ACCOUNT so old reservation is not undone */
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
 Kirill A. Shutemov
