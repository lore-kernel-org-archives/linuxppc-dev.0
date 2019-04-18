Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E894C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 22:23:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EFD2064A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 22:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EFD2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lYY4205LzDqRR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 08:23:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jglisse@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lYWK6yFnzDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 08:22:21 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 05FE4C066462;
 Thu, 18 Apr 2019 22:22:19 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED5475D9CC;
 Thu, 18 Apr 2019 22:22:14 +0000 (UTC)
Date: Thu, 18 Apr 2019 18:22:13 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v12 08/31] mm: introduce INIT_VMA()
Message-ID: <20190418222212.GH11645@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-9-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416134522.17540-9-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 18 Apr 2019 22:22:19 +0000 (UTC)
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

On Tue, Apr 16, 2019 at 03:44:59PM +0200, Laurent Dufour wrote:
> Some VMA struct fields need to be initialized once the VMA structure is
> allocated.
> Currently this only concerns anon_vma_chain field but some other will be
> added to support the speculative page fault.
> 
> Instead of spreading the initialization calls all over the code, let's
> introduce a dedicated inline function.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  fs/exec.c          | 1 +
>  include/linux/mm.h | 5 +++++
>  kernel/fork.c      | 2 +-
>  mm/mmap.c          | 3 +++
>  mm/nommu.c         | 1 +
>  5 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 2e0033348d8e..9762e060295c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -266,6 +266,7 @@ static int __bprm_mm_init(struct linux_binprm *bprm)
>  	vma->vm_start = vma->vm_end - PAGE_SIZE;
>  	vma->vm_flags = VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP;
>  	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> +	INIT_VMA(vma);
>  
>  	err = insert_vm_struct(mm, vma);
>  	if (err)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4ba2f53f9d60..2ceb1d2869a6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1407,6 +1407,11 @@ struct zap_details {
>  	pgoff_t last_index;			/* Highest page->index to unmap */
>  };
>  
> +static inline void INIT_VMA(struct vm_area_struct *vma)

Can we leave capital names for macro ? Also i prefer vma_init_struct() (the
one thing i like in C++ is namespace and thus i like namespace_action() for
function name).

Also why not doing a coccinelle patch for this:

@@
struct vm_area_struct *vma;
@@
-INIT_LIST_HEAD(&vma->anon_vma_chain);
+vma_init_struct(vma);


Untested ...

> +{
> +	INIT_LIST_HEAD(&vma->anon_vma_chain);
> +}
> +
>  struct page *_vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t pte, bool with_public_device);
>  #define vm_normal_page(vma, addr, pte) _vm_normal_page(vma, addr, pte, false)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 915be4918a2b..f8dae021c2e5 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -341,7 +341,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  
>  	if (new) {
>  		*new = *orig;
> -		INIT_LIST_HEAD(&new->anon_vma_chain);
> +		INIT_VMA(new);
>  	}
>  	return new;
>  }
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bd7b9f293b39..5ad3a3228d76 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1765,6 +1765,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	vma->vm_flags = vm_flags;
>  	vma->vm_page_prot = vm_get_page_prot(vm_flags);
>  	vma->vm_pgoff = pgoff;
> +	INIT_VMA(vma);
>  
>  	if (file) {
>  		if (vm_flags & VM_DENYWRITE) {
> @@ -3037,6 +3038,7 @@ static int do_brk_flags(unsigned long addr, unsigned long len, unsigned long fla
>  	}
>  
>  	vma_set_anonymous(vma);
> +	INIT_VMA(vma);
>  	vma->vm_start = addr;
>  	vma->vm_end = addr + len;
>  	vma->vm_pgoff = pgoff;
> @@ -3395,6 +3397,7 @@ static struct vm_area_struct *__install_special_mapping(
>  	if (unlikely(vma == NULL))
>  		return ERR_PTR(-ENOMEM);
>  
> +	INIT_VMA(vma);
>  	vma->vm_start = addr;
>  	vma->vm_end = addr + len;
>  
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 749276beb109..acf7ca72ca90 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1210,6 +1210,7 @@ unsigned long do_mmap(struct file *file,
>  	region->vm_flags = vm_flags;
>  	region->vm_pgoff = pgoff;
>  
> +	INIT_VMA(vma);
>  	vma->vm_flags = vm_flags;
>  	vma->vm_pgoff = pgoff;
>  
> -- 
> 2.21.0
> 
