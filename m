Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497D1C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:27:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60B82171F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60B82171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4496dq0LBczDqHJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 20:27:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4496VY1sTnzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:21:05 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4904DAC5A;
 Thu, 28 Feb 2019 09:21:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id E00081E4263; Thu, 28 Feb 2019 10:21:01 +0100 (CET)
Date: Thu, 28 Feb 2019 10:21:01 +0100
From: Jan Kara <jack@suse.cz>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 1/2] fs/dax: deposit pagetable even when installing zero
 page
Message-ID: <20190228092101.GA22210@quack2.suse.cz>
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Oliver O'Halloran <oohall@gmail.com>, Ross Zwisler <zwisler@kernel.org>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu 28-02-19 14:05:21, Aneesh Kumar K.V wrote:
> Architectures like ppc64 use the deposited page table to store hardware
> page table slot information. Make sure we deposit a page table when
> using zero page at the pmd level for hash.
> 
> Without this we hit
> 
> Unable to handle kernel paging request for data at address 0x00000000
> Faulting instruction address: 0xc000000000082a74
> Oops: Kernel access of bad area, sig: 11 [#1]
> ....
> 
> NIP [c000000000082a74] __hash_page_thp+0x224/0x5b0
> LR [c0000000000829a4] __hash_page_thp+0x154/0x5b0
> Call Trace:
>  hash_page_mm+0x43c/0x740
>  do_hash_page+0x2c/0x3c
>  copy_from_iter_flushcache+0xa4/0x4a0
>  pmem_copy_from_iter+0x2c/0x50 [nd_pmem]
>  dax_copy_from_iter+0x40/0x70
>  dax_iomap_actor+0x134/0x360
>  iomap_apply+0xfc/0x1b0
>  dax_iomap_rw+0xac/0x130
>  ext4_file_write_iter+0x254/0x460 [ext4]
>  __vfs_write+0x120/0x1e0
>  vfs_write+0xd8/0x220
>  SyS_write+0x6c/0x110
>  system_call+0x3c/0x130
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Thanks for the patch. It looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

> ---
> TODO:
> * Add fixes tag 

Probably this is a problem since initial PPC PMEM support, isn't it?

								Honza

> 
>  fs/dax.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 6959837cc465..01bfb2ac34f9 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -33,6 +33,7 @@
>  #include <linux/sizes.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/iomap.h>
> +#include <asm/pgalloc.h>
>  #include "internal.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -1410,7 +1411,9 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  {
>  	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>  	unsigned long pmd_addr = vmf->address & PMD_MASK;
> +	struct vm_area_struct *vma = vmf->vma;
>  	struct inode *inode = mapping->host;
> +	pgtable_t pgtable = NULL;
>  	struct page *zero_page;
>  	spinlock_t *ptl;
>  	pmd_t pmd_entry;
> @@ -1425,12 +1428,22 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
>  			DAX_PMD | DAX_ZERO_PAGE, false);
>  
> +	if (arch_needs_pgtable_deposit()) {
> +		pgtable = pte_alloc_one(vma->vm_mm);
> +		if (!pgtable)
> +			return VM_FAULT_OOM;
> +	}
> +
>  	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
>  	if (!pmd_none(*(vmf->pmd))) {
>  		spin_unlock(ptl);
>  		goto fallback;
>  	}
>  
> +	if (pgtable) {
> +		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> +		mm_inc_nr_ptes(vma->vm_mm);
> +	}
>  	pmd_entry = mk_pmd(zero_page, vmf->vma->vm_page_prot);
>  	pmd_entry = pmd_mkhuge(pmd_entry);
>  	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
> @@ -1439,6 +1452,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  	return VM_FAULT_NOPAGE;
>  
>  fallback:
> +	if (pgtable)
> +		pte_free(vma->vm_mm, pgtable);
>  	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_page, *entry);
>  	return VM_FAULT_FALLBACK;
>  }
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
