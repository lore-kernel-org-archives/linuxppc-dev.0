Return-Path: <vinayakm.list@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hdc00QyKzF2Bv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 02:15:08 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id a8-v6so4756077wmg.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 09:15:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523975611-15978-7-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1523975611-15978-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1523975611-15978-7-git-send-email-ldufour@linux.vnet.ibm.com>
From: vinayak menon <vinayakm.list@gmail.com>
Date: Thu, 10 May 2018 21:45:05 +0530
Message-ID: <CAOaiJ-n6P-hjBEkiR4+MyFYunocPgzAYkG1wALDcmi7ROe4-ag@mail.gmail.com>
Subject: Re: [PATCH v10 06/25] mm: make pte_unmap_same compatible with SPF
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, kirill@shutemov.name, ak@linux.intel.com,
 dave@stgolabs.net, jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
 David Rientjes <rientjes@google.com>, Jerome Glisse <jglisse@redhat.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Vinayak Menon <vinmenon@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 17, 2018 at 8:03 PM, Laurent Dufour
<ldufour@linux.vnet.ibm.com> wrote:
> pte_unmap_same() is making the assumption that the page table are still
> around because the mmap_sem is held.
> This is no more the case when running a speculative page fault and
> additional check must be made to ensure that the final page table are still
> there.
>
> This is now done by calling pte_spinlock() to check for the VMA's
> consistency while locking for the page tables.
>
> This is requiring passing a vm_fault structure to pte_unmap_same() which is
> containing all the needed parameters.
>
> As pte_spinlock() may fail in the case of a speculative page fault, if the
> VMA has been touched in our back, pte_unmap_same() should now return 3
> cases :
>         1. pte are the same (0)
>         2. pte are different (VM_FAULT_PTNOTSAME)
>         3. a VMA's changes has been detected (VM_FAULT_RETRY)
>
> The case 2 is handled by the introduction of a new VM_FAULT flag named
> VM_FAULT_PTNOTSAME which is then trapped in cow_user_page().
> If VM_FAULT_RETRY is returned, it is passed up to the callers to retry the
> page fault while holding the mmap_sem.
>
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  include/linux/mm.h |  1 +
>  mm/memory.c        | 39 ++++++++++++++++++++++++++++-----------
>  2 files changed, 29 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4d1aff80669c..714da99d77a3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1208,6 +1208,7 @@ static inline void clear_page_pfmemalloc(struct page *page)
>  #define VM_FAULT_NEEDDSYNC  0x2000     /* ->fault did not modify page tables
>                                          * and needs fsync() to complete (for
>                                          * synchronous page faults in DAX) */
> +#define VM_FAULT_PTNOTSAME 0x4000      /* Page table entries have changed */


This has to be added to VM_FAULT_RESULT_TRACE ?
