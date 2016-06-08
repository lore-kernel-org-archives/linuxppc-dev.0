Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPZXD1dB7zDr1B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 14:02:36 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rPZXC3VTCz9t0r
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2016 14:02:35 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u583whv5139953
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 00:02:33 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9m3hbg2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 08 Jun 2016 00:02:33 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 8 Jun 2016 14:02:31 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8F0BA3578058
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jun 2016 14:02:08 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5841rG18126892
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 14:01:54 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5841bve030579
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jun 2016 14:01:37 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH 0/5] Consistent TM structures
Date: Wed,  8 Jun 2016 14:00:31 +1000
Message-Id: <20160608040036.13064-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The reason for this series is outlined in 3/5. I'll reexplain here
quickly.

If userspace doesn't use TM at all then pt_regs, fp_state and vr_state
hold (almost) all the register state of the CPU.

If userspace uses TM then pt_regs is ALWAYS the live state. This may
be a transactional speculative state or if the thread is between
transactions it is just the regular live state. The checkpointed state
(if needed) always exists in ckpt_regs.
This is not true of fp_state and vr_state which MAY hold a live state
when the thread has not entered a transaction but will then contain
checkpointed values once a thread enters a transaction.
transact_fp and transact_vr are used only when a thread is in a
transaction (active or suspended) to keep the live (but speculative)
state.

Here I aim to remove this disconnect and have everything behave like
pt_regs.

For ease of review I've left patches 3, 4 and 5 separate. It probably
makes sense for them to be squashed into one, the naming inconsistency
between 3 and 4 can't be a good idea.

A few apologies for this series:
 - I had to write tests to have an idea what I've done is correct,
they're still a bit rough around the edges.
 - In the process I made more the asm helpers shared as the powerpc/math
selftests had quite a few things I found useful.
 - This pretty much means the 2/5 monster should be a few patches. I'll
split them up.

I didn't want this series held up from initial review while I cleaned
up tests.

Thanks,

Cyril

Cyril Bur (5):
  selftests/powerpc: Check for VSX preservation across userspace
    preemption
  selftests/powerpc: Add test to check TM ucontext creation
  powerpc: tm: Always use fp_state and vr_state to store live registers
  powerpc: tm: Rename transct_(*) to ck(\1)_state
  powerpc: Remove do_load_up_transact_{fpu,altivec}

 arch/powerpc/include/asm/processor.h               |  20 +--
 arch/powerpc/include/asm/tm.h                      |   5 -
 arch/powerpc/kernel/asm-offsets.c                  |  12 +-
 arch/powerpc/kernel/fpu.S                          |  26 ----
 arch/powerpc/kernel/process.c                      |  48 ++-----
 arch/powerpc/kernel/signal.h                       |   8 +-
 arch/powerpc/kernel/signal_32.c                    |  84 ++++++-------
 arch/powerpc/kernel/signal_64.c                    |  59 ++++-----
 arch/powerpc/kernel/tm.S                           |  95 +++++++-------
 arch/powerpc/kernel/traps.c                        |  12 +-
 arch/powerpc/kernel/vector.S                       |  25 ----
 tools/testing/selftests/powerpc/basic_asm.h        |   4 +
 tools/testing/selftests/powerpc/fpu_asm.h          |  72 +++++++++++
 tools/testing/selftests/powerpc/gpr_asm.h          |  96 ++++++++++++++
 tools/testing/selftests/powerpc/math/Makefile      |   4 +-
 tools/testing/selftests/powerpc/math/fpu_asm.S     |  73 +----------
 tools/testing/selftests/powerpc/math/vmx_asm.S     |  85 +------------
 tools/testing/selftests/powerpc/math/vsx_asm.S     |  57 +++++++++
 tools/testing/selftests/powerpc/math/vsx_preempt.c | 140 +++++++++++++++++++++
 tools/testing/selftests/powerpc/tm/Makefile        |   9 +-
 .../powerpc/tm/tm-signal-context-chk-fpu.c         |  94 ++++++++++++++
 .../powerpc/tm/tm-signal-context-chk-gpr.c         |  96 ++++++++++++++
 .../powerpc/tm/tm-signal-context-chk-vmx.c         | 112 +++++++++++++++++
 .../powerpc/tm/tm-signal-context-chk-vsx.c         | 127 +++++++++++++++++++
 .../selftests/powerpc/tm/tm-signal-context-chk.c   | 102 +++++++++++++++
 tools/testing/selftests/powerpc/tm/tm-signal.S     | 105 ++++++++++++++++
 tools/testing/selftests/powerpc/vmx_asm.h          |  98 +++++++++++++++
 tools/testing/selftests/powerpc/vsx_asm.h          |  71 +++++++++++
 28 files changed, 1343 insertions(+), 396 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/fpu_asm.h
 create mode 100644 tools/testing/selftests/powerpc/gpr_asm.h
 create mode 100644 tools/testing/selftests/powerpc/math/vsx_asm.S
 create mode 100644 tools/testing/selftests/powerpc/math/vsx_preempt.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vmx.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal.S
 create mode 100644 tools/testing/selftests/powerpc/vmx_asm.h
 create mode 100644 tools/testing/selftests/powerpc/vsx_asm.h

-- 
2.8.3
