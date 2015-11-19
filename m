Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1FF81A09E6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 22:36:46 +1100 (AEDT)
In-Reply-To: <1447817215-15804-4-git-send-email-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, mikey@neuling.org, anton@samba.org,
 linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/8] selftests/powerpc: Test FPU and VMX regs in signal ucontext
Message-Id: <20151119113646.695F8141498@ozlabs.org>
Date: Thu, 19 Nov 2015 22:36:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-18-11 at 03:26:50 UTC, Cyril Bur wrote:
> Load up the non volatile FPU and VMX regs and ensure that they are the
> expected value in a signal handler

This is giving me:

  $ /usr/bin/powerpc-linux-gnu-gcc -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"v4.0-rc1-55000-g906d582"' -I/home/buildbot/buildbot/slave/selftests-ppc64-gcc-ubuntu-be/build/tools/testing/selftests/powerpc  -O2 -g -pthread    fpu_signal.c ../harness.c fpu_asm.S   -o fpu_signal
  fpu_signal.c: In function ‘signal_fpu_sig’:
  fpu_signal.c:33:19: error: initialization from incompatible pointer type [-Werror]
    mcontext_t *mc = &uc->uc_mcontext;
                     ^
  fpu_signal.c:37:9: error: ‘mcontext_t’ has no member named ‘fp_regs’
     if (mc->fp_regs[i] != darray[i - 14]) {
           ^


As well as:

  $ /usr/bin/powerpc-linux-gnu-gcc -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"v4.0-rc1-55000-g906d582"' -I/home/buildbot/buildbot/slave/selftests-ppc64-gcc-ubuntu-be/build/tools/testing/selftests/powerpc  -O2 -g -pthread    vmx_syscall.c ../harness.c vmx_asm.S   -o vmx_syscall
  vmx_asm.S: Assembler messages:
  vmx_asm.S:61: Error: unsupported relocation against v20
  vmx_asm.S:63: Error: unsupported relocation against v21

Times infinity.

And same for vmx_preempt.

And:

  $ /usr/bin/powerpc-linux-gnu-gcc -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"v4.0-rc1-55000-g906d582"' -I/home/buildbot/buildbot/slave/selftests-ppc64-gcc-ubuntu-be/build/tools/testing/selftests/powerpc  -O2 -g -pthread    vmx_signal.c ../harness.c vmx_asm.S   -o vmx_signal
  make[1]: *** [vmx_preempt] Error 1
  vmx_signal.c: In function ‘signal_vmx_sig’:
  vmx_signal.c:37:19: error: initialization from incompatible pointer type [-Werror]
    mcontext_t *mc = &uc->uc_mcontext;
                     ^
  vmx_signal.c:41:16: error: ‘mcontext_t’ has no member named ‘v_regs’
     if (memcmp(mc->v_regs->vrregs[i], &varray[i - 20], 16)) {
                ^


cheers
