Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 47D7A2C030D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 20:12:13 +1100 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Add platform_device declaration to fsl_pci.h
Date: Mon, 4 Mar 2013 16:40:09 +0800
Message-ID: <1362386409-15907-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: B07421@freescale.com, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc85xx_pci_err_probe(struct platform_device *op) need platform_device
declaration for definition. Otherwise, it will cause compile error if any
files including fsl_pci.h without declaration of platform_device.

Signed-off-by: Jia Hongtao <B38951@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index c495c00..df66721 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -14,6 +14,8 @@
 #ifndef __POWERPC_FSL_PCI_H
 #define __POWERPC_FSL_PCI_H
 
+#include <linux/platform_device.h>
+
 #define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status */
 #define PCIE_LTSSM_L0	0x16		/* L0 state */
 #define PCIE_IP_REV_2_2		0x02080202 /* PCIE IP block version Rev2.2 */
-- 
1.7.5.1
