Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7668167CD6
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 11:17:29 +1100 (EST)
Message-ID: <45775D92.3080701@am.sony.com>
Date: Wed, 06 Dec 2006 16:17:22 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/2] ps3: add repository storage support
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Adds PS3 repository storage support routines:

  - Add missing implementations of ps3_repository_read_stor_*() repository
    accessors.
  - Dump storage properties in debug mode
  - Add PS3_DEV_TYPE_STOR_PDISK,ROM,FLASH} device types (which are identical to
    the corresponding SCSI device types) to enum ps3_dev_type

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3/repository.c |  185 +++++++++++++++++++++++++++++++-
 include/asm-powerpc/ps3.h               |   24 ++--
 2 files changed, 200 insertions(+), 9 deletions(-)

--- cell--common--7.orig/arch/powerpc/platforms/ps3/repository.c
+++ cell--common--7/arch/powerpc/platforms/ps3/repository.c
@@ -374,7 +374,55 @@ int ps3_repository_dump_resource_info(un
 	return result;
 }
 
-static int dump_device_info(unsigned int bus_index, unsigned int num_dev)
+static int dump_stor_dev_info(unsigned int bus_index, unsigned int dev_index)
+{
+	int result = 0;
+	unsigned int num_regions, region_index;
+	u64 port, blk_size, num_blocks;
+
+	pr_debug(" -> %s:%d: (%u:%u)\n", __func__, __LINE__,
+		bus_index, dev_index);
+
+	result = ps3_repository_read_stor_dev_info(bus_index, dev_index, &port,
+		&blk_size, &num_blocks, &num_regions);
+	if (result) {
+		pr_debug("%s:%d ps3_repository_read_stor_dev_info"
+			" (%u:%u) failed\n", __func__, __LINE__,
+			bus_index, dev_index);
+		goto out;
+	}
+
+	pr_debug("%s:%d  (%u:%u): port %lu, blk_size %lu, num_blocks "
+		 "%lu, num_regions %u\n",
+		 __func__, __LINE__, bus_index, dev_index, port,
+		 blk_size, num_blocks, num_regions);
+
+	for (region_index = 0; region_index < num_regions; region_index++) {
+		unsigned int region_id;
+		u64 region_start, region_size;
+
+		result = ps3_repository_read_stor_dev_region(bus_index,
+			dev_index, region_index, &region_id, &region_start,
+			&region_size);
+		if (result) {
+			 pr_debug("%s:%d ps3_repository_read_stor_dev_region"
+				  " (%u:%u) failed\n", __func__, __LINE__,
+				  bus_index, dev_index);
+			break;
+		}
+
+		pr_debug("%s:%d (%u:%u) region_id %u, start %lxh, size %lxh\n",
+			 __func__, __LINE__, bus_index, dev_index, region_id,
+			 region_start, region_size);
+	}
+
+out:
+	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	return result;
+}
+
+static int dump_device_info(unsigned int bus_index, enum ps3_bus_type bus_type,
+			    unsigned int num_dev)
 {
 	int result = 0;
 	unsigned int dev_index;
@@ -409,6 +457,9 @@ static int dump_device_info(unsigned int
 			__LINE__, bus_index, dev_index, dev_type, dev_id);
 
 		ps3_repository_dump_resource_info(bus_index, dev_index);
+
+		if (bus_type == PS3_BUS_TYPE_STORAGE)
+			dump_stor_dev_info(bus_index, dev_index);
 	}
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
@@ -459,7 +510,7 @@ int ps3_repository_dump_bus_info(void)
 			__func__, __LINE__, bus_index, bus_type, bus_id,
 			num_dev);
 
-		dump_device_info(bus_index, num_dev);
+		dump_device_info(bus_index, bus_type, num_dev);
 	}
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
@@ -664,6 +715,136 @@ int ps3_repository_find_reg(const struct
 	return result;
 }
 
+int ps3_repository_read_stor_dev_port(unsigned int bus_index,
+	unsigned int dev_index, u64 *port)
+{
+	return read_node(PS3_LPAR_ID_PME,
+		make_first_field("bus", bus_index),
+		make_field("dev", dev_index),
+		make_field("port", 0),
+		0, port, 0);
+}
+
+int ps3_repository_read_stor_dev_blk_size(unsigned int bus_index,
+	unsigned int dev_index, u64 *blk_size)
+{
+	return read_node(PS3_LPAR_ID_PME,
+		make_first_field("bus", bus_index),
+		make_field("dev", dev_index),
+		make_field("blk_size", 0),
+		0, blk_size, 0);
+}
+
+int ps3_repository_read_stor_dev_num_blocks(unsigned int bus_index,
+	unsigned int dev_index, u64 *num_blocks)
+{
+	return read_node(PS3_LPAR_ID_PME,
+		make_first_field("bus", bus_index),
+		make_field("dev", dev_index),
+		make_field("n_blocks", 0),
+		0, num_blocks, 0);
+}
+
+int ps3_repository_read_stor_dev_num_regions(unsigned int bus_index,
+	unsigned int dev_index, unsigned int *num_regions)
+{
+	int result;
+	u64 v1;
+
+	result = read_node(PS3_LPAR_ID_PME,
+		make_first_field("bus", bus_index),
+		make_field("dev", dev_index),
+		make_field("n_regs", 0),
+		0, &v1, 0);
+	*num_regions = v1;
+	return result;
+}
+
+int ps3_repository_read_stor_dev_region_id(unsigned int bus_index,
+	unsigned int dev_index, unsigned int region_index,
+	unsigned int *region_id)
+{
+	int result;
+	u64 v1;
+
+	result = read_node(PS3_LPAR_ID_PME,
+	    make_first_field("bus", bus_index),
+	    make_field("dev", dev_index),
+	    make_field("region", region_index),
+	    make_field("id", 0),
+	    &v1, 0);
+	*region_id = v1;
+	return result;
+}
+
+int ps3_repository_read_stor_dev_region_size(unsigned int bus_index,
+	unsigned int dev_index,	unsigned int region_index, u64 *region_size)
+{
+	return read_node(PS3_LPAR_ID_PME,
+	    make_first_field("bus", bus_index),
+	    make_field("dev", dev_index),
+	    make_field("region", region_index),
+	    make_field("size", 0),
+	    region_size, 0);
+}
+
+int ps3_repository_read_stor_dev_region_start(unsigned int bus_index,
+	unsigned int dev_index, unsigned int region_index, u64 *region_start)
+{
+	return read_node(PS3_LPAR_ID_PME,
+	    make_first_field("bus", bus_index),
+	    make_field("dev", dev_index),
+	    make_field("region", region_index),
+	    make_field("start", 0),
+	    region_start, 0);
+}
+
+int ps3_repository_read_stor_dev_info(unsigned int bus_index,
+	unsigned int dev_index, u64 *port, u64 *blk_size,
+	u64 *num_blocks, unsigned int *num_regions)
+{
+	int result;
+
+	result = ps3_repository_read_stor_dev_port(bus_index, dev_index, port);
+	if (result)
+	    return result;
+
+	result = ps3_repository_read_stor_dev_blk_size(bus_index, dev_index,
+		blk_size);
+	if (result)
+	    return result;
+
+	result = ps3_repository_read_stor_dev_num_blocks(bus_index, dev_index,
+		num_blocks);
+	if (result)
+	    return result;
+
+	result = ps3_repository_read_stor_dev_num_regions(bus_index, dev_index,
+		num_regions);
+	return result;
+}
+
+int ps3_repository_read_stor_dev_region(unsigned int bus_index,
+	unsigned int dev_index, unsigned int region_index,
+	unsigned int *region_id, u64 *region_start, u64 *region_size)
+{
+	int result;
+
+	result = ps3_repository_read_stor_dev_region_id(bus_index, dev_index,
+		region_index, region_id);
+	if (result)
+	    return result;
+
+	result = ps3_repository_read_stor_dev_region_start(bus_index, dev_index,
+		region_index, region_start);
+	if (result)
+	    return result;
+
+	result = ps3_repository_read_stor_dev_region_size(bus_index, dev_index,
+		region_index, region_size);
+	return result;
+}
+
 int ps3_repository_read_rm_size(unsigned int ppe_id, u64 *rm_size)
 {
 	return read_node(PS3_LPAR_ID_CURRENT,
--- cell--common--7.orig/include/asm-powerpc/ps3.h
+++ cell--common--7/include/asm-powerpc/ps3.h
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/device.h>
+#include <scsi/scsi.h>
 
 /**
  * struct ps3_device_id - HV bus device identifier from the system repository
@@ -255,9 +256,12 @@ enum ps3_bus_type {
 };
 
 enum ps3_dev_type {
+	PS3_DEV_TYPE_STOR_DISK = TYPE_DISK,	/* 0 */
 	PS3_DEV_TYPE_SB_GELIC = 3,
 	PS3_DEV_TYPE_SB_USB = 4,
+	PS3_DEV_TYPE_STOR_ROM = TYPE_ROM,	/* 5 */
 	PS3_DEV_TYPE_SB_GPIO = 6,
+	PS3_DEV_TYPE_STOR_FLASH = TYPE_RBC,	/* 14 */
 };
 
 int ps3_repository_read_bus_str(unsigned int bus_index, const char *bus_str,
@@ -327,21 +331,27 @@ int ps3_repository_find_reg(const struct
 
 /* repository block device info */
 
-int ps3_repository_read_dev_port(unsigned int bus_index,
+int ps3_repository_read_stor_dev_port(unsigned int bus_index,
 	unsigned int dev_index, u64 *port);
-int ps3_repository_read_dev_blk_size(unsigned int bus_index,
+int ps3_repository_read_stor_dev_blk_size(unsigned int bus_index,
 	unsigned int dev_index, u64 *blk_size);
-int ps3_repository_read_dev_num_blocks(unsigned int bus_index,
+int ps3_repository_read_stor_dev_num_blocks(unsigned int bus_index,
 	unsigned int dev_index, u64 *num_blocks);
-int ps3_repository_read_dev_num_regions(unsigned int bus_index,
+int ps3_repository_read_stor_dev_num_regions(unsigned int bus_index,
 	unsigned int dev_index, unsigned int *num_regions);
-int ps3_repository_read_dev_region_id(unsigned int bus_index,
+int ps3_repository_read_stor_dev_region_id(unsigned int bus_index,
 	unsigned int dev_index, unsigned int region_index,
 	unsigned int *region_id);
-int ps3_repository_read_dev_region_size(unsigned int bus_index,
+int ps3_repository_read_stor_dev_region_size(unsigned int bus_index,
 	unsigned int dev_index,	unsigned int region_index, u64 *region_size);
-int ps3_repository_read_dev_region_start(unsigned int bus_index,
+int ps3_repository_read_stor_dev_region_start(unsigned int bus_index,
 	unsigned int dev_index, unsigned int region_index, u64 *region_start);
+int ps3_repository_read_stor_dev_info(unsigned int bus_index,
+	unsigned int dev_index, u64 *port, u64 *blk_size,
+	u64 *num_blocks, unsigned int *num_regions);
+int ps3_repository_read_stor_dev_region(unsigned int bus_index,
+	unsigned int dev_index, unsigned int region_index,
+	unsigned int *region_id, u64 *region_start, u64 *region_size);
 
 /* repository pu and memory info */
 
