Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DCC7D1A0477
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 11:44:38 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com, scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/19] Context switch improvements
Date: Thu, 29 Oct 2015 11:43:52 +1100
Message-Id: <1446079451-8774-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here are various improvements to our context switch path. Some of the
highlights:

- Group all mfsprs and mtsprs in __switch_to(), which gives us a
  10% improvement on POWER8.

- Create giveup_all() and flush_all_to_thread() so we only write the
  MSR once, which gives us a 3% improvement on POWER8.

- Create disable_kernel_{fp,altivec,vsx,spe}() and add a debug boot
  option (ppc_strict_facility_enable) to minimise kernel code running
  with floating point and vector bits enabled.

- Make giveup_vsx() and flush_vsx_to_thread() handle FP and Altivec
  state, so they behave more like their sister functions.

Scott: There are changes to the SPE code here which I have only been
able to compile test.

Anton
--

Anton Blanchard (19):
  powerpc: Don't disable kernel FP/VMX/VSX MSR bits on context switch
  powerpc: Don't disable MSR bits in do_load_up_transact_*() functions
  powerpc: Create context switch helpers save_sprs() and restore_sprs()
  powerpc: Remove redundant mflr in _switch
  powerpc: Remove UP only lazy floating point and vector optimisations
  powerpc: Simplify TM restore checks
  powerpc: Create mtmsrd_isync()
  powerpc: Remove NULL task struct pointer checks in FP and vector code
  powerpc: Move part of giveup_fpu,altivec,spe into c
  powerpc: Move part of giveup_vsx into c
  crypto: vmx: Only call enable_kernel_vsx()
  powerpc: Create msr_check_and_{set,clear}()
  powerpc: Create disable_kernel_{fp,altivec,vsx,spe}()
  powerpc: Add ppc_strict_facility_enable boot option
  powerpc: Remove fp_enable() and vec_enable(), use
    msr_check_and_{set,clear}()
  powerpc: create giveup_all()
  powerpc: create flush_all_to_thread()
  powerpc: Rearrange __switch_to()
  powerpc: clean up asm/switch_to.h

 Documentation/kernel-parameters.txt      |   6 +
 arch/powerpc/crypto/aes-spe-glue.c       |   1 +
 arch/powerpc/crypto/sha1-spe-glue.c      |   1 +
 arch/powerpc/crypto/sha256-spe-glue.c    |   1 +
 arch/powerpc/include/asm/processor.h     |   9 +-
 arch/powerpc/include/asm/reg.h           |  17 ++
 arch/powerpc/include/asm/switch_to.h     |  65 ++---
 arch/powerpc/kernel/align.c              |   2 +
 arch/powerpc/kernel/entry_64.S           |  75 +----
 arch/powerpc/kernel/fpu.S                |  73 +----
 arch/powerpc/kernel/head_fsl_booke.S     |  42 +--
 arch/powerpc/kernel/idle_power7.S        |   7 -
 arch/powerpc/kernel/ppc_ksyms.c          |   6 -
 arch/powerpc/kernel/process.c            | 471 ++++++++++++++++++-------------
 arch/powerpc/kernel/signal_32.c          |  22 +-
 arch/powerpc/kernel/signal_64.c          |  22 +-
 arch/powerpc/kernel/swsusp.c             |   4 +-
 arch/powerpc/kernel/vector.S             | 112 +-------
 arch/powerpc/kvm/book3s_hv.c             |   5 +-
 arch/powerpc/kvm/book3s_paired_singles.c |   1 +
 arch/powerpc/kvm/book3s_pr.c             |  21 +-
 arch/powerpc/kvm/booke.c                 |   4 +
 arch/powerpc/lib/vmx-helper.c            |   2 +
 arch/powerpc/lib/xor_vmx.c               |   4 +
 drivers/crypto/vmx/aes.c                 |   6 +-
 drivers/crypto/vmx/aes_cbc.c             |   6 +-
 drivers/crypto/vmx/aes_ctr.c             |   6 +-
 drivers/crypto/vmx/ghash.c               |  12 +-
 lib/raid6/altivec.uc                     |   1 +
 29 files changed, 376 insertions(+), 628 deletions(-)

-- 
2.5.0
