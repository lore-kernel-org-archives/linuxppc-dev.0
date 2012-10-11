Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D50512C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:14:22 +1100 (EST)
Received: from mail184-co1 (localhost [127.0.0.1])	by
 mail184-co1-R.bigfish.com (Postfix) with ESMTP id 94A83D40136	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:17 +0000 (UTC)
Received: from CO1EHSMHS009.bigfish.com (unknown [10.243.78.240])	by
 mail184-co1.bigfish.com (Postfix) with ESMTP id DDF5C2C008D	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 16:14:14 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q9BGEBt3003738	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:14:11 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 00/12] KVM: PPC: 64-bit Book3E arch support
Date: Thu, 11 Oct 2012 19:13:17 +0300
Message-ID: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset adds arch support to KVM for 64-bit Book3E PowerPC procesosrs
with Embedded.Hypervisor category. The support is limited to the bolted TLB miss
exception handlers version and was validated on Freescale's e5500 cores
using P5020DS boards.

This patchset is based on Alex G. kvm-ppc-next branch with the following
core prerequisites:

The changes since commit 8b7b80b9ebb46dd88fbb94e918297295cf312b59:

    powerpc: Uprobes port to powerpc

up to commit 8b64a9dfb091f1eca8b7e58da82f1e7d1d5fe0ad:

    powerpc/booke64: Use SPRG0/3 scratch for bolted TLB miss & crit int


and the changes since commit d0832a75075b1119635e0f48549e378040cf5e67:

    powerpc/85xx: add HOTPLUG_CPU support

up to commit 39be5b4a7f232870aad0b3c130791eacd0d34347:

    powerpc/booke: Add CPU_FTR_EMB_HV check for e5500.


available in the git repository

    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git



Mihai Caraman (12):
  KVM: PPC: e500: Silence bogus GCC warning in tlb code
  KVM: PPC: booke: Fix get_tb() compile error on 64-bit
  KVM: PPC: bookehv: Remove GET_VCPU macro from exception handler
  KVM: PPC64: bookehv: Add support for interrupt handling
  KVM: PPC: Add emulation helper for getting instruction ea
  KVM: PPC: Mask ea's high 32-bits in 32/64 instr emulation
  KVM: PPC: e500: Mask MAS2 EPN high 32-bits in 32/64 tlbwe emulation
  KVM: PPC: booke: Extend MAS2 EPN mask for 64-bit
  KVM: PPC: bookehv: Add guest computation mode for irq delivery
  KVM: PPC: bookehv: Add EPCR support in mtspr/mfspr emulation
  KVM: PPC: booke: Add EPCR support in sregs
  KVM: PPC: booke: Get/set guest EPCR register using ONE_REG interface

 Documentation/virtual/kvm/api.txt           |    1 +
 arch/powerpc/include/asm/kvm.h              |    2 +
 arch/powerpc/include/asm/kvm_booke_hv_asm.h |   25 +++++
 arch/powerpc/include/asm/kvm_ppc.h          |   21 ++++
 arch/powerpc/include/asm/mmu-book3e.h       |    2 +-
 arch/powerpc/kvm/booke.c                    |   43 ++++++++-
 arch/powerpc/kvm/booke.h                    |    1 +
 arch/powerpc/kvm/booke_emulate.c            |   12 ++-
 arch/powerpc/kvm/bookehv_interrupts.S       |  145 ++++++++++++++++++++++++---
 arch/powerpc/kvm/e500.h                     |    8 +-
 arch/powerpc/kvm/e500_emulate.c             |   15 ++-
 arch/powerpc/kvm/e500_tlb.c                 |   38 +++----
 12 files changed, 265 insertions(+), 48 deletions(-)

-- 
1.7.4.1
