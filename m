Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E9083B71C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 11:01:07 +1000 (EST)
Subject: Re: linux-next: origin tree build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20090612102427.32582baa.sfr@canb.auug.org.au>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 11:00:06 +1000
Message-Id: <1244768406.7172.1.camel@pasglop>
Mime-Version: 1.0
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	paulus@samba.org, Ingo Molnar <mingo@elte.hu>,
	Linus <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-12 at 10:24 +1000, Stephen Rothwell wrote:

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 12 Jun 2009 10:14:22 +1000
> Subject: [PATCH] perfcounters: remove powerpc definitions of perf_counter_do_pending
> 
> Commit 925d519ab82b6dd7aca9420d809ee83819c08db2 ("perf_counter:
> unify and fix delayed counter wakeup") added global definitions.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Linus, please apply. BTW, This is _EXACTLY_ why this should have been in
-next for a few days before being merged :-(

Cheers,
Ben.

> ---
>  arch/powerpc/include/asm/hw_irq.h |    3 ---
>  arch/powerpc/kernel/irq.c         |    1 +
>  2 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index 20a44d0..5351237 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -156,8 +156,6 @@ static inline void clear_perf_counter_pending(void)
>  		"i" (offsetof(struct paca_struct, perf_counter_pending)));
>  }
>  
> -extern void perf_counter_do_pending(void);
> -
>  #else
>  
>  static inline unsigned long test_perf_counter_pending(void)
> @@ -167,7 +165,6 @@ static inline unsigned long test_perf_counter_pending(void)
>  
>  static inline void set_perf_counter_pending(void) {}
>  static inline void clear_perf_counter_pending(void) {}
> -static inline void perf_counter_do_pending(void) {}
>  #endif /* CONFIG_PERF_COUNTERS */
>  
>  #endif	/* __KERNEL__ */
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index feff792..844d3f8 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -53,6 +53,7 @@
>  #include <linux/bootmem.h>
>  #include <linux/pci.h>
>  #include <linux/debugfs.h>
> +#include <linux/perf_counter.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/system.h>
