Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHWjh0zGnzDqmr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 20:36:07 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6QAZX7p143628
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 06:36:05 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bxnxv25qc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 06:36:05 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 26 Jul 2017 20:36:01 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6QAZxSK26476620
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 20:35:59 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6QAZnFH018084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 20:35:50 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, mhocko@kernel.org
Subject: Re: [PATCH 1/6] powerpc: Free up four 64K PTE bits in 4K backed HPTE
 pages
In-Reply-To: <1500663129-10615-2-git-send-email-linuxram@us.ibm.com>
References: <1500663129-10615-1-git-send-email-linuxram@us.ibm.com>
 <1500663129-10615-2-git-send-email-linuxram@us.ibm.com>
Date: Wed, 26 Jul 2017 16:05:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgnb1o57.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> Rearrange 64K PTE bits to  free  up  bits 3, 4, 5  and  6,
> in the 4K backed HPTE pages.These bits continue to be used
> for 64K backed HPTE pages in this patch, but will be freed
> up in the next patch. The  bit  numbers are big-endian  as
> defined in the ISA3.0
>
> The patch does the following change to the 4k htpe backed
> 64K PTE's format.
>
> H_PAGE_BUSY moves from bit 3 to bit 9 (B bit in the figure
> 		below)
> V0 which occupied bit 4 is not used anymore.
> V1 which occupied bit 5 is not used anymore.
> V2 which occupied bit 6 is not used anymore.
> V3 which occupied bit 7 is not used anymore.
>
> Before the patch, the 4k backed 64k PTE format was as follows
>
>  0 1 2 3 4  5  6  7  8 9 10...........................63
>  : : : : :  :  :  :  : : :                            :
>  v v v v v  v  v  v  v v v                            v
>
> ,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
> |x|x|x|B|V0|V1|V2|V3|x| | |x|x|................|x|x|x|x| <- primary pte
> '_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'
> |S|G|I|X|S |G |I |X |S|G|I|X|..................|S|G|I|X| <- secondary pte
> '_'_'_'_'__'__'__'__'_'_'_'_'__________________'_'_'_'_'
>
> After the patch, the 4k backed 64k PTE format is as follows
>
>  0 1 2 3 4  5  6  7  8 9 10...........................63
>  : : : : :  :  :  :  : : :                            :
>  v v v v v  v  v  v  v v v                            v
>
> ,-,-,-,-,--,--,--,--,-,-,-,-,-,------------------,-,-,-,
> |x|x|x| |  |  |  |  |x|B| |x|x|................|.|.|.|.| <- primary pte
> '_'_'_'_'__'__'__'__'_'_'_'_'_'________________'_'_'_'_'
> |S|G|I|X|S |G |I |X |S|G|I|X|..................|S|G|I|X| <- secondary pte
> '_'_'_'_'__'__'__'__'_'_'_'_'__________________'_'_'_'_'
>
> the four  bits S,G,I,X (one quadruplet per 4k HPTE) that
> cache  the  hash-bucket  slot  value, is initialized  to
> 1,1,1,1 indicating -- an invalid slot.   If  a HPTE gets
> cached in a 1111  slot(i.e 7th  slot  of  secondary hash
> bucket), it is  released  immediately. In  other  words,
> even  though 1111   is   a valid slot  value in the hash
> bucket, we consider it invalid and  release the slot and
> the HPTE.  This  gives  us  the opportunity to determine
> the validity of S,G,I,X  bits  based on its contents and
> not on any of the bits V0,V1,V2 or V3 in the primary PTE
>
> When   we  release  a    HPTE    cached in the 1111 slot
> we also    release  a  legitimate   slot  in the primary
> hash bucket  and  unmap  its  corresponding  HPTE.  This
> is  to  ensure   that  we do get a HPTE cached in a slot
> of the primary hash bucket, the next time we retry.
>
> Though  treating  1111  slot  as  invalid,  reduces  the
> number of  available  slots  in the hash bucket and  may
> have  an  effect   on the performance, the probabilty of
> hitting a 1111 slot is extermely low.
>
> Compared  to  the  current   scheme, the above described
> scheme  reduces  the  number of false hash table updates
> significantly   and    has  the   added   advantage   of
> releasing  four  valuable  PTE bits for other purpose.
>
> NOTE:even though bits 3, 4, 5, 6, 7 are  not  used  when
> the  64K  PTE is backed by 4k HPTE,  they continue to be
> used  if  the  PTE  gets  backed  by 64k HPTE.  The next
> patch will decouple that aswell, and truely  release the
> bits.
>
> This idea was jointly developed by Paul Mackerras,
> Aneesh, Michael Ellermen and myself.
>
> 4K PTE format remains unchanged currently.
>
> The patch does the following code changes
> a) PTE flags are split between 64k and 4k  header files.
> b) __hash_page_4K()  is  reimplemented   to reflect the
>    above logic.
>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  |    2 +
>  arch/powerpc/include/asm/book3s/64/hash-64k.h |    8 +--
>  arch/powerpc/include/asm/book3s/64/hash.h     |    1 -
>  arch/powerpc/mm/hash64_64k.c                  |   74 ++++++++++++++++---------
>  arch/powerpc/mm/hash_utils_64.c               |    4 +-
>  5 files changed, 55 insertions(+), 34 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> index 0c4e470..f959c00 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -16,6 +16,8 @@
>  #define H_PUD_TABLE_SIZE	(sizeof(pud_t) << H_PUD_INDEX_SIZE)
>  #define H_PGD_TABLE_SIZE	(sizeof(pgd_t) << H_PGD_INDEX_SIZE)
>
> +#define H_PAGE_BUSY	_RPAGE_RSV1     /* software: PTE & hash are busy */
> +
>  /* PTE flags to conserve for HPTE identification */
>  #define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | \
>  			 H_PAGE_F_SECOND | H_PAGE_F_GIX)
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 9732837..62e580c 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -12,18 +12,14 @@
>   */
>  #define H_PAGE_COMBO	_RPAGE_RPN0 /* this is a combo 4k page */
>  #define H_PAGE_4K_PFN	_RPAGE_RPN1 /* PFN is for a single 4k page */
> +#define H_PAGE_BUSY	_RPAGE_RPN42     /* software: PTE & hash are busy */


Why are we moving H_PAGE_BUSY. Right now 4k and 64k linux page table
format looks similar. We use the lower RPN bits only for subpage
tracking/details.


> +
>  /*
>   * We need to differentiate between explicit huge page and THP huge
>   * page, since THP huge page also need to track real subpage details
>   */
>  #define H_PAGE_THP_HUGE  H_PAGE_4K_PFN
>


-aneesh
