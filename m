Return-Path: <linuxppc-dev+bounces-24400-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD340C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:57:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h250P3LSHz3bgK;
	Sat, 18 Jul 2026 08:57:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10c::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784329061;
	cv=pass; b=DXmGcM8jUYLPydz3shZXAhUfBPouLl4pBJ/69Fj4z54aszWGF6U71K1ISCGGBH1mO6ypKPZSsXt94uFwMOf7W6q8PWccVyxdEqS8JmSPNfAiDXb6akVA7oGmTGEV4yZi11DlgY4DRPIfGEpzXnc3L0RJzBV0apdq6JvtqspIatwZVFJmuWuFsDW5T4qa3tRFxaCCOxl4xZ+odEDhMHBgn538o0m5gHCk2aOcREPGmKUw3Oc49N9Rcvnxy8yG93m0MFuB/uIO4VqNIgNHix9iIQ5s9flByoHrJ6ZfVtkVAf951rjyqclX1zsJzF1P1gSiSQJKOIoobK8UaeQMj+Ny4w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784329061; c=relaxed/relaxed;
	bh=Kdw1eWIw0zdqEAz/Jt63KIm1sMclqDyW9ru810pYalo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZtcEbqbv/TntxZMbaExuuRWzJsZOLMA8uds5H9z6JKRD0grvYorGY7WNHjdTsFXcrvcx/w61Mz2a1Llrpd6anq+TyVqEGF5Ko6Ts24r4GsGN+7gRbBRrM/swterT1gLgb4S/gcop9NXKoKGBlnzFJxxJfHc52CErjThGHLU5nal5ZN5gDUwU3C6juErVqGE4LSoKGZ5Oe2CjgliTCIkENvsPmF8akmG5qC0iTmgEPlhNKUtd95dyIcsStVKW8BhVqe3JEhPk0RjEQebR4HtuwsJB4dYhrbpxSjHyCJGPacpbROwpHnPPF6B0fIMTHttZiDdiPB3qq/8d1i6fDs16ZA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iw1aw37R; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iw1aw37R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazlp170130001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10c::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h250N021Mz30DH
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:57:39 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEJUaw6nU28JFnNeRwLJO/I3rP5fc0sCtIBVra8LgWhhBcH23Zv1RnGPY3vi+oULUeuEQE3fg99f50zsn8ztPLPLvH0uTLb7JhDtth2Yg9ElGz2wD5M+iF+ldshqqao+BY/aIRTiEoTzz6fchJd1GIwLH+Uuqh8nouRMU6g2skGK9oXwRunGadM8k0twxX6V1+/R5VZ8Ze3+Uf/kxXjusd7d0pdmTlOCWqYtPOOUyn9HER6YsOvVh/WavytVruh5rXpHzVxpl7vSS7Zv5Z/xF/3zE9WNEq8U1g9Z/QfE8HKLsmZY6lgocyP5tjHJoX3TlJ90U2QyjHTCpINpE5D8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kdw1eWIw0zdqEAz/Jt63KIm1sMclqDyW9ru810pYalo=;
 b=YGBsbD2HXpc2y+GUz6PeWmyhzNKld1/l1fkJtFLCoNdqbi4gxYd4O3hUIL3dj0oBjYBsqTOjDTRxfqJ8lZtgdgCtSHgHkQJJiQKfO55PAEXCg8WtIHiHFsi0ns1MU/7FGLAfKxmp0D8C6cXwgXQ0DwjpALhRBh1mhA+kkiF2pL6KbMtO/rIfIbQ/Xm4GtN40SnjSC2xHJFg4l+7CrFB1yfcqQ6gryHHG+fDEOEptT3svYEkjoJPyP8uXh+o92s53QOBlkCUjrFc11GVAC6Yxfw1F0LWKGTqXMhmG98SXkbGZZNDbos0Ai+iTSR8v7WTVlYJny9efO0TTJwnWPIKCmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdw1eWIw0zdqEAz/Jt63KIm1sMclqDyW9ru810pYalo=;
 b=iw1aw37RFQzocD831Z6UVKXj8JkOy+vpl5y3i3WKuG4P1erPAv4wglj5CASXskgRe/D3V6J2wTQ63qyZkilxk+435IH6x/gXyGrwCIBYDx5rnK0R6jZ8FZTF5gA4dlVYWy57LUPKy18keL0S22BGbmNbRybQJPVsl5eDJh/o+q4=
Received: from BLAPR03CA0131.namprd03.prod.outlook.com (2603:10b6:208:32e::16)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Fri, 17 Jul
 2026 22:57:09 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::83) by BLAPR03CA0131.outlook.office365.com
 (2603:10b6:208:32e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 22:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:57:08 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:57:06 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Robert Richter <rrichter@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, "Alejandro
 Lucero" <alucerop@amd.com>, Alison Schofield <alison.schofield@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben
 Cheatham" <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno
 Leitao" <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M .
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
	<gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming <ming.li@zohomail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>, Shiju Jose
	<shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Tony Luck <tony.luck@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>
Subject: [RFC] cxl: Device protocol AER injection
Date: Fri, 17 Jul 2026 17:57:00 -0500
Message-ID: <20260717225700.3543801-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: b346651f-05c9-48b7-1a9e-08dee456bae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|1800799024|36860700016|3023799007|18002099003|5023799004|11063799006|56012099006|10067099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	j0FLxzMVYb3Rj9ctGsaFSLAJE1GC8ogUfckbQGYtyi4xLFxdBY0pZKyiPRu7vGFcKDQqs84Fr2dt2rMS5YNKLMvZO16wD1P712CrbR+/c2edD62n32yEIRvZG1NvOh8r1BIvOaseiUlPNoDMkUwXQQGI0LLLdft4fMa7TmKHOHusAhZOTpnmNVflUFu8Ixe10rmp9AIroWTkZFkt7jtUP71SvOPlew4uQ736RLrDGZ58CiIjTYSUj9MJJc1Fcee67EB9eO52JTf+TkKRj3GKt6RubRAqyipD47Eb5R0uVE2FLJ7T2vJTfnovlJwqsUxcKbUEu9UD2/bUo5TTVOPox2NWv/6etFaJhg4I7bRrWTPWon5Do5BnL0N7FXyPkfkNxwrQQuXKiIkYZMFNrS8tvNSWDNdOXegIOneGoTs4vlZ3ieRCSQxvBUT1BSOfr2dOMWuFy1cbW9tPpgTB0hB5zBu21BuTSBwxs6x5EZTr1i/F8RG6C7toVN4VEIfg7pCo242TxngfhZV7IWkDDbqwRYe6wYoRGBYub33ENweeSQX7IsqAyVd1k0n5U8TVVg4xKHYCG8crZ3gChrre0ku+nTd28krdNkyrxxEfF6hjW6y7LZhBQUp1s2nSAJpPSzP7aj0AeaiD87e3iScJDG18KEs69H2GZ5E1Qg8dS2PpN+1PmTAJrtDJRvN1OJgHOrZ+5q5Lr7DYe8QNEm9Bq/3HwA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(1800799024)(36860700016)(3023799007)(18002099003)(5023799004)(11063799006)(56012099006)(10067099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wwWr7Tzvg9l9v8ZDnhxP5/W0OnEX4dVlwg2fgpklHaDO+6GevY+1vkswMnG7de8hgxppoCy3TsUm4fxY00fnpl7gPY8VjVDp2AYlOPgFtvZAIhTCJl+ucMsgyJXt8ZaJB4am4drhkBD5z9ZvWEs8LAmhDJqjZnRZXapzQ7Qqm+UEUaDXBHRikKk6P027go0rP+cPt9qiRgkVoIF4pkBVGLHi/LUsNewYWT9qnAs2wC1iVs+10ITh3l4YraB15enuYvMdE8zrGfz8yJyyNGz0dNTqrFUqq5vakmrjsN5jWXqev2gVzRzT+/0kPOHFZfGJoCmiI7F0oW15ZemK/N2F2ahM+uXXnJ3L8UU3+/wvdW/9T+Jlolx2WdlSONTxOySYI2L+vTyEGZ58dZwappEPcT4QS8kwYO6Dzp8/VYWNAtLau+1L3s2AYI7+cvxpr0Um
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:57:08.6919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b346651f-05c9-48b7-1a9e-08dee456bae9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902

This patch is intended to provide a method of testing the recently submitted
cxl series "cxl: Enable CXL PCIe Port Protocol Error handling and logging" found
here:

https://lore.kernel.org/linux-cxl/20260717222706.3540281-1-terry.bowman@amd.com/T/#md90ec1fdd1b374bf1e32e7736e2b3e34b328c701

The changes in this patch will allow CXL RAS protocol testing by injecting
AER errors using AER EINJ. The RAS register block status is updated
using a central function to augment RAS register block returned by
to_ras_base(). This supports all CXL devices including Root Ports,
Upstream Switch Ports, Downstream Switch Ports, Endpoints, and RCH
Downstream Ports.

Add debugfs-based CXL protocol error injection for testing CXL RAS
error handling paths. Injects CXL RAS protocol errors using AER internal
error inject interface via /sys/kernel/debug/cxl/aer_einj_inject.

RAS CXL status is set using to_ras_base() function override when kernel config
CONFIG_CXL_PROTO_AER_EINJ is enabled.

Usage:
  echo "DDDD:BB:DD.F [UCE|CE] AER_STATUS RAS_STATUS [RCH]" > \
      /sys/kernel/debug/cxl/aer_einj_inject

Move struct aer_error_inj and aer_inject() to linux/aer.h so CXL
can invoke AER injection directly. Export aer_inject() with
EXPORT_SYMBOL_GPL.

Make cxl_debugfs non-static in port.c and declare it extern in
core.h so the debugfs file can be created under the existing CXL
debugfs root.

Co-developed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/Kconfig           |  13 +++
 drivers/cxl/core/core.h       |  21 ++++
 drivers/cxl/core/port.c       |   2 +-
 drivers/cxl/core/ras.c        | 208 ++++++++++++++++++++++++++++++++++
 drivers/cxl/core/ras_rch.c    |  12 ++
 drivers/pci/pcie/aer_inject.c |  29 ++---
 include/linux/aer.h           |  15 +++
 7 files changed, 281 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd7..ef449228b2549 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -238,6 +238,19 @@ config CXL_RAS
 	def_bool y
 	depends on ACPI_APEI_GHES && PCIEAER && CXL_BUS
 
+config CXL_PROTO_AER_EINJ
+	bool "CXL: RAS Protocol Error Injection using AER EINJ"
+	depends on CXL_RAS
+	depends on PCIEAER_INJECT
+	help
+	  Enable debugfs-based CXL protocol error injection. Writes to
+	  /sys/kernel/debug/cxl/aer_einj_inject inject CXL RAS protocol
+	  errors using the AER internal error inject interface.
+
+	  This is a debug/test facility. Say N for production kernels.
+
+	  If unsure say N.
+
 config CXL_ATL
 	def_bool y
 	depends on CXL_REGION
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a55a4e409feda..91910d2bb5d39 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -182,6 +182,9 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
 		return port->uport_dev;
 	return &port->dev;
 }
+
+extern struct dentry *cxl_debugfs;
+
 #ifdef CONFIG_CXL_RAS
 void cxl_ras_init(void);
 void cxl_ras_exit(void);
@@ -244,4 +247,22 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
+
+#ifdef CONFIG_CXL_PROTO_AER_EINJ
+
+#define AER_REGISTER_SIZE 5
+#define RAS_REGISTER_SIZE (CXL_RAS_CAPABILITY_LENGTH / sizeof(u32))
+
+struct cxl_aer_einj {
+	int correctable;
+	bool is_rch;
+	struct mutex *lock;
+	struct device *dev;
+	u32 aer_registers[AER_REGISTER_SIZE];
+	u32 ras_registers[RAS_REGISTER_SIZE];
+};
+
+extern struct cxl_aer_einj cxl_aer_einj;
+#endif
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a76f3ee05cba8..79657e5fddaac 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2501,7 +2501,7 @@ const struct bus_type cxl_bus_type = {
 };
 EXPORT_SYMBOL_NS_GPL(cxl_bus_type, "CXL");
 
-static struct dentry *cxl_debugfs;
+struct dentry *cxl_debugfs;
 
 struct dentry *cxl_debugfs_create_dir(const char *dir)
 {
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index d77208af41e03..d41deea899d30 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -3,6 +3,7 @@
 
 #include <linux/pci.h>
 #include <linux/aer.h>
+#include <linux/debugfs.h>
 #include <cxl/event.h>
 #include <cxlmem.h>
 #include <cxlpci.h>
@@ -117,6 +118,195 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
+#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
+
+static DEFINE_MUTEX(cxl_aer_einj_mutex);
+
+struct cxl_aer_einj cxl_aer_einj = {
+	.lock = &cxl_aer_einj_mutex,
+};
+
+static const char cxl_aer_einj_usage[] =
+	"ssss:bb:dd.f [UCE|CE] AER_STATUS RAS_STATUS [RCH]\n";
+
+static int cxl_aer_inject_error(struct pci_dev *pdev, bool correctable,
+				u32 aer_status, u32 ras_status)
+{
+	/* RCD errors are signaled as internal errors on the associated RCEC */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END) {
+		if (!pdev->rcec)
+			return -ENODEV;
+		pdev = pdev->rcec;
+	}
+
+	struct aer_error_inj einj = {
+		.bus = pdev->bus->number,
+		.dev = PCI_SLOT(pdev->devfn),
+		.fn = PCI_FUNC(pdev->devfn),
+		.domain = pci_domain_nr(pdev->bus),
+	};
+	int ret;
+	int aer_offset;
+	int ras_offset;
+
+	if (correctable) {
+		einj.cor_status = aer_status | PCI_ERR_COR_INTERNAL;
+		aer_offset = PCI_ERR_COR_STATUS / sizeof(u32);
+		ras_offset = CXL_RAS_CORRECTABLE_STATUS_OFFSET / sizeof(u32);
+	} else {
+		einj.uncor_status = aer_status | PCI_ERR_UNC_INTN;
+		aer_offset = PCI_ERR_UNCOR_STATUS / sizeof(u32);
+		ras_offset = CXL_RAS_UNCORRECTABLE_STATUS_OFFSET / sizeof(u32);
+	}
+
+	cxl_aer_einj.correctable = correctable;
+	cxl_aer_einj.aer_registers[aer_offset] = aer_status;
+	cxl_aer_einj.ras_registers[ras_offset] = ras_status;
+
+	ret = aer_inject(&einj);
+	if (ret) {
+		pr_err("cxl-einj: aer_inject failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static ssize_t cxl_aer_einj_write(struct file *file,
+				    const char __user *ubuf,
+				    size_t count, loff_t *ppos)
+{
+	char sbdf[16], severity[4], topology[4] = "";
+	unsigned int domain, bus, dev, fn;
+	u32 aer_status, ras_status;
+	struct cxl_dport *dport;
+	char buf[128];
+	int nargs;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (count >= sizeof(buf)) {
+		pr_err("cxl-einj: input too long (%zu bytes, max %zu)\n", count, sizeof(buf) - 1);
+		return -EINVAL;
+	}
+
+	if (copy_from_user(buf, ubuf, count)) {
+		pr_err("cxl-einj: copy_from_user failed\n");
+		return -EFAULT;
+	}
+	buf[count] = '\0';
+
+	nargs = sscanf(buf, "%15s %3s %x %x %3s", sbdf, severity,
+		       &aer_status, &ras_status, topology);
+	if (nargs < 4) {
+		pr_err("cxl-einj: expected format: <SBDF> <UCE|CE> <aer_status> <ras_status>\n");
+		return -EINVAL;
+	}
+
+	if (nargs == 5 && strcmp(topology, "RCH") != 0)
+		return -EINVAL;
+
+	if (strcmp(severity, "UCE") != 0 && strcmp(severity, "CE") != 0) {
+		pr_err("cxl-einj: expected 'UCE' or 'CE', got '%s'\n", severity);
+		return -EINVAL;
+	}
+
+	if (sscanf(sbdf, "%x:%x:%x.%x", &domain, &bus, &dev, &fn) != 4) {
+		pr_err("cxl-einj: invalid SBDF format '%s', expected DDDD:BB:DD.F\n", sbdf);
+		return -EINVAL;
+	}
+
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_domain_bus_and_slot(domain, bus, PCI_DEVFN(dev, fn));
+	if (!pdev) {
+		pr_err("cxl-einj: device %s not found\n", sbdf);
+		return -ENODEV;
+	}
+
+	guard(mutex)(cxl_aer_einj.lock);
+	cxl_aer_einj.dev = NULL;
+
+	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&pdev->dev, &dport);
+	if (!port) {
+		dev_err(&pdev->dev, "cxl-einj: Failed to find CXL Port.\n");
+		return -ENODEV;
+	}
+
+	if (!to_ras_base(port, dport)) {
+		dev_err(&pdev->dev, "cxl-einj: RAS not initialized.\n");
+		return -ENODEV;
+	}
+
+	cxl_aer_einj.is_rch = (nargs == 5 && strcmp(topology, "RCH") == 0);
+	if (!cxl_aer_einj.is_rch)
+		pci_dev_get(pdev);
+	cxl_aer_einj.dev = cxl_aer_einj.is_rch ? pdev->dev.parent : &pdev->dev;
+	ret = cxl_aer_inject_error(pdev, strcmp(severity, "CE") == 0,
+				   aer_status, ras_status);
+	if (ret) {
+		if (!cxl_aer_einj.is_rch)
+			pci_dev_put(pdev);
+		cxl_aer_einj.dev = NULL;
+		pr_err("cxl-einj: injection failed for %s: %d\n", sbdf, ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static ssize_t cxl_aer_einj_read(struct file *file, char __user *ubuf,
+				 size_t count, loff_t *ppos)
+{
+	return simple_read_from_buffer(ubuf, count, ppos,
+				       cxl_aer_einj_usage,
+				       sizeof(cxl_aer_einj_usage) - 1);
+}
+
+static const struct file_operations cxl_ras_error_fops = {
+	.owner		= THIS_MODULE,
+	.read		= cxl_aer_einj_read,
+	.write		= cxl_aer_einj_write,
+	.llseek		= default_llseek,
+};
+
+static void cxl_ras_create_debugfs(struct dentry *dir)
+{
+	debugfs_create_file("aer_einj_inject", 0600, dir, NULL,
+			    &cxl_ras_error_fops);
+}
+
+static void __iomem *to_einj_ras_base(struct cxl_port *port, struct cxl_dport *dport)
+{
+	if (dport) {
+		if (cxl_aer_einj.is_rch) {
+			if (cxl_aer_einj.dev == dport->dport_dev) {
+				cxl_aer_einj.dev = NULL;
+				return (__force void __iomem *)cxl_aer_einj.ras_registers;
+			}
+		} else {
+			if (cxl_aer_einj.dev == dport->dport_dev) {
+				pci_dev_put(to_pci_dev(cxl_aer_einj.dev));
+				cxl_aer_einj.dev = NULL;
+				return (__force void __iomem *)cxl_aer_einj.ras_registers;
+			}
+		}
+	} else if (!cxl_aer_einj.is_rch) {
+		struct device *dev = is_cxl_endpoint(port) ?
+			port->uport_dev->parent : port->uport_dev;
+
+		if (dev_is_pci(dev) && cxl_aer_einj.dev == dev) {
+			pci_dev_put(to_pci_dev(cxl_aer_einj.dev));
+			cxl_aer_einj.dev = NULL;
+			return (__force void __iomem *)cxl_aer_einj.ras_registers;
+		}
+	}
+
+	return NULL;
+}
+#endif
+
 static void cxl_unmask_proto_interrupts(struct device *dev)
 {
 	struct pci_dev *pdev;
@@ -238,6 +428,14 @@ void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
 	if (!port)
 		return NULL;
 
+#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
+	if (cxl_aer_einj.dev) {
+		void __iomem *einj = to_einj_ras_base(port, dport);
+		if (einj)
+			return einj;
+	}
+#endif
+
 	if (dport)
 		return dport->regs.ras;
 
@@ -458,10 +656,20 @@ void cxl_ras_init(void)
 	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
 	cxl_register_proto_err_work(&cxl_proto_err_work,
 				   cxl_proto_err_do_flush);
+#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
+	cxl_ras_create_debugfs(cxl_debugfs);
+#endif
 }
 
 void cxl_ras_exit(void)
 {
 	cxl_unregister_proto_err_work();
 	cxl_cper_unregister_prot_err_work();
+#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
+	if (cxl_aer_einj.dev) {
+		if (!cxl_aer_einj.is_rch)
+			pci_dev_put(to_pci_dev(cxl_aer_einj.dev));
+		cxl_aer_einj.dev = NULL;
+	}
+#endif
 }
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 14bb3bdb2d092..5071cf86e4a68 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -110,6 +110,14 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
 	if (!dport)
 		return;
 
+#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
+	if (cxl_aer_einj.is_rch && cxl_aer_einj.dev) {
+		severity = cxl_aer_einj.correctable ?
+			AER_CORRECTABLE : AER_FATAL;
+		goto handle_ras;
+	}
+#endif
+
 	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
 		return;
 
@@ -117,6 +125,10 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
 		return;
 
 	pci_print_aer(pdev, severity, &aer_regs);
+
+#if IS_ENABLED(CONFIG_CXL_PROTO_AER_EINJ)
+handle_ras:
+#endif
 	if (severity == AER_CORRECTABLE)
 		cxl_handle_cor_ras(dport->port, dport,
 				   to_ras_base(port, dport), pdev->dsn);
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 09bfc7194ef31..b313adef680ae 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -14,6 +14,7 @@
 
 #define dev_fmt(fmt) "aer_inject: " fmt
 
+#include <linux/aer.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -31,19 +32,6 @@
 static bool aer_mask_override;
 module_param(aer_mask_override, bool, 0);
 
-struct aer_error_inj {
-	u8 bus;
-	u8 dev;
-	u8 fn;
-	u32 uncor_status;
-	u32 cor_status;
-	u32 header_log0;
-	u32 header_log1;
-	u32 header_log2;
-	u32 header_log3;
-	u32 domain;
-};
-
 struct aer_error {
 	struct list_head list;
 	u32 domain;
@@ -316,7 +304,7 @@ static int pci_bus_set_aer_ops(struct pci_bus *bus)
 	return 0;
 }
 
-static int aer_inject(struct aer_error_inj *einj)
+int aer_inject(struct aer_error_inj *einj)
 {
 	struct aer_error *err, *rperr;
 	struct aer_error *err_alloc = NULL, *rperr_alloc = NULL;
@@ -332,10 +320,14 @@ static int aer_inject(struct aer_error_inj *einj)
 	dev = pci_get_domain_bus_and_slot(einj->domain, einj->bus, devfn);
 	if (!dev)
 		return -ENODEV;
-	rpdev = pcie_find_root_port(dev);
-	/* If Root Port not found, try to find an RCEC */
-	if (!rpdev)
-		rpdev = dev->rcec;
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
+		rpdev = dev;
+	else {
+		rpdev = pcie_find_root_port(dev);
+		/* If Root Port not found, try to find an RCEC */
+		if (!rpdev)
+			rpdev = dev->rcec;
+	}
 	if (!rpdev) {
 		pci_err(dev, "Neither Root Port nor RCEC found\n");
 		ret = -ENODEV;
@@ -482,6 +474,7 @@ static int aer_inject(struct aer_error_inj *einj)
 	pci_dev_put(dev);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(aer_inject);
 
 static ssize_t aer_inject_write(struct file *filp, const char __user *ubuf,
 				size_t usize, loff_t *off)
diff --git a/include/linux/aer.h b/include/linux/aer.h
index b3657b80564b9..65c22ba597657 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -27,6 +27,21 @@
 struct pci_dev;
 struct work_struct;
 
+struct aer_error_inj {
+	u8 bus;
+	u8 dev;
+	u8 fn;
+	u32 uncor_status;
+	u32 cor_status;
+	u32 header_log0;
+	u32 header_log1;
+	u32 header_log2;
+	u32 header_log3;
+	u32 domain;
+};
+
+int aer_inject(struct aer_error_inj *einj);
+
 struct pcie_tlp_log {
 	union {
 		u32 dw[PCIE_STD_MAX_TLP_HEADERLOG];
-- 
2.34.1


