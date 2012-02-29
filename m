Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A4315B6FAA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 11:10:10 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 00/38] KVM: PPC: e500mc support v3
Date: Wed, 29 Feb 2012 01:09:28 +0100
Message-Id: <1330474206-14794-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is Scott's e500mc RFC patch set rebased, berobbed of its pt_regs
parts and fixed for bisectability. On top of them, I addressed all the
comments that I had on the code and that came up in his code as FIXMEs.

I verified that this patch set works just fine on e500mc and doesn't
break e500v2, so I would say it's good to go as it is, unless someone
has strong objections to how things are done. Everything hereafter
I would prefer to do based on a working upstream version rather than
a downstream fork, as that way exposure is a lot higher.

v1 -> v2:

  - ESR -> GESR
  - introduce and use constants for doorbell
  - drop e500mc ifdefs for doorbell
  - fix whitespace
  - use explicit preempt counts in inst fixup
  - rework e500v2 kconfig patch
  - add patches 31-37

v2 -> v3:

  - add patch 38
  - check for signals earlier
  - also remove "lwz	r9, VCPU_KVM(r4)" which was as superfluous
  - sync host state instead of guest state to pt_regs
  - optimize reinject code path to get out fast when not reinjecting

Alexander Graf (23):
  KVM: PPC: e500mc: Add doorbell emulation support
  KVM: PPC: e500mc: implicitly set MSR_GS
  KVM: PPC: e500mc: Move r1/r2 restoration very early
  KVM: PPC: e500mc: add load inst fixup
  KVM: PPC: rename CONFIG_KVM_E500 -> CONFIG_KVM_E500V2
  KVM: PPC: make e500v2 kvm and e500mc cpu mutually exclusive
  KVM: PPC: booke: remove leftover debugging
  KVM: PPC: booke: deliver program int on emulation failure
  KVM: PPC: booke: rework rescheduling checks
  KVM: PPC: booke: BOOKE_IRQPRIO_MAX is n+1
  KVM: PPC: bookehv: fix exit timing
  KVM: PPC: bookehv: remove negation for CONFIG_64BIT
  KVM: PPC: bookehv: remove SET_VCPU
  KVM: PPC: bookehv: disable MAS register updates early
  KVM: PPC: bookehv: add comment about shadow_msr
  KVM: PPC: booke: Readd debug abort code for machine check
  KVM: PPC: booke: add GS documentation for program interrupt
  KVM: PPC: bookehv: remove unused code
  KVM: PPC: e500: fix typo in tlb code
  KVM: PPC: booke: Support perfmon interrupts
  KVM: PPC: booke: expose good state on irq reinject
  KVM: PPC: booke: Reinject performance monitor interrupts
  KVM: PPC: Booke: only prepare to enter when we enter

Scott Wood (15):
  powerpc/booke: Set CPU_FTR_DEBUG_LVL_EXC on 32-bit
  powerpc/e500: split CPU_FTRS_ALWAYS/CPU_FTRS_POSSIBLE
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
 arch/powerpc/include/asm/dbell.h            |    3 +
 arch/powerpc/include/asm/hw_irq.h           |    1 +
 arch/powerpc/include/asm/kvm.h              |    1 +
 arch/powerpc/include/asm/kvm_asm.h          |    8 +
 arch/powerpc/include/asm/kvm_book3s.h       |    3 +
 arch/powerpc/include/asm/kvm_booke.h        |    3 +
 arch/powerpc/include/asm/kvm_booke_hv_asm.h |   49 +++
 arch/powerpc/include/asm/kvm_e500.h         |   96 -----
 arch/powerpc/include/asm/kvm_host.h         |   22 +-
 arch/powerpc/include/asm/kvm_ppc.h          |   10 +-
 arch/powerpc/include/asm/mmu-book3e.h       |    6 +
 arch/powerpc/include/asm/processor.h        |    3 +
 arch/powerpc/include/asm/reg.h              |    2 +
 arch/powerpc/include/asm/reg_booke.h        |   34 ++
 arch/powerpc/include/asm/system.h           |    1 +
 arch/powerpc/kernel/asm-offsets.c           |   15 +-
 arch/powerpc/kernel/cpu_setup_fsl_booke.S   |    1 +
 arch/powerpc/kernel/head_44x.S              |   23 +-
 arch/powerpc/kernel/head_booke.h            |   69 ++-
 arch/powerpc/kernel/head_fsl_booke.S        |   98 ++++-
 arch/powerpc/kvm/44x.c                      |   12 +
 arch/powerpc/kvm/Kconfig                    |   28 +-
 arch/powerpc/kvm/Makefile                   |   15 +-
 arch/powerpc/kvm/book3s.c                   |    4 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c         |   26 +-
 arch/powerpc/kvm/booke.c                    |  469 +++++++++++++++++----
 arch/powerpc/kvm/booke.h                    |   57 +++-
 arch/powerpc/kvm/booke_emulate.c            |   23 +-
 arch/powerpc/kvm/bookehv_interrupts.S       |  602 +++++++++++++++++++++++++++
 arch/powerpc/kvm/e500.c                     |  372 ++++++++++++++---
 arch/powerpc/kvm/e500.h                     |  302 ++++++++++++++
 arch/powerpc/kvm/e500_emulate.c             |  110 +++++-
 arch/powerpc/kvm/e500_tlb.c                 |  588 +++++++++++---------------
 arch/powerpc/kvm/e500_tlb.h                 |  174 --------
 arch/powerpc/kvm/e500mc.c                   |  342 +++++++++++++++
 arch/powerpc/kvm/powerpc.c                  |   47 ++-
 arch/powerpc/kvm/timing.h                   |    6 +
 38 files changed, 2796 insertions(+), 850 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kvm_booke_hv_asm.h
 delete mode 100644 arch/powerpc/include/asm/kvm_e500.h
 create mode 100644 arch/powerpc/kvm/bookehv_interrupts.S
 create mode 100644 arch/powerpc/kvm/e500.h
 delete mode 100644 arch/powerpc/kvm/e500_tlb.h
 create mode 100644 arch/powerpc/kvm/e500mc.c
