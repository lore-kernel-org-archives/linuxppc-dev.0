Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdSfS3QKzzDw4b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 05:19:44 +1100 (AEDT)
Message-Id: <cover.1481651875.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC 0/2] powerpc: Perf events on PPC 8xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Date: Tue, 13 Dec 2016 19:19:39 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set is a first try of implementing some additional
perf events on PPC 8xx.

The first patch of the serie fixes missing MSR RI setting at end of exceptions
The second patch implements the perf counters.

The 8xx has no PMU, however some events can be emulated by other means.

This patch implements the following 4 events:
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]
  dTLB-load-misses                                   [Hardware cache event]
  iTLB-load-misses                                   [Hardware cache event]

I have no real clue on how should work perf events, hence the RFC status of
this serie. I have tested it with 'perf stat' and it seems to provide
relevant information.

This serie applies of top of the two following patches:
* powerpc/32: Remove FIX_SRR1
* powerpc/8xx: Implement hw_breakpoint

Christophe Leroy (2):
  powerpc/32: Unset MSR RI in exception epilogs
  powerpc/8xx: Perf events on PPC 8xx

 arch/powerpc/include/asm/ppc_asm.h     |   6 ++
 arch/powerpc/include/asm/reg.h         |   2 +
 arch/powerpc/include/asm/reg_8xx.h     |   4 +
 arch/powerpc/kernel/entry_32.S         |   5 +
 arch/powerpc/kernel/head_8xx.S         |  45 +++++++-
 arch/powerpc/perf/8xx-pmu.c            | 181 +++++++++++++++++++++++++++++++++
 arch/powerpc/perf/Makefile             |   2 +
 arch/powerpc/platforms/Kconfig.cputype |   7 ++
 8 files changed, 249 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/perf/8xx-pmu.c

-- 
2.10.1
