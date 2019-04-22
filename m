Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D295FC10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:38:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5925020859
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5925020859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nz1m5qwRzDqNC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 06:38:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jglisse@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nyzq11p0zDq6J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 06:36:55 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B387D369CA;
 Mon, 22 Apr 2019 20:36:52 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 131C95C1B5;
 Mon, 22 Apr 2019 20:36:48 +0000 (UTC)
Date: Mon, 22 Apr 2019 16:36:47 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v12 20/31] mm: introduce vma reference counter
Message-ID: <20190422203647.GK14666@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-21-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-21-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 22 Apr 2019 20:36:53 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: jack@suse.cz, sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
 Will Deacon <will.deacon@arm.com>, mhocko@kernel.org, linux-mm@kvack.org,
 paulus@samba.org, Punit Agrawal <punitagrawal@gmail.com>, hpa@zytor.com,
 Michel Lespinasse <walken@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, ak@linux.intel.com,
 Minchan Kim <minchan@kernel.org>, aneesh.kumar@linux.ibm.com, x86@kernel.org,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 David Rientjes <rientjes@google.com>, paulmck@linux.vnet.ibm.com,
 Haiyan Song <haiyanx.song@intel.com>, npiggin@gmail.com, sj38.park@gmail.com,
 dave@stgolabs.net, kemi.wang@intel.com, kirill@shutemov.name,
 Thomas Gleixner <tglx@linutronix.de>, zhong jiang <zhongjiang@huawei.com>,
 Ganesh Mahendran <opensource.ganesh@gmail.com>,
 Yang Shi <yang.shi@linux.alibaba.com>, Mike Rapoport <rppt@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 vinayak menon <vinayakm.list@gmail.com>, akpm@linux-foundation.org,
 Tim Chen <tim.c.chen@linux.intel.com>, haren@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 16, 2019 at 03:45:11PM +0200, Laurent Dufour wrote:
> The final goal is to be able to use a VMA structure without holding the
> mmap_sem and to be sure that the structure will not be freed in our back.
> 
> The lockless use of the VMA will be done through RCU protection and thus a
> dedicated freeing service is required to manage it asynchronously.
> 
> As reported in a 2010's thread [1], this may impact file handling when a
> file is still referenced while the mapping is no more there.  As the final
> goal is to handle anonymous VMA in a speculative way and not file backed
> mapping, we could close and free the file pointer in a synchronous way, as
> soon as we are guaranteed to not use it without holding the mmap_sem. For
> sanity reason, in a minimal effort, the vm_file file pointer is unset once
> the file pointer is put.
> 
> [1] https://lore.kernel.org/linux-mm/20100104182429.833180340@chello.nl/
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Using kref would have been better from my POV even with RCU freeing
but anyway:

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/mm.h       |  4 ++++
>  include/linux/mm_types.h |  3 +++
>  mm/internal.h            | 27 +++++++++++++++++++++++++++
>  mm/mmap.c                | 13 +++++++++----
>  4 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f14b2c9ddfd4..f761a9c65c74 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -529,6 +529,9 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	vma->vm_mm = mm;
>  	vma->vm_ops = &dummy_vm_ops;
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	atomic_set(&vma->vm_ref_count, 1);
> +#endif
>  }
>  
>  static inline void vma_set_anonymous(struct vm_area_struct *vma)
> @@ -1418,6 +1421,7 @@ static inline void INIT_VMA(struct vm_area_struct *vma)
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
>  #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
>  	seqcount_init(&vma->vm_sequence);
> +	atomic_set(&vma->vm_ref_count, 1);
>  #endif
>  }
>  
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 24b3f8ce9e42..6a6159e11a3f 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -285,6 +285,9 @@ struct vm_area_struct {
>  	/* linked list of VM areas per task, sorted by address */
>  	struct vm_area_struct *vm_next, *vm_prev;
>  
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	atomic_t vm_ref_count;
> +#endif
>  	struct rb_node vm_rb;
>  
>  	/*
> diff --git a/mm/internal.h b/mm/internal.h
> index 9eeaf2b95166..302382bed406 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -40,6 +40,33 @@ void page_writeback_init(void);
>  
>  vm_fault_t do_swap_page(struct vm_fault *vmf);
>  
> +
> +extern void __free_vma(struct vm_area_struct *vma);
> +
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +static inline void get_vma(struct vm_area_struct *vma)
> +{
> +	atomic_inc(&vma->vm_ref_count);
> +}
> +
> +static inline void put_vma(struct vm_area_struct *vma)
> +{
> +	if (atomic_dec_and_test(&vma->vm_ref_count))
> +		__free_vma(vma);
> +}
> +
> +#else
> +
> +static inline void get_vma(struct vm_area_struct *vma)
> +{
> +}
> +
> +static inline void put_vma(struct vm_area_struct *vma)
> +{
> +	__free_vma(vma);
> +}
> +#endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
> +
>  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>  		unsigned long floor, unsigned long ceiling);
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f7f6027a7dff..c106440dcae7 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -188,6 +188,12 @@ static inline void mm_write_sequnlock(struct mm_struct *mm)
>  }
>  #endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
>  
> +void __free_vma(struct vm_area_struct *vma)
> +{
> +	mpol_put(vma_policy(vma));
> +	vm_area_free(vma);
> +}
> +
>  /*
>   * Close a vm structure and free it, returning the next.
>   */
> @@ -200,8 +206,8 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
>  		vma->vm_ops->close(vma);
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
> -	mpol_put(vma_policy(vma));
> -	vm_area_free(vma);
> +	vma->vm_file = NULL;
> +	put_vma(vma);
>  	return next;
>  }
>  
> @@ -990,8 +996,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  		if (next->anon_vma)
>  			anon_vma_merge(vma, next);
>  		mm->map_count--;
> -		mpol_put(vma_policy(next));
> -		vm_area_free(next);
> +		put_vma(next);
>  		/*
>  		 * In mprotect's case 6 (see comments on vma_merge),
>  		 * we must remove another next too. It would clutter
> -- 
> 2.21.0
> 
