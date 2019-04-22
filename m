Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DC0C10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:36:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDF020859
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDF020859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nyzK2pVdzDqJP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 06:36:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jglisse@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nywQ62TvzDqHV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 06:33:58 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D15F30832EF;
 Mon, 22 Apr 2019 20:33:56 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E22545D9D4;
 Mon, 22 Apr 2019 20:33:52 +0000 (UTC)
Date: Mon, 22 Apr 2019 16:33:51 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v12 19/31] mm: protect the RB tree with a sequence lock
Message-ID: <20190422203350.GJ14666@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-20-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-20-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 22 Apr 2019 20:33:57 +0000 (UTC)
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

On Tue, Apr 16, 2019 at 03:45:10PM +0200, Laurent Dufour wrote:
> Introducing a per mm_struct seqlock, mm_seq field, to protect the changes
> made in the MM RB tree. This allows to walk the RB tree without grabbing
> the mmap_sem, and on the walk is done to double check that sequence counter
> was stable during the walk.
> 
> The mm seqlock is held while inserting and removing entries into the MM RB
> tree.  Later in this series, it will be check when looking for a VMA
> without holding the mmap_sem.
> 
> This is based on the initial work from Peter Zijlstra:
> https://lore.kernel.org/linux-mm/20100104182813.479668508@chello.nl/
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/mm_types.h |  3 +++
>  kernel/fork.c            |  3 +++
>  mm/init-mm.c             |  3 +++
>  mm/mmap.c                | 48 +++++++++++++++++++++++++++++++---------
>  4 files changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index e78f72eb2576..24b3f8ce9e42 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -358,6 +358,9 @@ struct mm_struct {
>  	struct {
>  		struct vm_area_struct *mmap;		/* list of VMAs */
>  		struct rb_root mm_rb;
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +		seqlock_t mm_seq;
> +#endif
>  		u64 vmacache_seqnum;                   /* per-thread vmacache */
>  #ifdef CONFIG_MMU
>  		unsigned long (*get_unmapped_area) (struct file *filp,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2992d2c95256..3a1739197ebc 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1008,6 +1008,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mm->mmap = NULL;
>  	mm->mm_rb = RB_ROOT;
>  	mm->vmacache_seqnum = 0;
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	seqlock_init(&mm->mm_seq);
> +#endif
>  	atomic_set(&mm->mm_users, 1);
>  	atomic_set(&mm->mm_count, 1);
>  	init_rwsem(&mm->mmap_sem);
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index a787a319211e..69346b883a4e 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -27,6 +27,9 @@
>   */
>  struct mm_struct init_mm = {
>  	.mm_rb		= RB_ROOT,
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +	.mm_seq		= __SEQLOCK_UNLOCKED(init_mm.mm_seq),
> +#endif
>  	.pgd		= swapper_pg_dir,
>  	.mm_users	= ATOMIC_INIT(2),
>  	.mm_count	= ATOMIC_INIT(1),
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 13460b38b0fb..f7f6027a7dff 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -170,6 +170,24 @@ void unlink_file_vma(struct vm_area_struct *vma)
>  	}
>  }
>  
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +static inline void mm_write_seqlock(struct mm_struct *mm)
> +{
> +	write_seqlock(&mm->mm_seq);
> +}
> +static inline void mm_write_sequnlock(struct mm_struct *mm)
> +{
> +	write_sequnlock(&mm->mm_seq);
> +}
> +#else
> +static inline void mm_write_seqlock(struct mm_struct *mm)
> +{
> +}
> +static inline void mm_write_sequnlock(struct mm_struct *mm)
> +{
> +}
> +#endif /* CONFIG_SPECULATIVE_PAGE_FAULT */
> +
>  /*
>   * Close a vm structure and free it, returning the next.
>   */
> @@ -445,26 +463,32 @@ static void vma_gap_update(struct vm_area_struct *vma)
>  }
>  
>  static inline void vma_rb_insert(struct vm_area_struct *vma,
> -				 struct rb_root *root)
> +				 struct mm_struct *mm)
>  {
> +	struct rb_root *root = &mm->mm_rb;
> +
>  	/* All rb_subtree_gap values must be consistent prior to insertion */
>  	validate_mm_rb(root, NULL);
>  
>  	rb_insert_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
>  }
>  
> -static void __vma_rb_erase(struct vm_area_struct *vma, struct rb_root *root)
> +static void __vma_rb_erase(struct vm_area_struct *vma, struct mm_struct *mm)
>  {
> +	struct rb_root *root = &mm->mm_rb;
> +
>  	/*
>  	 * Note rb_erase_augmented is a fairly large inline function,
>  	 * so make sure we instantiate it only once with our desired
>  	 * augmented rbtree callbacks.
>  	 */
> +	mm_write_seqlock(mm);
>  	rb_erase_augmented(&vma->vm_rb, root, &vma_gap_callbacks);
> +	mm_write_sequnlock(mm);	/* wmb */
>  }
>  
>  static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma,
> -						struct rb_root *root,
> +						struct mm_struct *mm,
>  						struct vm_area_struct *ignore)
>  {
>  	/*
> @@ -472,21 +496,21 @@ static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma,
>  	 * with the possible exception of the "next" vma being erased if
>  	 * next->vm_start was reduced.
>  	 */
> -	validate_mm_rb(root, ignore);
> +	validate_mm_rb(&mm->mm_rb, ignore);
>  
> -	__vma_rb_erase(vma, root);
> +	__vma_rb_erase(vma, mm);
>  }
>  
>  static __always_inline void vma_rb_erase(struct vm_area_struct *vma,
> -					 struct rb_root *root)
> +					 struct mm_struct *mm)
>  {
>  	/*
>  	 * All rb_subtree_gap values must be consistent prior to erase,
>  	 * with the possible exception of the vma being erased.
>  	 */
> -	validate_mm_rb(root, vma);
> +	validate_mm_rb(&mm->mm_rb, vma);
>  
> -	__vma_rb_erase(vma, root);
> +	__vma_rb_erase(vma, mm);
>  }
>  
>  /*
> @@ -601,10 +625,12 @@ void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
>  	 * immediately update the gap to the correct value. Finally we
>  	 * rebalance the rbtree after all augmented values have been set.
>  	 */
> +	mm_write_seqlock(mm);
>  	rb_link_node(&vma->vm_rb, rb_parent, rb_link);
>  	vma->rb_subtree_gap = 0;
>  	vma_gap_update(vma);
> -	vma_rb_insert(vma, &mm->mm_rb);
> +	vma_rb_insert(vma, mm);
> +	mm_write_sequnlock(mm);
>  }
>  
>  static void __vma_link_file(struct vm_area_struct *vma)
> @@ -680,7 +706,7 @@ static __always_inline void __vma_unlink_common(struct mm_struct *mm,
>  {
>  	struct vm_area_struct *next;
>  
> -	vma_rb_erase_ignore(vma, &mm->mm_rb, ignore);
> +	vma_rb_erase_ignore(vma, mm, ignore);
>  	next = vma->vm_next;
>  	if (has_prev)
>  		prev->vm_next = next;
> @@ -2674,7 +2700,7 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vma,
>  	insertion_point = (prev ? &prev->vm_next : &mm->mmap);
>  	vma->vm_prev = NULL;
>  	do {
> -		vma_rb_erase(vma, &mm->mm_rb);
> +		vma_rb_erase(vma, mm);
>  		mm->map_count--;
>  		tail_vma = vma;
>  		vma = vma->vm_next;
> -- 
> 2.21.0
> 
