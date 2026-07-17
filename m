Return-Path: <linuxppc-dev+bounces-24390-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C32C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:28:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h24Lg2QK0z307v;
	Sat, 18 Jul 2026 08:28:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784327307;
	cv=pass; b=nXPUboIJPy4m2Slwdq2qV7wzy2TbAnUidetUd31OF1jRKG9MFTJv078iOb2KoenkwSjMKjOZyjpCtZ5v3wIjqCrZCdAIyJ7wq8sKMMwYMZTV0rmWEcyR4rW/WZC+eoxLY4X4zhazgeo4HsuQfzKwv4BBoL39DgdDFMi+sxHiKoo09aGQvvMeOi6NOE6SK4cVtUoI7mkhrqhwVUlXjwe7QyIVARxzGpRIA9E3niBnXe5zZDQEgsUgJjaArpZiw/4EH8DwXOWgEBYo81nxcmxZ5i2A43CFwSZHZQFH9Qj/dABIYbsU45Lo/cMsb5VCrhzRaipYo0y7/eBM9U8rxHoAJA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784327307; c=relaxed/relaxed;
	bh=Ya9DTOOB1Pg91N8QYD5N/Pltr0DcD+7FavPhkoTmtWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naG/LHFVqddP49n6mOGjrZuHZmCTXmUqwhAhHZmKWcdA+ENzJUJ7eCvS8VUR96ewPzDbNYm3VW6wAXkYM6S5rksO3NCQUFKZ8J8QTPgzjjpiS0zxkNWkCQd3vmryUTRl21a7qe0mWOuu7FJH5xKm/h9RUeyhwfGrylYJ9METSbD0dtd7vG6fmiL3H8II+kA5RgB1FGqUaw5IXOEhhA99cnxuPpy7ZQL0yosSys1/84lEPw++bwZMrJgOIxI10IHLG6np84NzzSkiSi6bf24SbWqlzMdrgpsnBGhGE7FaDE9+IuAodrVMQih4FiWcgnKZ+uvSkSKl4FKkB6qw+ZFpQg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QikIYpiK; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QikIYpiK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h24Lf1TL2z2yZf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:28:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJ/JM4XMT4inuwpa6qQeHaEwHe9GeP4Z889ta+sDB0SuHIr/rRUgLHIngRB8SWVkoTn9ebQ6Qc0hHOv3n3BdB94M4ocRu7fzVI/SxS8Ng1z3PSsUofQC0BcmK/wZehHP8ooJXYfrILQCKe2whNmyHr/EZ5U4IhBMG9ItdKFcUW713izZi/aYixAvGTRKvRDhVv2iifoUgl27OM6z8VRKP+M5+147qV53UP/UBPz1OgW5vCrHF+gbpnt4MD9RWkXTgzeCTq55lWRtc5gJ1dSPGmO2iXRf/OGDTa2K4vkc5FfzfiJgK3NfoGW5gsawvOvyp+LA2DCCFcnRu+LmGTSILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya9DTOOB1Pg91N8QYD5N/Pltr0DcD+7FavPhkoTmtWs=;
 b=E47cZ0l24FNauG0AtaiRklW/Yc2jFuQukWMK3or5+A9xs4N6aNg6syNygm8Wae+wRK8j+OQR+DNNVIGKJ/y+UKAaZaHpwYY2UKeNruVq/9goRI++t3f2wRHhvLZZhhbAw6A65S8aP87oZId96RTtJKkWChzcWSvpO5QdJY9Z63oKwU2z/9OgJQ2/nxEzn+R702o6Q8oaTEIOVJdCNN+f11I1sXtxyWyiUNRnr2X3FuZJ1Bs1QoYBzGYVXoTsjKDL/NPCPWn9QMYj06ksrbblyTtJbwMsM99wZzvryZzoDre7vgy3v7x4CkrjVS0KDSemqWOGZ2aMExCr6zCeeZz4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya9DTOOB1Pg91N8QYD5N/Pltr0DcD+7FavPhkoTmtWs=;
 b=QikIYpiKW69IZmkpqW4s5XwO3sDbk9gLo5XOgknCCosOHesZfR+byKxOGXpjM5LuglO9hpCjfzsRqyazhyVSg5O3RE6e05rZSB8IjqsuXIb8NYVSJE93hnO5IpCHyvj6K2bzcBt9K3UyVC07adWwwT7WttsMPsj7Y1OV8huM1sM=
Received: from BY5PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:1e0::34)
 by SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 22:27:59 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::3c) by BY5PR03CA0024.outlook.office365.com
 (2603:10b6:a03:1e0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 22:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:27:59 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:27:57 -0500
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
Subject: [PATCH v18 04/13] cxl: Rename find_cxl_port() to find_cxl_port_by_dport()
Date: Fri, 17 Jul 2026 17:26:57 -0500
Message-ID: <20260717222706.3540281-5-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: 941bccf6-d9dc-496c-9519-08dee452a820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|6133799003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RakSHDiV2T9lp8IoPY5eKY300pLtT6yfScXvom5WMst9m2z5+Ld8fDXEWG0vXgXIuIET99123b3MQO6EyBoe5wwK3ilgxo8fANibFjnj/8fma4xBM05wvsZF9p5d8vuVyehjDw/5IE/4hT1urS1VHkTf8D+KHQ6I1ZYmJAQZJVNkL/L82bfo5B9dqWwpsnXp0db9qLtlJuVRjfx2KDoRqYLQ5VbWPOmLpgjD2zw8Yu6M/TXtjTW+GsHAz6qTqdoa8ALPwR8HPeCxFY1zM3/+lSI5uuKpZvPHPdA42QzHu+2hup1TAbEs/CHlGp7s4NGW1ehBk4tUbRGoGLQRPYHvbjT8bggdqls8J1+l0XCnTUrYAZa9ck/+dpg6hyAIGE2/ldGyj4YSiM9CfQZ8YKoS/gPn6fUd35rT7WHjjeNFTXV9aaYWrqleFwzl48zacRUuhH1r38f4TTdb7zGMRnDX4Duk/0l21jVq2qurdDWljCyBpr/g93b702pBP65xS4zv7BUN/UhaaklQq+tTM2gbeqyYtcAJ58p9xPYsFaiUktsJFf15ywLiZMTAwvkejmZqpUMvHecL8F+1QKLhO/Huqz5yr1hTZqL+oxytXltKr4lQNtUKuQnkw9JCmD/C0/i+VvGKATVFlQ2vPjdUtT6k2RMXTqVMSUActu5oXwam6DMvi7H/vQFTHi93Cr5Y1R848cxjS7uOn44l55vWrxlpqA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5MwJ1O27XI183tAFPdEzQfKHdxUHgvicV2yfMWOkMVskxyjfVIytIoeBeqjT5SUoIiM41t4xmNLhBc0CS7NgESmqfR9vxqwJhh6IbJKxCDBt59WKXZJ3CftLtXQuGYG49j8SrIj3RWFUDTj9JOj1A6lMA1Uyh0KiXMXp/ILsMPtOEw5ScaxO0ONr/LoCpxlFPCGutWnORa8VOVv7kMJR1w6HhYjwaZgBjLMyRPBM+bCkpz+F9Kepyj8/tFgwRpf5rY5mQ0EqX2pchEcipvxiAUpXoSkunJeX7HBemDvCR9eSMwtFzbAcpLsl3ek30IOHVUmvjMzNnbwuhV/B48vhyd/dzz0Nfl6XnXiomRvyXhBeI8sO2tqtUmSGfH9u/uoAT7ltuuwEJ/Sf47pHleyf3Goizo4axLJl5lXwCjmD9eF9QVnsuJVIcFqopOL43qcl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:27:59.1077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 941bccf6-d9dc-496c-9519-08dee452a820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

From: Dan Williams <djbw@kernel.org>

find_cxl_port() and find_cxl_port_by_uport() are internal port lookup
functions that search the CXL bus by dport and uport respectively, but
their names do not make the lookup method clear.

Rename find_cxl_port() to find_cxl_port_by_dport() to make the lookup
method explicit and consistent with find_cxl_port_by_uport(). Both
functions remain static to port.c; the upcoming patch that adds the
first cross-file caller will widen their scope.

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>

---

Changes in v17 -> v18:
- New commit
---
 drivers/cxl/core/port.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f90f899c31d07..cadb51f70f854 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1379,7 +1379,7 @@ static int match_port_by_dport(struct device *dev, const void *data)
 	return dport != NULL;
 }
 
-static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
+static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
 {
 	struct device *dev;
 
@@ -1392,8 +1392,16 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+/**
+ * find_cxl_port_by_dport - find a cxl_port by one of its targets
+ * @dport_dev: device representing the dport target
+ * @dport: optional output of the 'struct cxl_dport' companion of the @dport_dev
+ *
+ * Return a 'struct cxl_port' with an elevated reference if found. Use
+ * __free(put_cxl_port) to release.
+ */
+static struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
+					       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
@@ -1401,7 +1409,7 @@ static struct cxl_port *find_cxl_port(struct device *dport_dev,
 	};
 	struct cxl_port *port;
 
-	port = __find_cxl_port(&ctx);
+	port = __find_cxl_port_by_dport(&ctx);
 	return port;
 }
 
@@ -1895,14 +1903,14 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, "CXL");
 struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
 				   struct cxl_dport **dport)
 {
-	return find_cxl_port(pdev->dev.parent, dport);
+	return find_cxl_port_by_dport(pdev->dev.parent, dport);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_find_port, "CXL");
 
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport)
 {
-	return find_cxl_port(grandparent(&cxlmd->dev), dport);
+	return find_cxl_port_by_dport(grandparent(&cxlmd->dev), dport);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, "CXL");
 
-- 
2.34.1


