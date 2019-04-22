Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC47C10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:24:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306C820693
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 20:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306C820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nyjG4wRTzDqMM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 06:24:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jglisse@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nyNs0Z6DzDq5h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 06:09:55 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D7CC59468;
 Mon, 22 Apr 2019 20:09:47 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6880917CFF;
 Mon, 22 Apr 2019 20:09:43 +0000 (UTC)
Date: Mon, 22 Apr 2019 16:09:36 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH v12 14/31] mm/migrate: Pass vm_fault pointer to
 migrate_misplaced_page()
Message-ID: <20190422200936.GE14666@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-15-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-15-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Mon, 22 Apr 2019 20:09:47 +0000 (UTC)
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

On Tue, Apr 16, 2019 at 03:45:05PM +0200, Laurent Dufour wrote:
> migrate_misplaced_page() is only called during the page fault handling so
> it's better to pass the pointer to the struct vm_fault instead of the vma.
> 
> This way during the speculative page fault path the saved vma->vm_flags
> could be used.
> 
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  include/linux/migrate.h | 4 ++--
>  mm/memory.c             | 2 +-
>  mm/migrate.c            | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index e13d9bf2f9a5..0197e40325f8 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -125,14 +125,14 @@ static inline void __ClearPageMovable(struct page *page)
>  #ifdef CONFIG_NUMA_BALANCING
>  extern bool pmd_trans_migrating(pmd_t pmd);
>  extern int migrate_misplaced_page(struct page *page,
> -				  struct vm_area_struct *vma, int node);
> +				  struct vm_fault *vmf, int node);
>  #else
>  static inline bool pmd_trans_migrating(pmd_t pmd)
>  {
>  	return false;
>  }
>  static inline int migrate_misplaced_page(struct page *page,
> -					 struct vm_area_struct *vma, int node)
> +					 struct vm_fault *vmf, int node)
>  {
>  	return -EAGAIN; /* can't migrate now */
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index d0de58464479..56802850e72c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3747,7 +3747,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	}
>  
>  	/* Migrate to the requested node */
> -	migrated = migrate_misplaced_page(page, vma, target_nid);
> +	migrated = migrate_misplaced_page(page, vmf, target_nid);
>  	if (migrated) {
>  		page_nid = target_nid;
>  		flags |= TNF_MIGRATED;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a9138093a8e2..633bd9abac54 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1938,7 +1938,7 @@ bool pmd_trans_migrating(pmd_t pmd)
>   * node. Caller is expected to have an elevated reference count on
>   * the page that will be dropped by this function before returning.
>   */
> -int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
> +int migrate_misplaced_page(struct page *page, struct vm_fault *vmf,
>  			   int node)
>  {
>  	pg_data_t *pgdat = NODE_DATA(node);
> @@ -1951,7 +1951,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>  	 * with execute permissions as they are probably shared libraries.
>  	 */
>  	if (page_mapcount(page) != 1 && page_is_file_cache(page) &&
> -	    (vma->vm_flags & VM_EXEC))
> +	    (vmf->vma_flags & VM_EXEC))
>  		goto out;
>  
>  	/*
> -- 
> 2.21.0
> 
