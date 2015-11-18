Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C39191A0374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 14:28:41 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DFA6B141466
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:38 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 18 Nov 2015 13:28:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3ABB13578054
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:32 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAI3SNEI262442
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:28:32 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAI3RxN5001601
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2015 14:27:59 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, anton@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 0/8] FP/VEC/VSX switching optimisations
Date: Wed, 18 Nov 2015 14:26:47 +1100
Message-Id: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

These patches are an extension of the work done by Anton
https://patchwork.ozlabs.org/patch/537621/, they'll need to be applied on
top of them.

The goal of these patches is to rework how the 'math' registers (FP, VEC
and VSX) are context switched. Currently the kernel adopts a lazy approach,
always switching userspace tasks with all three facilities disabled and
loads in each set of registers upon receiving each unavailable exception.
The kernel does try to avoid disabling the features in the syscall quick
path but it during testing it appears that even what should be a simple
syscall still causes the kernel to use some facilities (vectorised memcpy
for example) for its self and therefore disable it for the user task.

The lazy approach makes for a small amount of time spent restoring
userspace state and if tasks don't use any of these facilities it is the
correct thing to do. In recent years, new workloads and new features such
as auto vectorisation in GCC have meant that the use of these facilities by
userspace has increased, so much so that some workloads can have a task
take an FP unavailable exception and a VEC unavailable exception almost
every time slice.

This series removes the general laziness in favour of a more selective
approach. If a task uses any of the 'math' facilities the kernel will load
the registers and enable the facilities for future time slices as the
assumption is that the use is likely to continue for some time. This
removes the cost of having to take an exception.

These patches also adds logic to detect if a task had been using a facility
and optimises in the case where the registers are still hot, this provides
another speedup as not only is the cost of the exception saved but the cost
of copying up to 64 x 128 bit registers is also removed.

With these patches applied on top of Antons patches I observe a significant
improvement with Antons context switch microbenchmark using yield():

http://ozlabs.org/~anton/junkcode/context_switch2.c

Using an LE kernel compiled with pseries_le_defconfig

Running:
./context_switch2 --test=yield 8 8
and adding one of --fp, --altivec or --vector
Gives a 5% improvement on a POWER8 CPU.

./context_switch2 --test=yield --fp --altivec --vector 8 8
Gives a 15% improvement on a POWER8 CPU.

I'll take this opportunity to note that 15% can be somewhat misleading. It
may be reasonable to assume that each of the optimisations has had a
compounding effect, this isn't incorrect and the reason behind the apparent
compounding reveals a lot about where the current bottleneck is.

The tests always touch FP first, then VEC then VSX which is the guaranteed
worst case for the way the kernel currently operates. This behaviour will
trigger three subsequent unavailable exceptions. Since the kernel currently
enables all three facilities after taking a VSX unavailable the tests can
be modified to touch VSX->VEC->FP in this order the difference in
performance when touching all three only 5%. There is a compounding effect
in so far as the cost of taking multiple unavailable exception is removed.
This testing also demonstrates that the cost of the exception is by far the
most expensive part of the current lazy approach.

Cyril Bur (8):
  selftests/powerpc: Test the preservation of FPU and VMX regs across
    syscall
  selftests/powerpc: Test preservation of FPU and VMX regs across
    preemption
  selftests/powerpc: Test FPU and VMX regs in signal ucontext
  powerpc: Explicitly disable math features when copying thread
  powerpc: Restore FPU/VEC/VSX if previously used
  powerpc: Add the ability to save FPU without giving it up
  powerpc: Add the ability to save Altivec without giving it up
  powerpc: Add the ability to save VSX without giving it up

 arch/powerpc/include/asm/processor.h               |   2 +
 arch/powerpc/include/asm/switch_to.h               |   5 +-
 arch/powerpc/kernel/asm-offsets.c                  |   2 +
 arch/powerpc/kernel/entry_64.S                     |  55 +++++-
 arch/powerpc/kernel/fpu.S                          |  25 +--
 arch/powerpc/kernel/ppc_ksyms.c                    |   4 -
 arch/powerpc/kernel/process.c                      | 144 ++++++++++++--
 arch/powerpc/kernel/vector.S                       |  45 +----
 tools/testing/selftests/powerpc/Makefile           |   3 +-
 tools/testing/selftests/powerpc/math/Makefile      |  19 ++
 tools/testing/selftests/powerpc/math/basic_asm.h   |  26 +++
 tools/testing/selftests/powerpc/math/fpu_asm.S     | 185 +++++++++++++++++
 tools/testing/selftests/powerpc/math/fpu_preempt.c |  92 +++++++++
 tools/testing/selftests/powerpc/math/fpu_signal.c  | 119 +++++++++++
 tools/testing/selftests/powerpc/math/fpu_syscall.c |  79 ++++++++
 tools/testing/selftests/powerpc/math/vmx_asm.S     | 219 +++++++++++++++++++++
 tools/testing/selftests/powerpc/math/vmx_preempt.c |  92 +++++++++
 tools/testing/selftests/powerpc/math/vmx_signal.c  | 124 ++++++++++++
 tools/testing/selftests/powerpc/math/vmx_syscall.c |  81 ++++++++
 19 files changed, 1240 insertions(+), 81 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/math/Makefile
 create mode 100644 tools/testing/selftests/powerpc/math/basic_asm.h
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_asm.S
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_preempt.c
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_signal.c
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_syscall.c
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_asm.S
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_preempt.c
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_signal.c
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_syscall.c

-- 
2.6.2
