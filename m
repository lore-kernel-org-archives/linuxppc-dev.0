Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7DEC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 22:09:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F2520693
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 22:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F2520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lYF12RQpzDqPR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 08:09:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jglisse@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lY8K1mllzDq9Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 08:05:53 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3EE7301EA88;
 Thu, 18 Apr 2019 22:05:50 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46F5A600C5;
 Thu, 18 Apr 2019 22:05:47 +0000 (UTC)
Date: Thu, 18 Apr 2019 18:05:45 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v12 06/31] mm: introduce pte_spinlock for
 FAULT_FLAG_SPECULATIVE
Message-ID: <20190418220545.GF11645@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-7-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-7-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 18 Apr 2019 22:05:51 +0000 (UTC)
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

On Tue, Apr 16, 2019 at 03:44:57PM +0200, Laurent Dufour wrote:
> When handling page fault without holding the mmap_sem the fetch of the
> pte lock pointer and the locking will have to be done while ensuring
> that the VMA is not touched in our back.
> 
> So move the fetch and locking operations in a dedicated function.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>


> ---
>  mm/memory.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index fc3698d13cb5..221ccdf34991 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2073,6 +2073,13 @@ int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(apply_to_page_range);
>  
> +static inline bool pte_spinlock(struct vm_fault *vmf)
> +{
> +	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
> +	spin_lock(vmf->ptl);
> +	return true;
> +}
> +
>  static inline bool pte_map_lock(struct vm_fault *vmf)
>  {
>  	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> @@ -3656,8 +3663,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	 * validation through pte_unmap_same(). It's of NUMA type but
>  	 * the pfn may be screwed if the read is non atomic.
>  	 */
> -	vmf->ptl = pte_lockptr(vma->vm_mm, vmf->pmd);
> -	spin_lock(vmf->ptl);
> +	if (!pte_spinlock(vmf))
> +		return VM_FAULT_RETRY;
>  	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  		goto out;
> @@ -3850,8 +3857,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>  	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
>  		return do_numa_page(vmf);
>  
> -	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
> -	spin_lock(vmf->ptl);
> +	if (!pte_spinlock(vmf))
> +		return VM_FAULT_RETRY;
>  	entry = vmf->orig_pte;
>  	if (unlikely(!pte_same(*vmf->pte, entry)))
>  		goto unlock;
> -- 
> 2.21.0
> 
