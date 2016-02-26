Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39D381A0B84
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Feb 2016 05:41:20 +1100 (AEDT)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 828791402D9
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2016 05:41:19 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Fri, 26 Feb 2016 11:41:17 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E0A5C19D804E
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:28:48 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1QIepcL39321746
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:40:51 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1QIeoYO016789
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2016 11:40:51 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH 00/14] PCI Passthrough Interrupt Optimizations
Date: Fri, 26 Feb 2016 12:40:18 -0600
Message-Id: <1456512032-31286-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set adds support for handling interrupts for PCI adapters
entirely in the guest under the right conditions. When an interrupt
is received by KVM in real mode, if the interrupt is from a PCI
passthrough adapter owned by the guest, KVM will update the virtual
ICP for the VCPU that is the target of the interrupt entirely in
real mode and generate the virtual interrupt. If the VCPU is not
running in the guest, it will wake up the VCPU.  It will also update
the affinity of the interrupt to directly target the CPU (core)
where this VCPU is being scheduled as an optimization. 

KVM needs the mapping between hardware interrupt numbers in the host
to the virtual hardware interrupt (GSI) that needs to get injected
into the guest. This patch set takes advantage of the IRQ bypass
manager feature to create this mapping. For now, we allocate and
manage a separate mapping structure per VM.

Although a mapping is created for every passthrough IRQ requested
in the guest, we also maintain a cache of mappings that is used to
speed up search. For now, KVM real mode code only looks in the cache for
a mapping. If no mapping is found, we fall back on the usual interrupt
routing mechanism - switch back to host and run the VFIO interrupt
handler.

This is based on 4.5-rc1 plus the patch set in
http://www.spinics.net/lists/kvm-ppc/msg11131.html since it has
dependencies on vmalloc_to_phys() being public.

Suresh Warrier (14):
  powerpc: Add simple cache inhibited MMIO accessors
  KVM: PPC: Book3S HV: Convert kvmppc_read_intr to a C function
  KVM: PPC: select IRQ_BYPASS_MANAGER
  KVM: PPC: Book3S HV: Introduce kvmppc_passthru_irqmap
  KVM: PPC: Book3S HV: Enable IRQ bypass
  KVM: PPC: Book3S HV: Caching for passthrough IRQ map
  KVM: PPC: Book3S HV: Handle passthrough interrupts in guest
  KVM: PPC: Book3S HV: Complete passthrough interrupt in host
  KVM: PPC: Book3S HV: Enable KVM real mode handling of passthrough IRQs
  KVM: PPC: Book3S HV: Dump irqmap in debugfs
  KVM: PPC: Book3S HV: Tunable to disable KVM IRQ bypass
  KVM: PPC: Book3S HV: Update irq stats for IRQs handled in real mode
  KVM: PPC: Book3S HV: Change affinity for passthrough IRQ
  KVM: PPC: Book3S HV: Counters for passthrough IRQ stats

 arch/powerpc/include/asm/io.h             |  28 +++
 arch/powerpc/include/asm/kvm_asm.h        |  10 +
 arch/powerpc/include/asm/kvm_book3s.h     |   1 +
 arch/powerpc/include/asm/kvm_host.h       |  25 +++
 arch/powerpc/include/asm/kvm_ppc.h        |  28 +++
 arch/powerpc/include/asm/pnv-pci.h        |   1 +
 arch/powerpc/kvm/Kconfig                  |   2 +
 arch/powerpc/kvm/book3s.c                 |  45 +++++
 arch/powerpc/kvm/book3s_hv.c              | 318 +++++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv_builtin.c      | 157 +++++++++++++++
 arch/powerpc/kvm/book3s_hv_rm_xics.c      | 181 +++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 226 ++++++++++++---------
 arch/powerpc/kvm/book3s_xics.c            |  68 ++++++-
 arch/powerpc/kvm/book3s_xics.h            |   3 +
 arch/powerpc/platforms/powernv/pci-ioda.c |  14 +-
 15 files changed, 1013 insertions(+), 94 deletions(-)

-- 
1.8.3.4
