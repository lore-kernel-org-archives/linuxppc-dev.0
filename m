Return-Path: <linuxppc-dev+bounces-23666-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE06EC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 02:11:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvPqN2Rf3z2yN8;
	Tue, 07 Jul 2026 12:11:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783390304;
	cv=pass; b=eCQ1aBr6oNYeiadjoQ+vI3lWWGZmQo40KX5Gk88hxSPKp6iIIJmzdBX1h5BkWoxUCjX9walJ3GVKrgzhurxl1MHR5BAk4UgYiJGTf6PA90v6TpSmF/pPcGPjwHCTtanJxIkUP82I/jT5T9HyaNGzZT04Pf1CfZDN2wjlgud3LEO8PDzHhPMFlVJuOUTz6/9tL2NdoMTwjEwkv3O+EDvfhkpBHJbnANdOnT4012Zzz+N5JvJMsCivbHeC+8HkV5s3PCGlLnA0aAH0XIXNEXQw4HN0rBsmhssBL3SxdiCMOWOVh3XFjU/Z80dmdQfbnfIfBI/7f3G/op7xpox6rqanhw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783390304; c=relaxed/relaxed;
	bh=OZWTKtclRrOfAi6ihxJKjALnLRbRSlyjEScPsGFqTuY=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=i20Ovph9sakoyj+ZfrNK6KUulYoznZrCHQ2qt0qAAu3iWeN1x+HSIT/IfCvPlw9P0RRgnVrEgcNzViU2O5Y8fnnN5TsDJECBhVDSpLH1E4tWVO7EXebskEXNV59qk3g698VGmj9dm2S/qk5wFuPL6GDzwzF8oovSZEyf8RPOH650hQ4BUNPUn8FqiJWp8nKlVcLlp+9g7mHMN8Np8jwydOXVXx84fpkE7ZPjAdsM+HWnBEouAlcOwfXueFgsbDI3EZZ4hrITk17i0PR1XH2hgcc90DPQm+tlUzjFv3aORSygS1QWUvLy/QfSWL7hthbV4q1criJBFFNPO4QKbtn30A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Rqgyb5dt; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Rqgyb5dt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvPqL51VGz2yMm
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 12:11:41 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wto1kG7x0lEigIZjZ69KzWs14cA7cKiTp/PLlUYQ1SbEn6vaSZvcPqgLnvs8uwlKZqvcSYGJhRpvFX5UHgIHDnncQCsBSQjYfQjJVguZaHEdE87aDk3nE2nrAKQqqQmFO4KsePviBaZmU6V9PPCdkT40T8XYYrNkLiC98LTc7zphww9NBz4YrLfAYTa7HhQQzL8fBCq8QlxsI9VxcTUvEc/OcTzZEBxSAy0VPiXnG8LzWHLkoXoMMmax6mc88IMZTiEzYoACoz/7vrJL1B0RBw811K1HfmjUGgn5MKC874AbjePd3kq5OoOMXCK6Er0CbfeE2RY8JSZsAPkEWp1dFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZWTKtclRrOfAi6ihxJKjALnLRbRSlyjEScPsGFqTuY=;
 b=rOp17A2cjBZEQEXbDH2sBM6PvUTJtENgAj5XN8/fkoSg6bAFrbdy5Y6OHlZiiwBMYh9GdhXLB+FPEevN0ewpRoWB7XBrtocviJ8FKT5r9QUewzAcHYkasjQpkysBZ5slVb9OMqsGbnYMOtDzj2WjxvpMekP/iX+Ci3Ru0k44y9xq3UUJWANTOB7V/4JZT+OmaSI1vlNApSXNSKaIaw3RDSSQSIILaOYmHbjVl9EnuXNmZaKgMZ1sBdIC5g1mp08ZB+Vr53zB44yzjNwAvwxmmmOTXZv0lp2ATm0cl6pWBfLEbCnLBswhE+tzTPxA3Hu2vkhoAvYfEFQTsMn1hHdC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZWTKtclRrOfAi6ihxJKjALnLRbRSlyjEScPsGFqTuY=;
 b=Rqgyb5dtBICsv78jQL9CwbjetB2CWZIlnhEcFGW1C9li+Ru/Uy+5fcKr6zrgltXGzrsIT9vMr8bMZssBqUgNwQGhb6qwRGbNRJQQtGQJURWS00Y7bBaPCYRCivowXwIJ0y+POE3CPVtBs6JzNlSzoT+z9aUcEJnL3CaluTQeU3AkbAVrJMv1FqmGq1mHhXPUsHPuzFAEflLIqRz9Z/gSfROp3V6fJm7o7ld/RFlNgV1oj7u610vnR1FRoZkoZryJ2/ABNDr0exj258xjZxGp4OD4zM2TVCaeOwUzd/c+FqTBPTHawE3xLuapQa2olUY7dc6YqlmJLzBQA0MO6p5hbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 02:11:13 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 02:11:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 22:10:32 -0400
Message-Id: <DJRZ2QCEIVA6.1AZF5S891NKS4@nvidia.com>
Subject: Re: [PATCH 02/13] mm/vma: update do_mmap() to use vma_flags_t
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
 <e0ac58ad2b88ff7e2f0024e3286b2e786f79ca32.1782760670.git.ljs@kernel.org>
In-Reply-To: <e0ac58ad2b88ff7e2f0024e3286b2e786f79ca32.1782760670.git.ljs@kernel.org>
X-ClientProxiedBy: CH2PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:610:51::33) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY5PR12MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: a46e7ba9-5394-4512-992e-08dedbcd0520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|18002099003|22082099003|56012099006|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	2eWtQE73CZSQ5v6QF5lztmsrSjPVumC5SvOZh5US96jgFfWckz/iaPIzlQl0IN4B9SRX7EbdnQoB2ClMvwl3QnklzfP+cGwQ0U2ns95Je2jZD/TuCMCwu5dHfriEqwM+rRiG4co9f5lLSn4hRTkZntECv2ITNa8uwsi1FGDLfLh1NgZDL34zp92+yucm7lzpv7R4c98FmxtXF4I19kqh/5gkPp0amOxupLrfWChopAaqL0WnwPeDgFuz7rp4vVYJaLVCAG/zzlIxASIecZH/ps72iemw8N49bkbCOZOtH7el24e84fYs++uhUvTUqxevuoamYcqyFaoptWPsZ9eHTMpXIXHfHbrbsTynVAdpH/zn72gFl0wtqm4h6bcRq8wDitcVQXoFoO/5ZnyrpwsLFlcQ2dNt30h0ZR6I3FuD1F7wubUbX0C2AmDmHwe8Y50zhllp/1es1GAb770bORFA+5rggFnE+F5ijvSsNz4S1fZ67ntonEVJ8R6IWT7YOBEVAzmpG0n8HWcncN/W4BU9qZgFzJSpmeUmWLfLt18PuVgrLucwmPQqb1nAf0lS76MIGhy3CYNWcJXXK9sSCzWA8+LZmqPmuiC5l8YNyjOf0m48gbj79Ur5Fsmi+Onn4al4JTWG3RoHqS4h+19gFkHjf0A6Bmz0T+OTx8atHnXM2eo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2tKU2lvSDV6bmNzb2V2alBFSURBSVhXcW54RHhWWklmYlFCYTVOZzdHaHpX?=
 =?utf-8?B?K1NWbjNDN1dQRW82Y0ZYUVlTc1huSTA3RnNQMmk4TTJmT1REVzdmcnBqTHo0?=
 =?utf-8?B?MTJzZk10LzdsMlNuMm9oWk5FOFBpWm10dGgxS0dMekZZbnlPUDhwWFFrUzdk?=
 =?utf-8?B?azhPMktCbDhjNDRHWHRxSk1KM003RXFPWlBNbmk5OGljL0dKTjJ3cXp0cmZZ?=
 =?utf-8?B?WlAzd3l5c2cyMXVOdTRmN0l0UUVUbzdrakxXMTV4QUtrSU5ZemdUSUM4blJ2?=
 =?utf-8?B?Z3BVTnVYSTZ5TnpBOEpqQlA3LzB6Rm55Q2FDUWFmbnNSSitpekR3MFFIazhX?=
 =?utf-8?B?NlBSa0hYaUpRWHdrYXg1Sjd2MjcyZlZ6dy9hN0wrejA5dzk5V2hjYXFIMlFz?=
 =?utf-8?B?bUt1SWYwb2VZY2o2eS9qQ3ZUSXpCWHR6SHBoYkhaOEpYNFp6R2VRdE5URGJs?=
 =?utf-8?B?dkFtR0dybjdnS0FUWjNpSWVCWmVyQ1RFVGFTRVZlYnd3MDVlZGZ0ZU9sMVNm?=
 =?utf-8?B?cGJkUmxIQmdGSDZCaTBNUkZoN0JlS3Iwc015TjhBYTlDL1dud3lEdFJsRzZC?=
 =?utf-8?B?bjRKSkwrWUtlNWdQZmRYbTBxNTlYVmdHQ3hkUWNZSGpqN2duMUVrdFRSSkNM?=
 =?utf-8?B?M2l2RVpUUlRqUzNYVzU2T1VFaGFJdmVaV1Q3OWpBVDRhSmxpbEVaa1ZrbWNw?=
 =?utf-8?B?MlhNUDJsQUh4b3BndHNFZGFmYkRUOFYvbFM3NkJJa2JrRUxCZWNjSkgvZkVr?=
 =?utf-8?B?OUp0Sit6ODlDMmEvZ1UrTm94T0VEaHEvYmRuZGtrREptTXpYbHVZZTNaTUNL?=
 =?utf-8?B?SS9IY21UWEJ5eW43SnpEamVCeGNybGZKQXcvZHBlSDJiUTZFdlZEaUtUdS9C?=
 =?utf-8?B?ak54OVRxWlBuWWNFOVpEVnlaN01iZGZ5bmtPOFRwbWtaRTFZc28rUkFQMUhp?=
 =?utf-8?B?dSthYjgweWZjaWxBSytYQUZFM1AzSnl3bDNPY2hxQXovVGVzV28vRzJ6ODhM?=
 =?utf-8?B?NmJ0a3dNeXA4UE9uRkVQZjU5Z0JqaURMa0l4OGJHS09oY3dpUm5DRkRJSkcv?=
 =?utf-8?B?SWpxME9OMUJHVnBkYXZaWVZNOE5oTnNXVlBNSlg3aUltN0FIdFNLeFNaYTd2?=
 =?utf-8?B?WjlWNGVXQnRuVkRaK3FuTXU5bVc1c2xNMFdncjk4MEdPN0RDSEhZMEErSXVn?=
 =?utf-8?B?ZktUTnZzYXJQUUZ4SWVseHpaLzhHc3UyRisxTnIrdXI5WHFtOGhwZ0QvQTA1?=
 =?utf-8?B?SEcvNk5xUjMzVzhBWWVsYjB1RHVPbUZ6R0xackxRNktncWIwY0xqcTE3aWRv?=
 =?utf-8?B?RkdmR3IwZjF6UFd4VFQ1YWJoWUYyT2FNUU4zZ0tmZWtENlVSOTFRNTZIc3N3?=
 =?utf-8?B?S0J2TzdvRS9OSWtLeVRKbG5JQ2dqV2tRVGFSYUhXYWc4c1NCVlVjbW9rRlhv?=
 =?utf-8?B?OG5FREJEZjJHc1ZyK0MzckdoQThnSERaYm0rdGlqRTYvUFo5OVAveFduWkxm?=
 =?utf-8?B?Y3RoNVl6ZVRHRjBEWG8zdEpXMDB0UmtOa1prUWpKenFMVkk1Y2N0ZXc3c0ls?=
 =?utf-8?B?VnIzdWhZWG01ZXJCQjFhdUlEMlE0WGxIWVVNREJpcUhLNHhLS2d6clltdXJX?=
 =?utf-8?B?S3RqMEpyTXFQeUJ5UUU2WEJKQnVqc0pycjdXZVRzOUk4d0pjWEt3L2NaUEpw?=
 =?utf-8?B?VGRBVjBzZU5OS1RMMG9NckdoekxOc041Y1pJWUo4Mmw2NXRNV0o2SnZXdHNX?=
 =?utf-8?B?MFNnM0pLbU1tZWZiWUFxS1AwTHNpVE9jQ0tDY0Nqd0xSWVYzQzMyQmpWNVIv?=
 =?utf-8?B?cFhsYmdZdHBIamVNcUJOVkYvc2JrUHZGZUg2QlR2K2VjMmhObjFUMHkzUkw1?=
 =?utf-8?B?cUdNYW83N1phOHpDRkhjd204a2V3bFk3cFRud2FVekdKcWFBelBSSi9lYnFR?=
 =?utf-8?B?OHNBcjVnaUljdzRlYW95a2p0dEp5ajh0d2tLVFExVWtJUDFTZkFGSWxSRWRE?=
 =?utf-8?B?dXlLWVFWYU1IWi9ucEx4bUVMZVJNdFpwbERmOXROWjZWSXVMQnQyNDV4TWZQ?=
 =?utf-8?B?ckQ0ZWY3eGlscFZSSm9lREpZTzJJNExuSnJmNHdNUmhYZGVMbS8rU3FROER0?=
 =?utf-8?B?Rkd3VHhqQW1uWGFtcmZMSjR1M2hyNHl5N0tuWEFyd1Z5NUhZaWpibHhZOXo5?=
 =?utf-8?B?SVArbHRFcnVBVFByVmEzWUZzZW9qaVE3RTIrTTVUTG9rUExlbE5jcE1GS01O?=
 =?utf-8?B?bXdvNnZSWEFlbVVET013VHVyWUFiY1NDUGRRdUtQWVR0OHpPM0ZRK2xIb20x?=
 =?utf-8?Q?JDrw2oFXXOPm0reTxK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46e7ba9-5394-4512-992e-08dedbcd0520
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 02:11:13.5375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkW8PLSCAM9OoBbuQEoPHlbtWH7slCizpMnfj3r3at8+bkAV7ft0tvr+nIf15jXf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177

On Mon Jun 29, 2026 at 3:25 PM EDT, Lorenzo Stoakes wrote:
> The core do_mmap() function accepts a vm_flags_t parameter which it then
> manipulates before passing to mmap_region() to do the heavy lifting of th=
e
> memory mapping.
>
> Update do_mmap() to instead accept a vma_flags_t parameter, and adjust al=
l
> the logic within do_mmap() to manipulate this instead.
>
> This is as part of the ongoing effort to convert VMA flags from a system
> word size to a bitmap type which allows us to unrestrict the number of VM=
A
> flags, as well as gain control over how VMA flag manipulation occurs.
>
> We do not cascade these changes to all functions which accept vm_flags_t,
> but rather use vma_flags_to_legacy() where necessary, specifically
> deferring converting calc_vm_prot_bits(), calc_vm_flag_bits() and
> __get_unmapped_area() to vma_flags_t.
>
> Also utilise the new vma_flags_can_grow() predicate which correctly handl=
es
> the case of architectures without upward growing stacks.
>
> As part of this change, introduce VMA_SHADOW_STACK so we can correctly
> handle the case of the shadow stack not being defined.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
>  arch/mips/kernel/vdso.c |  4 +--
>  fs/aio.c                |  2 +-
>  include/linux/memfd.h   |  6 ++--
>  include/linux/mm.h      |  6 ++--
>  ipc/shm.c               |  3 +-
>  mm/memfd.c              | 15 ++++-----
>  mm/mmap.c               | 67 ++++++++++++++++++++++++-----------------
>  mm/nommu.c              |  3 +-
>  mm/util.c               | 10 +++---
>  mm/vma.c                |  7 ++---
>  mm/vma.h                |  2 +-
>  11 files changed, 69 insertions(+), 56 deletions(-)
>

<snip>

> =20
> -static int check_write_seal(vm_flags_t *vm_flags_ptr)
> +static int check_write_seal(vma_flags_t *vma_flags_ptr)
>  {
> -	vm_flags_t vm_flags =3D *vm_flags_ptr;
> -	vm_flags_t mask =3D vm_flags & (VM_SHARED | VM_WRITE);
> -
>  	/* If a private mapping then writability is irrelevant. */
> -	if (!(mask & VM_SHARED))
> +	if (!vma_flags_test(vma_flags_ptr, VMA_SHARED_BIT))
>  		return 0;
> =20
>  	/*
>  	 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
>  	 * write seals are active.
>  	 */
> -	if (mask & VM_WRITE)
> +	if (vma_flags_test(vma_flags_ptr, VMA_WRITE_BIT))
>  		return -EPERM;
> =20
>  	/*
>  	 * This is a read-only mapping, disallow mprotect() from making a
>  	 * write-sealed mapping writable in future.
>  	 */
> -	*vm_flags_ptr &=3D ~VM_MAYWRITE;
> +	vma_flags_clear(vma_flags_ptr, VMA_MAYWRITE_BIT);
> =20
>  	return 0;
>  }

This function alone changed its original behavior, since vm_flags is a
snapshot of *vm_flags_ptr, but after the change this snapshot is gone.
But its only caller memfd_check_seals_mmap() gets vm_flags_ptr from the
input parameter of do_mmap(), so the overall behavior does not change.

<snip>

> +		case MAP_DROPPABLE: {
> +			vma_flags_t droppable =3D VMA_DROPPABLE;
> +
> +			if (vma_flags_empty(&droppable))
>  				return -EOPNOTSUPP;
> +			vma_flags_set_mask(&vma_flags, droppable);
> +
>  			/*
>  			 * A locked or stack area makes no sense to be droppable.
>  			 *
> @@ -515,23 +527,24 @@ unsigned long do_mmap(struct file *file, unsigned l=
ong addr,
>  			 */
>  			if (flags & (MAP_LOCKED | MAP_HUGETLB))
>  			        return -EINVAL;
> -			if (vm_flags & (VM_GROWSDOWN | VM_GROWSUP))
> +			if (vma_flags_can_grow(&vma_flags))
>  			        return -EINVAL;
> =20
> -			vm_flags |=3D VM_DROPPABLE;
> -

Lance pointed out the reordering of setting VMA_DROPPABLE and checking
of can_grow, but these flags are not overlapped and there is no parallel
writer to vma_flags. So it is still no functional change, just not
mechanical changes. :)

Otherwise, LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi


