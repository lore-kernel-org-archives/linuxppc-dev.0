Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411Sx86GsMzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 11:43:23 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y5-v6so3125143pfn.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jun 2018 18:43:23 -0700 (PDT)
Date: Thu, 7 Jun 2018 11:43:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic
 Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] powerpc/time: Only set
 CONFIG_ARCH_HAS_SCALED_CPUTIME on PPC64
Message-ID: <20180607114304.327c4ab5@roar.ozlabs.ibm.com>
In-Reply-To: <d9ac8da98f53debb4758b98d0227979aca9196f7.1528292284.git.christophe.leroy@c-s.fr>
References: <d9ac8da98f53debb4758b98d0227979aca9196f7.1528292284.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  6 Jun 2018 14:21:08 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> scaled cputime is only meaningfull when the processor has
> SPURR and/or PURR, which means only on PPC64.
> 
> Removing it on PPC32 significantly reduces the size of
> vtime_account_system() and vtime_account_idle() on an 8xx:
> 
> Before:
> 00000000 l     F .text	000000a8 vtime_delta
> 00000280 g     F .text	0000010c vtime_account_system
> 0000038c g     F .text	00000048 vtime_account_idle
> 
> After:
> (vtime_delta gets inlined in the two functions)
> 000001d8 g     F .text	000000a0 vtime_account_system
> 00000278 g     F .text	00000038 vtime_account_idle
> 
> In terms of performance, we also get approximatly 5% improvement on task switch:
> The following small benchmark app is run with perf stat:
> 
> void *thread(void *arg)
> {
> 	int i;
> 
> 	for (i = 0; i < atoi((char*)arg); i++)
> 		pthread_yield();
> }
> 
> int main(int argc, char **argv)
> {
> 	pthread_t th1, th2;
> 
> 	pthread_create(&th1, NULL, thread, argv[1]);
> 	pthread_create(&th2, NULL, thread, argv[1]);
> 	pthread_join(th1, NULL);
> 	pthread_join(th2, NULL);
> 
> 	return 0;
> }
> 
> Before the patch:
> 
> ~# perf stat chrt -f 98 ./sched 100000
> 
>  Performance counter stats for 'chrt -f 98 ./sched 100000':
> 
>        8622.166272      task-clock (msec)         #    0.955 CPUs utilized
>             200027      context-switches          #    0.023 M/sec
> 
> After the patch:
> 
> ~# perf stat chrt -f 98 ./sched 100000
> 
>  Performance counter stats for 'chrt -f 98 ./sched 100000':
> 
>        8207.090048      task-clock (msec)         #    0.958 CPUs utilized
>             200025      context-switches          #    0.024 M/sec
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

This looks okay to me. Nice numbers.

> ---
>  v4:
>   - Using the correct symbol CONFIG_ARCH_HAS_SCALED_CPUTIME instead of ARCH_HAS_SCALED_CPUTIME
>   - Grouped CONFIG_ARCH_HAS_SCALED_CPUTIME related code in dedicated functions to reduce the number of #ifdefs
>   - Integrated read_spurr() directly into the related function.
>  v3: Rebased following modifications in xmon.c
>  v2: added ifdefs in xmon to fix compilation error
> 
>  arch/powerpc/Kconfig                  |   2 +-
>  arch/powerpc/include/asm/accounting.h |   4 ++
>  arch/powerpc/include/asm/cputime.h    |   1 -
>  arch/powerpc/kernel/time.c            | 111 +++++++++++++++++++++-------------
>  arch/powerpc/xmon/xmon.c              |   4 ++
>  5 files changed, 77 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index b62a16e2c7cc..735398fd390d 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -142,7 +142,7 @@ config PPC
>  	select ARCH_HAS_PHYS_TO_DMA
>  	select ARCH_HAS_PMEM_API                if PPC64
>  	select ARCH_HAS_MEMBARRIER_CALLBACKS
> -	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
> +	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC64

I wonder if we could make this depend on PPC_PSERIES or even
PPC_SPLPAR as well? (That would be for a later patch)

Thanks,
Nick
