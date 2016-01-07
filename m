Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC63F1A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jan 2016 21:30:57 +1100 (AEDT)
Message-ID: <1452162650.5826.2.camel@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the powerpc tree
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Michael
 Neuling <mikey@neuling.org>
Date: Thu, 07 Jan 2016 21:30:50 +1100
In-Reply-To: <20160107191613.0228560b@canb.auug.org.au>
References: <20160107191613.0228560b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-01-07 at 19:16 +1100, Stephen Rothwell wrote:
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

Well that's rather embarrassing, for Mikey ;D

> This build has CONFIG_PPC_MM_SLICES not set ...

Ugh, but it would seem none of our defconfigs do :/

> I have applied the following patch for today:

Thanks.

I'll merge it or something similar once I get a chance to test it.

cheers
