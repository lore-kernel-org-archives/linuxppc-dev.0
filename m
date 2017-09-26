Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1NTw4YvBzDsM9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 11:22:11 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8Q1LpSG091775
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 21:22:09 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d7abefpny-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 21:22:08 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 26 Sep 2017 11:22:06 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8Q1KnSE40108238
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 11:20:49 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8Q1KqBu001555
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 11:20:52 +1000
Subject: Re: [PATCH V2] cxl: Fix memory page not handled
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com
References: <1506329896-2417-1-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 26 Sep 2017 11:20:47 +1000
MIME-Version: 1.0
In-Reply-To: <1506329896-2417-1-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d3c13a15-962e-b840-ceb8-a7724db879ac@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/09/17 18:58, Christophe Lombard wrote:
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

The duplication of the find_vma() depresses me slightly but I suppose 
there's not much that can be done there :)

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> 
> ---
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

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
