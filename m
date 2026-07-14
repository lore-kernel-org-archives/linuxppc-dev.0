Return-Path: <linuxppc-dev+bounces-24196-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62933C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 09:28:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzvBN2WLpz2y7W;
	Tue, 14 Jul 2026 19:28:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain="microsoft.com:microsoft.com"
ARC-Seal: i=3; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784021324;
	cv=pass; b=ouKqqP6tcqbz9ugGsEiJLynPwqly5OYiV7vghEfCLFFJUdfcWHa5mXegHp5KbxZPtcb7t5ApU2cdyamJvEsoGiJc9PJz4sc6V4KDf/zsfiMj8jcOngxjBbv+NKxgmcZxUQwZ3cVfFjK9akjEmQrG7GbNFNx5viIT/+JIn8Oc6JPMzqpkCctzrIF69DMUUXVOvdbzPSkTfkz8ZgZDpw8GnXOsaMyshW5WULkdhQhV2HHjh9L3g6D7jLcBnXN16MugYz8+V72sUme6sjU1nu/5ysVwofyLNXM0/AQBm/KFDMRZC0VsRufJjiuKZCBfI2aikHuj5mm3iWq9yrzSFAB5NQ==
ARC-Message-Signature: i=3; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784021324; c=relaxed/relaxed;
	bh=gopbG7UheHvCh7eBvyWX0sc8UhiYlvHM66YGNojBZlU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BOa/aNTMJ800H/erYDfpPqrX8cH5/sdDgLDJWpu2SyQ0Es9hwXpszZcmHiqw8MZmjn9zcES0EM8s6RPzvBCHMSJSW8xoZzxpLtPJo3L12RRkvbL9gPzOxE8nfCvmeZUbVwu+AgIJ0PV+PMQJ2Tt2zfGX0dQvUbUBqO3XHy34tD8P6pQWhSea/TyhjA4omfxn8o4QJg8+AHNt1d16e31MLq68YxL67BX1fjKqWroJxEKpWNPiLc5qGIQS5gvXn2wQFTwRnR/SCHuX1biKeFMRUxtDkL+ovt/k0Rt3RO5LH1lU4+0R8+13PgP/zLu5v8k57wqa6dPmcT4O6di2FSGJbA==
ARC-Authentication-Results: i=3; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=c4lbPi7r; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=c4lbPi7r; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=c4lbPi7r;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=c4lbPi7r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzvBJ5VtRz2xVY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 19:28:38 +1000 (AEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AnhCLEkt6Dr6Lw9SKmdsKJR8AeBURvl5UB3zBPeR/seiZvGc+cQ4N487jsk04y/jMVARDTEUqELzLlkPyvMyo8OwpJztVfwXGe2Tx4vRm6wfw5oMVK8Ig9obWa7xbtc9bhcjlHrSC6CzPPfI0DEtMsX8onI+SYj62NxnHqJpxwtE85jFh9zCSbyn5+BFD72Fdd0o2+qtgKmPmPZCfnqxZAjqBLge+0M5rvIFq9FlII4r5xr7X4Clibs0ylJmxKTVGmZArqdevPlcN16PtOqGlkrgl8lsISZ1LX3X2eUoHjlMxgWSKou9lc3tFtVwj868PDFz/LJoFk6Xct1u2dQamg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gopbG7UheHvCh7eBvyWX0sc8UhiYlvHM66YGNojBZlU=;
 b=ooo4Be0l9VzD3OdEsqpWi5DpbVX0Nl/gElh7P2Cmx7O16n6Hb9jjPR4p6U8II/O/fmTV13nZ7gW3ZNVCGuCBX5c4VO3edGX1i7+8+QvxEX5GrQ5TUOScdlhKRXj7mQ0/pVzHtkKbWxFPOkPMT5v75kPHjZrgczLHzupDMTLU9x4zdgxquTkFhRgUdJXPefbxtgk9ylGCZLY7adHNa2i80Xc7ruX0WLjA/0JHHy8RZN+RiPL+2v9C7NiS/nSfK31xG3dSTC5GZZrsmwAdp7Dt8dUNRI3HGx8bLdbidlpma5G5Zkm9zNS4tyKFNZCA+LCgLXX5HPFc9FjRF+4+M3m/ng==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=intel.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gopbG7UheHvCh7eBvyWX0sc8UhiYlvHM66YGNojBZlU=;
 b=c4lbPi7rrA5oQkZwIWgutbcyEL1JEJU18P/wS3CpmnyOWpHER26jVpksu6q0ddqTzWvi06FaxfZbofOHlIHfc+E4x/t8x/unvxtGY5x4bhT/PLdx4Ftr9xxxJYUnOYq9t0zURuX5VCd7jcutNofsvS4Giwz2hQJhxzlVUiAf9Qk=
Received: from AS4P190CA0029.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::19)
 by PAWPR08MB9638.eurprd08.prod.outlook.com (2603:10a6:102:2e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 09:28:08 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::c) by AS4P190CA0029.outlook.office365.com
 (2603:10a6:20b:5d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.20 via Frontend Transport; Tue,
 14 Jul 2026 09:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Tue, 14 Jul 2026 09:28:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWEeTzdvqdvYsBdr6Yj7ejNeiZ+qeyGJbfT2rIkf6GpraANPV7KixjZ/ZNHNvbX1gSP5S4zL/4lXYTtFVVZIpVU3Vnz1+BWpsc0awvXShPMS1Y5wC2F/UaFWb6unUqKrI5qU4HznNR2kNtaFIiTPxdei+aNbgN/KBzedMmD/i+qphzuVg5jPSD/ZGRM59EYtwM/TAaATxqPjxpQ9hBdL9SaGTdLuP9aRLwVECse+JtxCOk4wMxfUqWaLGu4W2mguyY51aNTYFiPRzFRBqoAfRqXaRU7eP9EMzgdKzK59QYINvCtuUe/1oubjsvUQRrUNWQH/Cg1bsJI0vNvDNH16Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gopbG7UheHvCh7eBvyWX0sc8UhiYlvHM66YGNojBZlU=;
 b=t+eNOKeFbzZStnDo/xJDcncYwdQJUd6nxaJib8T/4PhvD1bKsJGVLDdU78F/oRG8svbJU3IB0KT6RVe4RLHkVL6wVI783/ESuYZFPApkBcnu0dH3G+G2aci8b9qAAtcArlUMOVhvVkSnF3EZxzNqBFCLnGDuFM0aC5JctDVMjkAXhpKKUQu0NCJKmhFIIkQtJ8xnLWplNSANVB4iNZTOFikHnupTBaXt43f7C9qhEvisxK2HxJKSFMmPNCF5eAEd26w+wQTaLnBjfXrWe2k3m2drO9t9qOW+F9hK0tx/sctgXLKP20QjwXEeLX/u3UJ1IXAf49JK/NdN7NUR9ZFxrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gopbG7UheHvCh7eBvyWX0sc8UhiYlvHM66YGNojBZlU=;
 b=c4lbPi7rrA5oQkZwIWgutbcyEL1JEJU18P/wS3CpmnyOWpHER26jVpksu6q0ddqTzWvi06FaxfZbofOHlIHfc+E4x/t8x/unvxtGY5x4bhT/PLdx4Ftr9xxxJYUnOYq9t0zURuX5VCd7jcutNofsvS4Giwz2hQJhxzlVUiAf9Qk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by DU4PR08MB11007.eurprd08.prod.outlook.com (2603:10a6:10:570::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Tue, 14 Jul
 2026 09:27:04 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%7]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 09:27:04 +0000
Message-ID: <e77d0367-ab24-4b6d-beaa-034dd793cef6@arm.com>
Date: Tue, 14 Jul 2026 10:27:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] ACPI: APEI: GHES: move CXL CPER helpers
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-cxl@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-6-8b3a85216cef@arm.com>
 <alWi5hvXYT0-ZPyV@aschofie-mobl2.lan>
Content-Language: en-GB
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <alWi5hvXYT0-ZPyV@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::16) To VI0PR08MB11823.eurprd08.prod.outlook.com
 (2603:10a6:800:324::5)
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
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB11823:EE_|DU4PR08MB11007:EE_|AMS1EPF00000048:EE_|PAWPR08MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: 273000cb-246c-4b43-8757-08dee18a371e
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original:
 YDna5YWPiHOSC0aQ9Bwy42tKLSxuJ/4lQlPoJQHb4teX6q8M/UMDU9PFNIX5tl7TKYnUck6wY0p/cLQO+35cDdydvlwc2nJjfck0MpZ8Fpe4snbXLk7L3CJGmyLJNXdu746XitFCC6q6CzjOpUHUlkXoCTpwN9agQ84ht/feofvPkyRt+qIyKLXRie04YshonK0hCt1jfofWAGNzzId0DheyC7+07aZJSmawZtwfuMEGZp3bR2lO0oHAsozXypQnY0zumIsL4F0IBjsMwc4z4eCkPrMwSAgTE0vxpwXc5UFIX1mG1/MDSQ5sMibq5GId5Lxl+HwneDcbHAOyFNcEDnOo3r2gjVJToCi2SwaSAAEveLdp7uYBqTdn1IVpkIqbv9Kw69hUDaYmI+iFr3inqvKFO+CNpFSUlhl6a99yYwFIOqMn1JNKGwyGNdrks+8s6nmaKXahOQ9iDjiwWoZ8K0gF9eQAoNT3Sak6V6dZmDBPKEpsSbGQaxmYlTE3pTHv+Z+mag4A3xk1nAkKS+YD+B7DqMc8cRF1+caOiqXB/45LveABntyV2hJsLHzyyjGTsjTT0nQg1fQp5wH0Ep+0Dd7RdI6WEp99JSyFY6aGY8Fa+2oDAJ7bqP0l7i1ol/qfSiSKA2PjWP4LZGrmMjpxRZvlYwoDsGbSd2P/gpOiORg=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 rXYk/X9saKVSk0Bbw5qrxD9w5c53mNkAmuFh19Gtvou9l+UCOIXHjDyyQ4uYGfvj7V1y7snQt2f98+1yQL29djra3Ats8hIpF1Lbz1HkXuag9MlCCd6DB0g7LDLcpSRP1MYm9xth4cQk37PS+XG/XqYgEucDwdAl6/JfNzkjttnDTvJU0eIC1NASmcUyvIMz0tL/yvIQj/zh1TVCuULbZuBnGUtul3HHj7PFQamTAgt03tQOzkbrAWB3mQYqu9EdMDpJbt2Pbh8IO9prIznzDbSZYj7VfosYwD8Pxb3gMbF/BBEqGde5Kjvyy6GOepJYuDufz1zcFGqhbrHmZGnVaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11007
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	18c16b10-abd4-43d9-97bb-08dee18a10f9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|14060799003|35042699022|82310400026|376014|7416014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ibk3J59ge6fgQl/1L/9/TWYGluS/br8nQtyK966nmswXY6QnQkg3uKHDvrYgwkFXaTtQfmUaikH38jqhyrjp3C3UygXgyfPD/PqfWEbRR1cy2HSbdnm2iHZi3fzHTcY/FgTE1JDKQL0PKGWagGRhvP45CL6UgIszA6s4AgePensGvc+prv5MKH306ouy5wEmfsYt0fUAPpN96UZFhtJe4FK2ypXo9G5/XzLRMlG5iWnKCkON+lJfSpvijOCVPSfk8pBYHi6XhiVZhhQwiBPCfSUeYIlqcCNKLstxUSr3cMny3EjGHMdMN8j/9RS9d9gRN9pY6q9fW2MyC10hi2MgmGaxRynbixLpUS404aJheZ+XtzDWXI8aHUZyT6XfD7iYtCtXGrU0Gf4p/kH4ZWDcOWeqYBcaN2/k/WcLXaOwyX9GsNx7UJNtK+rF0bLP5tOoX3eEBh2ddtBb5pme/+1bYFx4QfPnLcf5ibvpQrprnZD5zA0AbxS1Fuofvy0DgZ7qSrvTljpT2hvPu/k2vuoGPtVnpY6+ytjR27lcgalqljFrIPfqxFXo4qGTFdwpp2nBmfgyyJnS4DrhTZcXFyitob04mSjaGtqB09en0GhrF4zc320rixeEUvznG9N0rYBP0R9XGZvw8geQDrtkWuNxL5pjUt6kAiSYpk6pmqffFw6p3Dl4UvJB6lQBlTJLGnNtmg6mnN2FdmpQ6x2vfmydCA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(14060799003)(35042699022)(82310400026)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fXQRKUPTDYk79cwaN8Zep2ZuMV3/0EYPaweY+OvjPbdzOgZS8YIJiW0+1tV1sE9lb6FMHEsfF55WYu8EGXnLxMZCzV9xbCzt9+2pSky81QIvtxCKxZCD4Pk9Y42RgwTjQgatHdKCFJCGgrA0jyVuMk8JUGxlpLSRLZf+JxHhlM8IYH27JFLwdZsxWX1CSUO5QXYJ0oqTPU2HB+wIldgAf6cwlIY96jfgidGb95M6e5kdQg1a1wo+bjiHIUTox9NpnqsoqjCWN4UV1p+TrBZhb1XtJvGwVhsuamFkH6U0o1RK3CtO3MS4HMCmtpd46N4Riw9XOdgyMEHTD9ktoQ/m9ltPh1w2AVmIaATGeKMpnrQx8ucGepilQwLmOzx80X3r7wWg6JztvhSJOYjSckCdbBxDqvVF97HuoRmzTUnAvN7beCxCVBpmOs2W67nsDfmV
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 09:28:07.9133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 273000cb-246c-4b43-8757-08dee18a371e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9638

On 14/07/2026 03:45, Alison Schofield wrote:
> On Wed, Jul 08, 2026 at 02:59:05PM +0100, Ahmed Tiba wrote:
>> Move the CXL CPER handling paths out of ghes.c and into ghes_cper.c so the
>> helpers can be reused. The code is moved as-is, with the public
>> prototypes updated so GHES keeps calling into the new translation unit.
>>
>> While moving this code, also add CXL CPER section length checks and use
>> spinlock_irqsave() in CXL register/unregister paths for locking
>> consistency.
> 
> NAK on moving and changing in the same patch, and esp in a patch
> whose subject only says MOVE.
Hi Alison,

I understand the concern.

I kept those changes in 06/10 because they address pre-existing issues
reported specifically against this patch by Sashiko, and I wanted to 
avoid carrying known defects forward in the series. I did this following 
Boris' feedback to address review-reported issues in-series rather than 
carry them forward unchanged.

I can also add a dedicated "Sashiko findings addressed" section and 
update the commit description to state clearly that this patch is not 
pure move.

Please advise your preferred way to address Sashiko findings per patch 
in this series.

Thanks,
Ahmed

