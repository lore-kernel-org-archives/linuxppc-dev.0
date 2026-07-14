Return-Path: <linuxppc-dev+bounces-24256-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222D7C4450A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 16:58:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h058r038Yz306S;
	Wed, 15 Jul 2026 02:58:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784048283;
	cv=none; b=jtFf6Z3qj0Y9sY7F51n5B52kxZdChmTEMGW7IAnkLaygHUQNti44aj/818RupG4m/ibnGQgYk3bOUwPon1jD64dehCvMo+PTBBwMMX8SaMjyCSuGC5WgDtrMzHn0fuG2ECBNzbj0Ll85hDVV03DWcCOwi7yoQlKA3mtuPwYuouSXchN2E5rJe0jkv9E4piz0dXnP9rL1BSVGrioagTVlfM+nIDjsB6Cb2diIiQSrLQVS00A97dimOpWAZD1TyMYND+3xPaqE/kyU6sRK9PXmrIb2usIi3xtCwSEM0KFHnrunZSxH2Po96PasE5tc+zaH4EODtX9koTIC73yTEgrF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784048283; c=relaxed/relaxed;
	bh=+5Mho4VPuqaUN6/kz43PQ85di8W0mKRXizaFOmtQUSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mdGVQuNd3fKBRB0r46XVpU3AUrMkfE2GjgYWbhO1R+HD1k0ASs92KPh+pMi6kvPR0MklwStsSTGKVOm22FltS6Ea+BlMGVOmF38il1yPMKiI3nXsCtec/2H61c+boZKbh8zwiS0lXSGYxIc6kvVrVC0KEsGl7KgKykO9KiOLdRSz25Y8ZUwdevz12OjNKvxqpgZ5zaJWr8Wiw8yyzSmE19Jfss6wa3X6Gz9BtsFaAFmN0p7Z6gRW5ZrmVGbiBKQ+Vj6wL+GRUcHSKIjJl0KRe8gXHsR64bi81Gvun0n/6r49OuzvIHIYPJtToGvqr0yL9qjX0kVnAbVzzcdXso2oxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=ZiOS6GD2; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=ZiOS6GD2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 359 seconds by postgrey-1.37 at boromir; Wed, 15 Jul 2026 02:58:00 AEST
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h058m49PMz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 02:58:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1784047914;
	bh=0NYj325MCxYfzA0iMFtFlFNm7KVwpEWpQsm1qEOkdJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZiOS6GD2z8CvGbtL0moHrrPujbDO5n6tgv6RfCwYJrs1wGp6CPFXJIc5ew43nmhV2
	 0to+rX9ljKOqdVHsN/XqIZzsELt5CLzdYptOivPMSQ3cIQ+Nd7lHJF5El9WRcmWJUA
	 SMS1lP7vprHJQLaGAhwBfMpj4StwXZx/qNXkRmpQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 14 Jul 2026 18:51:49 +0200
Subject: [PATCH 2/3] drivers: perf: Use __DEVICE_ATTR() macro to initialize
 dev_ext_attribute
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260714-sysfs-const-attr-dev_ext_attr-v1-2-6b2c0435d621@weissschuh.net>
References: <20260714-sysfs-const-attr-dev_ext_attr-v1-0-6b2c0435d621@weissschuh.net>
In-Reply-To: <20260714-sysfs-const-attr-dev_ext_attr-v1-0-6b2c0435d621@weissschuh.net>
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, 
 Yushan Wang <wangyushan12@huawei.com>, Jijie Shao <shaojijie@huawei.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784047913; l=9437;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0NYj325MCxYfzA0iMFtFlFNm7KVwpEWpQsm1qEOkdJ0=;
 b=taFfFE7aDqhB7yKmzGYYYePgDR3Gq0wU8bj7GfGE+vF5SobjgvamevsFQjF1lGuaA4rzQZtbQ
 g8UOoXRQfZaBitkIOv3PDEqpf2XYWku0enMWHxYIssSWEOwfK+bF7zt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The upcoming constification of the device_show_*() callback
signatures requires the users to handle the transition automatically.

Switch to the __DEVICE_ATTR() macro which can do this.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/perf/arm-cci.c                      |  2 +-
 drivers/perf/arm-ccn.c                      |  2 +-
 drivers/perf/arm_cspmu/arm_cspmu.h          |  2 +-
 drivers/perf/arm_dsu_pmu.c                  |  2 +-
 drivers/perf/cxl_pmu.c                      | 10 +++++-----
 drivers/perf/fujitsu_uncore_pmu.c           |  2 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c      |  2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h    |  6 +++---
 drivers/perf/hisilicon/hns3_pmu.c           |  6 +++---
 drivers/perf/nvidia_t410_c2c_pmu.c          |  2 +-
 drivers/perf/nvidia_t410_cmem_latency_pmu.c | 12 ++++++------
 drivers/perf/qcom_l3_pmu.c                  |  8 ++++----
 drivers/perf/xgene_pmu.c                    |  2 +-
 13 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 1cc3214d6b6d..374a00ae4e48 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -132,7 +132,7 @@ static ssize_t __maybe_unused cci_pmu_event_show(struct device *dev,
 
 #define CCI_EXT_ATTR_ENTRY(_name, _func, _config) 				\
 	&((struct dev_ext_attribute[]) {					\
-		{ __ATTR(_name, S_IRUGO, _func, NULL), (void *)_config }	\
+		{ __DEVICE_ATTR(_name, S_IRUGO, _func, NULL), (void *)_config }	\
 	})[0].attr.attr
 
 #define CCI_FORMAT_EXT_ATTR_ENTRY(_name, _config) \
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 8af3563fdf60..955cb5c2b77b 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -217,7 +217,7 @@ static void arm_ccn_pmu_config_set(u64 *config, u32 node_xp, u32 type, u32 port)
 
 #define CCN_FORMAT_ATTR(_name, _config) \
 	struct dev_ext_attribute arm_ccn_pmu_format_attr_##_name = \
-			{ __ATTR(_name, S_IRUGO, device_show_string, \
+			{ __DEVICE_ATTR(_name, S_IRUGO, device_show_string, \
 			NULL), _config }
 
 static CCN_FORMAT_ATTR(node, "config:0-7");
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 3fc5c8d77266..841b04ea02a4 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -23,7 +23,7 @@
 #define ARM_CSPMU_EXT_ATTR(_name, _func, _config)			\
 	(&((struct dev_ext_attribute[]){				\
 		{							\
-			.attr = __ATTR(_name, 0444, _func, NULL),	\
+			.attr = __DEVICE_ATTR(_name, 0444, _func, NULL),\
 			.var = (void *)_config				\
 		}							\
 	})[0].attr.attr)
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 32b0dd7c693b..1d7def95645f 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -69,7 +69,7 @@
 #define DSU_EXT_ATTR(_name, _func, _config)		\
 	(&((struct dev_ext_attribute[]) {				\
 		{							\
-			.attr = __ATTR(_name, 0444, _func, NULL),	\
+			.attr = __DEVICE_ATTR(_name, 0444, _func, NULL),\
 			.var = (void *)_config				\
 		}							\
 	})[0].attr.attr)
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 68a54d97d2a8..4ab3360a9004 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -209,11 +209,11 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
 }
 
 #define CXL_PMU_FORMAT_ATTR(_name, _format)\
-	(&((struct dev_ext_attribute[]) {					\
-		{								\
-			.attr = __ATTR(_name, 0444, device_show_string, NULL),	\
-			.var = (void *)_format					\
-		}								\
+	(&((struct dev_ext_attribute[]) {						\
+		{									\
+			.attr = __DEVICE_ATTR(_name, 0444, device_show_string, NULL),	\
+			.var = (void *)_format						\
+		}									\
 		})[0].attr.attr)
 
 enum {
diff --git a/drivers/perf/fujitsu_uncore_pmu.c b/drivers/perf/fujitsu_uncore_pmu.c
index c3c6f56474ad..b83fdaf59324 100644
--- a/drivers/perf/fujitsu_uncore_pmu.c
+++ b/drivers/perf/fujitsu_uncore_pmu.c
@@ -292,7 +292,7 @@ static void fujitsu_uncore_event_read(struct perf_event *event)
 
 #define UNCORE_PMU_FORMAT_ATTR(_name, _config)				      \
 	(&((struct dev_ext_attribute[]) {				      \
-		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),      \
+		{ .attr = __DEVICE_ATTR(_name, 0444, device_show_string, NULL), \
 		  .var = (void *)_config, }				      \
 	})[0].attr.attr)
 
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index c5394d007b61..2dc19b7c8cbf 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -110,7 +110,7 @@ static ssize_t hisi_pcie_event_sysfs_show(struct device *dev, struct device_attr
 
 #define HISI_PCIE_PMU_FORMAT_ATTR(_name, _format)                              \
 	(&((struct dev_ext_attribute[]){                                       \
-		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),       \
+		{ .attr = __DEVICE_ATTR(_name, 0444, device_show_string, NULL),\
 		  .var = (void *)_format }                                     \
 	})[0].attr.attr)
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index 3ffe6acda653..a4cb9ed7ea20 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -27,9 +27,9 @@
 #define HISI_MAX_COUNTERS	0x18
 #define to_hisi_pmu(p)	(container_of(p, struct hisi_pmu, pmu))
 
-#define HISI_PMU_ATTR(_name, _func, _config)				\
-	(&((struct dev_ext_attribute[]) {				\
-		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }   \
+#define HISI_PMU_ATTR(_name, _func, _config)				     \
+	(&((struct dev_ext_attribute[]) {				     \
+		{ __DEVICE_ATTR(_name, 0444, _func, NULL), (void *)_config } \
 	})[0].attr.attr)
 
 #define HISI_PMU_FORMAT_ATTR(_name, _config)		\
diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index c157f3572cae..88a1129e9b90 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -405,9 +405,9 @@ static ssize_t hns3_pmu_filter_mode_show(struct device *dev,
 	return len;
 }
 
-#define HNS3_PMU_ATTR(_name, _func, _config)				\
-	(&((struct dev_ext_attribute[]) {				\
-		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }	\
+#define HNS3_PMU_ATTR(_name, _func, _config)				     \
+	(&((struct dev_ext_attribute[]) {				     \
+		{ __DEVICE_ATTR(_name, 0444, _func, NULL), (void *)_config } \
 	})[0].attr.attr)
 
 #define HNS3_PMU_FORMAT_ATTR(_name, _format) \
diff --git a/drivers/perf/nvidia_t410_c2c_pmu.c b/drivers/perf/nvidia_t410_c2c_pmu.c
index 411987153ff3..930cb3e8aad2 100644
--- a/drivers/perf/nvidia_t410_c2c_pmu.c
+++ b/drivers/perf/nvidia_t410_c2c_pmu.c
@@ -545,7 +545,7 @@ static struct attribute_group nv_c2c_pmu_peer_attr_group = {
 #define NV_C2C_PMU_EXT_ATTR(_name, _func, _config)			\
 	(&((struct dev_ext_attribute[]){				\
 		{							\
-			.attr = __ATTR(_name, 0444, _func, NULL),	\
+			.attr = __DEVICE_ATTR(_name, 0444, _func, NULL),\
 			.var = (void *)_config				\
 		}							\
 	})[0].attr.attr)
diff --git a/drivers/perf/nvidia_t410_cmem_latency_pmu.c b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
index acb8f5571522..d6e02b70a7cf 100644
--- a/drivers/perf/nvidia_t410_cmem_latency_pmu.c
+++ b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
@@ -435,12 +435,12 @@ static struct attribute_group cmem_lat_pmu_identifier_attr_group = {
 
 /* Format attributes. */
 
-#define NV_PMU_EXT_ATTR(_name, _func, _config)			\
-	(&((struct dev_ext_attribute[]){				\
-		{							\
-			.attr = __ATTR(_name, 0444, _func, NULL),	\
-			.var = (void *)_config				\
-		}							\
+#define NV_PMU_EXT_ATTR(_name, _func, _config)					\
+	(&((struct dev_ext_attribute[]){					\
+		{								\
+			.attr = __DEVICE_ATTR(_name, 0444, _func, NULL),	\
+			.var = (void *)_config					\
+		}								\
 	})[0].attr.attr)
 
 static struct attribute *cmem_lat_pmu_formats[] = {
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index 66e6cabd6fff..d5aa6ace847a 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -609,10 +609,10 @@ static void qcom_l3_cache__event_read(struct perf_event *event)
 
 /* formats */
 
-#define L3CACHE_PMU_FORMAT_ATTR(_name, _config)				      \
-	(&((struct dev_ext_attribute[]) {				      \
-		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),      \
-		  .var = (void *) _config, }				      \
+#define L3CACHE_PMU_FORMAT_ATTR(_name, _config)				        \
+	(&((struct dev_ext_attribute[]) {				        \
+		{ .attr = __DEVICE_ATTR(_name, 0444, device_show_string, NULL), \
+		  .var = (void *) _config, }				        \
 	})[0].attr.attr)
 
 static struct attribute *qcom_l3_cache_pmu_formats[] = {
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 33b5497bdc06..3f23611fd4c7 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -164,7 +164,7 @@ enum xgene_pmu_dev_type {
  */
 #define XGENE_PMU_FORMAT_ATTR(_name, _config)		\
 	(&((struct dev_ext_attribute[]) {		\
-		{ .attr = __ATTR(_name, S_IRUGO, device_show_string, NULL), \
+		{ .attr = __DEVICE_ATTR(_name, S_IRUGO, device_show_string, NULL), \
 		  .var = (void *) _config, }		\
 	})[0].attr.attr)
 

-- 
2.55.0


