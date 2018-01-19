Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNDYQ2g7QzDqpP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 19:30:50 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0J8TD1T021149
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 03:30:48 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fkc8ut9va-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 03:30:47 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 19 Jan 2018 08:30:44 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/5] powerpc/mm: Allow more than 16 low slices
In-Reply-To: <1c9752ac98fd3278ef448e2553053c287af42b3f.1516179904.git.christophe.leroy@c-s.fr>
References: <49148d07955d3e5f963cedf9adcfcc37c3e03ef4.1516179904.git.christophe.leroy@c-s.fr>
 <1c9752ac98fd3278ef448e2553053c287af42b3f.1516179904.git.christophe.leroy@c-s.fr>
Date: Fri, 19 Jan 2018 14:00:37 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87po66z1w2.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> While the implementation of the "slices" address space allows
> a significant amount of high slices, it limits the number of
> low slices to 16 due to the use of a single u64 low_slices_psize
> element in struct mm_context_t
>
> On the 8xx, the minimum slice size is the size of the area
> covered by a single PMD entry, ie 4M in 4K pages mode and 64M in
> 16K pages mode. This means we could have resp. up to 1024 and 64
> slices.
>
> In order to override this limitation, this patch switches the
> handling of low_slices to BITMAPs as done already for high_slices.

Does it have a performance impact. When we switched high_slices
that was one of the question asked. Now with a topdown search we should
mostly be using the high_slices. But it will good to get numbers for
ppc64 for this change.


>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: Usign slice_bitmap_xxx() macros instead of bitmap_xxx() functions.
>
>  arch/powerpc/include/asm/book3s/64/mmu.h |   2 +-
>  arch/powerpc/include/asm/mmu-8xx.h       |   2 +-
>  arch/powerpc/include/asm/paca.h          |   2 +-
>  arch/powerpc/kernel/paca.c               |   3 +-
>  arch/powerpc/mm/hash_utils_64.c          |  13 ++--
>  arch/powerpc/mm/slb_low.S                |   8 ++-
>  arch/powerpc/mm/slice.c                  | 104 +++++++++++++++++--------------
>  7 files changed, 74 insertions(+), 60 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index c9448e19847a..27e7e9732ea1 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -91,7 +91,7 @@ typedef struct {
>  	struct npu_context *npu_context;
>  
>  #ifdef CONFIG_PPC_MM_SLICES
> -	u64 low_slices_psize;	/* SLB page size encodings */
> +	unsigned char low_slices_psize[8]; /* SLB page size encodings */

Can that 8 be a #define?


>  	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
>  	unsigned long slb_addr_limit;
>  #else

-aneesh
