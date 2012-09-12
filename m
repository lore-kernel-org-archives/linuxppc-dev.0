Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 543402C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 09:08:13 +1000 (EST)
Message-ID: <1347491161.2276.14.camel@pasglop>
Subject: Re: [PATCH] powerpc: fix typo in PTRS_PER_PUD
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 13 Sep 2012 09:06:01 +1000
In-Reply-To: <20120912230009.GA17226@buserror.net>
References: <20120912230009.GA17226@buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-09-12 at 18:00 -0500, Scott Wood wrote:
> PTRS_PER_PUD should be based on PUD_INDEX_SIZE, not PMD_INDEX_SIZE.  We
> got away with it because PUD and PMD had the same index size, but this is
> no longer true with Aneesh's patchset to support a 46-bit user effective
> address space.

Ah, my typo :-) Cool, I'll make sure to apply that before Aneesh
patches.

Thanks,
Ben.

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/include/asm/pgtable-ppc64-4k.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/pgtable-ppc64-4k.h b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
> index b3eccf2..12798c9 100644
> --- a/arch/powerpc/include/asm/pgtable-ppc64-4k.h
> +++ b/arch/powerpc/include/asm/pgtable-ppc64-4k.h
> @@ -19,7 +19,7 @@
>  
>  #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
>  #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
> -#define PTRS_PER_PUD	(1 << PMD_INDEX_SIZE)
> +#define PTRS_PER_PUD	(1 << PUD_INDEX_SIZE)
>  #define PTRS_PER_PGD	(1 << PGD_INDEX_SIZE)
>  
>  /* PMD_SHIFT determines what a second-level page table entry can map */
