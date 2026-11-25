Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97FF606A6A6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LRhKds8q;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LRhKds8q
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZQDL2GBDz2y7p;
	Thu, 26 Nov 2026 03:31:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain="microsoft.com:microsoft.com"
ARC-Seal: i=3; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795624290;
	cv=pass; b=acNNCBLQFZRkMYUE9MO4Wg0NKkfSiJv91rrka6fGNbb0XGby/5CNuxtcae/CXrRbndMthtUlP5rNxeoJGAJXQl9aekdvlHKi5yJjXzVa/5NABpXYhL3GQXfdGbQKHnFWdHJWhvEt4VSo7tqEAZbdR4n1zh/viNSUThyYFlHoqEsH+HHqX+C6qOU4txHwNxnwtSEns983W/wBUVa2DXM6vqcNZmejEk19kp+iiM6nd9Q7ASppQV1Aq7CLJen7WtGYYbviJbJDM68Pg8AT0hYkTJN26njClbAnJVn1ddH5B/yaC1PRwLIVlWVFGLJMS3uWHU/f0nNno4SEkjE0P/jYjQ==
ARC-Message-Signature: i=3; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795624290; c=relaxed/relaxed;
	bh=mQ8WMu294K7ivZV/DoLabS0cFlftdL+h6xSvpm6huHY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JrRsaluy26h7W4hsOpXIXkL/PH9/q2yORy7HWEEiL0INNCfEsUBqEx/rtMbPm/PS6joAfdA4BE0TX6V+vU2KTuHhEjyjzYbkqQFXiyT1pz1qcCf2JOaCjqhFsKjv8kQrHeV3T1Ug4PsjDve5BUpIEMO8EZmmEsVVexYRoOQH5ClOrQXSf2zbJNcFlP/4pehhy15pSlFZ/3Z4I158pIqjCygJ+WYS79wC53kpn5of0e00EUJ8uLEUHb5fV4vLzl7Afq5iUziVzqspOUJkugfWOJdtz/w5A35IdJWiyFJhl2XoqxtTPydn4RYFZpqSzYLEX6EektP88kyrBJ+cZbffrA==
ARC-Authentication-Results: i=3; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LRhKds8q; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LRhKds8q; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LRhKds8q;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LRhKds8q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZQDG2qlBz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:31:24 +1100 (AEDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=eJQrVFGolQE7tF3kUNklv+rmHPk777GnW6acG8nJ+9VPj/t9uoP76/9eEUYNSXk0wozCBNVWsBvSMqLlbP0lT65Sm5z8YUKwRLSaulOPqHtZKK2834HCBm9pQNA11s2L0+4SYdik/q6sWROC+ppF8yYgUeg12N4hsDZFGyLhZDae3bGiFhfvSRQFyQ/TJlRmba48heeDXFdAIv6kcG7zdJiwn5aVyoxJ2QAz4sCcoTJtST1nCTN0aw2ur0P2RxeEIMglefFbSfz3xF8gqKuyGRx9lJqGkmRued/gJygB9i5NU58clyzROSvCHe6w0NV5AjuAR0Kwg+bU7FbKXanGUg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQ8WMu294K7ivZV/DoLabS0cFlftdL+h6xSvpm6huHY=;
 b=HlC3IUOq/iths0GkcN3y4WqmK+WDRlYpKHYbpOr2lKO3JYUphGxG87dO6jrL8mY3wWe8d5eW/FcXgLMb2KMMM0NNUB//IhVaKxZZW5x5eK5apkbkhSR7bJ3pA08mzalToc+jdNLP+H4j2w5yiGIHPve9aTCD29p7xpZ22u51D6MR6yGIEDxYYkK1iihp/1YNybcsuikpPZqSkIIRh+zxr7ZgZwQSedMnbuqRWA8WTMiD9SiQxhiOuFFNViKMaGI3BSdc2IpHljzp1iyHh3aT0A6WPDlnSUPcGl2RQPCD/b2+FgwJ7c4v7Qtyad+AE7Y4XTWAKb7xwPj5R04Zre9OmQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=alien8.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ8WMu294K7ivZV/DoLabS0cFlftdL+h6xSvpm6huHY=;
 b=LRhKds8qoSqtBcaFdRGQHvoMsKLBKs1rO9qwGeKK57Nhitl53Klx6ZLt2UbuXeRxV8XllH50bhivbZQSZRDbMcmtFNaBDsNaqbhgdMh3h1H4tzomi6ZrqJcCYOGUZop8oICaogxk0pi6OuqC2iTc+/k009A7WXeA2JSA9LO9Ugw=
Received: from AS9PR06CA0563.eurprd06.prod.outlook.com (2603:10a6:20b:485::28)
 by PAWPR08MB11512.eurprd08.prod.outlook.com (2603:10a6:102:50a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 16:31:02 +0000
Received: from AMS1EPF00000097.eurprd02.prod.outlook.com
 (2603:10a6:20b:485:cafe::3a) by AS9PR06CA0563.outlook.office365.com
 (2603:10a6:20b:485::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 16:31:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000097.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.3
 via Frontend Transport; Wed, 25 Nov 2026 16:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCHL3dCwK+SN97WMaVcQCgaepw4vypOLOMNLSA39MAgl21gAOqhWGqWtHWbH0lXn7zz4cfNyI9KtnRA5uOpWYmYvhBnEHW1rBbSgkTQxWUATv3FeSjeCMc0gcH4/7jCw78IOYeixMq6dA5ku2uxh1I1/6LYZtDb3uQahMMJiGnqeb+BQpXMFRWqeUD1TNyux5nYydnvt53MY61g2e0g+WojLNMWa/zmHvwj9Jqz/RRIros62bCFAsZ3y6/62ngqSDRsxtWZ4IaMIBS1ySLkl0ofJYC884xmELq7ENtMVAmNo3cl18UclZ5c6uwj3cYcNPWkpT85rYfFdAwPKtCvAdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQ8WMu294K7ivZV/DoLabS0cFlftdL+h6xSvpm6huHY=;
 b=FMb+Bt8P9Oa2VAHpg5p7zG2HX4S9aUpLsLMjiPK5bt2TqdabAFT2iSecEAfbZ7JG8IwzGh9C3+tNB0zi446/muEf9v+v7S0fs83HmQKPNq1PBV3Rye9uvtUxOnKer2dG2zdyaL+o+4iOP5UhFhlAzdH8ahwlI6WkEliLGZ8evuUp2hmv3T8QUvMu6V8Ik4xD1ubd5r80thlLUaTIKG4VP+h1j3iDTwOg52UF4YknYRpFVm5gpbAH3197kxQFqX9qvjpANuTU1XPaEoGiM4q+uFn1iUfgGAIUrBHN6JM6Sg5bOPRj9iZKSiod7UQ0q54m/3jl26d8xguvPEtmy5kXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ8WMu294K7ivZV/DoLabS0cFlftdL+h6xSvpm6huHY=;
 b=LRhKds8qoSqtBcaFdRGQHvoMsKLBKs1rO9qwGeKK57Nhitl53Klx6ZLt2UbuXeRxV8XllH50bhivbZQSZRDbMcmtFNaBDsNaqbhgdMh3h1H4tzomi6ZrqJcCYOGUZop8oICaogxk0pi6OuqC2iTc+/k009A7WXeA2JSA9LO9Ugw=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 (2603:10a6:b10:109::23) by AMBPR08MB11937.eurprd08.prod.outlook.com
 (2603:10a6:20b:761::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:30:29 +0000
Received: from BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62]) by BESPR08MB999898.eurprd08.prod.outlook.com
 ([fe80::d62a:5300:bc89:9f62%6]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:30:29 +0000
Message-ID: <35d6a7b4-8909-4b3e-98ca-0a94081886e3@arm.com>
Date: Wed, 25 Nov 2026 17:30:26 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v1 09/19] ACPI: extlog: Report errors independently of RAS
 consumers
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 Dan Williams <djbw@kernel.org>, linux-acpi@vger.kernel.org,
 linux-edac@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-10-pierre.gondois@arm.com>
 <20261124050045.GOawUZ_S5imwUOyh8B@fat_crate.local>
Content-Language: en-US
In-Reply-To: <20261124050045.GOawUZ_S5imwUOyh8B@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
	BESPR08MB999898:EE_|AMBPR08MB11937:EE_|AMS1EPF00000097:EE_|PAWPR08MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 981fc9e1-5919-4c2d-12ac-08df4b117e9b
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|4143699003|6133799003|261009223027099003|22082099003|18002099003|3023799007|11063799006|56012099006|10067099003|261102123227099003|261028144727099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info-Original:
 /JvktHSMhkFjEtPDBuy1SOy2R1HyOEr0I0TKSjLaJUhrOlmvu/lCU49WN7LIkLn+RTHNHI+cZBacscp+z8IqC5jlS8l+/zdIwfDFBYRDCBHgAeDXSJ7Ih8XdXylmxCgR65pQ077dK5w/YhttkrRg1AxvnPJBKu6iK/6eycdGcmvHtKGJxjtrWx9tRXipLA89QrSMhQT7ZhwVlK+wj5lOtWAAWhyt/Nkp83fpjiamOPfRVQ+RBSEG2jhSbNBiEeBvh3ugGwvFY7psnHwIhxNXDd3I6UdR4AK4BVhiUJ4a08ZpR3L8CPe0miUzLih5D/R52pLzbPFhyCAHylhX2MWgdkkcR8Zk33Bo2rjWeY0c6pakqZTgLinBSLXSHi8e+OhWeu/1xv72D+Y2qomnnZ18qNMUfj8R0KjjpLZONn4B1NASoqPCP8zat2ClamDzEB/4CReM0cqiWmf8JlEB6/phNvrCqEWORJjkk7VhK/EvwmPM2kTG321l0E1I6HpNoKhlgxwJZ1WDYDFX7sEGx1CubhD5Y9ENM1Ta1GoGjeozHmmDkx2xt9clH717tNK+eRdj7qQQmVofyqZdOHpfjDXlwBMSDDC72gBzGFHgya5/lkzxKpWvl7eXFF4LwzP1ibL0
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESPR08MB999898.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(4143699003)(6133799003)(261009223027099003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(10067099003)(261102123227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 ABZDR96MCqvzprOWvU6AKsHfgcqH8Gk8tmuE0IwlUzNE18MPcsgOkk2Qg26ODB1tbqz9ZpgJaYAk0VHZdW8Zj6DjktoBmo/5AN19rsOL37kGdIZQfpdLPz+bx2/IODrmt4qiNXZ8Wz5WnpnfYXWis1qZ4wVQ/DsIvXnDcZQP9WVffmsHMwaLWy3RZUYHZgGkh47QxhRDxiQd40zycOMeHdJ2W2o8ri4/TTIjnxFg0xPVHJvgxtMoERQ08cMZMctzybh25sjqdmlqArjNOi91m2S4t4YPoZmtaqFGKwGk6Ucz53hPPgw/TwoUOqsLDTo/fgkrZXZGIywPjVdUmjqDUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB11937
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000097.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	71c5ae61-3429-42f4-f0f3-08df4b116b0f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|36860700016|23010399003|1800799024|82310400026|376014|7416014|261026121527099003|261028144727099003|261022075727099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|22082099003|6133799003|261009223027099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vp32oVhEDGGEN6BGN4y00WdpC7Hzsb2Wd6PECEsLEIw/nzxIWN83GmGli1IV9wVJM1Xvxt6Y0AL5sRRN6HwRrOTbxQQ9e0NoGkBbYZzFwM+ipJrQobeKP0EkjNGGgRcZlRboFgd4W9zX+v0SQQbFbIQppvEHdg2UHAfMga++XCE1/FIm+bAqmYqkZY1/i4DlecWSy77QMvgayKAzTOVIaNgFBHDMXXw1D/62M59lj2e/8oJyULrZ6DC1iJ4F6ZfEEF6lr5bMUtl1ybC9US+YNyzeoJEftG67nGTrt58j8cohUl+4f/XZ8duAW0hIPZ1f/cWYus1tWVD6xRf8COdiqT6jry5YwrpqU4qibvo9HH3pUoiJ6WP5VaHklqbOvZOXur8Gz/t6fJbV/FuywDJz4w80ApK/9Gr3udd3m9tVw9cLnwoH7P0T8KAnAbm5b3ACxO632/cZQhekBVBBG1ojrkvbPFEjydCy5avxayse02biiKjL0BYo9YXmAg0dWtjt4nRIh9uP/7ODbw22P4buRVbW1ghupS8Pk7HuDkVIgyYGjuRbeR+CuQYSfnkewE8jIF8ZfXSUcQWAOrJ2n3uoeZHRhUEBgLbaUhGa5hDvIAG2HfObmXmOtuY7ETwqa6GEJvTUBlXELPBUhoBlJWPSaUqpb47kmU65bHFLKO7lAHU=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(7416014)(261026121527099003)(261028144727099003)(261022075727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(22082099003)(6133799003)(261009223027099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x3efhjRI1dD2koAfSIEMZfvJT7dJUIwjgXphri0ahv+SD43yHb3Q710jUe2aherjVy2EkMm7W/SZ6irFsH4sOQcPfT4pliHW8M28vQbM0CYg2E4TcH1ZpQ5FdjtVh3EQgvs7ZEN/+HI9tM7Y6508cCNUb/AWLQzzLCpuBEmKqEgoqCZo7RJ2Yx5g2e8iX8p4OKzzssongNFq83AYOB391NuOpi46FbN8+5I3vgNMgB16Bhef8nLs5obeStaYFVg9OSEwevrlDHmyeznDgAbUeFSFpcNXXQnIvQzCfMMFmwxPT7iPoP30bkdsID5YT9p+R6TQH0mHAhzbcsGsc3iOcroXs91S6h9yLEsb2acNInzH/VjUkBUE+ZMKePjcb46KusFacW/M0PLiRiZS9oA2rfILTadRkrXr5oqrXETukV87wll4G4pdGAvNJ83w547v
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:31:01.9879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981fc9e1-5919-4c2d-12ac-08df4b117e9b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000097.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11512
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/24/26 06:00, Borislav Petkov wrote:
> On Tue, Nov 17, 2026 at 12:10:19PM +0100, Pierre Gondois wrote:
>> The RAS consumer check removes:
>> - trace events when no daemon is registered
>> - CPER console report when one is registered
>> This ties tracing, PCIe recovery and CXL protocol delivery to daemon
>> registration, and can hide a fatal record when userspace cannot process
>> its trace event before a reset.
>>
>> Remove the RAS consumer registration condition and:
>> - always emit trace events
>> - print the CPER record only for CPER_SEV_FATAL
>>
>> [1] additionally suggested to have a cmdline parameter to dynamically
>> update the above policy. Keep a simple hard coded policy for now.
>>
>> [1]
>> https://lore.kernel.org/lkml/20240521183913.GGZkzqUSN1hdE-_OEY@fat_crate.local/
>>
>> Signed-off-by: Pierre Gondois<pierre.gondois@arm.com>
>> ---
>>   drivers/acpi/acpi_extlog.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
>> index e09ea571c32f5..16a16b12d8ccf 100644
>> --- a/drivers/acpi/acpi_extlog.c
>> +++ b/drivers/acpi/acpi_extlog.c
>> @@ -208,10 +208,9 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>>   	if (cper_estatus_len(tmp) > ELOG_ENTRY_LEN || cper_estatus_check(tmp))
>>   		return NOTIFY_DONE;
>>   
>> -	if (!ras_userspace_consumers()) {
>> +	/* Print fatal records regardless of RAS consumer registration. */
>> +	if (tmp->error_severity == CPER_SEV_FATAL)
>>   		print_extlog_rcd(NULL, tmp, cpu);
>> -		goto out;
>> -	}
> So after rereading that link, we had this conversation back then about
> reorganizing and reworking RAS error reporting and Dan (may he rest in peace)
> wanted to unify and dump all the old cruft - especially since
> ras_userspace_consumers() is not really used anymore. Apparently.
>
> But what else uses it?
>
> This is something other luserspace probably relies on and we should probably
> do our due diligence and slowly deprecate it with a warning splat but not just
> whack it unceremoniously.

This is effectively slightly abrupt. I was also looking to get some
guidance on how to proceed for this. A warning message can be added
in a first place indeed.


> And what I'm missing in all that effort is the big picture. What are you even
> trying to achieve here, what's the point of all that gymnastics?
>
> Unify GHES and acpi_extlog? That's it?

Actually a big part of this patchset is effectively just trying
to unify GHES and acpi_extlog reporting (for Mem errors in particular).
If you prefer to have separate handling as it is right now, I'll go
in this direction.


> I'm sure there's much more to it than just a plain unification.
>
> Probably CXL-something is going to use this too eventually?
>
> But I should not be guessing - I should be reading about the big picture
> somewhere. No?
>
> Thx.
>

