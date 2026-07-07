Return-Path: <linuxppc-dev+bounces-23668-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341DCC43602
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 02:30:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvQDx5QsQz3brT;
	Tue, 07 Jul 2026 12:30:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783391425;
	cv=pass; b=np7jWOI0E8vPh0uEJqdzaPrLx3zUExlcX/3MPRylFSiP6oqft6aIgzcUNIZLyLQ2iAdnzp5mmQbL/bVMf7BPBIuUCZOFSLoMx0DDFfLA5dpgT923JJC7A1LQgM6vJdzi5zUHKa6spyYW7Q0/7hwMFjx6r3qjrkfMa8alY0T+H+95k9KSnBpkCMyoM8TCJ6ShZhjZre95U7kLUakyhiHOt31zZsjruYm2vYpk5lxCvGcet/AQTOYV+BPNMrvqGuoCXZB7Q5F1BezFYmtqUQzdr3jN4lw48qGTGWRJC0OiPAkU6cHpr9en1GuqIpGiho9rIzUDjmtGUhopX0rTwOFpWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783391425; c=relaxed/relaxed;
	bh=G5SDIdFLoYbDOHAIakCAUhsVvo3Qdgdk6RXUmFO83TU=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=bVhT/ZhNOT584BnrHnM1Bjn2iqneaby6/hiDctV5ZFN/nHBdzSO8/B9LpJQO7ZRiUNRmU15N+tA5nzl/QByu9v3hM4sIZEXTJcYxKWzh2isIltzaNI4JL1OIHZuWv9iAZWVMjqsmUKdPPCqPRaW4g2VrFALbjJFkgbdFHoWdElNMZ/1DvVFXnenpVAQbwqbXnuDDiHbwqZTWBhtsb3taNxz48dSWdmA5qDOFVn5vgXIirwXdilTK/dWhJu0YB5nGloIKVCbEmRSU/vR5RyZfNbV6SATMTv0ZlQ6+1Ybv9DMbdaoR8kvcuAwbZCAhJ2jWgqQxxflGGVHDjT08IKLtDg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eJi13RbM; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eJi13RbM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvQDw5qPCz3brN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 12:30:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzpRGdZ757zSn/vBzw7mLX/Dcw6yEnHlsf9xKmN2gwbYb5H8senBU8bWgX49JfMmXeoasFvlggyp0qNrA/5WdxcG2KnUTorZeFIQgQ+aktnIlvnhXmfVmkDMAwa+5JUNZC9Cwr+sAkDMUOhZ1aDcKkOpjuw89ZFQPvKKML0JPC5nSBupBjnBrHqopP2if71tNGmVV6c/+DRtJR+eFm2u5TphS1cjYxLfkrQKtgdsnr1H/qSUeB3VjYKpr+kBuu2S0bH4Id7ShzlUK3H2fbURgc81j8xx4Y9GtnEcVrTFwH4hjNPvxqBPDO7EPX2cJzvyDRX0yJA8xsvYLcVxBB5mAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5SDIdFLoYbDOHAIakCAUhsVvo3Qdgdk6RXUmFO83TU=;
 b=d/L4arIpSCIZ2cG//K6QIS4Eq75ZnFdfPyXbNabScvNwYRimUPGha5m7tevzOcTzTT4CYeSvLgNOJJ5HzZwIE9KYeXNvSCw4pno/w5hkQMzAONfvPpB79qiMhNvcutwqCU0HgwgWVkOl4B+wBR1hNNNSnNj79CxDiDTD0IzYcT7Towb08RxxV2WbAz0ZNFYcPsvOiybJioi5bbzSyOgTD1A+fyWObz9Byb2Ft5mSaQ5bxmvLs9VM+Hp4DY/FdN3+reSYAf+Godc2CMm4JShr55LmDOF92B4ook2QJe27JWlMkZyRmb5hs/DP7YPaPNScJRXM71IYstzZpoamqbBBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5SDIdFLoYbDOHAIakCAUhsVvo3Qdgdk6RXUmFO83TU=;
 b=eJi13RbM9h39ZibWYLZkLfbwMabfTmRDByyT16y+evTK2vpHEpvzjqbDftdNqIrU0ZiAArYwjDJ3k8OKG2zVMpeIeBstVKAim21tXyxT1g9lL43NhvSfrwWYVbAeW4eok15i/ELY4nhq1SjTLZfkiFVIoMOutGWj4DmyquPlkFaU92t5VfI10hmIsbOwBy09zyeqlsuET1DLiAMAktIYG9qPOjDHqbafq1FCkE22Pe1XUUf28RwmD+h2u0tmry7GeFhqCYMpN8/uXJXdstY8zu0l13LrX0DuFpfJNR903z28j54VWfHnOBBa9HBewlWBIwOWhnUSgLcktmy+e8Nm4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY5PR12MB6275.namprd12.prod.outlook.com (2603:10b6:930:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 02:29:56 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 02:29:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 22:29:15 -0400
Message-Id: <DJRZH2CUI67Z.2MQC3Q65RXJS@nvidia.com>
Subject: Re: [PATCH 04/13] mm: update generic_get_unmapped_area[_topdown]()
 to use vma_flags_t
Cc: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Lucas
 Stach" <l.stach@pengutronix.de>, "Inki Dae" <inki.dae@samsung.com>,
 "Seung-Woo Kim" <sw0312.kim@samsung.com>, "Kyungmin Park"
 <kyungmin.park@samsung.com>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Peter Griffin" <peter.griffin@linaro.org>, "Jani Nikula"
 <jani.nikula@linux.intel.com>, "Joonas Lahtinen"
 <joonas.lahtinen@linux.intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Tvrtko Ursulin" <tursulin@ursulin.net>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>,
 "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Sandy Huang"
 <hjc@rock-chips.com>, =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Andy Yan" <andy.yan@rock-chips.com>, "Thierry Reding"
 <thierry.reding@kernel.org>, "Mikko Perttunen" <mperttunen@nvidia.com>,
 "Jonathan Hunter" <jonathanh@nvidia.com>, "Gerd Hoffmann"
 <kraxel@redhat.com>, "Dmitry Osipenko" <dmitry.osipenko@collabora.com>,
 "Zack Rusin" <zack.rusin@broadcom.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Thomas Hellstrom"
 <thomas.hellstrom@linux.intel.com>, "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>, "Helge Deller" <deller@gmx.de>,
 "Benjamin LaHaise" <bcrl@kvack.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 "Muchun Song" <muchun.song@linux.dev>, "Oscar Salvador"
 <osalvador@suse.de>, "David Hildenbrand" <david@kernel.org>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>,
 "Nico Pache" <npache@redhat.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Dev Jain" <dev.jain@arm.com>, "Barry Song" <baohua@kernel.org>, "Lance
 Yang" <lance.yang@linux.dev>, "Hugh Dickins" <hughd@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Jann
 Horn" <jannh@google.com>, "Pedro Falcato" <pfalcato@suse.de>, "Kees Cook"
 <kees@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai"
 <tiwai@suse.com>, <linux-mips@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <dri-devel@lists.freedesktop.org>, <etnaviv@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <intel-gfx@lists.freedesktop.org>,
 <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-rockchip@lists.infradead.org>,
 <linux-tegra@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <intel-xe@lists.freedesktop.org>, <xen-devel@lists.xenproject.org>,
 <linux-fbdev@vger.kernel.org>, <linux-aio@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-sound@vger.kernel.org>
To: "Lorenzo Stoakes" <ljs@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <cover.1782760670.git.ljs@kernel.org>
 <cef55b19f86c110952f13829aefa4859db3a70ed.1782760670.git.ljs@kernel.org>
In-Reply-To: <cef55b19f86c110952f13829aefa4859db3a70ed.1782760670.git.ljs@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::20) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY5PR12MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6ebcdd-bf63-47bb-9a73-08dedbcfa283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tclAw8uDOS/u0aMNtPAvNk6Knf1cSRlVsE/rTf3au3z1vsNZx3i4nNOvahYaarK/foeav1xFBYYQtRmiINzpIR4GlvoOis0rEodCWrHWwRHiYPVAo8WuGfI3gOd73cfNAloZDe6qqt7ODpuCOeHdv4swVKJah38opvSuCvizYxemc+Bw6XaaVFcp0VLoQ4F6FqAuiccrV2X2XPI1TmWALS91QqhLuGenyttEKO7aqiTO6ZPKczfdUjJhoEtLWMtfb5+zqvllyTrzAnj+vpgzqF+Vq2DEgm1QBu1/3uSLTDiNrLruamuR8ZxR42YxsmW/3u85KjW4sA1N9X2KX7p4KbrCMF3AQmYumir8Wp9VV9VPCBPnpnb7dvoOpFDo1KvqC9PvMAOcK6pOsXK7EKumDQGpF2oGyb+SXUpjhbkyBikolAmXw6PjxJbSCBrypRsNtkVbWD5tIV1rfTKUK8dJd8jDjzfiSO36nJjVK4YRWuW1DsbhwqE11L3cKHffhxLl5ZUj7IdK2JpAjOjpZDrNivIvviGwuYnpiZioVCzdsqBw7ZdTSrv9I2JAahl21FQ2iee7KsgyFaeXYpqcyy7C6ikdctGI7t0Q7vFeLuKaoKdSF7T1lApWJTHGNwPof7Mza8HnpoAWl+xfZbvpI0u+In2lgmyukxkP/cwnmOxVqIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkk3WGsxaS9keEhmYml3Z2h4WlA4Q2VKTktOUjREZ2xWa1RQYUp4N2QrdEJo?=
 =?utf-8?B?TVE4bEM5N29iODZDMFdoR3Azc0hCVks2bEVqT1ppazY2Nk9icC9rNkl5WEdh?=
 =?utf-8?B?SjI4ZFB5aWhEbFcrSkw2S0Y5L2RUVkI4Q3d2TjlDbFJhTC9ZZHdsaXM5cko5?=
 =?utf-8?B?T2pOVHJ3UHd6bHlSUDdCMUpsYzRmTkROYWEycTlGV2ppemllY1BRY3k4d2FF?=
 =?utf-8?B?MHhkZVVPaUg4bWxxaHpkbnphUDk2eVJHc2xnMzcvWFYvVXhuNjNnRjJla1Zr?=
 =?utf-8?B?OHJmQytodURNb2prN2ZBWEs2SnZ3RWNYeW5mYkp5aGRsUmtEM1JaTCt6MEFp?=
 =?utf-8?B?L0V3OEJMMFFEMGk5YWVZNzRrQkVlT2RLRW1xY0c0NXZJQm40TmhUT3M5RVpz?=
 =?utf-8?B?RkpYZmpQcTZnVWh6cTNFSHFTNG9xcnowbTFET2dKL3psZmlVeHJNbWtnZDdo?=
 =?utf-8?B?Sll3NmV4RG05Sm9ZTW9nNlJpbExwcnZOeks3aEhaZy82bGZ5eitZUnM3WlhK?=
 =?utf-8?B?R0ExdHNqOVpLQURPR3J4TXBOT3F5Rkc1cnhGSXAzRTFSUEg1RmNNdUJSS3lZ?=
 =?utf-8?B?ZGFhdmJodFpqWStmWlQ1NnJFYVh2Vmx3eXhpMkRxeEY2ZXgvTkxKcDA0UFBQ?=
 =?utf-8?B?a0x3cmlMdnVTcUhmUndtK1RwRkJKRDEzT3lTSFN1dU1yOVFnNGsvZlRLdERH?=
 =?utf-8?B?RXl5NXpDbEVWeGhHdGxWSi92dWpVUWhJemZjeGljZHdpZWNDVHFkVFRNT3RZ?=
 =?utf-8?B?NTQ0dTFlQmxjbTFOQ01CcUVvMEZLNjZWaHFVNElwazZWb1d3d3RXeHBqS2lX?=
 =?utf-8?B?UDI3dFZZUVlMNGRGanRUR3p5WkFzZlNQUFpjbFlHREVMcUUrUDhUU0Y3ZXk0?=
 =?utf-8?B?QnI4UmMzUlMxMG1xVXFvdGQ5d1J2cTh5QTlwc2xzWmFBTFdCdlJDYldNdm9o?=
 =?utf-8?B?S0dkcGtENWxxVFROOTJmV1o2ZHJMdHYza21Sb05oQzRzTVM0RnNnamllSUEz?=
 =?utf-8?B?Tkk1NlM1QXdiL2VIRkFuaE5oYVp5N0w1bktoQm8zdmMzc3FURmFmYmpKNXBD?=
 =?utf-8?B?dDVBbEZOTFc5clJBcnB6YjhsUDFOUFAycXBpL2ZhOXBrdzRwVWh1VkpoTGRN?=
 =?utf-8?B?WmJlODkwNFdBeEw1OTArc0lKN0Yyckk1VklhVHZraGN1bC9wK2hYOVRnSnl4?=
 =?utf-8?B?bHJJRHgraVVoNzNDZWZmbnBOdVBLbnV4akF0eGNvUzB6TmJGamdMM00zMGNZ?=
 =?utf-8?B?WEY2ampxdHhTV1ZFeVdTWFJzdmpiU3FUOVJwTmtlbnA5R3RJa1VqV1V1d1lT?=
 =?utf-8?B?U2RrMzI5YWkyZjQydEFLZE5FcG84M1dLMTgyOWdJSFRYQXFWY1Zuazd5R0li?=
 =?utf-8?B?MVk4OFgyeWUrdFNEditCMGNNRHZIQ1Z2N2lPWm1xL1hpekYzUllvME9sbzZ1?=
 =?utf-8?B?WlVJZENQTnRmYjdJb3BnWVB4UktBRTVNVGV0aG9aOUVmTXpSSDBJbFY5Nklx?=
 =?utf-8?B?cWZFV3hYOUc0UFY3NHVQbHA0dmFuaFdSckN4bUFvdHRNTnU5WW1XMmhHR0hI?=
 =?utf-8?B?aWRpQU43VldwcUJQWUR1d2VDMTZ6ck5TYUEwVThFeTBqaG1lM2YvZEpXRmhp?=
 =?utf-8?B?TVNHTlF4RXBXSVU0ZzZnUy9Mbkg2L1AxbFEzbHFuYXIxNEtHcTEzUVFjS3Qx?=
 =?utf-8?B?VFllbXRoVkJFVHEwYXRDU0pkanZ4MUowQXgya0hrQVdzb2Vrdis2cHBJcWlz?=
 =?utf-8?B?WHFxU1p3TytYQ1k2NmpzcVNJQlNWLzFERGx3dVh4SFdwNmJGSzBxOFpHUk9k?=
 =?utf-8?B?ckZ1UmwwMnIzVWVDUElpUHptYU50L0xDM3YzQVMybkhlVWlKNUU3UWRyRElx?=
 =?utf-8?B?WnRxQy9JK3ZNdVhlbzZaR2daNFBlamZ6VWpiWTk0T2NJUUJKMnZuZkJBbElj?=
 =?utf-8?B?bVEvdFNCbnJ4NmgvVk1lbEhJRnAyeCt4NitVaWJ0UjNieWhiVElZVHZreENP?=
 =?utf-8?B?a21jajlQT0hDS09ZQjRtK0R6WWNJOWRIb093RlRjRDZ1NDdJTkV1anpDYTNi?=
 =?utf-8?B?UnIxZTQvd0JFcldOSWhhRmhrY2cycythbk1hTUZaek1aRHM3dU1WVjd4T0V1?=
 =?utf-8?B?L3VxZ3l3cnB0WTdBVXRya3hEc0xVVnN4bUtnaXhyYmR5dUwvWEJBSUZHck5R?=
 =?utf-8?B?dldGVzNpaDFuTzdzM2dnRVZuYk1zY0l6UzAvNnpkTnlYTTFHSGhlY0dSekVM?=
 =?utf-8?B?d0pkRGNEZFdaMHhwLzB6ZDR4YlQvSlVlL3J6aVpjNC9GTWtHSDkxNzlLUGRI?=
 =?utf-8?Q?wND7zKRGR8WfbZpe66?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6ebcdd-bf63-47bb-9a73-08dedbcfa283
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 02:29:56.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIOY0pzEGzhKPWD11iwEvHsQNPeERmU09vU4Ruy0IPd6ixsvMtAiayr8UYt0C99d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6275

On Mon Jun 29, 2026 at 3:25 PM EDT, Lorenzo Stoakes wrote:
> As part of the changes converting VMA flags from a system word size to a
> bitmap, extend this change to generic_get_unmapped_area() and
> generic_get_unmapped_area_topdown(), which also allows us to convert
> stack_guard_placement() as well.
>
> We retain arch_get_unmapped_area() and arch_get_unmapped_area_topdown()
> as-is for now, using legacy_to_vma_flags() as necessary to do so.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
>  arch/powerpc/mm/book3s64/slice.c |  6 ++++--
>  include/linux/sched/mm.h         |  4 ++--
>  mm/mmap.c                        | 16 ++++++++--------
>  3 files changed, 14 insertions(+), 12 deletions(-)
>
LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi


