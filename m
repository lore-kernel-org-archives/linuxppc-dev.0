Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D565F1A0BC6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 07:46:35 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 5 Nov 2015 02:16:32 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7BB01E005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 02:16:45 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4KkRtJ42926084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 02:16:28 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4KkPmB027516
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 02:16:27 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [RFC PATCH  0/3]perf/core: extend perf_reg and perf_sample_regs_intr
Date: Thu,  5 Nov 2015 02:16:15 +0530
Message-Id: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset extend the perf sample regs infrastructure
to include architecture specific regs. Current perf_sample_regs_intr
exports only registers in the pt_regs to perf.data using
PERF_SAMPLE_REGS_INTR sample type. But sometimes we end up looking
for or prefer raw register values at the interrupt during debug.

This patchset extends the perf_regs to include arch specific struct,
and makes perf_sample_regs_intr in kernel/event/core.c as __weak__
function. This way, an arch specific implementation of
perf_sample_regs_intr() can update the arch specific data to
the perf_regs.

First patch defines a new structure arch_misc_reg and updates the same
in the struct perf_regs. Patch also modifies the perf_reg_value()
and perf_output_sample_regs() to take perf_regs parameter instead of pt_regs.

Second patch updates struct arch_misc_reg for arch/powerpc with pmu registers
and adds offsetof macro for the same. It extends perf_reg_value()
to use reg idx to decide on struct to return value from.

Third patch adds arch specific perf_sample_regs_intr() in arch/powerpc
to hook up the arch_misc_regs to perf_regs.

This patchset depends on the recent posting by Anju T in
linuxppc-dev@lists.ozlabs.org to enable PERF_SAMPLE_REGS_INTR
support in arch/powerpc.

https://patchwork.ozlabs.org/patch/539242/
https://patchwork.ozlabs.org/patch/539243/
https://patchwork.ozlabs.org/patch/539244/

Would appreciate comments and feedback.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephane Eranian <eranian@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Madhavan Srinivasan (3):
  perf/core: extend perf_regs to include arch specific regs
  perf/powerpc: update macros and add regs to arch_misc_reg struct
  perf/powerpc: Functions to update arch_misc_regs

 arch/arm/include/asm/ptrace.h               |  2 ++
 arch/arm/kernel/perf_regs.c                 |  4 +++-
 arch/arm64/include/asm/ptrace.h             |  2 ++
 arch/arm64/kernel/perf_regs.c               |  4 +++-
 arch/powerpc/include/uapi/asm/perf_regs.h   | 10 ++++++++++
 arch/powerpc/include/uapi/asm/ptrace.h      | 11 +++++++++++
 arch/powerpc/perf/core-book3s.c             | 29 +++++++++++++++++++++++++++++
 arch/powerpc/perf/perf_regs.c               | 28 ++++++++++++++++++++++++++--
 arch/x86/include/asm/ptrace.h               |  2 ++
 arch/x86/kernel/perf_regs.c                 |  4 +++-
 include/linux/perf_regs.h                   |  5 +++--
 kernel/events/core.c                        |  8 ++++----
 tools/perf/arch/powerpc/include/perf_regs.h | 16 ++++++++++++++++
 13 files changed, 114 insertions(+), 11 deletions(-)

--
1.9.1
