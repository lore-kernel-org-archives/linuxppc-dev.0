Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10CB61A000E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 00:45:47 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [RFC PATCH 0/4] KVM Book3E support for HTW guests
Date: Thu, 3 Jul 2014 17:45:23 +0300
Message-ID: <1404398727-12844-1-git-send-email-mihai.caraman@freescale.com>
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

KVM Book3E support for Hardware Page Tablewalk enabled guests.

Mihai Caraman (4):
  powerpc/booke64: Add LRAT next and max entries to tlb_core_data
    structure
  KVM: PPC: Book3E: Handle LRAT error exception
  KVM: PPC: e500: TLB emulation for IND entries
  KVM: PPC: e500mc: Advertise E.PT to support HTW guests

 arch/powerpc/include/asm/kvm_host.h   |   1 +
 arch/powerpc/include/asm/kvm_ppc.h    |   2 +
 arch/powerpc/include/asm/mmu-book3e.h |  12 +++
 arch/powerpc/include/asm/reg_booke.h  |  14 +++
 arch/powerpc/kernel/asm-offsets.c     |   1 +
 arch/powerpc/kvm/booke.c              |  40 +++++++++
 arch/powerpc/kvm/bookehv_interrupts.S |   9 +-
 arch/powerpc/kvm/e500.h               |  81 ++++++++++++++----
 arch/powerpc/kvm/e500_mmu.c           |  84 ++++++++++++++----
 arch/powerpc/kvm/e500_mmu_host.c      | 156 +++++++++++++++++++++++++++++++++-
 arch/powerpc/kvm/e500mc.c             |  55 +++++++++++-
 arch/powerpc/mm/fsl_booke_mmu.c       |   8 ++
 12 files changed, 423 insertions(+), 40 deletions(-)

-- 
1.7.11.7
