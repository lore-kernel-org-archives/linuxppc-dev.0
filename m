Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWWcT0BHMzDqCp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 06:11:52 +1000 (AEST)
Subject: [PATCH v1 0/4] PCI: pci_resource_to_user() cleanups
To: Michal Simek <monstr@monstr.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Yinghai Lu <yinghai@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: sparclinux@vger.kernel.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Date: Fri, 17 Jun 2016 15:11:47 -0500
Message-ID: <20160617195835.11714.18657.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The /sys/devices/pci.../.../resource and /proc/bus/pci/devices files
contain PCI BAR addresses.  On most architectures these addresses are
"resource" values, e.g., CPU physical memory addresses or Linux I/O port
numbers.  These may be offset from the raw PCI values if there are multiple
PCI host bridges.

On others (microblaze, mips, powerpc, sparc) they are raw PCI values as
they would appear on the PCI bus.  pci_resource_to_user() converts from the
struct resource to whatever the arch wants to expose.  It's a no-op on
most arches.

The PCI core provides a pcibios_resource_to_bus() function that converts
from struct resource values to raw PCI bus values.  These patches use that
when possible instead of the arch-specific hand-coded equivalent.

These shouldn't fix or break anything unless I've made a mistake.

---

Bjorn Helgaas (4):
      PCI: Unify pci_resource_to_user() declarations
      microblaze/PCI: Implement pci_resource_to_user() with pcibios_resource_to_bus()
      powerpc/pci: Implement pci_resource_to_user() with pcibios_resource_to_bus()
      sparc/PCI: Implement pci_resource_to_user() with pcibios_resource_to_bus()


 arch/microblaze/include/asm/pci.h |    3 ---
 arch/microblaze/pci/pci-common.c  |   42 ++++++++++++-------------------------
 arch/mips/include/asm/pci.h       |   10 ---------
 arch/mips/pci/pci.c               |   10 +++++++++
 arch/powerpc/include/asm/pci.h    |    3 ---
 arch/powerpc/kernel/pci-common.c  |   42 ++++++++++++-------------------------
 arch/sparc/include/asm/pci_64.h   |    3 ---
 arch/sparc/kernel/pci.c           |   20 ++++++++++--------
 include/linux/pci.h               |    6 ++++-
 9 files changed, 54 insertions(+), 85 deletions(-)
