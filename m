Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC69A1A02D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 16:05:37 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8A7BA140BF7
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:05:36 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 15 Jan 2016 15:05:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 651802BB0052
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:05:32 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0F55O0d57671756
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:05:32 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0F550pm005874
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:05:00 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u0F5509c005054
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:05:00 +1100
Received: from camb691.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 70137A01C7
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jan 2016 16:04:35 +1100 (AEDT)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2 0/8] FP/VEC/VSX switching optimisations
Date: Fri, 15 Jan 2016 16:04:06 +1100
Message-Id: <1452834254-22078-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cover-letter for V1 of the series is at
https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-November/136350.html

Version one of this series used a cmpb instruction in handcrafted assembly
which it turns out is not supported on older power machines. Michael
suggested replacing it with crandc, which instruction works fine. Testing
also showed no difference in performance between using cmpb and crandc.

The primary objective improving the syscall hot path. While gut feelings
may be that avoiding C is quicker it may also be the case that the C is not
significantly slower. If C is not slower using C would provide a distinct
readability and maintainability advantage.
I have benchmarked a few possible scenarios:
1. Always calling into C.
2. Testing for the common case in assembly and calling into C
3. Using crandc in the full assembly check

All benchmarks are the average of 50 runs of Antons context switch
benchmark http://www.ozlabs.org/~anton/junkcode/context_switch2.c with
the kernel and ramdisk run under QEMU/KVM on a POWER8.
To test for all cases a variety of flags were passed to the benchmark to
see the effect of only touching a subset of the 'math' register space.

The absolute numbers are in context switches per second can vary greatly
depending on the how the kernel is run (virt/powernv/ramdisk/disk) and as
such units aren't very relevant here as we're interested in a speedup.
The most interesting number here is the %speedup over the previous
scenario. In this case 100% means there was no difference, therefore <100%
indicates a decrease in performance and >100% an increase.

For 1 - Always calling into C
         Flags |  Average   |  Stddev  |
========================================
          none | 2059785.00 | 14217.64 |
            fp | 1766297.65 | 10576.64 |
    fp altivec | 1636125.04 | 5693.84  |
     fp vector | 1640951.76 | 13141.93 |
       altivec | 1815133.80 | 10450.46 |
altivec vector | 1636438.60 | 5475.12  |
        vector | 1639628.16 | 11456.06 |
           all | 1629516.32 | 7785.36  |



For 2 - Common case checking in asm before calling into C
         Flags |  Average   |  Stddev  | %speedup vs 1 |
========================================================
          none | 2058003.64 | 20464.22 | 99.91         |
            fp | 1757245.80 | 14455.45 | 99.49         |
    fp altivec | 1658240.12 | 6318.41  | 101.35        |
     fp vector | 1668912.96 | 9451.47  | 101.70        |
       altivec | 1815223.96 | 4819.82  | 100.00        |
altivec vector | 1648805.32 | 15100.50 | 100.76        |
        vector | 1663654.68 | 13814.79 | 101.47        |
           all | 1644884.04 | 11315.74 | 100.94        |



For 3 - Full checking in ASM using crandc instead of cmpb
         Flags |  Average   |  Stddev  | %speedup vs 2 |
========================================================
          none | 2066930.52 | 19426.46 | 100.43        |
            fp | 1781653.24 | 7744.55  | 101.39        |
    fp altivec | 1653125.84 | 6727.36  | 99.69         |
     fp vector | 1656011.04 | 11678.56 | 99.23         |
       altivec | 1824934.72 | 16842.19 | 100.53        |
altivec vector | 1649486.92 | 3219.14  | 100.04        |
        vector | 1662420.20 | 9609.34  | 99.93         |
           all | 1647933.64 | 11121.22 | 100.19        |

>From these numbers it appears that reducing the call to C in the common
case is beneficial, possibly up to 1.5% speedup over always calling C. The
benefit of the more complicated asm checking does appear to be very slight,
fractions of a percent at best. In balance it may prove wise to use the
option 2, there are much bigger fish to fry in terms of performance, the
complexity of the assembly for a small fraction of one percent improvement
is not worth it at this stage.

Version 2 of this series also addresses some comments from Mikey Neuling in
the tests such as adding .gitignore and forcing 64 bit compiles of the
tests as they use 64 bit only instructions.


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
 arch/powerpc/kernel/entry_64.S                     |  21 +-
 arch/powerpc/kernel/fpu.S                          |  25 +--
 arch/powerpc/kernel/ppc_ksyms.c                    |   4 -
 arch/powerpc/kernel/process.c                      | 144 +++++++++++--
 arch/powerpc/kernel/vector.S                       |  45 +---
 tools/testing/selftests/powerpc/Makefile           |   3 +-
 tools/testing/selftests/powerpc/basic_asm.h        |  26 +++
 tools/testing/selftests/powerpc/math/.gitignore    |   6 +
 tools/testing/selftests/powerpc/math/Makefile      |  19 ++
 tools/testing/selftests/powerpc/math/fpu_asm.S     | 195 ++++++++++++++++++
 tools/testing/selftests/powerpc/math/fpu_preempt.c | 113 ++++++++++
 tools/testing/selftests/powerpc/math/fpu_signal.c  | 135 ++++++++++++
 tools/testing/selftests/powerpc/math/fpu_syscall.c |  90 ++++++++
 tools/testing/selftests/powerpc/math/vmx_asm.S     | 229 +++++++++++++++++++++
 tools/testing/selftests/powerpc/math/vmx_preempt.c | 113 ++++++++++
 tools/testing/selftests/powerpc/math/vmx_signal.c  | 138 +++++++++++++
 tools/testing/selftests/powerpc/math/vmx_syscall.c |  92 +++++++++
 20 files changed, 1326 insertions(+), 81 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/basic_asm.h
 create mode 100644 tools/testing/selftests/powerpc/math/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/math/Makefile
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_asm.S
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_preempt.c
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_signal.c
 create mode 100644 tools/testing/selftests/powerpc/math/fpu_syscall.c
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_asm.S
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_preempt.c
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_signal.c
 create mode 100644 tools/testing/selftests/powerpc/math/vmx_syscall.c

-- 
2.7.0
