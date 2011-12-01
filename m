Return-Path: <geoff@infradead.org>
Subject: [PATCH 6/8 v2] powerpc/ps3: Fix PS3 repository build warnings
From: Geoff Levand <geoff@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <CAMuHMdUjOXLskrRXYYO1Esd75W4Z=WS3srT0+qFF66DfLeQQmA@mail.gmail.com>
References: <cover.1322615824.git.geoff@infradead.org>
 <0b0c0efa6cca6e5e169b4b3e81373a3bab75716a.1322615824.git.geoff@infradead.org>
 <CAMuHMdUjOXLskrRXYYO1Esd75W4Z=WS3srT0+qFF66DfLeQQmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 1 Dec 2011 10:58:58 -0800
Message-ID: <1322765938.3037.351.camel@gum>
MIME-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix some PS3 repository.c build warnings when DEBUG is
defined. Also change most pr_debug calls to pr_devel calls.

Fixes warnings like these:

  format '%lx' expects type 'long unsigned int', but argument 7 has type 'u64'

Signed-off-by: Geoff Levand <geoff@infradead.org>
---

Hi Ben,

I rebased my for-powerpc branch to include this update.

-Geoff

v2: - Format u64 is using the "ll" length modifier (thanks Geert).
    - Convert pr_debug to pr_devel.

 arch/powerpc/platforms/ps3/repository.c |  135 ++++++++++++++++---------------
 1 files changed, 68 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index cb68729..7bdfea3 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -44,7 +44,7 @@ static void _dump_field(const char *hdr, u64 n, const char *func, int line)
 		s[i] = (in[i] <= 126 && in[i] >= 32) ? in[i] : '.';
 	s[i] = 0;
 
-	pr_debug("%s:%d: %s%016llx : %s\n", func, line, hdr, n, s);
+	pr_devel("%s:%d: %s%016llx : %s\n", func, line, hdr, n, s);
 #endif
 }
 
@@ -53,7 +53,7 @@ static void _dump_field(const char *hdr, u64 n, const char *func, int line)
 static void _dump_node_name(unsigned int lpar_id, u64 n1, u64 n2, u64 n3,
 	u64 n4, const char *func, int line)
 {
-	pr_debug("%s:%d: lpar: %u\n", func, line, lpar_id);
+	pr_devel("%s:%d: lpar: %u\n", func, line, lpar_id);
 	_dump_field("n1: ", n1, func, line);
 	_dump_field("n2: ", n2, func, line);
 	_dump_field("n3: ", n3, func, line);
@@ -65,13 +65,13 @@ static void _dump_node_name(unsigned int lpar_id, u64 n1, u64 n2, u64 n3,
 static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
 	u64 v1, u64 v2, const char *func, int line)
 {
-	pr_debug("%s:%d: lpar: %u\n", func, line, lpar_id);
+	pr_devel("%s:%d: lpar: %u\n", func, line, lpar_id);
 	_dump_field("n1: ", n1, func, line);
 	_dump_field("n2: ", n2, func, line);
 	_dump_field("n3: ", n3, func, line);
 	_dump_field("n4: ", n4, func, line);
-	pr_debug("%s:%d: v1: %016llx\n", func, line, v1);
-	pr_debug("%s:%d: v2: %016llx\n", func, line, v2);
+	pr_devel("%s:%d: v1: %016llx\n", func, line, v1);
+	pr_devel("%s:%d: v2: %016llx\n", func, line, v2);
 }
 
 /**
@@ -135,7 +135,7 @@ static int read_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
 		&v2);
 
 	if (result) {
-		pr_debug("%s:%d: lv1_read_repository_node failed: %s\n",
+		pr_warn("%s:%d: lv1_read_repository_node failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 		dump_node_name(lpar_id, n1, n2, n3, n4);
 		return -ENOENT;
@@ -149,10 +149,10 @@ static int read_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
 		*_v2 = v2;
 
 	if (v1 && !_v1)
-		pr_debug("%s:%d: warning: discarding non-zero v1: %016llx\n",
+		pr_devel("%s:%d: warning: discarding non-zero v1: %016llx\n",
 			__func__, __LINE__, v1);
 	if (v2 && !_v2)
-		pr_debug("%s:%d: warning: discarding non-zero v2: %016llx\n",
+		pr_devel("%s:%d: warning: discarding non-zero v2: %016llx\n",
 			__func__, __LINE__, v2);
 
 	return 0;
@@ -323,16 +323,16 @@ int ps3_repository_find_device(struct ps3_repository_device *repo)
 	result = ps3_repository_read_bus_num_dev(tmp.bus_index, &num_dev);
 
 	if (result) {
-		pr_debug("%s:%d read_bus_num_dev failed\n", __func__, __LINE__);
+		pr_devel("%s:%d read_bus_num_dev failed\n", __func__, __LINE__);
 		return result;
 	}
 
-	pr_debug("%s:%d: bus_type %u, bus_index %u, bus_id %llu, num_dev %u\n",
+	pr_devel("%s:%d: bus_type %u, bus_index %u, bus_id %llu, num_dev %u\n",
 		__func__, __LINE__, tmp.bus_type, tmp.bus_index, tmp.bus_id,
 		num_dev);
 
 	if (tmp.dev_index >= num_dev) {
-		pr_debug("%s:%d: no device found\n", __func__, __LINE__);
+		pr_devel("%s:%d: no device found\n", __func__, __LINE__);
 		return -ENODEV;
 	}
 
@@ -340,7 +340,7 @@ int ps3_repository_find_device(struct ps3_repository_device *repo)
 		&tmp.dev_type);
 
 	if (result) {
-		pr_debug("%s:%d read_dev_type failed\n", __func__, __LINE__);
+		pr_devel("%s:%d read_dev_type failed\n", __func__, __LINE__);
 		return result;
 	}
 
@@ -348,12 +348,12 @@ int ps3_repository_find_device(struct ps3_repository_device *repo)
 		&tmp.dev_id);
 
 	if (result) {
-		pr_debug("%s:%d ps3_repository_read_dev_id failed\n", __func__,
+		pr_devel("%s:%d ps3_repository_read_dev_id failed\n", __func__,
 		__LINE__);
 		return result;
 	}
 
-	pr_debug("%s:%d: found: dev_type %u, dev_index %u, dev_id %llu\n",
+	pr_devel("%s:%d: found: dev_type %u, dev_index %u, dev_id %llu\n",
 		__func__, __LINE__, tmp.dev_type, tmp.dev_index, tmp.dev_id);
 
 	*repo = tmp;
@@ -367,14 +367,14 @@ int ps3_repository_find_device_by_id(struct ps3_repository_device *repo,
 	struct ps3_repository_device tmp;
 	unsigned int num_dev;
 
-	pr_debug(" -> %s:%u: find device by id %llu:%llu\n", __func__, __LINE__,
+	pr_devel(" -> %s:%u: find device by id %llu:%llu\n", __func__, __LINE__,
 		 bus_id, dev_id);
 
 	for (tmp.bus_index = 0; tmp.bus_index < 10; tmp.bus_index++) {
 		result = ps3_repository_read_bus_id(tmp.bus_index,
 						    &tmp.bus_id);
 		if (result) {
-			pr_debug("%s:%u read_bus_id(%u) failed\n", __func__,
+			pr_devel("%s:%u read_bus_id(%u) failed\n", __func__,
 				 __LINE__, tmp.bus_index);
 			return result;
 		}
@@ -382,23 +382,23 @@ int ps3_repository_find_device_by_id(struct ps3_repository_device *repo,
 		if (tmp.bus_id == bus_id)
 			goto found_bus;
 
-		pr_debug("%s:%u: skip, bus_id %llu\n", __func__, __LINE__,
+		pr_devel("%s:%u: skip, bus_id %llu\n", __func__, __LINE__,
 			 tmp.bus_id);
 	}
-	pr_debug(" <- %s:%u: bus not found\n", __func__, __LINE__);
+	pr_devel(" <- %s:%u: bus not found\n", __func__, __LINE__);
 	return result;
 
 found_bus:
 	result = ps3_repository_read_bus_type(tmp.bus_index, &tmp.bus_type);
 	if (result) {
-		pr_debug("%s:%u read_bus_type(%u) failed\n", __func__,
+		pr_devel("%s:%u read_bus_type(%u) failed\n", __func__,
 			 __LINE__, tmp.bus_index);
 		return result;
 	}
 
 	result = ps3_repository_read_bus_num_dev(tmp.bus_index, &num_dev);
 	if (result) {
-		pr_debug("%s:%u read_bus_num_dev failed\n", __func__,
+		pr_devel("%s:%u read_bus_num_dev failed\n", __func__,
 			 __LINE__);
 		return result;
 	}
@@ -408,7 +408,7 @@ found_bus:
 						    tmp.dev_index,
 						    &tmp.dev_id);
 		if (result) {
-			pr_debug("%s:%u read_dev_id(%u:%u) failed\n", __func__,
+			pr_devel("%s:%u read_dev_id(%u:%u) failed\n", __func__,
 				 __LINE__, tmp.bus_index, tmp.dev_index);
 			return result;
 		}
@@ -416,21 +416,21 @@ found_bus:
 		if (tmp.dev_id == dev_id)
 			goto found_dev;
 
-		pr_debug("%s:%u: skip, dev_id %llu\n", __func__, __LINE__,
+		pr_devel("%s:%u: skip, dev_id %llu\n", __func__, __LINE__,
 			 tmp.dev_id);
 	}
-	pr_debug(" <- %s:%u: dev not found\n", __func__, __LINE__);
+	pr_devel(" <- %s:%u: dev not found\n", __func__, __LINE__);
 	return result;
 
 found_dev:
 	result = ps3_repository_read_dev_type(tmp.bus_index, tmp.dev_index,
 					      &tmp.dev_type);
 	if (result) {
-		pr_debug("%s:%u read_dev_type failed\n", __func__, __LINE__);
+		pr_devel("%s:%u read_dev_type failed\n", __func__, __LINE__);
 		return result;
 	}
 
-	pr_debug(" <- %s:%u: found: type (%u:%u) index (%u:%u) id (%llu:%llu)\n",
+	pr_devel(" <- %s:%u: found: type (%u:%u) index (%u:%u) id (%llu:%llu)\n",
 		 __func__, __LINE__, tmp.bus_type, tmp.dev_type, tmp.bus_index,
 		 tmp.dev_index, tmp.bus_id, tmp.dev_id);
 	*repo = tmp;
@@ -443,18 +443,18 @@ int __devinit ps3_repository_find_devices(enum ps3_bus_type bus_type,
 	int result = 0;
 	struct ps3_repository_device repo;
 
-	pr_debug(" -> %s:%d: find bus_type %u\n", __func__, __LINE__, bus_type);
+	pr_devel(" -> %s:%d: find bus_type %u\n", __func__, __LINE__, bus_type);
 
 	repo.bus_type = bus_type;
 	result = ps3_repository_find_bus(repo.bus_type, 0, &repo.bus_index);
 	if (result) {
-		pr_debug(" <- %s:%u: bus not found\n", __func__, __LINE__);
+		pr_devel(" <- %s:%u: bus not found\n", __func__, __LINE__);
 		return result;
 	}
 
 	result = ps3_repository_read_bus_id(repo.bus_index, &repo.bus_id);
 	if (result) {
-		pr_debug("%s:%d read_bus_id(%u) failed\n", __func__, __LINE__,
+		pr_devel("%s:%d read_bus_id(%u) failed\n", __func__, __LINE__,
 			 repo.bus_index);
 		return result;
 	}
@@ -469,13 +469,13 @@ int __devinit ps3_repository_find_devices(enum ps3_bus_type bus_type,
 
 		result = callback(&repo);
 		if (result) {
-			pr_debug("%s:%d: abort at callback\n", __func__,
+			pr_devel("%s:%d: abort at callback\n", __func__,
 				__LINE__);
 			break;
 		}
 	}
 
-	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	pr_devel(" <- %s:%d\n", __func__, __LINE__);
 	return result;
 }
 
@@ -489,7 +489,7 @@ int ps3_repository_find_bus(enum ps3_bus_type bus_type, unsigned int from,
 	for (i = from; i < 10; i++) {
 		error = ps3_repository_read_bus_type(i, &type);
 		if (error) {
-			pr_debug("%s:%d read_bus_type failed\n",
+			pr_devel("%s:%d read_bus_type failed\n",
 				__func__, __LINE__);
 			*bus_index = UINT_MAX;
 			return error;
@@ -509,7 +509,7 @@ int ps3_repository_find_interrupt(const struct ps3_repository_device *repo,
 	int result = 0;
 	unsigned int res_index;
 
-	pr_debug("%s:%d: find intr_type %u\n", __func__, __LINE__, intr_type);
+	pr_devel("%s:%d: find intr_type %u\n", __func__, __LINE__, intr_type);
 
 	*interrupt_id = UINT_MAX;
 
@@ -521,7 +521,7 @@ int ps3_repository_find_interrupt(const struct ps3_repository_device *repo,
 			repo->dev_index, res_index, &t, &id);
 
 		if (result) {
-			pr_debug("%s:%d read_dev_intr failed\n",
+			pr_devel("%s:%d read_dev_intr failed\n",
 				__func__, __LINE__);
 			return result;
 		}
@@ -535,7 +535,7 @@ int ps3_repository_find_interrupt(const struct ps3_repository_device *repo,
 	if (res_index == 10)
 		return -ENODEV;
 
-	pr_debug("%s:%d: found intr_type %u at res_index %u\n",
+	pr_devel("%s:%d: found intr_type %u at res_index %u\n",
 		__func__, __LINE__, intr_type, res_index);
 
 	return result;
@@ -547,7 +547,7 @@ int ps3_repository_find_reg(const struct ps3_repository_device *repo,
 	int result = 0;
 	unsigned int res_index;
 
-	pr_debug("%s:%d: find reg_type %u\n", __func__, __LINE__, reg_type);
+	pr_devel("%s:%d: find reg_type %u\n", __func__, __LINE__, reg_type);
 
 	*bus_addr = *len = 0;
 
@@ -560,7 +560,7 @@ int ps3_repository_find_reg(const struct ps3_repository_device *repo,
 			repo->dev_index, res_index, &t, &a, &l);
 
 		if (result) {
-			pr_debug("%s:%d read_dev_reg failed\n",
+			pr_devel("%s:%d read_dev_reg failed\n",
 				__func__, __LINE__);
 			return result;
 		}
@@ -575,7 +575,7 @@ int ps3_repository_find_reg(const struct ps3_repository_device *repo,
 	if (res_index == 10)
 		return -ENODEV;
 
-	pr_debug("%s:%d: found reg_type %u at res_index %u\n",
+	pr_devel("%s:%d: found reg_type %u at res_index %u\n",
 		__func__, __LINE__, reg_type, res_index);
 
 	return result;
@@ -1009,7 +1009,7 @@ int ps3_repository_dump_resource_info(const struct ps3_repository_device *repo)
 	int result = 0;
 	unsigned int res_index;
 
-	pr_debug(" -> %s:%d: (%u:%u)\n", __func__, __LINE__,
+	pr_devel(" -> %s:%d: (%u:%u)\n", __func__, __LINE__,
 		repo->bus_index, repo->dev_index);
 
 	for (res_index = 0; res_index < 10; res_index++) {
@@ -1021,13 +1021,13 @@ int ps3_repository_dump_resource_info(const struct ps3_repository_device *repo)
 
 		if (result) {
 			if (result !=  LV1_NO_ENTRY)
-				pr_debug("%s:%d ps3_repository_read_dev_intr"
+				pr_devel("%s:%d ps3_repository_read_dev_intr"
 					" (%u:%u) failed\n", __func__, __LINE__,
 					repo->bus_index, repo->dev_index);
 			break;
 		}
 
-		pr_debug("%s:%d (%u:%u) intr_type %u, interrupt_id %u\n",
+		pr_devel("%s:%d (%u:%u) intr_type %u, interrupt_id %u\n",
 			__func__, __LINE__, repo->bus_index, repo->dev_index,
 			intr_type, interrupt_id);
 	}
@@ -1042,18 +1042,18 @@ int ps3_repository_dump_resource_info(const struct ps3_repository_device *repo)
 
 		if (result) {
 			if (result !=  LV1_NO_ENTRY)
-				pr_debug("%s:%d ps3_repository_read_dev_reg"
+				pr_devel("%s:%d ps3_repository_read_dev_reg"
 					" (%u:%u) failed\n", __func__, __LINE__,
 					repo->bus_index, repo->dev_index);
 			break;
 		}
 
-		pr_debug("%s:%d (%u:%u) reg_type %u, bus_addr %lxh, len %lxh\n",
+		pr_devel("%s:%d (%u:%u) reg_type %u, bus_addr %llxh, len %llxh\n",
 			__func__, __LINE__, repo->bus_index, repo->dev_index,
 			reg_type, bus_addr, len);
 	}
 
-	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	pr_devel(" <- %s:%d\n", __func__, __LINE__);
 	return result;
 }
 
@@ -1063,22 +1063,22 @@ static int dump_stor_dev_info(struct ps3_repository_device *repo)
 	unsigned int num_regions, region_index;
 	u64 port, blk_size, num_blocks;
 
-	pr_debug(" -> %s:%d: (%u:%u)\n", __func__, __LINE__,
+	pr_devel(" -> %s:%d: (%u:%u)\n", __func__, __LINE__,
 		repo->bus_index, repo->dev_index);
 
 	result = ps3_repository_read_stor_dev_info(repo->bus_index,
 		repo->dev_index, &port, &blk_size, &num_blocks, &num_regions);
 	if (result) {
-		pr_debug("%s:%d ps3_repository_read_stor_dev_info"
+		pr_devel("%s:%d ps3_repository_read_stor_dev_info"
 			" (%u:%u) failed\n", __func__, __LINE__,
 			repo->bus_index, repo->dev_index);
 		goto out;
 	}
 
-	pr_debug("%s:%d  (%u:%u): port %lu, blk_size %lu, num_blocks "
-		 "%lu, num_regions %u\n",
-		 __func__, __LINE__, repo->bus_index, repo->dev_index, port,
-		 blk_size, num_blocks, num_regions);
+	pr_devel("%s:%d  (%u:%u): port %llu, blk_size %llu, num_blocks "
+		 "%llu, num_regions %u\n",
+		 __func__, __LINE__, repo->bus_index, repo->dev_index,
+		port, blk_size, num_blocks, num_regions);
 
 	for (region_index = 0; region_index < num_regions; region_index++) {
 		unsigned int region_id;
@@ -1088,19 +1088,20 @@ static int dump_stor_dev_info(struct ps3_repository_device *repo)
 			repo->dev_index, region_index, &region_id,
 			&region_start, &region_size);
 		if (result) {
-			 pr_debug("%s:%d ps3_repository_read_stor_dev_region"
+			 pr_devel("%s:%d ps3_repository_read_stor_dev_region"
 				  " (%u:%u) failed\n", __func__, __LINE__,
 				  repo->bus_index, repo->dev_index);
 			break;
 		}
 
-		pr_debug("%s:%d (%u:%u) region_id %u, start %lxh, size %lxh\n",
+		pr_devel("%s:%d (%u:%u) region_id %u, start %lxh, size %lxh\n",
 			__func__, __LINE__, repo->bus_index, repo->dev_index,
-			region_id, region_start, region_size);
+			region_id, (unsigned long)region_start,
+			(unsigned long)region_size);
 	}
 
 out:
-	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	pr_devel(" <- %s:%d\n", __func__, __LINE__);
 	return result;
 }
 
@@ -1109,7 +1110,7 @@ static int dump_device_info(struct ps3_repository_device *repo,
 {
 	int result = 0;
 
-	pr_debug(" -> %s:%d: bus_%u\n", __func__, __LINE__, repo->bus_index);
+	pr_devel(" -> %s:%d: bus_%u\n", __func__, __LINE__, repo->bus_index);
 
 	for (repo->dev_index = 0; repo->dev_index < num_dev;
 		repo->dev_index++) {
@@ -1118,7 +1119,7 @@ static int dump_device_info(struct ps3_repository_device *repo,
 			repo->dev_index, &repo->dev_type);
 
 		if (result) {
-			pr_debug("%s:%d ps3_repository_read_dev_type"
+			pr_devel("%s:%d ps3_repository_read_dev_type"
 				" (%u:%u) failed\n", __func__, __LINE__,
 				repo->bus_index, repo->dev_index);
 			break;
@@ -1128,15 +1129,15 @@ static int dump_device_info(struct ps3_repository_device *repo,
 			repo->dev_index, &repo->dev_id);
 
 		if (result) {
-			pr_debug("%s:%d ps3_repository_read_dev_id"
+			pr_devel("%s:%d ps3_repository_read_dev_id"
 				" (%u:%u) failed\n", __func__, __LINE__,
 				repo->bus_index, repo->dev_index);
 			continue;
 		}
 
-		pr_debug("%s:%d  (%u:%u): dev_type %u, dev_id %lu\n", __func__,
+		pr_devel("%s:%d  (%u:%u): dev_type %u, dev_id %lu\n", __func__,
 			__LINE__, repo->bus_index, repo->dev_index,
-			repo->dev_type, repo->dev_id);
+			repo->dev_type, (unsigned long)repo->dev_id);
 
 		ps3_repository_dump_resource_info(repo);
 
@@ -1144,7 +1145,7 @@ static int dump_device_info(struct ps3_repository_device *repo,
 			dump_stor_dev_info(repo);
 	}
 
-	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	pr_devel(" <- %s:%d\n", __func__, __LINE__);
 	return result;
 }
 
@@ -1153,7 +1154,7 @@ int ps3_repository_dump_bus_info(void)
 	int result = 0;
 	struct ps3_repository_device repo;
 
-	pr_debug(" -> %s:%d\n", __func__, __LINE__);
+	pr_devel(" -> %s:%d\n", __func__, __LINE__);
 
 	memset(&repo, 0, sizeof(repo));
 
@@ -1164,7 +1165,7 @@ int ps3_repository_dump_bus_info(void)
 			&repo.bus_type);
 
 		if (result) {
-			pr_debug("%s:%d read_bus_type(%u) failed\n",
+			pr_devel("%s:%d read_bus_type(%u) failed\n",
 				__func__, __LINE__, repo.bus_index);
 			break;
 		}
@@ -1173,32 +1174,32 @@ int ps3_repository_dump_bus_info(void)
 			&repo.bus_id);
 
 		if (result) {
-			pr_debug("%s:%d read_bus_id(%u) failed\n",
+			pr_devel("%s:%d read_bus_id(%u) failed\n",
 				__func__, __LINE__, repo.bus_index);
 			continue;
 		}
 
 		if (repo.bus_index != repo.bus_id)
-			pr_debug("%s:%d bus_index != bus_id\n",
+			pr_devel("%s:%d bus_index != bus_id\n",
 				__func__, __LINE__);
 
 		result = ps3_repository_read_bus_num_dev(repo.bus_index,
 			&num_dev);
 
 		if (result) {
-			pr_debug("%s:%d read_bus_num_dev(%u) failed\n",
+			pr_devel("%s:%d read_bus_num_dev(%u) failed\n",
 				__func__, __LINE__, repo.bus_index);
 			continue;
 		}
 
-		pr_debug("%s:%d bus_%u: bus_type %u, bus_id %lu, num_dev %u\n",
+		pr_devel("%s:%d bus_%u: bus_type %u, bus_id %lu, num_dev %u\n",
 			__func__, __LINE__, repo.bus_index, repo.bus_type,
-			repo.bus_id, num_dev);
+			(unsigned long)repo.bus_id, num_dev);
 
 		dump_device_info(&repo, num_dev);
 	}
 
-	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	pr_devel(" <- %s:%d\n", __func__, __LINE__);
 	return result;
 }
 
-- 
1.7.0.4
