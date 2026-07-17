Return-Path: <linuxppc-dev+bounces-24393-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374A1C44516
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:29:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h24MK6WKRz2yR5;
	Sat, 18 Jul 2026 08:29:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784327341;
	cv=pass; b=VYiTawcp7PxDl78f2xZd+RqGotZdy+V7TOrHbfi6PezCV2LCGQfu1pyBBFb+ERmLW8Tt4s6uMmf2SqbzU1+8eJq+3iLjtbrZLEQQ8jnBWPG5Sb6yYVBFiXlWAkjE00kbkYSVTzWjSyaLsnNT3NaNirkB5ePXzS+YYAZZcuPnLsIvpJNWQX0Y86FqQX3xlPpRnsYm4AKq0lSbaHEa31UZ8pvnNSnqIerZEkYYLx87BXUxuQ0Y8oWu7GNRztl6veioFN9/Xh1R4e5RftY4Fx2Ovj4T8W0TI/zni0dAFDpAOS6l/OaYkDXqJD8hl9T5/cokmdOipkbVLWYxnbCUuIYWOQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784327341; c=relaxed/relaxed;
	bh=Pw5hqIsC33u7gUEIECx9Zs5V8ttGWwt4ANJ9gthfuCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A289mObLWIP/MD44tAsCU6RPf069A07j+x+999xZgx8BN3uJZTdzeGQd2FBO7wWaIBHWBT2T4KVRRLvjO+/H+n5rcxVD3culHVjgctF4x6NS15Bsa8Vd1W7c0QkNvAOwX3zExXOJSr12BSml7H8xZyXJBfAwgVf6vAAsGeNHbMIi49gcSiKe10Fdk9mKRU3wizegQK8BHMckvPjcp2ODU+EbPNOroc78rEVKKV7NPSRiuqQAgFRI4afICfGv8j+qwPIwxGRH6AHK0QBWKh42TBswt8QFWfXIIHS9ZUEKr1L3onh0dJkZZexF3jlrQ2OulHjfwgxHA7FEBRtKJtCsYg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oQRmiWKu; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oQRmiWKu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h24MJ4Lclz3c3K
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:29:00 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L88vXCghWp41W5zNQr8nNI/p14iq3bZjRxx8GTqN57Ts1XGUdmmZVMSigHzBnA6MQ99k85Lkkyv9eD6+sdgD/0Bxbv4DxzlZ9NWLWY6wHmzoT6NepvSNUegMzj1GMlcdtsUmhOLlVUbfhnzOF7rvYl2FZYDYAi24o6Mx2/1DrTQEpgqT2UGaMf46VPnhvuj0yFdmmksc++5wkQbBgnXeuRKyffQiESPhgyUw62JZgVRpRWzN6NZ0yI4GHOywQc+LD2HoxEAPd4T5inTu8TPW3RDj11ODUpKVla8EEQ8+zCIJK0jLlC/RrftmhhYMQ2F8B4xoxdjvyowMlHIPuojh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pw5hqIsC33u7gUEIECx9Zs5V8ttGWwt4ANJ9gthfuCs=;
 b=AJjLU7hMiUIhUK0027pH8XZLwtW2J24kyHR96DBXphGvlAd/EQu3BdzPHaazECLVVG3YsJxo2Gj4D1zTMSXcOijcSX6qMKNgBS6e/Wn5dM3BzhltxwzzjzKwJsET/vQuj19cZSl9kStOcLAn/eSy85w8yFth0ys8RSz1vEQs9vLfttCzn4sofMEjmA/UC01hsq1ISMjnSWDYiIUvrjBHR9gsc8bFRQzBQdPX9L1D3EOsxiZHpB4gcrIXXcLwSAIGBXF8gekQnOne3C+TXQLdsGfOS0+dSok2roR9NHePxhctllZLNJZzIED1aPkDCjdBGbRqv+EWWGLCTh7JXiv6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pw5hqIsC33u7gUEIECx9Zs5V8ttGWwt4ANJ9gthfuCs=;
 b=oQRmiWKuGPSIcifmTnxgjtknFOuDS5heZdd27hKA2awOjY9l3x64H6LNs1WGUSspV0fRn3Ft2MVAbqhWVrZDf41Pr9/Fsxbe8JmawLeuuveOLBuG8iUlDVyXa9kUW+Fd6YZsGmaT3V2Cxs6vyJbZvLvP2VzYr6B7mVknpdz2S4c=
Received: from BY3PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:217::15)
 by LV1PR12MB999279.namprd12.prod.outlook.com (2603:10b6:408:3f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 22:28:34 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::40) by BY3PR04CA0010.outlook.office365.com
 (2603:10b6:a03:217::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 22:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:28:33 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:28:32 -0500
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
Subject: [PATCH v18 07/13] PCI/CXL: Add RCH support to CXL handlers
Date: Fri, 17 Jul 2026 17:27:00 -0500
Message-ID: <20260717222706.3540281-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|LV1PR12MB999279:EE_
X-MS-Office365-Filtering-Correlation-Id: 7053a89f-92a9-4d9a-1796-08dee452bcbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|7416014|18002099003|22082099003|56012099006|11063799006|3023799007|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	9wEyR/CB6zinC5Y5AheKzHRMGcC2aH6k8ZVv6pQkTpV4pP56/32goZ2khivdEUw8fFB2h0iZ0uUPfcoavpgmpoR0eRzPUyL33M5ZmoC56afjvywEpma/uNjH7drWq6SyOOnUh+n8FrzpE05ECCcymGDb2v1LuRGYZyoCE0BDFCtIUbbuIeAEprGOQicf8OOWDsKzVdl6SXUeo42xgPRrEXWdmuA9g5PoPYRG37alx6Roj3ZAAnhCKQ9Fvk/fCiaSQLVbg1iP91xEt/qWnNArqQRDsE/Dtl/fXEWLoS734Mp96/jfT2WxrfdA+I4iBwFZ5dXyXhjyJyNMrFeEZ6O8Oug1RKyX8f0Zsx7gxUaODykui7cZNQvOeyOsh80NDA0pmjFIHTgrpssWpQd2sNnCmS877s2Dk9EA4INZmBq1RM7XsLj0V2Pcqddpwz+wBeYCACw4m5E7M2RGSXdE1V86MiWsrLR+ZmL6cBHRPWOJrSuBslo5mI5BSwxj/1atLyayLobhP649Zs28akGWirMO+M1u42uRLhyLJzAYjiYqyIhsy4wxGRbGDxfjxXw/v5mzXoP15onL1QTqAhiNAQLpGHekOxZzr/yVpqefA/pFgb8mQ14+ph3GQISCZn52a5CCCOqWn89K78GH9ohNkZjeGipOMFQ2HiXVpP6EHGtcJQCXrfF2gVGnXL7oicyLX4YRT9gxPuH7q5+LU8/c7Ux5Fg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jgo/fI0kZ1f0D+GQ4MS1XW/IgkxZGxEkRypcX0JASIkMIWXbITOPMmb6T4eu6jHsjNc5mUl4aHXTcQ3TevYqt3VsLTIGmXU/q5vAuN+9q+UBpl0elnKg6ZeRpcaRP7poecXuIqY205Q3pk8CaDjtKOe+RhYmhbZJqlsV/7pAJeoXAikq90hpBuBrIfnIt/dQ9a5/K3yS4+CmqiT2i/62ZL5KVAQvIKNRah4xPmVP/nqEDrUCWI5+2zBB4HuPBBFrqkNpyRTikcffwvwzK2i4Eg8oXRGxOi8QMelXBHamEbQEMciGeCyGlgf9cFr3keUmxDsSdfxzrALbFs+TJVzXJvXFWvsSNxUN0GmpqYEOelVurLZcf2wOOF8tEcMSNEa5FWrhyIq+0QB+TmWuAM0lc3ga5IjTKYdSlqYRjHp49m55kyc4cbquVWEy5fhgapyK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:28:33.6810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7053a89f-92a9-4d9a-1796-08dee452bcbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999279

Restricted CXL Host (RCH) error handling is a separate path from the
new CXL Port error handling flow. Fold RCH error handling into the
Port flow so both share a common entry point.

Update cxl_rch_handle_error_iter() to forward RCH protocol errors
through the AER-CXL kfifo. Change cxl_rch_handle_error() return type
from void to bool so handle_error_source() can determine whether work
was enqueued and call cxl_proto_err_flush() before AER recovery
proceeds.

For RC_END devices, __cxl_proto_err_work_fn() calls
cxl_handle_rdport_errors() to process RCH Downstream Port errors,
then falls through to the VH path for RC_END Endpoint handling.

An RCD uncorrectable CXL RAS error now panics via cxl_do_recovery().
Before this patch the RCH Downstream Port UCE path called
cxl_handle_ras() but ignored its return value - no panic. After this
patch the same condition calls cxl_do_recovery() which panics on
confirmed UCE. The Endpoint UCE path already panicked at the parent
commit. This matches the panic policy added in the common CXL Port
protocol error flow.

Remove cxl_cor_error_detected() and its .cor_error_detected
registration in cxl_error_handlers. Correctable Endpoint errors are
now routed through the AER-CXL kfifo like all other CXL protocol
errors.

Drop the cxlds->rcd / cxl_handle_rdport_errors(cxlds) branches from
cxl_error_detected(). RCH downstream port error handling is now
performed by __cxl_proto_err_work_fn() via the kfifo path, which
calls cxl_handle_rdport_errors(pdev) before the common dispatch.

Change cxl_handle_rdport_errors() to take a struct pci_dev * instead
of a struct cxl_dev_state *, matching the new caller context. Re-fetch
dport under guard() to close the TOCTOU window between
cxl_pci_find_port()'s lockless xa_load() and the first dereference of
the returned pointer.

Change find_cxl_port_by_dev() RC_END lookup from
find_cxl_port_by_dport(dev->parent) to find_cxl_port_by_uport(dev),
matching the Endpoint lookup path. RC_END Endpoint port resolution
uses the uport (the RC_END device itself), while the separate RCH
Downstream Port lookup is handled by cxl_handle_rdport_errors().

The RCH Downstream Port and the RCD Endpoint (RC_END) are separate
devices with independent RAS register blocks. cxl_handle_rdport_errors()
handles the RCH Downstream Port RAS. RCD Endpoint (RC_END) is handled in
cxl_handle_proto_error().

Use to_ras_base() in cxl_handle_rdport_errors() instead of referencing
dport->regs.ras directly. Make to_ras_base() non-static in ras.c and
declare it in core.h so ras_rch.c can access it. Route all RAS base address lookups
through a single helper to prepare for CXL RAS error injection testing
that follows this series.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v17->v18:
- Pass &pdev->dev instead of dport->port->uport_dev in
  cxl_handle_rdport_errors() to avoid dropping RCH trace events.
- Document trace event attribution change.
- Document removal of cxl_cor_error_detected() and cxlds->rcd branches.
- Capitalize Endpoint per PCI spec convention.
- Use to_ras_base() in cxl_handle_rdport_errors() to centralize RAS base
  address lookup in preparation for error injection testing.

Changes in v16->v17:
- Drop now-dead cxlds->rcd branches from cxl_{cor_,}error_detected().
- Drop duplicate subject line from commit body.
- Document panic-on-uncorrectable behavior change for RCD path.
- Document trace event device-name change (memN -> PCI BDF) for RCH path.
- Rewrite cxl_handle_proto_error() RC_END comment to clarify RCD/RCH shared
  interrupt relationship
- Rewrite commit message

Changes in v16:
- New commit
---
 drivers/cxl/core/core.h        | 10 +++++--
 drivers/cxl/core/ras.c         | 50 ++++++++--------------------------
 drivers/cxl/core/ras_rch.c     | 16 ++++++-----
 drivers/cxl/cxlpci.h           |  3 --
 drivers/cxl/pci.c              |  1 -
 drivers/pci/pcie/aer.c         |  4 +--
 drivers/pci/pcie/aer_cxl_rch.c | 39 ++++++++++++--------------
 drivers/pci/pcie/portdrv.h     |  4 +--
 8 files changed, 48 insertions(+), 79 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 7c70bea06c2db..272634ff2615b 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -191,7 +191,8 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
 void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
+void cxl_handle_rdport_errors(struct pci_dev *pdev);
+void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport);
 void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
 #else
 static inline void cxl_ras_init(void) { }
@@ -205,7 +206,12 @@ static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
 static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
-static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
+static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
+static inline void __iomem *to_ras_base(struct cxl_port *port,
+					 struct cxl_dport *dport)
+{
+	return NULL;
+}
 static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 #endif /* CONFIG_CXL_RAS */
 
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index b190e69c2d415..9a142abcf4f8b 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -218,7 +218,8 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
-static void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
+
+void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
 {
 	if (!port)
 		return NULL;
@@ -324,37 +325,7 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	return true;
 }
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
-{
-	guard(device)(&pdev->dev);
-	if (!pdev->dev.driver)
-		return;
-
-	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
-	if (!port)
-		return;
-
-	if (is_cxl_restricted(pdev)) {
-		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-		struct cxl_memdev *cxlmd = cxlds->cxlmd;
 
-		scoped_guard(device, &cxlmd->dev) {
-			cxl_handle_rdport_errors(cxlds);
-		}
-	}
-
-	scoped_guard(device, &port->dev) {
-		if (!port->dev.driver) {
-			dev_warn(&pdev->dev,
-				 "%s: port disabled, abort error handling\n",
-				 dev_name(&port->dev));
-			return;
-		}
-
-		cxl_handle_cor_ras(port->uport_dev, to_ras_base(port, NULL));
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
 
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state)
@@ -365,14 +336,6 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	if (!port)
 		return PCI_ERS_RESULT_DISCONNECT;
 
-	if (is_cxl_restricted(pdev)) {
-		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-		struct cxl_memdev *cxlmd = cxlds->cxlmd;
-
-		scoped_guard(device, &cxlmd->dev) {
-			cxl_handle_rdport_errors(cxlds);
-		}
-	}
 
 	scoped_guard(device, &port->dev) {
 		if (!port->dev.driver) {
@@ -429,6 +392,15 @@ static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
 
 static void __cxl_proto_err_work_fn(struct cxl_proto_err_work_data *wd)
 {
+	/*
+	 * For RC_END (RCD) devices, handle RCH Downstream Port errors
+	 * first.  cxl_handle_rdport_errors() does its own port lookup
+	 * and locking, keeping the Downstream Port lock separate from the
+	 * Endpoint Port lock taken below.
+	 */
+	if (is_cxl_restricted(wd->pdev))
+		cxl_handle_rdport_errors(wd->pdev);
+
 	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&wd->pdev->dev, NULL);
 	if (!port) {
 		dev_err_ratelimited(&wd->pdev->dev,
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 44b335d560708..f2d2fb83758b9 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2025 AMD Corporation. All rights reserved. */
 
-#include <linux/types.h>
 #include <linux/aer.h>
 #include "cxl.h"
 #include "core.h"
@@ -96,18 +95,21 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
 	return false;
 }
 
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+void cxl_handle_rdport_errors(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct aer_capability_regs aer_regs;
 	struct cxl_dport *dport;
 	int severity;
 
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
+	struct cxl_port *port __free(put_cxl_port) = cxl_pci_find_port(pdev, NULL);
 	if (!port)
 		return;
 
+	guard(device)(&port->dev);
+	dport = cxl_find_dport_by_dev(port, pdev->dev.parent);
+	if (!dport)
+		return;
+
 	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
 		return;
 
@@ -116,7 +118,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_cor_ras(&pdev->dev, to_ras_base(port, dport));
 	else
-		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_do_recovery(pdev, dport->port, dport);
 }
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index b826eb53cf7ba..06c46adcf0f6c 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -89,14 +89,11 @@ struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
-void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
 void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
 #else
-static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
-
 static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 						  pci_channel_state_t state)
 {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7c6faee7f85ed..5c21db36073fe 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1004,7 +1004,6 @@ static const struct pci_error_handlers cxl_error_handlers = {
 	.error_detected	= cxl_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2d9d40528e709..0bd23a65e7ebc 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1185,9 +1185,7 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	bool cxl_pending = false;
-
-	cxl_rch_handle_error(dev, info);
+	bool cxl_pending = cxl_rch_handle_error(dev, info);
 
 	if (is_cxl_error(dev, info))
 		cxl_pending |= cxl_forward_error(dev, info);
diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index e471eefec9c40..683712fc965ff 100644
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -34,42 +34,37 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 	return (pcie_ports_native || host->native_aer);
 }
 
+struct cxl_rch_error_ctx {
+	struct aer_err_info *info;
+	bool enqueued;
+};
+
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 {
-	struct aer_err_info *info = (struct aer_err_info *)data;
-	const struct pci_error_handlers *err_handler;
+	struct cxl_rch_error_ctx *ctx = data;
 
 	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
 		return 0;
 
-	guard(device)(&dev->dev);
-
-	err_handler = dev->driver ? dev->driver->err_handler : NULL;
-	if (!err_handler)
-		return 0;
-
-	if (info->severity == AER_CORRECTABLE) {
-		if (err_handler->cor_error_detected)
-			err_handler->cor_error_detected(dev);
-	} else if (err_handler->error_detected) {
-		if (info->severity == AER_NONFATAL)
-			err_handler->error_detected(dev, pci_channel_io_normal);
-		else if (info->severity == AER_FATAL)
-			err_handler->error_detected(dev, pci_channel_io_frozen);
-	}
+	if (cxl_forward_error(dev, ctx->info))
+		ctx->enqueued = true;
 	return 0;
 }
 
-void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
+bool cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
+	struct cxl_rch_error_ctx ctx = { .info = info };
+
 	/*
-	 * Internal errors of an RCEC indicate an AER error in an
-	 * RCH's downstream port. Check and handle them in the CXL.mem
-	 * device driver.
+	 * An RCEC AER internal error indicates an error in an
+	 * associated RCH Downstream Port or RC_END device or both.
+	 * Forward to the cxl_core module for handling.
 	 */
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
 	    is_aer_internal_error(info))
-		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, &ctx);
+
+	return ctx.enqueued;
 }
 
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index fd203010877bf..807bca90dee0e 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -128,14 +128,14 @@ struct aer_err_info;
 
 #ifdef CONFIG_CXL_RAS
 bool is_aer_internal_error(struct aer_err_info *info);
-void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
+bool cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
 void cxl_rch_enable_rcec(struct pci_dev *rcec);
 bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
 bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
 void cxl_proto_err_flush(void);
 #else
 static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
-static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
+static inline bool cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { return false; }
 static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
 static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
 static inline bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
-- 
2.34.1


