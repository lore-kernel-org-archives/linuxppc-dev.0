Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMnJD34J1zDrgS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 07:01:15 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SKwtlo125426
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:01:12 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0b-001b2d01.pphosted.com with ESMTP id 253r8rpvsn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:01:12 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 02:31:08 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 75E39E0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:30:06 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SL15l919529798
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:05 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SL14q2004394
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:05 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 00/13] Add support for perf_arch_regs
Date: Mon, 29 Aug 2016 02:30:45 +0530
Message-Id: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patchset to extend PERF_SAMPLE_REGS_INTR to include
platform specific PMU registers.

Patchset applies cleanly on tip:perf/core branch

It's a perennial request from hardware folks to be able to
see the raw values of the pmu registers. Partly it's so that
they can verify perf is doing what they want, and some
of it is that they're interested in some of the more obscure
info that isn't plumbed out through other perf interfaces.

Over the years internally we have used various hack to get
the requested data out but this is an attempt to use a
somewhat standard mechanism (using PERF_SAMPLE_REGS_INTR).

This would also be helpful for those of us working on the perf
hardware backends, to be able to verify that we're programming
things correctly, without resorting to debug printks etc.

Mechanism proposed:

1)perf_regs structure is extended with a perf_arch_regs structure
which each arch/ can populate with their specific platform
registers to sample on each perf interrupt and an arch_regs_mask
variable, which is for perf tool to know about the perf_arch_regs
that are supported.

2)perf/core func perf_sample_regs_intr() extended to update
the perf_arch_regs structure and the perf_arch_reg_mask. Set of new
support functions added perf_get_arch_regs_mask() and
perf_get_arch_reg() to aid the updates from arch/ side.

3) perf/core funcs perf_prepare_sample() and perf_output_sample()
are extended to support the update for the perf_arch_regs_mask and
perf_arch_regs in the sample

4)perf/core func perf_output_sample_regs() extended to dump
the arch_regs to the output sample.

5)Finally, perf tool side is updated to include a new element
"arch_regs_mask" in the "struct regs_dump", event sample funcs
and print functions are updated to support perf_arch_regs.

example usage:

$./perf record -I ls
.....
builtin-data.o           builtin-list.o    builtin-stat.c    Documentation        perf.h
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.009 MB perf.data (12 samples) ]
$./perf script -D
....
0x980 [0x200]: event: 9
.
. ... raw event: size 512 bytes
.  0000:  00 00 00 09 00 01 02 00 00 00 00 00 00 08 fb 4c  ...............L
.  0010:  00 00 16 cb 00 00 16 cb 00 00 01 1d ca 45 9f 52  .............E.R
.  0020:  00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 02  ................
.......
.... dsisr 0x60000000
.... arch_regs 0x7e7f
.... pvr   0x4a0201
.... pmc1  0x7fffffff
.... pmc2  0x0
.... pmc3  0x0
.... pmc4  0x0
.... pmc5  0xa03
.... pmc6  0x38df
.... mmcr0 0x82008080
.... mmcr1 0x1e000000
.... sier  0x1e000000
.... siar  0x8fb4c
.... sdar  0xc00000241b195100
.... mmcra 0x60000000
 ... thread: perf:5835
 ...... dso: <not found>
            perf  5835  1227.459239:          1 cycles:ppp:             8fb4c [unknown] ([unknown])


Option to get only perf_arch_regs values:

$ ./perf record -I?
available registers: r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 r13 r14 r15 r16 r17 r18 r19 r20 r21 r22 r23 r24 r25 r26 r27 r28 r29 r30 r31 nip msr orig_r3 ctr link xer ccr softe trap dar dsisr arch_regs

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -I, --intr-regs[=<any register>]
                          sample selected machine registers on interrupt, use -I ? to list register names

$./perf record -Iarch_regs ls
.....
$./perf script -D
.....
104621404208 0xa28 [0xa8]: PERF_RECORD_SAMPLE(IP, 0x1): 5823/5823: 0xc00000000008fb4c period: 1 addr: 0
... intr regs: mask 0x80000000000 ABI 64-bit
.... arch_regs 0x7e7f
.... pvr   0x4a0201
.... pmc1  0x7fffffff
.... pmc2  0x0
.... pmc3  0x0
.... pmc4  0x0
.... pmc5  0x39551
.... pmc6  0xe6d99
.... mmcr0 0x82008080
.... mmcr1 0x1e000000
.... sier  0x1e000000
.... siar  0xc00000000008fb4c
.... sdar  0xc00000235f592500
.... mmcra 0x60000000
 ... thread: perf:5823
 ...... dso: /boot/vmlinux
            perf  5823   104.621404:          1 cycles:ppp:  c00000000008fb4c .power_check_constraints (/boot/vmlinux)
....

RFC:

https://lkml.org/lkml/2015/11/4/530
https://lkml.org/lkml/2015/11/4/531
https://lkml.org/lkml/2015/11/4/532
https://lkml.org/lkml/2015/11/4/533

Patch 11 in this patchset is a fix which is already posted, but not yet
to be pulled in. So I have added that to this patchset.

https://patchwork.kernel.org/patch/9285421/

Kindly let me know you comments and feedbacks.
Madhavan Srinivasan (13):
  perf/core: Add perf_arch_regs and mask to perf_regs structure
  perf/core: Extend perf_sample_regs_intr() to include perf_arch_regs
    update
  perf/core: Update perf_*_sample() to include perf_arch_regs
  perf/core: Extend perf_output_sample_regs() to include perf_arch_regs
  powerpc/perf: Define enums for perf_arch_regs registers
  powerpc/perf: Add support for perf_arch_regs in powerpc
  powerpc/perf: Add support for perf_arch_regs for Power7 processor
  powerpc/perf: Add support for perf_arch_regs for newer Power processor
  powerpc/perf: Add support for perf_arch_regs for PPC970 processor
  tool/perf: Add support for perf_arch_regs
  tools/perf: Fix the mask in regs_dump__printf and print_sample_iregs
  tool/perf: Add perf_arch_reg mask and arch_reg_names structure
  powerpc/perf: Add support to dump only arch_regs

 arch/powerpc/include/asm/perf_event_server.h    | 11 +++++
 arch/powerpc/include/uapi/asm/perf_regs.h       | 39 ++++++++++++++++++
 arch/powerpc/perf/core-book3s.c                 | 38 ++++++++++++++++++
 arch/powerpc/perf/isa207-common.c               | 18 +++++++++
 arch/powerpc/perf/isa207-common.h               | 10 +++++
 arch/powerpc/perf/perf_regs.c                   |  3 ++
 arch/powerpc/perf/power7-pmu.c                  | 28 +++++++++++++
 arch/powerpc/perf/power8-pmu.c                  |  2 +
 arch/powerpc/perf/power9-pmu.c                  |  2 +
 arch/powerpc/perf/ppc970-pmu.c                  | 23 +++++++++++
 include/linux/perf_regs.h                       | 26 ++++++++++++
 kernel/events/core.c                            | 53 +++++++++++++++++++++----
 tools/arch/powerpc/include/uapi/asm/perf_regs.h | 40 +++++++++++++++++++
 tools/include/linux/bitmap.h                    |  2 +
 tools/lib/bitmap.c                              | 18 +++++++++
 tools/perf/arch/arm/include/perf_regs.h         |  5 +++
 tools/perf/arch/arm64/include/perf_regs.h       |  5 +++
 tools/perf/arch/powerpc/include/perf_regs.h     | 28 ++++++++++++-
 tools/perf/arch/powerpc/util/perf_regs.c        |  1 +
 tools/perf/arch/x86/include/perf_regs.h         |  5 +++
 tools/perf/builtin-script.c                     | 11 ++++-
 tools/perf/util/event.h                         |  1 +
 tools/perf/util/evsel.c                         | 11 +++++
 tools/perf/util/perf_regs.h                     |  5 +++
 tools/perf/util/session.c                       | 16 ++++++--
 25 files changed, 388 insertions(+), 13 deletions(-)

--
2.7.4
