Return-Path: <B41889@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B8A482C008A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 17:36:01 +1000 (EST)
From: Yuanquan Chen <Yuanquan.Chen@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/pci: fix PCI-e check link issue
Date: Fri, 17 May 2013 15:35:29 +0800
Message-ID: <1368776129-21249-1-git-send-email-Yuanquan.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>, r61911@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For Freescale powerpc platform, the PCI-e bus number uses the reassign mode
by default. It means the second PCI-e controller's hose->first_busno is the
first controller's last bus number adding 1. For some hotpluged device(or
controlled by FPGA), the device is linked to PCI-e slot at linux runtime.
It needs rescan for the system to add it and driver it to work. It successes
to rescan the device linked to the first PCI-e controller's slot, but fails to
rescan the device linked to the second PCI-e controller's slot. The cause is
that the bus->number is reset to 0, which isn't equal to the hose->first_busno
for the second controller checking PCI-e link. So it doesn't really check the
PCI-e link status, the link status is always no_link. The device won't be
really rescaned. Reset the bus->number to hose->first_busno in the function
fsl_pcie_check_link(), it will do the real checking PCI-e link status for the
second controller, the device will be rescaned.

Signed-off-by: Yuanquan Chen <Yuanquan.Chen@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 028ac1f..534597a 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -64,7 +64,7 @@ static int fsl_pcie_check_link(struct pci_controller *hose)
 	if (hose->indirect_type & PPC_INDIRECT_TYPE_FSL_CFG_REG_LINK) {
 		if (hose->ops->read == fsl_indirect_read_config) {
 			struct pci_bus bus;
-			bus.number = 0;
+			bus.number = hose->first_busno;
 			bus.sysdata = hose;
 			bus.ops = hose->ops;
 			indirect_read_config(&bus, 0, PCIE_LTSSM, 4, &val);
-- 
1.7.9.5
