Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgeamrelo02.lge.com (lgeamrelo02.lge.com [156.147.1.126])
 by lists.ozlabs.org (Postfix) with ESMTP id 100721A0349
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 15:29:57 +1000 (EST)
Date: Mon, 16 Jun 2014 14:34:08 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 07/10] PPC, KVM, CMA: use general CMA reserved area
 management framework
Message-ID: <20140616053408.GH23210@js1304-P5Q-DELUXE>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-8-git-send-email-iamjoonsoo.kim@lge.com>
 <87mwdfg9co.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87mwdfg9co.fsf@linux.vnet.ibm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, kvm@vger.kernel.org,
 linux-mm@kvack.org, Gleb Natapov <gleb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Graf <agraf@suse.de>, Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 14, 2014 at 02:23:59PM +0530, Aneesh Kumar K.V wrote:
> Joonsoo Kim <iamjoonsoo.kim@lge.com> writes:
> 
> > Now, we have general CMA reserved area management framework,
> > so use it for future maintainabilty. There is no functional change.
> >
> > Acked-by: Michal Nazarewicz <mina86@mina86.com>
> > Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Need this. We may want to keep the VM_BUG_ON by moving
> KVM_CMA_CHUNK_ORDER around.
> 
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 8056107..1932e0e 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -37,8 +37,6 @@
>  #include <asm/ppc-opcode.h>
>  #include <asm/cputable.h>
>  
> -#include "book3s_hv_cma.h"
> -
>  /* POWER7 has 10-bit LPIDs, PPC970 has 6-bit LPIDs */
>  #define MAX_LPID_970   63
>  
> @@ -64,7 +62,6 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
>         }
>  
>         kvm->arch.hpt_cma_alloc = 0;
> -       VM_BUG_ON(order < KVM_CMA_CHUNK_ORDER);
>         page = kvm_alloc_hpt(1 << (order - PAGE_SHIFT));
>         if (page) {
>                 hpt = (unsigned long)pfn_to_kaddr(page_to_pfn(page));
> 
> 
> 
> -aneesh

Okay.
So do you also want this?

@@ -131,16 +135,18 @@ struct page *kvm_alloc_hpt(unsigned long nr_pages)
 {
        unsigned long align_pages = HPT_ALIGN_PAGES;
 
+       VM_BUG_ON(get_order(nr_pages) < KVM_CMA_CHUNK_ORDER - PAGE_SHIFT);
+
        /* Old CPUs require HPT aligned on a multiple of its size */
        if (!cpu_has_feature(CPU_FTR_ARCH_206))
                align_pages = nr_pages;
-       return kvm_alloc_cma(nr_pages, align_pages);
+       return cma_alloc(kvm_cma, nr_pages, get_order(align_pages));
 }

Thanks.
