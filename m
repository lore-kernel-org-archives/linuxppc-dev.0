Return-Path: <linuxppc-dev+bounces-23755-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A31C44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 02:30:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw2Bx2w6Jz3046;
	Wed, 08 Jul 2026 12:30:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783477849;
	cv=pass; b=Uxmiy0rETMqibH2OSsmVihqEohNSa5Uv8xt0574KyDAl3t1jD8uAlwj0im6QeNKJB/u2WLpTLzp6iZMxy0VdzO+iRoeoxIxzz2q/pR/uZ2yj0n4j3JDbvq8vyavSHMdvbAWwphSqdZe0sGy8RrIg65BoyeKvIf9otadcy9db7tHUtQ3hAFo+OJnYhEMCwFpx4Leg5BZ0AGVx4zpQVim4bZSGlUyUFBm7JxTknsgsjx1mp5AmlG7O68e/iUZLXqrfrUcgFuRasgl3Lbhni0CU0ollVIpjiPEAGFwslX/+JHJdTGJQrlO0bWyq6DTvas5zO9A5pLAvDXSXA0QDvKkZkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783477849; c=relaxed/relaxed;
	bh=arzevAtoH6cUE5vjUvMhwI1l/6xS7uVDQdLrQTOTzjA=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=gcFMyDElUko8NDzcN6RVM5Zm80/fKinWqJ/i3WBcIxCpH93rCLDS/x4nrq43qx5T5bSW6D/aEBxUYgGCjCB5zEcv/1qKlztb08Y5ETmzd/ODJoQ/3A3dTqsgCcNOyS0aGvv/WnSbX3OmXMTkhBFj0vrU+GyZjnMT8J0ECYlthR5F7/1c0GCeLJNZGHh+eq4AlTIAhu1G0qOa8qina9TGw67GbVHJoytVaV8rglxYakkDxqk10V4+6SfFH8NcLLozV3rLVKtETvU1sDXA6inKEcUls6N6QDr+I6HjAclIneLQ0+Bwjh6XAipusSAFnxYfleTtqF8wVMT2Fz9BtLbKZQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IJ/n9Zfl; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::5; helo=dm1pr04cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IJ/n9Zfl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c111::5; helo=dm1pr04cu001.outbound.protection.outlook.com; envelope-from=ziy@nvidia.com; receiver=lists.ozlabs.org)
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw2Bv27lxz303B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 12:30:46 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBra6uUFMQoN/y6ewP81O3m2YOPGJ0b90xg4TOL6++jBUmt3pGeIUr1yC7IVUI0rvpGQv7JLf3fKuIptGW+G+jng8leFlsBvXZH69th0THIkvEQNfBGug84W8+caXdgntNUxkErz4s1a1kY21xM+XpgCV9+slks05y12yTL65+v5jGLhKpm5EXX5DlUw9XneCkjQPcDmXFyGV1Wa7+mtsGJ1lsxyGWCAZCywh0y0uwOCstAj0qnjZvNEBiUEcChCOWf/4Oj5cREkfn3JQywGt7Q8cA9MFrJeJsW13ZIs3PgatAXhIra5wYp2643H6Tz5DEGH60frmGTCDG8ouoNMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arzevAtoH6cUE5vjUvMhwI1l/6xS7uVDQdLrQTOTzjA=;
 b=NO5/uFep6RwJc/3yqw55hrjnxyrT61InrlFttGXoyk9B5td84ig4k1p1nc6ALYGNSKFC9dYr/wDu1viCYwAukG2MQvLanBEQKAYlTUNR6JdB7EnJX5wXRQziF9IvgNCvcimHZauFCIQWP4+RjgK+K0h3e/wdYFA5GtLgYLNR2ff55TrkSxvHaq2ttTCBb1a9MTOgMMLIAMpzpFlV8MfGK+bET7XOhhE4ChWyoFcTBCD8rxi7RHVftgR7Z1BLZTOXWid79Wc4IPKbbOX3PkAoCH/eIoKttkOXGlnw3isLdgOkZZoQlAwJOD2LhJ4NczldVzl9RhAM73keLKWqb+BLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arzevAtoH6cUE5vjUvMhwI1l/6xS7uVDQdLrQTOTzjA=;
 b=IJ/n9ZflLYbi/Y9DmBKE/I0hWBSfbTopgftA713S+shU8putf/vChIRb5gbBfpyhqNIp53XDk3JUhGeFOh5WiKBOV03s6UK+/y7nzAelCc4YHGzb8eEU4BUFB7ix/hzsQEvMWPJNXAk1ctPMQfMDEMy8yV7w4yDX9oYUUPpmYZFUWXKaZQTu/GQtcGlGmUjm2paC1COttn5QJne2y88VnPLlruqpAZG+ZrL2Gl1NrLEeT3s1xGgi2c2q5Ytj1fn4j5aFAaMLFjip0D4jFcSwAZmmRvTNRElyaJbEZE+dYSeN7VditKzPHfZJOk4+yEyvReOe1JCgZRqTGIgzyRXUMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 02:30:18 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 02:30:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 22:30:10 -0400
Message-Id: <DJSU4BBF7EON.276L17W5RTEW1@nvidia.com>
Subject: Re: [PATCH 06/13] mm/vma: convert vm_pgprot_modify() to use
 vma_flags_t and rename
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
 <548ba81b2971734d4d2143237ad1465bd1b2f525.1782760670.git.ljs@kernel.org>
In-Reply-To: <548ba81b2971734d4d2143237ad1465bd1b2f525.1782760670.git.ljs@kernel.org>
X-ClientProxiedBy: DS1PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:8:456::17) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6621ac-eb34-405b-3d17-08dedc98d978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	VAzUzijjsJMvZkTGj7iS37VLUGQpPdMEUfbkgqqEylainL+DBI6dFO51X/qwWCWcg5JSVNRgvk5htcQKKY+WLC47q0M+mfb8J9jpXe8myoD32H8zyHLtpoyZEvDZh6N5Gd7VpoR8pu6CTsearPGoErfEfPNs+BXPgBg1o18aIV1xS0iFNPrKMl+sWL7EJqeo1scKZYY1/dN16dLPqcE5VEB0lU8v4pKk+LeIfyN7e1l199nFenhu2aCgt3+r9Z8mmD5B7AlmjDTg+rcmj3sXv1qgoxZbu+VMZ86acnfduxcUBbLMTRopt6wx6d506Tm8d9UiDJrfFS98BcDr1ic4gelhhj5bMEd/3VbMKtmzgjMtyjR2Zl2O3gBBIO881rEoW/HYTxVoR9WDKLXLhgC+gu62f8ULeBFOObIA9lZLWTfNvyTmlJ8SBGo4S+HZGxfLki5EdZp4XMUSgxZCsrxsWYfPe2DLTJ0mAtWW1OcZkDNw20hFJY5KoQc3eoi+dm95FKrilZsz77euV0JC91TouPj5u9OtFDdOgVOjU+IBa0gNww9gaocAhWFdw9BItcPSBEwPs5WnSnWgE4+d8JlITOTRXMpcBuWi+2G/EKAP0F0YNGZEoeQRXtcI5URKg1O3bp4lYrw3k7uwgM3bUKCHLEyCx1xJMQ8RE0hu2k/jJWM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlJvRk5yMldtTGhKSnFFcEZYUllSVUdabjZrVG1adkVmSHpadVlTaGQ2ckRZ?=
 =?utf-8?B?akQ4ZlUxOGFFaHkxV3dXWVJEcWp4My9GZzlzbzRnY0Y0cjAzMWhrUTFjYzdv?=
 =?utf-8?B?YXYvZGp6bG1NSjMyS0pKUnloSnV2Q21NbmVVVlQ3eDFSZHBYL3QrbFdzaXBQ?=
 =?utf-8?B?ZjYzYnVZUzhoOVJsV3k2SDFkTXExcTBiRHUwQWt5TjRLZTNPNW9Fb1J2SW5t?=
 =?utf-8?B?cWFBNzBvTy9ja0hqSktpOUJZTG0rRVd2TEZrbTVhQ3VPRmpqK1pUTGU5VmtO?=
 =?utf-8?B?ZVpPeERBZ1dqem1rOWxUQWRzYkc0cHNJcXFxa05zV0Z2Z1llK2F2QVFxVWZr?=
 =?utf-8?B?TlBzSnJMZFdrNFprdzVkMEZramIrellZcXdXMzh0RjREVURsR1ZiNjBhbEZk?=
 =?utf-8?B?RlpoSFlsWEtlWk5qSEdyVUhlaFdTRmNpNFlzZWlEYmJVWGt5bncrVWFmQ2JQ?=
 =?utf-8?B?VkRMdHd6YXc2WkJZRnJlTzNCalZWQkdjdFYxM1ZnN1ZEbGhFRGN1T0hRSXdi?=
 =?utf-8?B?eHprZUhWbjI5a05Zc1FZRzlaeDErd1IyckUyL1RoSnh4OXFBSUlvMzBLL3NE?=
 =?utf-8?B?Ri9sTDhaKy9jcFFSN1hhdjJDNUxPRDlQc0FZUzBEbWxWNDk2QlBZZUVMQXJs?=
 =?utf-8?B?T2tvVjVCY3VrZSt5bmc1UFBmdm4wS3E0Z2hVQzF2cmpRamQzQzBGYnBZdEdv?=
 =?utf-8?B?YmtRb2JSeVBUKzAwdkhIR3BlOGFwZjdMaURxUHlmM1F4SXBGeFMybHp6M0Ny?=
 =?utf-8?B?L2pEQTNQdm1JSUlyU0dia1g2anc1RGJjQllHYW84ZVFFQndxWDVYQlVOK3pm?=
 =?utf-8?B?WS9CSVREbmRhMTRqeWhVRFNDMGZGeEZ5NDhWWitQV0VVVVFKTFFBTTBqaVdm?=
 =?utf-8?B?bXdCZmZoZ1YrR29SY2lGOW1LNUxXaG96dVFCMTZuenJjbjFwWWZCYUxTT3hr?=
 =?utf-8?B?K0w2clB0UFhubm1jdlNaanBpSHVHMml4SjB6N0FMc3Z1NlZSQlo1c1ZoU1hV?=
 =?utf-8?B?U1FlTTdmMHg2UmZ3NHJxb0VnbVN5cDFWTE9kSXUrcXpJQVFzbUJhNkoweDM1?=
 =?utf-8?B?STJSd1dLcml1VGcxL3lLelpKTWg5ZVJHTmZHemRiWVFBS0tiZlhYRTBCeTNr?=
 =?utf-8?B?OUJnSDVnMitVZlBwcEdwQmdYOGtGYnBjdTBqRExKd2dETUFjOWFsOFc4QWxl?=
 =?utf-8?B?K1BWd2h4YXd0WjJwZUxsVjR3a2p3aGVoZWliVWZNcHpidVhldVBOdzJMWHVn?=
 =?utf-8?B?OFdIc0ZzbjBTdm9RRkZpUnlhZEU2Wk1sbGtmTTIwSWhLTjlDeFNqWDljWmV0?=
 =?utf-8?B?bWJ0MHMxSDMxTEZHZXVGSGFueXBuOENLOWcyS05VVXh4NGNPT05qMWYrTktv?=
 =?utf-8?B?QTVUMnBYOTUzak5IT1hMM2dpeGwyYnp4QjAzOGQvcnh3K0tPMEN5VHBNaVFM?=
 =?utf-8?B?QlkzdE4zTlF2OTBRQ3hGbTdqOHUxU1l4ZllyNlVZSGpmdGQwSnM5NHdnY0VX?=
 =?utf-8?B?Q21hM25hUXBtaDVyR21BV3hHMEVSbnNBK09IcE5wQmJ4UHUwc1JFdjNOV1BQ?=
 =?utf-8?B?bXA1VG0zTlJIV1AxWGh0ejQ0V1JwN3orYjZxWEc2Nzl0V002NXlmb2l1eUF0?=
 =?utf-8?B?U25uaTRGRmlRSDZHOS84V1NGeDBTS2I3UUtrZ1BHWE82OFBsZHZzelJySWZY?=
 =?utf-8?B?b3VCMEd2b0NPbGJXOERWWUk3UXgwQVNFMkFqdXBrMGVqMkc5S29qaGpUaXFH?=
 =?utf-8?B?TnRNUVcvUGdSV2s2dHlLUElvNVZCcmh4V3diUG9GamxjV215KzlwT1BxRnlx?=
 =?utf-8?B?T05mRUw5di9QazRPbWdNV0VtQkNjS0F1a1p4WVNXcGhQT1I4WndxMU1zOGI4?=
 =?utf-8?B?aHUxWjZMcXpnQ3o5anJsQ29wRW5CbGRLakl4U1RxVlJyQXlHaE9mbnVBSExF?=
 =?utf-8?B?WWZNa1A2SGxGTTdUbWVkSGZBZlhzT2ZmUk11aXJjYXJXdERBdkNZMTFHM0lt?=
 =?utf-8?B?RVBBc2ZsRkFMZktoVHU3dWFuTWUvNkVVcW5PS1VFaFlVRzhNSFBLVnQyVW00?=
 =?utf-8?B?M3pYcjI1dHhNcTVHZy9OV3lBWVYxRzRJZlRPdzNnTU9rY3l2SXBtcFlLSHEx?=
 =?utf-8?B?TFo1VktNMHpuRW43REhFbGdvNTJVTW4yaUxHQ1k4NDR4ZDRneDlZMzdiOEVP?=
 =?utf-8?B?SnpKamdHaE9vU1YvREhQYmJGc2RhanR3bXFEMlJmM2tKVEJPRzcvUkx0YXdL?=
 =?utf-8?B?U0EycERWUUxhS3VhL09qT3I2c05lSEw4M0N6S2VoTENLMi9tRE9qR09aWUZr?=
 =?utf-8?B?aGxtbkM5M1NQNWVNZXEvTFIvNFdhOEowSzBpditXeFVld0lNQzUxZ1NlV0tN?=
 =?utf-8?Q?2FxA9efYaxP1BooyqXhD3g//7LqxQMMxqb004?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6621ac-eb34-405b-3d17-08dedc98d978
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 02:30:17.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IR4pRR0IZrwgy9TMLVxgrf6jof6ZMh6ww9NBNbjH0YPS3Wokg4RcFSC5tqtGcdFC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963

On Mon Jun 29, 2026 at 3:25 PM EDT, Lorenzo Stoakes wrote:
> Update vm_pgprot_modify() to use the new VMA flags type vma_flags_t, and
> rename to vma_pgprot_modify() accordingly.
>
> This is part of the ongoing work to convert vm_flags_t to vma_flags_t, in
> order to eliminate the arbitrary limit of the number of bits in a system
> word on available VMA flags.
>
> Update VMA userland tests accordingly, updating vma_set_page_prot() to no
> longer inline vma_pgprot_modify(), rather we can simply define
> vma_pgprot_modify() as a static inline function and the tests will pick i=
t
> up from vma.h.
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
>  mm/mmap.c                       |  8 ++++----
>  mm/vma.c                        |  2 +-
>  mm/vma.h                        |  6 ++++--
>  tools/testing/vma/include/dup.h | 12 +++++-------
>  4 files changed, 14 insertions(+), 14 deletions(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi


