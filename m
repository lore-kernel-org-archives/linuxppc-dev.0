Return-Path: <linuxppc-dev+bounces-24387-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EFFC44516
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:27:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h24L342ygz3bxM;
	Sat, 18 Jul 2026 08:27:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c005::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784327275;
	cv=pass; b=HOA1kQ9g79tQMsHFCOYVGXzkEPq0vi417TPoUgyewo1Qav7fbniDQW4WQHelcyyOKYNT0wclmDEeqyzHsfF1tfPCBfv04U0eVXiW+8MvX8g5G/mvhAcU7YbBJ6fuUN0GFvopFMnPuMMtBGDIBAWQcRTEFeRpIxfc1CNC0jqiMv9Es5O0svTN0tRchDVytjyqmFpikJrCvmzUILivCj/YEtEzLY6aiquhOy7+mnuO9Qf+ewHJttjGjosmk3ID/i2mOCwf/9PdFtcZIlHKQ5naaAZkXIkXuogLh3LqBw3VJIaFWEv7XrhBNnaENe++s7bqCFI9WS9XY4iN/fw7x/w6qw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784327275; c=relaxed/relaxed;
	bh=xsx19jZGXjXDjdvOWicMaaLfYr4y6jRCZ+FfIfVy/l0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HRdLRcwWSXuVIKmglNSmnZZuuzt9+u67q0Pjj1UUQQ8WjAAsESRqAALd1iuHfxscs4SZ5/HwZELxr7zK/cOoNbTyjg84ZcOQEObYYUzM5/kg6gEJebQmCu2S6uzbO/VaDedi5Oj95o3nGw+iMlHlR1yVBanTB34kdVdNgIP9eDx41DQVKVTJEJcATvpCZRfZCZFYUr9BW+MccJZnj6YHJkQKNY2sYUF6jknA/khYcyiawEqITJSE/3ueSujXbrQooI+4jDTDnNWH7EHcsmJ5nhYTxC6LR8J9SHaynfaM/eocJpc5llln9v+3L82IeKNAC3nK4pfS12zlhyEKdP8BDQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lsX+K6hw; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lsX+K6hw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c005::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h24Ky7565z2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:27:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHjBh94J030ylWQtHkzHhHu9bSjdUBZwkRuyVNDSKVyDwcHfBDZb9NyiDWcdWqIit7oULOn1eb+hh+iEACJq6t0KqePn7WI5/xw9n1aHcFvRCZVHE3AZJUEOrvR2Y3FXSyw+yiRKAygzpvD6rzY+75PAWrFqcOIncFuTD21rdOJrhognK/NHCab6RNyITUN2g42wrG3TKiKwn65qLOxKdfBXQQVVcALLrIztAXWOSqWWGsi41n/smnSO2JQisVU8YW/srq8e7teMkaKZ7BhXax+ah3GfPU0oycj1f/XXU8wPdDgTM3MM9kGNzy06/B+QWiRpeMIgQ98hbjLtXG8ZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsx19jZGXjXDjdvOWicMaaLfYr4y6jRCZ+FfIfVy/l0=;
 b=doB/qtEs2Z30fDCi7ZPf3PKBNOfjAwtqKAZNCX+x8v9nwO/24paWTcnXmlYPhtH0pyCkvWfpMDjRo0iISNcKbp9NtDdm9MPV8TkqRHad6PcLYoemKeURDSz2dQdall1uy43wPAuTO+4fihaLIYN5Dp1cABIGdvcCYodpkOb4r3ijFaJg4jROOV/F5/BaDToI3RpEQa/Tlzr82lE7KRYuWYFBtxC1lTKlKx4xgtjn1Jxus72TCwVcuFe+InOMyUYV1nJCaiD3n+ZVUtQ8x33vsEp8C1kgxlSCJz0QBcQI4FNjhCGuUsk+1jIMZC0SRtqS9CtEQkqLMiaKgNduN/wulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsx19jZGXjXDjdvOWicMaaLfYr4y6jRCZ+FfIfVy/l0=;
 b=lsX+K6hwJQoxLTFTgdoZA8Kn4GeI9+KxCevQmNi+ywOfJhtUcaC9bJRdj24WLMs/R25MJpCD8g3HLweRJDgPGDplK8oP8MqyOS8Y/mfRuhU0buADKozB5fDtUgVcsLcd8b+Xdrv+PHxLEjb2IzPoBpZ3yUoQblszQHCJlfq4xeE=
Received: from SJ0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:a03:333::32)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 22:27:15 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::9f) by SJ0PR03CA0117.outlook.office365.com
 (2603:10b6:a03:333::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 22:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:27:15 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:27:11 -0500
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
Subject: [PATCH v18 00/13] Enable CXL PCIe Port Protocol Error handling and logging
Date: Fri, 17 Jul 2026 17:26:53 -0500
Message-ID: <20260717222706.3540281-1-terry.bowman@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f6921e-ea78-4cbb-021f-08dee4528de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|7416014|18002099003|3023799007|13003099007|10067099003|5023799004|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZncEHTWseBtV7ANytapVGbhOZH6ZOEC2lvDUGENpI9gwUkeSN0fFalLerTGJLE4aWdCTxSOL12AfJ2/4/XCJ7BvAVcW519T/5IlMa0vQT/4BV0f4bFT0e038sdE8AjJV7978W1sjimCgdXIKXzfsNxuiSIiOUUDGRy8RadS8YBBSpVOAykp0dJtO3kF01HK5YAvN2wVnYZhNLi1/Pb30f6HATdgKEBV+NfOHWItXSJLoLNjwscnFZrXLr2EPrqHYKlI/dnKD8fUKgH7Jhrd/AscBcr9yWIErxoGu8PB0GB2k+2huQu1hFd6Cil4FEYxnc6+y9pIpaXXY+BuuHA+Z6RFHnPIY/ZPVr8ergkLrvmp+8Ke2+LLS50YFQ3Xx3LdqJd/kNKAH5lFAqyG3NtZOKP6UnwKFRVIstv/gRgp47ZxdsYES6iprpFONIw70mUW414OJYwu8d4TARWYAHG3lFXNTLE5fhnuyR0jXoXOQptzNO32pwmbp8oQSfEwPDm+GjYgtZxHb6fQRcymbV5jgFvTsgRuBtOJz84nJVRVH9UyEu77jdypE+F0PNViIiRleaYVsqDCoQ83SU8VIMa6mbg+dh2qNpJAMprqcd5Xy2oNtosMljyGO7duZ7/dFOdBEYKeQrBNaCVYwsuD1yiF5Gsa8ne0CTmssmj5WwKPPlP8G0IDbQwLtIte469WChZR2jxfUDFsG75tXv+1wNSFULQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(7416014)(18002099003)(3023799007)(13003099007)(10067099003)(5023799004)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	riDonnOrre5vA6KjQ0mBrJBu6lnDRaDfV+ScQI9VL1XJvxppJ0GuwiGPrxof3dly4xWWxqEyH8uVXgi0YDWNSXdIY1PVgvWLp5VkY+gbU3FsvDvPfFL+EQFzTrZNEEw35qvL0Cm1sdGP7qjmnuN4+KaRx9QOPHSOxKTP4DJ7fIp0r6TwltptGEJ61aPgggr0pQ/2In4K4x/G3G29+9NJGFG/+sUfZoQM/L+GstnTY7yY9wL+MEw09K6fOI0fPfyHtwh46IhBu+/Qfh5B/0Zzcdy69mHBGbQdgw8OwcWHLSifFLSyX7SRfOemmT0ddIIHPCULMEQaNmYsENv/9vyjs7cyJl4tFC3FCElRM3NNjtp1glf9WCY3avbAe6GDAqgKqDdfOH3WuLIrcf6FxyfBR3coW1M2e/L2E7UUSgK6Zn2ejseyQNS2EnSqcAxMlr8a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:27:15.0956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f6921e-ea78-4cbb-021f-08dee4528de1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212


This patch series enables CXL protocol error handling for both CXL Ports
and CXL Endpoints (EP). The previous revision is available at:

https://lore.kernel.org/linux-cxl/20260505173029.2718246-1-terry.bowman@amd.com/

Today the kernel handles native CXL.cachemem RAS only for Endpoints and
Restricted CXL Host (RCH) Downstream Ports. Root Ports, Upstream Switch
Ports, and Downstream Switch Ports are uncovered. This series introduces
a unified CXL protocol error path for all CXL device types, in both VH
and RCH topologies.

CXL protocol errors are layered as a distinct error plane on top of PCIe
AER. CXL RAS conditions are signaled as PCIe correctable (CE) and
uncorrectable (UCE) Internal AER Errors. The AER driver classifies these
events using pcie_is_cxl() and hands them off to cxl_core through the
AER-CXL kfifo.

The cxl_core driver dequeues each event, resolves the cxl_port topology,
and dispatches to the CE or UCE handler. RCD Endpoints are handled
slightly differently: the RCH Downstream Port's RAS state is processed
first, then the Endpoint's own RAS follows the common path.

PCIe AER errors remain a separate plane and are handled independently.
This series updates the CXL Endpoint AER UCE handler and removes the
Endpoint AER CE handler, which is now redundant since the AER driver
clears and logs CE status itself.

PCI_ERS_RESULT_PANIC, introduced in earlier revisions, has been dropped.
The panic decision is made directly in cxl_do_recovery(): the kernel
panics on any uncorrectable CXL RAS error reported by cxl_handle_ras(),
or earlier on link disconnect.

A fatal UCE on an Upstream Switch Port or Endpoint surfaces through the
AER path rather than the CXL RAS path. USP devices are bound to the PCIe
portdrv driver, so when a USP reports a fatal UCE, the PCIe error handler
provided by portdrv is invoked. PCI config reads to the source device are
expected to fail in this scenario, so the AER core never retrieves
UNCOR_STATUS, and the event cannot be classified as CXL. See the fatal
and non-fatal log excerpts for USP and EP below.

== Patch Details ==

Patch 1 - cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity register
Fix RCH Downstream Port severity classification. Was using
PCI_ERR_ROOT_FATAL_RCV (a Root Error Status bit) instead of uncor_severity
to classify fatal vs non-fatal.

Patch 2 - acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks
Convert cxl_cper_work_lock and cxl_cper_prot_err_work_lock from spinlock_t
to raw_spinlock_t to avoid sleeping-in-hardirq deadlock on PREEMPT_RT kernels.

Patch 3 - cxl: Tighten CPER kfifo registration API and symbol visibility
Replace EXPORT_SYMBOL_NS_GPL() with EXPORT_SYMBOL_FOR_MODULES() for CPER
kfifo helpers. Simplify register/unregister return types to void.

Patch 4 - cxl: Rename find_cxl_port() to find_cxl_port_by_dport()
Renames find_cxl_port() to find_cxl_port_by_dport() to make the lookup
method explicit and consistent with the existing find_cxl_port_by_uport().

Patch 5 - PCI/AER: Introduce AER-CXL protocol error kfifo
Adds the AER-CXL kfifo in drivers/pci/pcie/aer_cxl_vh.c along with the
producer helper cxl_forward_error() and the consumer registration helpers
cxl_register_proto_err_work() and cxl_unregister_proto_err_work(). The
kfifo delivers CXL VH protocol errors from the AER driver to cxl_core.

Patch 6 - PCI: Establish common CXL Port protocol error flow
Dequeues work from the AER-CXL kfifo and establishes a common flow for all
CXL Port protocol error handling. Panics on any uncorrectable CXL RAS
error. The producer dispatch and consumer go live atomically.

Patch 7 - PCI/CXL: Add RCH support to CXL handlers
Folds Restricted CXL Host (RCH) error handling into the common Port flow. An
RCD uncorrectable CXL RAS error now panics, matching the policy applied to
all other CXL devices.

Patch 8 - cxl/pci: Thread port and dport through RAS handling helpers
Refactors cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
cxl_port * and struct cxl_dport * directly, eliminating redundant bus walks on
the error path.

Patch 9 - cxl: Update CXL Endpoint AER handler
Replaces cxl_error_detected() with cxl_pci_error_detected(). Reads CXL RAS
unconditionally; panics on UCE regardless of channel state.

Patch 10 - cxl: Add port and dport identifiers to CXL AER trace events
Passes struct cxl_port * and struct cxl_dport * to trace events. Adds new
"port" and "dport" string fields for all CXL device classes.

Patch 11 - PCI: Cache PCI DSN into pci_dev->dsn during probe
Caches the PCI Device Serial Number at probe time so error handlers and
panic paths avoid live config-space reads.

Patch 12 - PCI/CXL: Mask/Unmask CXL protocol errors
Enables CXL Internal Error reporting on CXL Ports and Endpoints. The unmask
is paired with RAS register block mapping; the mask is registered as a devres
action.

Patch 13 - Documentation: cxl: Document CXL protocol error handling
Adds protocol-error-handling.rst describing the end-to-end CXL protocol
error path.

== Notes ==

- @Bjorn, I kindly request your review for the following patches. Many
  of the changes are to CXL-specific files in the PCI tree:
    Patch 5  - PCI/AER: Introduce AER-CXL protocol error kfifo
    Patch 6  - PCI: Establish common CXL Port protocol error flow
    Patch 7  - PCI/CXL: Add RCH support to CXL handlers
    Patch 11 - PCI: Cache PCI DSN into pci_dev->dsn during probe
    Patch 12 - PCI/CXL: Mask/Unmask CXL protocol errors

- USP/EP fatal UCE follows the AER path because of how the AER core collects
  status. aer_get_device_error_info() only reads PCI_ERR_UNCOR_STATUS for
  Root Ports/RCECs/Downstream Ports or non-fatal severities, where config
  reads to the source are still expected to succeed. For a fatal UCE
  signaled by an upstream component, config reads to that device are
  expected to fail, so UNCOR_STATUS is never retrieved. Without the status
  word, is_cxl_error() cannot classify the event as CXL and the AER path
  handles it.

- Dan's related series addressing RAS setup has more details:
  https://lore.kernel.org/linux-cxl/20260131000403.2135324-1-dan.j.williams@intel.com/

- TODOs for future series:
  - Move aer_cxl_rch.c to cxl/core/ras_rch.c
  - Move RCH traversing for handling from AER driver into CXL driver
  - Support user-defined status masks
  - Add CXL Port traversing in cxl_do_recovery()

== Testing ==

Testing included the following:
- cxl-test
- RCH/RCD AER error injection
- CPER GHES (firmware first)
- VH AER error injection

** The AER error injection is not included in this series but will be posted
as an RFC for review and for others to use. The error injection using AER
will be posted separately as ("cxl: Device protocol AER injection").

Below are the testing results.

=== cxl_test ===
The cxl_test CXL testsuite passed on QEMU with no issues.

This required changes in patch 12 ("PCI/CXL: Mask/Unmask CXL protocol errors").
__wrap_devm_cxl_dport_rch_ras_setup() is introduced to prevent cxl_test from
trying to map the RCH AER/RAS registers.

=== CPER Tests ===
CPER/firmware first error injection was run and passed on real HW using AMD
RAS tool for protocol error injection at the CXL Root Port.

==== Restricted CXL Host (RCH) ====
Error injection tests for RCH devices were run using CXL2.0 Endpoint that enumerate
as a RCiEP.

echo "0000:7f:00.0 CE 00000000 00000002 RCH" > /sys/kernel/debug/cxl/aer_einj_inject

pcieport 0000:40:00.3: aer_inject: Injecting errors 00004000/00000000 into device 0000:40:00.3
pcieport 0000:40:00.3: AER: Correctable error message received from 0000:40:00.3
pcieport 0000:40:00.3: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:40:00.3:   device [1022:14a6] error status/mask=00004000/00002000
pcieport 0000:40:00.3:    [14] CorrIntErr
cxl_aer_correctable_error: memdev= port=root0 dport=pci0000:7f host=ACPI0017:00 serial=0: status: 'Memory Data ECC Error'

echo "0000:7f:00.0 UCE 00000000 00000002 RCH" > /sys/kernel/debug/cxl/aer_einj_inject

pcieport 0000:40:00.3: aer_inject: Injecting errors 00000000/00400000 into device 0000:40:00.3
pcieport 0000:40:00.3: AER: Uncorrectable (Non-Fatal) error message received from 0000:40:00.3
pcieport 0000:40:00.3: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:40:00.3:   device [1022:14a6] error status/mask=00400000/00000000
pcieport 0000:40:00.3:    [22] UncorrIntErr
cxl_aer_uncorrectable_error: memdev= port=root0 dport=pci0000:7f host=ACPI0017:00 serial=0: status: 'Cache Address Parity Error' first_error: 'Cache Address Parity Error'
Kernel panic - not syncing: CXL cachemem error
CPU: 26 UID: 0 PID: 396 Comm: kworker/26:1 Kdump: loaded Not tainted 7.2.0-rc3-tb-00014-g6346be30306a #1363 PREEMPT(lazy)
Hardware name: AMD Corporation ONYX/ONYX, BIOS TOX100HB 12/03/2025
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 vpanic+0x453/0x4b0
 panic+0x56/0x60
 cxl_do_recovery+0x66/0x70 [cxl_core]
 cxl_handle_rdport_errors+0x176/0x190 [cxl_core]
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? update_load_avg+0x5c/0x2b0
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? dequeue_entities+0x160/0xb40
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? pick_task_fair+0x164/0x670
 ? __pfx___cxl_proto_err_work_fn+0x10/0x10 [cxl_core]
 __cxl_proto_err_work_fn+0xea/0x1b0 [cxl_core]
 ? __pfx___cxl_proto_err_work_fn+0x10/0x10 [cxl_core]
 for_each_cxl_proto_err+0x5a/0x80
 cxl_proto_err_work_fn+0x26/0x50 [cxl_core]
 process_one_work+0x16e/0x3a0
 worker_thread+0x172/0x2e0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1bd/0x220
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

==== Restricted CXL Device (RCD) ====
Error injection tests for RCD devices were run using CXL2.0 Endpoint that enumerate
as a RCiEP.

echo "0000:7f:00.0 CE 00000000 00000002" > /sys/kernel/debug/cxl/aer_einj_inject

pcieport 0000:40:00.3: aer_inject: Injecting errors 00004000/00000000 into device 0000:40:00.3
pcieport 0000:40:00.3: AER: Correctable error message received from 0000:40:00.3
pcieport 0000:40:00.3: PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:40:00.3:   device [1022:14a6] error status/mask=00004000/00002000
pcieport 0000:40:00.3:    [14] CorrIntErr            
cxl_aer_correctable_error: memdev=mem0 port=endpoint1 dport= host=0000:7f:00.0 serial=0: status: 'Memory Data ECC Error'

echo "0000:7f:00.0 UCE 00000000 00000002" > /sys/kernel/debug/cxl/aer_einj_inject

pcieport 0000:40:00.3: aer_inject: Injecting errors 00000000/00400000 into device 0000:40:00.3
pcieport 0000:40:00.3: AER: Uncorrectable (Non-Fatal) error message received from 0000:40:00.3
pcieport 0000:40:00.3: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:40:00.3:   device [1022:14a6] error status/mask=00400000/00000000
pcieport 0000:40:00.3:    [22] UncorrIntErr          
cxl_aer_uncorrectable_error: memdev=mem0 port=endpoint1 dport= host=0000:7f:00.0 serial=0: status: 'Cache Address Parity Error' first_error: 'Cache Address Parity Error'
Kernel panic - not syncing: CXL cachemem error
CPU: 26 UID: 0 PID: 394 Comm: kworker/26:1 Kdump: loaded Not tainted 7.2.0-rc3-tb-00014-g6346be30306a #1363 PREEMPT(lazy) 
Hardware name: AMD Corporation ONYX/ONYX, BIOS TOX100HB 12/03/2025
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 vpanic+0x453/0x4b0
 panic+0x56/0x60
 cxl_do_recovery+0x66/0x70 [cxl_core]
 __cxl_proto_err_work_fn+0xa0/0x1b0 [cxl_core]
 ? __pfx___cxl_proto_err_work_fn+0x10/0x10 [cxl_core]
 for_each_cxl_proto_err+0x5a/0x80
 cxl_proto_err_work_fn+0x26/0x50 [cxl_core]
 process_one_work+0x16e/0x3a0
 worker_thread+0x172/0x2e0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1bd/0x220
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

=== Virtual Hierarchy ===
Below are the VH error injection test results using QEMU with CXL AER error
injection via /sys/kernel/debug/cxl/aer_einj_inject on kernel 7.2.0-rc3 based
kernel.
The below QEMU testing uses a CXL Root Port, a CXL Upstream Switch Port, a
CXL Downstream Switch Port, and a CXL Type3 Endpoint as given below.

The sub-topology for the QEMU testing is:

     ---------------------
     | CXL RP - 0C:00.0  |
     ---------------------
	       |
     ---------------------
     | CXL USP - 0D:00.0 |
     ---------------------
	       |
     --------------------
     | CXL DSP - 0E:00.0 |
     --------------------
	       |
     ---------------------
     | CXL EP - 0F:00.0  |
     ---------------------

  Error Injection Test Results Summary:

  | # | Device Type      | BDF     | Test | Result    | AER | RAS | Verdict          |
  |---|------------------|---------|------|-----------|-----|-----|------------------|
  | 1 | Root Port        | 0c:00.0 | CE   | Recovered | OK  | OK  | PASS             |
  | 2 | Root Port        | 0c:00.0 | UCE  | Panic     | OK  | OK  | PASS             |
  | 3 | Upstream Port    | 0d:00.0 | CE   | Recovered | OK  | OK  | PASS             |
  | 4 | Upstream Port    | 0d:00.0 | UCE  | Recovered | OK  | --  | PASS (Known Lim) |
  | 5 | Downstream Port  | 0e:00.0 | CE   | Recovered | OK  | OK  | PASS             |
  | 6 | Downstream Port  | 0e:00.0 | UCE  | Panic     | OK  | OK  | PASS             |
  | 7 | Endpoint         | 0f:00.0 | CE   | Recovered | OK  | OK  | PASS             |
  | 8 | Endpoint         | 0f:00.0 | UCE  | Panic     | OK  | OK  | PASS             |

  Overall: 8/8 PASS

=== Root Port - CE ===

echo "0000:0c:00.0 CE 00000000 00000002" > /sys/kernel/debug/cxl/aer_einj_inject

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0c:00.0
pcieport 0000:0c:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00004000/0000a000
pcieport 0000:0c:00.0:    [14] CorrIntErr
cxl_aer_correctable_error: memdev= port=port1 dport=0000:0c:00.0 host=pci0000:0c serial=0: status: 'Memory Data ECC Error'

=== Root Port - UCE ===

echo "0000:0c:00.0 UCE 00000000 00000002" > /sys/kernel/debug/cxl/aer_einj_inject

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
pcieport 0000:0c:00.0:    [22] UncorrIntErr
cxl_aer_uncorrectable_error: memdev= port=port1 dport=0000:0c:00.0 host=pci0000:0c serial=0: status: 'Cache Address Parity Error' first_error: 'Cache Address Parity Error'
Kernel panic - not syncing: CXL cachemem error
CPU: 58 UID: 0 PID: 409 Comm: kworker/58:1 Not tainted 7.2.0-rc3-tb-00014-g23418142f421 #1291 PREEMPT(lazy)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 vpanic+0x453/0x4b0
 panic+0x56/0x60
 cxl_do_recovery+0x66/0x70 [cxl_core]
 __cxl_proto_err_work_fn+0x9e/0x1b0 [cxl_core]
 ? __pfx___cxl_proto_err_work_fn+0x10/0x10 [cxl_core]
 for_each_cxl_proto_err+0x5a/0x80
 cxl_proto_err_work_fn+0x26/0x50 [cxl_core]
 process_one_work+0x16e/0x3a0
 worker_thread+0x172/0x2e0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1bd/0x220
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error ]---

=== Upstream Switch Port - CE ===

echo "0000:0d:00.0 CE 00000000 00000002" > /sys/kernel/debug/cxl/aer_einj_inject

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0d:00.0
pcieport 0000:0d:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0d:00.0:   device [19e5:a128] error status/mask=00004000/0000a000
pcieport 0000:0d:00.0:    [14] CorrIntErr
cxl_aer_correctable_error: memdev= port=port2 dport= host=0000:0d:00.0 serial=0: status: 'Memory Data ECC Error'

=== Upstream Switch Port - UCE (fatal - AER recovery, known limitation) ===

echo "0000:0d:00.0 UCE 00000000 00000002" > /sys/kernel/debug/cxl/aer_einj_inject

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0d:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0d:00.0
pcieport 0000:0d:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
cxl_pci 0000:0f:00.0: mem0: frozen state error detected, disable CXL.mem
pcieport 0000:0c:00.0: AER: Root Port link has been reset (0)
cxl_pci 0000:0f:00.0: mem0: restart CXL.mem after slot reset
cxl_pci 0000:0f:00.0: mem0: error resume successful
pcieport 0000:0c:00.0: AER: device recovery successful

=== Downstream Port - CE ===

echo "0000:0e:00.0 CE 00000000 00000002" > /sys/kernel/debug/cxl/aer_einj_inject

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0e:00.0
pcieport 0000:0e:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00004000/0000a000
pcieport 0000:0e:00.0:    [14] CorrIntErr
cxl_aer_correctable_error: memdev= port=port2 dport=0000:0e:00.0 host=0000:0d:00.0 serial=0: status: 'Memory Data ECC Error'

=== Downstream Port - UCE ===

echo "0000:0e:00.0 UCE 00000000 00000002" > /sys/kernel/debug/cxl/aer_einj_inject

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0e:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0e:00.0
pcieport 0000:0e:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
pcieport 0000:0e:00.0:   device [19e5:a129] error status/mask=00400000/02000000
pcieport 0000:0e:00.0:    [22] UncorrIntErr          
cxl_aer_uncorrectable_error: memdev= port=port2 dport=0000:0e:00.0 host=0000:0d:00.0 serial=0: status: 'Cache Address Parity Error' first_error: 'Cache Address Parity Error'
Kernel panic - not syncing: CXL cachemem error
CPU: 7 UID: 0 PID: 299 Comm: kworker/7:1 Not tainted 7.2.0-rc3-tb-00014-g832c50e87f10 #1364 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Workqueue: events cxl_proto_err_work_fn [cxl_core]
Call Trace:
 <TASK>
 vpanic+0x453/0x4b0
 panic+0x56/0x60
 cxl_do_recovery+0x66/0x70 [cxl_core]
 __cxl_proto_err_work_fn+0xa0/0x1b0 [cxl_core]
 ? __pfx___cxl_proto_err_work_fn+0x10/0x10 [cxl_core]
 for_each_cxl_proto_err+0x5a/0x80
 cxl_proto_err_work_fn+0x26/0x50 [cxl_core]
 process_one_work+0x16e/0x3a0
 worker_thread+0x172/0x2e0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1bd/0x220
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error ]---

=== Endpoint - CE ===

echo "0000:0f:00.0 CE 00000000 00000002" > /sys/kernel/debug/cxl/aer_einj_inject

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00004000/00000000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Correctable error message received from 0000:0f:00.0
cxl_pci 0000:0f:00.0: CXL Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
cxl_pci 0000:0f:00.0:   device [8086:0d93] error status/mask=00004000/0000a000
cxl_pci 0000:0f:00.0:    [14] CorrIntErr
cxl_aer_correctable_error: memdev=mem1 port=endpoint4 dport= host=0000:0f:00.0 serial=0: status: 'Memory Data ECC Error'

=== Endpoint - UCE ===

echo "0000:0f:00.0 UCE 00000000 00000002" > /sys/kernel/debug/cxl/aer_einj_inject

pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0f:00.0
pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0f:00.0
cxl_pci 0000:0f:00.0: AER: CXL Bus Error: severity=Uncorrectable (Fatal), type=Inaccessible, (Unregistered Agent ID)
cxl_aer_uncorrectable_error: memdev=mem1 port=endpoint4 dport= host=0000:0f:00.0 serial=0: status: 'Cache Address Parity Error' first_error: 'Cache Address Parity Error'
Kernel panic - not syncing: CXL cachemem error
CPU: 58 UID: 0 PID: 430 Comm: irq/24-aerdrv Not tainted 7.2.0-rc3-tb-00014-g23418142f421 #1291 PREEMPT(lazy)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 vpanic+0x453/0x4b0
 panic+0x56/0x60
 cxl_pci_error_detected+0x15c/0x160 [cxl_core]
 report_error_detected+0xc7/0x1c0
 ? __pfx_report_frozen_detected+0x10/0x10
 __pci_walk_bus+0x47/0x70
 ? __pfx_report_frozen_detected+0x10/0x10
 pci_walk_bus+0x2c/0x40
 ? __pfx_aer_root_reset+0x10/0x10
 pcie_do_recovery+0x234/0x330
 ? __pfx_irq_thread_fn+0x10/0x10
 aer_isr_one_error_type+0x333/0x340
 aer_isr_one_error+0x112/0x140
 aer_isr+0x47/0x80
 irq_thread_fn+0x1f/0x60
 irq_thread+0x123/0x220
 ? __pfx_irq_thread_dtor+0x10/0x10
 ? __pfx_irq_thread+0x10/0x10
 kthread+0xe5/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x1bd/0x220
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel Offset: disabled
---[ end Kernel panic - not syncing: CXL cachemem error ]---


== Changes ==

Changes in v17->v18:
 acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks
 - New commit
 - Convert cxl_cper_work_lock and cxl_cper_prot_err_work_lock from
   spinlock_t to raw_spinlock_t; use guard(raw_spinlock_irqsave) at
   all call sites to avoid sleeping-in-hardirq on PREEMPT_RT.
 - Add kfifo_reset(&cxl_cper_fifo) to cxl_cper_unregister_work()
 - Add WARN_ONCE to cxl_cper_register_work() for double-registration consistency
 - Fix cxl_cper_unregister_work() to clear global pointer before cancel_work_sync()
 - Remove redundant cancel_work_sync() from cxl_ras_exit()
 cxl: Tighten CPER kfifo registration API and symbol visibility
 - New commit (split/rework of v17 "Limit CXL-CPER kfifo registration functions scope")
 cxl: Rename find_cxl_port() to find_cxl_port_by_dport()
 - None
 PCI/AER: Introduce AER-CXL protocol error kfifo
 - Remove correctable status clear from cxl_forward_error(); the AER core
   clears all status bits via pci_aer_handle_error() info->status writeback
 - Schedule consumer on kfifo overflow so existing entries can be drained
 PCI: Establish common CXL Port protocol error flow
 - Fix handle_error_source() to call pci_aer_handle_error() unconditionally
   so AER handling always runs after cxl_forward_error()
 - Add cxl_proto_err_flush() call for CXL UCE to drain kfifo before AER
   recovery tears down the device
 - Fix NULL dereference of dport->dport_dev in cxl_handle_cor_ras() and
   cxl_handle_ras() for UPSTREAM/ENDPOINT port types: use dport->dport_dev
   when dport is non-NULL, else fall back to port->uport_dev
 - Remove duplicate pcie_clear_device_status() call from
   cxl_handle_proto_error() CE path; pci_aer_handle_error() already clears it
 - Clarify panic policy: panic only on confirmed UCE via RAS status read
 - Document kfifo consumer serialization against driver unbind via
   guard(device)(&port->dev) and port->dev.driver check
 PCI/CXL: Add RCH support to CXL handlers
 - Pass &pdev->dev instead of dport->port->uport_dev in
   cxl_handle_rdport_errors() to avoid dropping RCH trace events.
 - Document trace event attribution change.
 - Document removal of cxl_cor_error_detected() and cxlds->rcd branches.
 - Capitalize Endpoint per PCI spec convention.
 - Use to_ras_base() in cxl_handle_rdport_errors() to centralize RAS base
   address lookup in preparation for error injection testing.
 cxl/pci: Thread port and dport through RAS handling helpers
 - New commit
 cxl: Update CXL Endpoint AER handler
 - Fix cxl_pci_error_detected() to use find_cxl_port_by_uport() and port->uport_dev
 - Read CXL RAS unconditionally; panic on UCE regardless of channel state
 - Document unconditional read policy and 0xFFFFFFFF behavior in comment
 cxl: Add port and dport identifiers to CXL AER trace events
 - Consolidate double find_cxl_port_by_dev() in cxl_cper_handle_prot_err()
 - Add comment noting dport is NULL for endpoint and upstream port devices
 PCI: Cache PCI DSN into pci_dev->dsn during probe
 - New commit
 PCI/CXL: Mask/Unmask CXL protocol errors
 - Make cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts() static
 - Remove dev_is_pci() guard from devm_cxl_dport_rch_ras_setup(); the guard
   blocked real RCH hardware because pci_host_bridge is not on pci_bus_type
 Documentation: cxl: Document CXL protocol error handling
 - Simplify document for readability (Jonathan)
 - Drop historical context that goes stale (Jonathan)
 - Shorten ASCII flow diagram (Jonathan)
 - Drop manual backtick markup, use automarkup (Jonathan)
 - Clarify USP/DSP as single switch component (Dave)
 - Fix line wrapping to 80 chars (Jonathan)

Changes in v16->v17:
 PCI/AER: Introduce AER-CXL Kfifo
 - Reword "kfifo semaphore" to "kfifo spinlock" to match fifo_lock.
 - Defer the handle_error_source() is_cxl_error() switch to the patch that
   registers the kfifo consumer to keep each commit bisect-safe.
 - Rename rwsema to rwsem
 - Change CPER exports to use EXPORT_SYMBOL_FOR_MODULES.
 - Add work cancel function.
 - Replace kfifo_put() with kfifo_in_spinlocked() for multiple producers
 - Add fifo_lock spinlock for concurrent producer serialisation
 - Initialize the embedded kfifo with INIT_KFIFO() in a subsys_initcall so
   kfifo->mask, ->esize and ->data are set before first use.
 - Clear PCI_ERR_COR_STATUS in cxl_forward_error() before enqueue so the
   device is acked for correctable events even when the consumer drops the
   event. Uncorrectable status is left for cxl_do_recovery() to clear after
   recovery completes, mirroring the AER core convention.
 - WARN on double-registration in cxl_register_proto_err_work() to make an
   unintended second consumer visible at runtime.
 - Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
   in aer_cxl_vh.c
 - Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
 - Update message
 cxl/ras: Unify Endpoint and Port AER trace events
 - Replace cxlds->serial with pci_get_dsn()
 - Change 'memdev' to 'device' (Dan)
 - Updated Commit message
 cxl: Use common CPER handling for all CXL devices
 - New commit
 cxl: Rename find_cxl_port() to find_cxl_port_by_dport()
 - New commit
 - Drop the de-staticisation of find_cxl_port_by_uport() and the
   core.h declarations from this prep patch; both move to the patch
   that introduces the first cross-file caller.
 cxl: Limit CXL-CPER kfifo registration functions scope
 - Split from v16 02/10 ("Update unregistration for AER-CXL and
   CPER-CXL kfifos"); AER-CXL half folded into v17 01/10.
 - Convert exports to EXPORT_SYMBOL_FOR_MODULES("cxl_core").
 - Change register/unregister return type from int to void.
 - Drop work_struct argument from cxl_cper_unregister_prot_err_work();
   it now cancels its own work.
 - Remove now-redundant cancel_work_sync() from cxl_ras_exit().
 - Add WARN_ONCE() in cxl_cper_register_prot_err_work() for
   double-registration.
 PCI: Establish common CXL Port protocol error flow
 - get_cxl_port() -> find_cxl_port_by_dev()
 - Simplified find_cxl_port_by_dev()
 - Replace and remove cxl_serial_number() w/ pci_get_dsn()
 - cxl_get_ras_base() -> to_ras_base()
 - Drop dependency on PCI_ERS_RESULT_PANIC; cxl_do_recovery() panics
   directly. (PANIC enum patch dropped from series.)
 - Clarify panic semantics: panic on any uncorrectable CXL RAS error, not
   only AER-FATAL severities.
 - Drop the redundant PCI_ERR_COR_STATUS RMW in cxl_handle_proto_error();
   cxl_forward_error() already acks the correctable AER status.
 - Add is_cxl_error() switch in handle_error_source() here, paired with the
   kfifo consumer registration, to keep each commit bisect-safe.
 - Drop pcie_aer_is_native() guard in cxl_do_recovery() (always native).
 - Swap order with the "Limit" patch for bisectability w/ cxl_ras_exit()
 - Reword for "any uncorrectable" CXL RAS error panics.
 - Restore log messages for port-not-found and port-unbound cases.
 - Whitespace cleanup (Jonathan)
 - Update to get_cxl_port() documentation (Terry)
 - Fix __cxl_proto_err_work_fn() to return 0 for transient errors.
 - Drop !port check in cxl_do_recovery(), caller already validated
 - Fix kerneldoc @pdev -> @dev in find_cxl_port_by_dev()
 - Fix missing space in pr_err_ratelimited()
 - Add disconnect check before access
 - Made pcie_clear_device_status() and pci_aer_clear_fatal_status()
   EXPORT_SYMBOL_FOR_MODULES("cxl_core") (Dan)
 - Move find_cxl_port_by_dport() and find_cxl_port_by_uport()
   de-staticisation and core.h declarations from the rename patch to
   here, where the first cross-file callers in find_cxl_port_by_dev()
   land.
 PCI/CXL: Add RCH support to CXL handlers
 - Drop now-dead cxlds->rcd branches from cxl_{cor_,}error_detected().
 - Drop duplicate subject line from commit body.
 - Document panic-on-uncorrectable behavior change for RCD path.
 - Document trace event device-name change (memN -> PCI BDF) for RCH path.
 - Rewrite cxl_handle_proto_error() RC_END comment to clarify RCD/RCH shared
   interrupt relationship
 - Rewrite commit message
 cxl: Remove Endpoint AER correctable handler
 - Update commit message
 - Add Reviewed-by from Jonathan and DaveJ
 cxl: Update Endpoint AER uncorrectable handler
 - Rename pci_error_handlers struct instance to cxl_pci_error_handlers to
   avoid shadowing the struct type tag.
 - Restore scoped_guard(device) and dev->driver check around AER read.
 - NULL-check find_cxl_port_by_dev() before deref of port->uport_dev.
 - Updated commit message. (Terry)
 - Add scope cleanup for port variable in cxl_pci_error_detected() (Terry)
 - Drop cxl_uncor_aer_present(), rely on AER state
 PCI/CXL: Mask/Unmask CXL protocol errors
 - Drop redundant cxl_mask_proto_interrupts() calls from unregister_port()
   and cxl_dport_remove(); the devres action registered alongside the unmask
   is the sole mask path.
 - Update title
 - Remove unnecessary check for aer_capabilities
 - Gate cxl_unmask_proto_interrupts() on pcie_aer_is_native()
 - Add pci_aer_mask_internal_errors() and cxl_mask_proto_interrupts()
 - Only unmask on successful cxl_map_component_regs()
 - NULL-check @dev in cxl_{un,}mask_proto_interrupts()
 - Drop static and declare in core/core.h
 Documentation: cxl: Document CXL protocol error handling
 - New commit

Changes in v15->v16:
 PCI/AER: Introduce AER-CXL Kfifo
 - Add pci_dev_put() and comment at pci_dev_get() (Dan)
 - /rw_sema/rwsema/ (Dan)
 - Split validation checks in cxl_forward_error() to allow
   for meaningful reason in log (Terry)
 - Shortened commit title to remove wordiness (Terry)
 PCI/CXL: Update unregistration for AER-CXL and CPER-CXL kfifos
 - New commit
 cxl: Update CXL Endpoint tracing
 - Add Dan's review-by
 - Incorporate Dan's comment into commit message:
   "Add the serial number at the end to preserve compatibility with
   libtraceevent parsing of the parameters."
 PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
 - None
 PCI: Establish common CXL Port protocol error flow
 - get_ras_base(), initialize dport to NULL (Jonathan)
 - Remove guard(device)(&cxlmd->dev) (Jonathan)
 - Fix dev_warns() (Jonathan)
 - Remove comment in cxl_port_error_detected() (Dan)
 - Made pcie_clear_device_status() and pci_aer_clear_fatal_status()
   "CXL" Export namespace (Dan)
 - Update switch-case brackets to follow clang-format (Dan)
 - Add PCI_EXP_TYPE_RC_END for cxl_get_ras_base() (Terry)
 - Add NULL port check in cxl_serial_number() (Terry)
 PCI/CXL: Add RCH support to CXL handlers
 - New commit
 cxl: Update error handlers to support CXL Port devices
 - None
 cxl: Update Endpoint AER uncorrectable handler
 - Update commit message (DaveJ)
 - s/cxl_handle_aer()/cxl_uncor_aer_present()/g (Jonathan)
 - cxl_uncor_aer_present(): Leave original result calculation based on
   if a UCE is present and the provided state (Terry)
 - Add call to pci_print_aer(). AER fails to log because is upstream
   link (Terry)
 cxl: Remove Endpoint AER correctable handler
 - None
 cxl: Enable CXL protocol error reporting
 - None

Changes in v14->v15:
 PCI/AER: Introduce AER-CXL Kfifo in new file, pcie/aer_cxl_vh.c
 - Move pci_dev_get() call to this patch (Dave)
 cxl: Update CXL Endpoint tracing
 - Update commit message
 - Moved cxl_handle_ras/cxl_handle_cor_ras() changes to future patch (Terry)
 PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
 - None
 PCI/AER: Dequeue forwarded CXL error
 - Move pci_dev_get() to cxl_forward_error() (Dave)
 - Move in is_cxl_error() change from later patch (Terry)
 PCI: Establish common CXL Port protocol error flow
 - Update commit message and title. Added Bjorn's ack.
 - Move CE and UCE handling logic here (Terry)
 cxl: Update error handlers to support CXL Port protocol errors
 - New commit (Terry)
 cxl: Update Endpoint AER uncorrectable handler
 - Title update (Terry)
 - Change cxl_pci_error-detected() to handle & log AER (Terry)
 - Update commit message (Terry)
 - Moved cxl_handle_ras()/cxl_handle_cor_ras() to earlier patch (Terry)
 cxl: Remove Endpoint AER correctable handler
 - Remove cxl_pci_cor_error_detected(). Is not needed. AER is logged
   in the AER driver. (Dan)
 - Update commit message

Changes in v13->v14:
 PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - Add Jonathan's and Dan's review-by
 - Update commit title prefix (Bjorn)
 - Revert format fix for cxl_sbr_masked() (Jonathan)
 - Update 'Compute Express Link' comment block (Jonathan)
 - Move PCI_DVSEC_CXL_FLEXBUS definitions to later patch where
   used (Jonathan)
 - Removed stray change (Bjorn)
 PCI: Update CXL DVSEC definitions
 - New patch. Split from previous patch such that there is now a separate
   move patch and a format fix patch.
 - Formatting update requested (Bjorn)
 - Remove PCI_DVSEC_HEADER1_LENGTH_MASK because it duplicates
   PCI_DVSEC_HEADER1_LEN() (Bjorn)
 - Add Dan's review-by
 PCI: Introduce pcie_is_cxl()
 - Move FLEXBUS_STATUS DVSEC here (Jonathan)
 - Remove check for EP and USP (Dan)
 - Update commit message (Bjorn)
 - Fix writing past 80 columns (Bjorn)
 - Add pci_is_pcie() parent bridge check at beginning of function (Bjorn)
 PCI: Replace cxl_error_is_native() with pcie_aer_is_native()
 - New commit
 cxl/pci: Move CXL driver's RCH error handling into core/ras_rch.c
 - Add sign-off for Dan and Jonathan
 - Revert inadvertent formatting of cxl_dport_map_rch_aer() (Jonathan)
 - Remove default value for CXL_RCH_RAS (Dan)
 - Remove unnecessary pci.h include in core.h & ras_rch.c (Jonathan)
 - Add linux/types.h include in ras_rch.c (Jonathan)
 - Change CONFIG_CXL_RCH_RAS -> CONFIG_CXL_RAS (Dan)
 PCI/AER: Export pci_aer_unmask_internal_errors
 - New commit. Bjorn requested separating out and adding immediatetly
   before being used. This is called from cxl_rch_enable_rcec() in
   following patch.
 PCI/AER: Update is_internal_error() to be non-static is_aer_internal_error()
 - New commit
 PCI/AER: Move CXL RCH error handling to aer_cxl_rch.c
 - Add review-by and signed-off for Dan
 - Commit message fixup (Dan)
 - Update commit message with use-case description (Dan, Lukas)
 - Make cxl_error_is_native() static (Dan)
 - Make is_internal_error() non-static, non-export (Terry)
 PCI/AER: Use guard() in cxl_rch_handle_error_iter()
 - Add review-by for Jonathan, Dave Jiang, Dan WIlliams, and Bjorn
 - Remove cleanup.h (Jonathan)
 - Reverted comment removal (Bjorn)
 - Move this patch after pci/pcie/aer_cxl_rch.c creation (Bjorn)
 PCI/AER: Replace PCIEAER_CXL symbol with CXL_RAS
 - New commit
 PCI/AER: Report CXL or PCIe bus type in AER trace logging
 - Merged with Dan's commit. Changes are moving bus_type the last
   parameter in function calls (Dan)
 - Removed all DCOs because of changes (Terry)
 - Update commit message (Bjorn)
 - Add Bjorn's ack-by
 PCI/AER: Update struct aer_err_info with kernel-doc formatting
 - New commit
 cxl/mem: Clarify @host for devm_cxl_add_nvdimm()
 - New commit
 cxl/port: Remove "enumerate dports" helpers
 - New commit
 cxl/port: Fix devm resource leaks around with dport management
 - New commit
 cxl/port: Move dport operations to a driver event
 - New commit
 cxl/port: Move dport RAS reporting to a port resource
 - New commit
 cxl: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Correct message spelling (Terry)
 cxl/port: Move endpoint component register management to cxl_port
 - Correct message spelling (Terry)
 cxl/port: Map Port component registers before switchport init
 - Updates to use cxl_port_setup_regs() (Dan)
 cxl: Change CXL handlers to use guard() instead of scoped_guard()
 - Add reviewed-by for Jonathan and Dave Jiang
 PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
 - Add review-by for Dan
 - Update Title prefix (Bjorn)
 - Removed merge_result. Only logging error for device reporting the
   error (Dan)
 - Remove PCI_ERS_RESULT_PANIC paragraph in pci-error-recovery.rst (Bjorn)
 PCI/AER: Move AER driver's CXL VH handling to pcie/aer_cxl_vh.c
 - Replaced workqueue_types.h include with 'struct work_struct'
   predeclaration (Bjorn)
 - Update error message (Bjorn)
 - Reordered 'struct cxl_proto_err_work_data' (Bjorn)
 - Remove export of cxl_error_is_native() here (Bjorn)
 cxl/port: Unify endpoint and switch port lookup
 - New patch
 PCI/AER: Dequeue forwarded CXL error
 - Update commit title's prefix (Bjorn)
 - Add pdev ref get in AER driver before enqueue and add pdev ref put in
   CXL driver after dequeue and handling (Dan)
 - Removed handling to simplify patch context (Terry)
 PCI: Introduce CXL Port protocol error handlers
 - Add Dave Jiang's review-by
 - Update commit message & headline (Bjorn)
 - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
   one line (Jonathan)
 - Remove cxl_walk_port(). Only log the erroring device. No port walking. (Dan)
 - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
   sufficient (Dan)
 - Remove device_lock_if()
 - Combine CE and UCE here (Terry)
 cxl: Update Endpoint uncorrectable protocol error handling
 - Update commit headline (Bjorn)
 - Rename pci_error_detected()/pci_cor_error_detected() ->
   cxl_pci_error_detected/cxl_pci_cor_error_detected() (Jonathan)
 - Remove now-invalid comment in cxl_error_detected() (Jonathan)
 - Split into separate patches for UCE and CE (Terry)
 cxl: Update Endpoint correctable protocol error handling
 - New commit
 - Change cxl_cor_error_detected() parameter to &pdev->dev device from
   memdev device. (Terry)
 cxl: Enable CXL protocol errors during CXL Port probe
 - Update commit title's prefix (Bjorn)
 Changes in v12->v13:
 CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - Add Dave Jiang's reviewed-by
 - Remove changes to existing PCI_DVSEC_CXL_PORT* defines. Update commit
   message. (Jonathan)
 PCI/CXL: Introduce pcie_is_cxl()
 - Add Ben's "reviewed-by"
 cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
 - None
 cxl/pci: Remove unnecessary CXL RCH handling helper functions
 - None
 cxl: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core
 - None
 cxl: Move CXL driver's RCH error handling into core/ras_rch.c
 - None
 CXL/AER: Replace device_lock() in cxl_rch_handle_error_iter() with guard() lock
 - New patch
 CXL/AER: Move AER drivers RCH error handling into pcie/aer_cxl_rch.c
 - Add forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
 - Changed copyright date from 2025 to 2023 (Jonathan)
 - Add David Jiang's, Jonathan's, and Ben's review-by
 - Readd 'struct aer_err_info' (Bot)
 PCI/AER: Report CXL or PCIe bus error type in trace logging
 - Remove duplicated aer_err_info inline comments. Is already in the
   kernel-doc header (Ben)
 cxl/pci: Update RAS handler interfaces to also support CXL Ports
 - None
 cxl/pci: Log message if RAS registers are unmapped
 - Added Bens review-by
 cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
 - Added Dave Jiang's review-by
 cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
 - Add Ben's review-by
 cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Change as result of dport delay fix. No longer need switchport and
 endport approach. Refactor. (Terry)
 CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
 - Add Dave Jiang's, Jonathan's, Ben's review-by
 - Typo fix (Ben)
 CXL/AER: Introduce pcie/aer_cxl_vh.c in AER driver for forwarding CXL errors
 - Add Dave Jiang's review-by
 - Update error message (Ben)
 cxl: Introduce cxl_pci_drv_bound() to check for bound driver
 - Add Dave Jiang's review-by.
 cxl: Change CXL handlers to use guard() instead of scoped_guard()
 - New patch
cxl/pci: Introduce CXL protocol error handlers for endpoints
 - Updated all the implemetnation and commit message. (Terry)
 - Refactored cxl_cor_error_detected()/cxl_error_detected() to remove
   pdev (Dave Jiang)
CXL/PCI: Introduce CXL Port protocol error handlers
 - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
   patch (Terry)
 - Remove EP case in cxl_get_ras_base(), not used. (Terry)
 - Remove check for dport->dport_dev (Dave)
 - Remove whitespace (Terry)
PCI/AER: Dequeue forwarded CXL error
 - Rewrite cxl_handle_proto_error() and cxl_proto_err_work_fn() (Terry)
 - Rename get_cxl_host dev() to be get_cxl_port() (Terry)
 - Remove exporting of unused function, pci_aer_clear_fatal_status() (Dave Jiang)
 - Change pr_err() calls to ratelimited. (Terry)
 - Update commit message. (Terry)
 - Remove namespace qualifier from pcie_clear_device_status()
   export (Dave Jiang)
 - Move locks into cxl_proto_err_work_fn() (Dave)
 - Update log messages in cxl_forward_error() (Ben)
CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
 - Renamed pci_ers_merge_result() to pcie_ers_merge_result().
   pci_ers_merge_result() is already used in eeh driver. (Bot)
CXL/PCI: Introduce CXL uncorrectable protocol error recovery
 - Rewrite report_error_detected() and cxl_walk_port (Terry)
 - Add guard() before calling cxl_pci_drv_bound() (Dave Jiang)
 - Add guard() calls for EP (cxlds->cxlmd->dev & pdev->dev) and ports
   (pdev->dev & parent cxl_port) in cxl_report_error_detected() and
   cxl_handle_proto_error() (Terry)
 - Remove unnecessary check for endpoint port. (Dave Jiang)
 - Remove check for RCIEP EP in cxl_report_error_detected() (Terry)
CXL/PCI: Enable CXL protocol errors during CXL Port probe
 - Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
 - Add Dave Jiang's and Ben's review-by
CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
 - Added dev and dev_is_pci() checks in cxl_mask_proto_interrupts() (Terry)

Changes in v11 -> v12:
 cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
  - Added Dave Jiang's review by
  - Moved to front of series
 cxl/pci: Remove unnecessary CXL RCH handling helper functions
  - Add reviewed-by for Alejandro & Dave Jiang
  - Moved to front of series
 cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
  - Update CONFIG_CXL_RAS in CXL Kconfig to have CXL_PCI dependency (Terry)
 CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
  - Added review-by for Sathyanarayanan
  - Changed Kconfig dependency from PCIEAER_CXL to PCIEAER. Moved
    this backwards into this patch.
 cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditio
  - Moved CXL_RCH_RAS Kconfig definition here from following commit
 CXL/AER: Introduce aer_cxl_rch.c into AER driver for handling CXL RCH errors
  - Rename drivers/pci/pcie/cxl_rch.c to drivers/pci/pcie/aer_cxl_rch.c (Lukas)
  - Removed forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
 CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
  - Change formatting to be same as existing definitions
  - Change GENMASK() -> __GENMASK() and BIT() to _BITUL()
 PCI/CXL: Introduce pcie_is_cxl()
  - Add review-by for Alejandro
  - Add comment in set_pcie_cxl() explaining why updating parent status.
 PCI/AER: Report CXL or PCIe bus error type in trace logging
  - Change aer_err_info::is_cxl to be bool a bitfield. Update structure padding. (Lukas)
  - Add kernel-doc for 'struct aer_err_info' (Lukas)
 cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
  - Correct parameters to call trace_cxl_aer_correctable_error() (Shiju)
  - Add reviewed-by for Jonathan and Shiju
 cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
  - Add check for dport_parent->rch before calling cxl_dport_init_ras_reporting().
  - RCH dports are initialized from cxl_dport_init_ras_reporting cxl_mem_probe().
 CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
  - Documentation requested by (Lukas)
 CXL/AER: Introduce aer_cxl_vh.c in AER driver for forwarding CXL errors
  - Rename drivers/pci/pcie/cxl_aer.c to drivers/pci/pcie/aer_cxl_vh.c (Lukas)
 cxl: Introduce cxl_pci_drv_bound() to check for bound driver
  - New patch
 PCI/AER: Dequeue forwarded CXL error
  - Add guard for CE case in cxl_handle_proto_error() (Dave)
  - Updated commit message (Terry)
 CXL/PCI: Introduce CXL Port protocol error handlers
  - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
    pci_to_cxl_dev() (Lukas)
  - Change cxl_error_detected() -> cxl_cor_error_detected() (Terry)
  - Remove NULL variable assignments (Jonathan)
  - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
    port searches. (Dave)
 CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
  - Remove static inline pci_ers_merge_result() definition for !CONFIG_PCIEAER.
    Is not needed. (Lukas)
 CXL/PCI: Introduce CXL uncorrectable protocol error recovery
  - Clean up port discovery in cxl_do_recovery() (Dave)
  - Add PCI_EXP_TYPE_RC_END to type check in cxl_report_error_detected()

Changes in v10 -> v11:
 cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from core/pci.c
 - New patch
 CXL/AER: Remove CONFIG_PCIEAER_CXL and replace with CONFIG_CXL_RAS
 - New patch
 cxl/pci: Remove unnecessary CXL RCH handling helper functions
 - New patch
 cxl: Move CXL driver RCH error handling into CONFIG_CXL_RCH_RAS conditional block
 - New patch
 CXL/AER: Introduce rch_aer.c into AER driver for handling CXL RCH errors
 - Remove changes in code-split and move to earlier, new patch
 - Add #include <linux/bitfield.h> to cxl_ras.c
 - Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
   to aer.h, more localized.
 - Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c ifdef changes
 CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
 - New patch
 PCI/CXL: Introduce pcie_is_cxl()
 - Amended set_pcie_cxl() to check for Upstream Port's and EP's parent
   downstream port by calling set_pcie_cxl(). (Dan)
 - Retitle patch: 'Add' -> 'Introduce'
 - Add check for CXL.mem and CXL.cache (Alejandro, Dan)
 PCI/AER: Report CXL or PCIe bus error type in trace logging
 - Remove duplicate call to trace_aer_event() (Shiju)
 - Added Dan William's and Dave Jiang's reviewed-by
 CXL/AER: Update PCI class code check to use FIELD_GET()
 - Add #include <linux/bitfield.h> to cxl_ras.c (Terry)
 - Removed line wrapping at "(CXL 3.2, 8.1.12.1)". (Jonathan)
 cxl/pci: Log message if RAS registers are unmapped
 - Added Dave Jiang's review-by (Terry)
 cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
 - Updated CE and UCE trace routines to maintian consistent TP_Struct ABI
   and unchanged TP_printk() logging. (Shiju, Alison)
 cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
 - Added Dave Jiang and Jonathan Cameron's review-by
 - Changes moved to core/ras.c
 cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
 - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
 - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
 - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
   and cxl_switch_port_init_ras() (Dave Jiang)
 - Port helper changes were in cxl/port.c, now in core/ras.c (Dave Jiang)
 cxl/pci: Introduce CXL Endpoint protocol error handlers
 - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
 - cxl_error_detected() - Remove extra line (Shiju)
 - Changes moved to core/ras.c (Terry)
 - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
 - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
 - Move #include "pci.h from cxl.h to core.h (Terry)
 - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
 CXL/AER: Introduce cxl_aer.c into AER driver for forwarding CXL errors
 - Move RCH implementation to cxl_rch.c and RCH declarations to pci/pci.h. (Terry)
 - Introduce 'struct cxl_proto_err_kfifo' containing semaphore, fifo,
   and work struct. (Dan)
 - Remove embedded struct from cxl_proto_err_work (Dan)
 - Make 'struct work_struct *cxl_proto_err_work' definition static (Jonathan)
 - Add check for NULL cxl_proto_err_kfifo to determine if CXL driver is
   not registered for workqueue. (Dan)
 PCI/AER: Dequeue forwarded CXL error
 - Reword patch commit message to remove RCiEP details (Jonathan)
 - Add #include <linux/bitfield.h> (Terry)
 - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
 - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
 - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
 - Usse FIELD_GET() in discovering class code (Jonathan)
 - Remove BDF from cxl_proto_err_work_data. Use 'struct pci_dev *' (Dan)
 CXL/PCI: Introduce CXL Port protocol error handlers
 - Removed check for PCI_EXP_TYPE_RC_END in cxl_report_error_detected() (Terry)
 - Update is_cxl_error() to check for acceptable PCI EP and port types
 CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
 - pci_ers_merge_result() - Change export to non-namespace and rename
   to be pci_ers_merge_result() (Jonathan)
 - Move pci_ers_merge_result() definition to pci.h. Needs pci_ers_result (Terry)
 CXL/PCI: Introduce CXL uncorrectable protocol error recovery
 - pci_ers_merge_results() - Move to earlier patch
 CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
 - Remove guard() in cxl_mask_proto_interrupts(). Observed device lockup/block
   during testing. (Terry)

Changes in v9 -> v10:
 - Add drivers/pci/pcie/cxl_aer.c
 - Add drivers/cxl/core/native_ras.c
 - Change cxl_register_prot_err_work()/cxl_unregister_prot_err_work to return void
 - Check for pcie_ports_native in cxl_do_recovery()
 - Remove debug logging in cxl_do_recovery()
 - Update PCI_ERS_RESULT_PANIC definition to indicate is CXL specific
 - Revert trace logging changes: name,parent -> memdev,host.
 - Use FIELD_GET() to check for EP class code (cxl_aer.c & native_ras.c).
 - Change _prot_ to _proto_ everywhere
 - cxl_rch_handle_error_iter(), check if driver is cxl_pci_driver
 - Remove cxl_create_prot_error_info(). Move logic into forward_cxl_error()
 - Remove sbdf_to_pci() and move logic into cxl_handle_proto_error()
 - Simplify/refactor get_pci_cxl_host_dev()
 - Simplify/refactor cxl_get_ras_base()
 - Move patch 'Remove unnecessary CXL Endpoint handling helper functions' to front
 - Update description for 'CXL/PCI: Introduce CXL Port protocol error
   handlers' with why state is not used to determine handling
 - Introduce cxl_pci_drv_bound() and call from cxl_rch_handle_error_iter()
 Changes in v8 -> v9:
 - Updated reference counting to use pci_get_device()/pci_put_device() in
   cxl_disable_prot_errors()/cxl_enable_prot_errors
 - Refactored cxl_create_prot_err_info() to fix reference counting
 - Removed 'struct cxl_port' driver changes for error handler. Instead
   check for CXL device type (EP or Port device) and call handler
 - Make pcie_is_cxl() static inline in include/linux/linux.h
 - Remove NULL check in create_prot_err_info()
 - Change success return in cxl_ras_init() to use hardcoded 0
 - Changed 'struct work_struct cxl_prot_err_work' declaration to static
 - Change to use rate limited log with dev anchor in forward_cxl_error()
 - Refactored forward-cxl_error() to remove severity auto variable
 - Changed pci_aer_clear_nonfatal_status() to be static inline for
   !(CONFIG_PCIEAER)
 - Renamed merge_result() to be cxl_merge_result()
 - Removed 'ue' condition in cxl_error_detected()
 - Updated 2nd parameter in call to __cxl_handle_cor_ras()/__cxl_handle_ras()
   in unify patch
 - Added log message for failure while assigning interrupt disable callback
 - Updated pci_aer_mask_internal_errors() to use pci_clear_and_set_config_dword()
 - Simplified patch titles for clarity
 - Moved CXL error interrupt disabling into cxl/core/port.c with CXL Port
 teardown
 - Updated 'struct cxl_port_err_info' to only contain sbdf and severity
 Removed everything else.
 - Added pdev and CXL device get_device()/put_device() before calling handlers

Changes in v7 -> v8:
 [Dan] Use kfifo. Move handling to CXL driver. AER forwards error to CXL
 driver
 [Dan] Add device reference incrementors where needed throughout
 [Dan] Initiate CXL Port RAS init from Switch Port and Endpoint Port init
 [Dan] Combine CXL Port and CXL Endpoint trace routine
 [Dan] Introduce aer_info::is_cxl. Use to indicate CXL or PCI errors
 [Jonathan] Add serial number for all devices in trace
 [DaveJ] Move find_cxl_port() change into patch using it
 [Terry] Move CXL Port RAS init into cxl/port.c
 [Terry] Moved kfifo functions into cxl/core/ras.c

Changes in v6 -> v7:
 [Terry] Move updated trace routine call to later patch. Was causing build
 error.

Changes in v5 -> v6:
 [Ira] Move pcie_is_cxl(dev) define to a inline function
 [Ira] Update returning value from pcie_is_cxl_port() to bool w/o cast
 [Ira] Change cxl_report_error_detected() cleanup to return correct bool
 [Ira] Introduce and use PCI_ERS_RESULT_PANIC
 [Ira] Reuse comment for PCIe and CXL recovery paths
 [Jonathan] Add type check in for cxl_handle_cor_ras() and cxl_handle_ras()
 [Jonathan] cxl_uport/dport_init_ras_reporting(), added a mutex.
 [Jonathan] Add logging example to patches updating trace output
 [Jonathan] Make parameter 'const' to eliminate for cast in match_uport()
 [Jonathan] Use __free() in cxl_pci_port_ras()
 [Terry] Add patch to log the PCIe SBDF along with CXL device name
 [Terry] Add patch to handle CXL endpoint and RCH DP errors as CXL errors
 [Terry] Remove patch w USP UCE fatal support @ aer_get_device_error_info()
 [Terry] Rebase to cxl/next commit 5585e342e8d3 ("cxl/memdev: Remove unused partition values")
 [Gregory] Pre-initialize pointer to NULL in cxl_pci_port_ras()
 [Gregory] Move AER driver bus name detection to a static function

Changes in v4 -> v5:
 [Alejandro] Refactor cxl_walk_bridge to simplify 'status' variable usage
 [Alejandro] Add WARN_ONCE() in __cxl_handle_ras() and cxl_handle_cor_ras()
 [Ming] Remove unnecessary NULL check in cxl_pci_port_ras()
 [Terry] Add failure check for call to to_cxl_port() in cxl_pci_port_ras()
 [Ming] Use port->dev for call to devm_add_action_or_reset() in
 cxl_dport_init_ras_reporting() and cxl_uport_init_ras_reporting()
 [Jonathan] Use get_device()/put_device() to prevent race condition in
 cxl_clear_port_error_handlers() and cxl_clear_port_error_handlers()
 [Terry] Commit message cleanup. Capitalize keywords from CXL and PCI
 specifications

Changes in v3 -> v4:
 [Lukas] Capitalize PCIe and CXL device names as in specifications
 [Lukas] Move call to pcie_is_cxl() into cxl_port_devsec()
 [Lukas] Correct namespace spelling
 [Lukas] Removed export from pcie_is_cxl_port()
 [Lukas] Simplify 'if' blocks in cxl_handle_error()
 [Lukas] Change panic message to remove redundant 'panic' text
 [Ming] Update to call cxl_dport_init_ras_reporting() in RCH case
 [lkp@intel] 'host' parameter is already removed. Remove parameter description too.
 [Terry] Added field description for cxl_err_handlers in pci.h comment block

Changes in v1 -> v2:
 [Jonathan] Remove extra NULL check and cleanup in cxl_pci_port_ras()
 [Jonathan] Update description to DSP map patch description
 [Jonathan] Update cxl_pci_port_ras() to check for NULL port
 [Jonathan] Dont call handler before handler port changes are present (patch order)
 [Bjorn] Fix linebreak in cover sheet URL
 [Bjorn] Remove timestamps from test logs in cover sheet
 [Bjorn] Retitle AER commits to use "PCI/AER:"
 [Bjorn] Retitle patch#3 to use renaming instead of refactoring
 [Bjorn] Fix base commit-id on cover sheet
 [Bjorn] Add VH spec reference/citation
 [Terry] Removed last 2 patches to enable internal errors. Is not needed
 because internal errors are enabled in AER driver.
 [Dan] Create cxl_do_recovery() and pci_driver::cxl_err_handlers.
 [Dan] Use kernel panic in CXL recovery
 [Dan] cxl_port_hndlrs -> cxl_port_error_handlers

Dan Williams (4):
  cxl: Tighten CPER kfifo registration API and symbol visibility
  cxl: Rename find_cxl_port() to find_cxl_port_by_dport()
  cxl/pci: Thread port and dport through RAS handling helpers
  cxl: Add port and dport identifiers to CXL AER trace events

Terry Bowman (9):
  cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity register
  acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks
  PCI/AER: Introduce AER-CXL protocol error kfifo
  PCI: Establish common CXL Port protocol error flow
  PCI/CXL: Add RCH support to CXL handlers
  cxl: Update CXL Endpoint AER handler
  PCI: Cache PCI DSN into pci_dev->dsn during probe
  PCI/CXL: Mask/Unmask CXL protocol errors
  Documentation: cxl: Document CXL protocol error handling

 Documentation/driver-api/cxl/index.rst        |   1 +
 .../cxl/linux/protocol-error-handling.rst     | 222 ++++++++++
 MAINTAINERS                                   |   2 +
 drivers/acpi/apei/ghes.c                      |  66 +--
 drivers/cxl/core/core.h                       |  36 +-
 drivers/cxl/core/port.c                       |  28 +-
 drivers/cxl/core/ras.c                        | 395 ++++++++++++------
 drivers/cxl/core/ras_rch.c                    |  20 +-
 drivers/cxl/core/trace.c                      |  35 ++
 drivers/cxl/core/trace.h                      |  91 ++--
 drivers/cxl/cxlmem.h                          |   7 +
 drivers/cxl/cxlpci.h                          |  11 +-
 drivers/cxl/pci.c                             |  16 +-
 drivers/pci/pci.h                             |   1 -
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/aer.c                        |  45 +-
 drivers/pci/pcie/aer_cxl_rch.c                |  39 +-
 drivers/pci/pcie/aer_cxl_vh.c                 | 235 +++++++++++
 drivers/pci/pcie/portdrv.h                    |  10 +-
 drivers/pci/probe.c                           |  14 +
 include/cxl/event.h                           |  17 +-
 include/linux/aer.h                           |  26 ++
 include/linux/pci.h                           |   1 +
 tools/testing/cxl/Kbuild                      |   1 +
 tools/testing/cxl/test/mock.c                 |  12 +
 25 files changed, 1013 insertions(+), 319 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/linux/protocol-error-handling.rst
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.34.1


