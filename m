Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9PNX6n1hzDr0r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:00 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BNSgqP060566
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:28:59 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24r5ugxnvb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:28:58 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 12 Aug 2016 09:28:56 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E6D0F3578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:28:53 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BNSrXh28180480
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:28:53 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BNSrZO022946
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:28:53 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: anton@samba.org, mikey@neuling.org
Subject: [PATCH v2 00/20] Consistent TM structures
Date: Fri, 12 Aug 2016 09:27:59 +1000
Message-Id: <20160811232819.11453-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This series has grown considerably from v1.

Similarities with v1 include:
- Selftests are all the same, they have simply been split into several
  patches with comments from MPE and Daniel Axtens incorporated. It
  is possible some things slipped through the cracks selftest wise as
  the focus has been on the final three patches.
- The final three patches have been reworked following extra testing
  and from review by Simon Guo.

Differences include:
- Patches 2-5 are fixes for existing problems found in the course of
  verifying the final three patches. In the case of "powerpc: Never
  giveup a reclaimed thread when enabling kernel {fp, altivec, vsx}" it
  has proven difficult to narrow down when the bug was introduced. It
  does not exist in 3.8 when TM was introduced but does exist in 4.4. I
  was unable to boot 3.13 (or 3.12) in an attempt to further bisect.
- As ptrace code was merged between v1 and v2, work was needed there
  to make it fit in with the final three patches.

The overall aim of this series may have gotten lost here. The final
three patches are the goal here.

Cyril Bur (20):
  selftests/powerpc: Compile selftests against headers without AT_HWCAP2
  powerpc: Always restore FPU/VEC/VSX if hardware transactional memory
    in use
  powerpc: Add check_if_tm_restore_required() to giveup_all()
  powerpc: Return the new MSR from msr_check_and_set()
  powerpc: Never giveup a reclaimed thread when enabling kernel {fp,
    altivec, vsx}
  selftests/powerpc: Check for VSX preservation across userspace
    preemption
  selftests/powerpc: Rework FPU stack placement macros and move to
    header file
  selftests/powerpc: Move VMX stack frame macros to header file
  selftests/powerpc: Introduce GPR asm helper header file
  selftests/powerpc: Add transactional memory defines
  selftests/powerpc: Allow tests to extend their kill timeout
  selftests/powerpc: Add TM tcheck helpers in C
  selftests/powerpc: Check that signals always get delivered
  selftests/powerpc: Add checks for transactional GPRs in signal
    contexts
  selftests/powerpc: Add checks for transactional FPUs in signal
    contexts
  selftests/powerpc: Add checks for transactional VMXs in signal
    contexts
  selftests/powerpc: Add checks for transactional VSXs in signal
    contexts
  powerpc: tm: Always use fp_state and vr_state to store live registers
  powerpc: tm: Rename transct_(*) to ck(\1)_state
  powerpc: Remove do_load_up_transact_{fpu,altivec}

 arch/powerpc/include/asm/processor.h               |  15 +-
 arch/powerpc/include/asm/reg.h                     |   2 +-
 arch/powerpc/include/asm/tm.h                      |   5 -
 arch/powerpc/kernel/asm-offsets.c                  |  12 +-
 arch/powerpc/kernel/fpu.S                          |  26 --
 arch/powerpc/kernel/process.c                      | 119 +++++----
 arch/powerpc/kernel/ptrace.c                       | 278 +++++----------------
 arch/powerpc/kernel/signal.h                       |   8 +-
 arch/powerpc/kernel/signal_32.c                    |  84 +++----
 arch/powerpc/kernel/signal_64.c                    |  59 ++---
 arch/powerpc/kernel/tm.S                           |  94 +++----
 arch/powerpc/kernel/traps.c                        |  12 +-
 arch/powerpc/kernel/vector.S                       |  25 --
 tools/testing/selftests/powerpc/Makefile           |   1 +
 tools/testing/selftests/powerpc/basic_asm.h        |   4 +
 tools/testing/selftests/powerpc/fpu_asm.h          |  81 ++++++
 tools/testing/selftests/powerpc/gpr_asm.h          |  96 +++++++
 tools/testing/selftests/powerpc/harness.c          |   9 +-
 tools/testing/selftests/powerpc/math/Makefile      |   4 +-
 tools/testing/selftests/powerpc/math/fpu_asm.S     |  73 +-----
 tools/testing/selftests/powerpc/math/vmx_asm.S     |  85 +------
 tools/testing/selftests/powerpc/math/vsx_asm.S     |  61 +++++
 tools/testing/selftests/powerpc/math/vsx_preempt.c | 147 +++++++++++
 tools/testing/selftests/powerpc/signal/Makefile    |  12 +
 tools/testing/selftests/powerpc/signal/signal.S    |  50 ++++
 tools/testing/selftests/powerpc/signal/signal.c    | 111 ++++++++
 tools/testing/selftests/powerpc/signal/signal_tm.c | 110 ++++++++
 tools/testing/selftests/powerpc/tm/Makefile        |   8 +-
 .../powerpc/tm/tm-signal-context-chk-fpu.c         |  92 +++++++
 .../powerpc/tm/tm-signal-context-chk-gpr.c         |  90 +++++++
 .../powerpc/tm/tm-signal-context-chk-vmx.c         | 110 ++++++++
 .../powerpc/tm/tm-signal-context-chk-vsx.c         | 125 +++++++++
 tools/testing/selftests/powerpc/tm/tm-signal.S     | 114 +++++++++
 tools/testing/selftests/powerpc/tm/tm.h            |  27 ++
 tools/testing/selftests/powerpc/utils.h            |   9 +-
 tools/testing/selftests/powerpc/vmx_asm.h          |  98 ++++++++
 tools/testing/selftests/powerpc/vsx_asm.h          |  71 ++++++
 37 files changed, 1709 insertions(+), 618 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/fpu_asm.h
 create mode 100644 tools/testing/selftests/powerpc/gpr_asm.h
 create mode 100644 tools/testing/selftests/powerpc/math/vsx_asm.S
 create mode 100644 tools/testing/selftests/powerpc/math/vsx_preempt.c
 create mode 100644 tools/testing/selftests/powerpc/signal/Makefile
 create mode 100644 tools/testing/selftests/powerpc/signal/signal.S
 create mode 100644 tools/testing/selftests/powerpc/signal/signal.c
 create mode 100644 tools/testing/selftests/powerpc/signal/signal_tm.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-fpu.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-gpr.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vmx.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-context-chk-vsx.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal.S
 create mode 100644 tools/testing/selftests/powerpc/vmx_asm.h
 create mode 100644 tools/testing/selftests/powerpc/vsx_asm.h

-- 
2.9.2
