Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 Nov 2007 17:10:47 +1100
Subject: [PATCH 8/24] powerpc: Add of_translate_dma_address
In-Reply-To: <1196403038.569525.367459803520.qpush@grosgo>
Message-Id: <20071130061150.65EF7DDEEB@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a variant of of_translate_address that uses the dma-ranges
property instead of "ranges", it's to be used by PCI code in parsing
the dma-ranges property.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/prom_parse.c |   20 ++++++++++++++++----
 include/asm-powerpc/prom.h       |    4 ++++
 2 files changed, 20 insertions(+), 4 deletions(-)

Index: linux-work/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_parse.c	2007-11-22 13:18:32.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom_parse.c	2007-11-22 13:50:45.000000000 +1100
@@ -419,7 +419,7 @@ static struct of_bus *of_match_bus(struc
 
 static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 			    struct of_bus *pbus, u32 *addr,
-			    int na, int ns, int pna)
+			    int na, int ns, int pna, const char *rprop)
 {
 	const u32 *ranges;
 	unsigned int rlen;
@@ -438,7 +438,7 @@ static int of_translate_one(struct devic
 	 * to translate addresses that aren't supposed to be translated in
 	 * the first place. --BenH.
 	 */
-	ranges = of_get_property(parent, "ranges", &rlen);
+	ranges = of_get_property(parent, rprop, &rlen);
 	if (ranges == NULL || rlen == 0) {
 		offset = of_read_number(addr, na);
 		memset(addr, 0, pna * 4);
@@ -481,7 +481,8 @@ static int of_translate_one(struct devic
  * that can be mapped to a cpu physical address). This is not really specified
  * that way, but this is traditionally the way IBM at least do things
  */
-u64 of_translate_address(struct device_node *dev, const u32 *in_addr)
+u64 __of_translate_address(struct device_node *dev, const u32 *in_addr,
+			   const char *rprop)
 {
 	struct device_node *parent = NULL;
 	struct of_bus *bus, *pbus;
@@ -540,7 +541,7 @@ u64 of_translate_address(struct device_n
 		    pbus->name, pna, pns, parent->full_name);
 
 		/* Apply bus translation */
-		if (of_translate_one(dev, bus, pbus, addr, na, ns, pna))
+		if (of_translate_one(dev, bus, pbus, addr, na, ns, pna, rprop))
 			break;
 
 		/* Complete the move up one level */
@@ -556,8 +557,19 @@ u64 of_translate_address(struct device_n
 
 	return result;
 }
+
+u64 of_translate_address(struct device_node *dev, const u32 *in_addr)
+{
+	return __of_translate_address(dev, in_addr, "ranges");
+}
 EXPORT_SYMBOL(of_translate_address);
 
+u64 of_translate_dma_address(struct device_node *dev, const u32 *in_addr)
+{
+	return __of_translate_address(dev, in_addr, "dma-ranges");
+}
+EXPORT_SYMBOL(of_translate_dma_address);
+
 const u32 *of_get_address(struct device_node *dev, int index, u64 *size,
 		    unsigned int *flags)
 {
Index: linux-work/include/asm-powerpc/prom.h
===================================================================
--- linux-work.orig/include/asm-powerpc/prom.h	2007-11-22 13:48:21.000000000 +1100
+++ linux-work/include/asm-powerpc/prom.h	2007-11-22 13:48:57.000000000 +1100
@@ -202,6 +202,10 @@ static inline unsigned long of_read_ulon
  */
 extern u64 of_translate_address(struct device_node *np, const u32 *addr);
 
+/* Translate a DMA address from device space to CPU space */
+extern u64 of_translate_dma_address(struct device_node *dev,
+				    const u32 *in_addr);
+
 /* Extract an address from a device, returns the region size and
  * the address space flags too. The PCI version uses a BAR number
  * instead of an absolute index
