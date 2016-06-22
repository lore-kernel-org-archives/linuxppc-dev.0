Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZGKH48c8zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 17:23:15 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u5M7N7xm013502
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 02:23:08 -0500
Message-ID: <1466580187.4089.23.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/pci: Reduce log level of PCI I/O space warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 22 Jun 2016 17:23:07 +1000
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

If a PHB has no I/O space, there's no need to make it look like
something bad happened, a pr_debug() is plenty enough since this
is the case of all our modern POWER chips.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/pci-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 2a67b16..3ab1f7b 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1487,9 +1487,9 @@ static void pcibios_setup_phb_resources(struct pci_controller *hose,
 	res = &hose->io_resource;
 
 	if (!res->flags) {
-		pr_info("PCI: I/O resource not set for host"
-		       " bridge %s (domain %d)\n",
-		       hose->dn->full_name, hose->global_number);
+		pr_debug("PCI: I/O resource not set for host"
+			 " bridge %s (domain %d)\n",
+			 hose->dn->full_name, hose->global_number);
 	} else {
 		offset = pcibios_io_space_offset(hose);
 
