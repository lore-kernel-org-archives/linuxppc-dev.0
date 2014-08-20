Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77F011A0197
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 23:36:46 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH v4 0/6] KVM: PPC: Book3e: AltiVec support
Date: Wed, 20 Aug 2014 16:36:21 +0300
Message-ID: <1408541787-24625-1-git-send-email-mihai.caraman@freescale.com>
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

Add KVM Book3e AltiVec support.

Changes:

v4:
 - use CONFIG_SPE_POSSIBLE and a new ifdef for CONFIG_ALTIVEC
 - remove SPE handlers from bookehv
 - split ONE_REG powerpc generic and ONE_REG AltiVec
 - add setters for IVPR, IVOR2 and IVOR8
 - add api documentation for ONE_REG IVPR and IVORs
 - don't enable e6500 core since hardware threads are not yet supported

v3:
 - use distinct SPE/AltiVec exception handlers
 - make ONE_REG AltiVec support powerpc generic
 - add ONE_REG IVORs support

 v2:
 - integrate Paul's FP/VMX/VSX changes that landed in kvm-ppc-queue
   in January and take into account feedback

Mihai Caraman (6):
  KVM: PPC: Book3E: Increase FPU laziness
  KVM: PPC: Book3e: Add AltiVec support
  KVM: PPC: Make ONE_REG powerpc generic
  KVM: PPC: Move ONE_REG AltiVec support to powerpc
  KVM: PPC: Booke: Add setter functions for IVPR, IVOR2 and IVOR8
    emulation
  KVM: PPC: Booke: Add ONE_REG support for IVPR and IVORs

 Documentation/virtual/kvm/api.txt     |   7 +
 arch/powerpc/include/uapi/asm/kvm.h   |  30 +++
 arch/powerpc/kvm/book3s.c             | 151 ++++----------
 arch/powerpc/kvm/booke.c              | 371 ++++++++++++++++++++++++++++------
 arch/powerpc/kvm/booke.h              |  43 +---
 arch/powerpc/kvm/booke_emulate.c      |  15 +-
 arch/powerpc/kvm/bookehv_interrupts.S |   9 +-
 arch/powerpc/kvm/e500.c               |  42 +++-
 arch/powerpc/kvm/e500_emulate.c       |  20 ++
 arch/powerpc/kvm/e500mc.c             |  18 +-
 arch/powerpc/kvm/powerpc.c            |  97 +++++++++
 11 files changed, 576 insertions(+), 227 deletions(-)

-- 
1.7.11.7
