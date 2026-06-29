Return-Path: <linuxppc-dev+bounces-23140-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ADBC43327
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 20:27:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpyVq4Wjmz2xYh;
	Tue, 30 Jun 2026 06:26:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782764819;
	cv=pass; b=GUA0VKoNcgNNeZHRSJuSzjHexYZKKi3qTrJDcyYc8KyJOccec6HgPhB2szAP8Mic4iRvEPLHDTaUEbrVLf1Mh2BfhzGMVw4ZwhLI6w0ITSOMfM/7GNHyQn+696rRu2kwdzPGogB+SzhQS3W43ZV46FkBajxqgwsNVGGS3Xtvktlu1pAm+Ggjch4i4UR3Lf0NVFomLHBQ+P8QRp5osrdmBBeojnQnAYhhqr+88WwmZ85dnIb+jHu6bT8gJKE1KimF9sf6mIn0KJIzlEXYssR3528ljw+2wqZ958WeUEQ8GZ3biOjo+r/QiPo3b3HYEVPM38OnzcjQ4Gb4YSEZU1MrTw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782764819; c=relaxed/relaxed;
	bh=UjOcawimHyWmxgix9NetNoPKlptEq1gcNWDAjaT9jQw=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To:MIME-Version; b=blatlF217MpY7XmyGNBjxa/Qhi+8VxkW55oTNCcclyKiFRZSMTdERc1+flnXx811OCTnD2QwR6jNu0j+0Rj6H8BGhLTjxg1+2NlQbS8TpWF7Ma1rWdANha4cryjV1Bj1woP/ouGI4VdpRcUTzo2+YnZm9XM7Wm95GeKnA3apRcvWPXkudVzN4ALQ94mDzrrFhaSsC0rPJHtTzZci8CqRVgOjYa2kqnd3jCGf2/ifFmJmyYlwOaR/6kiygj3fiJ/ZHMA3ZwvzqnqQmfa+NK+JGV0sfY7eo/GX+CIkql7hwSwIokYJDcBEBYAzVuV+2NQ6d6jruTxU3fPcMn+egEItuA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aYnFAIn2; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::5; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aYnFAIn2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c001::5; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpyVn0txvz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 06:26:56 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/v44OCgZVv8TnwMyFEqZ59yu11oCB/L8D/YmJ45y3NQvoZQNhrxzCH34Xr4RtJnlmGEbegSVMRmMjurJ9k44Z0/gng+ZdY6mFprMUoGrSiOIiBPpTCnIzNz7C4PAKic1QMjjhB3wrZhwhZWvYn8GEMWsnjwJCqvDm0xSVemHrfuoO+LWQ3P6OJXsI6Q7WguJ8UxcHY5cf3FpmmnpBsQWjSzqxFD3CQYu4gMk9u6t6uC1DIwIwB1teUbMbQf4Q8hZmMYkUC7uOHG7VX2amk9Ekjy/AEO+CuR8vv6qVeoSSMBMi4p0J6sHcCEnLZckLWf+ZiWQ2cdDcfH3MKASIkBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjOcawimHyWmxgix9NetNoPKlptEq1gcNWDAjaT9jQw=;
 b=ETjNpAbP7ey+4SFFarO0HFFa58CsUMqTPhTZ6MoEu77yNuv4XlJ7z3qHfH3wTBDxqWfKmR1eryM06/wAPJhYsEGSkpOH1e+zrVfLpV7gTfVNHMv2XWr4LoMAzE6xqFlTDtjubMihZQ4daGCdHxAcmjZ6U3ZkRMFN9whuNWqz+kx2MURGE9CXq2XBL08JCwvBzMyfIav1tWO3vSUJdC/R8nHwqSB9Q7xd7DobDUmWZsd+2fGSr41wxtOt00KtskVCttuCm/WLc+ss4CRZqD1t6b/yJQkHchvV77pB42Thcv1Czd3D2i/HEOuOd39PjMIdMgZqFPxRPF0ADL7YZuJEQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjOcawimHyWmxgix9NetNoPKlptEq1gcNWDAjaT9jQw=;
 b=aYnFAIn2X9xFXp3Fs19l/6YLTYATk0NbcZ68EnMprL3spbrD7OTb6WKPkVm3IDu+1b67fgyFwo2ywI5nr0JLH8dFvemEbfWOqMDPcJ0SRokU7U960JH25I7aq/aXIytsuh+SAvoaScfzHXZqJ1KLvbE0frQpLu7XQ81i5xO9wMFQM+XhAWzbrAMV6Wgm7KvK+uQlpFVY3NFDs9c80F4Ndy5zMVpf2DBZmYM1asChhVA/SAK6YBw6g61oj8S5j4CMJkUGMor7NCUA3QJbWJy7Ea5FbzGl0z6UuXdhOeT8AVUeKTgEC6Cu0UBvlnTLPjJkJ3PePzU5itCa1iBHsubWeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 20:26:20 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 20:26:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 16:26:18 -0400
Message-Id: <DJLTDCPWMXDL.4ICZ77A1LPZZ@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 01/13] mm: introduce vma_flags_can_grow() and
 vma_can_grow()
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
X-Mailer: aerc 0.21.0
References: <cover.1782760670.git.ljs@kernel.org>
 <f2e8c32515d328db62279cc8bab8398ea278d74f.1782760670.git.ljs@kernel.org>
In-Reply-To: <f2e8c32515d328db62279cc8bab8398ea278d74f.1782760670.git.ljs@kernel.org>
X-ClientProxiedBy: BLAP220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::31) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdbfcab-ac89-4e05-59d2-08ded61cadfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|22082099003|18002099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	xUj0Wbi7enOgdR8SfgVuT5C73lXoevgkzScl9VL1vsj0miycsDySQxzOAN6+yVwlaeVhGLKqkIayPxmq1HCPnZhRw9vOk0gDDPPvKfEOz0ZESjcbEs2cEZs+hdnh1i6oSi+6AXAZTLt3IC4T0HDKPuXI4C5I7J7/sY1eAn9xAt7rXgSTZZtq7IPZUawDx5rf/pGGcPoP0WbHVGYEQxe/34QBIUrEPJTadYzWQ6LUdRd7P4lrz0HdM37EY6/SdwgCz4BT+XqhdE8Xk9yIbGKKoq9a1mR4/qDOHqdpxghkHsLKvAh4kMHvncz1akgnhR38twHjIjyWGz5BLMeX/aVmnb5qxlyvFDm78GZ7ImdEZeL53JW1o8KwzX4mNIZF/c3zaupiC5x4htPFwOTc43ztfGKot0S5JrSyb+dQR2v9OK2EHhkGUjCPmyGfWXm1r/2C6x6zAcOukC0FS4O0eeOKmRwDGrRxFVgXiQh+QbqyhEvF7FpPwf8Bysr1zlerwRkHyc/66RHdmHSD7dIUzmBBKD6QiONcCzV3YPuK0oklR2Fm4kKr5Sg5ELEzaT6wKluIZ5441stoCvpJiPxZec3UMiuJ9lNzczUR+PvqcWFEAE1eEnXBbjPwCJpX38bIlBAIjfH6Py1HcGoT1a14UjGCntdei7oGEa5zchpvlGderDM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2FSYUZmZVN3Q25LK0llMFRzY2EwNkZRQ1lMWjdiT3U1Q1RoU2c5NUZuNjJC?=
 =?utf-8?B?VWllTW01dWZFZ1NVVFhDQXVXT0ZZdXBNLytTc3RySWlibWREOGJsYkNNKzMx?=
 =?utf-8?B?MC9DekxkRnAybzNZVVhlZldFYWlhRW1JYnpSWFRHR1NsOGh5T2tqNmY1MStZ?=
 =?utf-8?B?ZHptdS81RGorTFB0dldWZkNvSlRYTEtPay94UkZTVnF6eFNOZjJRUVB1WHVX?=
 =?utf-8?B?clNneWFrVlNiTU1zRXBBOEVHSGpGVkdUM2hoNElUcElOVUdlQ0wvbHZjNXRH?=
 =?utf-8?B?TlRGenUxUHAvUENnMUIxc3pucGVpMHJWODBwVjcxRmRER3BYVnBSdGljSjlu?=
 =?utf-8?B?MXN5SUJrVjNvVGxzYkMxRlFlbU00QTRURnJNUmJCK1pWVmxla2d3RHpWaFpz?=
 =?utf-8?B?SHgvcnFtZUdTK2hMMFRDR0lJRFEvYnRFSnBReTF4SXBFZ1lwMUJyOU1xVzd2?=
 =?utf-8?B?ZWJBMmwwUC9KRFZQRkJwaFV1RHJlTG1iOC83TWRZRlcrRUxjSVk1RHdTZ2h1?=
 =?utf-8?B?bGUvS1RFcUdLaC95YW5PenVLOXFPUVM2MThSMUkvQWx2MEprZHNHTS9tNmRF?=
 =?utf-8?B?RElqcFZlUGpudlJNVUZPZHBXNWdzNGEremdlWkJzZG5YbjVrTWJ4Tld4bHlK?=
 =?utf-8?B?eVF5aEswK2poLzFUVmtmQ0JtNG5vbzBNZTNtYjRaVWIxcmxrMjVHTEorUzZY?=
 =?utf-8?B?Q3Y2aThOTzIxdTVrbGVwZ044L1Z1NkNaNXgrSXUvbFBDak4yYXhOT3RTTXFN?=
 =?utf-8?B?SnpkS3EyTkk1TC8yOFBTNVlBMkVsZ21YZzlObDcrS1ZPSG1KYVNnZDVCYWV6?=
 =?utf-8?B?cnByMVVwWVU5MExBTEpFcGxmRGlWOHowYS81QU1IaElqL0hZZU9zclZxR0VV?=
 =?utf-8?B?UWNyWTFnLzFRbCswSWVnNzNDL08yQS8rZU4yVnZMQm9pVDQrdzEvZEttQUp0?=
 =?utf-8?B?b0VvQm5vUHUwTzJTVDU4dHFaY1Jkc1RBakNxK3VZdVZzd2hVTnZ5Um9XWDIv?=
 =?utf-8?B?cFc0d0F4dzM2c3NaMEZRajBRTkF4MW9wQ1gzbTVnNm1aSlNaVE5YS295dUxH?=
 =?utf-8?B?NzRnMjA5MXRCcVBIVURVd0VqWHkvaVg3dUtwR0Evc0Y5RUUvWjEzS3hzTWNj?=
 =?utf-8?B?Qm9DSXRqTzh1QzdkQ2s3OW1wNlRTZUx0cUFpUkhoc1FpOEpCZS9RdkRvaTk3?=
 =?utf-8?B?aTd4THNCZUlpY2VBU2c1SGVzYzBvd2R0dForRWZzUnMyMzdYUkljTHU1aktK?=
 =?utf-8?B?OXBKTmV2NUNpeGZjaTc5ODhLM2JMaEJaM054UUF6RTdHTndTbDY2RHZxRy9i?=
 =?utf-8?B?M1NiNGRZQUZOWnVJYXRtcW96STVNbHhScndhZmtLVWlud0FCdnRBMjhENTRN?=
 =?utf-8?B?cmpsb25CS2JaNU9WY2pPNDdPNXJmaTVOVlIrWGJxcmgzMERuRDZzdmhRZGRU?=
 =?utf-8?B?UVN2RlRqSzhVN1BLMTM3R3JDWGpOWWVBUFRFNGV6dDRuZCtoSjM0K0s5UG9W?=
 =?utf-8?B?Z2FybXh3enRDcUxPUGNHWjYvMVdiaHpVQlFyenRReFprVXhhQWNsZU81OFd0?=
 =?utf-8?B?OW5XRXlEZ20wYlBLWlZsYmFobDBJVXNSeExVMmM5eTgwTGcyQ20zZ0lWcWJ4?=
 =?utf-8?B?V0d1OG1STXJ6T2U5eThmS1AxTElCK2lZK2lCcWZ3OFJpZmtldndsTDFPRVMz?=
 =?utf-8?B?TVk4STNTU0V5MDFMV0xhOFRTbkxhQWJXdFpEYWxtZTdyWVUyK0FpQkpXYnhN?=
 =?utf-8?B?SXgvMi8zUEtYRTFNWmdTMU90cUVTNGhrZjBZcGNlYVBHSytsOVlJcndSdjU0?=
 =?utf-8?B?YXFrU1ZZakRMeGJUVGdvekhQeFl0ZVNINGFkTjZRbSt1bUorTzI3cDgvaFNP?=
 =?utf-8?B?QmJuakREYjN5bllIMVIzeWd0ZCtza2NwS0lESzNNZkdhamJYRXhMNzRaVGNh?=
 =?utf-8?B?c25kMko0VlRqTXdJT1JCOHBOK1N5ejV4bm54MkQvRW5YcHRnMVpPOWtSaHpL?=
 =?utf-8?B?QldRbGZxZHUwRGlNaUF5MnNvaXFNeWlhV29aRUcyQWRKZG8wVXRjbHR6anZu?=
 =?utf-8?B?c04wV3Y4RHBTU3M5QkFVVXRYVlllZG40eEZlVWJ4UmtSdEs4eDhsMEx0d2ky?=
 =?utf-8?B?NmdKTzVUWlduS0VDODcvakRvaURQMllyQys3OFl6Q04wVmR0VWxMdzNJSnEw?=
 =?utf-8?B?K2xXQ0k1SnV3Z2NaaUFIbk1PUGI2ZTkrOFV6NVBaNURNMnJRNUIyTDZoaXF3?=
 =?utf-8?B?aytMQ0tLdENFU1Y2ZUZ4OUw4TTlGcFJFR25MaFhTWkNsME03SFIrYzFKcVph?=
 =?utf-8?Q?+t2YN/oXnRlwZEOT5Y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdbfcab-ac89-4e05-59d2-08ded61cadfd
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 20:26:20.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeOF9AEynETVEVXKwzskEDGmMEHuAC1VcI7guFM1cBS66AuhSMQ4skmiFHWDXKMV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551

On Mon Jun 29, 2026 at 3:25 PM EDT, Lorenzo Stoakes wrote:
> These test whether the VMA has stack sematics, i.e. is able to grow upwar=
ds
> or downwards depending on the architecture.
>
> In order to account for arches which do not support upward-growing stacks=
,
> introduce VMA_GROWSUP whose definition depends on the architecture
> supporting it, and use vma_flags_test_single_mask() in vma_flags_can_grow=
()
> to account for this.
>
> Update the VMA userland tests to reflect the changes
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
>  include/linux/mm.h              | 21 ++++++++++++++++++---
>  tools/testing/vma/include/dup.h |  4 ++++
>  2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 868b2334bff3..cf7df1569052 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -472,6 +472,7 @@ enum {
>  #define VM_SAO		INIT_VM_FLAG(SAO)
>  #elif defined(CONFIG_PARISC)
>  #define VM_GROWSUP	INIT_VM_FLAG(GROWSUP)
> +#define VMA_GROWSUP	mk_vma_flags(VMA_GROWSUP_BIT)
>  #elif defined(CONFIG_SPARC64)
>  #define VM_SPARC_ADI	INIT_VM_FLAG(SPARC_ADI)
>  #define VM_ARCH_CLEAR	INIT_VM_FLAG(ARCH_CLEAR)
> @@ -483,6 +484,7 @@ enum {
>  #endif
>  #ifndef VM_GROWSUP
>  #define VM_GROWSUP	VM_NONE
> +#define VMA_GROWSUP	EMPTY_VMA_FLAGS
>  #endif
>  #ifdef CONFIG_ARM64_MTE
>  #define VM_MTE		INIT_VM_FLAG(MTE)
> @@ -1563,11 +1565,24 @@ static inline bool vma_is_initial_stack(const str=
uct vm_area_struct *vma)
>  		vma->vm_end >=3D vma->vm_mm->start_stack;
>  }
> =20
> -static inline bool vma_is_temporary_stack(const struct vm_area_struct *v=
ma)
> +static inline bool vma_flags_can_grow(const vma_flags_t *flags)
>  {
> -	int maybe_stack =3D vma->vm_flags & (VM_GROWSDOWN | VM_GROWSUP);
> +	if (vma_flags_test_single_mask(flags, VMA_GROWSUP))
> +		return true;
> +	if (vma_flags_test(flags, VMA_GROWSDOWN_BIT))
> +		return true;
> +
> +	return false;
> +}
> =20
> -	if (!maybe_stack)
> +static inline bool vma_can_grow(const struct vm_area_struct *vma)
> +{
> +	return vma_flags_can_grow(&vma->flags);

Would it save vma_flags_can_grow() if we do below?

return vma_test(vma, VMA_GROWSDOWN_BIT) || vma_test_single_mask(vma, VMA_GR=
OWSUP);

I find these two functions when I am reading mm.h.

> +}
> +
> +static inline bool vma_is_temporary_stack(const struct vm_area_struct *v=
ma)
> +{
> +	if (!vma_can_grow(vma))
>  		return false;
> =20
>  	if ((vma->vm_flags & VM_STACK_INCOMPLETE_SETUP) =3D=3D
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 5d7d0afd7765..6f5bcd7fbcd8 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -245,8 +245,10 @@ enum {
>  #define VM_STACK	INIT_VM_FLAG(STACK)
>  #ifdef CONFIG_STACK_GROWS_UP
>  #define VM_STACK_EARLY	INIT_VM_FLAG(STACK_EARLY)
> +#define VMA_STACK_EARLY mk_vma_flags(VMA_STACK_EARLY_BIT)
>  #else
>  #define VM_STACK_EARLY	VM_NONE
> +#define VMA_STACK_EARLY EMPTY_VMA_FLAGS
>  #endif
>  #ifdef CONFIG_ARCH_HAS_PKEYS
>  #define VM_PKEY_SHIFT ((__force int)VMA_HIGH_ARCH_0_BIT)
> @@ -315,6 +317,8 @@ enum {
> =20
>  /* Bits set in the VMA until the stack is in its final location */
>  #define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK=
_EARLY)
> +#define VMA_STACK_INCOMPLETE_SETUP append_vma_flags(		\
> +	VMA_STACK_EARLY, VMA_RAND_READ_BIT, VMA_SEQ_READ_BIT)
> =20
>  #define TASK_EXEC_BIT ((current->personality & READ_IMPLIES_EXEC) ? \
>  		       VM_EXEC_BIT : VM_READ_BIT)

Why are VMA_STACK_EARLY and VMA_STACK_INCOMPLETE_SETUP added here but
not in mm.h?


--=20
Best Regards,
Yan, Zi


