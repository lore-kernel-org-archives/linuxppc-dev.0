Return-Path: <linuxppc-dev+bounces-24388-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A83C44516
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:28:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h24LC3dcwz3c7H;
	Sat, 18 Jul 2026 08:28:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784327283;
	cv=pass; b=YnAfAPApqtkT+Xk/akaSNEx/CYPHH0PqTVFOZXZJyRi77gMsUgZQjOYd80DJCbZ4HsSdYcTZvDjwDjbzg975jNioLDylZvH3lipq2qbxeQevx9kHuIkLD0JuYLl/xWwnSsssUHTmvUhDB4FnCKcDL5gaG5PXDkit8JmPJx4vnNMLYdq/oM6TPa5BVYRkMSGasG6obHo0GwMeDGGB/oQlWaHt9nBx/8LuYKqvkFDbiGYoGPJ9nCbhPsEBUHoqmB9SYbuak9ZjTr2PV/vFKi7l82+JLCDdEcZGDiDPU3ZROU+Q86JmiESPmSurNoyrEMGSNmVoOheCCWSsINpTW2N1TQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784327283; c=relaxed/relaxed;
	bh=zFPvGhtbErpN9rbSTgyEunssT6OmnZzksDzZbaCbnfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V77Mztmp45pWehQapNvvKgaHU2AltVGRLu14mfTgsDguWf9Lmngd1r837TvHHt8i0xglZ4wXOinBkj2wOkek3ZQ3zvokR9V7+IKlcLz5OjKvdygnv0gKpbG47WjvyJRaKGJ2O0jDl5D8V2SNgZkMvs7bloPkwlBDJIdtiGl45XhU3wDDp81688+F572iV6EUhUmH5e4R7D/jCFQ5hfVSDWb3bymV6kHSNi0z3wLDBjJzQsOIpmq3w5EPNv8IvZkaF2Ql7sfXFhLk8UswCPknx6wjjT37pPnSdq83moqsiUg96Ne6AjalxLwA2B5rChPTKDb5oWFDOKXoHkPMnOrZRg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lWUQSCz/; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lWUQSCz/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h24LB3Vh6z2yQJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:28:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6XPll94fnO7HKJg41rbyR3HqeDXcQTlJlI7Yq+lA+1SpqT2esgrWR0+7QrCLPIstTq4CdbdynmNxoGoP3DQdn2gBmYOPNS3hS21QRZw0W4L/AYewZYTl1+QOaZ+MUa8qItysD6RYnUIU0BVif48TBL0MyeCzLKfyJbxkXfAZS6eOX/6HQ69HlhFiiF7NfKqGOaEGov3tZYUwYFs+4a34ak0UwbFCIM/3ynpW0tlDmmSNe60hd6wyZnjdQt+T9tZtLtM4W1NMLW0Gvpeuevz5swyWkagE4HYjOcvkmexNvvf83TgVB6sKEyC6F0R7iQtsElDuycFAsVn8Y1rtmDf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFPvGhtbErpN9rbSTgyEunssT6OmnZzksDzZbaCbnfA=;
 b=HS7+tH6+tKKInMYFyVx1ZSa+wTcTHaTecn+xRmGhYJ3uXx7v/z8lI7Cox7kyotwqb6cmEuD/MMpWGcdw0kY34lomSFOZGof1L2QJHoWUk/WI4oAOl4BlGl6JTqBEVPDQHK1W59WvtYzcCPlJYwitlyAjbEuTJVYruYrdZ4ibtIEvy22Cqf6iUCRngCWGr1e4LNMBENt3ThiWZmBgzMr7H5yI0OzvDzb7D4zAWuTG6+ugSn8ymqCyd5asx9iYps0d7n5lKmsvOKaPeRa2FVBvIaGxQwJuaHGI25UVbXxS/pHoAWYs0YqIAtCFMwWBbzLlxInSJYzcnrNt2Lbg1t6vBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFPvGhtbErpN9rbSTgyEunssT6OmnZzksDzZbaCbnfA=;
 b=lWUQSCz/DQ+pACuzI8o4GE4PQ/yjbuJEobfLh0x4sDm/u1O9vE0sO2P47E6ksC8+DnxIjqW7UJ+djs71Lp+bdW8v3+2tMGcARa1kzI8LsqAqDozQ6O+Bd9wEzp4k9ILuNeu+1XfJh4kVWNXrbOvP/UfRp+tY5M1TElO6CqZE+Bk=
Received: from SJ0PR03CA0110.namprd03.prod.outlook.com (2603:10b6:a03:333::25)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Fri, 17 Jul
 2026 22:27:36 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::20) by SJ0PR03CA0110.outlook.office365.com
 (2603:10b6:a03:333::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 22:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:27:36 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:27:34 -0500
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
Subject: [PATCH v18 02/13] acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks
Date: Fri, 17 Jul 2026 17:26:55 -0500
Message-ID: <20260717222706.3540281-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: c59320f9-3c93-4663-8153-08dee4529a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|7416014|3023799007|6133799003|56012099006|18002099003|22082099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	YN5vL81bNGFLQ7bVqw9LLslgx86wOy0mT557wUAK5/l+vRaQcBt4u+y2PIGlP476wZoW43gG8cIa5d3UeaoKe5gVFXqpdN3MiQVyXQJ2C7Jgl6+lghJKvKGptb8x+0nslSHn7/c80GZo0sqdo27y6rzhqAqcCZNDItdMcjKMCWKS/uSTy/B0n6ovzgR8ZV5JHb8gF9ynKa0yKCy+KG8mjzrGDX74/n/VjF334MCHMcvBS4ledM59wIFOarVkoSzyKd72ZSpleESoAKvhXWQrpqaUCncCqwp9KolpmEAhw0n6a1xtB32eFwknfPYAqhWnrlB46O95jl69kG4gayzhWKitszbkoOlTK2rHU7X4x4VWU743OQicBsUp4RRthEwNB1i2aLQFeaGLQQQIZuRiqyXKRl/YNjIbgTB1/Aw6Glbot94LkaNngRrOFJry8apAwxlO0Y7C0WMyG7qb3k/h1foVTONrQvTffeEJ2M0oWLcVrlpvlN3eTRpRHyIfnb5YVxtVMjzRwye95yZR1n2A0osu2q4VqWi04k+h2XpPpxfqejUEEgBX0EwoRM3iVf4Op/Ip8yXglUGd8OCc96OMnfAdRGNyeRe/FEaZmg7ZdSVjCb8h4cIBuumUw6ZbrsHGR8ycQnNjtrFh6AU+EdMZSVCpAh9GRjtiKtJxTptBCgfAVUzYKOsMYCCkiAZzAAoTg0GYywR496rZ8fqNNnC60Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(7416014)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wVGK2H80e+/1b70v2F6MTddiKCUgdTmJWWEmnZIUeopDeaThWJdWcN+2ah4xn4Ogqded42ACb+1YqCjrk39k+L/uExDLdxOnUYP56lh6PZEQjb3mxrp1K9JF9reAnimG/3c1ZfvH99XjlBdaHOfIoGwotUq8eSntp6dc/xbhzWadgEHPgXoSDNNMi/iA2TXqdGP55uTUhVgtWA3AGeiZDF7YlNpLeeQAraZbZ876dA0cCJ4LKs9kNxk5w4Aps5WZIkeJfpiPWgy6lp6oI1aotkwMWjA2ugBvvestlZY+8NJzBLJMQ6tjdzuhyJV3nV8fCDIdGMovkF1SeKDhpOgQQU9Ghy/9GpFfVp+ErHhp9xPl4BjOOktlddW71pYTW7xbDklPLHiyv4KCrvKO2c3VdCphZba9pwtHuzDD3gvWIIoKJN9s4pKf1NQYbNLcB63o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:27:36.2164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c59320f9-3c93-4663-8153-08dee4529a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181

The CXL CPER work registration and unregistration helpers in
drivers/acpi/apei/ghes.c acquire cxl_cper_work_lock and
cxl_cper_prot_err_work_lock with guard(spinlock), which leaves local
interrupts enabled. The corresponding post paths
(cxl_cper_post_event(), cxl_cper_post_prot_err()) execute in hard IRQ
context (they are called from the GHES error notification path) and
acquire the same locks via guard(spinlock_irqsave).

If a CPU is holding one of these locks via guard(spinlock) when a
GHES interrupt arrives on the same CPU, the IRQ handler spins on the
held lock waiting for it to release, while the lock holder is
preempted by the IRQ. The result is a deadlock.

Convert both locks from spinlock_t to raw_spinlock_t and use
guard(raw_spinlock_irqsave) at all call sites. On PREEMPT_RT kernels
spinlock_t is backed by rt_mutex and sleeping from hard IRQ context is
not permitted; raw_spinlock_t is safe in both contexts.

Add WARN_ONCE to both register functions to surface double-registration
bugs at runtime.

Restructure both unregister functions to clear the global work pointer
under the lock before calling cancel_work_sync(), closing the window
where a CPER interrupt could schedule work on a pointer about to be
freed. Add kfifo_reset() after cancel_work_sync() so stale entries
are not replayed on next module load.

Both kfifos are single-consumer: only one work_struct is registered at
a time, enforced by the WARN_ONCE guard in the register functions.
kfifo_reset() is safe outside the lock because cancel_work_sync() has
already quiesced the consumer, and no new consumer can register until
the current module exit completes and a fresh module init runs.

Remove the now-redundant cancel_work_sync() call from
cxl_pci_driver_exit() - cxl_cper_unregister_work() handles quiescing
internally.

Reported-by: Sashiko <sashiko@linuxfoundation.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
Cc: stable@vger.kernel.org

---

Changes in v17 -> v18:
- New patch.
---
 drivers/acpi/apei/ghes.c | 50 ++++++++++++++++++++++++++--------------
 drivers/cxl/pci.c        |  1 -
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6b..ca7a138c1ff2e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -749,7 +749,7 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
 		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
 
 /* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
-static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
+static DEFINE_RAW_SPINLOCK(cxl_cper_prot_err_work_lock);
 struct work_struct *cxl_cper_prot_err_work;
 
 static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
@@ -761,7 +761,7 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 	if (cxl_cper_sec_prot_err_valid(prot_err))
 		return;
 
-	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
+	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 
 	if (!cxl_cper_prot_err_work)
 		return;
@@ -780,10 +780,11 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 
 int cxl_cper_register_prot_err_work(struct work_struct *work)
 {
-	if (cxl_cper_prot_err_work)
-		return -EINVAL;
+	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
 
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
+	if (WARN_ONCE(cxl_cper_prot_err_work,
+		      "CPER-CXL kfifo consumer already registered\n"))
+		return -EINVAL;
 	cxl_cper_prot_err_work = work;
 	return 0;
 }
@@ -791,11 +792,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
 
 int cxl_cper_unregister_prot_err_work(struct work_struct *work)
 {
-	if (cxl_cper_prot_err_work != work)
-		return -EINVAL;
+	scoped_guard(raw_spinlock_irqsave, &cxl_cper_prot_err_work_lock) {
+		if (WARN_ONCE(cxl_cper_prot_err_work != work,
+			      "CPER-CXL kfifo consumer mismatch on unregister\n"))
+			return -EINVAL;
+		cxl_cper_prot_err_work = NULL;
+	}
+
+	cancel_work_sync(work);
+
+	/* Discard stale entries so they are not replayed on next module load */
+	kfifo_reset(&cxl_cper_prot_err_fifo);
 
-	guard(spinlock)(&cxl_cper_prot_err_work_lock);
-	cxl_cper_prot_err_work = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
@@ -811,7 +819,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
 DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
 
 /* Synchronize schedule_work() with cxl_cper_work changes */
-static DEFINE_SPINLOCK(cxl_cper_work_lock);
+static DEFINE_RAW_SPINLOCK(cxl_cper_work_lock);
 struct work_struct *cxl_cper_work;
 
 static void cxl_cper_post_event(enum cxl_event_type event_type,
@@ -831,7 +839,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 		return;
 	}
 
-	guard(spinlock_irqsave)(&cxl_cper_work_lock);
+	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
 
 	if (!cxl_cper_work)
 		return;
@@ -849,10 +857,11 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 
 int cxl_cper_register_work(struct work_struct *work)
 {
-	if (cxl_cper_work)
+	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
+	if (WARN_ONCE(cxl_cper_work,
+		      "CXL CPER kfifo consumer already registered\n"))
 		return -EINVAL;
 
-	guard(spinlock)(&cxl_cper_work_lock);
 	cxl_cper_work = work;
 	return 0;
 }
@@ -860,11 +869,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
 
 int cxl_cper_unregister_work(struct work_struct *work)
 {
-	if (cxl_cper_work != work)
-		return -EINVAL;
+	scoped_guard(raw_spinlock_irqsave, &cxl_cper_work_lock) {
+		if (WARN_ONCE(cxl_cper_work != work,
+			      "CXL CPER kfifo consumer mismatch on unregister\n"))
+			return -EINVAL;
+		cxl_cper_work = NULL;
+	}
+
+	cancel_work_sync(work);
+
+	/* Discard stale entries so they are not replayed on next module load */
+	kfifo_reset(&cxl_cper_fifo);
 
-	guard(spinlock)(&cxl_cper_work_lock);
-	cxl_cper_work = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 267c679b0b3c2..7c6faee7f85ed 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1083,7 +1083,6 @@ static int __init cxl_pci_driver_init(void)
 static void __exit cxl_pci_driver_exit(void)
 {
 	cxl_cper_unregister_work(&cxl_cper_work);
-	cancel_work_sync(&cxl_cper_work);
 	pci_unregister_driver(&cxl_pci_driver);
 }
 
-- 
2.34.1


