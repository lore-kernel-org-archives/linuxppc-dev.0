Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y703d0X1MzDrBS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 15:22:21 +1100 (AEDT)
In-Reply-To: <20171001143303.15671-1-chunkeey@gmail.com>
To: Christian Lamparter <chunkeey@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Subject: Re: [v3] powerpc: fix compile error on 64K pages on 40x, 44x
Message-Id: <3y703c6y0Hz9t44@ozlabs.org>
Date: Thu,  5 Oct 2017 15:22:20 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-10-01 at 14:33:03 UTC, Christian Lamparter wrote:
> The mmu context on the 40x, 44x does not define pte_frag
> entry. This causes gcc abort the compilation due to:
> 
> setup-common.c: In function ‘setup_arch’:
> setup-common.c:908: error: ‘mm_context_t’ has no ‘pte_frag’
> 
> This patch fixes the issue by removing the pte_frag
> initialization in setup-common.c.
> 
> This is possible, because the compiler will do the
> initialization, since the mm_context is a sub struct of
> init_mm. init_mm is declared in mm_types.h as external linkage.
> according to C99 6.2.4.3:
> "An object whose identifier is declared with external linkage
> [...] has static storage duration."
> 
> C99 defines in 6.7.8.10 that: "
> If an object that has static storage duration is not
> initialized explicitly, then:
> - if it has pointer type, it is initialized to a null pointer
> [...]
> "
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/070e004912fed099263408bf2ff1bb

cheers
