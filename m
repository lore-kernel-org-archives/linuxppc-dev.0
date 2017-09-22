Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzFjD1wf1zDsNh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Sep 2017 00:09:36 +1000 (AEST)
Date: Fri, 22 Sep 2017 11:09:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf tools: allow overriding MAX_NR_CPUS at compile time
Message-ID: <20170922140906.GE29668@kernel.org>
References: <20170922112043.8349468C57@po15668-vm-win7.idsi0.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170922112043.8349468C57@po15668-vm-win7.idsi0.si.c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Fri, Sep 22, 2017 at 01:20:43PM +0200, Christophe Leroy escreveu:
> After update of kernel, perf tool doesn't run anymore on my
> 32MB RAM powerpc board, but still runs on a 128MB RAM board:
> 
> ~# strace perf
> execve("/usr/sbin/perf", ["perf"], [/* 12 vars */]) = -1 ENOMEM (Cannot allocate memory)
> --- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL, si_addr=0} ---
> +++ killed by SIGSEGV +++
> Segmentation fault
> 
> objdump -x shows that .bss section has a huge size of 24Mbytes:
> 
>  27 .bss          016baca8  101cebb8  101cebb8  001cd988  2**3
> 
> With especially the following objects having quite big size
> 
> 10205f80 l     O .bss	00140000              runtime_cycles_stats
> 10345f80 l     O .bss	00140000              runtime_stalled_cycles_front_stats
> 10485f80 l     O .bss	00140000              runtime_stalled_cycles_back_stats
> 105c5f80 l     O .bss	00140000              runtime_branches_stats
> 10705f80 l     O .bss	00140000              runtime_cacherefs_stats
> 10845f80 l     O .bss	00140000              runtime_l1_dcache_stats
> 10985f80 l     O .bss	00140000              runtime_l1_icache_stats
> 10ac5f80 l     O .bss	00140000              runtime_ll_cache_stats
> 10c05f80 l     O .bss	00140000              runtime_itlb_cache_stats
> 10d45f80 l     O .bss	00140000              runtime_dtlb_cache_stats
> 10e85f80 l     O .bss	00140000              runtime_cycles_in_tx_stats
> 10fc5f80 l     O .bss	00140000              runtime_transaction_stats
> 11105f80 l     O .bss	00140000              runtime_elision_stats
> 11245f80 l     O .bss	00140000              runtime_topdown_total_slots
> 11385f80 l     O .bss	00140000              runtime_topdown_slots_retired
> 114c5f80 l     O .bss	00140000              runtime_topdown_slots_issued
> 11605f80 l     O .bss	00140000              runtime_topdown_fetch_bubbles
> 11745f80 l     O .bss	00140000              runtime_topdown_recovery_bubbles
> 
> This is due to commit 4d255766d28b1 ("perf: Bump max number of cpus
> to 1024"), because many tables are sized with MAX_NR_CPUS
> 
> This patch gives the opportunity to redefine MAX_NR_CPUS via
> 
> make EXTRA_CFLAGS=-DMAX_NR_CPUS=1

I'll probably apply this, but the right thing would be to get rid of
MAX_NR_CPUS completely and instead allocate that using sysconf:

[root@jouet ~]# perf trace -e open,getdents getconf _NPROCESSORS_CONF
4
     0.014 ( 0.011 ms): getconf/2452 open(filename: /etc/ld.so.cache, flags: CLOEXEC                       ) = 3
     0.045 ( 0.008 ms): getconf/2452 open(filename: /lib64/libc.so.6, flags: CLOEXEC                       ) = 3
     0.264 ( 0.012 ms): getconf/2452 open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC         ) = 3
     0.315 ( 0.028 ms): getconf/2452 open(filename: /sys/devices/system/cpu, flags: CLOEXEC|DIRECTORY|NONBLOCK) = 3
     0.349 ( 0.013 ms): getconf/2452 getdents(fd: 3</sys/devices/system/cpu>, dirent: 0x944030, count: 32768) = 624
     0.365 ( 0.001 ms): getconf/2452 getdents(fd: 3</sys/devices/system/cpu>, dirent: 0x944030, count: 32768) = 0
[root@jouet ~]#
 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  tools/perf/perf.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index dc442ba21bf6..a9db563da0a9 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -23,7 +23,9 @@ static inline unsigned long long rdclock(void)
>  	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
>  }
>  
> +#ifndef MAX_NR_CPUS
>  #define MAX_NR_CPUS			1024
> +#endif
>  
>  extern const char *input_name;
>  extern bool perf_host, perf_guest;
> -- 
> 2.13.3
