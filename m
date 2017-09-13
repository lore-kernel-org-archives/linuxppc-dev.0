Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsg6x35XfzDqjt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 21:54:01 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id e1so23064159pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 04:54:01 -0700 (PDT)
Date: Wed, 13 Sep 2017 20:53:54 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v3 04/20] mm: VMA sequence count
Message-ID: <20170913115354.GA7756@jagdpanzerIV.localdomain>
References: <1504894024-2750-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1504894024-2750-5-git-send-email-ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504894024-2750-5-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On (09/08/17 20:06), Laurent Dufour wrote:
[..]
> @@ -903,6 +910,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  		mm->map_count--;
>  		mpol_put(vma_policy(next));
>  		kmem_cache_free(vm_area_cachep, next);
> +		write_seqcount_end(&next->vm_sequence);
>  		/*
>  		 * In mprotect's case 6 (see comments on vma_merge),
>  		 * we must remove another next too. It would clutter
> @@ -932,11 +940,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  		if (remove_next == 2) {
>  			remove_next = 1;
>  			end = next->vm_end;
> +			write_seqcount_end(&vma->vm_sequence);
>  			goto again;
> -		}
> -		else if (next)
> +		} else if (next) {
> +			if (next != vma)
> +				write_seqcount_begin_nested(&next->vm_sequence,
> +							    SINGLE_DEPTH_NESTING);
>  			vma_gap_update(next);
> -		else {
> +		} else {
>  			/*
>  			 * If remove_next == 2 we obviously can't
>  			 * reach this path.
> @@ -962,6 +973,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  	if (insert && file)
>  		uprobe_mmap(insert);
>  
> +	if (next && next != vma)
> +		write_seqcount_end(&next->vm_sequence);
> +	write_seqcount_end(&vma->vm_sequence);


ok, so what I got on my box is:

vm_munmap()  -> down_write_killable(&mm->mmap_sem)
 do_munmap()
  __split_vma()
   __vma_adjust()  -> write_seqcount_begin(&vma->vm_sequence)
                   -> write_seqcount_begin_nested(&next->vm_sequence, SINGLE_DEPTH_NESTING)

so this gives 3 dependencies  ->mmap_sem   ->   ->vm_seq
                              ->vm_seq     ->   ->vm_seq/1
                              ->mmap_sem   ->   ->vm_seq/1


SyS_mremap() -> down_write_killable(&current->mm->mmap_sem)
 move_vma()   -> write_seqcount_begin(&vma->vm_sequence)
              -> write_seqcount_begin_nested(&new_vma->vm_sequence, SINGLE_DEPTH_NESTING);
  move_page_tables()
   __pte_alloc()
    pte_alloc_one()
     __alloc_pages_nodemask()
      fs_reclaim_acquire()


I think here we have prepare_alloc_pages() call, that does

        -> fs_reclaim_acquire(gfp_mask)
        -> fs_reclaim_release(gfp_mask)

so that adds one more dependency  ->mmap_sem   ->   ->vm_seq    ->   fs_reclaim
                                  ->mmap_sem   ->   ->vm_seq/1  ->   fs_reclaim


now, under memory pressure we hit the slow path and perform direct
reclaim. direct reclaim is done under fs_reclaim lock, so we end up
with the following call chain

__alloc_pages_nodemask()
 __alloc_pages_slowpath()
  __perform_reclaim()       ->   fs_reclaim_acquire(gfp_mask);
   try_to_free_pages()
    shrink_node()
     shrink_active_list()
      rmap_walk_file()      ->   i_mmap_lock_read(mapping);


and this break the existing dependency. since we now take the leaf lock
(fs_reclaim) first and the the root lock (->mmap_sem).


well, seems to be the case.

	-ss
