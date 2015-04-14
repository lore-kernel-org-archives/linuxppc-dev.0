Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 238B71A0176
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 14:28:19 +1000 (AEST)
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 710831402A8
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2015 14:28:17 +1000 (AEST)
Received: by pabtp1 with SMTP id tp1so124798933pab.2
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Apr 2015 21:28:15 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 00/10] Move MSI related PCI controller ops to
 pci_controller_ops
Date: Tue, 14 Apr 2015 14:27:53 +1000
Message-Id: <1428985683-24767-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set moves MSI related PCI controller operations out of
ppc_md and into the pci_controller_ops struct.

This is a follow up to the previous patch series creating the
pci_controller_ops structure. [1]

This series follows the same structure:

 - Add functions to pci_controller_ops struct, patch call sites to
   call struct functions if available, in preference to ppc_md
   funtions.

 - Move affected platforms and subsystems over one by one.

 - Remove shims, remove from ppc_md.

The set has been build tested for PowerNV, pseries, Cell, PaSemi,
ppc44x and Corenet 64 (for fsl_pci). It builds at every point in the
series. It has been boot-tested on pseries.

It depends on my previous patch series. As such, it is based on
today's linux-next.

[1] https://lkml.kernel.org/r/1427778057-9505-1-git-send-email-dja@axtens.net

Daniel Axtens (10):
  powerpc: Add MSI operations to pci_controller_ops struct
  powerpc/powernv: Move MSI-related ops to pci_controller_ops
  powerpc/cell: Move MSI-related ops to pci_controller_ops
  powerpc/pseries: Move MSI-related ops to pci_controller_ops
  powerpc/fsl_msi: Move MSI-related ops to pci_controller_ops
  powerpc/ppc4xx_msi: Move MSI-related ops to pci_controller_ops
  powerpc/ppc4xx_hsta_msi: Move MSI-related ops to pci_controller_ops
  powerpc/mpic_pasemi_msi: Move MSI-related ops to pci_controller_ops
  powerpc/mpic_u3msi: Move MSI-related ops to pci_controller_ops
  powerpc: Remove MSI-related PCI controller ops from ppc_md

 arch/powerpc/include/asm/machdep.h     |  6 ------
 arch/powerpc/include/asm/pci-bridge.h  |  6 ++++++
 arch/powerpc/kernel/msi.c              | 11 ++++++++---
 arch/powerpc/platforms/cell/axon_msi.c |  5 +++--
 arch/powerpc/platforms/powernv/pci.c   | 10 ++++------
 arch/powerpc/platforms/pseries/msi.c   |  8 +++++---
 arch/powerpc/sysdev/fsl_msi.c          | 23 +++++++++++++++--------
 arch/powerpc/sysdev/mpic_pasemi_msi.c  |  9 ++++++---
 arch/powerpc/sysdev/mpic_u3msi.c       |  9 ++++++---
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c  |  7 +++++--
 arch/powerpc/sysdev/ppc4xx_msi.c       |  7 +++++--
 11 files changed, 63 insertions(+), 38 deletions(-)

-- 
2.1.4
