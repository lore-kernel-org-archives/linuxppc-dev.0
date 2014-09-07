Return-Path: <agordeev@dhcp-27-160.brq.redhat.com>
Received: from dhcp-27-160.brq.redhat.com (unknown [89.24.186.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC15D1A090E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Sep 2014 14:27:42 +1000 (EST)
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] PCI/MSI: Remove arch_msi_check_device()
Date: Sun,  7 Sep 2014 20:57:52 +0200
Message-Id: <cover.1410078503.git.agordeev@redhat.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
 Alexander Gordeev <agordeev@redhat.com>, linux-pci@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This is a cleanup effort to get rid of arch_msi_check_device() function.

I am sending v2 series, since kbuild for v1 reports compile errors on
ppc4xx and Armada 370. Still, I have not checked the fixes on these
platforms.

Changes since v1:
  - patch 1: 'pdev' undeclared compile error fixed on ppc4xx. I updated
             changelog and removed ACK from this patch in case there are
             any objections;

  - patch 2: 'struct msi_chip' has no 'check_device' error fixed on
             Armada 370 - armada_370_xp_check_msi_device() hook removed;

  - patch 3: msi_check_device() renamed to pci_msi_supported(). This is
             the very same patch I sent earlier;

Thanks!

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org

Alexander Gordeev (3):
  patch 1 - PCI/MSI/PPC: Remove arch_msi_check_device()
  patch 2 - PCI/MSI/Armada-370-xp: Remove arch_msi_check_device()
  patch 3 - PCI/MSI: Remove arch_msi_check_device()

 arch/powerpc/include/asm/machdep.h     |  2 --
 arch/powerpc/kernel/msi.c              | 12 +--------
 arch/powerpc/platforms/cell/axon_msi.c |  9 -------
 arch/powerpc/platforms/powernv/pci.c   | 19 ++++---------
 arch/powerpc/platforms/pseries/msi.c   | 42 +++++++++++------------------
 arch/powerpc/sysdev/fsl_msi.c          | 12 +++------
 arch/powerpc/sysdev/mpic_pasemi_msi.c  | 11 ++------
 arch/powerpc/sysdev/mpic_u3msi.c       | 28 ++++++++-----------
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c  | 18 +++++--------
 arch/powerpc/sysdev/ppc4xx_msi.c       | 19 +++++--------
 drivers/irqchip/irq-armada-370-xp.c    | 14 +++-------
 drivers/pci/msi.c                      | 49 +++++++++-------------------------
 include/linux/msi.h                    |  3 ---
 13 files changed, 67 insertions(+), 171 deletions(-)

-- 
1.9.3
