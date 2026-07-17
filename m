Return-Path: <linuxppc-dev+bounces-24394-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF47C44516
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:29:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h24MM4hqHz3c3K;
	Sat, 18 Jul 2026 08:29:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784327343;
	cv=pass; b=I5a96+umTgjFwDbYWzXR56qQFPgtm4RZP5braY5Gdgh3CHXIVKOVUKtIwMWlEYooaLQNx2bdD+WRq9zmaFv3Fn3ed25g6IdfPIRZTUUrRUGrR9uw9/AU1MoIgoF2hn7xiDbPhwUjk6hyhH3EuSB1sYUiwJWN0qBYHgQPkUHi72HC8Op2+D44cN+BxqBtAg+RM+Zhu7ZF5zV4xBLFQ9z6X27bWYnLsGzeiaAEWqm5ONXHbGNDgJZ7qrkaYYaY72DfkPnnK8eIRIBJfYCaUWjB7dpebSfyvNJgy6GMUuMuIOHcfBta95HwBIwFp3GXFdMYyU02G7gODMbiKYTG1zFe7w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784327343; c=relaxed/relaxed;
	bh=FKptL42rOdimuUV7XOnSQCTLr4XMj1qFwilDIogX+go=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5l89xGbNvb8bUS9ZMVoT0HJdnFUhdANGnTprmx7GsQGrmuLTef30VAIGNZ2xbYevPT6LHu/5w1RZ4/AT1DmuYFW9Rz5x2lwGr9+8MVaazPvoqfsTJiq1rGF1tgSnnuGw6zN22Mm99U4C7UujBK6tq7JXT+wGLziJuqqusNJWW5ls/FnWBw/ns4BCpNVb2bswfMMNBx+GpNp84lynhMWlkjcTnqUCZLVR3dDDvR2Vz6aaQdN7HSFcEcP7BJS5WSkr1YvrdjylakZvj8YW9wM2xqdxD9lwP3J2obdLUvGmnck8lSXtx0YPRuhL+mZK0kSqZiFURM+6ZvhEMwo+nNXBQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KMoFrTE1; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KMoFrTE1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h24ML5xlCz3cJD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:29:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBm3xDXF96zaCnfbsvGuDbFE4Jgrbct8jxKaWIELqQNuMgAgIjoscKgO378aXDWO/Oy0xFHgq1U0dAlWx5IYsvsrJfxAZ01DkIbC/jd6+fy9+dhvXMglc2IyR8iCLJDIqq0IcZ5PnJAVh98U3cKkY8/xmUJ+CeNuCHRZKe+Kgk6WjqhQxebXf3IjzWn/vGet7Oj6flrhltMdDHudknp/U2+7vCl1OZaCYTMpZNb9npe0OOucnx15qdFBM4jc7nHODPgG39wBiRqsR5m+Ar7vBuFqa1wHyCrWVSNis1ZhIK0FbOHdcClP3lwiCNk0C+afGiQV3Tkdx8B+Ur88Gm9kVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKptL42rOdimuUV7XOnSQCTLr4XMj1qFwilDIogX+go=;
 b=WGxaSKLKLUvq1mOWqO7nVzqIDcczf0gkKabvlzkKhc2mcIRrEzE5P0jlY/haLG/51Tuv+qLAW8a+2ipZvnJjiS7lX7N+4Tr44AC6UVzq0mgj8M/LNDMsKBibqnXfox7X9yUO309JRzyNLLQgFSTYwd64PNgq/VHCpITvADv7o0A9eMT/yoZM1dkaFUvN48yOquIFhzU3S5XgZo0rKTuBYjJmXFYUXS5NDF0/6XJE5e/XOP552fSYnwp4NMKd2b3IMKYxlMBusXt9/Gi4nkuEOtEjBTmolXiqApmHmdq9RKX7evcXWu71JJDymspq+wwcIfnNv2pQ9ddUFZ0DM0NoCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKptL42rOdimuUV7XOnSQCTLr4XMj1qFwilDIogX+go=;
 b=KMoFrTE1EqqPHDXhUNT5luclpt/HNTij3Pwep0Sq9MdjL4hrtR2aqzUUXmq+XyXQA1rLakWTEPRTU3SNzT9QSMwvKOfSttr2rdh91Wb/Q1pmqy8T6TUaFaU8XHM9u10DE23R5LBZ8P+U6l4BouvLgrb4s5NY3rRlc09EeLWpFAE=
Received: from SJ0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:2c0::6)
 by CH1PPF84B7B0C96.namprd12.prod.outlook.com (2603:10b6:61f:fc00::618) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 22:28:45 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::c) by SJ0PR13CA0001.outlook.office365.com
 (2603:10b6:a03:2c0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.6 via Frontend Transport; Fri, 17
 Jul 2026 22:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:28:45 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:28:43 -0500
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
Subject: [PATCH v18 08/13] cxl/pci: Thread port and dport through RAS handling helpers
Date: Fri, 17 Jul 2026 17:27:01 -0500
Message-ID: <20260717222706.3540281-9-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CH1PPF84B7B0C96:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f9441c-65aa-448d-c6bc-08dee452c3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|82310400026|1800799024|10067099003|6133799003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	CbqYr+kY/IgsXX1RSccqFz3lKtzHOYZv7GP2hK/QmKP9xRVzgur6oXsl0OQGJJjqnCjlKzX4MZ6dc/7OzlX5kmOlliFkVgai0xSGAcsyRKh46PK4F5pVjAiD/Ev5ZrdYD18zWR/OstWBvI/6hwXZ0g5rIO/oRqPJzN6iv8ZuONqdtHFJH6pSGp7c3Udj8UE1NC9Z7r7u6O578slTM+cizsQ4wKwuf/CSry9E8zP1Hj8HBRfkzOWh6/EXu+Talfz4TMygEYpcTB2KkFy/89ZqtIe4X1v8yrXwK6mw+m94kEUc+wo1cSkgd+Y/B9JrgctVBqrZn/sGrEdhKIXlmsnTbly/RhSk0WK68NXUeBSVxF6moQL1nFqZLlMvcHn0Sb56FP3J23F5exUOX+6pWSGDYZp+foFbLQ69tF6LsBMysLjqCVbTdn5KZ88qD2w5Co/NNfXNNGW9L8ctbLJPjOGrqQPeD88hsrq96AeEHpOhKhte7Win6eR+/I2WYQu7+zpBbQSsAZPzFc9S/UH6OXAfUTf4zVusFqaArBU3Vg8WzHfw+q0euQDuwQEN2yyE6NKWyPmcfryfzlW02Z8m+dUbKmLskRM3tNxsq704Zd9tvNwIFrm1UguDpsO5pnRH/jcRn5CzwSBzjEiZzhTE4zbOhfovKkPrrBTT1V2F1x+M8h0Hz6i0+dwXzIHf9NWvzxWwsPBL5EplMsndra/KOx08yw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9mVrq4ePbfxXja9NrMW/sws2QQjBmvf4sy5YD+2r80mMyYFFLENFBQzzrEaILCahpxcJi0+NGwO0/JcKUxoj64KrmjvuJcFKpT9HwxtS4ztqcY8s0YwjotSyqg8C7nc2S6qGccgnTbyipoLP1qnPkHi2pVfeDJbdV+500g/zmfVuknBiygwzK1u4UayhG3SqCJEum/RSOkCR2pHompIxxYMbRbV6SehJeN1N0s7l1x3+NZ9J6qvH7lLYjSRQydglFfyHs4mZN889bQw4fJXxOap+evo/RxmudtMaSxbncgsDYpD1WnKYVkLyyx6YsvZEkeI+hy/TIfKWDcGLLwV3VqF8CvJNjNIxvDZALxhQhZjxzY0D0E67ZUt1mnLnZGz8iw/KSj9N7VyH/T3ZMXFGWgud5SiJgiWzd5x0XJ7SZuhHnYDcbys0/z1YY7WPKpTM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:28:45.3215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f9441c-65aa-448d-c6bc-08dee452c3ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF84B7B0C96

From: Dan Williams <djbw@kernel.org>

The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
a struct cxl_port * and struct cxl_dport * for the device being
handled. Passing a generic struct device * requires is_cxl_memdev()
to distinguish Endpoints from ports at trace emission time. Threading
port and dport directly enables is_cxl_endpoint(port) and explicit
dport/port branching for cleaner trace dispatch.

Refactor cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
cxl_port * and struct cxl_dport * directly. The CXL RAS trace event
emission logic is split into three branches: Endpoint events are
identified via is_cxl_endpoint(port) and emit with the memdev, dport
events emit with dport->dport_dev, and Upstream Port events fall back
to port->uport_dev.

Update cxl_handle_rdport_errors() in ras_rch.c and
cxl_handle_proto_error() in ras.c to pass port and dport to the
refactored functions.

RCH Downstream Port correctable trace events now report the dport
device (dport->dport_dev) as a consequence of threading port and dport
through the RAS helpers. The following trace event rework ("cxl: Add
port and dport identifiers to CXL AER trace events") adds explicit
memdev, port, dport, and host fields that provide full context for
all device types.

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>

---

Changes in v17 -> v18:
- New patch.
---
 drivers/cxl/core/core.h    | 12 ++++++++----
 drivers/cxl/core/ras.c     | 29 +++++++++++++++--------------
 drivers/cxl/core/ras_rch.c |  2 +-
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 272634ff2615b..5ca1275fd8f35 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -185,10 +185,12 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
 #ifdef CONFIG_CXL_RAS
 void cxl_ras_init(void);
 void cxl_ras_exit(void);
-bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
+bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
+		    void __iomem *ras_base);
 void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
 		     struct cxl_dport *dport);
-void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
+void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
+			void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct pci_dev *pdev);
@@ -197,13 +199,15 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
 #else
 static inline void cxl_ras_init(void) { }
 static inline void cxl_ras_exit(void) { }
-static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+static inline bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
+				  void __iomem *ras_base)
 {
 	return false;
 }
 static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport) { }
-static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
+static inline void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
+				      void __iomem *ras_base) { }
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 9a142abcf4f8b..6f4a3c1b0bb85 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -232,7 +232,6 @@ void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
 
 void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
 {
-	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
 	void __iomem *ras_base = to_ras_base(port, dport);
 
 	if (!ras_base) {
@@ -241,14 +240,14 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dpo
 		return;
 	}
 
-	if (cxl_handle_ras(dev, ras_base))
+	if (cxl_handle_ras(port, dport, ras_base))
 		panic("CXL cachemem error");
 
 	dev_dbg(&pdev->dev,
 		"CXL UCE signaled but no CXL RAS status bits set\n");
 }
 
-void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
+void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
 {
 	u32 status;
 	void __iomem *addr;
@@ -260,10 +259,12 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		if (is_cxl_memdev(dev))
-			trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+		if (is_cxl_endpoint(port))
+			trace_cxl_aer_correctable_error(to_cxl_memdev(port->uport_dev), status);
+		else if (dport)
+			trace_cxl_port_aer_correctable_error(dport->dport_dev, status);
 		else
-			trace_cxl_port_aer_correctable_error(dev, status);
+			trace_cxl_port_aer_correctable_error(port->uport_dev, status);
 	}
 }
 
@@ -288,7 +289,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
+bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
 {
 	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
 	void __iomem *addr;
@@ -315,10 +316,12 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	if (is_cxl_memdev(dev))
-		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	if (is_cxl_endpoint(port))
+		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(port->uport_dev), status, fe, hl);
+	else if (dport)
+		trace_cxl_port_aer_uncorrectable_error(dport->dport_dev, status, fe, hl);
 	else
-		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
+		trace_cxl_port_aer_uncorrectable_error(port->uport_dev, status, fe, hl);
 
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
@@ -351,7 +354,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		 * chance the situation is recoverable dump the status of the RAS
 		 * capability registers and bounce the active state of the memdev.
 		 */
-		ue = cxl_handle_ras(port->uport_dev, to_ras_base(port, NULL));
+		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
 	}
 
 	/*
@@ -382,10 +385,8 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
 static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport, int severity)
 {
-	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
-
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(dev, to_ras_base(port, dport));
+		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
 	else
 		cxl_do_recovery(pdev, port, dport);
 }
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index f2d2fb83758b9..f4b98f2c11a1c 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -118,7 +118,7 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&pdev->dev, to_ras_base(port, dport));
+		cxl_handle_cor_ras(dport->port, dport, to_ras_base(port, dport));
 	else
 		cxl_do_recovery(pdev, dport->port, dport);
 }
-- 
2.34.1


