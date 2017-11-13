Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yZz2q6KRDzDqYd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 15:59:47 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAD4xbP3073756
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 23:59:45 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e72c1nsac-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 23:59:44 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 13 Nov 2017 04:59:43 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Florian Weimer <fweimer@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 2/5] powerpc/64s/hash: Fix fork() with 512TB process
 address space
In-Reply-To: <20171109172740.19681-3-npiggin@gmail.com>
References: <20171109172740.19681-1-npiggin@gmail.com>
 <20171109172740.19681-3-npiggin@gmail.com>
Date: Mon, 13 Nov 2017 10:29:38 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efp2srid.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> Hash unconditionally resets the addr_limit to default (128TB) when
> the mm context is initialised. If a process has > 128TB mappings when
> it forks, the child will not get the 512TB addr_limit, so accesses to
> valid > 128TB mappings will fail in the child.
>
> Fix this by only resetting the addr_limit to default if it was 0. Non
> zero indicates it was duplicated from the parent (0 means exec()).
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/mmu_context_book3s64.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index 6d724dab27c2..846cbad45fce 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -93,11 +93,11 @@ static int hash__init_new_context(struct mm_struct *mm)
>  		return index;
>
>  	/*
> -	 * We do switch_slb() early in fork, even before we setup the
> -	 * mm->context.addr_limit. Default to max task size so that we copy the
> -	 * default values to paca which will help us to handle slb miss early.
> +	 * In the case of exec, use the default limit,
> +	 * otherwise inherit it from the mm we are duplicating.
>  	 */
> -	mm->context.addr_limit = DEFAULT_MAP_WINDOW_USER64;
> +	if (!mm->context.addr_limit)
> +		mm->context.addr_limit = DEFAULT_MAP_WINDOW_USER64;
>
>  	/*
>  	 * The old code would re-promote on fork, we don't do that when using
> -- 
> 2.15.0
