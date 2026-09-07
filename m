Return-Path: <linuxppc-dev+bounces-26648-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F27BC79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 05:52:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdbn24HQgz304r;
	Mon, 07 Sep 2026 15:52:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788760326;
	cv=none; b=SY1/M3LksNGumJuAe4qaCiz9OJBQZAGVZJhJHEmg3M9gyr2lbuMjTzf//xOmpoTsEf7kEl++mZAdED8vcKPfeGpufjIQGx2C1nvMvxuueQ4O5wz2h3y+Pw2MBmTWKH8G1I+MQ/hc8VGeD3Ds9plIR3c1KexiCv/aSANj3XssCrFx7+Jc+SLzZcBNdEUNNi3UU17oSvzxQjs3/zg4bj9XP+cZWtrjtUmZiZXv3x4nJCc9APWByVmz//qhWApWnkpn4x/1yc0+RsGgX/v/5tLsQcZMI3FWTkgSt+Zk616Kuqs+6KIryFvPKFU7XUFmv5TDNSqiRcU6Ngmb3gU0NUmciA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788760326; c=relaxed/relaxed;
	bh=cabIh8bSvmgpJ92aslOXLMQtWKnM4WSFGwgl271Nlb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6doiO3NC6mxfQOryltcLjkqjcUDQRGBBtLaV2wSy7o361MHrRKGDXhC7uPqQM0XqXJriq8DByuTZssZjdIgoELHmbnSfCViWmJkUYOt90iyNUXhOIjdTsR6pwVT/VmyAinRDgGw+tjfT3BpTZf3PppD6jFq0i7FyIOtg/i55M2EBuP9i6gi+zA9dgU5WllTce1FtLjhZR9N/l2mlG4anDDWebEqngRR/O4NoODVClGPExayxFCJE4/EQUdwca9OSuwqhub21Qakf/pfv7kDYL1YsfVsA19cObLbimGqMthPABLJ2+7H3/qoxWvkgNWJosJdPMcM1/lQM4cf5VpL1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=YPS8iNbN; dkim-atps=neutral; spf=pass (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org) smtp.mailfrom=weissschuh.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=YPS8iNbN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=weissschuh.net (client-ip=159.69.126.157; helo=todd.t-8ch.de; envelope-from=linux@weissschuh.net; receiver=lists.ozlabs.org)
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdbn12tynz2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 15:52:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1788759912;
	bh=QM1RaMRYf7ZAFUu0L56y/M+PpGDxYRKN1uJfvbRAwN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YPS8iNbNG9RvZGIDsyGJnqtiJcjBQYlGiwc1ROWqNmaL2IOvFrXvtFEUjjxoEc5oi
	 095w1Ju927d8rJzJV5WIeUhrPdy5xmlAIANK0TFNoOSjrMMY0Pg58i2Aie0v3fkE2z
	 tD6+HP/mVW8VGHcpqfadeNvmZxcxREwvMQMWaqIo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 07 Sep 2026 07:45:02 +0200
Subject: [PATCH v2 2/3] drivers: perf: Use __DEVICE_ATTR() macro to
 initialize dev_ext_attribute
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
Message-Id: <20260907-sysfs-const-attr-dev_ext_attr-v2-2-bf53afe57071@weissschuh.net>
References: <20260907-sysfs-const-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net>
In-Reply-To: <20260907-sysfs-const-attr-dev_ext_attr-v2-0-bf53afe57071@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788759912; l=12208;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QM1RaMRYf7ZAFUu0L56y/M+PpGDxYRKN1uJfvbRAwN0=;
 b=ceDGkuw5FvCesHSl7AwX4c6GgQs4jtq7D8STBSAwXKPtd3kbTyAoZ4/HhjydwRLIcF5Cw/uGk
 gWDsUqgs8ddB7q6pRTxFHQAhBSLHxf/waF6uXNDoYT6xdoKfzu6hFHf
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The upcoming constification of the device_show_*() callback
signatures requires the users to handle the transition automatically.

Switch to the __DEVICE_ATTR() macro which can do this.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/perf/alibaba_uncore_drw_pmu.c       |  2 +-
 drivers/perf/arm-cci.c                      |  2 +-
 drivers/perf/arm-ccn.c                      |  2 +-
 drivers/perf/arm_cspmu/arm_cspmu.h          |  2 +-
 drivers/perf/arm_dsu_pmu.c                  |  2 +-
 drivers/perf/arm_spe_pmu.c                  |  6 +++---
 drivers/perf/cxl_pmu.c                      | 10 +++++-----
 drivers/perf/fsl_imx8_ddr_perf.c            |  2 +-
 drivers/perf/fujitsu_uncore_pmu.c           |  2 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c      |  2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h    |  6 +++---
 drivers/perf/hisilicon/hns3_pmu.c           |  6 +++---
 drivers/perf/nvidia_t410_c2c_pmu.c          |  2 +-
 drivers/perf/nvidia_t410_cmem_latency_pmu.c | 12 ++++++------
 drivers/perf/qcom_l3_pmu.c                  |  8 ++++----
 drivers/perf/starfive_starlink_pmu.c        |  2 +-
 drivers/perf/xgene_pmu.c                    |  2 +-
 17 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index fc934bccf4a6..5b6d3a4736da 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -135,7 +135,7 @@ static ssize_t ali_drw_pmu_event_show(struct device *dev,
 
 #define ALI_DRW_PMU_ATTR(_name, _func, _config)                            \
 		(&((struct dev_ext_attribute[]) {                               \
-				{ __ATTR(_name, 0444, _func, NULL), (void *)_config }   \
+				{ __DEVICE_ATTR(_name, 0444, _func, NULL), (void *)_config }   \
 		})[0].attr.attr)
 
 #define ALI_DRW_PMU_FORMAT_ATTR(_name, _config)            \
diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index f0ef0a679e74..71035227f58b 100644
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
index c40da3450c8f..e3411bdf5c7c 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -216,7 +216,7 @@ static void arm_ccn_pmu_config_set(u64 *config, u32 node_xp, u32 type, u32 port)
 
 #define CCN_FORMAT_ATTR(_name, _config) \
 	struct dev_ext_attribute arm_ccn_pmu_format_attr_##_name = \
-			{ __ATTR(_name, S_IRUGO, device_show_string, \
+			{ __DEVICE_ATTR(_name, S_IRUGO, device_show_string, \
 			NULL), _config }
 
 static CCN_FORMAT_ATTR(node, "config:0-7");
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index c4058d602477..93d5b062de8b 100644
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
index bcbd19e075a5..8332eaca06dc 100644
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
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index b70f3fedf028..e298d6d6371e 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -172,9 +172,9 @@ static ssize_t arm_spe_pmu_cap_show_hex(struct device *dev,
 	return sysfs_emit(buf, "0x%llx\n", arm_spe_pmu_cap_get(spe_pmu, cap));
 }
 
-#define SPE_EXT_ATTR_ENTRY(_name, _func, _var)				\
-	&((struct dev_ext_attribute[]) {				\
-		{ __ATTR(_name, S_IRUGO, _func, NULL), (void *)_var }	\
+#define SPE_EXT_ATTR_ENTRY(_name, _func, _var)					\
+	&((struct dev_ext_attribute[]) {					\
+		{ __DEVICE_ATTR(_name, S_IRUGO, _func, NULL), (void *)_var }	\
 	})[0].attr.attr
 
 #define SPE_CAP_EXT_ATTR_ENTRY(_name, _var)				\
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 2c8a03cc11e4..a36cf792a2d0 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -216,11 +216,11 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
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
diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index dd8046265584..7553c5872600 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -214,7 +214,7 @@ static ssize_t ddr_perf_filter_cap_show(struct device *dev,
 
 #define PERF_EXT_ATTR_ENTRY(_name, _func, _var)				\
 	(&((struct dev_ext_attribute) {					\
-		__ATTR(_name, 0444, _func, NULL), (void *)_var		\
+		__DEVICE_ATTR(_name, 0444, _func, NULL), (void *)_var	\
 	}).attr.attr)
 
 #define PERF_FILTER_EXT_ATTR_ENTRY(_name, _var)				\
diff --git a/drivers/perf/fujitsu_uncore_pmu.c b/drivers/perf/fujitsu_uncore_pmu.c
index fa64146fcac6..db90e181b9a8 100644
--- a/drivers/perf/fujitsu_uncore_pmu.c
+++ b/drivers/perf/fujitsu_uncore_pmu.c
@@ -291,7 +291,7 @@ static void fujitsu_uncore_event_read(struct perf_event *event)
 
 #define UNCORE_PMU_FORMAT_ATTR(_name, _config)				      \
 	(&((struct dev_ext_attribute[]) {				      \
-		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),      \
+		{ .attr = __DEVICE_ATTR(_name, 0444, device_show_string, NULL), \
 		  .var = (void *)_config, }				      \
 	})[0].attr.attr)
 
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 0f55d871c67e..0a69d13fa453 100644
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
index bff875f4f625..a41d5712da91 100644
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
index 6c8e41598ec1..da91a51fe29e 100644
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
index e18d0f94e8d8..d036fa05aeab 100644
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
diff --git a/drivers/perf/starfive_starlink_pmu.c b/drivers/perf/starfive_starlink_pmu.c
index 98e5ccee2fdc..d9843645554b 100644
--- a/drivers/perf/starfive_starlink_pmu.c
+++ b/drivers/perf/starfive_starlink_pmu.c
@@ -51,7 +51,7 @@
 
 #define STARLINK_FORMAT_ATTR(_name, _config)				      \
 	(&((struct dev_ext_attribute[]) {				      \
-		{ .attr = __ATTR(_name, 0444, starlink_pmu_sysfs_format_show, NULL), \
+		{ .attr = __DEVICE_ATTR(_name, 0444, starlink_pmu_sysfs_format_show, NULL), \
 		  .var = (void *)_config, }				      \
 	})[0].attr.attr)
 
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index ab3623fab914..104cd0277b58 100644
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


