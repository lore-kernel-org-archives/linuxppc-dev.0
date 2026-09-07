Return-Path: <linuxppc-dev+bounces-26672-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD8DC79FA0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:07:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdm6T10X3z2yvv;
	Mon, 07 Sep 2026 22:07:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain="microsoft.com:microsoft.com"
ARC-Seal: i=3; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788782865;
	cv=pass; b=SPNg029Gxzvg56IcCvZ0BM98LYbNQU1d3E10LhejVPslrDJl7ilRy5v/O6xvyJT5mZwmV0YFWtGwYD6IHzGG3LNPFIV7IzhoG3tZnUoL6CNOCbR+nuOTititn7+nJrG3v8oQpzABGMO8ptqr3O+nQTzqJu9z4ZjhzN13P+B1sgVC5TYkasidKLo3bq4bxEdZ/3MKwlm2E6KtK/+Nd1+axzz0l8deMm152DKyutGrG54qEA/0WdURvkQj1OKZsBRcuXAwBMs1mqQyU/sNUrS3LiW5ENpUqG4zCK5MgKdG1RW6rPMZoNBc9rqHujUh1ucTMugohuWeQsc4CsKbsQHMyg==
ARC-Message-Signature: i=3; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788782865; c=relaxed/relaxed;
	bh=oVcsfhwrEthpQbjqa0/IPKQxhj1FPIzOGUNKhA/6R7g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HOIkOYNLQOtmBXb68CzLimIJYcnTTszJlX6Kg7DpTT/m1FV6jmUo7bdBTTVJo6aOx/Ya2+R4fwKGuqmQOCY4QitcEjBZd7Gz64lL3CN8pcQsGHly5ddTmy1hEQcr5a2LjMknqayIwppFYXMw6kgYo6Mrig4LxvoAPFztzrcS7MdqlAyQ0KfGIX9fOc/2roQYGqT904xSkb1Q5XntLl1fe4VZKCi0/WquxzQKdoef2BnJcpI5jgHsygVsIypfiUMEZVQxiWvFwEjwK7fK0guiKfH+YJHrw+8O1M6op4Dn3C6cwu3goaNwodyLfb91sM+pTVc6YzFh+niPuuHMlX1IpA==
ARC-Authentication-Results: i=3; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=GjrVPEj8; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=GjrVPEj8; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=GjrVPEj8;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=GjrVPEj8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdm6P16v5z2yvj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:07:38 +1000 (AEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=yYHNraNKIquKGFFmQHBT36ZJaWLEECFHVunE0R4GV2GqpFNseiRZT7nhT/rZD9lV4EZDtGS3IpTH0SILyr3ehZPVr2npD5rjKFED+SgQsrSA+dRARjJa80zOdY15nDC1k0/Rk2lMBxfPkNLXR1cK7PNdmwIhwFAX5muHoFYv5EUIoTjOdwnRwWumLmoHt0tPoQ4vBVZMh2peCZHkqyNxGJrQ6ki87YJpfEcKr4n3z3TYyXqKukA5Rn+JoijLQb/pY26pI5xLnasZfPygy5qW/zGdNgIUZhe7not4zNJtX71UPo0ZOsdf9OQkPNyVqQ5300j+8/rg0TxT/edOhS3bTA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVcsfhwrEthpQbjqa0/IPKQxhj1FPIzOGUNKhA/6R7g=;
 b=nhy0y2eHIEcPSBhes4ZCJibKaQ9JyMyHoR1vEEbrGMO+5ge7WYKwrm0pF4koEg6YR2ZgqgoFfB7wnVcLOQoJwVYMbMVmziDtYer7sc4PYfH99mj2MAxV731PoZVPgSTt7B1wQkuDnBIG1fTeP27pICAeDq15Ok9jw6hNbY/Fg+WFnedB0dkspZQ3hyyEM/3tXPaA5qYAV9o51SsvdIYl5OS30O97S9m5Te2OBy05DT3o12oBOMDUvw7+1fWqOIDLILvqOBJ8sRV827hFX4+2HQle7GPON2h95SFeyRQO8SqniF2DOn1Hy5BvzA0ZMcN93/YZriCYa1kX5FKlu1MEeA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=alien8.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVcsfhwrEthpQbjqa0/IPKQxhj1FPIzOGUNKhA/6R7g=;
 b=GjrVPEj8W987WO1yD1I5gySPHXAern42O72p/cymBV3/Yl6w1BQQ6s4+kil5iRq8sx2VoHx3IyNGDLcQIOhii0d8XNklmTBFHz7KcCty1xs4OHWHUpeXxZ2z4C3ZMzdqDzklDjenpHNxih1EUu1mkkr5jqzWUQL04t0dzkTzUIo=
Received: from PAZP264CA0051.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::11)
 by DU0PR08MB9725.eurprd08.prod.outlook.com (2603:10a6:10:447::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 12:07:06 +0000
Received: from MI3PEPF0000847E.eurprd02.prod.outlook.com
 (2603:10a6:102:1fc:cafe::57) by PAZP264CA0051.outlook.office365.com
 (2603:10a6:102:1fc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 12:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF0000847E.mail.protection.outlook.com (10.167.240.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Mon, 7 Sep 2026 12:07:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCQv3jESKNrDxjaVhzImfg/V8G58xh3+kqSosEPBnYrEbVpZs20/hH/hB6P+Xdt01QsZRgZg8ofKP3eMdKI775a99YhwL/PyqduwOCzsbZq83PBO80q02ddhrZtSHegYZRoGEnLd2nB5tZ6lfIZNvHRFZvAcs/YIth7Q0sN9uhJ7kOXCKtKcoiMEKi44qq8MUMfd1IfO922eIodvJOc3rtstX3ScR70UNlfSqmN2V6OMHEFv4bjxmN5vWXNqSpAGNCXsrxY5n3kHJNKPgNM9yJ7gP55rBGjsnmPJspm0QUjXNE4OITWrgp88ez+P4s949vP4kSu/4c9hRGljDbe8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVcsfhwrEthpQbjqa0/IPKQxhj1FPIzOGUNKhA/6R7g=;
 b=tjdGD+mn77EV2dZrZ4s4Y0wG0UtWxESUeEjcxifIpL4D1KeccigyDQ3NkjPdTE9jXm+TejWppW6Vb++Mnekyd+0odkvv7sVKX0veXWwycMph+HnFQXZKPMosPbAKVY/jZT1qnxl7latose+jVFMl2w8xfCJV5WBQ52BvfE7n59RKY2QStnuo1CV2BA2O2Kwg9N0maXsTjW/WXeKCpAO3qwda3jJ0w43DumKcQOrOKcBRVpeAuBTB1eWr4AnPg+f975/6bNNreT+Qi6gFpqjovEpADdPpvWINRh9d/3v2vSlOk5UcxY99jwppte5Rvw/uUDeMI3Ew+VjHGptU/eQ2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVcsfhwrEthpQbjqa0/IPKQxhj1FPIzOGUNKhA/6R7g=;
 b=GjrVPEj8W987WO1yD1I5gySPHXAern42O72p/cymBV3/Yl6w1BQQ6s4+kil5iRq8sx2VoHx3IyNGDLcQIOhii0d8XNklmTBFHz7KcCty1xs4OHWHUpeXxZ2z4C3ZMzdqDzklDjenpHNxih1EUu1mkkr5jqzWUQL04t0dzkTzUIo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com (2603:10a6:800:324::5)
 by DU0PR08MB8116.eurprd08.prod.outlook.com (2603:10a6:10:3ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.1; Mon, 7 Sep 2026
 12:06:30 +0000
Received: from VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd]) by VI0PR08MB11823.eurprd08.prod.outlook.com
 ([fe80::694c:3790:be1a:8ddd%7]) with mapi id 15.21.0406.002; Mon, 7 Sep 2026
 12:06:28 +0000
Message-ID: <9af92fe1-e5ec-49f9-a85b-e36888f566c9@arm.com>
Date: Mon, 7 Sep 2026 13:06:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/10] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
To: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
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
 <20260723055347.GHamGsaxesLkMbSnfR@fat_crate.local>
Content-Language: en-GB
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <20260723055347.GHamGsaxesLkMbSnfR@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0323.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::11) To VI0PR08MB11823.eurprd08.prod.outlook.com
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
	VI0PR08MB11823:EE_|DU0PR08MB8116:EE_|MI3PEPF0000847E:EE_|DU0PR08MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0cc1c9-b761-40fc-0400-08df0cd88911
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 WoSMxl1/4uHVH7cVFWun6At9WCM+jsYiQ6ctu82UA9E3c8g2Y2t1SRF55ZWVLknG1DBiyTuIpGcRgkIRKr3kN/xEFkxxCtLp1AY5SBR+hh94likgtr5kjoud2HZz24OYIQS8f9d44Ev+LiuqW8+wgInQb0gWrplIwdqKT+QvAXc+rM8n6IICLkQGZzo6nM/GqZCwLB3O9XbRnNEvAa7WKrRO5yeDQt2qFeccKYKJ4vFkK38ZfTQbH9DBlQ3BEsmoXYgqehfCKDWxY1PXro3X5shV6hH2229CldelZu3QZw5jGPNUtFAjLfHJgvJRANuhdzxUNVHoHwi4GRW/bBIsQHtm0+ghuZ7UjNRYroRfUydI8Xx3ruAfqa37vsEe6EFIUBun/wz+8gcY6A6YgbX8hr9oK8ckOsG9GW/PBWPWZKQyi9HAU8k8he2qW5eQgC+lRLNPM7Kg6gGDIHCAo6FXPsSxg39jSt4ny9+y8mbmb2HFKgXBv+Weak7DWyxmBLiEzNy68klVRzG8cAXQvn1JWQScKHFT0L6ZTI0us42AdHyk3QunuQPlgTJB02YcGQywNMAWIko6mjPNX4YMSb0x0YGK/HKuLv1XW/AlxAEzZeE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11823.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Ax5UrOKk7+o0kiaA7rBnrjj4WDu16ZmpV1I4bT5bOtp90x27yTu0NwahSFnIxkujnlf4SWsNCAKFHDrCsX886eqFcHbEIc5M79mjitI7bL1XZrctpiosmM4Pb775XF9vq8ZsSI8XKkZ7i/+9Qg82dYyzMQeU7SYmbWNTdiXseFnEn20jFq8akxfNlah574IiO6FJLBYs92+0AULwOtw3qi0hjtreTN1MGJcPabPvKf5o3jvGJWhnp2BfWKzQUYLq7JrlSM8sKc1CRGSPez5evL4UcLulk/94p48ON6Nd0LDZ2jKCTKMZlXbT+2C6ghdtOfid9WMrv4SrHihv4728SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8116
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 MI3PEPF0000847E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	a2ae8ed7-7dff-482e-86c9-08df0cd87263
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|36860700016|23010399003|1800799024|376014|7416014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CjNl7YrWfKSemhO+eTHBiy8ieZ3Awd1n/7haPtPhLwCami8qO+tS8qlz5V+IauNgWm0vcb4FJANvlmMF/KnLOZuYTMclQMoG+N0fGWY45p/XH5xC0vU98PnrXgOjKB3Wa6TncK/WBga2qd0+ubep4XAcJNWI0C8qVdYEVln0fC1hi5cgpzVDwwn4DULSRRw+Rbjqqhe/58m+V5fLxVSmV2/xqMhBsNDUa/YBTh6Oi38iFZYQx5bEwf9oySf78kqSHoz7dWk6d/4Fz0Xli9ZhKdnyf1/7YvCj1JbHQjSlM52tYRpr2Tciz2Ggk3u8YqopPwJAoNMbxFAKDE+SAiUGHGVwdBIOgiwdMLC7EUy2owwSajMx8YFOiUrE0S8sB2bkNphSH3f5Rtrgf1iVMrbTZ3DFSobcraRhkShpfc4R64bp2b8Apjrw6uWqP79XqjPe1RoQVbBSdrrEQwh5C7Kweamsza1SsZVsQu/ipT1SJVSybQA5eXAiG1KdSAa9o/Bq85nD6xF4+iq4ENkbSEVGTC6L9DlaQxlLeyUuzUXC6wv2zb9nnnQUBTO+yCSAn5UZjnEIlndOWlzYsbNQXC2PZ7ldAqrpJoZ/RChcvfK4jMqxPN4qZTsa9E7QDgvOlbFJ+53wsE7ljDuXZVRRIL6yZQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(36860700016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OlKjjU84V+Ye/CJq/JOfU+91kTbpadoZu5AvoRdiz9saVnKvr331fpzBDq0bSfAt7Zu1xLtk+nT4L+8jSyyA40wBXnEVHrK3F7kFuX/YpRKksSl3RbfnfDa2cJ7hsI5OvPxeUP1Vl8VNnpb1Mfnry4E/1pM7wZ0BnA0XkaiMO+07IYteXqitlFAJZLdk/+ACTqMGOmPXu0Tx+BLpIoqE7OGM91tY3A9c9c7TrhnraMJH9UxYcDE0V4Ov0U7gvx487UEIavMcNHmokEld08RFFpduMSjf6cd/TXhC1SbB5CebtEmDHdSVC4/mjCxV2pTBPPikO+kDDvEPQTXGBlPUQGauhuacoCbk20K28La7EpyzRFLMs2fW8VGbErmNzvc+88M2zVGs7qLpzGozL23xup2ZfXJD4jCw2fZkdFRekB4sEjSp3PKHozoMugJgYKdk
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 12:07:06.0838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0cc1c9-b761-40fc-0400-08df0cd88911
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000847E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9725

On 23/07/2026 06:53, Borislav Petkov wrote:
> On Wed, Jul 08, 2026 at 02:58:59PM +0100, Ahmed Tiba wrote:
>> This is v7 of the GHES refactor series. Compared to v6, it addresses
>> the Sashiko-reported issues including pre-existing ones and fixes
>> the ACPI-disabled cper-x86 build break.
>>
>> The DT firmware-first CPER provider is intended for the upstream zena-css
>> platform. Validation so far has been on FVP.
>>
>> Changes in v7:
>> - Address Sashiko-reported issues for this series, including pre-existing ones.
> 
> And Sashiko flagged more:
> 
> https://sashiko.dev/#/patchset/20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef%40arm.com
> 
> I'd leave this to Rafael to decide but I would fix them all first before we go
> and carve out things. Maybe we can share the effort and such. I see an EDAC
> one which I wanna take a look when I get a chance.
> 
> Thx.
> 

Hi Boris, Rafael,

Following up on this series, could you please advise how you would like 
to divide the remaining fixes?

Boris, did you get a chance to look at the EDAC issue?

Please let me know which issues I should take. Once we agree on the 
scope, I will address those and prepare v8.

Thanks,
Ahmed

