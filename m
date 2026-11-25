Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638B5606A33D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=nl7Y8hmh;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=nl7Y8hmh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZQDL2HP4z2y8W;
	Thu, 26 Nov 2026 03:31:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain="microsoft.com:microsoft.com"
ARC-Seal: i=3; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795624290;
	cv=pass; b=U/5Tc5T1xmSBfzj9DglvWteJZRG8Y1H1icWgcEjLGXQQY0/P+pkuVvF9VS3K4oUfL0DqXpaVAzr07hYzLHFl25/ohilEl05klLJqBbGEqbnabkJ821KE5j0iimxrOaRgV13TLigPlwUKGVuS2NCjTkJD53KsfdhMWG6Sc7xIf9HQ9lYa9algysVbIN7GfKVoa7ZIfWcF4lLgK4qSRsO2zFDypB0134Bt4qQ9OM1ikPjlm3dwasTHWKUKl0mE3HPFA8+jT18C+D8YwDIZI6Avgb5bGAQpNjGmfW3CBO/6VM6S8NpFYzMCOdDkcgZ0uxaY5XUF0SeppTgWEd15rA7EDg==
ARC-Message-Signature: i=3; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795624290; c=relaxed/relaxed;
	bh=ouJBIgt+nRZnmYef/AbrhZ2pbzNQtm9kMcG9IWzu2X4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gqLF/Bd1JxJv5CHWDub7ESjSlhiOUQ2GP8uZbJUOEoaXi0Gea8eLAdF6RXWBXRI3E1PRqiBBRy0/9PPNWIgrYpZXIoDRWNfHu4wFsQdrCRWF+KtcAa+yeKiNp2UADJreiKS9/DLYe/5Fn0gyQNS21oBJ/tb8Xatui/GawRHJR74XslI5ga4WVtiKSIc26ouTPjt08wDTz+uyVrQcQ5M9cjBiI+epGDmNETKGa2yQLfn/PBhnXWzFOxEgWZtJiybEU6ankpBS+2flW4WMF3BVA2bGospIp6/ZTiKPuD9jY1fIEOEk/qxDMDENRGJnt9VKUelqNfOEJD+vg3GngdLHqA==
ARC-Authentication-Results: i=3; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=nl7Y8hmh; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=nl7Y8hmh; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=nl7Y8hmh;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=nl7Y8hmh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQDH6NJvz2xqh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:31:27 +1100 (AEDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AXfRz61icqgewNbv0eot/AcETudYtQY8d0yPm+1NtfNGEVT3jq0HCQv6sfaFU4VYqxQgvjd6adp/sJdFSPbR3aK6TIQ71qMxch17H3EPg4DnO+5F0m2QGCX3YcULHOdvMYWtxsq8qWmBYSg7OQceCTlH5mjrSzTNphm9omHRARVxLnQ5VlWNWlkJf9nZrk2YwuIhznO04xXeTfQA4GsQQOxNgDOxgB+mQs+KFEJRCJrFPuk29eWFRbG+BMGB8NrGyZIaVoXBT5zF7CkW3uKkqmbap0yRXzBU4S//DhunYfWwfGwbauq4B4WBWeX2vvPLujgFdFXa976lLCVcho+f/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouJBIgt+nRZnmYef/AbrhZ2pbzNQtm9kMcG9IWzu2X4=;
 b=py0Z/y0LYrwxPB9/vvoDac0qzhJ/vpcTxOUtAWTGWLYDeWBRYLSm6JuXXs7QuptRViWWUsTEYkBUsa1HyzJ3EUTMCw1YxJWFi5BM9rGbIpihbyrFUr1pJA+l/7t+U+3k8uzuINEONi3jRP62/842XTKPSF3rCSbxkV87zJRoVmLmCokoa9f52iOWhrpdR0gJ5cbJipY4b915xgORWEBK20mgrv7KQP/aF9CR5VhZqCXMPzOYgFaCDV6vnrX1ukZspHPkSUkGDtkaKvJRRV3kcPBnr+OfLLS3ek2uUK2XB7wcP0wkgqrzQ5obkI34tt3paVuFZWLewA4p8jReQpfmiQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=amd.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouJBIgt+nRZnmYef/AbrhZ2pbzNQtm9kMcG9IWzu2X4=;
 b=nl7Y8hmhHY9GQWKkm8RNbnqfcVeBQ5updElWtju6YuIMBPDKcH9ljNecbcR9BQps9f5wfoToWz6WlSVHS9xGa+0lASAh3I7y6K4K47KjUTk/nS3YNV42zfty+beH/5D73mZLiin+/YpHIZwr1KfkMmu/xJEqJgIZpqu0WGCwToY=
Received: from ZR2P278CA0060.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:53::20)
 by PAWPR08MB8815.eurprd08.prod.outlook.com (2603:10a6:102:337::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:31:08 +0000
Received: from ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
 (2603:10a6:910:53:cafe::22) by ZR2P278CA0060.outlook.office365.com
 (2603:10a6:910:53::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 16:31:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6AD.mail.protection.outlook.com (10.167.241.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 16:31:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXtJU0HC8IJ3P52tNaPczCXG7X3ZXUFGvQPTLQErgSTEy+nGeQnU5s0Cpql7XhARAMXfnG7A/R2PoZGWOAgwg4w3FWvjS1VOym53oW8zMoTY6aJvP0SRYNXEEEPDhF8cfLhL78lMtMr6YMLmCgTL6Xi+NTtmAFukVwdMmAD0IHw8lJHfedn07ibRkRf3/4u9AwBM5oV0sgzU/UQwNvJAH2yrVSPgJJnCfOemLmyPC09uajl9jtUkImDmtA2v4wpEYC9cAtODDLxf7a8OATYZ+LnAyN2ZpOSEaQxAhnhhMrHG0/ShhRXFIk/uSpDarhtme12RIUeC57k3KcYinzu1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouJBIgt+nRZnmYef/AbrhZ2pbzNQtm9kMcG9IWzu2X4=;
 b=nqIacdy8Ef6rZeevatnlA1O0rFGr/J7IY/1j8PWKLWwNvYlZF6uHOIAqC/y+vTS3FDrE5vliUIqCdPJ130oOG/oEPuX16kl116pwWulqYrH6SN4mbeO9wSLHjFuf5c2myii9KWoYI4682WaccTr4us+u+v9mHFkmjlmQYvMq7bitxS0Vq437IhjsS8mSDnNbmh4V3rM6aNXJK8d7uwZLak+pOD3kf4pCj/xotwOkNPfknQ4fObV0W2eztapm0Qm5px8BOAeb1dlbuQAUk3ijFh4Hjv3lQxfBfpraXb4uZ5dGuzs/E77ScOAbDgOX28UER8qR4Y1A7VXJmUOgMAMJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouJBIgt+nRZnmYef/AbrhZ2pbzNQtm9kMcG9IWzu2X4=;
 b=nl7Y8hmhHY9GQWKkm8RNbnqfcVeBQ5updElWtju6YuIMBPDKcH9ljNecbcR9BQps9f5wfoToWz6WlSVHS9xGa+0lASAh3I7y6K4K47KjUTk/nS3YNV42zfty+beH/5D73mZLiin+/YpHIZwr1KfkMmu/xJEqJgIZpqu0WGCwToY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by AMBPR08MB11937.eurprd08.prod.outlook.com
 (2603:10a6:20b:761::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:30:34 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:30:34 +0000
Message-ID: <92f3a4a7-a4be-40ce-b156-c3fbec150e58@arm.com>
Date: Wed, 25 Nov 2026 17:30:32 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v1 19/19] PCI/ERR: Avoid NULL bridge pointer
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
 Ashok Raj <ashok.raj@oss.qualcomm.com>, James Morse <james.morse@arm.com>,
 Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Avadhut Naik <avadhut.naik@amd.com>,
 Radu Rendec <radu@rendec.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-20-pierre.gondois@arm.com>
 <avw_daENKPcY7_04@wunner.de>
 <28da8229-99f9-47c7-b2d6-d301ae34253f@linux.intel.com>
 <ba5f649c-f338-40d1-9e85-b666590835ca@arm.com>
 <20261124160027.GC2156781@yaz-khff2.amd.com>
Content-Language: en-US
In-Reply-To: <20261124160027.GC2156781@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0504.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::11) To BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	BESPR08MB999898:EE_|AMBPR08MB11937:EE_|ZR1PEPF0000E6AD:EE_|PAWPR08MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 2618d542-3f74-4713-2961-08df4b118208
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|4143699003|261009223027099003|22082099003|18002099003|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261021121427099003;
X-Microsoft-Antispam-Message-Info-Original:
 AhgwumveZmLnHExFaZS/9UmjEzvEMlU7BQ+O48IN1jA8hX0vHLUT5mONwZy/bc3/2o3xkhzQxhmD/vIcA7blJPDk/ZWFo/I8DTzUWj9XUNOJc1utzKb3uuow94GVmm9wNL4hTODySr+bndlrgXOkKwlqVY9M1tKE25t9u5QAv8i49hM9bBSyIChNfatfdybzBwyJblsm0KAfVBuGPr+1M6t2jFzAwwk+5wITNcn4ouHUck58t1IueO6bY+kYWYZvyntuwGZaM8ml67Sdpa8K+HoenmSteb4kiffsSBF1VAqs1ZmUJOVjCpTEbx9JlmYqIma1FLa7e3pLEIQPjKmtWLoGTAtfmtJXDcVAw+E4RujdeFPLeVuH+BERFm0bx43sV6U+czeOvdS+p/VSBPUCZkxNGeAFT96fkUO9V9cJIGjo6i+pWkfEOTmwD7ccq697uJlO0t5FF1u4xWJyZpOIBce6ybD2HTmf9fD5HqJruH+DSqkJFYbi7fgwqh5rGNhlzbWpvEfkyu+TcsHrkXe77xHJaTBvhbX8KjzNEu/rNE0rJ9T4fUtJGjOhnASrk5JmgmZTNy5N7jofOHK5Btk6ugdpTlbS5UdKqep3wZ4FXitXfy0uWs41rrZN5cw5Uc+Lb6NVJsm4/T7GQemLrGB1NPI2zsZ+Fkpct+Bhg3A2Vu0=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(4143699003)(261009223027099003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 QzDXR5bI5IIvNKgEV3/XqY2UO/b3eggRqJ0SENyJzoWdifxtD7gUrvy8pePr9eUhgM9eXwPta1edZAEf5pnX5k9phZujDTSsdS0klQxaDoKuSMVdjVTzre/jQSbPhki4Hcmb52yezvK1AgiqZR1JpPt8E9V6hNmyxMjwXCymqMPgA/mDMvb1mbkhWwQlHoLzpiDS6sn1ufuM92SQcIxJHpbvQ6vkW3FJEp4YVORdQmtJHJ0+UcNfOf3V/Ap6rL5ptlSqP21Kwy1IPHZPC3nQmd4096kbHdHko5eQh5tDCPFWWgAmXvu+ACiz8DuplXkQssxHsIjsZAPuw4V472LoXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB11937
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	cef271bd-3b92-4f21-41f3-08df4b116df0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|23010399003|82310400026|376014|7416014|35042699022|36860700016|1800799024|4143699003|18002099003|261009223027099003|22082099003|10067099003|56012099006|11063799006|261102123227099003|261022075727099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	3TA1+R0pGWakgq8Q6WXcdh7XmFM67sWLY1hS9gF7bB/Z2ileumpZMEB7SQezrBxcuJGgUk/c0llV4gRbTnN3J7daaQectl+tFDTCuX73pnuEgVxfA+qUEo6OWwM7rGO1y5MyLUfElI25ouclKZoIHt5OqLqhtdf6EB7LMzG+3NHPeAlrIl6O6u9T1csfapeS2dArIvKeUdhfIGo8Z92DhkdMZ4hMvYUozj5Bko/pb/78mhTaRc1kajesJ9V5WSakbD+qR7NxoUq7kzn4ARabbii39z0Hwe9sghTW8yHfe1zY2KgGqET39ht0GX/wgb8CsAJ6c5hTOIQbj7RdDBav1swS/OuO/Z6PBiKe5SpeudRHp1xEJ9aNJLBW6wEx1yPGyCMbo8fVs864esXlo3joATTfSI8gQL6mb8oD+lamHrzYGdf17iyNdiRbF6Xgb/u/4U2GMhcV7O7SaXxuOwJkyCOGKXj06WjEU3SsASR7yafbI4QYS8IFTy4tbsSMTOlkExnzZLOFNPl3ypUcfCwVJxp9UAIQ9Lohx77+j+Ptalma/HI2zn6Wf18rH4cZXOEwndkEauWczwO6CYqP1KVW+N1GKbhTVpmUtD4C6wmfIR519WHkay09F0BURQ6EVQdEKawk/7KUVPYGpoUybx1+yKRjk/mXmIDzktwKxFW6NPm07FI5ya7Y+rMmh18y0qpix+4/gBUTKLruiW7IgopO8w==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(23010399003)(82310400026)(376014)(7416014)(35042699022)(36860700016)(1800799024)(4143699003)(18002099003)(261009223027099003)(22082099003)(10067099003)(56012099006)(11063799006)(261102123227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n+S6GWpjPx2shyhoCu+cS0oriR4wvQ5OB4jbnHW39DLTYWyvTeipFSv9ElyIl/TIUFzqqitKosad8V5dwTLTcHYTIdxc9xYEJAh0tvROI0VapEyqcFt38heeX5w645tlEs6yOuQWtdB4Ooofo21of+/plPAw5h3/jo2OilTM8IwqfS25lbHyOnyMsIsL1qlsg9JC73+1XnOqLcYY5XYyILkM6NG9lx1SqXGcWMsqM+Zzd7L3uK0mPNQDo6xpqkHnoHSLkBKl/4CP0s9wXptxthgxgANH87psx+h3Km/o+38B+EZ4JOwRI8rS0lnoBiWxa1d20yIPAAjzKXeVlqmbYmYUd9ZDHLKOk/cLGw1Y18/6lQoQjWzQ1z9tNOq1Vxcj8dEZ+U67dfR6T0vKtV+n51A93kuilXrND6h3mGkm3fvJ6Oj161aspWdh3S7EhEvR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:31:07.6631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2618d542-3f74-4713-2961-08df4b118208
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6AD.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8815
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/24/26 17:00, Yazen Ghannam wrote:
> On Wed, Nov 18, 2026 at 04:11:48PM +0100, Pierre Gondois wrote:
>> Hello Lukas, Kuppuswamy,
>>
>> On 11/17/26 19:57, Kuppuswamy Sathyanarayanan wrote:
>>> On 11/17/26 03:50, Lukas Wunner wrote:
>>>> On Tue, Nov 17, 2026 at 12:10:29PM +0100, Pierre Gondois wrote:
>>>>> Return PCI_ERS_RESULT_DISCONNECT when no upstream bridge is available,
>>>>> avoiding a NULL pointer dereference in pci_walk_bridge().
>>>> How can that happen?  If it can happen (which I doubt), why isn't this
>>>> patch tagged for stable?
>>> One way I can see is a device without a PCIe capability on a root bus.
>>> pci_pcie_type() returns 0, which is PCI_EXP_TYPE_ENDPOINT, and
>>> pci_upstream_bridge() returns NULL. Native AER never gets there. Only
>>> firmware-first can, through aer_recover_work_func(), and only if
>>> firmware reports a PCIe error section for such a device. If that is
>>> the case, skipping recovery for !pci_is_pcie(pdev) in
>>> aer_recover_work_func() seems a better fit than a check in
>>> pcie_do_recovery().
>>>
>>>> Why is it at the end of this series?  Does the series somehow make it
>>>> possible that there's no upstream bridge?  Which patch does that?
>>>> If the preceding patches are not the cause of a potential NULL
>>>> pointer deref, why isn't this patch submitted separately from the series?
>> To test this serie, I generated and injected synthetic CPER records.
>> The PCI device referenced in some synthetic CPER records did not
>> actually exist. In such case, the kernel crashes due to a NULL
>> pointer deferencement.
>>
>> This use case is indeed slightly unsusual and unlikely to happen
>> in the real world. The patch was still included in the serie.
>>
>> Please let me know if the patch should be either dropped or better
>> documented.
> It would be good to include these details in the commit message.
>
> Also, I agree it is fair to be prepared for, and gracefully handle,
> unexpected data from firmware. A platform may report a CPER to OS with
> the intention that the data is only for reporting purposes, not recovery
> action.
>
> **BUT**, we could argue this is a platform bug. CPER serverity is one
> item used to decide if recovery should be attempted. The platform should
> not report a severity that indicates recovery/action is needed while
> giving bogus/incomplete data.
>
> If the platform is intending to share data for reporting only, then the
> CPER severity should be set appropriately.
>
> Otherwise, this should be a big FW_BUG message "Platform reported
> recoverable error for unknown device."

I'm not sure to understand. Are you saying that we should
try to fetch/resolve the PCI bridge in pci_aer_handle_error()
before calling pcie_do_recovery() ?


