Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rPjt5JcNzF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 17:47:14 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id t12-v6so12508486plo.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 00:47:14 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v4 00/29] KVM: PPC: Book3S PR: Transaction memory support on
 PR KVM
Date: Wed, 23 May 2018 15:01:43 +0800
Message-Id: <1527058932-7434-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

In current days, many OS distributions have utilized transaction
memory functionality. In PowerPC, HV KVM supports TM. But PR KVM
does not.

The drive for the transaction memory support of PR KVM is the
openstack Continuous Integration testing - They runs a HV(hypervisor)
KVM(as level 1) and then run PR KVM(as level 2) on top of that.

This patch set add transaction memory support on PR KVM.

v3 -> v4 changes:
- fix a powermac 32-bit compile failure.

v2 -> v3 changes:
1) rebase onto Paul's kvm-ppc-next branch, which includes rework 
KVM_CHECK_EXTENSION ioctl (patch #25) a little bit. 
2) allow mtspr TFHAR in TM suspend state
3) remove patch: 
  "KVM: PPC: add KVM_SET_ONE_REG/KVM_GET_ONE_REG to async ioctl"
4) some minor rework per comments

v1 -> v2 changes:
1. Correct a bug in trechkpt emulation: the tm sprs need to be 
flushed to vcpu before trechkpt.
2. add PR kvm ioctl functionalities for TM.
3. removed save_msr_tm and use kvmppc_get_msr() to determine 
whether a transaction state need to be restored.
4. Remove "KVM: PPC: Book3S PR: set MSR HV bit accordingly 
for PPC970 and others." patch.
It will prevent PR KVM to start as L1 hypervisor. Since if 
we set HV bit to 0 when rfid to guest (who is supposed to 
run at HV=1 && PR=1), the guest will not be able to access 
its original memory.
The original code always set HV bits for shadow_msr, it is 
benign since:
HV bits can only be altered by sc instruction; it can only 
be set to 0 by rfid/hrfid instruction.  
We return to guest with rfid. So:
* if KVM are running as L1 hypervisor, guest physical MSR 
expects HV=1.
* if KVM are running as L2 hypervisor, rfid cannot update 
HV =1 so the HV is still 0.
5. add XER register implementation to 
kvmppc_copyto_vcpu_tm/kvmppc_copyfrom_vcpu_tm()
6. remove unnecessary stack frame in _kvmppc_save/restore_tm().
7. move MSR bits sync into kvmppc_copy_from_svcpu() so that 
we always see inconsistent shadow_msr/kvmppc_get_msr() 
even when preemption.
8. doing failure recording in treclaim emulation when TEXASR_FS
is 0.

Simon Guo (29):
  powerpc: export symbol msr_check_and_set().
  powerpc: add TEXASR related macros
  powerpc: export tm_enable()/tm_disable/tm_abort() APIs
  KVM: PPC: Book3S PR: Move kvmppc_save_tm/kvmppc_restore_tm to separate
    file
  KVM: PPC: Book3S PR: add new parameter (guest MSR) for
    kvmppc_save_tm()/kvmppc_restore_tm()
  KVM: PPC: Book3S PR: turn on FP/VSX/VMX MSR bits in kvmppc_save_tm()
  KVM: PPC: Book3S PR: add C function wrapper for
    _kvmppc_save/restore_tm()
  KVM: PPC: Book3S PR: In PR KVM suspends Transactional state when
    inject an interrupt.
  KVM: PPC: Book3S PR: PR KVM pass through MSR TM/TS bits to shadow_msr.
  KVM: PPC: Book3S PR: Sync TM bits to shadow msr for problem state
    guest
  KVM: PPC: Book3S PR: implement RFID TM behavior to suppress change
    from S0 to N0
  KVM: PPC: Book3S PR: prevent TS bits change in kvmppc_interrupt_pr()
  KVM: PPC: Book3S PR: adds new
    kvmppc_copyto_vcpu_tm/kvmppc_copyfrom_vcpu_tm API for PR KVM.
  KVM: PPC: Book3S PR: add kvmppc_save/restore_tm_sprs() APIs
  KVM: PPC: Book3S PR: add transaction memory save/restore skeleton for
    PR KVM
  KVM: PPC: Book3S PR: add math support for PR KVM HTM
  KVM: PPC: Book3S PR: make mtspr/mfspr emulation behavior based on
    active TM SPRs
  KVM: PPC: Book3S PR: always fail transaction in guest privilege state
  KVM: PPC: Book3S PR: enable NV reg restore for reading TM SPR at guest
    privilege state
  KVM: PPC: Book3S PR: adds emulation for treclaim.
  KVM: PPC: Book3S PR: add emulation for trechkpt in PR KVM.
  KVM: PPC: Book3S PR: add emulation for tabort. for privilege guest
  KVM: PPC: Book3S PR: add guard code to prevent returning to guest with
    PR=0 and Transactional state
  KVM: PPC: Book3S PR: Support TAR handling for PR KVM HTM.
  KVM: PPC: Book3S PR: enable HTM for PR KVM for KVM_CHECK_EXTENSION
    ioctl
  KVM: PPC: move vcpu_load/vcpu_put down to each ioctl case in
    kvm_arch_vcpu_ioctl
  KVM: PPC: remove load/put vcpu for KVM_GET/SET_ONE_REG ioctl
  KVM: PPC: remove load/put vcpu for KVM_GET_REGS/KVM_SET_REGS
  KVM: PPC: Book3S PR: enable kvmppc_get/set_one_reg_pr() for HTM
    registers

 arch/powerpc/include/asm/asm-prototypes.h   |   9 +
 arch/powerpc/include/asm/kvm_book3s.h       |  16 +
 arch/powerpc/include/asm/kvm_host.h         |   1 -
 arch/powerpc/include/asm/reg.h              |  32 +-
 arch/powerpc/include/asm/tm.h               |   2 -
 arch/powerpc/include/uapi/asm/tm.h          |   2 +-
 arch/powerpc/kernel/process.c               |   1 +
 arch/powerpc/kernel/tm.S                    |  12 +
 arch/powerpc/kvm/Makefile                   |   3 +
 arch/powerpc/kvm/book3s.c                   |   6 -
 arch/powerpc/kvm/book3s.h                   |   6 +
 arch/powerpc/kvm/book3s_64_mmu.c            |  11 +-
 arch/powerpc/kvm/book3s_emulate.c           | 369 +++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S     | 343 +-------------------
 arch/powerpc/kvm/book3s_pr.c                | 341 ++++++++++++++++++--
 arch/powerpc/kvm/book3s_segment.S           |  13 +
 arch/powerpc/kvm/powerpc.c                  |  12 +-
 arch/powerpc/kvm/tm.S                       | 467 ++++++++++++++++++++++++++++
 arch/powerpc/mm/hash_utils_64.c             |   1 +
 arch/powerpc/platforms/powernv/copy-paste.h |   3 +-
 20 files changed, 1262 insertions(+), 388 deletions(-)
 create mode 100644 arch/powerpc/kvm/tm.S

-- 
1.8.3.1
