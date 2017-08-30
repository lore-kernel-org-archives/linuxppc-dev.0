Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhvv310VGzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 15:58:23 +1000 (AEST)
Date: Wed, 30 Aug 2017 07:58:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
 ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net,
 jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com, npiggin@gmail.com,
 bsingharora@gmail.com, Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 14/20] mm: Provide speculative fault infrastructure
Message-ID: <20170830055800.GG32112@worktop.programming.kicks-ass.net>
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1503007519-26777-15-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170827001823.n5wgkfq36z6snvf2@node.shutemov.name>
 <507e79d5-59df-c5b5-106d-970c9353d9bc@linux.vnet.ibm.com>
 <20170829120426.4ar56rbmiupbqmio@hirez.programming.kicks-ass.net>
 <848fa2c6-dbda-9a1e-2efd-3ce9b083365e@linux.vnet.ibm.com>
 <20170829134550.t7du5zdssvlzemtk@hirez.programming.kicks-ass.net>
 <ab0634c4-274d-208f-fc4b-43991986bacf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ab0634c4-274d-208f-fc4b-43991986bacf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 30, 2017 at 10:33:50AM +0530, Anshuman Khandual wrote:
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a497024..08f3042 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1181,6 +1181,18 @@ int __lock_page_killable(struct page *__page)
>  int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
>                          unsigned int flags)
>  {
> +       if (flags & FAULT_FLAG_SPECULATIVE) {
> +               if (flags & FAULT_FLAG_KILLABLE) {
> +                       int ret;
> +
> +                       ret = __lock_page_killable(page);
> +                       if (ret)
> +                               return 0;
> +               } else
> +                       __lock_page(page);
> +               return 1;
> +       }
> +
>         if (flags & FAULT_FLAG_ALLOW_RETRY) {
>                 /*
>                  * CAUTION! In this case, mmap_sem is not released

Yeah, that looks right.

> @@ -4012,17 +4010,7 @@ int handle_speculative_fault(struct mm_struct *mm, unsigned long address,
>                 goto unlock;
>         }
> 
> +       if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
>                 trace_spf_vma_notsup(_RET_IP_, vma, address);
>                 goto unlock;
>         }

As riel pointed out on IRC slightly later, private file maps also need
->anon_vma and those actually have ->vm_ops IIRC so the condition needs
to be slightly more complicated.
