Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 333241A0935
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2015 08:24:31 +1000 (AEST)
Date: Fri, 8 May 2015 15:24:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] mm/thp: Split out pmd collpase flush into a
 seperate functions
Message-Id: <20150508152428.4326eaaae99b74fa53c96f23@linux-foundation.org>
In-Reply-To: <1430983408-24924-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1430983408-24924-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: aarcange@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  7 May 2015 12:53:27 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> After this patch pmdp_* functions operate only on hugepage pte,
> and not on regular pmd_t values pointing to page table.
> 

The patch looks like a pretty safe no-op for non-powerpc?

> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64.h
> @@ -576,6 +576,10 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
>  extern void pmdp_splitting_flush(struct vm_area_struct *vma,
>  				 unsigned long address, pmd_t *pmdp);
>  
> +#define __HAVE_ARCH_PMDP_COLLAPSE_FLUSH
> +extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
> +				 unsigned long address, pmd_t *pmdp);
> +

The fashionable way of doing this is

extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
				 unsigned long address, pmd_t *pmdp);
#define pmdp_collapse_flush pmdp_collapse_flush

then, elsewhere,

#ifndef pmdp_collapse_flush
static inline pmd_t pmdp_collapse_flush(...) {}
#define pmdp_collapse_flush pmdp_collapse_flush
#endif

It avoids introducing a second (ugly) symbol into the kernel.
