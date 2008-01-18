Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail72-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 93E8FDE037
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 07:34:15 +1100 (EST)
Message-ID: <47910CD8.4050302@am.sony.com>
Date: Fri, 18 Jan 2008 12:32:24 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 10/16] PS3: Checkpatch cleanups for
	arch/powerpc/platforms/ps3/repository.c
References: <20080118202612.422185192@am.sony.com>
In-Reply-To: <20080118202612.422185192@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Cleanup coding errors in arch/powerpc/platforms/ps3/repository.c as reported
by sparse and checkpatch.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/repository.c |   64 ++++++++++++++++----------------
 1 files changed, 32 insertions(+), 32 deletions(-)

--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -33,7 +33,7 @@ enum ps3_lpar_id {
 };
 
 #define dump_field(_a, _b) _dump_field(_a, _b, __func__, __LINE__)
-static void _dump_field(const char *hdr, u64 n, const char* func, int line)
+static void _dump_field(const char *hdr, u64 n, const char *func, int line)
 {
 #if defined(DEBUG)
 	char s[16];
@@ -50,8 +50,8 @@ static void _dump_field(const char *hdr,
 
 #define dump_node_name(_a, _b, _c, _d, _e) \
 	_dump_node_name(_a, _b, _c, _d, _e, __func__, __LINE__)
-static void _dump_node_name (unsigned int lpar_id, u64 n1, u64 n2, u64 n3,
-	u64 n4, const char* func, int line)
+static void _dump_node_name(unsigned int lpar_id, u64 n1, u64 n2, u64 n3,
+	u64 n4, const char *func, int line)
 {
 	pr_debug("%s:%d: lpar: %u\n", func, line, lpar_id);
 	_dump_field("n1: ", n1, func, line);
@@ -63,7 +63,7 @@ static void _dump_node_name (unsigned in
 #define dump_node(_a, _b, _c, _d, _e, _f, _g) \
 	_dump_node(_a, _b, _c, _d, _e, _f, _g, __func__, __LINE__)
 static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
-	u64 v1, u64 v2, const char* func, int line)
+	u64 v1, u64 v2, const char *func, int line)
 {
 	pr_debug("%s:%d: lpar: %u\n", func, line, lpar_id);
 	_dump_field("n1: ", n1, func, line);
@@ -165,7 +165,7 @@ int ps3_repository_read_bus_str(unsigned
 		make_first_field("bus", bus_index),
 		make_field(bus_str, 0),
 		0, 0,
-		value, 0);
+		value, NULL);
 }
 
 int ps3_repository_read_bus_id(unsigned int bus_index, u64 *bus_id)
@@ -190,7 +190,7 @@ int ps3_repository_read_bus_type(unsigne
 		make_first_field("bus", bus_index),
 		make_field("type", 0),
 		0, 0,
-		&v1, 0);
+		&v1, NULL);
 	*bus_type = v1;
 	return result;
 }
@@ -205,7 +205,7 @@ int ps3_repository_read_bus_num_dev(unsi
 		make_first_field("bus", bus_index),
 		make_field("num_dev", 0),
 		0, 0,
-		&v1, 0);
+		&v1, NULL);
 	*num_dev = v1;
 	return result;
 }
@@ -218,7 +218,7 @@ int ps3_repository_read_dev_str(unsigned
 		make_field("dev", dev_index),
 		make_field(dev_str, 0),
 		0,
-		value, 0);
+		value, NULL);
 }
 
 int ps3_repository_read_dev_id(unsigned int bus_index, unsigned int dev_index,
@@ -231,7 +231,7 @@ int ps3_repository_read_dev_id(unsigned 
 		make_field("dev", dev_index),
 		make_field("id", 0),
 		0,
-		dev_id, 0);
+		dev_id, NULL);
 	return result;
 }
 
@@ -246,14 +246,14 @@ int ps3_repository_read_dev_type(unsigne
 		make_field("dev", dev_index),
 		make_field("type", 0),
 		0,
-		&v1, 0);
+		&v1, NULL);
 	*dev_type = v1;
 	return result;
 }
 
 int ps3_repository_read_dev_intr(unsigned int bus_index,
 	unsigned int dev_index, unsigned int intr_index,
-	enum ps3_interrupt_type *intr_type, unsigned int* interrupt_id)
+	enum ps3_interrupt_type *intr_type, unsigned int *interrupt_id)
 {
 	int result;
 	u64 v1;
@@ -282,7 +282,7 @@ int ps3_repository_read_dev_reg_type(uns
 		make_field("dev", dev_index),
 		make_field("reg", reg_index),
 		make_field("type", 0),
-		&v1, 0);
+		&v1, NULL);
 	*reg_type = v1;
 	return result;
 }
@@ -588,7 +588,7 @@ int ps3_repository_read_stor_dev_port(un
 		make_first_field("bus", bus_index),
 		make_field("dev", dev_index),
 		make_field("port", 0),
-		0, port, 0);
+		0, port, NULL);
 }
 
 int ps3_repository_read_stor_dev_blk_size(unsigned int bus_index,
@@ -598,7 +598,7 @@ int ps3_repository_read_stor_dev_blk_siz
 		make_first_field("bus", bus_index),
 		make_field("dev", dev_index),
 		make_field("blk_size", 0),
-		0, blk_size, 0);
+		0, blk_size, NULL);
 }
 
 int ps3_repository_read_stor_dev_num_blocks(unsigned int bus_index,
@@ -608,7 +608,7 @@ int ps3_repository_read_stor_dev_num_blo
 		make_first_field("bus", bus_index),
 		make_field("dev", dev_index),
 		make_field("n_blocks", 0),
-		0, num_blocks, 0);
+		0, num_blocks, NULL);
 }
 
 int ps3_repository_read_stor_dev_num_regions(unsigned int bus_index,
@@ -621,7 +621,7 @@ int ps3_repository_read_stor_dev_num_reg
 		make_first_field("bus", bus_index),
 		make_field("dev", dev_index),
 		make_field("n_regs", 0),
-		0, &v1, 0);
+		0, &v1, NULL);
 	*num_regions = v1;
 	return result;
 }
@@ -638,7 +638,7 @@ int ps3_repository_read_stor_dev_region_
 	    make_field("dev", dev_index),
 	    make_field("region", region_index),
 	    make_field("id", 0),
-	    &v1, 0);
+	    &v1, NULL);
 	*region_id = v1;
 	return result;
 }
@@ -651,7 +651,7 @@ int ps3_repository_read_stor_dev_region_
 	    make_field("dev", dev_index),
 	    make_field("region", region_index),
 	    make_field("size", 0),
-	    region_size, 0);
+	    region_size, NULL);
 }
 
 int ps3_repository_read_stor_dev_region_start(unsigned int bus_index,
@@ -662,7 +662,7 @@ int ps3_repository_read_stor_dev_region_
 	    make_field("dev", dev_index),
 	    make_field("region", region_index),
 	    make_field("start", 0),
-	    region_start, 0);
+	    region_start, NULL);
 }
 
 int ps3_repository_read_stor_dev_info(unsigned int bus_index,
@@ -718,7 +718,7 @@ int ps3_repository_read_rm_size(unsigned
 		make_field("pu", 0),
 		ppe_id,
 		make_field("rm_size", 0),
-		rm_size, 0);
+		rm_size, NULL);
 }
 
 int ps3_repository_read_region_total(u64 *region_total)
@@ -727,7 +727,7 @@ int ps3_repository_read_region_total(u64
 		make_first_field("bi", 0),
 		make_field("rgntotal", 0),
 		0, 0,
-		region_total, 0);
+		region_total, NULL);
 }
 
 /**
@@ -763,7 +763,7 @@ int ps3_repository_read_num_spu_reserved
 		make_first_field("bi", 0),
 		make_field("spun", 0),
 		0, 0,
-		&v1, 0);
+		&v1, NULL);
 	*num_spu_reserved = v1;
 	return result;
 }
@@ -782,7 +782,7 @@ int ps3_repository_read_num_spu_resource
 		make_first_field("bi", 0),
 		make_field("spursvn", 0),
 		0, 0,
-		&v1, 0);
+		&v1, NULL);
 	*num_resource_id = v1;
 	return result;
 }
@@ -795,7 +795,7 @@ int ps3_repository_read_num_spu_resource
  */
 
 int ps3_repository_read_spu_resource_id(unsigned int res_index,
-	enum ps3_spu_resource_type* resource_type, unsigned int *resource_id)
+	enum ps3_spu_resource_type *resource_type, unsigned int *resource_id)
 {
 	int result;
 	u64 v1;
@@ -812,14 +812,14 @@ int ps3_repository_read_spu_resource_id(
 	return result;
 }
 
-int ps3_repository_read_boot_dat_address(u64 *address)
+static int ps3_repository_read_boot_dat_address(u64 *address)
 {
 	return read_node(PS3_LPAR_ID_CURRENT,
 		make_first_field("bi", 0),
 		make_field("boot_dat", 0),
 		make_field("address", 0),
 		0,
-		address, 0);
+		address, NULL);
 }
 
 int ps3_repository_read_boot_dat_size(unsigned int *size)
@@ -832,7 +832,7 @@ int ps3_repository_read_boot_dat_size(un
 		make_field("boot_dat", 0),
 		make_field("size", 0),
 		0,
-		&v1, 0);
+		&v1, NULL);
 	*size = v1;
 	return result;
 }
@@ -847,7 +847,7 @@ int ps3_repository_read_vuart_av_port(un
 		make_field("vir_uart", 0),
 		make_field("port", 0),
 		make_field("avset", 0),
-		&v1, 0);
+		&v1, NULL);
 	*port = v1;
 	return result;
 }
@@ -862,7 +862,7 @@ int ps3_repository_read_vuart_sysmgr_por
 		make_field("vir_uart", 0),
 		make_field("port", 0),
 		make_field("sysmgr", 0),
-		&v1, 0);
+		&v1, NULL);
 	*port = v1;
 	return result;
 }
@@ -893,7 +893,7 @@ int ps3_repository_read_num_be(unsigned 
 		0,
 		0,
 		0,
-		&v1, 0);
+		&v1, NULL);
 	*num_be = v1;
 	return result;
 }
@@ -905,7 +905,7 @@ int ps3_repository_read_be_node_id(unsig
 		0,
 		0,
 		0,
-		node_id, 0);
+		node_id, NULL);
 }
 
 int ps3_repository_read_tb_freq(u64 node_id, u64 *tb_freq)
@@ -915,7 +915,7 @@ int ps3_repository_read_tb_freq(u64 node
 		node_id,
 		make_field("clock", 0),
 		0,
-		tb_freq, 0);
+		tb_freq, NULL);
 }
 
 int ps3_repository_read_be_tb_freq(unsigned int be_index, u64 *tb_freq)

-- 
