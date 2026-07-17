Return-Path: <linuxppc-dev+bounces-24391-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C16EC4451B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:28:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h24Lv62xpz3c2K;
	Sat, 18 Jul 2026 08:28:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784327319;
	cv=pass; b=Oynn8BAJmQUzJD7L5i1zXrNJXPoTXlXBXQejfxeHJ/kdICnDFocxoJZX+6HvD1bVW56e9vp94U2ayRMGsHTAWSmisUkJKkxZ+IXtDucvVZgXfu94NuEywxh+ZPXBtrhp5/VaXrWAuWyEbnUWv/XH3ob7ZjxLCYiPYuk/3G1hMC6XA55vP47yxX4z4OZ0anJlj32TmibLne/wHkA7wD6Iuzb4Y01+zpvPrAhzeM85hJnDhH1KBu0dsucl6CpquAeGCh3m5Lnb6XrVV8vFJ/EQrMRWiKSsuPROcSjvyQz41UIR2HXvGWX/Zn02sa2xC58/09KofpwoS6yaDmqfrCDNRw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784327319; c=relaxed/relaxed;
	bh=0e/WKBvIguDklBUJ4QTahVA4gw6Mtt/HHzw5bsXbD6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCtdpq/v5DBNxg8SUhnvu2JNPPG5A9pKaVkMPk+SpZIE/90VsTmgvToGBbj2S9YjIOLhAOzS4Iuu3Uzd9DP4iqImKpf/1Fipg7MiA9uzJY7dour9w+gnS4+6a3kP6v3gtpXb2FyAJ+XVjY81buJtODxrLzRvafM1O7ih/XJKFi+zqrz26sAh0jKg09RDAuZ9v776SeYqvYMhju6vEC1dS8GKzmI3km9cb9U+0rlnV8KeUMK4/VJLAqvBxuiwC7GDazfG8e+qIoazWVRZDbk39nUVDa9iuYt0+Kaw9j6Lz5dnklhQzrsIpmvZwOIZR+ua4ETvR9xOM2upOyXHeUauVg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VGQPQguA; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VGQPQguA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h24Lt4fRHz2yZf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:28:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6MBQqDXaiHG0ElLnIvwmh1FMKUY+h89attknNnwJlFv8ywz2gmQoZC5QJc7mzhQfNXDmdQukGkxzI+7jwcuJ9Qs+RRGZqRJR95s9Ly9pUQexA/+K9Y2xVFuKKJo9HnvYs1uk5AWetIep2Rv0WFpVg9ueL3XfeGU1fEBv2vLNh551GnoMxTzrPtOpszJTn1/l5JUNwzmAadQAw3zMswQOzKumlzZsJlLxx3YwTUTTET9hy6G33+qna7fCi7yGzlNOeJoAIkOXvBLnY4H4qgJEz8sQ8E5lfrAarQ3q6pQPDVdasn771Pu6297j3JwuOBfSKAOdC5/sAx9u2VHaNg2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e/WKBvIguDklBUJ4QTahVA4gw6Mtt/HHzw5bsXbD6g=;
 b=y6nKjzIwAcK1hNgbIizswqPm4nhYEAyuG2Dq6yD69+wRFxi/NKPAEzHXo7rc2LfiFSn14AhLMpr9Fe9KrBw68z7jYZB/nyOedSVQKN8AWilXfEI0o8p308t6XtWhp1ddR7gSLtgUVzN/+T2N7UgEwyZPCFVqUpSpIPLnyAb8eHLm9jCK7ZlGTjjCeediQQv0agVCc1+/EwohUgCWd0WVZc5lHOAOhbszdd/EnJkYFTNSm0MrrxcwNTb/mylTqVazUu4ktjilPLygFyLtC2UVMww0OkPK3cedpDzqr67B9iy6oLUYeoA76tsVKm0vX1RdC2j+uiwmS5E5b09UJOw+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e/WKBvIguDklBUJ4QTahVA4gw6Mtt/HHzw5bsXbD6g=;
 b=VGQPQguAwF1uFK6x0hDixczMCulNpvgttIb/OE0AnZrqistIb9nd8RadhA+jQlax0ZSr3s5N7GaURzkTrnjfi38qLHBQZLe9hnnZzKxTEykVwqJ5XB7BIcRtYCwBzugN7X4Sedsp/fFQ8l7sijUDEkOIqJO4lCMUpL7LhWFeYHQ=
Received: from MW4PR03CA0224.namprd03.prod.outlook.com (2603:10b6:303:b9::19)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 22:28:10 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::7d) by MW4PR03CA0224.outlook.office365.com
 (2603:10b6:303:b9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 22:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:28:10 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:28:09 -0500
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
Subject: [PATCH v18 05/13] PCI/AER: Introduce AER-CXL protocol error kfifo
Date: Fri, 17 Jul 2026 17:26:58 -0500
Message-ID: <20260717222706.3540281-6-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: c05c2af9-9fe3-483c-650f-08dee452aec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|23010399003|376014|22082099003|18002099003|10067099003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	jXT55tLVbCZRfWEVwP5UB0CSzqLULPXja18jJehaesAcLkql6r7+pm6ZBOca9GG0/3HNgZbSotz9JcjQMhz+k6NMb5DpqcNVzmA0jbC79/5MmycZTrGH8gtQSbWu7Y5KrJhqrB4ZtNyBpSORSQeM3icqR/ey9Xu6v15lEUW8EvdFWdpwiY7PnhZJjH5fRwI2wltT6q3VuxGN5Hme6VsT6KPXVM7rfO8V95pg3fY7VS6AX5Z/ZE2jp/+jmADYIJ2gfcH3CaRUKKDFePbKD3S77soCWgwPiuC0DMZRBv9pJRd12lOCiV/kcRgHyHK7B+e+Zpf38gnWsL1w8iv7J4rNtQUymiqpZX1zPdZFy6+w/j9FDxhkSgGL8jUv51u2SialMVkC+BtuhMSeaHqIAdvhuQuFDSf48QKEPGmpVeLg3Sd9TIHmmIzrzxdhlyjq6SnVsXH+EEjVshnkbc0QDEe346F6ffs/mvHqy/R5pPwYJn2GLR0goMCysIk2mv2QDBG7yCdXootnL7kI1vQxj5p8Hiu7N2i0p41gn33zgIKRcjYP8hm52N3d6F1SMRv2lNThoPBZMSNGSEk9zXc/RM+BDq8Kph39PfVj5bMjhNQYOIb0AFN/eViGm1HfjvyJMl0JoV8PRNX8Asbu4wW7fjKnZ/6PYJnoPJZzdr4Ec1sta+aiPrAeG2pIh6IDYDw6e+Y3TOZz1JyGqUutDqfPYQ1DXQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fydtEwRMTE1AXq3aHJD3Q77KEYf29n0rnHFiFOUPV4c4HePHEtF89lTc06uMZbkFRqS1mbx3xD78YoW/mQjaC5R8ogEp4TQQh+vC2oLMHXu/LDs8ofGYGfjNABJgllUFU/7tEDCOem00w9U4owBQDgDiW6RPc8Yd5J1IcZeKbxZ55NEXK5zpZThRdDjkjQUGpCQp36DaGH6/vvo2RIs15PM40GQmLITRYmMZIX146SbElEACOtml4g+erw6JyleiYqMXJ2THc/uQ9pslbCQ315f3Amm0aUiONKejRmgC2t6+rK9y70+8uyM9vgNrON8BE0wRf/T7kYv/kizNj7lhd0pP/mfs2OZ3pp+5rjs53YYN7VGpdlBmTbNioyI5vq1k8bx+TDW5sFUeAtdDfCK2iiAHvVQlFJ85OHX7k2djd6rIiAGq+vhAEW+LzVsfdIpY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:28:10.2730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c05c2af9-9fe3-483c-650f-08dee452aec4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439

CXL VH RAS handling requires a path for the AER driver to hand off
CXL protocol errors to cxl_core for logging and recovery before PCIe
AER recovery tears down the device. Add
drivers/pci/pcie/aer_cxl_vh.c to implement this handoff via a kfifo-backed
work item.

Introduce is_aer_internal_error() to identify CXL protocol errors
from AER internal error status bits across both correctable and
uncorrectable severities.

Introduce is_cxl_error() to gate the VH kfifo path.

Introduce struct cxl_proto_err_work_data to carry the error source
PCI device and severity through the kfifo. Encapsulate the kfifo,
per-producer spinlock, registration rwsem, and work pointer in struct
cxl_proto_err_kfifo. Initialize the embedded kfifo via INIT_KFIFO()
from a subsys_initcall so its metadata is populated before any
producer or consumer runs.

Introduce cxl_forward_error() to enqueue a CXL protocol error. A
reference is taken on the PCI device; the consumer releases it via
for_each_cxl_proto_err(). On enqueue failure the reference is
released immediately, the error is dropped, and the consumer is
scheduled to drain existing entries. A subsequent patch wires
cxl_forward_error() into handle_error_source() where correctable and
uncorrectable status clearing is left to pci_aer_handle_error().

Introduce cxl_proto_err_flush() to synchronously wait for the
consumer worker to drain the kfifo. A subsequent patch wires this
into handle_error_source() for UCE events so the CXL plane completes
error handling and panic policy before pci_aer_handle_error() drives
PCIe recovery.

Introduce cxl_register_proto_err_work() and
cxl_unregister_proto_err_work() for cxl_core to register and
deregister its work handler. On unregistration, pending kfifo entries
are drained and their pdev references released before
cancel_work_sync() runs. Export these and for_each_cxl_proto_err()
via EXPORT_SYMBOL_FOR_MODULES restricted to cxl_core.

Protect the work pointer with a rwsem to correctly serialize
registration, deregistration, enqueue, and dequeue against concurrent
AER IRQ threads. Serialize concurrent kfifo writers with a spinlock.

Add MAINTAINERS entries for aer_cxl_vh.c and aer_cxl_rch.c under
the CXL entry so CXL maintainers are CC'd on changes to the AER-CXL
bridging code.

Co-developed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v17->v18:
- Remove correctable status clear from cxl_forward_error(); the AER core
  clears all status bits via pci_aer_handle_error() info->status writeback
- Schedule consumer on kfifo overflow so existing entries can be drained

Changes in v16->v17:
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
- Clear PCI_ERR_COR_STATUS in cxl_forward_error() after enqueue so the
  device is acked for correctable events even when the consumer drops the
  event. Uncorrectable status is left for cxl_do_recovery() to clear after
  recovery completes, mirroring the AER core convention.
- WARN on double-registration in cxl_register_proto_err_work() to make an
  unintended second consumer visible at runtime.
- Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
  in aer_cxl_vh.c
- Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
- Update message
---
 MAINTAINERS                   |   2 +
 drivers/pci/pcie/Makefile     |   1 +
 drivers/pci/pcie/aer.c        |  10 --
 drivers/pci/pcie/aer_cxl_vh.c | 221 ++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h    |   6 +
 include/linux/aer.h           |  24 ++++
 6 files changed, 254 insertions(+), 10 deletions(-)
 create mode 100644 drivers/pci/pcie/aer_cxl_vh.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 806bd2d80d153..39007aa90b20f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6526,6 +6526,8 @@ S:	Maintained
 F:	Documentation/driver-api/cxl
 F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
 F:	drivers/cxl/
+F:	drivers/pci/pcie/aer_cxl_rch.c
+F:	drivers/pci/pcie/aer_cxl_vh.c
 F:	include/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index b0b43a18c304b..62d3d3c69a5df 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
 obj-y				+= aspm.o
 obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
 obj-$(CONFIG_CXL_RAS)		+= aer_cxl_rch.o
+obj-$(CONFIG_CXL_RAS)		+= aer_cxl_vh.o
 obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
 obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c4fd9c0b2a548..c5bce25df51cb 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1150,16 +1150,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
  */
 EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
 
-#ifdef CONFIG_CXL_RAS
-bool is_aer_internal_error(struct aer_err_info *info)
-{
-	if (info->severity == AER_CORRECTABLE)
-		return info->status & PCI_ERR_COR_INTERNAL;
-
-	return info->status & PCI_ERR_UNC_INTN;
-}
-#endif
-
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
new file mode 100644
index 0000000000000..93bed07936100
--- /dev/null
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2026 AMD Corporation. All rights reserved. */
+
+#include <linux/aer.h>
+#include <linux/atomic.h>
+#include <linux/cleanup.h>
+#include <linux/init.h>
+#include <linux/kfifo.h>
+#include <linux/rwsem.h>
+#include <linux/wait_bit.h>
+#include <linux/workqueue.h>
+#include "../pci.h"
+#include "portdrv.h"
+
+#define CXL_ERROR_SOURCES_MAX          128
+
+struct cxl_proto_err_kfifo {
+	struct work_struct *work;
+	void (*flush)(void);
+	struct rw_semaphore rwsem;
+	spinlock_t fifo_lock;
+	atomic_t flush_inflight;
+	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
+		      CXL_ERROR_SOURCES_MAX);
+};
+
+static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
+	.rwsem = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rwsem),
+	.fifo_lock = __SPIN_LOCK_UNLOCKED(cxl_proto_err_kfifo.fifo_lock),
+};
+
+static int __init cxl_proto_err_kfifo_init(void)
+{
+	INIT_KFIFO(cxl_proto_err_kfifo.fifo);
+	return 0;
+}
+subsys_initcall(cxl_proto_err_kfifo_init);
+
+bool is_aer_internal_error(struct aer_err_info *info)
+{
+	if (info->severity == AER_CORRECTABLE)
+		return info->status & PCI_ERR_COR_INTERNAL;
+
+	return info->status & PCI_ERR_UNC_INTN;
+}
+
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	if (!info || !info->is_cxl)
+		return false;
+
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+		return false;
+
+	return is_aer_internal_error(info);
+}
+
+/**
+ * cxl_forward_error - Forward a CXL protocol error to the CXL subsystem via kfifo
+ * @pdev: PCI device that reported the AER error
+ * @info: AER error info containing severity and status
+ *
+ * Producer side of the AER-CXL kfifo. Enqueues a CXL protocol error work
+ * item and schedules the consumer workqueue. Takes a reference on @pdev
+ * that the consumer releases after handling.
+ *
+ * Return: true if the caller must flush the kfifo before AER recovery,
+ * false if no CXL error handling was initiated due to early return on
+ * error.
+ */
+bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
+{
+	struct cxl_proto_err_work_data wd = {
+		.severity = info->severity,
+		.pdev = pdev,
+	};
+
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
+
+	if (!cxl_proto_err_kfifo.work) {
+		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo reader not registered\n");
+		return false;
+	}
+
+	/*
+	 * Reference discipline: the AER caller (handle_error_source())
+	 * holds a ref on @pdev for the duration of this call and releases
+	 * it on return. Take a fresh ref here so the pdev stays live while
+	 * queued in the kfifo; the consumer (for_each_cxl_proto_err())
+	 * drops that ref after handling. On enqueue failure below, drop
+	 * the ref we just took to avoid a leak.
+	 */
+	pci_dev_get(pdev);
+
+	/* Serialize concurrent kfifo writers: multiple AER threaded IRQs */
+	if (!kfifo_in_spinlocked(&cxl_proto_err_kfifo.fifo, &wd, 1,
+				 &cxl_proto_err_kfifo.fifo_lock)) {
+		/* Dropped; no panic - UCE unconfirmed without RAS read */
+		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo add failed\n");
+		pci_dev_put(pdev);
+		schedule_work(cxl_proto_err_kfifo.work);
+		return true;
+	}
+
+	schedule_work(cxl_proto_err_kfifo.work);
+	return true;
+}
+
+void cxl_register_proto_err_work(struct work_struct *work,
+				void (*flush)(void))
+{
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
+
+	/*
+	 * Warn on double-registration to surface driver bugs (e.g. missing
+	 * cxl_unregister_proto_err_work() on module exit)
+	 */
+	if (WARN(cxl_proto_err_kfifo.work,
+		 "AER-CXL kfifo consumer already registered\n"))
+		return;
+	cxl_proto_err_kfifo.work = work;
+	cxl_proto_err_kfifo.flush = flush;
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_register_proto_err_work, "cxl_core");
+
+static struct work_struct *cancel_cxl_proto_err(void)
+{
+	struct work_struct *work;
+	struct cxl_proto_err_work_data wd;
+
+	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
+	work = cxl_proto_err_kfifo.work;
+	cxl_proto_err_kfifo.work = NULL;
+	cxl_proto_err_kfifo.flush = NULL;
+
+	/* rwsem_write excludes all producers; fifo_lock not needed */
+	while (kfifo_get(&cxl_proto_err_kfifo.fifo, &wd)) {
+		dev_err_ratelimited(&wd.pdev->dev,
+				    "AER-CXL error report canceled\n");
+		pci_dev_put(wd.pdev);
+	}
+	return work;
+}
+
+void cxl_unregister_proto_err_work(void)
+{
+	struct work_struct *work;
+
+	lockdep_assert_not_held(&cxl_proto_err_kfifo.rwsem);
+
+	work = cancel_cxl_proto_err();
+
+	/* Wait for any in-flight cxl_proto_err_flush() calls to complete */
+	wait_var_event(&cxl_proto_err_kfifo.flush_inflight,
+		       atomic_read(&cxl_proto_err_kfifo.flush_inflight) == 0);
+
+	if (work)
+		cancel_work_sync(work);
+}
+EXPORT_SYMBOL_FOR_MODULES(cxl_unregister_proto_err_work, "cxl_core");
+
+/**
+ * for_each_cxl_proto_err - Call a function for each kfifo work item
+ *
+ * Single-consumer invariant: this function is only called from
+ * cxl_proto_err_work_fn() via a single DECLARE_WORK.
+ *
+ * Holds rwsem_read internally; fn() must not call cxl_register_proto_err_work()
+ * or cxl_unregister_proto_err_work().
+ */
+void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
+			    cxl_proto_err_fn_t fn)
+{
+	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
+	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
+		fn(wd);
+		pci_dev_put(wd->pdev);
+	}
+}
+EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");
+
+/**
+ * cxl_proto_err_flush - drain pending AER-CXL kfifo work synchronously
+ *
+ * Wait for the consumer worker to finish processing all entries
+ * currently in the kfifo. Used by handle_error_source() for UCE so
+ * the CXL plane can read CXL RAS, apply panic policy, and clear CXL
+ * state before pci_aer_handle_error() drives PCIe recovery.
+ *
+ * Snapshots the flush callback under rwsem_read and releases the rwsem
+ * before calling it.  This avoids holding rwsem_read across flush_work(),
+ * which would deadlock via the rwsem HANDOFF mechanism when a concurrent
+ * rwsem_write waiter (cxl_unregister_proto_err_work) blocks new readers
+ * including the worker's for_each_cxl_proto_err() rwsem_read acquisition.
+ *
+ * The flush_inflight counter prevents cxl_core module unload while a
+ * flush is in progress outside the rwsem. The counter is incremented
+ * under rwsem_read (mutually exclusive with the rwsem_write in
+ * cancel_cxl_proto_err() that NULLs the flush pointer) and decremented
+ * after the flush completes. cxl_unregister_proto_err_work() waits for
+ * the counter to reach zero before proceeding with cancel_work_sync().
+ *
+ * For correctable events the consumer can run asynchronously; AER
+ * does not need to call this helper for AER_CORRECTABLE.
+ */
+void cxl_proto_err_flush(void)
+{
+	void (*flush)(void);
+
+	scoped_guard(rwsem_read, &cxl_proto_err_kfifo.rwsem) {
+		flush = cxl_proto_err_kfifo.flush;
+		if (flush)
+			atomic_inc(&cxl_proto_err_kfifo.flush_inflight);
+	}
+
+	if (flush) {
+		flush();
+		if (atomic_dec_and_test(&cxl_proto_err_kfifo.flush_inflight))
+			wake_up_var(&cxl_proto_err_kfifo.flush_inflight);
+	}
+}
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index cc58bf2f2c844..fd203010877bf 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -130,9 +130,15 @@ struct aer_err_info;
 bool is_aer_internal_error(struct aer_err_info *info);
 void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
 void cxl_rch_enable_rcec(struct pci_dev *rcec);
+bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
+bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
+void cxl_proto_err_flush(void);
 #else
 static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
 static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
 static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
+static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
+static inline bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
+static inline void cxl_proto_err_flush(void) { }
 #endif /* CONFIG_CXL_RAS */
 #endif /* _PORTDRV_H_ */
diff --git a/include/linux/aer.h b/include/linux/aer.h
index df0f5c382286f..8eba3192e2d15 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -25,6 +25,7 @@
 #define PCIE_STD_MAX_TLP_HEADERLOG	(PCIE_STD_NUM_TLP_HEADERLOG + 10)
 
 struct pci_dev;
+struct work_struct;
 
 struct pcie_tlp_log {
 	union {
@@ -66,6 +67,29 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
 
+#ifdef CONFIG_CXL_RAS
+/**
+ * struct cxl_proto_err_work_data - Error information used in CXL error handling
+ * @pdev: PCI device detecting the error
+ * @severity: AER severity
+ */
+struct cxl_proto_err_work_data {
+	struct pci_dev *pdev;
+	int severity;
+};
+
+/**
+ * Callback for processing a CXL protocol error from the AER-CXL kfifo.
+ */
+typedef void (*cxl_proto_err_fn_t)(struct cxl_proto_err_work_data *wd);
+
+void cxl_register_proto_err_work(struct work_struct *work,
+				void (*flush)(void));
+void for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
+			    cxl_proto_err_fn_t fn);
+void cxl_unregister_proto_err_work(void);
+#endif
+
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
 int cper_severity_to_aer(int cper_severity);
-- 
2.34.1


