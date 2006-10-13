Return-Path: <anton@ozlabs.org>
Date: Fri, 13 Oct 2006 12:26:57 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Check for offline nodes in pci NUMA code
Message-ID: <20061013022657.GD16029@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


During boot we bring up all memory and cpu nodes. Normally a PCI device
will be in one of these online nodes, however in some weird setups it
may not.

We have only seen this in the lab but we may as well check for the case
and fallback to -1 (all nodes).

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/pci_64.c
===================================================================
--- build.orig/arch/powerpc/kernel/pci_64.c	2006-10-08 01:18:30.000000000 +1000
+++ build/arch/powerpc/kernel/pci_64.c	2006-10-08 01:23:05.000000000 +1000
@@ -199,8 +199,14 @@ struct pci_controller * pcibios_alloc_co
 	pci_setup_pci_controller(phb);
 	phb->arch_data = dev;
 	phb->is_dynamic = mem_init_done;
-	if (dev)
-		PHB_SET_NODE(phb, of_node_to_nid(dev));
+	if (dev) {
+		int nid = of_node_to_nid(dev);
+
+		if (nid < 0 || !node_online(nid))
+			nid = -1;
+
+		PHB_SET_NODE(phb, nid);
+	}
 	return phb;
 }
 
