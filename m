Return-Path: <linuxppc-dev+bounces-24389-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7479C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:28:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h24LR2w17z2yll;
	Sat, 18 Jul 2026 08:28:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784327295;
	cv=pass; b=Gk6tW6Rs3mexfN20MbkbQejQW49zbMUzhNG4OOlrw6MV4N6mKrkrSYPpZxA+QkLtTVjIbXK1YYB2CyZ1sipdKDSApwAGo2nxwJZDRQwVdWpXLqNymt0aWPBzzdKGf6ZH86L/tfBWwluNzqNkHaGQTctXCqpef3rdm21bYKRk0+7qYTUcaMmanPPsII0cI6nuzbwWK6llkg+HdTbOruF6WJQc+7vCh9FJcqSRKcFKUV24q6AC66NwmdpDodXsX+xbRX5HSgxQR/s0j8Ig2d7bf9jt8jmNpkYb8YUQ5k+76UXgbko8/hDk49CG/EQibIY0w5Fe1rl/O95MXaGhqS8rBw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784327295; c=relaxed/relaxed;
	bh=wogRdxVfErogyI7QNX65froU+HmN3HpTXed/Kk7aGw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+AISGE9GO2Fb/Rmxs+Y3WGIjqEpLbjobv+oFlBdmvbfJLvBvay0m3dnuYPXjZgcSqj4puFSUqR1F2NdZAWP7lNUkAwP0nT28h82wpopnWOUa0MugbTMRK6Jipwv2NyBGmKT/Degd9f0Mh3ODeBBlPrDs07kmH7bwjnqwV2ck8ACwU3lvX8unF3ZMl/Rbn/MjKowuam+HTb/1IZ0Vl214RW91gkYZKyHfpfGOwQ4k4nO3UdTuc3Tufn9TJnzCTCkGUd8khONCId8QGRZG9OHDFXZwvrBquyKHuoDTLe4YicO5ZuzRlB5fHUmS47em2nG8o0AMzdzoFUEAdFekfYkbw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vO81t6Q2; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vO81t6Q2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h24LQ0YPyz2yZf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:28:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1wHKmsWdVWoejSRerpMdY9GG/iju1nPR/wuJuVFehQRsEJjx45q6TcB8CTh2dDZHR+GbeLSQkUvPI2GqzNnsudTHcEbEk6xdTQCuo0tMWAzDhG+H115Ci89VZ68xuFVfKe7m2LiS+B4CYA1nlQFBA3F+2qui++H/x0UzXJAYsYfFdQUs7MkVmxWCfKHXQMoVccqvbaVRtV7Bs9ysdDv/FoP3QpZhlzlhoyc8jRjpL8dDmJ2gsZvkeyXPrt/9wrM1Na7Z/coL42KL0RIsgyOIEDqS38ZeSD010r4tzWHvb7riTF3MlnE0TpOqq4CbX1KLpIida0upE0MgN/Zo1KqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wogRdxVfErogyI7QNX65froU+HmN3HpTXed/Kk7aGw4=;
 b=QU6+mJ2hkNhabVI02kDlxntvdjN/dcKtTCBQCPDKewgJn+IKDzz3ytQpUoQnRqRbG5Um+aZ2XqnEG7oVxqc1LWtawhiS0ZS3MdiHlSLpPQahSC1ejKc+r8d9a2+YKoC78ZYJnyGJ6enArGWH4Dm6N14s1VWQLKXk+7FNK7CkdpPhnc/rqGfLm7BVxIBCWLxw4UKrjAgvQHPHufN8Pc998LRTWefgZmdge8OXssAbgB7ECdNZhgddwEBr93c6yG3Lp7lN5v3VI+KsJ+YaHrUIpIhfCek5r9C/GLGg6xCKDHF70fNNCT7YzvKv6MIxmkVKhRLf/A7mfVe96e9tW3xsLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wogRdxVfErogyI7QNX65froU+HmN3HpTXed/Kk7aGw4=;
 b=vO81t6Q2dOvvreaKAAW8LKRyCkP/xphJF0XgvBrcEO3gJQMFU0g6qT70/OYXjWqmVynowumTl/bI0uQBBMO8GqCVu7yFijSR37hppQv3W7/IXRoFdOrs99tHY4eXEHfP1GQegmxNxhvBt6av8HQ8pF+2K+KXAq2gALQyAV1fOSw=
Received: from BY5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:1e0::31)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Fri, 17 Jul
 2026 22:27:48 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::e) by BY5PR03CA0021.outlook.office365.com
 (2603:10b6:a03:1e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 22:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:27:47 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:27:46 -0500
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
Subject: [PATCH v18 03/13] cxl: Tighten CPER kfifo registration API and symbol visibility
Date: Fri, 17 Jul 2026 17:26:56 -0500
Message-ID: <20260717222706.3540281-4-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b94d1b1-a522-4436-2ea8-08dee452a149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|7416014|376014|10067099003|3023799007|11063799006|6133799003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	8u8NEYsC3R9wlJalAhtJd0l7QlLYpxVTy3YKwQpvVU4QakDneyJE4l/YYDpfn7BTyiQn9L0YpMuHC0V36Bfmau2nhVPQe0HoUuowufZqNVjxw0UG/jRrvWSORMrXTnVGkO30FVMUQ74Gp3szCiaFsBZSX3aA4SOOPG+4SMWHI8r0arOiKS+Ix/nhC97bUwDc8sfj1NHkNfKA5BeDKq8ByY2vzXn6cQgodGUpUisdLl739lKsZLWaNnzr+IE5loGHS5ZPuZU8jNq/pvCrHLMQ+rLMFzfne0QobpH2j47vr9vPzrS2zIovsSZ0gYY4mhsN95eaWPoNUAUWgrEukEn0iPicY7SkCW8ML4v6E/u+ed9AEidbRlUiaDFOJtzHAm9xT6FoV+tFukqkrrlXG75GvZ/vXkygdl6/JLSnh24+0/qIlNOUHiJLrhAc1pS9Nm3pskL7CmW4BfDp+/V4f0evzNaA5ttZgP4wVs02Us58lhlDDUKOwfXO/t0idWvmGQItzko7FAsNGcXpar1g13zMD8ZXCYg16H/jy4KHOEoixXWOZDNEv0nkzDXVyP8W7ADYcs1GFGjLLxC0X9LuWiaY3kELBBs2rrg3XMUm8reONPrOAKkov2mODzq4eYvRTk7xh8Dm0qcGzVWMbGfd5K/Gt0RhwIWuRf68TesmQl8eAlyO26SvfmqYWHuWeUkA7shUXq7CEGntTZDFe/m8wG+ayQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(7416014)(376014)(10067099003)(3023799007)(11063799006)(6133799003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OBRHjYwqMsrrL7BmNVbv/dGW19ahGPeiHhkIY5qGHxHbzQ4T4AM7mr4EBzgemMf3G3iC6igV59c0RGVha1dyAYDiiEtDxg4jlacf4EDJfeXhFrf7z8++r9hEIAwTh013LtcimXZXxZ7UxDxKGAlIWbLOc0s1iSUdhCLxrFDTf69kuO/B/LdHbJnBPKQk+cw1oe7dc+caqzDvskMwBs6xStkwFSmF0BugyBI/s4FfvPECT3A5n3l2CWzJPIUdpqCJZdopO50nhR7dH9isN6eL5FyRKM/mahhhwK1CKNywA0u/KO+HXZ74NF47t8O0OqSXC+w0igCkTkdtu2KSVEaFo3kypoo19lUDIygOk/GWgMxnoj6/bLKzKaPK0eUoFPrkSUnJK+9Tt74tYVY+qdTQlWQgsSMvQL+6ktxPz9v9610ht/SyA1vd1dqz1iLw5N7m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:27:47.6296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b94d1b1-a522-4436-2ea8-08dee452a149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727

From: Dan Williams <djbw@kernel.org>

Tighten the CPER protocol error kfifo registration API and symbol
visibility.

Use EXPORT_SYMBOL_FOR_MODULES() instead of EXPORT_SYMBOL_NS_GPL() for
the CPER kfifo registration symbols. This names the consuming module
explicitly and gives compile-time enforcement.

Drop the work_struct argument from the unregister path. Change the
WARN_ONCE condition to a NULL check since there is no caller pointer
to compare against anymore.

Change register/unregister return types to void. Flag double registration
with WARN_ONCE() inside the lock instead of returning an error.

Change cxl_ras_init() to void because there is one consumer and one producer
so the error return was unnecessary. Remove the now-dead error check in
cxl_core_init().

Add a diagnostic log when the driver is not bound in
cxl_cper_handle_prot_err().

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>

---

Changes in v17 -> v18:
- New patch.
---
 drivers/acpi/apei/ghes.c | 32 +++++++++++++++-----------------
 drivers/cxl/core/core.h  |  7 ++-----
 drivers/cxl/core/port.c  |  6 +-----
 drivers/cxl/core/ras.c   | 12 +++++++-----
 include/cxl/event.h      | 17 ++++++-----------
 5 files changed, 31 insertions(+), 43 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ca7a138c1ff2e..187f54e31c33e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -778,41 +778,41 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 #endif
 }
 
-int cxl_cper_register_prot_err_work(struct work_struct *work)
+void cxl_cper_register_prot_err_work(struct work_struct *work)
 {
 	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 
 	if (WARN_ONCE(cxl_cper_prot_err_work,
 		      "CPER-CXL kfifo consumer already registered\n"))
-		return -EINVAL;
+		return;
 	cxl_cper_prot_err_work = work;
-	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_register_prot_err_work, "cxl_core");
 
-int cxl_cper_unregister_prot_err_work(struct work_struct *work)
+void cxl_cper_unregister_prot_err_work(void)
 {
+	struct work_struct *old;
+
 	scoped_guard(raw_spinlock_irqsave, &cxl_cper_prot_err_work_lock) {
-		if (WARN_ONCE(cxl_cper_prot_err_work != work,
-			      "CPER-CXL kfifo consumer mismatch on unregister\n"))
-			return -EINVAL;
+		WARN_ONCE(!cxl_cper_prot_err_work,
+			  "CPER-CXL kfifo consumer not registered on unregister\n");
+		old = cxl_cper_prot_err_work;
 		cxl_cper_prot_err_work = NULL;
 	}
 
-	cancel_work_sync(work);
+	if (old)
+		cancel_work_sync(old);
 
 	/* Discard stale entries so they are not replayed on next module load */
 	kfifo_reset(&cxl_cper_prot_err_fifo);
-
-	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_unregister_prot_err_work, "cxl_core");
 
 int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
 {
 	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
+EXPORT_SYMBOL_FOR_MODULES(cxl_cper_prot_err_kfifo_get, "cxl_core");
 
 /* Room for 8 entries for each of the 4 event log queues */
 #define CXL_CPER_FIFO_DEPTH 32
@@ -867,12 +867,12 @@ int cxl_cper_register_work(struct work_struct *work)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
 
-int cxl_cper_unregister_work(struct work_struct *work)
+void cxl_cper_unregister_work(struct work_struct *work)
 {
 	scoped_guard(raw_spinlock_irqsave, &cxl_cper_work_lock) {
 		if (WARN_ONCE(cxl_cper_work != work,
 			      "CXL CPER kfifo consumer mismatch on unregister\n"))
-			return -EINVAL;
+			return;
 		cxl_cper_work = NULL;
 	}
 
@@ -880,8 +880,6 @@ int cxl_cper_unregister_work(struct work_struct *work)
 
 	/* Discard stale entries so they are not replayed on next module load */
 	kfifo_reset(&cxl_cper_fifo);
-
-	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 07555ae638594..23fe40ddf4c6b 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -183,7 +183,7 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
 	return &port->dev;
 }
 #ifdef CONFIG_CXL_RAS
-int cxl_ras_init(void);
+void cxl_ras_init(void);
 void cxl_ras_exit(void);
 bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
 void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
@@ -192,10 +192,7 @@ void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
 void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
 #else
-static inline int cxl_ras_init(void)
-{
-	return 0;
-}
+static inline void cxl_ras_init(void) { }
 static inline void cxl_ras_exit(void) { }
 static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1215ee4f40351..f90f899c31d07 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2531,14 +2531,10 @@ static __init int cxl_core_init(void)
 	if (rc)
 		goto err_region;
 
-	rc = cxl_ras_init();
-	if (rc)
-		goto err_ras;
+	cxl_ras_init();
 
 	return 0;
 
-err_ras:
-	cxl_region_exit();
 err_region:
 	bus_unregister(&cxl_bus_type);
 err_bus:
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 99fb00949c2fa..135f1997e6f4f 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -104,8 +104,11 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 	}
 
 	guard(device)(&pdev->dev);
-	if (!pdev->dev.driver)
+	if (!pdev->dev.driver) {
+		dev_warn_ratelimited(&pdev->dev,
+				     "Device is unbound, abort CPER error handling\n");
 		return;
+	}
 
 	struct device *mem_dev __free(put_device) = bus_find_device(
 		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
@@ -129,15 +132,14 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
-int cxl_ras_init(void)
+void cxl_ras_init(void)
 {
-	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
 }
 
 void cxl_ras_exit(void)
 {
-	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
-	cancel_work_sync(&cxl_cper_prot_err_work);
+	cxl_cper_unregister_prot_err_work();
 }
 
 static void cxl_dport_map_ras(struct cxl_dport *dport)
diff --git a/include/cxl/event.h b/include/cxl/event.h
index ff97fea718d2c..3471d4f75c025 100644
--- a/include/cxl/event.h
+++ b/include/cxl/event.h
@@ -287,10 +287,10 @@ struct cxl_cper_prot_err_work_data {
 
 #ifdef CONFIG_ACPI_APEI_GHES
 int cxl_cper_register_work(struct work_struct *work);
-int cxl_cper_unregister_work(struct work_struct *work);
+void cxl_cper_unregister_work(struct work_struct *work);
 int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
-int cxl_cper_register_prot_err_work(struct work_struct *work);
-int cxl_cper_unregister_prot_err_work(struct work_struct *work);
+void cxl_cper_register_prot_err_work(struct work_struct *work);
+void cxl_cper_unregister_prot_err_work(void);
 int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
 #else
 static inline int cxl_cper_register_work(struct work_struct *work)
@@ -298,21 +298,16 @@ static inline int cxl_cper_register_work(struct work_struct *work)
 	return 0;
 }
 
-static inline int cxl_cper_unregister_work(struct work_struct *work)
-{
-	return 0;
-}
+static inline void cxl_cper_unregister_work(struct work_struct *work) { }
 static inline int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
 {
 	return 0;
 }
-static inline int cxl_cper_register_prot_err_work(struct work_struct *work)
+static inline void cxl_cper_register_prot_err_work(struct work_struct *work)
 {
-	return 0;
 }
-static inline int cxl_cper_unregister_prot_err_work(struct work_struct *work)
+static inline void cxl_cper_unregister_prot_err_work(void)
 {
-	return 0;
 }
 static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
 {
-- 
2.34.1


