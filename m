Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3Sf0nqYzF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:21:06 +1000 (AEST)
In-Reply-To: <20180914040649.1794-5-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Anton Blanchard <anton@samba.org>
Subject: Re: [v2,
 4/5] powerpc: Fix duplicate const clang warning in user access code
Message-Id: <42G3Sc6QDNz9sD4@ozlabs.org>
Date: Thu, 20 Sep 2018 14:21:04 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-09-14 at 04:06:48 UTC, Joel Stanley wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> This re-applies b91c1e3e7a6f which was reverted in f2ca80905929
> d466f6c5cac1 f84ed59a612d (powerpc/sparse: Constify the address pointer
> ...").
> 
> We see a large number of duplicate const errors in the user access
> code when building with llvm/clang:
> 
>   include/linux/pagemap.h:576:8: warning: duplicate 'const' declaration specifier
>       [-Wduplicate-decl-specifier]
>         ret = __get_user(c, uaddr);
> 
> The problem is we are doing const __typeof__(*(ptr)), which will hit the
> warning if ptr is marked const.
> 
> Removing const does not seem to have any effect on GCC code generation.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e00d93ac9a189673028ac125a74b9b

cheers
