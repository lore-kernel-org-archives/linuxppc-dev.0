Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 30275B6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Jun 2010 09:25:16 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 00/26] KVM PPC PV framework
Date: Sat, 26 Jun 2010 01:24:48 +0200
Message-Id: <1277508314-915-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PPC we run PR=0 (kernel mode) code in PR=1 (user mode) and don't use the
hypervisor extensions.

While that is all great to show that virtualization is possible, there are
quite some cases where the emulation overhead of privileged instructions is
killing performance.

This patchset tackles exactly that issue. It introduces a paravirtual framework
using which KVM and Linux share a page to exchange register state with. That
way we don't have to switch to the hypervisor just to change a value of a
privileged register.

To prove my point, I ran the same test I did for the MMU optimizations against
the PV framework. Here are the results:

[without]

debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > /dev/null; done

real    0m14.659s
user    0m8.967s
sys     0m5.688s

[with]

debian-powerpc:~# time for i in {1..1000}; do /bin/echo hello > /dev/null; done

real    0m7.557s
user    0m4.121s
sys     0m3.426s


So this is a significant performance improvement! I'm quite happy how fast this
whole thing becomes :)

I tried to take all comments I've heard from people so far about such a PV
framework into account. In case you told me something before that is a no-go
and I still did it, please just tell me again.

Now go and have fun with fast VMs on PPC! Get yourself a G5 on ebay and start
experiencing the power yourself. - heh

Alexander Graf (26):
  KVM: PPC: Introduce shared page
  KVM: PPC: Convert MSR to shared page
  KVM: PPC: Convert DSISR to shared page
  KVM: PPC: Convert DAR to shared page.
  KVM: PPC: Convert SRR0 and SRR1 to shared page
  KVM: PPC: Convert SPRG[0-4] to shared page
  KVM: PPC: Implement hypervisor interface
  KVM: PPC: Add PV guest critical sections
  KVM: PPC: Add PV guest scratch registers
  KVM: PPC: Tell guest about pending interrupts
  KVM: PPC: Make RMO a define
  KVM: PPC: First magic page steps
  KVM: PPC: Magic Page Book3s support
  KVM: PPC: Magic Page BookE support
  KVM: PPC: Expose magic page support to guest
  KVM: Move kvm_guest_init out of generic code
  KVM: PPC: Generic KVM PV guest support
  KVM: PPC: KVM PV guest stubs
  KVM: PPC: PV instructions to loads and stores
  KVM: PPC: PV tlbsync to nop
  KVM: PPC: Introduce kvm_tmp framework
  KVM: PPC: PV assembler helpers
  KVM: PPC: PV mtmsrd L=1
  KVM: PPC: PV mtmsrd L=0 and mtmsr
  KVM: PPC: PV wrteei
  KVM: PPC: Add Documentation about PV interface

 Documentation/kvm/ppc-pv.txt             |  164 ++++++++++++
 arch/powerpc/include/asm/kvm_book3s.h    |    1 -
 arch/powerpc/include/asm/kvm_host.h      |   14 +-
 arch/powerpc/include/asm/kvm_para.h      |  121 +++++++++-
 arch/powerpc/include/asm/kvm_ppc.h       |    1 +
 arch/powerpc/kernel/Makefile             |    2 +
 arch/powerpc/kernel/asm-offsets.c        |   18 ++-
 arch/powerpc/kernel/kvm.c                |  399 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/kvm_emul.S           |  237 ++++++++++++++++++
 arch/powerpc/kvm/44x.c                   |    7 +
 arch/powerpc/kvm/44x_tlb.c               |    8 +-
 arch/powerpc/kvm/book3s.c                |  162 ++++++++-----
 arch/powerpc/kvm/book3s_32_mmu.c         |   28 ++-
 arch/powerpc/kvm/book3s_32_mmu_host.c    |   16 +-
 arch/powerpc/kvm/book3s_64_mmu.c         |   42 +++-
 arch/powerpc/kvm/book3s_64_mmu_host.c    |   16 +-
 arch/powerpc/kvm/book3s_emulate.c        |   25 +-
 arch/powerpc/kvm/book3s_paired_singles.c |   11 +-
 arch/powerpc/kvm/booke.c                 |  110 +++++++--
 arch/powerpc/kvm/booke.h                 |    6 +-
 arch/powerpc/kvm/booke_emulate.c         |   14 +-
 arch/powerpc/kvm/booke_interrupts.S      |    3 +-
 arch/powerpc/kvm/e500.c                  |    7 +
 arch/powerpc/kvm/e500_tlb.c              |   31 ++-
 arch/powerpc/kvm/e500_tlb.h              |    2 +-
 arch/powerpc/kvm/emulate.c               |   47 +++-
 arch/powerpc/kvm/powerpc.c               |   42 +++-
 arch/powerpc/platforms/Kconfig           |   10 +
 arch/x86/include/asm/kvm_para.h          |    6 +
 include/linux/kvm_para.h                 |    7 +-
 30 files changed, 1383 insertions(+), 174 deletions(-)
 create mode 100644 Documentation/kvm/ppc-pv.txt
 create mode 100644 arch/powerpc/kernel/kvm.c
 create mode 100644 arch/powerpc/kernel/kvm_emul.S
