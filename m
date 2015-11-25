Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD43E1A032F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 17:36:37 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 25 Nov 2015 16:36:36 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3487B3578047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 17:36:31 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAP6aNdH58458232
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 17:36:31 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAP6ZwCe009376
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 17:35:58 +1100
Message-ID: <565556BB.9070201@linux.vnet.ibm.com>
Date: Wed, 25 Nov 2015 12:05:39 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 14/31] powerpc/booke: Move nohash headers (part 2)
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1448274160-28446-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some sort of commit message enlisting what we copied from where and
which all header file references have changed will be helpful here.

On 11/23/2015 03:52 PM, Aneesh Kumar K.V wrote:
> Acked-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/{pgtable-ppc32.h => nohash/32/pgtable.h} | 0
>  arch/powerpc/include/asm/{pgtable-ppc64.h => nohash/64/pgtable.h} | 2 +-
>  arch/powerpc/include/asm/nohash/pgtable.h                         | 8 ++++----
>  3 files changed, 5 insertions(+), 5 deletions(-)
>  rename arch/powerpc/include/asm/{pgtable-ppc32.h => nohash/32/pgtable.h} (100%)
>  rename arch/powerpc/include/asm/{pgtable-ppc64.h => nohash/64/pgtable.h} (99%)
> 
> diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
> similarity index 100%
> rename from arch/powerpc/include/asm/pgtable-ppc32.h
> rename to arch/powerpc/include/asm/nohash/32/pgtable.h
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> similarity index 99%
> rename from arch/powerpc/include/asm/pgtable-ppc64.h
> rename to arch/powerpc/include/asm/nohash/64/pgtable.h
> index 6be203d43fd1..9b4f9fcd64de 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -18,7 +18,7 @@
>   * Size of EA range mapped by our pagetables.
>   */
>  #define PGTABLE_EADDR_SIZE (PTE_INDEX_SIZE + PMD_INDEX_SIZE + \
> -                	    PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
> +			    PUD_INDEX_SIZE + PGD_INDEX_SIZE + PAGE_SHIFT)
>  #define PGTABLE_RANGE (ASM_CONST(1) << PGTABLE_EADDR_SIZE)
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
> index 91325997ba25..c0c41a2409d2 100644
> --- a/arch/powerpc/include/asm/nohash/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/pgtable.h

This should be added at the end of the file.

#endif /* _ASM_POWERPC_NOHASH_PGTABLE_H */
