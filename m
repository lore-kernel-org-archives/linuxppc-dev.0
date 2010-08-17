Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 3EF50B70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 Aug 2010 23:58:05 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 00/26] KVM: PPC: Mid-August patch queue
Date: Tue, 17 Aug 2010 15:57:35 +0200
Message-Id: <1282053481-18787-1-git-send-email-agraf@suse.de>
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

Keep in mind that this is the first version that is stable on PPC32 hosts.
All versions prior to this could occupy otherwise used segment entries and
thus crash your machine :-).

After finally meeting Avi again, we also agreed to give pulls a try. So
here we go - this is my tree online:

    git://github.com/agraf/linux-2.6.git kvm-ppc-next


Have fun with more accurate, faster and less buggy KVM on PowerPC!


Alexander Graf (23):
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

Hollis Blanchard (3):
  KVM: PPC: initialize IVORs in addition to IVPR
  KVM: PPC: fix compilation of "dump tlbs" debug function
  KVM: PPC: allow ppc440gp to pass the compatibility check

 arch/powerpc/include/asm/kvm_book3s.h |   25 ++--
 arch/powerpc/include/asm/kvm_para.h   |    3 +
 arch/powerpc/kernel/asm-offsets.c     |    1 +
 arch/powerpc/kernel/kvm.c             |  144 ++++++++++++++++++---
 arch/powerpc/kernel/kvm_emul.S        |   75 +++++++++--
 arch/powerpc/kvm/44x.c                |    3 +-
 arch/powerpc/kvm/44x_tlb.c            |    1 +
 arch/powerpc/kvm/book3s.c             |   54 ++++----
 arch/powerpc/kvm/book3s_32_mmu.c      |   83 +++++++------
 arch/powerpc/kvm/book3s_32_mmu_host.c |   67 ++++++----
 arch/powerpc/kvm/book3s_64_mmu_host.c |   59 +++------
 arch/powerpc/kvm/book3s_emulate.c     |   48 +++-----
 arch/powerpc/kvm/book3s_mmu_hpte.c    |   38 ++----
 arch/powerpc/kvm/booke.c              |    8 +-
 arch/powerpc/kvm/powerpc.c            |    5 +-
 arch/powerpc/kvm/trace.h              |  230 +++++++++++++++++++++++++++++++++
 16 files changed, 614 insertions(+), 230 deletions(-)
