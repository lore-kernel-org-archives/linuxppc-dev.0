Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 60271DDDF7
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 14:10:58 +1000 (EST)
Date: Wed, 3 Jun 2009 14:10:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fix warning when printing a resource_size_t
Message-Id: <20090603141057.b8835f62.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

resource_size_t is 64 bits on PowerPC 64.

Gets rid of this warning:

arch/powerpc/kernel/pci_64.c: In function 'pcibios_map_io_space':
arch/powerpc/kernel/pci_64.c:504: warning: format '%016lx' expects type 'long unsigned int', but argument 2 has type 'resource_size_t'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/pci_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index dd6c7a3..a165fec 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -501,7 +501,7 @@ int __devinit pcibios_map_io_space(struct pci_bus *bus)
 	pr_debug("IO mapping for PHB %s\n", hose->dn->full_name);
 	pr_debug("  phys=0x%016llx, virt=0x%p (alloc=0x%p)\n",
 		 hose->io_base_phys, hose->io_base_virt, hose->io_base_alloc);
-	pr_debug("  size=0x%016lx (alloc=0x%016lx)\n",
+	pr_debug("  size=0x%016llx (alloc=0x%016lx)\n",
 		 hose->pci_io_size, size_page);
 
 	/* Establish the mapping */
-- 
1.6.3.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
