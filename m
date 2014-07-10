Return-Path: <hartb@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 50D601A01BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 23:59:59 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hartb@linux.vnet.ibm.com>;
 Thu, 10 Jul 2014 09:59:56 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id B566DC90041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 09:59:48 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6ADxtK610289454
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 13:59:55 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6ADxspP026025
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 09:59:54 -0400
Date: Thu, 10 Jul 2014 08:59:52 -0500
From: Brian W Hart <hartb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2] powerpc: Fail remap_4k_pfn() if PFN doesn't fit
 inside PTE
Message-ID: <20140710135952.GA8014@oc3347516403.ibm.com>
References: <53BE51EB.5090208@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53BE51EB.5090208@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 10, 2014 at 02:12:19PM +0530, Madhusudanan Kandasamy wrote:
> V2 : Rewritten to avoid helper function as suggested by Stephen Rothwell.
> remap_4k_pfn() silently truncates upper bits of input 4K PFN if
> it cannot be contained in PTE. This leads invalid memory mapping
> and could result in a system crash when the memory is accessed.
> This patch fails remap_4k_pfn() and returns -EINVAL if the input
> 4K PFN cannot be contained in PTE.
> 
> Signed-off-by: Madhusudanan Kandasamy <kmadhu@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/pte-hash64-64k.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/pte-hash64-64k.h b/arch/powerpc/include/asm/pte-hash64-64k.h
> index d836d94..b5178e4 100644
> --- a/arch/powerpc/include/asm/pte-hash64-64k.h
> +++ b/arch/powerpc/include/asm/pte-hash64-64k.h
> @@ -75,7 +75,8 @@
>  	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)
> 
>  #define remap_4k_pfn(vma, addr, pfn, prot)				\
> -	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,		\
> +	WARN_ON((pfn >= (1UL << (64 - PTE_RPN_SHIFT)))) ? -EINVAL :	\
> +		remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,	\
>  			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN))
> 
>  #endif	/* __ASSEMBLY__ */
> -- 
> 2.0.1

Chatted with Madhu.  He'll send a new version that adds some
parentheses to protect 'pfn' inside the macro and the entire macro
against use cases like:

    !remap_4k_pfn(...)

brian
