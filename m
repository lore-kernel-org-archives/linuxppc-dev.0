Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 99467DE078
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:58:43 +1000 (EST)
Date: Tue, 3 Apr 2007 10:58:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 6/6] [POWERPC] make struct property's value a void *
Message-Id: <20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
In-Reply-To: <20070403105748.769f156c.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
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
 arch/powerpc/kernel/machine_kexec_64.c       |   10 +++++-----
 arch/powerpc/kernel/pci_32.c                 |    2 +-
 arch/powerpc/kernel/prom.c                   |    5 +++--
 arch/powerpc/platforms/maple/pci.c           |    2 +-
 arch/powerpc/platforms/powermac/pci.c        |    2 +-
 arch/powerpc/platforms/powermac/pfunc_core.c |    3 +--
 drivers/macintosh/smu.c                      |    2 +-
 fs/proc/proc_devtree.c                       |    2 +-
 include/asm-powerpc/prom.h                   |    2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index a24b09c..b975b5b 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -294,19 +294,19 @@ static unsigned long htab_base, kernel_end;
 static struct property htab_base_prop = {
 	.name = "linux,htab-base",
 	.length = sizeof(unsigned long),
-	.value = (unsigned char *)&htab_base,
+	.value = &htab_base,
 };
 
 static struct property htab_size_prop = {
 	.name = "linux,htab-size",
 	.length = sizeof(unsigned long),
-	.value = (unsigned char *)&htab_size_bytes,
+	.value = &htab_size_bytes,
 };
 
 static struct property kernel_end_prop = {
 	.name = "linux,kernel-end",
 	.length = sizeof(unsigned long),
-	.value = (unsigned char *)&kernel_end,
+	.value = &kernel_end,
 };
 
 static void __init export_htab_values(void)
@@ -335,7 +335,7 @@ static void __init export_htab_values(void)
 static struct property crashk_base_prop = {
 	.name = "linux,crashkernel-base",
 	.length = sizeof(unsigned long),
-	.value = (unsigned char *)&crashk_res.start,
+	.value = &crashk_res.start,
 };
 
 static unsigned long crashk_size;
@@ -343,7 +343,7 @@ static unsigned long crashk_size;
 static struct property crashk_size_prop = {
 	.name = "linux,crashkernel-size",
 	.length = sizeof(unsigned long),
-	.value = (unsigned char *)&crashk_size,
+	.value = &crashk_size,
 };
 
 static void __init export_crashk_values(void)
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index ecc7658..e99ffe2 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -1012,7 +1012,7 @@ pci_create_OF_bus_map(void)
 		memset(of_prop, -1, sizeof(struct property) + 256);
 		of_prop->name = "pci-OF-bus-map";
 		of_prop->length = 256;
-		of_prop->value = (unsigned char *)&of_prop[1];
+		of_prop->value = &of_prop[1];
 		prom_add_property(find_path_device("/"), of_prop);
 	}
 }
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 2890ce3..ec6921c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -390,12 +390,13 @@ static unsigned long __init unflatten_dt_node(unsigned long mem,
 		if (allnextpp) {
 			pp->name = "name";
 			pp->length = sz;
-			pp->value = (unsigned char *)(pp + 1);
+			pp->value = pp + 1;
 			*prev_pp = pp;
 			prev_pp = &pp->next;
 			memcpy(pp->value, ps, sz - 1);
 			((char *)pp->value)[sz - 1] = 0;
-			DBG("fixed up name for %s -> %s\n", pathp, pp->value);
+			DBG("fixed up name for %s -> %s\n", pathp,
+				(char *)pp->value);
 		}
 	}
 	if (allnextpp) {
diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 73c5990..ab5a6f1 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -77,7 +77,7 @@ static void __init fixup_bus_range(struct device_node *bridge)
 			       bridge->full_name);
 		return;
 	}
-	bus_range = (int *)prop->value;
+	bus_range = prop->value;
 	bus_range[1] = fixup_one_level_bus_range(bridge->child, bus_range[1]);
 }
 
diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 6fbac30..431a685 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -100,7 +100,7 @@ static void __init fixup_bus_range(struct device_node *bridge)
 	if (prop == NULL || prop->length < 2 * sizeof(int))
 		return;
 
-	bus_range = (int *)prop->value;
+	bus_range = prop->value;
 	bus_range[1] = fixup_one_level_bus_range(bridge->child, bus_range[1]);
 }
 
diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c b/arch/powerpc/platforms/powermac/pfunc_core.c
index 7651f27..a128553 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -692,8 +692,7 @@ static int pmf_add_functions(struct pmf_device *dev, void *driverdata)
 		name = pp->name + plen;
 		if (strlen(name) && pp->length >= 12)
 			count += pmf_add_function_prop(dev, driverdata, name,
-						       (u32 *)pp->value,
-						       pp->length);
+						       pp->value, pp->length);
 	}
 	return count;
 }
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 3096836..45bb3c1 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -952,7 +952,7 @@ static struct smu_sdbp_header *smu_create_sdb_partition(int id)
 	prop->name = ((char *)prop) + tlen - 18;
 	sprintf(prop->name, "sdb-partition-%02x", id);
 	prop->length = len;
-	prop->value = (unsigned char *)hdr;
+	prop->value = hdr;
 	prop->next = NULL;
 
 	/* Read the datablock */
diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
index abdf068..eca471b 100644
--- a/fs/proc/proc_devtree.c
+++ b/fs/proc/proc_devtree.c
@@ -38,7 +38,7 @@ static int property_read_proc(char *page, char **start, off_t off,
 		n = count;
 	else
 		*eof = 1;
-	memcpy(page, pp->value + off, n);
+	memcpy(page, (char *)pp->value + off, n);
 	*start = page;
 	return n;
 }
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index fb068f2..e73a2b4 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -71,7 +71,7 @@ typedef u32 ihandle;
 struct property {
 	char	*name;
 	int	length;
-	unsigned char *value;
+	void	*value;
 	struct property *next;
 };
 
-- 
1.5.0.3
