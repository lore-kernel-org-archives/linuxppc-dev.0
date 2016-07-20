Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvWMw09dMzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 19:10:20 +1000 (AEST)
In-Reply-To: <1468372480-6453-2-git-send-email-haokexin@gmail.com>
To: Kevin Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>
Subject: Re: [v2,
 1/3] powerpc32: booke: fix the build error when CRASH_DUMP is enabled
Message-Id: <3rvWMv6fJzz9t0v@ozlabs.org>
Date: Wed, 20 Jul 2016 19:10:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-13-07 at 01:14:38 UTC, Kevin Hao wrote:
> In the current code, the RELOCATABLE will be forcedly enabled when
> enabling CRASH_DUMP. But for ppc32, the RELOCABLE also depend on
> ADVANCED_OPTIONS and select NONSTATIC_KERNEL. This will cause the
> following build error when CRASH_DUMP=y && ADVANCED_OPTIONS=n
> because the select of NONSTATIC_KERNEL doesn't take effect.
>   arch/powerpc/include/asm/io.h: In function 'virt_to_phys':
>   arch/powerpc/include/asm/page.h:113:26: error: 'virt_phys_offset' undeclared (first use in this function)
>    #define VIRT_PHYS_OFFSET virt_phys_offset
>                           ^
> It doesn't have any strong reasons to make the RELOCATABLE depend on
> ADVANCED_OPTIONS. So remove this dependency to fix this issue.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/da4230714662278781d007fb2b

cheers
