Return-Path: <linuxppc-dev+bounces-24386-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEA6C4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:27:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h24L24w6lz2yRC;
	Sat, 18 Jul 2026 08:27:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784327274;
	cv=pass; b=lwkOE/OoAuK0ZcuP20hfqzQXze0KGTf9N5sPzvnWTtAJD65F++iiZcNJtfpBwoq1E5q2zlioRQjccBiBf+ANDhL4Wfeu4q1qT30vnQf62F8aFMyFLnRlJ1t6R58emYZGJzvZVLeH0+OzCWYFq1kfr1jj7QYWfDKquwb1zxgrP0rnSnTyXyZAYdNJo06gyt6/6TiFNK+nU1VSmuMfsmc0bTpDmauTaF6hYl8mPpPcu4p1pjv6Q3u9aXdslKovzlJZPpllk3Kgp2XhCWFAZR5sMJYYJPSEw1dpSbS0yGbQe2NdY3JjOzI9S1QjIrDJS6xqnYmHbDc5pyGO9ahb8Kw+uQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784327274; c=relaxed/relaxed;
	bh=yEslr1NThbZNUP4XuSOwUEJ1PFcL2iZnzwxz13slxf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyL2J7QOTror1RsKkxdeApXTbTE6iFnt6xcQvC6lmqVSe+A26wJrLV/P5x/FQofXJYe9ouCFUKOeAjDdVYL75YUoPA18Hl4g2Xqn+lE8IsLHXZVP5HB2fr4pQJEgyVJKk1Ve0470oiN5PqzpeNBhfEYwWkLqn7L4KwuFc7vvxgm+fWcMf439WvWJv4GeePdtYp28QoC+ixqrr3NLAtWYiPUBv4xrI/MYDvn+9pXDHzLhq+vxz0iWwwDqht8grTDSyatP+ea2k5s36OqbPBsnAoVixt6jDiptSNDqY7k+8477k3r6E0x5S0jQkOkc3NsC60D6ZxoLJ2YdOFPO/fbyFA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AUfrrPUz; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=AUfrrPUz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h24L173lzz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:27:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdLlQ5iBd34dCZVB8wvnaO5rdslJp8xA1KxjSkOA+03IhMaIhayiMnTASXDHZ3duGaOp9NzKwAEWuGCLNCTwm0n1K0W2o8hvicVsiAIggw7VjgyRX7lL35mQe17OQ2OL+1jU89q17309aGXv/WuUS5y0TXW0q6W+L55trttymX/AN3159oVHiwXoE3qcKt3jU5n8zxSxfTljHzivzKujA4IAOXg+5VEM3Ul+n4z1SrtvptSsbXqhTN/JoJcOE9VOmI1bTQFYCsyvE/3maizx7pd0UvszGFj5LdLPImn2ZMWhhngZX/WWcvO/kHKH+wzr5NQObAEAGPVyH+K9mrk/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEslr1NThbZNUP4XuSOwUEJ1PFcL2iZnzwxz13slxf8=;
 b=bAsNMFFJiiu29DoKd9e3VCOzgYtqDZBu4bofOHMGwMCP1erHe+sF9X51RnzbOzihDkhMJT5S67i/dJ5qdXqnuoAd0YTBLFbgMA14WtAAPwPkhUZCmTWvgr3uGGIb9qNNysbKvF3DTlqUuj2JdxMShc2PlzGJZ1ln1SJaysiw3bN2Esxp3IaGf2JSsH6MRKO3ZpApwtIhV85ndSKMP1OfazVZxQl70WTQ0xvjsh79bOt1SnqGH931n8/riz+U+VeUJER2L+5/5YvMzZ8Hd8lyGdFBbR/VIKndRfvrUvD4fqlU1VvNLcrDM64j0/M0G9jMTtMjx3N7qzMK6bZKa54mbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEslr1NThbZNUP4XuSOwUEJ1PFcL2iZnzwxz13slxf8=;
 b=AUfrrPUzS04od95aL9aJydxvs7MyIedk8WKWc2whuCl9exnLwhcjzKhkffvG4Km8OkU7xAjvrbmvRzV1kb+fAi+06BBqq/shc6i7x2SWw3/Lwf7EDMATOqFUK1D9VxR4T7boKlBywW6QQKbKJqfk+vAh1YuXVNAnN7wbyb7NMgk=
Received: from PH7P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::20)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 22:27:25 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::a9) by PH7P221CA0016.outlook.office365.com
 (2603:10b6:510:32a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 22:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:27:24 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:27:23 -0500
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
Subject: [PATCH v18 01/13] cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity register
Date: Fri, 17 Jul 2026 17:26:54 -0500
Message-ID: <20260717222706.3540281-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbe59d6-60ce-44e4-c1ab-08dee4529398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|376014|7416014|82310400026|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	BH5QyqdR/WbWv5osK423qbI2w2bROVXXIf1J94BVceLLQBp5y43XbTKgWhln/CkmW1jLIqsnIwznkYC3/ASOAl6LmPhth6liqAKBJjdLmDvfIoG0OFsMIDYV6RISiDVvyPq0N6WIQkU+XCmT1hSr1Nya1v1+R6Ujf5INngSqjSGLOFqBieOIHkWxQA5YckY/rn9Q1g9h78pZzmYugK8gaow2xyK4d1ezuhZ0lcFOEEHt9OlSM0TRZn+hPNBAZqD4lm48upkKBLo/Lj/6JhyAY9yQz4OT0enm4cO6ggKIZjXvf7XDGQ8MVyHRJ9/JNmXx1eCFniG4fFzzHXv5e5ZSbiVMpyQVCK/TitPXKkRNywt4I36Zo0hAAINVBDM82QwKwQuUnskLZKzZjDlPzhoLPvhKstnAUIAZYoMrzkC0A6lrXXENtk+8dLnSiyQ2QTdsbKEh0wXsdukBtDRj6739F4SMJXbgNP2E2kJ27e+d8MDIDBsJUoGHQ8+YY2JaPJCEEEQclGErFC0DoDSUI5M7Q5Lio35VBuedAQBP7Q5baKT2s88EJXF0CJ7/Oid8vH+pmJUDRhtKC+cItSJMIUR/PflG909mKVxUZ04lQ1I5sF29GgkqDC5tn1fp4mGwbiSi9+Kb+thrfrATXhiPD6q67bzFlTwBIrcC3HhnvC51PMx2lQlcguqQyUbCxZvGykgFL9c7UnTv1MakbQhiBGPAhQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(7416014)(82310400026)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KlTuWe52nXAENRbGDWxSwyAISApgj/ghCD9yGarHdsTmBRKlntv84nZ8mnqnXMQuSNCekWh2VKO3bKENl4JEba8CdWqpHP5USsRPjKwVRJsGNkbaxx+TbSWSDA8ebA2M44/ONCnoPYztao+wSbtlmQvis9+uuaZJa6nTHZ4pQkuMJ7SVscIKrHCcF8+F4/vVofGrVelUVlEUra9vc0Gb9pnyehPTPnuLFmDoK8Krcq5cBOcCVSJ+b5fAfaHuZ9HRfcfTUjSXKUVP7s9I9YM3geTW4qv6lFXLsYjG6R0MXY9lKeHhr9JQlwAoMLhyEWAt/Q0RTkwOgfhkbzStUb0+430NA6IkbiIl/OJrTHbxCl6O5zjXOguHSZPMqDd17/Vc3H73bKR/0ZbQSnG/MX7xcG6eyukKNywT4Soc6LhQU04nBtAEeKco3kaLBxn0S71w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:27:24.6579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbe59d6-60ce-44e4-c1ab-08dee4529398
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256

cxl_rch_get_aer_severity() classifies RCH Downstream Port uncorrectable
errors as fatal or non-fatal by ANDing uncorrectable status with
PCI_ERR_ROOT_FATAL_RCV. This is wrong because PCI_ERR_ROOT_FATAL_RCV is a
Root Error Status register bit (bit 6), not a severity bit. ANDing it
against uncorrectable status tests a reserved bit and produces incorrect
severity classification.

Fix by ANDing the unmasked uncor_status against uncor_severity. Per
PCIe Base Spec r6.0 Section 7.8.4.4, each bit in the Uncorrectable
Error Severity register indicates whether the corresponding error is
fatal (1) or non-fatal (0).

Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
Cc: stable@vger.kernel.org
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v17 -> v18:
- New patch.
---
 drivers/cxl/core/ras_rch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 0a8b3b9b63884..44b335d560708 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -80,7 +80,8 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
 				     int *severity)
 {
 	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
-		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
+		if ((aer_regs->uncor_status & ~aer_regs->uncor_mask) &
+		    aer_regs->uncor_severity)
 			*severity = AER_FATAL;
 		else
 			*severity = AER_NONFATAL;
-- 
2.34.1


