Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptdB50fpzF0Rr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:10 +1000 (AEST)
In-Reply-To: <975595591e096f4ad3253b5a11713beaf62912c4.1533561636.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/cpm1: fix compilation error with
 CONFIG_PPC_EARLY_DEBUG_CPM
Message-Id: <41ptd913q3z9sCX@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-08-06 at 15:09:11 UTC, Christophe Leroy wrote:
> commit e8cb7a55eb8dc ("powerpc: remove superflous inclusions of
> asm/fixmap.h") removed inclusion of asm/fixmap.h from files not
> including objects from that file.
> 
> However, asm/mmu-8xx.h includes  call to __fix_to_virt(). The proper
> way would be to include asm/fixmap.h in asm/mmu-8xx.h but it creates
> an inclusion loop.
> 
> So we have to leave asm/fixmap.h in sysdep/cpm_common.c for
> CONFIG_PPC_EARLY_DEBUG_CPM
> 
>   CC      arch/powerpc/sysdev/cpm_common.o
> In file included from ./arch/powerpc/include/asm/mmu.h:340:0,
>                  from ./arch/powerpc/include/asm/reg_8xx.h:8,
>                  from ./arch/powerpc/include/asm/reg.h:29,
>                  from ./arch/powerpc/include/asm/processor.h:13,
>                  from ./arch/powerpc/include/asm/thread_info.h:28,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/powerpc/include/asm/ptrace.h:159,
>                  from ./arch/powerpc/include/asm/hw_irq.h:12,
>                  from ./arch/powerpc/include/asm/irqflags.h:12,
>                  from ./include/linux/irqflags.h:16,
>                  from ./include/asm-generic/cmpxchg-local.h:6,
>                  from ./arch/powerpc/include/asm/cmpxchg.h:537,
>                  from ./arch/powerpc/include/asm/atomic.h:11,
>                  from ./include/linux/atomic.h:5,
>                  from ./include/linux/mutex.h:18,
>                  from ./include/linux/kernfs.h:13,
>                  from ./include/linux/sysfs.h:16,
>                  from ./include/linux/kobject.h:20,
>                  from ./include/linux/device.h:16,
>                  from ./include/linux/node.h:18,
>                  from ./include/linux/cpu.h:17,
>                  from ./include/linux/of_device.h:5,
>                  from arch/powerpc/sysdev/cpm_common.c:21:
> arch/powerpc/sysdev/cpm_common.c: In function ‘udbg_init_cpm’:
> ./arch/powerpc/include/asm/mmu-8xx.h:218:25: error: implicit declaration of function ‘__fix_to_virt’ [-Werror=implicit-function-declaration]
>  #define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
>                          ^
> arch/powerpc/sysdev/cpm_common.c:75:7: note: in expansion of macro ‘VIRT_IMMR_BASE’
>        VIRT_IMMR_BASE);
>        ^
> ./arch/powerpc/include/asm/mmu-8xx.h:218:39: error: ‘FIX_IMMR_BASE’ undeclared (first use in this function)
>  #define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
>                                        ^
> arch/powerpc/sysdev/cpm_common.c:75:7: note: in expansion of macro ‘VIRT_IMMR_BASE’
>        VIRT_IMMR_BASE);
>        ^
> ./arch/powerpc/include/asm/mmu-8xx.h:218:39: note: each undeclared identifier is reported only once for each function it appears in
>  #define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
>                                        ^
> arch/powerpc/sysdev/cpm_common.c:75:7: note: in expansion of macro ‘VIRT_IMMR_BASE’
>        VIRT_IMMR_BASE);
>        ^
> cc1: all warnings being treated as errors
> make[1]: *** [arch/powerpc/sysdev/cpm_common.o] Error 1
> 
> Fixes: e8cb7a55eb8dc ("powerpc: remove superflous inclusions of asm/fixmap.h")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6bd6d8672208e8dc0c18588d6eb458

cheers
