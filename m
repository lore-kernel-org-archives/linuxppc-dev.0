Return-Path: <linuxppc-dev+bounces-24396-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C778C44516
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 22:29:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h24Mz0cKlz3cQ7;
	Sat, 18 Jul 2026 08:29:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784327375;
	cv=pass; b=T4aUXvNZ9LKYrIoJvWgfXstclyxeuKAJi7cvTGpXw9Z/tot7s6MIsgz3cVDkncTy1x5iNXBxRfmmxFwN23XFi24T/731eSepb3EljMv46rXJOQ5vB8zDmByr5V1ccOJ/JAL9+OONQ5daTjvGp8wsYhIQdK6Y6lFhqeuNK35y5YRrXkaaNTAVHYmKSwKNTJZO/D/D8YgUaShJOoYJ5BNgiIw76mEmXQzdfO4vz3jl0S1674ZhZedL5IH+FBlm56K3JeigFpeT9kUXjBsurMT4K0VuaeD2hk7WrXyxm4lMwnlUi2G/KRZ5c/qXPh01WIn832Izs7RB0vWKeGJZjqvNlw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784327375; c=relaxed/relaxed;
	bh=Ft4rNT2Li6KM1hxA/DTs8OS5XQFDsxMDV+Yj9lIsIWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAmRYnENvzeVGqs8qqVuAN5CDCWyg921N2OmsKUAPBfP+bOqZka9GQu6qcE15jjuCcQkimdTgegJxsshvdp5uKAV1KeUHcCnpHKaZfCz4/Eot2WrCVzjoy5gmE3W9WO54tE95NgDuUbVgUJKMohtU1suoJHAk+uP3kzjqQCj77eFtv1Mn03Cmut860iDdMwYILPBJrzoucpcgnz7778QIK+6Im/+ZOrQRLfY+dpZM4+GAGWbqBkQZWG6tjfbRTYXehSOQERCmqSgEV39zJXqfeW+4dg6so5s/lXyfEnOzUqfVIaO5kQclB9kb//O0w5SzKcrhQJL3byLpNUrHXjxrw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p206AvlG; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p206AvlG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c107::3; helo=ph0pr06cu001.outbound.protection.outlook.com; envelope-from=terry.bowman@amd.com; receiver=lists.ozlabs.org)
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h24Mx5QP6z3c6c
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jul 2026 08:29:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmtlZMjSUiGC50VcpSjvR65+ylOfBaxPndTitMWUSPhP9Wr14aJZQUVT75UlRhS9i39ebrHxGKepuX2/tp/hZ3xhZAzVNNQ93MpPqEZtezUqgnduznARwiR0jREDAWgZE2IJBJJl0W4Z+nxvQvJDdksUzyjblZ5vBEB5+B+wJiGvsTr/OiMVK+lMMenUEy2Awd8LGr9tO7s2/lIfFv0mV0rzrlUNVYrvq+2tdCq832SNwV4RtAcK7CzQlfGapNpQocav8p+Py/uSxpgeHauenMeqzj37JT6M5uhGOJgxdJQotH3xA+U4wSzQQv8Wr/H6nmG3CiRVjabCyyQ6nuKyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ft4rNT2Li6KM1hxA/DTs8OS5XQFDsxMDV+Yj9lIsIWw=;
 b=ZbiEvh9v9KGLXU2uYwT2q7aSMvwGPz8pVAtuUW5C0478y+8/47RxCx0ufuGMtPIq+1gilZmq2k5f22BrrJ8NRltv0ubo724XDlZ357HLS1swHuCLHC5Gy4HquuxO9pQgpoyYdLOoT6+4EhkeO2Dr/RWExc1eMQCSay7HP+gGZ2iIZaiJ4bgVVObBqFPQ7b+xInw6rKO9v9VK84GzDVcXS9bwj2JQ/Vse4wukCjYGNwEP3hPmCfrBFD0iRMK1Ckt6OXuVpbHlzkcG43CcytOMOzm+C02mFw0f50lP3fC4xLCUFLqNZoW5K2hdP8wSOFgsrnpvCD1AwMWPRys7wWZpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ft4rNT2Li6KM1hxA/DTs8OS5XQFDsxMDV+Yj9lIsIWw=;
 b=p206AvlG3Ev22rnUcl9jBBq5tbRWPTfq7uoYzFHcZwJFgNQfWdjO3s6aT3+T28/+NS2f8avzQh2Wv5ssfmKvZxrWMpS8l0/4CG8HvEKZKNT9FsOSoJZ6OYcGdV7DVAR+J1Il2T8mSJNJFNu7G4yBwVDyXqNqAonecQ24BNbCIxY=
Received: from BY3PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:217::27)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 22:29:08 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::32) by BY3PR04CA0022.outlook.office365.com
 (2603:10b6:a03:217::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 22:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:29:07 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:29:06 -0500
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
Subject: [PATCH v18 10/13] cxl: Add port and dport identifiers to CXL AER trace events
Date: Fri, 17 Jul 2026 17:27:03 -0500
Message-ID: <20260717222706.3540281-11-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 9079148f-4c55-4282-cd61-08dee452d12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|23010399003|56012099006|11063799006|6133799003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Wa+i7nrqUzuVdFUBcGaJhr5/vIloll/e/6D+dMNIJ7e/kRowQ/x9kG3WcYw9ykSk4tUo/y4eK+nFhusYAvYejrp1hg8ivw+2pQi2eWqzBogQlUYMCVosriknbkLAZVnheV1CTBz9sLDzXvD7WVURveq8Rw0uwu9ryVNhcoPUove1sZi3jtQh/57hII73gtU0RRue3fZSRju0RCE/nSLiok4Z0mrwHkFOiGbhPrPrtQvA8PVoGweT6bVAhhwiawJ4//Rc1sG3OfIyIhmTzTCU01hwR4i+njet/8qynUihHGsdkHGH97P8GXaQ9F6fHALn6vA30AM+2bS/I+sNBDw/xtan0dfjMTD6yAS1OYmGgqb2gJ6ycemjfKaWhFwK+I5IdVpEC9HChXjs3t9PK/ekw8l32sQicSbBzsa5mgBXZbv9SIHVjhzcIdEFUvcYyQVLOqfb2mP01OdM1wGMPuSTwwI6dOzhIp1L2B/spiYZ6RjQNnIHDHWxvav62iNzEzjs2LKpKhD6RbyBEfsuEZ4Md04r9ImpL0pI3E44UhA1itNPWv2kUNvUMHivZ9PTlHgw8xCnOeyFsGAlm7s9B2a7oLYPGUH3MgR+XEn9Jz9nPIOtHdV6d0LVBAm6miTCCzlq5tJ1FTyp6vcfLFuM5e7FgFi6y+aNcrjBHsqVweITTlgmOUs/LbtMrV/vJ9OPtqfAzfOWjSV/BeMjHsnvsVubEQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Zgu31DNiGUn/MFPB5GVxx+V9mRrVDuS9VZoXN5GrjuD9vNAE9jvrQho+x83tMOt3eCNIlBj69OlD0J8js//IYdUtz8qeo7zR51C+44YkAzZEDaH541Rb16jUn2uZgkwtOspdvQHztb905f7p2JsRysdVCfc/AaG5ksysuq7wBxYwc+/9q8z1rxbByF7oMbEDX69l3vdO6yHksDEGMkJ3kqc8dMMiJkRjUV3Eqn4PMdd7eBeyh/RB8vE2ogWsUJf6N52cWWlu+/Q4MlQj+gXNF/uAs7FXDuk08lyaD6ag6aTbtRnniYhtcgK8lYrdl3fwpAO6xiK5wJwB5TlE1mhgpzfj9s9V2mu8fcLc/tWkbECVZr1q2dEH/agT6RYHIxrKqyfTcnlhX/cN2rWZGLWMHfzKFQd2e1YywaK9LpNe5aD7DcIswR1A0iw0T/QnrAmo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:29:07.9939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9079148f-4c55-4282-cd61-08dee452d12b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478

From: Dan Williams <djbw@kernel.org>

Pass struct cxl_port * and struct cxl_dport * to the cxl_aer_*
trace events instead of a plain struct device * derived at the
caller. The trace event helpers then derive the right strings for
endpoints, switch ports, root ports, and RCH downstream ports
consistently across the CPER and native AER paths.

The unified cxl_aer_* events keep "memdev" as the legacy field
(endpoint events populate it with the memdev name; non-endpoint
events emit memdev="") and add new "port" and "dport" string fields
populated for all CXL device classes. Updated userspace can key
off "port" and "dport" without a parallel set of events.

Remove the separate cxl_port_aer_uncorrectable_error and
cxl_port_aer_correctable_error trace events. All CXL AER events now
use the unified cxl_aer_* events with port and dport fields.

Rework cxl_cper_handle_prot_err() to use find_cxl_port_by_dev() and
the unified trace helpers, replacing the per-port-type branching and
bus_find_device() memdev lookup.

The TP_printk format string places "port=%s dport=%s" between
"memdev=%s" and "host=%s", changing the text-mode field order from
the pre-patch output. This does not affect consumers such as
rasdaemon that use libtraceevent to parse fields by name rather than
by fixed text position.

For non-endpoint events (switch port, root port, RCH dport),
"memdev" is empty and "port"/"dport" carry the topology information.

The serial number is retrieved via pci_get_dsn() which performs live
PCI configuration space reads. A following patch ("PCI: Cache PCI
DSN into pci_dev->dsn during probe") replaces these with a cached
serial number to avoid config space access in error handlers and panic
paths.

Below are examples of the different CXL devices' error trace logs
after this patch:

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

Root Port:
cxl_aer_correctable_error: memdev= port=port1 dport=0000:0c:00.0 \
   host=pci0000:0c serial=0: status: 'Memory Data ECC Error'

cxl_aer_uncorrectable_error: memdev= port=port1 dport=0000:0c:00.0 \
   host=pci0000:0c serial=0: status: 'Cache Address Parity Error'  \
   first_error: 'Cache Address Parity Error'

Upstream Switch Port:
cxl_aer_correctable_error: memdev= port=port2 dport= host=0000:0d:00.0 \
   serial=0: status: 'Memory Data ECC Error'

UCE NA - Upstream Switch Port UCE's are handled in the portdrv driver's
PCI AER callbacks that are not CXL aware.

Downstream Switch Port:
cxl_aer_correctable_error: memdev= port=port2 dport=0000:0e:00.0 \
   host=0000:0d:00.0 serial=0: status: 'Memory Data ECC Error'

cxl_aer_uncorrectable_error: memdev= port=port2 dport=0000:0e:00.0 \
   host=0000:0d:00.0 serial=0: status: 'Cache Address Parity Error' \
   first_error: 'Cache Address Parity Error'

Endpoint:
cxl_aer_uncorrectable_error: memdev=mem1 port=endpoint4 dport= \
   host=0000:0f:00.0 serial=0: status: 'Cache Address Parity Error' \
   first_error: 'Cache Address Parity Error'

cxl_aer_correctable_error: memdev=mem1 port=endpoint4 dport= host=0000:0f:00.0 \
   serial=0: status: 'Memory Data ECC Error'

Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Dan Williams <djbw@kernel.org>

---
Changes in v17->v18:
- Consolidate double find_cxl_port_by_dev() in cxl_cper_handle_prot_err()
- Add comment noting dport is NULL for Endpoint and Upstream Port devices
- Add cxl_trace_* helpers
- Add CPER refactor

Changes in v16->v17:
- Replace cxlds->serial with pci_get_dsn()
- Change 'memdev' to 'device' (Dan)
- Updated Commit message

Changes in v15->v16:
- Add Dan's review-by
- Incorporate Dan's comment into commit message:
"Add the serial number at the end to preserve compatibility with
libtraceevent parsing of the parameters."

Changes in v14->v15:
- Update commit message.
- Moved cxl_handle_ras/cxl_handle_cor_ras() changes to future patch (terry)

Changes in v13->v14:
- Update commit headline (Bjorn)

Changes in v12->v13:
- Added Dave Jiang's review-by

Changes in v11 -> v12:
- Correct parameters to call trace_cxl_aer_correctable_error()
- Add reviewed-by for Jonathan and Shiju

Changes in v10->v11:
- Updated CE and UCE trace routines to maintain consistent TP_Struct ABI
and unchanged TP_printk() logging.
---
 drivers/cxl/core/core.h    |   8 +--
 drivers/cxl/core/ras.c     | 131 +++++++++++--------------------------
 drivers/cxl/core/ras_rch.c |   3 +-
 drivers/cxl/core/trace.c   |  35 ++++++++++
 drivers/cxl/core/trace.h   |  91 ++++++++------------------
 drivers/cxl/cxlmem.h       |   7 ++
 6 files changed, 113 insertions(+), 162 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 5ca1275fd8f35..a55a4e409feda 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -186,11 +186,11 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
 void cxl_ras_init(void);
 void cxl_ras_exit(void);
 bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
-		    void __iomem *ras_base);
+		    void __iomem *ras_base, u64 serial);
 void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
 		     struct cxl_dport *dport);
 void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
-			void __iomem *ras_base);
+			void __iomem *ras_base, u64 serial);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct pci_dev *pdev);
@@ -200,14 +200,14 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
 static inline void cxl_ras_init(void) { }
 static inline void cxl_ras_exit(void) { }
 static inline bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
-				  void __iomem *ras_base)
+				  void __iomem *ras_base, u64 serial)
 {
 	return false;
 }
 static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport) { }
 static inline void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
-				      void __iomem *ras_base) { }
+				      void __iomem *ras_base, u64 serial) { }
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index d5dc2c22565da..acf40b2396c3b 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -12,69 +12,37 @@
 static_assert(CXL_HEADERLOG_TRACE_SIZE_U32 == 128,
 	      "rasdaemon ABI requires exactly 128 u32s");
 
-static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
-					      struct cxl_ras_capability_regs ras_cap)
-{
-	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
-
-	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
-}
-
-static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
-						struct cxl_ras_capability_regs ras_cap)
+static void cxl_cper_trace_uncorr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
+					   u64 serial, struct cxl_ras_capability_regs *ras_cap)
 {
 	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
-	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
+	u32 status = ras_cap->uncor_status & ~ras_cap->uncor_mask;
 	u32 fe;
 
 	if (hweight32(status) > 1)
 		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
-				   ras_cap.cap_control));
-	else
-		fe = status;
-
-	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
-	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe, hl);
-}
-
-static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
-					 struct cxl_ras_capability_regs ras_cap)
-{
-	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
-
-	trace_cxl_aer_correctable_error(cxlmd, status);
-}
-
-static void
-cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
-			       struct cxl_ras_capability_regs ras_cap)
-{
-	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
-	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
-	u32 fe;
-
-	if (hweight32(status) > 1)
-		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
-				   ras_cap.cap_control));
+				   ras_cap->cap_control));
 	else
 		fe = status;
 
 	/*
-	 * ras_cap.header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
+	 * ras_cap->header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
 	 * dwords.  Copy them into the front of a zero-filled
 	 * CXL_HEADERLOG_TRACE_SIZE_U32 (128) u32 staging buffer so the trace
 	 * event memcpy sees a full 512-byte source and the userspace ABI
 	 * (rasdaemon) is preserved.
 	 */
-	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
-	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
+	memcpy(hl, ras_cap->header_log, CXL_HEADERLOG_SIZE);
+	trace_cxl_aer_uncorrectable_error(port, dport, status, fe,
+					  hl, serial);
 }
 
-static int match_memdev_by_parent(struct device *dev, const void *uport)
+static void cxl_cper_trace_corr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
+					 u64 serial, struct cxl_ras_capability_regs *ras_cap)
 {
-	if (is_cxl_memdev(dev) && dev->parent == uport)
-		return 1;
-	return 0;
+	u32 status = ras_cap->cor_status & ~ras_cap->cor_mask;
+
+	trace_cxl_aer_correctable_error(port, dport, status, serial);
 }
 
 
@@ -109,47 +77,34 @@ static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dpor
 
 void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 {
+	struct cxl_dport *dport;
 	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
 				       data->prot_err.agent_addr.function);
-	struct pci_dev *pdev __free(pci_dev_put) =
-		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
-					    data->prot_err.agent_addr.bus,
-					    devfn);
-	struct cxl_memdev *cxlmd;
-	int port_type;
-
-	if (!pdev)
-		return;
-
-	port_type = pci_pcie_type(pdev);
-	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
-	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
-	    port_type == PCI_EXP_TYPE_UPSTREAM) {
-		if (data->severity == AER_CORRECTABLE)
-			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
-		else
-			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
-
+	struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
+		data->prot_err.agent_addr.segment, data->prot_err.agent_addr.bus, devfn);
+	if (!pdev) {
+		pr_err_ratelimited("Failed to find CPER device in CXL topology\n");
 		return;
 	}
 
-	guard(device)(&pdev->dev);
-	if (!pdev->dev.driver) {
-		dev_warn_ratelimited(&pdev->dev,
-				     "Device is unbound, abort CPER error handling\n");
+	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&pdev->dev, NULL);
+	if (!port) {
+		dev_err_ratelimited(&pdev->dev,
+				    "Failed to find parent port device in CXL topology\n");
 		return;
 	}
 
-	struct device *mem_dev __free(put_device) = bus_find_device(
-		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
-	if (!mem_dev)
-		return;
+	guard(device)(&port->dev);
+
+	/* dport is NULL for Endpoint and Upstream Port devices */
+	dport = cxl_find_dport_by_dev(port, &pdev->dev);
 
-	cxlmd = to_cxl_memdev(mem_dev);
 	if (data->severity == AER_CORRECTABLE)
-		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
+		cxl_cper_trace_corr_prot_err(port, dport, pci_get_dsn(pdev),
+					     &data->ras_cap);
 	else
-		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
+		cxl_cper_trace_uncorr_prot_err(port, dport, pci_get_dsn(pdev),
+					       &data->ras_cap);
 }
 EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
 
@@ -240,14 +195,14 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dpo
 		return;
 	}
 
-	if (cxl_handle_ras(port, dport, ras_base))
+	if (cxl_handle_ras(port, dport, ras_base, pci_get_dsn(pdev)))
 		panic("CXL cachemem error");
 
 	dev_dbg(&pdev->dev,
 		"CXL UCE signaled but no CXL RAS status bits set\n");
 }
 
-void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
+void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base, u64 serial)
 {
 	u32 status;
 	void __iomem *addr;
@@ -259,12 +214,7 @@ void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __i
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		if (is_cxl_endpoint(port))
-			trace_cxl_aer_correctable_error(to_cxl_memdev(port->uport_dev), status);
-		else if (dport)
-			trace_cxl_port_aer_correctable_error(dport->dport_dev, status);
-		else
-			trace_cxl_port_aer_correctable_error(port->uport_dev, status);
+		trace_cxl_aer_correctable_error(port, dport, status, serial);
 	}
 }
 
@@ -289,7 +239,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
  * Log the state of the RAS status registers and prepare them to log the
  * next error status. Return 1 if reset needed.
  */
-bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
+bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
+		    void __iomem *ras_base, u64 serial)
 {
 	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
 	void __iomem *addr;
@@ -316,12 +267,7 @@ bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem
 	}
 
 	header_log_copy(ras_base, hl);
-	if (is_cxl_endpoint(port))
-		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(port->uport_dev), status, fe, hl);
-	else if (dport)
-		trace_cxl_port_aer_uncorrectable_error(dport->dport_dev, status, fe, hl);
-	else
-		trace_cxl_port_aer_uncorrectable_error(port->uport_dev, status, fe, hl);
+	trace_cxl_aer_uncorrectable_error(port, dport, status, fe, hl, serial);
 
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
@@ -360,7 +306,8 @@ pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 		 * cases below handle AER recovery for devices without active
 		 * CXL.mem traffic.
 		 */
-		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
+		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL),
+				    pci_get_dsn(pdev));
 	}
 
 	/*
@@ -392,7 +339,7 @@ static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport, int severity)
 {
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
+		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport), pci_get_dsn(pdev));
 	else
 		cxl_do_recovery(pdev, port, dport);
 }
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index f4b98f2c11a1c..0385d2f4a2f66 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -118,7 +118,8 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(dport->port, dport, to_ras_base(port, dport));
+		cxl_handle_cor_ras(dport->port, dport, to_ras_base(port, dport),
+				   pci_get_dsn(pdev));
 	else
 		cxl_do_recovery(pdev, dport->port, dport);
 }
diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
index 7f2a9dd0d0e3f..df42d119c53dd 100644
--- a/drivers/cxl/core/trace.c
+++ b/drivers/cxl/core/trace.c
@@ -2,7 +2,42 @@
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 
 #include <cxl.h>
+#include <cxlmem.h>
 #include "core.h"
 
+const char *cxl_trace_memdev_name(struct cxl_port *port)
+{
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+
+		return dev_name(&cxlmd->dev);
+	}
+
+	return "";
+}
+
+const char *cxl_trace_host_name(struct cxl_port *port)
+{
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+
+		return dev_name(cxlmd->dev.parent);
+	}
+
+	return dev_name(port->uport_dev);
+}
+
+const char *cxl_trace_port_name(struct cxl_port *port)
+{
+	return dev_name(&port->dev);
+}
+
+const char *cxl_trace_dport_name(struct cxl_dport *dport)
+{
+	if (dport)
+		return dev_name(dport->dport_dev);
+	return "";
+}
+
 #define CREATE_TRACE_POINTS
 #include "trace.h"
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index d37876096dd7c..910aceb2ca3ab 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -48,44 +48,15 @@
 	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
 )
 
-TRACE_EVENT(cxl_port_aer_uncorrectable_error,
-	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(dev, status, fe, hl),
-	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-		__field(u32, first_error)
-		__array(u32, header_log, CXL_HEADERLOG_TRACE_SIZE_U32)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-		__entry->first_error = fe;
-		/*
-		 * Embed headerlog data for user app retrieval and parsing,
-		 * but no need to print in the trace buffer. Only
-		 * CXL_HEADERLOG_SIZE_U32 (16) dwords are hardware data;
-		 * the remaining entries preserve the 512-byte ABI layout
-		 * rasdaemon depends on and are zero-filled by the caller.
-		 */
-		memcpy(__entry->header_log, hl,
-			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
-	),
-	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
-		  __get_str(device), __get_str(host),
-		  show_uc_errs(__entry->status),
-		  show_uc_errs(__entry->first_error)
-	)
-);
-
 TRACE_EVENT(cxl_aer_uncorrectable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
-	TP_ARGS(cxlmd, status, fe, hl),
+	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport,
+		 u32 status, u32 fe, u32 *hl, u64 serial),
+	TP_ARGS(port, dport, status, fe, hl, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(memdev, cxl_trace_memdev_name(port))
+		__string(port, cxl_trace_port_name(port))
+		__string(dport, cxl_trace_dport_name(dport))
+		__string(host, cxl_trace_host_name(port))
 		__field(u64, serial)
 		__field(u32, status)
 		__field(u32, first_error)
@@ -93,8 +64,10 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	),
 	TP_fast_assign(
 		__assign_str(memdev);
+		__assign_str(port);
+		__assign_str(dport);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 		__entry->first_error = fe;
 		/*
@@ -107,8 +80,9 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 		memcpy(__entry->header_log, hl,
 			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
+	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
+		  __get_str(memdev), __get_str(port), __get_str(dport),
+		  __get_str(host), __entry->serial,
 		  show_uc_errs(__entry->status),
 		  show_uc_errs(__entry->first_error)
 	)
@@ -132,42 +106,29 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
 	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
 )
 
-TRACE_EVENT(cxl_port_aer_correctable_error,
-	TP_PROTO(struct device *dev, u32 status),
-	TP_ARGS(dev, status),
-	TP_STRUCT__entry(
-		__string(device, dev_name(dev))
-		__string(host, dev_name(dev->parent))
-		__field(u32, status)
-	),
-	TP_fast_assign(
-		__assign_str(device);
-		__assign_str(host);
-		__entry->status = status;
-	),
-	TP_printk("device=%s host=%s status='%s'",
-		  __get_str(device), __get_str(host),
-		  show_ce_errs(__entry->status)
-	)
-);
-
 TRACE_EVENT(cxl_aer_correctable_error,
-	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
-	TP_ARGS(cxlmd, status),
+	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport,
+		 u32 status, u64 serial),
+	TP_ARGS(port, dport, status, serial),
 	TP_STRUCT__entry(
-		__string(memdev, dev_name(&cxlmd->dev))
-		__string(host, dev_name(cxlmd->dev.parent))
+		__string(memdev, cxl_trace_memdev_name(port))
+		__string(port, cxl_trace_port_name(port))
+		__string(dport, cxl_trace_dport_name(dport))
+		__string(host, cxl_trace_host_name(port))
 		__field(u64, serial)
 		__field(u32, status)
 	),
 	TP_fast_assign(
 		__assign_str(memdev);
+		__assign_str(port);
+		__assign_str(dport);
 		__assign_str(host);
-		__entry->serial = cxlmd->cxlds->serial;
+		__entry->serial = serial;
 		__entry->status = status;
 	),
-	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
-		  __get_str(memdev), __get_str(host), __entry->serial,
+	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld: status: '%s'",
+		  __get_str(memdev), __get_str(port), __get_str(dport),
+		  __get_str(host), __entry->serial,
 		  show_ce_errs(__entry->status)
 	)
 );
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ed419d0c59f2f..f1ef8b78db18a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -125,6 +125,13 @@ static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 #endif
 
 struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
+
+/* trace-event helpers */
+const char *cxl_trace_memdev_name(struct cxl_port *port);
+const char *cxl_trace_host_name(struct cxl_port *port);
+const char *cxl_trace_port_name(struct cxl_port *port);
+const char *cxl_trace_dport_name(struct cxl_dport *dport);
+
 struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 					 const struct cxl_memdev_attach *attach);
 int devm_cxl_sanitize_setup_notifier(struct device *host,
-- 
2.34.1


