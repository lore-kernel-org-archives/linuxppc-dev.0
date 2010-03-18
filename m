Return-Path: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/of: Fix comparison of "compatible" properties
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Mar 2010 11:09:01 +1100
Message-ID: <1268870941.2335.214.camel@pasglop>
Mime-Version: 1.0
Cc: microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 7c7b60cb87547b1664a4385c187f029bf514a737
"of: put default string compare and #a/s-cell values into common header"

Breaks various things on powerpc due to using strncasecmp instead of
strcasecmp for comparing against "compatible" strings.

This causes things like the 4xx PCI code to fail miserably due to the
partial matches in code like this:

	for_each_compatible_node(np, NULL, "ibm,plb-pcix")
		ppc4xx_probe_pcix_bridge(np);
	for_each_compatible_node(np, NULL, "ibm,plb-pci")
		ppc4xx_probe_pci_bridge(np);

This reverts us to use strcasecmp. I do wonder why microblase and sparc
want the partial matches though. For sparc it could be historical, but
microblaze might want to change.

It's not quite right to do partial name match. Entries in a compatible
list are meant to be matched whole. If a device is compatible with both
"foo" and "foo1", then the device should have both strings in its
"compatible" property.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/prom.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index ddd408a..47ce796 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -23,6 +23,14 @@
 #include <asm/irq.h>
 #include <asm/atomic.h>
 
+/* We do -not- want the generic "strncasecmp" here for of_compat_cmp.
+ * We have cases where we could otherwise mismatch "pcix" and "pci"
+ * and similar.
+ */
+#define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))
+#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
+#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
+
 #define HAVE_ARCH_DEVTREE_FIXUPS
 
 #ifdef CONFIG_PPC32
