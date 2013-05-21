Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C0EAC2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2013 13:24:45 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r4L3Of0L000342
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2013 22:24:42 -0500
Message-ID: <1369106679.6387.36.camel@pasglop>
Subject: [PATCH] powerpc/pci: Fix bogus message at boot about empty memory
 resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 21 May 2013 13:24:39 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The message is only meant to be displayed if resource 0 is empty,
but was displayed if any is.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/pci-common.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 6053f03..e9acf50 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1520,9 +1520,10 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
 	for (i = 0; i < 3; ++i) {
 		res = &hose->mem_resources[i];
 		if (!res->flags) {
-			printk(KERN_ERR "PCI: Memory resource 0 not set for "
-			       "host bridge %s (domain %d)\n",
-			       hose->dn->full_name, hose->global_number);
+			if (i == 0)
+				printk(KERN_ERR "PCI: Memory resource 0 not set for "
+				       "host bridge %s (domain %d)\n",
+				       hose->dn->full_name, hose->global_number);
 			continue;
 		}
 		offset = hose->mem_offset[i];
