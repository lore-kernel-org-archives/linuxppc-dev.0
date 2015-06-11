Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 240CC1A09BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 18:43:57 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 14:13:55 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C1204394005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:13:51 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B8hkre49021094
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:13:47 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B8hiDN015083
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:13:45 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 khandual@linux.vnet.ibm.com, rusty@rustcorp.com.au,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 0/8]powerpc/perf: Export memory hierarchy level
Date: Thu, 11 Jun 2015 14:13:29 +0530
Message-Id: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power8 Perforence Monitoring Unit (PMU) supports different
sampling modes (SM) Random Instruction Sampling (RIS),
Random Load/Store Facility Sampling (RLS) and Random Branch
Sampling (RBS). This patchset enabled RLS mode to mark
Load/Store instructions to save the memory hierarchy level
(eg: L2, L3) for cache reload. Event used here to sample
is "marked instruction complete".

This patchset exports the hierarchy information to the user via the
perf_mem_data_src object. Patchset is based on and derived from
Sukadev Bhattiprolu work[1]. It exports the memory hierarchy
information only to Power8 processor based system, since
similiar event or modes are not supported in Power7

[1]:https://lkml.org/lkml/2013/10/15/858

perf interface sample. Workload used here is "ebizzy"

# perf report -n --mem-mode --sort=mem,sym,dso,symbol_daddr --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
# Samples: 33  of event 'cpu/mem_access/'
# Total weight : 33
# Sort order   : mem,sym,dso,symbol_daddr
#
# Overhead       Samples             Memory access                              Symbol      Shared Object                                Data Symbol
# ........  ............  ........................  ..................................  .................  .........................................
#
    12.12%             4  L2 hit                    [k] __do_softirq                    [kernel.kallsyms]  [k] softirq_vec+0x8
     6.06%             2  L2 hit                    [k] __schedule                      [kernel.kallsyms]  [k] 0xc0000003bb975df0
     6.06%             2  Remote Cache (1 hop) hit  [k] scheduler_tick                  [kernel.kallsyms]  [k] 0xc0000003feb1e4b0
     3.03%             1  L2 hit                    [k] __acct_update_integrals         [kernel.kallsyms]  [k] 0xc0000003b79d8a30
     3.03%             1  L2 hit                    [.] __memcpy_power7                 libc-2.17.so       [.] 0x0000010021349b00
     3.03%             1  L2 hit                    [.] __memcpy_power7                 libc-2.17.so       [.] 0x000001002134a030
     3.03%             1  L2 hit                    [k] __mmdrop                        [kernel.kallsyms]  [k] pgtable_cache+0x58
     3.03%             1  L2 hit                    [k] __update_cpu_load               [kernel.kallsyms]  [k] 0xc0000003feb1dc60
     3.03%             1  L2 hit                    [.] _int_malloc                     libc-2.17.so       [.] 0x00003fff90000090
     3.03%             1  L2 hit                    [k] account_system_time             [kernel.kallsyms]  [k] 0xc0000003feb08088
.....

Madhavan Srinivasan (8):
 powerpc/perf: Remove PME_ prefix for power7 events
 powerpc/perf: Export Power8 generic events in sysfs
 powerpc/perf: EVENT macro for exporting generic events
 powerpc/perf: Add Power8 mem_access event to sysfs
 powerpc/perf: Define big-endian version of perf_mem_data_src
 powerpc/perf: Export Power8 memory hierarchy info to user space
 powerpc/perf: Set data source value
 powerpc/perf: cleanup in perf_event_print_debug()

 arch/powerpc/include/asm/perf_event_server.h |  4 +-
 arch/powerpc/perf/core-book3s.c              | 17 ++++-
 arch/powerpc/perf/power7-pmu.c               | 18 ++---
 arch/powerpc/perf/power8-events-list.h       | 21 ++++++
 arch/powerpc/perf/power8-pmu.c               | 98 ++++++++++++++++++++++++++--
 include/uapi/linux/perf_event.h              | 16 +++++
 6 files changed, 155 insertions(+), 19 deletions(-)
 create mode 100644 arch/powerpc/perf/power8-events-list.h

-- 
1.9.1
