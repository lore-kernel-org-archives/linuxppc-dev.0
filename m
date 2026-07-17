Return-Path: <linuxppc-dev+bounces-24399-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781FFC44516
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:30:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h24Nd6xwZz3c8m;
	Sat, 18 Jul 2026 08:30:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784327409;
	cv=pass; b=Ms63DbKq1Q3bfDD9yo6j2YJCjV/EioloVTw7ZbQkOe1pJJ26AOjtzXo88JydaNwZkMr6iFJLvAR/QtPmJsaDJteNXvYBZx6fMm+AAlfEqQnhmrhejwh7elhRlcgvAvcw2PQME4mnq4AHzP9h2mMysEja9WaWEHfh0cVem8Dt3L7gid1YY5/sQhgBY2i+rlLbJxaYPZ1JAoX5u8uHoOJHiWkK/qthyNzl8I2jbM3bSnc1ICRbuAQxdww+PGDpDpLF2XFbpwIRfB1JmuPxD6d9iL+od744H4IPokv+g1rnyfvWkCT403VF97SmBSdiNXTH5iJlVCQ7pWEnuTCb7Jyrww==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784327409; c=relaxed/relaxed;
	bh=cKF5y+2gGEbvWyt/LekeB4GebBCjHiNEXm8JyzuIwlg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0WuLX30Cmz3rOpi9mOyz3iTCGha5VOWncJ3EW6Ih/9QHIBerl5VyYva5ah9pJe2whhd8ZQUDsAXSd0wByreXJXTROCZxfyKV9pTIU1P/x1bsHZ1Lc9a/Dxjv97AYGCzS6eNQ/XijJW8FXGG4z2vnxttUrhkSZaX0DsoJMAFuadfWUE97ShHdRq43wh0sRSgxLM3jOgTMQnl2OV6XpkZl5lRVLI18YxjehOyZUNFLuaME2t3LEhfeuE7P9B//XZhzla/z83MRUNLLTozb3jP1hNZVHMMawpw0zyKetoCnaVcbO/e3n9D86VLE7y6N2cOo+13b7uQsL+71wZko/DIQw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=j1/GfsBZ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=j1/GfsBZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h24Nc0NbQz3c6c
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:30:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmHR2+SGEkQcet+ncJvjvVQZiigIJl0kYxrf0ej7ouFH7/DcrKpuHUAuRI3PJLpSmXAuE4xXq2kouWVMVhNGdZeXcLmrhZ/1PtUw88nmCOcLCQL2TgIzPeUe9SSUqcZ+zFz27w2A8VJhpbdkIiqxzi87zcvtHWS66P/ZsCFuvUV+uHw8sK2Xp9C24qlSYi7XCHCXGA+MtyPNimY/ZbhJVLIy+nsJg4q1C/E/abEZuI5eqBU01dH22A9hCVZB99EDvEnRdR5N8c/aFRaS0qnwT0MryfFaIurVpduLTA18+ZZQtxlTx2HivuAyZSN4vRpG0FRjzC3uficxN7oxn35GJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKF5y+2gGEbvWyt/LekeB4GebBCjHiNEXm8JyzuIwlg=;
 b=Rrykx5raNo1b4rULEttlUY9iXPFoAcliXuvUTq8piy62+qT7QqM/JLy+1Q1USM3Jb6a+xMd4lMulV5yzgk2qa+ZTLorTCxflK5cqXBvOHxFzzfaQjMtpBT63RHM5dNuBLnQDndvXod7z9oW09fKjXpdlwkohIusgUkSws/zYAlorSMWelTdlpgykami4F/sxiKDEhiXkLueiPq86UBm6t6p2sVSWg8nZRRBqVPM3wlLS6PpZ7m2rezu/pV45PATbJC6tC6PAdRvHwP9nGtjwul4mFKhdlI9FeQ7XcjY5LnrR9TBR8gzJUUklMzstJ6MiJGInJticl1S4ewdRndqIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKF5y+2gGEbvWyt/LekeB4GebBCjHiNEXm8JyzuIwlg=;
 b=j1/GfsBZMa9daIy7MxvvYMSS8dECSZ4SJdyq3nOrUjmeNDdgmv4HKBLUeRVJoS9f9EVyCa8XNVcHp3tX8vizzUiJw5jut0kLC0ig65JirxlNITq4BwXtQtxjgbtzhbCPLHIu8ZwoYE7NKpOLJv4X5ka5wCdDrGclbFzAtCkSsdE=
Received: from SJ0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:33a::6)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 22:29:43 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::2) by SJ0PR03CA0001.outlook.office365.com
 (2603:10b6:a03:33a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 22:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:29:42 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:29:41 -0500
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
Subject: [PATCH v18 13/13] Documentation: cxl: Document CXL protocol error handling
Date: Fri, 17 Jul 2026 17:27:06 -0500
Message-ID: <20260717222706.3540281-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717222706.3540281-1-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c478457-58a0-4541-c04c-08dee452e5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|1800799024|82310400026|10067099003|11063799006|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MR7E0DceO6UJFfxJAdlLUmluRpk5+V/Id0an4w2u3/UFc612dYEJYr9UoCs+86Iz4zaERVOLml+xYgLy7mpZY7+RC/5fTNCgZfbmdR1K3nOCIpgmxGzxypx6SgnwuhJ2eYMIf8IOouZ5sNTzgWfgyHPv2Qvg11/os7QLXjhSR3S6zLpt5fPqXozQ7hbIiDBHZuUrmFT+zX8tpmPdAuzarq0b4/OrrkUNSDPx9UzphzPOtJtkUHsIKe7b7HMDtSJdr0NUlH6+SVzdGAAKLrSjvs6DAB6D1JcQYUKqyHsat64UKg4o9u78FCnWKQbEqRQuKOEBt1FXN3Y8f3AKocSPBa91/GOtojHBWbuyxcHCAHMw+QyJU5mldzGN3AzC/ouEAjjWOpAyatvw83hbuZCYg1a+naTlgDNnBMnLMNyIToLsvFBj+aafcCMDR0lJrJ9bDzJCzOZgPaVm++ySeffyhve2axEeENcaanmpfVyTU1T8GYHwwy/CLB8DqqlxxJhq4YGXuHSHJn775L0/yw2LMeJAwnLM6IlN98BOhIIOvmsBd1qlltcYq2ltQY8GYkf5tWbOXgYO2AObKAdAf5R0Znf8MXIVNyukxENxlY3NoEO4/5iflJhzDqBwYkF76VTjv71JTjsTRKBrS197tSWRnSnhVmJZwxl345zNfaf/XUtt/VanDQzd4kHgWAWRC8zB50HwJodInTwboAGE/G8YPw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l45VvLNuxZdSXToV03htamVrM/e7VKYWTrfdG6CSwlq9txec3apn2+70ZVUlHnwrRPjg9rewkj0wshoaIR7+RWtJZwdOAJgSBMVdcttsz9Xvb2folcjkD5k6dzymtzjhAAws2KlLWBCD2+8iKI58Ch/BN4NmEpSv0GW89BUu9NilImmqWYJ0NE7k83yCEERldBhJLOBiKoNjvV8W04YeIwBCMzw6JleuDqCAC3BdJZNS92He63c1o2+G+DQPGFY0bMxMMdieMDrasxrwHOXQHyYamonKc/jNPreJrfX/ajj/XwniHYYpZ+/I8H0It/UoaCrd7niIUjnrKMbcjWa8dPV3aZIq7upRkFLhw9IeCVfX8kVNkVvR/iJhrJ0ugdvWKq6svWPBUrtyvOQhw06i4LVaRBsRfSul/LhYtoopyQgF8tLDhxBqjqyYZf3/B2fp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:29:42.7281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c478457-58a0-4541-c04c-08dee452e5e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377

Add Documentation/driver-api/cxl/linux/protocol-error-handling.rst
describing the end-to-end CXL protocol error path: AER ingress, the
AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
cases, severity policy, trace events, and a source code map.

This documents the architecture introduced by the preceding patches in
this series.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---
Changes in v17->v18:
- Simplify document for readability (Jonathan)
- Drop historical context that goes stale (Jonathan)
- Shorten ASCII flow diagram (Jonathan)
- Drop manual backtick markup, use automarkup (Jonathan)
- Clarify USP/DSP as single switch component (Dave)
- Fix line wrapping to 80 chars (Jonathan)
---
 Documentation/driver-api/cxl/index.rst        |   1 +
 .../cxl/linux/protocol-error-handling.rst     | 222 ++++++++++++++++++
 2 files changed, 223 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/linux/protocol-error-handling.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 3dfae1d310ca5..6861b2e5726a3 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -42,6 +42,7 @@ that have impacts on each other.  The docs here break up configurations steps.
    linux/dax-driver
    linux/memory-hotplug
    linux/access-coordinates
+   linux/protocol-error-handling
 
 .. toctree::
    :maxdepth: 2
diff --git a/Documentation/driver-api/cxl/linux/protocol-error-handling.rst b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
new file mode 100644
index 0000000000000..67f0492e56702
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
@@ -0,0 +1,222 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+CXL Protocol Error Handling
+==============================
+
+CXL devices report protocol-layer failures (CXL.cachemem RAS) as PCIe
+AER Internal Errors: PCI_ERR_COR_INTERNAL for correctable events and
+PCI_ERR_UNC_INTN for uncorrectable events.  The actual fault
+information lives in CXL RAS capability registers, not in the PCIe AER
+status registers.
+
+The kernel routes every CXL Internal Error through a producer/consumer
+pipeline shared by all CXL device types: Root Ports, Upstream/Downstream
+Switch Ports, Endpoints, and Restricted CXL Devices (RCDs).
+
+
+Architecture
+============
+
+Two error planes run side by side:
+
+* The **PCIe AER plane** handles native PCIe errors (receiver
+  overflows, malformed TLPs, completion timeouts, etc.).
+* The **CXL protocol error plane** handles CXL Internal Errors.
+  The AER core forwards them to cxl_core via a dedicated kfifo;
+  cxl_core reads the CXL RAS registers, emits trace events, and
+  applies recovery/panic policy.
+
+The boundary between the two planes is enforced by is_cxl_error() in
+aer_cxl_vh.c.  It checks info->is_cxl, the PCIe device type
+(Endpoint, Root Port, Upstream, or Downstream), and whether the AER
+status word indicates an internal error.  RC_END devices are excluded
+from is_cxl_error() because they reach the kfifo via the separate
+cxl_rch_handle_error() path instead.
+
+The pipeline:
+
+1. **Producer** (aer_cxl_vh.c, aer_cxl_rch.c) - AER threaded
+   handler context.  Classifies and enqueues a
+   struct cxl_proto_err_work_data into the kfifo.
+2. **Queue** - the AER-CXL kfifo plus a backing work_struct.
+3. **Consumer** (cxl_core/ras.c) - workqueue context.  Resolves
+   the CXL port topology and dispatches to CE/UE handlers.
+
+
+Topologies
+==========
+
+Virtual Hierarchy (VH)
+----------------------
+
+Standard PCIe topology: Root Port, optional switch (Upstream Port with
+one or more Downstream Ports), and Endpoints.  Each component raises
+Internal Errors directly via the Root Port's AER interrupt.
+
+Producer: cxl_forward_error() in aer_cxl_vh.c.
+
+Restricted CXL Host (RCH)
+--------------------------
+
+A Root Complex Event Collector (RCEC) aggregates errors from RCDs
+attached as Root Complex Integrated Endpoints.  The AER driver
+iterates RCDs beneath the RCEC via pcie_walk_rcec() and forwards
+each qualifying device through cxl_forward_error() into the same
+kfifo.
+
+Producer: cxl_forward_error() in aer_cxl_vh.c, called from
+cxl_rch_handle_error_iter() via pcie_walk_rcec().
+
+
+Error flow
+==========
+
+.. code-block:: text
+
+   CXL device raises AER Internal Error
+   (PCI_ERR_COR_INTERNAL or PCI_ERR_UNC_INTN)
+                   |
+                   v
+   +--------------------------------------+
+   | AER core (aer.c)                     |
+   |  aer_irq() -> aer_isr()             |
+   |  -> find_source_device()             |
+   |  -> handle_error_source(dev, info)   |
+   +--------------------------------------+
+                   |
+                   v
+   +--------------------------------------+
+   | handle_error_source() dispatch       |
+   |                                      |
+   |  1. cxl_rch_handle_error()           |
+   |     [always; filters internally]     |
+   |                                      |
+   |  2. if is_cxl_error():              |
+   |       cxl_forward_error()            |
+   |       [enqueue to kfifo]             |
+   |                                      |
+   |  3. if cxl_pending && non-CE:        |
+   |       cxl_proto_err_flush()          |
+   |       [sync drain before recovery]   |
+   |                                      |
+   |  4. pci_aer_handle_error() [always]  |
+   +--------------------------------------+
+                   |
+          (kfifo -> workqueue)
+                   |
+                   v
+   +--------------------------------------+
+   | __cxl_proto_err_work_fn() consumer   |
+   |                                      |
+   |  if is_cxl_restricted(pdev):         |
+   |    cxl_handle_rdport_errors()        |
+   |    [RCH dport RAS first]             |
+   |                                      |
+   |  port = find_cxl_port_by_dev(        |
+   |           &pdev->dev, NULL)           |
+   |  dport = cxl_find_dport_by_dev(      |
+   |           port, &pdev->dev)           |
+   |  [dport NULL for EP/USP; set RP/DSP] |
+   |                                      |
+   |  cxl_handle_proto_error()            |
+   +--------------------------------------+
+            |                |
+            v                v
+   +-----------------+  +--------------------+
+   | CE              |  | UCE                |
+   | cxl_handle_     |  | cxl_do_recovery()  |
+   |   cor_ras()     |  |  read RAS status   |
+   | trace + clear   |  |  trace + panic     |
+   +-----------------+  +--------------------+
+
+cxl_do_recovery() reads the CXL RAS uncorrectable status register.
+If UE bits are set, it emits the trace event and panics.  If no bits
+are set (e.g. RAS mapped but error already cleared), it logs a
+diagnostic and defers to AER recovery.
+
+
+Severity policy
+===============
+
+**CE** - cxl_handle_cor_ras() reads the CXL RAS correctable status
+register, clears set bits, and emits a cxl_aer_correctable_error
+trace event.  No recovery action.
+
+**UCE (non-fatal, and fatal on Root Port/Downstream Port)** - cxl_do_recovery() reads the CXL RAS
+uncorrectable status register.  If UE bits are set, the kernel panics.
+CXL.cachemem traffic cannot be safely recovered once an uncorrectable
+error is signaled; continuing risks silent data corruption across
+interleaved HDM regions.  This panic policy applies to the native AER
+path.  On firmware-first (CPER/GHES) platforms the CPER handler emits
+trace events only and does not call cxl_do_recovery().
+
+**Fatal UCE on EP/USP** - The AER core driver does not read AER status
+registers for Endpoint and Upstream Ports with fatal events because the
+link is down.  Without AER status, is_cxl_error() cannot classify
+the event as a CXL protocol error and it falls through to standard
+AER recovery.
+
+RCH special case
+================
+
+When the consumer sees is_cxl_restricted(pdev), it calls
+cxl_handle_rdport_errors() first to process the RCH Downstream
+Port's RAS registers (accessed via RCRB, not standard config space).
+It then continues to process the RCD Endpoint's own RAS registers
+via the common path.  Both register blocks are checked because
+errors can appear in either independently.
+
+cxl_handle_rdport_errors() acquires the port lock internally.
+Callers must not hold it.
+
+
+Trace events
+============
+
+Two trace events cover all device types and both the native AER and
+CPER/GHES firmware-first paths:
+
+* cxl_aer_correctable_error
+* cxl_aer_uncorrectable_error
+
+Fields:
+
+* ``memdev`` - memdev name for Endpoints; empty for non-Endpoints.
+* ``port`` - CXL port device name.
+* ``dport`` - Downstream Port device name; empty when not applicable.
+* ``host`` - parent host bridge or uport device name.
+* ``serial`` - PCI Device Serial Number from pdev->dsn (cached at
+  enumeration; no config-space read in the error path).
+
+
+Interrupt masking
+=================
+
+CXL Internal Error bits (PCI_ERR_UNC_INTN and PCI_ERR_COR_INTERNAL)
+are unmasked in the AER capability only after the CXL RAS register
+block is successfully mapped.  A devm teardown action restores the
+mask when the port or dport is removed, ensuring clean state after
+driver removal.
+
+
+Source files
+============
+
+.. list-table::
+   :header-rows: 1
+
+   * - File
+     - Role
+   * - drivers/pci/pcie/aer.c
+     - AER core; IRQ, dispatch
+   * - drivers/pci/pcie/aer_cxl_vh.c
+     - VH producer; kfifo
+   * - drivers/pci/pcie/aer_cxl_rch.c
+     - RCH dispatch; RCEC walk
+   * - drivers/cxl/core/ras.c
+     - Consumer; CE/UE handlers; CPER
+   * - drivers/cxl/core/ras_rch.c
+     - RCH dport RAS handling
+   * - drivers/acpi/apei/ghes.c
+     - CPER/GHES kfifo producer
-- 
2.34.1


