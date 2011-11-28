Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5F0DB1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 09:50:53 +1100 (EST)
Message-ID: <1322520637.23348.52.camel@pasglop>
Subject: Re: [PATCH 03/13] powerpc: Fix booke hugetlb preload code for
 PPC_MM_SLICES and 64-bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
Date: Tue, 29 Nov 2011 09:50:37 +1100
In-Reply-To: <13182798681100-git-send-email-beckyb@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 	return;
>  
>  #ifdef CONFIG_PPC_MM_SLICES
> -	psize = mmu_get_tsize(get_slice_psize(mm, ea));
> -	tsize = mmu_get_psize(psize);
> +	psize = get_slice_psize(mm, ea);
> +	tsize = mmu_get_tsize(psize);
>  	shift = mmu_psize_defs[psize].shift;
>  #else
> -	vma = find_vma(mm, ea);
> -	psize = vma_mmu_pagesize(vma);	/* returns actual size in bytes */
> -	asm (PPC_CNTLZL "%0,%1" : "=r" (lz) : "r" (psize));
> -	shift = 31 - lz;
> -	tsize = 21 - lz;
> +	psize = vma_mmu_pagesize(find_vma(mm, ea));
> +	shift = __ilog2(psize);
> +	tsize = shift - 10;
>  #endif
>  

BTW. Can you remind me what is the business with slices vs. no slices on
Book3E ?

I'd like to avoid having to build separate kernels for A2 vs. FSL ... 

Cheers,
Ben.
