Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBgZk1NXNzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 18:12:45 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc: Add support for non-PCI ISA bridges
Date: Mon, 30 Jan 2017 18:11:56 +1100
Message-Id: <20170130071157.22677-2-benh@kernel.crashing.org>
In-Reply-To: <20170130071157.22677-1-benh@kernel.crashing.org>
References: <20170130071157.22677-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The POWER9 chip supports an LPC bus that isn't hanging
off a PCI bus, so let's add support for that, mapping it
to the reserved space at ISA_IO_BASE

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/isa-bridge.h |  1 +
 arch/powerpc/kernel/isa-bridge.c      | 91 +++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/arch/powerpc/include/asm/isa-bridge.h b/arch/powerpc/include/asm/isa-bridge.h
index 94d9c1c..a3a7c1d 100644
--- a/arch/powerpc/include/asm/isa-bridge.h
+++ b/arch/powerpc/include/asm/isa-bridge.h
@@ -4,6 +4,7 @@
 #ifdef CONFIG_PPC64
 
 extern void isa_bridge_find_early(struct pci_controller *hose);
+extern void isa_bridge_init_non_pci(struct device_node *np);
 
 static inline int isa_vaddr_is_ioport(void __iomem *address)
 {
diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index c898ff0..bb6f899 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -168,6 +168,97 @@ void __init isa_bridge_find_early(struct pci_controller *hose)
 }
 
 /**
+ * isa_bridge_find_early - Find and map the ISA IO space early before
+ *                         main PCI discovery. This is optionally called by
+ *                         the arch code when adding PCI PHBs to get early
+ *                         access to ISA IO ports
+ */
+void __init isa_bridge_init_non_pci(struct device_node *np)
+{
+	const __be32 *ranges, *pbasep = NULL;
+	int rlen, i, rs;
+	u32 na, ns, pna;
+	u64 cbase, pbase, size = 0;
+
+	/* If we already have an ISA bridge, bail off */
+	if (isa_bridge_devnode != NULL)
+		return;
+
+	pna = of_n_addr_cells(np);
+	if (of_property_read_u32(np, "#address-cells", &na) ||
+	    of_property_read_u32(np, "#size-cells", &ns)) {
+		pr_warn("ISA: Non-PCI bridge %s is missing address format\n",
+			np->full_name);
+		return;
+	}
+
+	/* Check it's a supported address format */
+	if (na != 2 || ns != 1) {
+		pr_warn("ISA: Non-PCI bridge %s has unsupported address format\n",
+			np->full_name);
+		return;
+	}
+	rs = na + ns + pna;
+
+	/* Grab the ranges property */
+	ranges = of_get_property(np, "ranges", &rlen);
+	if (ranges == NULL || rlen < rs) {
+		pr_warn("ISA: Non-PCI bridge %s has absent or invalid ranges\n",
+			np->full_name);
+		return;
+	}
+
+	/* Parse it. We are only looking for IO space */
+	for (i = 0; (i + rs - 1) < rlen; i += rs) {
+		if (be32_to_cpup(ranges + i) != 1)
+			continue;
+		cbase = be32_to_cpup(ranges + i + 1);
+		size = of_read_number(ranges + i + na + pna, ns);
+		pbasep = ranges + i + na;
+		break;
+	}
+
+	/* Got something ? */
+	if (!size || !pbasep) {
+		pr_warn("ISA: Non-PCI bridge %s has no usable IO range\n",
+			np->full_name);
+		return;
+	}
+
+	/* Align size and make sure it's cropped to 64K */
+	size = PAGE_ALIGN(size);
+	if (size > 0x10000)
+		size = 0x10000;
+
+	/* Map pbase */
+	pbase = of_translate_address(np, pbasep);
+	if (pbase == OF_BAD_ADDR) {
+		pr_warn("ISA: Non-PCI bridge %s failed to translate IO base\n",
+			np->full_name);
+		return;
+	}
+
+	/* We need page alignment */
+	if ((cbase & ~PAGE_MASK) || (pbase & ~PAGE_MASK)) {
+		pr_warn("ISA: Non-PCI bridge %s has non aligned IO range\n",
+			np->full_name);
+		return;
+	}
+
+	/* Got it */
+	isa_bridge_devnode = np;
+
+	/* Set the global ISA io base to indicate we have an ISA bridge
+	 * and map it
+	 */
+	isa_io_base = ISA_IO_BASE;
+	__ioremap_at(pbase, (void *)ISA_IO_BASE,
+		     size, pgprot_val(pgprot_noncached(__pgprot(0))));
+
+	pr_debug("ISA: Non-PCI bridge is %s\n", np->full_name);
+}
+
+/**
  * isa_bridge_find_late - Find and map the ISA IO space upon discovery of
  *                        a new ISA bridge
  */
-- 
2.9.3
