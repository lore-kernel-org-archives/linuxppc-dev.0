Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EE791A03F4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 15:53:09 +1100 (AEDT)
Date: Thu, 25 Feb 2016 14:41:13 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 07/18] powerpc/mm: Update masked bits for linux page
 table
Message-ID: <20160225034113.GF18753@oak.ozlabs.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456202900-5454-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 23, 2016 at 10:18:09AM +0530, Aneesh Kumar K.V wrote:
> We now use physical address in upper page table tree levels. Even though
> they are aligned to their size, for the masked bits we use the
> overloaded bit positions as per PowerISA 3.0. We keep the bad bits check
> as it is, and will use conditional there when adding radix. Bad bits
> check also check for reserved bits and we oveload some of the reserved
> fields of radix in hash config.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index f0f5f91d7909..60c2c912c3a7 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -60,15 +60,12 @@
>  #define PTE_FRAG_SIZE_SHIFT  12
>  #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
>  
> -/*
> - * Bits to mask out from a PMD to get to the PTE page
> - * PMDs point to PTE table fragments which are PTE_FRAG_SIZE aligned.
> - */
> -#define PMD_MASKED_BITS		(PTE_FRAG_SIZE - 1)
> -/* Bits to mask out from a PGD/PUD to get to the PMD page */
> -#define PUD_MASKED_BITS		0x1ff
> -/* FIXME!! Will be fixed in next patch */
> -#define PGD_MASKED_BITS		0
> +/* Bits to mask out from a PMD to get to the PTE page */
> +#define PMD_MASKED_BITS		0xc0000000000000ffUL
> +/* Bits to mask out from a PUD to get to the PMD page */
> +#define PUD_MASKED_BITS		0xc0000000000000ffUL
> +/* Bits to mask out from a PGD to get to the PUD page */
> +#define PGD_MASKED_BITS		0xc0000000000000ffUL

Why not fold this into the previous patch?  (and include this patch's
commentary in the previous patch's commentary, of course)

Paul.
