Return-Path: <SRS0=Oz1q=T5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11883C28CC0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 May 2019 18:06:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654D324027
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 May 2019 18:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654D324027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Ddv60cqZzDqRp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 04:06:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45DdsR6zZXzDqCq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2019 04:04:50 +1000 (AEST)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 May 2019 11:04:48 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga002.jf.intel.com with ESMTP; 29 May 2019 11:04:46 -0700
Date: Wed, 29 May 2019 11:05:48 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v2] mm: add account_locked_vm utility function
Message-ID: <20190529180547.GA16182@iweiny-DESK2.sc.intel.com>
References: <de375582-2c35-8e8a-4737-c816052a8e58@ozlabs.ru>
 <20190524175045.26897-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524175045.26897-1-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: Mark Rutland <mark.rutland@arm.com>, Davidlohr Bueso <dave@stgolabs.net>,
 kvm@vger.kernel.org, Alan Tull <atull@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Moritz Fischer <mdf@kernel.org>,
 Steve Sistare <steven.sistare@oracle.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Lameter <cl@linux.com>,
 Wu Hao <hao.wu@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 24, 2019 at 01:50:45PM -0400, Daniel Jordan wrote:

[snip]

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0e8834ac32b7..72c1034d2ec7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1564,6 +1564,25 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  int get_user_pages_fast(unsigned long start, int nr_pages,
>  			unsigned int gup_flags, struct page **pages);
>  
> +int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
> +			struct task_struct *task, bool bypass_rlim);
> +
> +static inline int account_locked_vm(struct mm_struct *mm, unsigned long pages,
> +				    bool inc)
> +{
> +	int ret;
> +
> +	if (pages == 0 || !mm)
> +		return 0;
> +
> +	down_write(&mm->mmap_sem);
> +	ret = __account_locked_vm(mm, pages, inc, current,
> +				  capable(CAP_IPC_LOCK));
> +	up_write(&mm->mmap_sem);
> +
> +	return ret;
> +}
> +
>  /* Container for pinned pfns / pages */
>  struct frame_vector {
>  	unsigned int nr_allocated;	/* Number of frames we have space for */
> diff --git a/mm/util.c b/mm/util.c
> index e2e4f8c3fa12..bd3bdf16a084 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -6,6 +6,7 @@
>  #include <linux/err.h>
>  #include <linux/sched.h>
>  #include <linux/sched/mm.h>
> +#include <linux/sched/signal.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/security.h>
>  #include <linux/swap.h>
> @@ -346,6 +347,51 @@ int __weak get_user_pages_fast(unsigned long start,
>  }
>  EXPORT_SYMBOL_GPL(get_user_pages_fast);
>  
> +/**
> + * __account_locked_vm - account locked pages to an mm's locked_vm
> + * @mm:          mm to account against, may be NULL

This kernel doc is wrong.  You dereference mm straight away...

> + * @pages:       number of pages to account
> + * @inc:         %true if @pages should be considered positive, %false if not
> + * @task:        task used to check RLIMIT_MEMLOCK
> + * @bypass_rlim: %true if checking RLIMIT_MEMLOCK should be skipped
> + *
> + * Assumes @task and @mm are valid (i.e. at least one reference on each), and
> + * that mmap_sem is held as writer.
> + *
> + * Return:
> + * * 0       on success
> + * * 0       if @mm is NULL (can happen for example if the task is exiting)
> + * * -ENOMEM if RLIMIT_MEMLOCK would be exceeded.
> + */
> +int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
> +			struct task_struct *task, bool bypass_rlim)
> +{
> +	unsigned long locked_vm, limit;
> +	int ret = 0;
> +
> +	locked_vm = mm->locked_vm;

here...

Perhaps the comment was meant to document account_locked_vm()?  Or should the
parameter checks be moved here?

Ira

> +	if (inc) {
> +		if (!bypass_rlim) {
> +			limit = task_rlimit(task, RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +			if (locked_vm + pages > limit)
> +				ret = -ENOMEM;
> +		}
> +		if (!ret)
> +			mm->locked_vm = locked_vm + pages;
> +	} else {
> +		WARN_ON_ONCE(pages > locked_vm);
> +		mm->locked_vm = locked_vm - pages;
> +	}
> +
> +	pr_debug("%s: [%d] caller %ps %c%lu %lu/%lu%s\n", __func__, task->pid,
> +		 (void *)_RET_IP_, (inc) ? '+' : '-', pages << PAGE_SHIFT,
> +		 locked_vm << PAGE_SHIFT, task_rlimit(task, RLIMIT_MEMLOCK),
> +		 ret ? " - exceeded" : "");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(__account_locked_vm);
>

> +
>  unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
>  	unsigned long len, unsigned long prot,
>  	unsigned long flag, unsigned long pgoff)
> 
> base-commit: a188339ca5a396acc588e5851ed7e19f66b0ebd9
> -- 
> 2.21.0
> 
