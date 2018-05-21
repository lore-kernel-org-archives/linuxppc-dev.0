Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q7R96MZPzF13x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 16:00:05 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id az12-v6so8141759plb.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 23:00:05 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v3 0/7] KVM: PPC: reimplement mmio emulation with
 analyse_instr()
Date: Mon, 21 May 2018 13:24:19 +0800
Message-Id: <1526880266-11291-1-git-send-email-wei.guo.simon@gmail.com>
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
duplicated and it will be good to utilize analyse_instr() to reimplement the
code. The advantage is that the code logic will be shared and more clean to be 
maintained.

This patch series reimplement kvmppc_emulate_loadstore() for various load/store
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
	lvebx stvebx
	lvehx stvehx
	lvewx stvewx

V2 -> V3 changes:
1) add FPU SIGNEXT case to handle lfiwax based on comment.
2) a minor change to go label "out:" when EMULATE_DO_MMIO 
returned based on comment.
3) rebased to paul's kvm-ppc-next branch (3 patches was
merged into that branch and so this patch set includes 7 
patches only).

V1 -> V2 changes:
1) correct patch split issue in v1.
2) revise some commit message/code comment per review comment
3) remove incorrect special handling for stxsiwx
4) remove mmio_update_ra related and move the RA update into
kvmppc_emulate_loadstore().
5) rework giveup_ext() which is only meaningful when not NULL.
6) rewrite VMX emulation code and cover rest VMX instructions:
	lvebx stvebx
	lvehx stvehx
	lvewx stvewx


Simon Guo (7):
  KVM: PPC: add KVMPPC_VSX_COPY_WORD_LOAD_DUMP type support for mmio
    emulation
  KVM: PPC: reimplement non-SIMD LOAD/STORE instruction mmio emulation
    with analyse_intr() input
  KVM: PPC: add giveup_ext() hook for PPC KVM ops
  KVM: PPC: reimplement LOAD_FP/STORE_FP instruction mmio emulation with
    analyse_intr() input
  KVM: PPC: reimplements LOAD_VSX/STORE_VSX instruction mmio emulation
    with analyse_intr() input
  KVM: PPC: expand mmio_vsx_copy_type to mmio_copy_type to cover VMX
    load/store elem types
  KVM: PPC: reimplements LOAD_VMX/STORE_VMX instruction mmio emulation
    with analyse_intr() input

 arch/powerpc/include/asm/kvm_host.h  |  11 +-
 arch/powerpc/include/asm/kvm_ppc.h   |  17 +-
 arch/powerpc/kvm/book3s.c            |   4 +-
 arch/powerpc/kvm/book3s_pr.c         |   1 +
 arch/powerpc/kvm/e500_mmu_host.c     |   8 +-
 arch/powerpc/kvm/emulate_loadstore.c | 751 +++++++++++------------------------
 arch/powerpc/kvm/powerpc.c           | 299 +++++++++++---
 7 files changed, 498 insertions(+), 593 deletions(-)

-- 
1.8.3.1
