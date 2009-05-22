Return-Path: <tony@bakeyournoodle.com>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7EA00DE1E4
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 13:32:46 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <d9509d4f228388a6c4606eedbd72436322e38b71.1242963165.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 1/1] Remove __devinit annotation from pcibios_claim_one_bus()
Date: Fri, 22 May 2009 13:32:45 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pcibios_finish_adding_to_bus() is NOT annotated __devinit but it calls
pcibios_claim_one_bus().  pcibios_finish_adding_to_bus() is called from
at least the rpadlpar code which also is NOT annotated __devinit.

The annotation seems bogus so remove it.

Found by Jeremy Huddleston a reported at:
	http://bugzilla.kernel.org/show_bug.cgi?id=13228

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/kernel/pci-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0f41812..a9f988f 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1469,7 +1469,7 @@ void __init pcibios_resource_survey(void)
  * rest of the code later, for now, keep it as-is as our main
  * resource allocation function doesn't deal with sub-trees yet.
  */
-void __devinit pcibios_claim_one_bus(struct pci_bus *bus)
+void pcibios_claim_one_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 	struct pci_bus *child_bus;
-- 
1.6.0.6
