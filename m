Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94EA8B7B93
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 09:15:13 +1100 (EST)
Subject: Re: [RFC PATCH v4 1/2] powerpc: reserve fixmap entries for early debug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <731eb73d0a309d0c23b30bea3718b976c3782b71.1259871725.git.albert_herranz@yahoo.es>
References: <cover.1259871725.git.albert_herranz@yahoo.es>
	<731eb73d0a309d0c23b30bea3718b976c3782b71.1259871725.git.albert_herranz@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Dec 2009 09:15:08 +1100
Message-ID: <1260569708.16132.377.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-12-03 at 21:34 +0100, Albert Herranz wrote:
> Add a set of entries to the fixmap table to allow usage of known
> reserved virtual address space by early debug code.
> 
> The address space reserved is the top 128K of the 32-bit address
> space. This allows, if required, the use of a BAT to do the mappings.
> 
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

That will do for now. I have ideas to clean it up a bit but for now it's
fine.

> ---
>  arch/powerpc/include/asm/fixmap.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
> index f1f4e23..5c2c023 100644
> --- a/arch/powerpc/include/asm/fixmap.h
> +++ b/arch/powerpc/include/asm/fixmap.h
> @@ -44,6 +44,9 @@
>   */
>  enum fixed_addresses {
>  	FIX_HOLE,
> +	/* reserve the top 128K for early debugging purposes */
> +	FIX_EARLY_DEBUG_TOP = FIX_HOLE,
> +	FIX_EARLY_DEBUG_BASE = FIX_EARLY_DEBUG_TOP+((128*1024)/PAGE_SIZE)-1,
>  #ifdef CONFIG_HIGHMEM
>  	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
>  	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
