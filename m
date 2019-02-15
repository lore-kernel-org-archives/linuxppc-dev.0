Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF695C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 09:55:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638B721924
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 09:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638B721924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4417tN63RjzDqgf
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 20:55:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ldufour@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4417rS2SrZzDqfG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 20:53:56 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1F9nJ56129167
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 04:53:54 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qntdh25tt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 04:53:54 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 15 Feb 2019 09:53:51 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 15 Feb 2019 09:53:48 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1F9rlGd6685172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Feb 2019 09:53:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3075342045;
 Fri, 15 Feb 2019 09:53:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A825C4203F;
 Fri, 15 Feb 2019 09:53:46 +0000 (GMT)
Received: from [9.145.61.176] (unknown [9.145.61.176])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 15 Feb 2019 09:53:46 +0000 (GMT)
Subject: Re: [PATCH] powerpc/mm: Handle mmap_min_addr correctly in
 get_unmapped_area callback
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20190215081647.24876-1-aneesh.kumar@linux.ibm.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 15 Feb 2019 10:53:46 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190215081647.24876-1-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021509-0016-0000-0000-00000256CAEA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021509-0017-0000-0000-000032B0FF67
Message-Id: <66c2abb2-e911-5542-804c-97b09ccaaa38@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-15_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=856 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150072
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Le 15/02/2019 à 09:16, Aneesh Kumar K.V a écrit :
> After we ALIGN up the address we need to make sure we didn't overflow
> and resulted in zero address. In that case, we need to make sure that
> the returned address is greater than mmap_min_addr.
> 
> Also when doing top-down search the low_limit is not PAGE_SIZE but rather
> max(PAGE_SIZE, mmap_min_addr). This handle cases in which mmap_min_addr >
> PAGE_SIZE.
> 
> This fixes selftest va_128TBswitch --run-hugetlb reporting failures when
> run as non root user for
> 
> mmap(-1, MAP_HUGETLB)
> mmap(-1, MAP_HUGETLB)
> 
> We also avoid the first mmap(-1, MAP_HUGETLB) returning NULL address as mmap address
> with this change

FWIW:
Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>

> CC: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>   arch/powerpc/mm/hugetlbpage-radix.c |  5 +++--
>   arch/powerpc/mm/slice.c             | 10 ++++++----
>   2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
> index 2486bee0f93e..97c7a39ebc00 100644
> --- a/arch/powerpc/mm/hugetlbpage-radix.c
> +++ b/arch/powerpc/mm/hugetlbpage-radix.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <linux/mm.h>
>   #include <linux/hugetlb.h>
> +#include <linux/security.h>
>   #include <asm/pgtable.h>
>   #include <asm/pgalloc.h>
>   #include <asm/cacheflush.h>
> @@ -73,7 +74,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   	if (addr) {
>   		addr = ALIGN(addr, huge_page_size(h));
>   		vma = find_vma(mm, addr);
> -		if (high_limit - len >= addr &&
> +		if (high_limit - len >= addr && addr >= mmap_min_addr &&
>   		    (!vma || addr + len <= vm_start_gap(vma)))
>   			return addr;
>   	}
> @@ -83,7 +84,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   	 */
>   	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>   	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
>   	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
>   	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
>   	info.align_offset = 0;
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 06898c13901d..aec91dbcdc0b 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -32,6 +32,7 @@
>   #include <linux/export.h>
>   #include <linux/hugetlb.h>
>   #include <linux/sched/mm.h>
> +#include <linux/security.h>
>   #include <asm/mman.h>
>   #include <asm/mmu.h>
>   #include <asm/copro.h>
> @@ -377,6 +378,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
>   	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
>   	unsigned long addr, found, prev;
>   	struct vm_unmapped_area_info info;
> +	unsigned long min_addr = max(PAGE_SIZE, mmap_min_addr);
> 
>   	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>   	info.length = len;
> @@ -393,7 +395,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
>   	if (high_limit > DEFAULT_MAP_WINDOW)
>   		addr += mm->context.slb_addr_limit - DEFAULT_MAP_WINDOW;
> 
> -	while (addr > PAGE_SIZE) {
> +	while (addr > min_addr) {
>   		info.high_limit = addr;
>   		if (!slice_scan_available(addr - 1, available, 0, &addr))
>   			continue;
> @@ -405,8 +407,8 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
>   		 * Check if we need to reduce the range, or if we can
>   		 * extend it to cover the previous available slice.
>   		 */
> -		if (addr < PAGE_SIZE)
> -			addr = PAGE_SIZE;
> +		if (addr < min_addr)
> +			addr = min_addr;
>   		else if (slice_scan_available(addr - 1, available, 0, &prev)) {
>   			addr = prev;
>   			goto prev_slice;
> @@ -528,7 +530,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   		addr = _ALIGN_UP(addr, page_size);
>   		slice_dbg(" aligned addr=%lx\n", addr);
>   		/* Ignore hint if it's too large or overlaps a VMA */
> -		if (addr > high_limit - len ||
> +		if (addr > high_limit - len || addr < mmap_min_addr ||
>   		    !slice_area_is_free(mm, addr, len))
>   			addr = 0;
>   	}
> 

