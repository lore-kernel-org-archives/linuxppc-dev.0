Return-Path: <mihai.caraman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9CCE1A046A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 02:06:37 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH v6 0/5] Read guest last instruction from kvmppc_get_last_inst()
Date: Wed, 23 Jul 2014 19:06:17 +0300
Message-ID: <1406131582-6052-1-git-send-email-mihai.caraman@freescale.com>
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

Read guest last instruction from kvmppc_get_last_inst() allowing the function
to fail in order to emulate again. On bookehv architecture search for
the physical address and kmap it, instead of using Load External PID (lwepx)
instruction. This fixes an infinite loop caused by lwepx's data TLB miss
exception handled in the host and the TODO for execute-but-not-read entries
and TLB eviction.

Mihai Caraman (5):
  KVM: PPC: e500mc: Revert "add load inst fixup"
  KVM: PPC: Book3e: Add TLBSEL/TSIZE defines for MAS0/1
  KVM: PPC: Book3s: Remove kvmppc_read_inst() function
  KVM: PPC: Alow kvmppc_get_last_inst() to fail
  KVM: PPC: Bookehv: Get vcpu's last instruction for emulation

 arch/powerpc/include/asm/kvm_book3s.h    |  26 -------
 arch/powerpc/include/asm/kvm_booke.h     |   5 --
 arch/powerpc/include/asm/kvm_ppc.h       |  31 +++++++++
 arch/powerpc/include/asm/mmu-book3e.h    |   9 ++-
 arch/powerpc/kvm/book3s.c                |  17 +++++
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  17 ++---
 arch/powerpc/kvm/book3s_paired_singles.c |  38 +++++++----
 arch/powerpc/kvm/book3s_pr.c             | 114 ++++++++++++++++---------------
 arch/powerpc/kvm/booke.c                 |  47 +++++++++++++
 arch/powerpc/kvm/bookehv_interrupts.S    |  55 ++-------------
 arch/powerpc/kvm/e500_mmu_host.c         |  98 ++++++++++++++++++++++++++
 arch/powerpc/kvm/emulate.c               |  18 +++--
 arch/powerpc/kvm/powerpc.c               |  11 ++-
 13 files changed, 314 insertions(+), 172 deletions(-)

-- 
1.7.11.7
