Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtqFn5w1dzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 14:03:25 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2U2sdMY102396
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 23:03:18 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29gpubptvw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 23:03:18 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 30 Mar 2017 08:33:15 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2U31u3814155994
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 08:31:56 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2U33BMu019177
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 08:33:12 +0530
Subject: Re: [PATCH V5 16/17] mm: Let arch choose the initial value of task
 size
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1490153823-29241-17-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 30 Mar 2017 08:33:11 +0530
MIME-Version: 1.0
In-Reply-To: <1490153823-29241-17-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <77aeea83-0334-45b7-3f40-4a1d8619d191@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/22/2017 09:07 AM, Aneesh Kumar K.V wrote:
> As we start supporting larger address space (>128TB), we want to give
> architecture a control on max task size of an application which is different
> from the TASK_SIZE. For ex: ppc64 needs to track the base page size of a segment
> and it is copied from mm_context_t to PACA on each context switch. If we know that
> application has not used an address range above 128TB we only need to copy
> details about 128TB range to PACA. This will help in improving context switch
> performance by avoiding larger copy operation.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  fs/exec.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 65145a3df065..5550a56d03c3 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1308,6 +1308,14 @@ void would_dump(struct linux_binprm *bprm, struct file *file)
>  }
>  EXPORT_SYMBOL(would_dump);
>  
> +#ifndef arch_init_task_size
> +static inline void arch_init_task_size(void)
> +{
> +	current->mm->task_size = TASK_SIZE;
> +}
> +#define arch_init_task_size arch_init_task_size
> +#endif

Why not a proper CONFIG_ARCH_DEFINED_TASK_SIZE kind of option for
this ? Also are there no assumptions about task current->mm->size
being TASK_SIZE in other places which might get broken ?
