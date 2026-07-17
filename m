Return-Path: <linuxppc-dev+bounces-24397-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1807C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:29:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h24N93fqcz3c7p;
	Sat, 18 Jul 2026 08:29:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784327385;
	cv=pass; b=VF+/B+i8YQLAL2u5cIre635VeujBSBFW/bDSL9mQkPLKRvJzcoCdf+dt50bp6c4zWJs3huHLwDXuIJXjhUF4Mk3ikaFjg9b+NIacWO877t4c/wmeoe2t546PEr3dAOnS3AwavY0k+67JcJnrQwGTXniFPiFoOIxSnTSL6f4pnuh/o16szTcCfgzqAQ/X/2dey0DVGwZDwegY4i6PsxEGQzKWLV15hJ3XztPr7PmRbpn/hmKy01e/iuXv7qYz9dfqyURctCNXo2pLlV34FIeqLdjkgVGhc8MMPGthzFPf2QYEJ3hJabjPWQ0cRV1DZa1geUFbBMFZ9AwAeC1bLwukDw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784327385; c=relaxed/relaxed;
	bh=Fc2Chm2LwoMe9yA+vKHuYM8+CKUKSjsshd2+uCXAHos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PxJ7A5YV/7eelgCYQnxjP+1qUrGoUSrxpvR+oCMOtk2Z9Ayi15urGjaX16WDsPBFPXOUWIAZQS/z6Wkmhtq3spvStyJfLpuf/BAP6QCPGB4QBObtDimh7Ep6FP/k9djwJALbwgn5BJ6uvksIOJQk7YEXcvMBL+jc1dw10PdNG/zkyTrxdauWVnP+7MvNQ0/NYW3b+2MIU37x6SpZlT00rZtlVd/wHKgN2d8HAdgtpnUnxtnLLofOd1DG4fc0oiU5Ld1x9hUVXpToUjXTyjwVOsjU2S2Usz95vCAYwKkRYDWIPxynvmvDpsbr3Rh7hDVvcIqEK2BCWXPKa9HtyjrLeQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BjWf8W+n; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BjWf8W+n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h24N84NChz3c6c
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:29:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9emSJh1VlUI+K8kyiJvfkA9gEoBGTfoYn5mGP4WPQVVXEey7+TeeP55n0X+7Ybg6t6GT1vGg063oZUBxM+fPISNPSzMMJgU1bVe0vp230SS3umEYpAVUKAni8pt08nDrMfRaGVzS4+vDvjAasS0rnAreVYlTvqDw27Xg5tw0OYnVVfwmNaMwYF2qsh/ahKdRCuC46y0dzIPM1zGVQlZedGQeI/zTpMhb4npgApHsKcHDI3A6f+LPyOsSPQ7EkIGFKhA7gB2JGF2sg33nx0fxPyoSdVrQrXQuOa8B+36TB6a0/L/4967E8y3dyXnIwShzoK9qzu8uKLSY8/Bq3EV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc2Chm2LwoMe9yA+vKHuYM8+CKUKSjsshd2+uCXAHos=;
 b=aBFkwy6/8HDmHdFM6spIUNfMmYQaMQbALUWyr4ytfCzquHsXPRToC3H8n7Ib9tzCvfdIXkPROjCo02aY89ZIR6hGjXZcKdRYc9zukUmRFE7mI5ySzJ8atPtoW5RS6FbPLfbW6JGHch5rfvuDXC59bm+Gru63xewDfBtzrdX8hWblSgXBVnU3dBmGrCncdMGgcFQvPRi5LCqc5D26OHy0Y2LkLRA+Cvf4od7cB+f+uA5EnBQe2zl+ADgigVQrQga3CSmfdaY/e4N90ABcSaTjpbgLSD/Lt2BBbq/9zwhgyYWgQTICaSW0eNzES0opdawTt3HrWs508C8iO+p+e6lo+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc2Chm2LwoMe9yA+vKHuYM8+CKUKSjsshd2+uCXAHos=;
 b=BjWf8W+nTACngZXISLWna3l9eVRAtWfwmnbsNlm89ltSLzfbS9OtOYYh3FXpqtnCnBRiF2/q+gB/lWd1wKiy0Iq8BnROHca6YJZ3h+XqLPLp+iKqUQ73Ul7ppBJQVxYzm+4742tYMiDGUFGfWO6h7oJtfaG3x+G2AyFcqfZidqA=
Received: from SJ0PR05CA0090.namprd05.prod.outlook.com (2603:10b6:a03:332::35)
 by BL3PR12MB6521.namprd12.prod.outlook.com (2603:10b6:208:3bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 22:29:20 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::79) by SJ0PR05CA0090.outlook.office365.com
 (2603:10b6:a03:332::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Fri, 17
 Jul 2026 22:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:29:19 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:29:18 -0500
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
Subject: [PATCH v18 11/13] PCI: Cache PCI DSN into pci_dev->dsn during probe
Date: Fri, 17 Jul 2026 17:27:04 -0500
Message-ID: <20260717222706.3540281-12-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|BL3PR12MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: bb52cb4c-8a01-4a4a-cf78-08dee452d839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|23010399003|376014|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cvD165g+fkhnl5f+WuX7JbhIbItD4yFE2+gvGB0MyW7BXddHmNJBzxCi0iqihzWFK5m2nhJnrj5aogVfhVA4zT0G/IFFn/mbV5RcWeRAmG7dO3hM8OaOZ3Iv5M28JlJQnvr6kW2PRW3+b91BVw4soGDQw7YIZMl9GYA8fmOHB+gsKhD1yU4HUqpvqX7mfJknboMsCA4b9LQD5BlhT3t/ylrg8emrpjlZC0bdgKClVl/Ju1+awgSZa50CE9teI/sXk6RCcHIABjwf3FoS7u9hjWcolVuqw1haoqULRo2em9otjCQ0KeCHPvZ6aSy6Y6Kqkt7Ynwdwq6fbYtpcoRFwTMd6t+fnfwJ8ut3hckdzR7ugjMX4DJpzF9ObzC899HihdLKiqQMZJFuJ8ws2R/pwBGQFUrRBlPW1yfwRWuQi+RyFRMNFCDu/tGhdRCFQDkfloTkuy6Pdg6ptEgvUuWDhfa7SAOereAydp/PMCNT1iiX5kDars44Edm/JodUPQoi8MbNZxQBZIrTTywUcCJunaMw5RFiDLuMhdWm1iMJ36B6CyRjWedc/HR2rU+iKv4B7U43QwmoRHLtVs4D7NrlGEA/g4QDYAb8rt4qk7VwVlwVbEGtc+T2lSiiJWLX/NTDROo6xibLCa17tUn01wWeJ3EOzSWGs3j+AK0QN73EQ46xoFtlJjpM6K9oMmCo5dFmPCZuTEm8cAQqSOLTmEdug8g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gMrsoUE2T3tLHTULWXF85fweqnd0xsAkr4bsR+YRcTTby6yzq6x5PQ0cpvReR0Fzu+hQM0gQ6gTFQNglaHvowLoOXVqN5dNwQpsmo6VRTBwgEacvMZR0VtPufgCw3WabvRuRwCeHq28ypw0U3ZOLnOU+yrH+aztQwV1+KZUOLkaCs25wzVp/SP6DzOb9O6L0wZ4rzmoaMUEwOdm0GajaHql6sAK62sX2/8BCmPLXUiz+VZ84w9ELFBnTXblD33XUNJMYKMhT5KpYsXH4bLng001uijAAg7P/KHTpJ6ucot0PRfMky96mL9XomeKb7+EQyJ9rD7QgmE0Cd7BR0Oj8WLStU1aZ1lNy3FZbmRvNj06UeVylATp1pQ6HoRmzzIg/2fHQ5fnOm4z5lm3QhgxFtZrUEMgvpPHXsnKvKawpOrH8xI308yzQBRtKZJEAtKcx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:29:19.8037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb52cb4c-8a01-4a4a-cf78-08dee452d839
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6521

Subsequent CXL error-reporting code paths need to log the PCI Device
Serial Number (DSN) as part of trace events emitted from interrupt or
panic context. Computing the DSN there via pci_get_dsn() requires PCI
configuration space reads, which are slow, can fail when the link is
down or frozen, and may not be safe in some contexts.

Add a u64 dsn field to struct pci_dev and populate it from pci_get_dsn()
during pci_init_capabilities() at probe time via pci_dsn_init(). Only
write dev->dsn when the read succeeds. The zero initial value from
pci_dev allocation already represents 'no DSN available.'

pci_get_dsn() is not modified because it remains a pure config-space read
with no side effects on pci_dev. The cache is written exclusively by
pci_dsn_init() at probe time.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v17->v18:
- New commit.
---
 drivers/cxl/core/ras.c     | 11 ++++++-----
 drivers/cxl/core/ras_rch.c |  4 ++--
 drivers/cxl/pci.c          |  2 +-
 drivers/pci/probe.c        | 14 ++++++++++++++
 include/linux/pci.h        |  1 +
 5 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index acf40b2396c3b..69b320c74469c 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -100,10 +100,10 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 	dport = cxl_find_dport_by_dev(port, &pdev->dev);
 
 	if (data->severity == AER_CORRECTABLE)
-		cxl_cper_trace_corr_prot_err(port, dport, pci_get_dsn(pdev),
+		cxl_cper_trace_corr_prot_err(port, dport, pdev->dsn,
 					     &data->ras_cap);
 	else
-		cxl_cper_trace_uncorr_prot_err(port, dport, pci_get_dsn(pdev),
+		cxl_cper_trace_uncorr_prot_err(port, dport, pdev->dsn,
 					       &data->ras_cap);
 }
 EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
@@ -195,7 +195,7 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dpo
 		return;
 	}
 
-	if (cxl_handle_ras(port, dport, ras_base, pci_get_dsn(pdev)))
+	if (cxl_handle_ras(port, dport, ras_base, pdev->dsn))
 		panic("CXL cachemem error");
 
 	dev_dbg(&pdev->dev,
@@ -307,7 +307,7 @@ pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 		 * CXL.mem traffic.
 		 */
 		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL),
-				    pci_get_dsn(pdev));
+				    pdev->dsn);
 	}
 
 	/*
@@ -339,7 +339,8 @@ static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport, int severity)
 {
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport), pci_get_dsn(pdev));
+		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport),
+				   pdev->dsn);
 	else
 		cxl_do_recovery(pdev, port, dport);
 }
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 0385d2f4a2f66..14bb3bdb2d092 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -118,8 +118,8 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(dport->port, dport, to_ras_base(port, dport),
-				   pci_get_dsn(pdev));
+		cxl_handle_cor_ras(dport->port, dport,
+				   to_ras_base(port, dport), pdev->dsn);
 	else
 		cxl_do_recovery(pdev, dport->port, dport);
 }
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6cf1db7b85020..45a994cc782a9 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -807,7 +807,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dvsec)
 		pci_warn(pdev, "Device DVSEC not present, skip CXL.mem init\n");
 
-	mds = cxl_memdev_state_create(&pdev->dev, pci_get_dsn(pdev), dvsec);
+	mds = cxl_memdev_state_create(&pdev->dev, pdev->dsn, dvsec);
 	if (IS_ERR(mds))
 		return PTR_ERR(mds);
 	cxlds = &mds->cxlds;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18d..92ece5ec211f8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2638,6 +2638,19 @@ void pcie_report_downtraining(struct pci_dev *dev)
 	__pcie_print_link_status(dev, false);
 }
 
+/*
+ * Cache the Device Serial Number for use in contexts where config-space
+ * reads are unsafe (interrupt, panic).  Process-context callers that
+ * need a fresh value (e.g. hotplug device replacement) use pci_get_dsn().
+ */
+static void pci_dsn_init(struct pci_dev *dev)
+{
+	u64 dsn = pci_get_dsn(dev);
+
+	if (dsn)
+		dev->dsn = dsn;
+}
+
 static void pci_imm_ready_init(struct pci_dev *dev)
 {
 	u16 status;
@@ -2674,6 +2687,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_rebar_init(dev);		/* Resizable BAR */
 	pci_dev3_init(dev);		/* Device 3 capabilities */
 	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
+	pci_dsn_init(dev);		/* Serial number */
 
 	pcie_report_downtraining(dev);
 	pci_init_reset_methods(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c1..48a1622639190 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -386,6 +386,7 @@ struct pci_dev {
 	unsigned long	*dma_alias_mask;/* Mask of enabled devfn aliases */
 
 	struct pci_driver *driver;	/* Driver bound to this device */
+	u64		dsn;		/* PCI Device Serial Number */
 	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
-- 
2.34.1


