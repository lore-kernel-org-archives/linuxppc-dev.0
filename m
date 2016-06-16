Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVWgb6kTyzDql3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 15:11:07 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id 66so3196570pfy.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 22:11:07 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm/radix: Update Radix tree size as per ISA 3.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1466047309-8390-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <2cb66bb4-26aa-5e16-5cd4-9b171f8f4486@gmail.com>
Date: Thu, 16 Jun 2016 15:10:59 +1000
MIME-Version: 1.0
In-Reply-To: <1466047309-8390-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/06/16 13:21, Aneesh Kumar K.V wrote:
> ISA 3.0 updated it to be encoded as Radix tree size = 2^(RTS + 31). We
> have it encoded as 2^(RTS + 28). Add a helper with the correct encoding
> and use it instead of opencoding.
> 
> Fixes commit 2bfd65e45e87 ("powerpc/mm/radix: Add radix callbacks for
> early init routine ")
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/radix.h | 15 +++++++++++++++
>  arch/powerpc/mm/mmu_context_book3s64.c     |  2 +-
>  arch/powerpc/mm/pgtable-radix.c            |  9 +++------
>  3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
> index 0d980de55c40..cdf791af8ab2 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -260,5 +260,20 @@ extern void radix__vmemmap_remove_mapping(unsigned long start,
>  
>  extern int radix__map_kernel_page(unsigned long ea, unsigned long pa,
>  				 pgprot_t flags, unsigned int psz);
> +
> +static inline unsigned long radix__get_rts_value(void)

How about radix__get_tree_size()?

> +{
> +	unsigned long rts_field;
> +	/*
> +	 * we support 52 bits, hence 52-31 = 21, 0b10101
> +	 * RTS encoding details
> +	 * bits 0 - 3 of rts -> bits 6 - 8 unsigned long
> +	 * bits 4 - 5 of rts -> bits 62 - 63 of unsigned long
> +	 */
> +	rts_field = (0x5UL << 5); /* 6 - 8 bits */
> +	rts_field |= (0x2UL << 61);
> +
> +	return rts_field;
> +}


Looks good otherwise

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
