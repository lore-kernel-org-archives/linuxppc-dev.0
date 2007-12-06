Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5C245DE04F
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:57 +1100 (EST)
Received: from ash.ozlabs.ibm.com (ta-1-1.tip.net.au [203.11.71.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 19018368002
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:07:57 +1100 (EST)
Date: Fri, 7 Dec 2007 01:52:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 08/19] [POWERPC] iSeries: consoldiate PCI IO error check
Message-Id: <20071207015245.05cac2a7.sfr@canb.auug.org.au>
In-Reply-To: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/pci.c |  105 ++++++++-------------------------
 1 files changed, 26 insertions(+), 79 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 8e2ac3d..105b23d 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -342,7 +342,7 @@ static int check_return_code(char *type, struct device_node *dn,
  */
 static inline struct device_node *xlate_iomm_address(
 		const volatile void __iomem *addr,
-		u64 *dsaptr, u64 *bar_offset)
+		u64 *dsaptr, u64 *bar_offset, const char *func)
 {
 	unsigned long orig_addr;
 	unsigned long base_addr;
@@ -350,8 +350,20 @@ static inline struct device_node *xlate_iomm_address(
 	struct device_node *dn;
 
 	orig_addr = (unsigned long __force)addr;
-	if ((orig_addr < BASE_IO_MEMORY) || (orig_addr >= max_io_memory))
+	if ((orig_addr < BASE_IO_MEMORY) || (orig_addr >= max_io_memory)) {
+		static unsigned long last_jiffies;
+		static int num_printed;
+
+		if ((jiffies - last_jiffies) > 60 * HZ) {
+			last_jiffies = jiffies;
+			num_printed = 0;
+		}
+		if (num_printed++ < 10)
+			printk(KERN_ERR
+				"iSeries_%s: invalid access at IO address %p\n",
+				func, addr);
 		return NULL;
+	}
 	base_addr = orig_addr - BASE_IO_MEMORY;
 	ind = base_addr / IOMM_TABLE_ENTRY_SIZE;
 	dn = iomm_table[ind];
@@ -377,21 +389,10 @@ static u8 iSeries_read_byte(const volatile void __iomem *addr)
 	int retry = 0;
 	struct HvCallPci_LoadReturn ret;
 	struct device_node *dn =
-		xlate_iomm_address(addr, &dsa, &bar_offset);
-
-	if (dn == NULL) {
-		static unsigned long last_jiffies;
-		static int num_printed;
+		xlate_iomm_address(addr, &dsa, &bar_offset, "read_byte");
 
-		if ((jiffies - last_jiffies) > 60 * HZ) {
-			last_jiffies = jiffies;
-			num_printed = 0;
-		}
-		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_read_byte: invalid access at IO address %p\n",
-			       addr);
+	if (dn == NULL)
 		return 0xff;
-	}
 	do {
 		HvCall3Ret16(HvCallPciBarLoad8, &ret, dsa, bar_offset, 0);
 	} while (check_return_code("RDB", dn, &retry, ret.rc) != 0);
@@ -406,21 +407,10 @@ static u16 iSeries_read_word(const volatile void __iomem *addr)
 	int retry = 0;
 	struct HvCallPci_LoadReturn ret;
 	struct device_node *dn =
-		xlate_iomm_address(addr, &dsa, &bar_offset);
-
-	if (dn == NULL) {
-		static unsigned long last_jiffies;
-		static int num_printed;
+		xlate_iomm_address(addr, &dsa, &bar_offset, "read_word");
 
-		if ((jiffies - last_jiffies) > 60 * HZ) {
-			last_jiffies = jiffies;
-			num_printed = 0;
-		}
-		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_read_word: invalid access at IO address %p\n",
-			       addr);
+	if (dn == NULL)
 		return 0xffff;
-	}
 	do {
 		HvCall3Ret16(HvCallPciBarLoad16, &ret, dsa,
 				bar_offset, 0);
@@ -436,21 +426,10 @@ static u32 iSeries_read_long(const volatile void __iomem *addr)
 	int retry = 0;
 	struct HvCallPci_LoadReturn ret;
 	struct device_node *dn =
-		xlate_iomm_address(addr, &dsa, &bar_offset);
-
-	if (dn == NULL) {
-		static unsigned long last_jiffies;
-		static int num_printed;
+		xlate_iomm_address(addr, &dsa, &bar_offset, "read_long");
 
-		if ((jiffies - last_jiffies) > 60 * HZ) {
-			last_jiffies = jiffies;
-			num_printed = 0;
-		}
-		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_read_long: invalid access at IO address %p\n",
-			       addr);
+	if (dn == NULL)
 		return 0xffffffff;
-	}
 	do {
 		HvCall3Ret16(HvCallPciBarLoad32, &ret, dsa,
 				bar_offset, 0);
@@ -470,20 +449,10 @@ static void iSeries_write_byte(u8 data, volatile void __iomem *addr)
 	int retry = 0;
 	u64 rc;
 	struct device_node *dn =
-		xlate_iomm_address(addr, &dsa, &bar_offset);
+		xlate_iomm_address(addr, &dsa, &bar_offset, "write_byte");
 
-	if (dn == NULL) {
-		static unsigned long last_jiffies;
-		static int num_printed;
-
-		if ((jiffies - last_jiffies) > 60 * HZ) {
-			last_jiffies = jiffies;
-			num_printed = 0;
-		}
-		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_write_byte: invalid access at IO address %p\n", addr);
+	if (dn == NULL)
 		return;
-	}
 	do {
 		rc = HvCall4(HvCallPciBarStore8, dsa, bar_offset, data, 0);
 	} while (check_return_code("WWB", dn, &retry, rc) != 0);
@@ -496,21 +465,10 @@ static void iSeries_write_word(u16 data, volatile void __iomem *addr)
 	int retry = 0;
 	u64 rc;
 	struct device_node *dn =
-		xlate_iomm_address(addr, &dsa, &bar_offset);
-
-	if (dn == NULL) {
-		static unsigned long last_jiffies;
-		static int num_printed;
+		xlate_iomm_address(addr, &dsa, &bar_offset, "write_word");
 
-		if ((jiffies - last_jiffies) > 60 * HZ) {
-			last_jiffies = jiffies;
-			num_printed = 0;
-		}
-		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_write_word: invalid access at IO address %p\n",
-			       addr);
+	if (dn == NULL)
 		return;
-	}
 	do {
 		rc = HvCall4(HvCallPciBarStore16, dsa, bar_offset, data, 0);
 	} while (check_return_code("WWW", dn, &retry, rc) != 0);
@@ -523,21 +481,10 @@ static void iSeries_write_long(u32 data, volatile void __iomem *addr)
 	int retry = 0;
 	u64 rc;
 	struct device_node *dn =
-		xlate_iomm_address(addr, &dsa, &bar_offset);
+		xlate_iomm_address(addr, &dsa, &bar_offset, "write_long");
 
-	if (dn == NULL) {
-		static unsigned long last_jiffies;
-		static int num_printed;
-
-		if ((jiffies - last_jiffies) > 60 * HZ) {
-			last_jiffies = jiffies;
-			num_printed = 0;
-		}
-		if (num_printed++ < 10)
-			printk(KERN_ERR "iSeries_write_long: invalid access at IO address %p\n",
-			       addr);
+	if (dn == NULL)
 		return;
-	}
 	do {
 		rc = HvCall4(HvCallPciBarStore32, dsa, bar_offset, data, 0);
 	} while (check_return_code("WWL", dn, &retry, rc) != 0);
-- 
1.5.3.7


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
