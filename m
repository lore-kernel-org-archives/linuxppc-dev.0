Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFC7C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:49:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF05A2173C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF05A2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jzrb1zCdzDqDN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 15:49:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jzpr0bV1zDqDG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 15:47:31 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2D4dMAA044146
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 00:47:28 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r6ty28d67-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 00:47:28 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 13 Mar 2019 04:47:25 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 13 Mar 2019 04:47:22 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2D4lL8C28180590
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Mar 2019 04:47:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89197A4054;
 Wed, 13 Mar 2019 04:47:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31817A405C;
 Wed, 13 Mar 2019 04:47:19 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.49.154])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 13 Mar 2019 04:47:18 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com, Ross Zwisler <zwisler@kernel.org>,
 Jan Kara <jack@suse.cz>, akpm@linux-foundation.org
Subject: Re: [PATCH v2] fs/dax: deposit pagetable even when installing zero
 page
In-Reply-To: <20190309120721.21416-1-aneesh.kumar@linux.ibm.com>
References: <20190309120721.21416-1-aneesh.kumar@linux.ibm.com>
Date: Wed, 13 Mar 2019 10:17:17 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19031304-0028-0000-0000-0000035356B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031304-0029-0000-0000-00002411DD07
Message-Id: <8736nrnzxm.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-13_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130033
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
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-nvdimm@lists.01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Hi Dan/Andrew/Jan,

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

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
> Fixes: b5beae5e224f ("powerpc/pseries: Add driver for PAPR SCM regions")
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Any suggestion on which tree this patch should got to? Also since this
fix a kernel crash, we may want to get this to 5.1?

> ---
> Changes from v1:
> * Add reviewed-by:
> * Add Fixes:
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

-aneesh

