Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y13DT6C2YzDsPH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 22:24:25 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8PCMAwU055397
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 08:24:23 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d6yp4ga8u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 08:24:23 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 25 Sep 2017 13:24:21 +0100
Subject: Re: [PATCH V2] cxl: Fix memory page not handled
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1506329896-2417-1-git-send-email-clombard@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 25 Sep 2017 14:24:18 +0200
MIME-Version: 1.0
In-Reply-To: <1506329896-2417-1-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <5fce0f8f-745d-37d4-1bf1-1e0124583995@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/09/2017 à 10:58, Christophe Lombard a écrit :
> The in-kernel 'library' API can be called by drivers to help
> interaction with an IBM XSL on a POWER9 system.
> 
> The cxllib_handle_fault() API is used to handle memory fault. All memory
> pages of the specified buffer have to be handled but under certain
> conditions,the last page may not be touched, and the address the
> adapter is trying to access is never sent to the kernel for resolution.
> 
> This patch reworks start address of the loop with an address aligned on
> the page size. In this context, the last page is not missed.
> 
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
> 
> Fixes: 3ced8d730063 ("cxl: Export library to support IBM XSL");
> 
> ---

Thanks,

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>



> Changelog[v2]
>   - Rebase to latest upstream.
>   - Change the start address of the loop.
>   - Rewrite the commit message.
> ---
>   drivers/misc/cxl/cxllib.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cxl/cxllib.c b/drivers/misc/cxl/cxllib.c
> index 5dba23c..ff7492d 100644
> --- a/drivers/misc/cxl/cxllib.c
> +++ b/drivers/misc/cxl/cxllib.c
> @@ -219,8 +219,17 @@ int cxllib_handle_fault(struct mm_struct *mm, u64 addr, u64 size, u64 flags)
> 
>   	down_read(&mm->mmap_sem);
> 
> -	for (dar = addr; dar < addr + size; dar += page_size) {
> -		if (!vma || dar < vma->vm_start || dar > vma->vm_end) {
> +	vma = find_vma(mm, addr);
> +	if (!vma) {
> +		pr_err("Can't find vma for addr %016llx\n", addr);
> +		rc = -EFAULT;
> +		goto out;
> +	}
> +	/* get the size of the pages allocated */
> +	page_size = vma_kernel_pagesize(vma);
> +
> +	for (dar = (addr & ~(page_size - 1)); dar < (addr + size); dar += page_size) {
> +		if (dar < vma->vm_start || dar > vma->vm_end) {
>   			vma = find_vma(mm, addr);
>   			if (!vma) {
>   				pr_err("Can't find vma for addr %016llx\n", addr);
> 
