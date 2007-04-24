Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4DA04DDEDB
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 13:52:58 +1000 (EST)
Date: Tue, 24 Apr 2007 13:48:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 1/5] [POWERPC] Remove find_compatible_devices
Message-Id: <20070424134841.cee3ff4e.sfr@canb.auug.org.au>
In-Reply-To: <20070413171422.c19353e2.sfr@canb.auug.org.au>
References: <20070413171422.c19353e2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an old interface and is replaced by of_find_compatible_node.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c         |   24 ------------------------
 arch/powerpc/platforms/chrp/time.c |   13 +++++++++----
 drivers/macintosh/macio-adb.c      |   16 +++++++++++++---
 include/asm-powerpc/prom.h         |    2 --
 4 files changed, 22 insertions(+), 33 deletions(-)

This series of patches has been compile tested for a ppc64 allmodconfig.
They are on top of the for-2.6.22 tree plus my patch entitled "Rename
last get_property calls"

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index ec6921c..2f7e6ec 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1171,30 +1171,6 @@ int machine_is_compatible(const char *compat)
 EXPORT_SYMBOL(machine_is_compatible);
 
 /**
- * Construct and return a list of the device_nodes with a given type
- * and compatible property.
- */
-struct device_node *find_compatible_devices(const char *type,
-					    const char *compat)
-{
-	struct device_node *head, **prevp, *np;
-
-	prevp = &head;
-	for (np = allnodes; np != 0; np = np->allnext) {
-		if (type != NULL
-		    && !(np->type != 0 && strcasecmp(np->type, type) == 0))
-			continue;
-		if (of_device_is_compatible(np, compat)) {
-			*prevp = np;
-			prevp = &np->next;
-		}
-	}
-	*prevp = NULL;
-	return head;
-}
-EXPORT_SYMBOL(find_compatible_devices);
-
-/**
  * Find the device_node with a given full_name.
  */
 struct device_node *find_path_device(const char *path)
diff --git a/arch/powerpc/platforms/chrp/time.c b/arch/powerpc/platforms/chrp/time.c
index 7d78890..96d1e4b 100644
--- a/arch/powerpc/platforms/chrp/time.c
+++ b/arch/powerpc/platforms/chrp/time.c
@@ -39,12 +39,17 @@ long __init chrp_time_init(void)
 	struct resource r;
 	int base;
 
-	rtcs = find_compatible_devices("rtc", "pnpPNP,b00");
+	rtcs = of_find_compatible_node(NULL, "rtc", "pnpPNP,b00");
 	if (rtcs == NULL)
-		rtcs = find_compatible_devices("rtc", "ds1385-rtc");
-	if (rtcs == NULL || of_address_to_resource(rtcs, 0, &r))
+		rtcs = of_find_compatible_node(NULL, "rtc", "ds1385-rtc");
+	if (rtcs == NULL)
+		return 0;
+	if (of_address_to_resource(rtcs, 0, &r)) {
+		of_node_put(rtcs);
 		return 0;
-	
+	}
+	of_node_put(rtcs);
+
 	base = r.start;
 	nvram_as1 = 0;
 	nvram_as0 = base;
diff --git a/drivers/macintosh/macio-adb.c b/drivers/macintosh/macio-adb.c
index 026b67f..79119f5 100644
--- a/drivers/macintosh/macio-adb.c
+++ b/drivers/macintosh/macio-adb.c
@@ -82,7 +82,14 @@ struct adb_driver macio_adb_driver = {
 
 int macio_probe(void)
 {
-	return find_compatible_devices("adb", "chrp,adb0")? 0: -ENODEV;
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, "adb", "chrp,adb0");
+	if (np) {
+		of_node_put(np);
+		return 0;
+	}
+	return -ENODEV;
 }
 
 int macio_init(void)
@@ -91,12 +98,14 @@ int macio_init(void)
 	struct resource r;
 	unsigned int irq;
 
-	adbs = find_compatible_devices("adb", "chrp,adb0");
+	adbs = of_find_compatible_node(NULL, "adb", "chrp,adb0");
 	if (adbs == 0)
 		return -ENXIO;
 
-	if (of_address_to_resource(adbs, 0, &r))
+	if (of_address_to_resource(adbs, 0, &r)) {
+		of_node_put(adbs);
 		return -ENXIO;
+	}
 	adb = ioremap(r.start, sizeof(struct adb_regs));
 
 	out_8(&adb->ctrl.r, 0);
@@ -107,6 +116,7 @@ int macio_init(void)
 	out_8(&adb->autopoll.r, APE);
 
 	irq = irq_of_parse_and_map(adbs, 0);
+	of_node_put(adbs);
 	if (request_irq(irq, macio_adb_interrupt, 0, "ADB", (void *)0)) {
 		printk(KERN_ERR "ADB: can't get irq %d\n", irq);
 		return -EAGAIN;
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index e73a2b4..c2bb8b5 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -115,8 +115,6 @@ static inline void set_node_proc_entry(struct device_node *dn, struct proc_dir_e
 extern struct device_node *find_devices(const char *name);
 extern struct device_node *find_type_devices(const char *type);
 extern struct device_node *find_path_device(const char *path);
-extern struct device_node *find_compatible_devices(const char *type,
-						   const char *compat);
 extern struct device_node *find_all_nodes(void);
 
 /* New style node lookup */
-- 
1.5.1.1
