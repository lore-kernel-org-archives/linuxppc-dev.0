Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 596A71A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 23:32:48 +1100 (AEDT)
In-Reply-To: <20160107191613.0228560b@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the powerpc tree
Message-Id: <20160112123248.131801401E7@ozlabs.org>
Date: Tue, 12 Jan 2016 23:32:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-07-01 at 08:16:13 UTC, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the powerpc tree, today's linux-next build (powerpc64
> allnoconfig) failed like this:
> 
> arch/powerpc/mm/hash_utils_64.c: In function 'get_paca_psize':
> arch/powerpc/mm/hash_utils_64.c:869:19: error: 'struct paca_struct' has no member named 'context'
>   return get_paca()->context.user_psize;
>                    ^
> arch/powerpc/mm/hash_utils_64.c:870:1: error: control reaches end of non-void function [-Werror=return-type]
>  }
>  ^
> 
> Caused by commit
> 
>   2fc251a8dda5 ("powerpc: Copy only required pieces of the mm_context_t to the paca")
> 
> This build has CONFIG_PPC_MM_SLICES not set ...
> 
> I have applied the following patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 7 Jan 2016 19:07:18 +1100
> Subject: [PATCH] powerpc: restore the user_psize member of the mm_context_t in
>  the paca
> 
> It is used when CONFIG_PPC_MM_SLICES is not set.
> 
> Fixes: 2fc251a8dda5 ("powerpc: Copy only required pieces of the mm_context_t to the paca")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c33e54fafacaf83b3e345aae0e

cheers
