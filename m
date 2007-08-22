Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6741BDDE04
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 10:17:54 +1000 (EST)
Date: Tue, 21 Aug 2007 19:18:00 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Please pull from 'fixes-2.6.23' branch
Message-ID: <Pine.LNX.4.64.0708211917250.14411@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'fixes-2.6.23' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git fixes-2.6.23

to receive the following updates:

 arch/powerpc/sysdev/fsl_pci.c |    2 ++
 include/linux/pci_ids.h       |    6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

Kumar Gala (1):
      [POWERPC] Fix PCI Device ID for MPC8544/8533 processors

commit 15f6ddc7d9cf96f2ee88897c7164198ed6e45a77
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Tue Aug 21 19:15:31 2007 -0500

    [POWERPC] Fix PCI Device ID for MPC8544/8533 processors

    The initial user manuals for MPC8544/8533 had some issues with properly
    documenting the device IDs for MPC8544/8533.  These processors are almost
    identical and both show up on the reference boards.

    Fix up the quirks for PCIe support to handle MPC8533/E.

    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 9fb0ce5..114c90f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -251,6 +251,8 @@ DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8568E, quirk_fsl_pcie_transpare
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8568, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8567E, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8567, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8533E, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8533, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8544E, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8544, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8641, quirk_fsl_pcie_transparent);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 07fc574..8938d59 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2092,8 +2092,10 @@
 #define PCI_DEVICE_ID_MPC8568		0x0021
 #define PCI_DEVICE_ID_MPC8567E		0x0022
 #define PCI_DEVICE_ID_MPC8567		0x0023
-#define PCI_DEVICE_ID_MPC8544E		0x0030
-#define PCI_DEVICE_ID_MPC8544		0x0031
+#define PCI_DEVICE_ID_MPC8533E		0x0030
+#define PCI_DEVICE_ID_MPC8533		0x0031
+#define PCI_DEVICE_ID_MPC8544E		0x0032
+#define PCI_DEVICE_ID_MPC8544		0x0033
 #define PCI_DEVICE_ID_MPC8641		0x7010
 #define PCI_DEVICE_ID_MPC8641D		0x7011
