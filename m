Return-Path: <B02008@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D44E2C00EA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 20:08:18 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH 0/8 v3] KVM: PPC: e500: Enable FSL e6500 core
Date: Thu, 11 Apr 2013 13:03:06 +0300
Message-ID: <1365674594-17410-1-git-send-email-mihai.caraman@freescale.com>
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

Enable basic support for Freescale e6500 core, adding MAV 2.0 support.
Validated on T4240QDS platfrom. Altivec, Multithreading and HW Tablewalk
are not addressed by this patchset.

Mihai Caraman (8):
  KVM: PPC: Book3E: Refactor ONE_REG ioctl implementation
  KVM: PPC: e500: Expose MMU registers via ONE_REG
  KVM: PPC: e500: Move vcpu's MMU configuration to dedicated functions
  KVM: PPC: e500: Add support for TLBnPS registers
  KVM: PPC: e500: Add support for EPTCFG register
  KVM: PPC: e500: Remove E.PT and E.HV.LRAT categories from VCPUs
  KVM: PPC: e500mc: Enable e6500 cores
  KVM: PPC: e500: Add e6500 core to Kconfig description

 Documentation/virtual/kvm/api.txt   |   16 +++
 arch/powerpc/include/asm/kvm_host.h |    2 +
 arch/powerpc/include/uapi/asm/kvm.h |   22 ++++
 arch/powerpc/kvm/44x.c              |   12 ++
 arch/powerpc/kvm/Kconfig            |    6 +-
 arch/powerpc/kvm/booke.c            |  102 ++++++++++---------
 arch/powerpc/kvm/e500.c             |   14 +++
 arch/powerpc/kvm/e500.h             |   22 ++++
 arch/powerpc/kvm/e500_emulate.c     |   19 ++++
 arch/powerpc/kvm/e500_mmu.c         |  192 +++++++++++++++++++++++++++++++----
 arch/powerpc/kvm/e500mc.c           |   16 +++
 11 files changed, 351 insertions(+), 72 deletions(-)

-- 
1.7.4.1
