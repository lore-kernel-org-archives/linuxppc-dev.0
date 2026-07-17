Return-Path: <linuxppc-dev+bounces-24398-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE58C44516
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:30:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h24NX6b8Zz3c7M;
	Sat, 18 Jul 2026 08:30:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784327404;
	cv=pass; b=D/7mex88WjnSO7uJH6HCu5xOD/fXKsQ8lywpwg+7DGbHzQCn3YDF6xGQrDQ2wmXbSEZkrjS++ZdZVX01M2hV25lvX3V7jKI4MOVqVLDemmNuJjKZSwltewkmqnvoX3/qeUqZqtzDlT3J8bo1HI68ujsRJ2JAmXuy1KAgnBrpcpbdBKI+jOx6aQ3AD+N0lCVdrbgJj796M+XCASIdQEstp2rbiKve6o0sQvyBHzNjTIqsIkh4oM+b56KTDJGAnwzixoSH95dSSY3elnjaSRMW625e+oUqxM/bPYNFW26nBtYniKNb3NdQjHneD0ujnveLvt9UoNa9lpO2w8hxuSJFLA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784327404; c=relaxed/relaxed;
	bh=L8veAhM8WUPQ0ske+LfeXD/54UrbVMZyutnMsjB9Gf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/RaAauNX6sG7IMyibQomdQqhWRyJavFxq35zuHDfPlvd0WE6vcGNBlUGajeiYsskKaRhNa8vch2+N1+yUQox27Z2uNdVfSejmfI5N6sE3eeS5Lj+3M7usHA+pkDNneISDmUqr7tjtzDdXS7iL9h7mOpZRYVxOtBjeQHOgU8MiO+FrLzJjSpIDdPU3ByVwKHdagCVvaIaPrMFx4AALrSF0Y4MIM4VxEvY+o7xwqGJwV5Ss44LW6X+mKfB793e8H88xhDeBkXOKOFuqExrigT3n5Thb8H7DLkSVNdu8Su+ADVeVh5SJuLXsQlUjWwM0sUlpN1jDrmtjeK+wCgsIMDLQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Cy+3QzRZ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Cy+3QzRZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h24NV6fV9z3c6c
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:30:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGXduOJYHJ3dl/QmvSWZRR4zrft6tv12IH4p3BsS7DSJzfD7Qjv/BKnR0/u3RX1+NRjOrfpy9tLARqrraAh/lqKyZto6uEf2LfOcn//7jPVpxLL3+aLtmXRSGgl/D8cyUWd97Nm5rePjmamDWLkp8iN5bh2FjuznuBzkkBV1UWvhRVj8MJ/SPdPV9oU5tzms5b+vCxkLclgIIqD17Kyx30GWG/Rm6XHRg/HwW6UrqqUBHdt3IVUWkk6qJMQNLmirDeLXh1GFziPc7mXkDQ3JSPntYfY2rCRnj8uTnCfhxduziAEO7Ja40i+pADzxOAngvz61Fj5TjVydjVBVQ+csnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8veAhM8WUPQ0ske+LfeXD/54UrbVMZyutnMsjB9Gf0=;
 b=EkEzLUpCkFQsxrR0uMWfYM7tu7A0VbU5xuUiDbSTiQqzhve657sBGnuP8wy6U2AKLdoNk7Oy9+2qowCr4azDJNgusWwlAf/CmkexbUN1shQeo7ITIajYzUSaHH7ozp5E35B5t/4p5ayXPV7OamlBA/MUZI2dkDfMX9UhG9BW7SZhTPOCIrvOZmazj/Xd6VrNgdtzQZVNY2MNmYuPvi/YMlraRMaqky7gC5CsXWpBo7ucsHKBnaiu74oQA5MHHs7pdFIOMm6nJKqYWDgBN5QOkF9mhujcKrsEX4XDYH7W30cdayHwXthXwmu57KNWUeFRlo+eGkiG0X9AUtbLT++DxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8veAhM8WUPQ0ske+LfeXD/54UrbVMZyutnMsjB9Gf0=;
 b=Cy+3QzRZXlWy1sOSk4BYKAEdZKebZ1EHlv7t3SEnsD6Rlq8LqBWxEWjFHddNaUIuqCtc+6HR9KviJBa9o5F5WsFcSQyEo9RMK2lTJ9ypcqmWdk9Gq/3Tbf3wveow967JzG4N9t/l5/tL5yrFL8EhtSvOOeFZvvv4/9CojmclbEs=
Received: from SJ0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:33a::34)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 22:29:31 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::4a) by SJ0PR03CA0029.outlook.office365.com
 (2603:10b6:a03:33a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 22:29:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:29:31 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:29:29 -0500
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
Subject: [PATCH v18 12/13] PCI/CXL: Mask/Unmask CXL protocol errors
Date: Fri, 17 Jul 2026 17:27:05 -0500
Message-ID: <20260717222706.3540281-13-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7070ef-bbdd-4c26-1fde-08dee452df0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|82310400026|1800799024|10067099003|6133799003|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fIke7sjxCDFeF+d/Zst3o2e1CcI0U1F5A4bAbzONGUwurGlkoLGGiz61QYAbzDuTWjWrWsth8rTi+cWhC9cUCnTqAVdgl6u2tmqsoqThjwkU6l7tf/xEx5N7+uSMO3hSV0W/cM455+pIF9lNQrChRzPMIb/EktQDn67G9g+yT0CThB6OJMDkYid4aWT7MVGFKHGhfXzjPReWHaXDHmqyZzxS41ukVSzFfCHRfhsUQRi+N2/PlbMKwO8EynuP6EIi0eoji6+2s/HM71pLi8G+MiFXTa0xIxXg2TmRxqAoSW07kCVqIP1jYtSk3HQUHJxLe1Wz+4Ziu2QBtvABrDTzW4py7PiidjYcQD7bNelD7I+XCswhRThoAeMjJImx3eM13FPsNdB+IP6Yd26spac/ihp/uLnFb3VHazPnFbgKtzct6yEWfn+Qm7KFudMSbkJD2QFWmyJ88usLfqGDPz3nQ1cmRHDS4zuBDbKM5CNse4oTRtjIlWir58ZEqU0AeYfUTgvSos+EHKTCukrGkJ0TFTxo8BoXbvP11JbyzuoEidI/yYm1zrVlKrd2TeQ0/w7MrzTFHvWyyBZl8x2tfiouWtS7B1h8O8W36wgi6cBriTXci4qZKi8ZDDY1ZqQbB1BGcdJDyKL6BpqyLf80wYbNoPp5cNQI75qr5GMTnE3+navcH9TmQUvbx3Bn9U5GqLKHVAO3vVMA8y4M9LfHuaJMoA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(6133799003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AlC3oxhTxyrnKVxYuxd0GOEKjxYLFBmxTgVmnRRnLKYcuxtvbeFnaA3QlWESpLS2I7v0BfdDgl5KschZvAO3DHO523xgstGLfaBnekKosnJBPMHnNJ/ZFoKxZ4aHIOUQbHtgGTMyd5mCQQq4OD93ZFIroTfAkTZOv4uMA1o7zf7YBrtLDs5msHGmHA6MqWoB5wjftGRY7Ey0MuapJfDEzJMe7am4Rx40sDjOVcptwUwe8NCHL8qb9Uk+xo5p3ALnKcWvRI+wqhUGdTKeRZbYTdkGSumCQoDOyI7zJnaanaZyAT9Y02iRbR5kJ34EI7Lw1A62iwlA3mTJSF6t5RnqpQ4xqTAO9TtqgXhxemoeiy1Pkgou1+jgcfVDPrhoyALK0Id6gzXhMqbD/d1NcWK9r2G9rMzUIr/XvR2yOPv30IHDWQDLffgVLY6JuVfuU+lv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:29:31.2481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7070ef-bbdd-4c26-1fde-08dee452df0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884

CXL protocol errors are not enabled for all CXL devices after boot.
They must be enabled in order to process CXL protocol errors. Provide
matching teardown helpers so the masks are restored when a CXL Port
or dport goes away.

Add pci_aer_mask_internal_errors() as the symmetric counterpart to
pci_aer_unmask_internal_errors() and export both for the cxl_core
module.

Introduce cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts()
in cxl_core to wrap the PCI helpers with the dev_is_pci() and
pcie_aer_is_native() gating CXL needs. Both helpers tolerate a NULL
or non-PCI @dev so callers do not have to special-case it.

Wire cxl_unmask_proto_interrupts() into the success path of
cxl_dport_map_ras() and devm_cxl_port_ras_setup() so the unmask
only runs when the RAS register block was actually mapped. Pair each
unmask with a devm_add_action_or_reset() registration of
cxl_mask_proto_irqs() scoped to the host device so the mask is
restored when devres is released. This applies to dports, Endpoints,
Upstream Switch Ports, Downstream Switch Ports, and Root Ports.

Remove the dev_is_pci(dport->dport_dev) guard in
devm_cxl_dport_rch_ras_setup(). On RCH systems dport->dport_dev is the
pci_host_bridge device, which is not on pci_bus_type, so this guard
caused the function to return early on real hardware without mapping
dport RAS or AER registers. The caller already gates on dport->rch,
which is sufficient to exclude cxl_test mock devices.

Co-developed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v17->v18:
- Make cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts() static
- Remove dev_is_pci() guard from devm_cxl_dport_rch_ras_setup(); the guard
  blocked real RCH hardware because pci_host_bridge is not on pci_bus_type

Changes in v16->v17:
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

Change in v15 -> v16:
- None

Change in v14 -> v15:
- None

Changes in v13->v14:
- Update commit title's prefix (Bjorn)

Changes in v12->v13:
- Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
- Add Dave Jiang's and Ben's review-by

Changes in v11->v12:
- None
---
 drivers/cxl/core/ras.c        | 73 +++++++++++++++++++++++++++++++----
 drivers/pci/pcie/aer.c        | 28 ++++++++++++--
 include/linux/aer.h           |  2 +
 tools/testing/cxl/Kbuild      |  1 +
 tools/testing/cxl/test/mock.c | 12 ++++++
 5 files changed, 105 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 69b320c74469c..d77208af41e03 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -117,16 +117,64 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
+static void cxl_unmask_proto_interrupts(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return;
+
+	pdev = to_pci_dev(dev);
+	if (!pcie_aer_is_native(pdev))
+		return;
+
+	pci_aer_unmask_internal_errors(pdev);
+}
+
+static void cxl_mask_proto_interrupts(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return;
+
+	pdev = to_pci_dev(dev);
+	if (!pcie_aer_is_native(pdev))
+		return;
+
+	pci_aer_mask_internal_errors(pdev);
+}
+
+static void cxl_mask_proto_irqs(void *dev)
+{
+	cxl_mask_proto_interrupts(dev);
+}
+
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
 	struct device *dev = dport->dport_dev;
 
-	if (!map->component_map.ras.valid)
+	if (!map->component_map.ras.valid) {
 		dev_dbg(dev, "RAS registers not found\n");
-	else if (cxl_map_component_regs(map, &dport->regs.component,
-					BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		return;
+	}
+
+	if (cxl_map_component_regs(map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(dev, "Failed to map RAS capability.\n");
+		return;
+	}
+
+	if (!dev_is_pci(dev))
+		return;
+
+	cxl_unmask_proto_interrupts(dev);
+	if (devm_add_action_or_reset(dport_to_host(dport),
+				     cxl_mask_proto_irqs, dev)) {
+		dev_warn(dev, "failed to defer CXL proto-irq mask; CXL protocol error reporting disabled\n");
+		dport->regs.component.ras = NULL;
+	}
 }
 
 /**
@@ -143,9 +191,6 @@ void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
 {
 	struct pci_host_bridge *host_bridge;
 
-	if (!dev_is_pci(dport->dport_dev))
-		return;
-
 	devm_cxl_dport_ras_setup(dport);
 
 	host_bridge = to_pci_host_bridge(dport->dport_dev);
@@ -160,6 +205,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_rch_ras_setup, "CXL");
 void devm_cxl_port_ras_setup(struct cxl_port *port)
 {
 	struct cxl_register_map *map = &port->reg_map;
+	struct device *dev;
 
 	if (!map->component_map.ras.valid) {
 		dev_dbg(&port->dev, "RAS registers not found\n");
@@ -168,8 +214,21 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 
 	map->host = &port->dev;
 	if (cxl_map_component_regs(map, &port->regs,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+		return;
+	}
+
+	dev = is_cxl_endpoint(port) ? port->uport_dev->parent : port->uport_dev;
+	if (!dev_is_pci(dev))
+		return;
+
+	cxl_unmask_proto_interrupts(dev);
+	if (devm_add_action_or_reset(&port->dev, cxl_mask_proto_irqs, dev)) {
+		dev_warn(&port->dev,
+			 "failed to defer CXL proto-irq mask; CXL protocol error reporting disabled\n");
+		port->regs.ras = NULL;
+	}
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 0bd23a65e7ebc..be6dc2cbd4491 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1143,12 +1143,32 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
 
-/*
- * Internal errors are too device-specific to enable generally, however for CXL
- * their behavior is standardized for conveying CXL protocol errors.
+/**
+ * pci_aer_mask_internal_errors - mask internal errors
+ * @dev: pointer to the pci_dev data structure
+ *
+ * Mask internal errors in the Uncorrectable and Correctable Error
+ * Mask registers.
+ *
+ * Note: AER must be enabled and supported by the device which must be
+ * checked in advance, e.g. with pcie_aer_is_native().
  */
-EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
+void pci_aer_mask_internal_errors(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+	u32 mask;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
+	mask |= PCI_ERR_UNC_INTN;
+	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+
+	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
+	mask |= PCI_ERR_COR_INTERNAL;
+	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+}
+EXPORT_SYMBOL_FOR_MODULES(pci_aer_mask_internal_errors, "cxl_core");
 
 /**
  * pci_aer_handle_error - handle logging error into an event log
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 8eba3192e2d15..b3657b80564b9 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -58,6 +58,7 @@ struct aer_capability_regs {
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
+void pci_aer_mask_internal_errors(struct pci_dev *dev);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
@@ -65,6 +66,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
+static inline void pci_aer_mask_internal_errors(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_CXL_RAS
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc93..957945201f04d 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -6,6 +6,7 @@ ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=devm_cxl_add_rch_dport
+ldflags-y += --wrap=devm_cxl_dport_rch_ras_setup
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
 ldflags-y += --wrap=hmat_get_extended_linear_cache_size
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 6454b868b122c..5ad3243da8d29 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -220,6 +220,18 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
 
+void __wrap_devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
+{
+	int index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (!ops || !ops->is_mock_port(dport->dport_dev))
+		devm_cxl_dport_rch_ras_setup(dport);
+
+	put_cxl_mock_ops(index);
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_dport_rch_ras_setup, "CXL");
+
 void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 {
 	int index;
-- 
2.34.1


