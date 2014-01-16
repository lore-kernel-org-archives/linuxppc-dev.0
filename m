Return-Path: <Minghuan.Lian@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 17CE72C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 19:14:49 +1100 (EST)
Received: from mail49-tx2 (localhost [127.0.0.1])	by mail49-tx2-R.bigfish.com
 (Postfix) with ESMTP id 484DC4E0251	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 16 Jan 2014 08:14:29 +0000 (UTC)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/pci: Fix IMMRBAR address
Date: Thu, 16 Jan 2014 16:14:51 +0800
Message-ID: <1389860091-32754-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For PEXCSRBAR, bit 3-0 indicate prefetchable and address type.
So when getting base address, these bits should be masked,
otherwise we may get incorrect base address.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4dfd61d..44eae39 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -868,6 +868,14 @@ u64 fsl_pci_immrbar_base(struct pci_controller *hose)
 
 		pci_bus_read_config_dword(hose->bus,
 			PCI_DEVFN(0, 0), PCI_BASE_ADDRESS_0, &base);
+
+		/*
+		 * For PEXCSRBAR, bit 3-0 indicate prefetchable and
+		 * address type. So when getting base address, these
+		 * bits should be masked
+		 */
+		base &= 0xfffffff0;
+
 		return base;
 	}
 #endif
-- 
1.8.1.2
