Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CAEF810086D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Jul 2010 23:04:26 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 0/7] Rest of my KVM-PPC patch queue
Date: Thu, 29 Jul 2010 15:04:15 +0200
Message-Id: <1280408662-10328-1-git-send-email-agraf@suse.de>
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

During the past few weeks a couple of fixes have gathered in my queue. This
is a dump of everything that is not related to the PV framework.

Please apply on top of the PV stuff.

Alexander Graf (6):
  KVM: PPC: Book3S_32 MMU debug compile fixes
  KVM: PPC: RCU'ify the Book3s MMU
  KVM: PPC: Add book3s_32 tlbie flush acceleration
  KVM: PPC: Use MSR_DR for external load_up
  KVM: PPC: Make long relocations be ulong
  KVM: PPC: Move KVM trampolines before __end_interrupts

Gleb Natapov (1):
  KVM: PPC: correctly check gfn_to_pfn() return value

 arch/powerpc/include/asm/kvm_book3s.h |    4 +-
 arch/powerpc/include/asm/kvm_host.h   |    6 ++
 arch/powerpc/kernel/exceptions-64s.S  |    6 ++
 arch/powerpc/kernel/head_64.S         |    6 --
 arch/powerpc/kvm/book3s_32_mmu.c      |    4 +-
 arch/powerpc/kvm/book3s_32_mmu_host.c |    2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c |    2 +-
 arch/powerpc/kvm/book3s_mmu_hpte.c    |  118 ++++++++++++++++++++++++++-------
 arch/powerpc/kvm/book3s_rmhandlers.S  |   32 ++++++---
 9 files changed, 133 insertions(+), 47 deletions(-)
