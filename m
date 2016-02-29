Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F3B61A0341
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 10:03:04 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BA897140B99
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2016 10:03:03 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 184so3971428pff.1
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Feb 2016 15:03:03 -0800 (PST)
Date: Tue, 1 Mar 2016 10:02:54 +1100
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/9] FP/VEC/VSX switching optimisations
Message-ID: <20160301100254.5cd7b558@camb691>
In-Reply-To: <1456728831-31862-1-git-send-email-cyrilbur@gmail.com>
References: <1456728831-31862-1-git-send-email-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 29 Feb 2016 17:53:42 +1100
Cyril Bur <cyrilbur@gmail.com> wrote:

Apologies this should have had a Version 6 prefix!



> Cover-letter for V1 of the series is at
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-November/136350.html
> 
> Cover-letter for V2 of the series is at
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-January/138054.html
> 
> Changes in V3:
> Addressed review comments from Michael Neuling
>  - Made commit message in 4/9 better reflect the patch
>  - Removed overuse of #ifdef blocks and redundant condition in 5/9
>  - Split 6/8 in two to better prepare for 7,8,9
>  - Removed #ifdefs in 6/9
> 
> Changes in V4:
>  - Addressed non ABI compliant ASM macros in 1/9
>  - Fixed build breakage due to changing #ifdefs in V3 (6/9)
>  - Reordered some conditions in if statements
> 
> Changes in V5:
>  - Enhanced basic-asm.h to provide ABI independent macro as pointed out by
>    Naveen Rao.
>    - Tested for both BE and LE builds. Had to disable -flto from the
>      selftests/powerpc Makefile as it didn't play well with the custom ASM.
>  - Added some extra debugging output to the vmx_signal testcase
>  - Fixed comments in testing code
>  - Updated VSX test code to use GCC Altivec macros
> 
> Changes in V6:
>  - Removed recursive definition of CFLAGS in math/Makefile
>  - Corrected the use of the word param in favour of doubleword
>  - Reordered some code in basic-asm.h and neatened some comments
> 
> 
> 
> Cyril Bur (9):
>   selftests/powerpc: Test the preservation of FPU and VMX regs across
>     syscall
>   selftests/powerpc: Test preservation of FPU and VMX regs across
>     preemption
>   selftests/powerpc: Test FPU and VMX regs in signal ucontext
>   powerpc: Explicitly disable math features when copying thread
>   powerpc: Restore FPU/VEC/VSX if previously used
>   powerpc: Prepare for splitting giveup_{fpu,altivec,vsx} in two
>   powerpc: Add the ability to save FPU without giving it up
>   powerpc: Add the ability to save Altivec without giving it up
>   powerpc: Add the ability to save VSX without giving it up
> 
>  arch/powerpc/include/asm/processor.h               |   2 +
>  arch/powerpc/include/asm/reg.h                     |   8 +
>  arch/powerpc/include/asm/switch_to.h               |  13 +-
>  arch/powerpc/kernel/asm-offsets.c                  |   2 +
>  arch/powerpc/kernel/entry_64.S                     |  21 +-
>  arch/powerpc/kernel/fpu.S                          |  25 +--
>  arch/powerpc/kernel/ppc_ksyms.c                    |   4 -
>  arch/powerpc/kernel/process.c                      | 168 +++++++++++++--
>  arch/powerpc/kernel/vector.S                       |  45 +---
>  tools/testing/selftests/powerpc/Makefile           |   3 +-
>  tools/testing/selftests/powerpc/basic_asm.h        |  63 ++++++
>  tools/testing/selftests/powerpc/math/.gitignore    |   6 +
>  tools/testing/selftests/powerpc/math/Makefile      |  21 ++
>  tools/testing/selftests/powerpc/math/fpu_asm.S     | 197 +++++++++++++++++
>  tools/testing/selftests/powerpc/math/fpu_preempt.c | 113 ++++++++++
>  tools/testing/selftests/powerpc/math/fpu_signal.c  | 135 ++++++++++++
>  tools/testing/selftests/powerpc/math/fpu_syscall.c |  90 ++++++++
>  tools/testing/selftests/powerpc/math/vmx_asm.S     | 234 +++++++++++++++++++++
>  tools/testing/selftests/powerpc/math/vmx_preempt.c | 112 ++++++++++
>  tools/testing/selftests/powerpc/math/vmx_signal.c  | 156 ++++++++++++++
>  tools/testing/selftests/powerpc/math/vmx_syscall.c |  91 ++++++++
>  21 files changed, 1426 insertions(+), 83 deletions(-)
>  create mode 100644 tools/testing/selftests/powerpc/basic_asm.h
>  create mode 100644 tools/testing/selftests/powerpc/math/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/math/Makefile
>  create mode 100644 tools/testing/selftests/powerpc/math/fpu_asm.S
>  create mode 100644 tools/testing/selftests/powerpc/math/fpu_preempt.c
>  create mode 100644 tools/testing/selftests/powerpc/math/fpu_signal.c
>  create mode 100644 tools/testing/selftests/powerpc/math/fpu_syscall.c
>  create mode 100644 tools/testing/selftests/powerpc/math/vmx_asm.S
>  create mode 100644 tools/testing/selftests/powerpc/math/vmx_preempt.c
>  create mode 100644 tools/testing/selftests/powerpc/math/vmx_signal.c
>  create mode 100644 tools/testing/selftests/powerpc/math/vmx_syscall.c
> 
