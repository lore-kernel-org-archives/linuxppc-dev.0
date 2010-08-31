Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 82942B7100
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:32:18 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PULL 00/35] KVM: PPC: End-August patch queue
Date: Tue, 31 Aug 2010 04:31:41 +0200
Message-Id: <1283221937-21006-1-git-send-email-agraf@suse.de>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Howdy,

This is my local patch queue with stuff that has accumulated over the last
weeks on KVM for PPC with some last minute fixes, speedups and debugging help
that I needed for the KVM Forum ;-).

The highlights of this set are:

  - Converted most important debug points to tracepoints
  - Flush less PTEs (speedup)
  - Go back to our own hash (less duplicates)
  - Make SRs guest settable (speedup for 32 bit guests)
  - Remove r30/r31 restrictions from PV hooks (speedup!)
  - Fix random breakages
  - Fix random guest stalls
  - 440GP host support (Thanks Hollis!)
  - Reliable interrupt injection

Keep in mind that this is the first version that is stable on PPC32 hosts.
All versions prior to this could occupy otherwise used segment entries and
thus crash your machine :-).

It is also the first version that is stable with PPC64 guests, because they
require more sophisticated interrupt injection logic for which qemu patches
are also required.

Please pull this tree from:

    git://github.com/agraf/linux-2.6.git kvm-ppc-next

Have fun with more accurate, faster and less buggy KVM on PowerPC!

Alexander Graf (31):
  KVM: PPC: Move EXIT_DEBUG partially to tracepoints
  KVM: PPC: Move book3s_64 mmu map debug print to trace point
  KVM: PPC: Add tracepoint for generic mmu map
  KVM: PPC: Move pte invalidate debug code to tracepoint
  KVM: PPC: Fix sid map search after flush
  KVM: PPC: Add tracepoints for generic spte flushes
  KVM: PPC: Preload magic page when in kernel mode
  KVM: PPC: Don't flush PTEs on NX/RO hit
  KVM: PPC: Make invalidation code more reliable
  KVM: PPC: Move slb debugging to tracepoints
  KVM: PPC: Revert "KVM: PPC: Use kernel hash function"
  KVM: PPC: Remove unused define
  KVM: PPC: Add feature bitmap for magic page
  KVM: PPC: Move BAT handling code into spr handler
  KVM: PPC: Interpret SR registers on demand
  KVM: PPC: Put segment registers in shared page
  KVM: PPC: Add mtsrin PV code
  KVM: PPC: Make PV mtmsr work with r30 and r31
  KVM: PPC: Update int_pending also on dequeue
  KVM: PPC: Make PV mtmsrd L=1 work with r30 and r31
  KVM: PPC: Force enable nap on KVM
  KVM: PPC: Implement correct SID mapping on Book3s_32
  KVM: PPC: Don't put MSR_POW in MSR
  KVM: PPC: Enable napping only for Book3s_64
  KVM: PPC: Implement Level interrupts on Book3S
  KVM: PPC: Fix CONFIG_KVM_GUEST && !CONFIG_KVM case
  KVM: PPC: Expose level based interrupt cap
  KVM: PPC: Implement level interrupts for BookE
  KVM: PPC: Document KVM_INTERRUPT ioctl
  KVM: PPC: Fix compile error in e500_tlb.c
  KVM: PPC: Add documentation for magic page enhancements

Hollis Blanchard (3):
  KVM: PPC: initialize IVORs in addition to IVPR
  KVM: PPC: fix compilation of "dump tlbs" debug function
  KVM: PPC: allow ppc440gp to pass the compatibility check

Kyle Moffett (1):
  KVM: PPC: e500_tlb: Fix a minor copy-paste tracing bug

 Documentation/kvm/api.txt             |   33 +++++-
 Documentation/kvm/ppc-pv.txt          |   17 +++
 arch/powerpc/include/asm/kvm.h        |    1 +
 arch/powerpc/include/asm/kvm_asm.h    |    4 +-
 arch/powerpc/include/asm/kvm_book3s.h |   25 ++--
 arch/powerpc/include/asm/kvm_para.h   |    3 +
 arch/powerpc/kernel/asm-offsets.c     |    7 +-
 arch/powerpc/kernel/kvm.c             |  147 ++++++++++++++++++---
 arch/powerpc/kernel/kvm_emul.S        |   75 +++++++++--
 arch/powerpc/kvm/44x.c                |    3 +-
 arch/powerpc/kvm/44x_tlb.c            |    1 +
 arch/powerpc/kvm/book3s.c             |   84 +++++++-----
 arch/powerpc/kvm/book3s_32_mmu.c      |   83 ++++++-----
 arch/powerpc/kvm/book3s_32_mmu_host.c |   67 ++++++----
 arch/powerpc/kvm/book3s_64_mmu_host.c |   59 +++-----
 arch/powerpc/kvm/book3s_emulate.c     |   48 +++-----
 arch/powerpc/kvm/book3s_mmu_hpte.c    |   38 ++---
 arch/powerpc/kvm/booke.c              |   25 +++-
 arch/powerpc/kvm/booke.h              |    4 +-
 arch/powerpc/kvm/e500_tlb.c           |    9 +-
 arch/powerpc/kvm/powerpc.c            |    6 +-
 arch/powerpc/kvm/trace.h              |  239 +++++++++++++++++++++++++++++++++
 include/linux/kvm.h                   |    1 +
 23 files changed, 730 insertions(+), 249 deletions(-)
