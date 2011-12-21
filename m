Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4A3C7B70AC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:33:53 +1100 (EST)
Date: Tue, 20 Dec 2011 19:33:40 -0600
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [RFC PATCH 00/16] KVM: PPC: e500mc support
Message-ID: <20111221013340.GA8368@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a preliminary patchset for e500mc KVM support, using
hardware virtualization support.  There's still some ugliness
that I need to tame, and it needs a bunch of testing -- but I wanted
to get something out for people to comment on and/or test.

CCing linuxppc-dev as well since some of the patches wander
outside of KVM-land.

Scott Wood (16):
  powerpc/booke: Set CPU_FTR_DEBUG_LVL_EXC on 32-bit
  powerpc/e500: split CPU_FTRS_ALWAYS/CPU_FTRS_POSSIBLE
  KVM: PPC: Use pt_regs in vcpu->arch
  KVM: PPC: factor out lpid allocator from book3s_64_mmu_hv
  KVM: PPC: booke: add booke-level vcpu load/put
  KVM: PPC: booke: Move vm core init/destroy out of booke.c
  KVM: PPC: e500: rename e500_tlb.h to e500.h
  KVM: PPC: e500: merge <asm/kvm_e500.h> into arch/powerpc/kvm/e500.h
  KVM: PPC: e500: clean up arch/powerpc/kvm/e500.h
  KVM: PPC: e500: refactor core-specific TLB code
  KVM: PPC: e500: Track TLB1 entries with a bitmap
  KVM: PPC: e500: emulate tlbilx
  powerpc/booke: Provide exception macros with interrupt name
  KVM: PPC: booke: category E.HV (GS-mode) support
  KVM: PPC: booke: standard PPC floating point support
  KVM: PPC: e500mc support

 arch/powerpc/include/asm/cputable.h         |   21 +-
 arch/powerpc/include/asm/dbell.h            |    1 +
 arch/powerpc/include/asm/kvm.h              |    1 +
 arch/powerpc/include/asm/kvm_asm.h          |    8 +
 arch/powerpc/include/asm/kvm_book3s.h       |   31 +-
 arch/powerpc/include/asm/kvm_booke.h        |   27 +-
 arch/powerpc/include/asm/kvm_booke_hv_asm.h |   49 +++
 arch/powerpc/include/asm/kvm_e500.h         |   96 -----
 arch/powerpc/include/asm/kvm_host.h         |   30 +-
 arch/powerpc/include/asm/kvm_ppc.h          |    8 +
 arch/powerpc/include/asm/mmu-book3e.h       |    6 +
 arch/powerpc/include/asm/processor.h        |    3 +
 arch/powerpc/include/asm/reg.h              |    2 +
 arch/powerpc/include/asm/reg_booke.h        |   34 ++
 arch/powerpc/include/asm/system.h           |    1 +
 arch/powerpc/kernel/asm-offsets.c           |   32 +-
 arch/powerpc/kernel/cpu_setup_fsl_booke.S   |    1 +
 arch/powerpc/kernel/head_44x.S              |   23 +-
 arch/powerpc/kernel/head_booke.h            |   69 ++-
 arch/powerpc/kernel/head_fsl_booke.S        |   98 ++++-
 arch/powerpc/kvm/44x.c                      |   12 +
 arch/powerpc/kvm/Kconfig                    |   20 +-
 arch/powerpc/kvm/Makefile                   |   11 +
 arch/powerpc/kvm/book3s_32_mmu.c            |    2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c         |   26 +-
 arch/powerpc/kvm/book3s_hv.c                |    9 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c         |   12 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S     |    4 +-
 arch/powerpc/kvm/booke.c                    |  485 +++++++++++++++++------
 arch/powerpc/kvm/booke.h                    |   57 +++-
 arch/powerpc/kvm/booke_emulate.c            |   25 +-
 arch/powerpc/kvm/bookehv_interrupts.S       |  587 ++++++++++++++++++++++++++
 arch/powerpc/kvm/e500.c                     |  372 ++++++++++++++---
 arch/powerpc/kvm/e500.h                     |  302 ++++++++++++++
 arch/powerpc/kvm/e500_emulate.c             |   42 ++-
 arch/powerpc/kvm/e500_tlb.c                 |  590 +++++++++++----------------
 arch/powerpc/kvm/e500_tlb.h                 |  174 --------
 arch/powerpc/kvm/e500mc.c                   |  342 ++++++++++++++++
 arch/powerpc/kvm/powerpc.c                  |   45 ++-
 arch/powerpc/kvm/timing.h                   |    6 +
 40 files changed, 2727 insertions(+), 937 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kvm_booke_hv_asm.h
 delete mode 100644 arch/powerpc/include/asm/kvm_e500.h
 create mode 100644 arch/powerpc/kvm/bookehv_interrupts.S
 create mode 100644 arch/powerpc/kvm/e500.h
 delete mode 100644 arch/powerpc/kvm/e500_tlb.h
 create mode 100644 arch/powerpc/kvm/e500mc.c

-- 
1.7.7.rc3.4.g8d714
