Return-Path: <mihai.caraman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1773B1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 01:35:11 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 0/6 v2] KVM: PPC: Book3e: AltiVec support
Date: Mon, 30 Jun 2014 18:34:51 +0300
Message-ID: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
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

Add KVM Book3E AltiVec support and enable e6500 core.

Integrates Paul's FP/VMX/VSX changes that landed in kvm-ppc-queue in January
and take into account feedback.

Mihai Caraman (6):
  KVM: PPC: Book3E: Use common defines for SPE/FP/AltiVec int numbers
  KVM: PPC: Book3E: Refactor SPE/FP exit handling
  KVM: PPC: Book3E: Increase FPU laziness
  KVM: PPC: Book3E: Add AltiVec support
  KVM: PPC: Book3E: Add ONE_REG AltiVec support
  KVM: PPC: Book3E: Enable e6500 core

 arch/powerpc/include/asm/kvm_asm.h    |   8 --
 arch/powerpc/include/uapi/asm/kvm.h   |   5 +
 arch/powerpc/kvm/booke.c              | 238 ++++++++++++++++++++++++++++------
 arch/powerpc/kvm/booke.h              |  38 +-----
 arch/powerpc/kvm/booke_interrupts.S   |   9 +-
 arch/powerpc/kvm/bookehv_interrupts.S |   4 +-
 arch/powerpc/kvm/e500.c               |  10 +-
 arch/powerpc/kvm/e500_emulate.c       |  10 +-
 arch/powerpc/kvm/e500mc.c             |  12 +-
 9 files changed, 232 insertions(+), 102 deletions(-)

-- 
1.7.11.7
