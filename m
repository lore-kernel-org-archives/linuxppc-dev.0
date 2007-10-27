Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out2.tiscali.nl (smtp-out2.tiscali.nl [195.241.79.177])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F368BDDEE1
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 00:27:42 +1000 (EST)
Received: from [82.171.216.234] (helo=[192.168.1.2])
	by smtp-out2.tiscali.nl with esmtp (Tiscali http://www.tiscali.nl)
	id 1IlmOG-0001Eh-Nb
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 16:11:52 +0200
Message-ID: <47234726.3010809@tiscali.nl>
Date: Sat, 27 Oct 2007 16:11:50 +0200
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Free when ioremap fails in
	powerpc/platforms/52xx/mpc52xx_pci.c
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Free hose when ioremap fails

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 4c6c82a..50f9655 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -395,8 +395,10 @@ mpc52xx_add_bridge(struct device_node *node)
 	hose->ops = &mpc52xx_pci_ops;
 
 	pci_regs = ioremap(rsrc.start, rsrc.end - rsrc.start + 1);
-	if (!pci_regs)
+	if (!pci_regs) {
+		pcibios_free_controller(hose);
 		return -ENOMEM;
+	}
 
 	pci_process_bridge_OF_ranges(hose, node, 1);
 
