Return-Path: <rientjes@google.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40G2xx05yBzF28G
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 07:57:24 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id 59-v6so8257273plc.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 14:57:24 -0700 (PDT)
Date: Tue, 3 Apr 2018 14:57:20 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v9 04/24] mm: Prepare for FAULT_FLAG_SPECULATIVE
In-Reply-To: <361fa6e7-3c17-e1b8-8046-af72c4459613@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1804031449130.153232@chino.kir.corp.google.com>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-5-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803251426120.80485@chino.kir.corp.google.com>
 <361fa6e7-3c17-e1b8-8046-af72c4459613@linux.vnet.ibm.com>
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

On Wed, 28 Mar 2018, Laurent Dufour wrote:

> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index 4d02524a7998..2f3e98edc94a 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -300,6 +300,7 @@ extern pgprot_t protection_map[16];
> >>  #define FAULT_FLAG_USER		0x40	/* The fault originated in userspace */
> >>  #define FAULT_FLAG_REMOTE	0x80	/* faulting for non current tsk/mm */
> >>  #define FAULT_FLAG_INSTRUCTION  0x100	/* The fault was during an instruction fetch */
> >> +#define FAULT_FLAG_SPECULATIVE	0x200	/* Speculative fault, not holding mmap_sem */
> >>  
> >>  #define FAULT_FLAG_TRACE \
> >>  	{ FAULT_FLAG_WRITE,		"WRITE" }, \
> > 
> > I think FAULT_FLAG_SPECULATIVE should be introduced in the patch that 
> > actually uses it.
> 
> I think you're right, I'll move down this define in the series.
> 
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index e0ae4999c824..8ac241b9f370 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -2288,6 +2288,13 @@ int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
> >>  }
> >>  EXPORT_SYMBOL_GPL(apply_to_page_range);
> >>  
> >> +static bool pte_map_lock(struct vm_fault *vmf)
> > 
> > inline?
> 
> Agreed.
> 

Ignore this, the final form of the function after the full patchset 
shouldn't be inline.

> >> +{
> >> +	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> >> +				       vmf->address, &vmf->ptl);
> >> +	return true;
> >> +}
> >> +
> >>  /*
> >>   * handle_pte_fault chooses page fault handler according to an entry which was
> >>   * read non-atomically.  Before making any commitment, on those architectures
> >> @@ -2477,6 +2484,7 @@ static int wp_page_copy(struct vm_fault *vmf)
> >>  	const unsigned long mmun_start = vmf->address & PAGE_MASK;
> >>  	const unsigned long mmun_end = mmun_start + PAGE_SIZE;
> >>  	struct mem_cgroup *memcg;
> >> +	int ret = VM_FAULT_OOM;
> >>  
> >>  	if (unlikely(anon_vma_prepare(vma)))
> >>  		goto oom;
> >> @@ -2504,7 +2512,11 @@ static int wp_page_copy(struct vm_fault *vmf)
> >>  	/*
> >>  	 * Re-check the pte - we dropped the lock
> >>  	 */
> >> -	vmf->pte = pte_offset_map_lock(mm, vmf->pmd, vmf->address, &vmf->ptl);
> >> +	if (!pte_map_lock(vmf)) {
> >> +		mem_cgroup_cancel_charge(new_page, memcg, false);
> >> +		ret = VM_FAULT_RETRY;
> >> +		goto oom_free_new;
> >> +	}
> > 
> > Ugh, but we aren't oom here, so maybe rename oom_free_new so that it makes 
> > sense for return values other than VM_FAULT_OOM?
> 
> You're right, now this label name is not correct, I'll rename it to
> "out_free_new" and rename also the label "oom" to "out" since it is generic too
> now.
> 

I think it would just be better to introduce a out_uncharge that handles 
the mem_cgroup_cancel_charge() in the exit path.

diff --git a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2645,9 +2645,8 @@ static int wp_page_copy(struct vm_fault *vmf)
 	 * Re-check the pte - we dropped the lock
 	 */
 	if (!pte_map_lock(vmf)) {
-		mem_cgroup_cancel_charge(new_page, memcg, false);
 		ret = VM_FAULT_RETRY;
-		goto oom_free_new;
+		goto out_uncharge;
 	}
 	if (likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 		if (old_page) {
@@ -2735,6 +2734,8 @@ static int wp_page_copy(struct vm_fault *vmf)
 		put_page(old_page);
 	}
 	return page_copied ? VM_FAULT_WRITE : 0;
+out_uncharge:
+	mem_cgroup_cancel_charge(new_page, memcg, false);
 oom_free_new:
 	put_page(new_page);
 oom:
