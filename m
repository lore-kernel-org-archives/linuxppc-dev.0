Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSpl5hXmzDr0c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:26:23 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdSpj72rNz9t1M
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2016 22:26:21 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 16/17] powerpc/pci: Reduce log level of PCI I/O space warning
Date: Mon, 27 Jun 2016 22:25:32 +1000
Message-Id: <1467030333-31435-17-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
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
 
-- 
2.7.4
