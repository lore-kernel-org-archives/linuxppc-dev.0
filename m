Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 2/20] [powerpc] Use const qualifiers for prom parsing utilites
Message-ID: 1151993427.2210.03@pokey
Date: Tue,  4 Jul 2006 16:46:44 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The of_bus callbacks map and get_flags can be constified, as they don't
alter the range or addr arguments. of_dump_addr and of_read_addr can
also be constified.

Built for 32- and 64-bit powerpc

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 arch/powerpc/kernel/prom_parse.c |   22 ++++++++++++----------
 include/asm-powerpc/prom.h       |    2 +-
 2 files changed, 13 insertions(+), 11 deletions(-)

Index: linux-2.6/arch/powerpc/kernel/prom_parse.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/prom_parse.c
+++ linux-2.6/arch/powerpc/kernel/prom_parse.c
@@ -27,7 +27,7 @@
 
 /* Debug utility */
 #ifdef DEBUG
-static void of_dump_addr(const char *s, u32 *addr, int na)
+static void of_dump_addr(const char *s, const u32 *addr, int na)
 {
 	printk("%s", s);
 	while(na--)
@@ -35,7 +35,7 @@ static void of_dump_addr(const char *s, 
 	printk("\n");
 }
 #else
-static void of_dump_addr(const char *s, u32 *addr, int na) { }
+static void of_dump_addr(const char *s, const u32 *addr, int na) { }
 #endif
 
 
@@ -46,9 +46,10 @@ struct of_bus {
 	int		(*match)(struct device_node *parent);
 	void		(*count_cells)(struct device_node *child,
 				       int *addrc, int *sizec);
-	u64		(*map)(u32 *addr, u32 *range, int na, int ns, int pna);
+	u64		(*map)(u32 *addr, const u32 *range,
+				int na, int ns, int pna);
 	int		(*translate)(u32 *addr, u64 offset, int na);
-	unsigned int	(*get_flags)(u32 *addr);
+	unsigned int	(*get_flags)(const u32 *addr);
 };
 
 
@@ -65,7 +66,8 @@ static void of_bus_default_count_cells(s
 		*sizec = prom_n_size_cells(dev);
 }
 
-static u64 of_bus_default_map(u32 *addr, u32 *range, int na, int ns, int pna)
+static u64 of_bus_default_map(u32 *addr, const u32 *range,
+		int na, int ns, int pna)
 {
 	u64 cp, s, da;
 
@@ -93,7 +95,7 @@ static int of_bus_default_translate(u32 
 	return 0;
 }
 
-static unsigned int of_bus_default_get_flags(u32 *addr)
+static unsigned int of_bus_default_get_flags(const u32 *addr)
 {
 	return IORESOURCE_MEM;
 }
@@ -118,7 +120,7 @@ static void of_bus_pci_count_cells(struc
 		*sizec = 2;
 }
 
-static u64 of_bus_pci_map(u32 *addr, u32 *range, int na, int ns, int pna)
+static u64 of_bus_pci_map(u32 *addr, const u32 *range, int na, int ns, int pna)
 {
 	u64 cp, s, da;
 
@@ -143,7 +145,7 @@ static int of_bus_pci_translate(u32 *add
 	return of_bus_default_translate(addr + 1, offset, na - 1);
 }
 
-static unsigned int of_bus_pci_get_flags(u32 *addr)
+static unsigned int of_bus_pci_get_flags(const u32 *addr)
 {
 	unsigned int flags = 0;
 	u32 w = addr[0];
@@ -178,7 +180,7 @@ static void of_bus_isa_count_cells(struc
 		*sizec = 1;
 }
 
-static u64 of_bus_isa_map(u32 *addr, u32 *range, int na, int ns, int pna)
+static u64 of_bus_isa_map(u32 *addr, const u32 *range, int na, int ns, int pna)
 {
 	u64 cp, s, da;
 
@@ -203,7 +205,7 @@ static int of_bus_isa_translate(u32 *add
 	return of_bus_default_translate(addr + 1, offset, na - 1);
 }
 
-static unsigned int of_bus_isa_get_flags(u32 *addr)
+static unsigned int of_bus_isa_get_flags(const u32 *addr)
 {
 	unsigned int flags = 0;
 	u32 w = addr[0];
Index: linux-2.6/include/asm-powerpc/prom.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/prom.h
+++ linux-2.6/include/asm-powerpc/prom.h
@@ -198,7 +198,7 @@ extern int release_OF_resource(struct de
 
 
 /* Helper to read a big number */
-static inline u64 of_read_number(u32 *cell, int size)
+static inline u64 of_read_number(const u32 *cell, int size)
 {
 	u64 r = 0;
 	while (size--)
