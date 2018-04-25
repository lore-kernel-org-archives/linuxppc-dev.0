Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WJXr00ZMzDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 21:55:03 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id o16so15004343pfk.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 04:55:03 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 00/11] KVM: PPC: reconstruct mmio emulation with
 analyse_instr()
Date: Wed, 25 Apr 2018 19:54:33 +0800
Message-Id: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

We already have analyse_instr() which analyzes instructions for the instruction
type, size, addtional flags, etc. What kvmppc_emulate_loadstore() did is somehow
duplicated and it will be good to utilize analyse_instr() to reconstruct the
code. The advantage is that the code logic will be shared and more clean to be 
maintained.

This patch series reconstructs kvmppc_emulate_loadstore() for various load/store
instructions. 

The testcase locates at:
https://github.com/justdoitqd/publicFiles/blob/master/test_mmio.c

- Tested at both PR/HV KVM. 
- Also tested with little endian host & big endian guest.

Tested instruction list: 
	lbz lbzu lbzx ld ldbrx
	ldu ldx lfd lfdu lfdx
	lfiwax lfiwzx lfs lfsu lfsx
	lha lhau lhax lhbrx lhz
	lhzu lhzx lvx lwax lwbrx
	lwz lwzu lwzx lxsdx lxsiwax
	lxsiwzx lxsspx lxvd2x lxvdsx lxvw4x
	stb stbu stbx std stdbrx
	stdu stdx stfd stfdu stfdx
	stfiwx stfs stfsx sth sthbrx
	sthu sthx stvx stw stwbrx
	stwu stwx stxsdx stxsiwx stxsspx
	stxvd2x stxvw4x

Simon Guo (11):
  KVM: PPC: add pt_regs into kvm_vcpu_arch and move vcpu->arch.gpr[]
    into it
  KVM: PPC: mov nip/ctr/lr/xer registers to pt_regs in kvm_vcpu_arch
  KVM: PPC: Fix a mmio_host_swabbed uninitialized usage issue when VMX
    store
  KVM: PPC: fix incorrect element_size for stxsiwx in analyse_instr
  KVM: PPC: add GPR RA update skeleton for MMIO emulation
  KVM: PPC: add KVMPPC_VSX_COPY_WORD_LOAD_DUMP type support for mmio
    emulation
  KVM: PPC: reconstruct non-SIMD LOAD/STORE instruction mmio emulation
    with analyse_intr() input
  KVM: PPC: add giveup_ext() hook for PPC KVM ops
  KVM: PPC: reconstruct LOAD_FP/STORE_FP instruction mmio emulation with
    analyse_intr() input
  KVM: PPC: reconstruct LOAD_VMX/STORE_VMX instruction mmio emulation
    with analyse_intr() input
  KVM: PPC: reconstruct LOAD_VSX/STORE_VSX instruction mmio emulation
    with analyse_intr() input

 arch/powerpc/include/asm/kvm_book3s.h    |  20 +-
 arch/powerpc/include/asm/kvm_book3s_64.h |  20 +-
 arch/powerpc/include/asm/kvm_booke.h     |  20 +-
 arch/powerpc/include/asm/kvm_host.h      |   9 +-
 arch/powerpc/include/asm/kvm_ppc.h       |   2 +
 arch/powerpc/include/asm/sstep.h         |   2 +-
 arch/powerpc/kernel/asm-offsets.c        |  22 +-
 arch/powerpc/kvm/book3s_32_mmu.c         |   2 +-
 arch/powerpc/kvm/book3s_64_vio_hv.c      |   2 +-
 arch/powerpc/kvm/book3s_hv.c             |  11 +-
 arch/powerpc/kvm/book3s_hv_builtin.c     |   6 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  15 +-
 arch/powerpc/kvm/book3s_hv_rm_xics.c     |   2 +-
 arch/powerpc/kvm/book3s_hv_tm.c          |  10 +-
 arch/powerpc/kvm/book3s_hv_tm_builtin.c  |  10 +-
 arch/powerpc/kvm/book3s_pr.c             |  73 +--
 arch/powerpc/kvm/book3s_xive_template.c  |   4 +-
 arch/powerpc/kvm/booke.c                 |  41 +-
 arch/powerpc/kvm/booke_emulate.c         |   6 +-
 arch/powerpc/kvm/e500_emulate.c          |   6 +-
 arch/powerpc/kvm/e500_mmu.c              |   2 +-
 arch/powerpc/kvm/emulate_loadstore.c     | 734 +++++++++----------------------
 arch/powerpc/kvm/powerpc.c               |  53 ++-
 arch/powerpc/lib/sstep.c                 |   2 +-
 24 files changed, 407 insertions(+), 667 deletions(-)

-- 
1.8.3.1
