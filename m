Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yZz336hNGzDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 15:59:59 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAD4xbeE126139
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 23:59:57 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e74eb0y60-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 23:59:57 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 13 Nov 2017 04:59:55 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Florian Weimer <fweimer@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 3/5] powerpc/64s/hash: Allow MAP_FIXED allocations to
 cross 128TB boundary
In-Reply-To: <20171109172740.19681-4-npiggin@gmail.com>
References: <20171109172740.19681-1-npiggin@gmail.com>
 <20171109172740.19681-4-npiggin@gmail.com>
Date: Mon, 13 Nov 2017 10:29:49 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87bmk6sri2.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> While mapping hints with a length that cross 128TB are disallowed,
> MAP_FIXED allocations that cross 128TB are allowed. These are failing
> on hash (on radix they succeed). Add an additional case for fixed
> mappings to expand the addr_limit when crossing 128TB.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/slice.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 3889201b560c..a4f93699194b 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -418,7 +418,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	unsigned long high_limit;
>
>  	high_limit = DEFAULT_MAP_WINDOW;
> -	if (addr >= high_limit)
> +	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
>  		high_limit = TASK_SIZE;
>
>  	if (len > high_limit)
> -- 
> 2.15.0
