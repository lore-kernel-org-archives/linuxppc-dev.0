Return-Path: <mcaraman@mcaraman-VirtualBox.ea.freescale.net>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 05227100833
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 22:26:55 +1000 (EST)
Received: from mail32-db3 (localhost [127.0.0.1])	by mail32-db3-R.bigfish.com
 (Postfix) with ESMTP id 4A37F16016D	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,
 25 Jun 2012 12:25:12 +0000 (UTC)
Received: from DB3EHSMHS008.bigfish.com (unknown [10.3.81.249])	by
 mail32-db3.bigfish.com (Postfix) with ESMTP id 2CAF14600EA	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 12:25:05 +0000 (UTC)
Received: from mcaraman-VirtualBox.ea.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q5PCQdNu019300	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 05:26:40 -0700
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <qemu-ppc@nongnu.org>
Subject: [RFC PATCH 00/17] KVM: PPC: 64-bit Book3E support
Date: Mon, 25 Jun 2012 15:26:18 +0300
Message-ID: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset adds 64-bit Book3E PowerPC support to KVM. It is intended
as a request for comment for scratch register changes and for the support
limited to bolted TLB miss exception handlers.
This work was validated on Freescale's e5500 cores using P5020DS boards.

This patchset is based on Alex G. kvm-ppc-next branch. For a ready to use
git tree, please check here:

  git://github.com/mcaraman/kvm.git 64-bit-booke

Current limitations:

- 64-bit guests must be configured without KVM support. CPU_FTR_EMB_HV setup
  for 64-bit non-hv will be addressed soon in a different patchset.

Prerequisite patches, availabe on top of the git tree:

- commit 7cd1afad10d981cbf4a0c8738bf7f5c0add0e50f:
	Make hard_irq_disable() actually hard-disable interrupts

- commit 9a5a0b80cf7e09bd6fadf1a66f27579d0f6d2795, required to run 32-bit
  guests on e5500 cores:
	powerpc/e5500: Set r5 to point to cpu spec in setup_cpu_e5500()

- commit 6c04342ba5ad7723d8b07d2ad4800607c0985c35, required to run 64-bit
  SMP guests:
	KVM: PPC: bookehv64: Add support for std/ld emulation

This patchset requires a qemu with e5500 support. For a ready to use git tree,
please check here:

  git://repo.or.cz/qemu/agraf.git ppc-e5500

To use qemu run:

  $ qemu-system-ppc64 -M mpc8544ds -cpu e5500 -nographic -kernel uImage \
    -machine dt_compatible=fsl,,P5020DS

Mike

Mihai Caraman (17):
  KVM: PPC64: booke: Set interrupt computation mode for 64-bit host
  KVM: PPC64: booke: Add EPCR support in mtspr/mfspr emulation
  KVM: PPC64: booke: Add EPCR support in sregs
  KVM: PPC64: booke: Add guest computation mode for irq delivery
  KVM: PPC: booke: Extend MAS2 EPN mask for 64-bit
  KVM: PPC: e500: Add emulation helper for getting instruction ea
  KVM: PPC: e500: Mask ea's high 32-bits in 32/64 instr emulation
  KVM: PPC: e500mc: Fix tlbilx emulation for 64-bit guests
  KVM: PPC64: booke: Hard disable interrupts when entering guest
  PowerPC: booke64: Refactor exception prolog for save/restore regs
  PowerPC: booke64: Fix machine check handler to use the right prolog
  PowerPC: booke64: Add DO_KVM kernel hooks
  PowerPC: booke64: Use SPRG0/3 scratch for bolted TLB miss & crit int
  KVM: PPC32: bookehv: Remove GET_VCPU macro from exception handler
  KVM: PPC64: bookehv: Add support for interrupt handling
  KVM: PPC: e500: Silence bogus GCC warning in tlb code
  KVM: PPC: booke: Fix get_tb() compile error on 64-bit

 arch/powerpc/include/asm/exception-64e.h    |   14 ++--
 arch/powerpc/include/asm/kvm_booke_hv_asm.h |   12 +++-
 arch/powerpc/include/asm/mmu-book3e.h       |    2 +-
 arch/powerpc/include/asm/reg.h              |    6 +-
 arch/powerpc/kernel/exceptions-64e.S        |  127 ++++++++++++++++++---------
 arch/powerpc/kvm/booke.c                    |   49 +++++++++--
 arch/powerpc/kvm/booke.h                    |    6 ++
 arch/powerpc/kvm/booke_emulate.c            |   13 +++-
 arch/powerpc/kvm/bookehv_interrupts.S       |  127 ++++++++++++++++++++++++---
 arch/powerpc/kvm/e500.h                     |    8 +-
 arch/powerpc/kvm/e500_emulate.c             |   26 +++++-
 arch/powerpc/kvm/e500_tlb.c                 |   28 ++----
 arch/powerpc/kvm/e500mc.c                   |    8 ++-
 arch/powerpc/mm/tlb_low_64e.S               |   42 +++++----
 14 files changed, 347 insertions(+), 121 deletions(-)

-- 
1.7.4.1
