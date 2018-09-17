Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Dhgx0YRkzDsRY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 09:11:09 +1000 (AEST)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 084/158] perf tools: Allow overriding MAX_NR_CPUS at
 compile time
Date: Tue, 18 Sep 2018 00:41:54 +0200
Message-Id: <20180917211715.095678338@linuxfoundation.org>
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit 21b8732eb4479b579bda9ee38e62b2c312c2a0e5 ]

After update of kernel, the perf tool doesn't run anymore on my 32MB RAM
powerpc board, but still runs on a 128MB RAM board:

  ~# strace perf
  execve("/usr/sbin/perf", ["perf"], [/* 12 vars */]) = -1 ENOMEM (Cannot allocate memory)
  --- SIGSEGV {si_signo=SIGSEGV, si_code=SI_KERNEL, si_addr=0} ---
  +++ killed by SIGSEGV +++
  Segmentation fault

objdump -x shows that .bss section has a huge size of 24Mbytes:

 27 .bss          016baca8  101cebb8  101cebb8  001cd988  2**3

With especially the following objects having quite big size:

  10205f80 l     O .bss	00140000     runtime_cycles_stats
  10345f80 l     O .bss	00140000     runtime_stalled_cycles_front_stats
  10485f80 l     O .bss	00140000     runtime_stalled_cycles_back_stats
  105c5f80 l     O .bss	00140000     runtime_branches_stats
  10705f80 l     O .bss	00140000     runtime_cacherefs_stats
  10845f80 l     O .bss	00140000     runtime_l1_dcache_stats
  10985f80 l     O .bss	00140000     runtime_l1_icache_stats
  10ac5f80 l     O .bss	00140000     runtime_ll_cache_stats
  10c05f80 l     O .bss	00140000     runtime_itlb_cache_stats
  10d45f80 l     O .bss	00140000     runtime_dtlb_cache_stats
  10e85f80 l     O .bss	00140000     runtime_cycles_in_tx_stats
  10fc5f80 l     O .bss	00140000     runtime_transaction_stats
  11105f80 l     O .bss	00140000     runtime_elision_stats
  11245f80 l     O .bss	00140000     runtime_topdown_total_slots
  11385f80 l     O .bss	00140000     runtime_topdown_slots_retired
  114c5f80 l     O .bss	00140000     runtime_topdown_slots_issued
  11605f80 l     O .bss	00140000     runtime_topdown_fetch_bubbles
  11745f80 l     O .bss	00140000     runtime_topdown_recovery_bubbles

This is due to commit 4d255766d28b1 ("perf: Bump max number of cpus
to 1024"), because many tables are sized with MAX_NR_CPUS

This patch gives the opportunity to redefine MAX_NR_CPUS via

  $ make EXTRA_CFLAGS=-DMAX_NR_CPUS=1

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/20170922112043.8349468C57@po15668-vm-win7.idsi0.si.c-s.fr
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/perf.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -25,7 +25,9 @@ static inline unsigned long long rdclock
 	return ts.tv_sec * 1000000000ULL + ts.tv_nsec;
 }
 
+#ifndef MAX_NR_CPUS
 #define MAX_NR_CPUS			1024
+#endif
 
 extern const char *input_name;
 extern bool perf_host, perf_guest;
