Return-Path: <Minghuan.Lian@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A0EA62C0090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 21:54:00 +1100 (EST)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][v2] powerpc/pci: Fix IMMRBAR address
Date: Mon, 20 Jan 2014 18:54:20 +0800
Message-ID: <1390215260-28888-1-git-send-email-Minghuan.Lian@freescale.com>
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
Change log:
v2:
Use PCI_BASE_ADDRESS_MEM_MASK instead of 0xfffffff0

 arch/powerpc/sysdev/fsl_pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4dfd61d..252716d 100644
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
+		base &= PCI_BASE_ADDRESS_MEM_MASK;
+
 		return base;
 	}
 #endif
-- 
1.8.1.2
