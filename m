Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A43D81A0206
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 16:05:03 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH] powerpc/pseries: Quieten ibm,pcie-link-speed-stats warning
Date: Fri, 31 Oct 2014 16:05:01 +1100
Message-Id: <1414731901-2096-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ibm,pcie-link-speed-stats isn't mandatory, so we shouldn't print
a high priority error message when missing. One example where we see
this is QEMU.

Reduce it to pr_info.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/pseries/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 67e4859..57dd7a0 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -134,7 +134,7 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
 	of_node_put(pdn);
 
 	if (rc) {
-		pr_err("no ibm,pcie-link-speed-stats property\n");
+		pr_info("no ibm,pcie-link-speed-stats property\n");
 		return 0;
 	}
 
-- 
1.9.1
