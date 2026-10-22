Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49E606A31A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=pfDpesX7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9Mwh6xy8z2y7W;
	Thu, 22 Oct 2026 21:35:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792665300;
	cv=pass; b=QylcgJUQS9hnHszgoGi/NO39yYvvyYYjeemNVG9PyAtIv4IQnLUkZM5OHuCgCjTwEOMW9nFaO+uonOoShttpEYMJPZekJoVFf3FMu8AnfW41zTpOe9sIpdlHG424zOL+oIJfwBwiynPUDQZmEvu1ClR6n8q+gwPWZyqdabHAMtPyEAzWz55KDd+iKkjZOjsoZvBmTBzuKk/AKgrciYhcQgprHIBhTJHeMnWh+XQ6f4hF86CIkHtPOSLLyusBIaIFkb6d/MBaGpodwGkC5TlRIt6eic9jHPkfxBzJeU1SLiMpVJ0rnty7UzJ8xpVpjVcTb6hCYw9w2teKLBj+gAcEoQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792665300; c=relaxed/relaxed;
	bh=LMl2BakasIgszrDbVksZBhYpaIBRwF0MnmcwaAjghcw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YyoA+I4yclIhaak9xHk1OYg+5xD7/KiPU5RgneXC9o4+wwh/48gYjjf2v+C0BM/ap0C/8pDKb/Q8hV/Oc+iGaATP+htk51ubKqeZ7P/EhrJfToEYGJeuuxQVewdO2t1BGfsKHYacp7VR4foPfTiOSiVffMS2L+GguuVLOWiO3yajES2wZzBn75CDKVCcd0M8miqRspj1UDAgGWjJk2pgAbquZKq1WvUUiZvF8+Af6O8CjFpfx7GAgvXXYjx/78giIjQdbpmbI8G89uz7JjC8m38aacAVWR2HrOQd4P2heSTChsg32nLbwcwCv14Vd/bnVF01lV0GylKk6XvUYKzKrg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; dkim=pass (2048-bit key; unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=pfDpesX7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org) smtp.mailfrom=virtuozzo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=pfDpesX7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=virtuozzo.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9Mwg0Txzz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 21:34:58 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQ6qsg19x31CCUkHScl7xXcDGL/6RMOWRsIbnVsR4CyNxWSh4iq9hXLxd01smhMeItU1UhmZANf0En5/MhzfAyd6WlOTqsditHgDhwsNMjO3ry7sLbsvhwfuXtBG8HOWWhI4azPXt2Wp6p5iHUEzRgRbLu31kT3hXrTp+95ZeZbSHnUSczxHeE1ZbCqaYGX9DcOBHnM2nwPCg9dJpJ7bOq++W5AzyT8LxFnSw6mJxF5u69PoMdiK5g4MlXI+JlsjoNzh/yuWyYUVqaCF9akrl6+fvMB+DyURRe+Yp9QR0Kwwqfmo/hFj0ZtJDn8gHFn3106DDVW4/Fi2GHJop79Dhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMl2BakasIgszrDbVksZBhYpaIBRwF0MnmcwaAjghcw=;
 b=kSyAqbkirP3YaMp0P4gVpmQ5Hz3cZfdwdaAqjqxNOSSXIlaw13gNFrNa3Pmqv4CRvtcHq3Rol7UtARBj81vEm6NLOvfpwEQJ+5rfqW8gdkxd9vKiSBE6Idw6/HJAUlp/9ICUTstxgPnqiC/0hVmDAALuBvWHCAApgFmDmqPUS9Co5KAyA71TENpYM/W+fUf8X//pVISCpDMIFY3+L046V7hWIhoF7vih/Emux61dYzZVYeEwOSciZ42AoKNBEmcvufJeHG33GBf1AIQAzuYKdebUbNonpPmw8IZywXsaL2d9KTBDJuM+IfOJZrZ1OnCQAgcJ2wl2VyCJzCKyX2NAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMl2BakasIgszrDbVksZBhYpaIBRwF0MnmcwaAjghcw=;
 b=pfDpesX7Pzpn0G1H2++tpZPwnieU6cBNcgA7zTzFeCxKi8d2/h9I4qfqlw9ADzFPkLyYSf4a/0qUum5i4MIf1UsXs/jdRttk6nvJz75unlqsumLhoK/76eWJz41Lcz5eje6WzgxHWG1aQ3ZZtS1qW9ykwMkRuHNu4ZYVKxtnNlG5bcVD6hkqJn6sy0nJvY9Y5C5awawlRAySlMiolbfra11oCwxx3y0boDt8uEVgArLkjDvCXxqsl7QfxhGiCBOVhWDRQ71RphYKptMQ2m1hFe6/lBdWi3/1p1LqNKcwEsuATHIkNnZg3LEEBYAFtkA+Wi4QdhD1QUkFef26WLdwag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by MI7PR08MB884834.eurprd08.prod.outlook.com
 (2603:10a6:290:109::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 10:34:34 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 10:34:33 +0000
Message-ID: <98c1002d-ee6e-47a3-9214-2296a560b3b1@virtuozzo.com>
Date: Thu, 22 Oct 2026 12:34:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org, =?UTF-8?Q?Lo=C3=AFc_Molinari?=
 <loic.molinari@collabora.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-1-66f00b7a564c@virtuozzo.com>
 <8C082879-C8F6-475D-9460-DF5E3CB629E4@nvidia.com>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <8C082879-C8F6-475D-9460-DF5E3CB629E4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::9) To PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|MI7PR08MB884834:EE_
X-MS-Office365-Filtering-Correlation-Id: 249f093b-bd4f-49c2-de76-08df30280ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10067099003|22082099003|18002099003|261021121427099003|261021123027099003|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8Wv+0/Bz3pLIzUrpyqqf0lN6tYvb4hsblfzoD/qkSIgkmmhL3+QFWo61nquALvlO4wffW4giEEyfLS41rfJIQp6w+O15E+o7v+NZBKQoM1q4wnk04bB434JpuJ8UX1qxR/caoRij0gEohhKt3Cwy8gtP3xmJX6/1dffKRynj0JNG8GXhhc7c5cbW53n/7ExNtvWp/WyLxwJ8ac3vricaV83cmXAGIF5DZiMo7qeemR7j8NfwRVxjAQ2mOnzqW2e0He/F41AXZKFLU7+cgysvQvi7AH69ojVbh1jmAHiDAVn6SvrIyHEnLJN6qqHt49Tri5Q8bhyg+IW0zvUtDyTNr231EXVkoSFUvBNiFgjzmLP+hAAlFZ5dYCtF1LGGRBqbDMxqEiK3sBFHg5jmUzvatuBt62UGui3ZkAefVqvbvoAF689Qmy/qsDnFv3mb/LE6tnlbEH2F3d0A4ADX9mcZRjn9GbR/ipWlXluh0MVLS4CFe7uCLZLnVoHvyprcvyAi5E+oNnMSEr/hO3tGF4lhZPoP+U+4MHUlJ1zJN5l07eOpuO+wGxMgGDFjsZqJanLFDa55WZEaRVk9cjsqswIPwGQaXsaxKr4VIas2SSeYtdNq67mN3Eh/MD5inBDtdALUasGdc5t08U3zBpbFBQVG71WzUXObIXKV0gpy1WKVAdg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10708.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(261021121427099003)(261021123027099003)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V21TaDBRc1dCa1NyUVlzWXNnVXVkSWxKOWVHM3JFY3lSYks0aVhEOVRxZkFR?=
 =?utf-8?B?dlMrTER2RnpTemdqZm55ZGFwRWVHeThBVzFLbjVsSTJicUErbkRUNTZJR1JJ?=
 =?utf-8?B?KzJSbXRDOTZQYUFYUUZWcDQ1NmFsdTFsQjIvaUlYRHdtN29Hd0xZRjAwVm80?=
 =?utf-8?B?WU5tZlJRb0djb2xrVEVFbFB0K1dKT1pZZjFXdm1XS3ZZdVRBM1BEK3gxTG1Q?=
 =?utf-8?B?eXZaSFpIK2gzUXFsNi9rUVdnZHo2K2l6cFlDZms4Q0JEQlM0VWNERHVGY01q?=
 =?utf-8?B?bTRTRzlPU1YzZ29BenFPSzZDSGJjai9LVlk0Y1E4VEpTcy9LRDl6Y2hzdEhu?=
 =?utf-8?B?WGlFL29YVVFpME9rTWFXbmdhdFBmUnJsdnEwK1JRNGFXbmNJb1doRkUxV2JP?=
 =?utf-8?B?bG5LOVRDY1pEQitVNmZJZXJ5cWRtaHREZHVkS0xZUU1mOGdXWHVsRi9UdUNn?=
 =?utf-8?B?VlFYSGpBb1FyczJMWFQzT0R1Uk9xUUZYS3FsTFdTaHJZN0VRQ1RSTmlLbmFX?=
 =?utf-8?B?UCtHbHY0Q3RtcVB5eXA4Z2pER1VjZ29pcU5MVk01TjZqL0lIL3NXMnZObkhO?=
 =?utf-8?B?dmFUV0ZaMEUyZlI2UG9uTldZc2tOUUdFV0w5NnpNYlhuay90NDdlZytYOWVl?=
 =?utf-8?B?NkwrU041dW43Ry9sRlJuQnpUMVN5U3RCd3RzTG42dmtEc3JTWVlsL29MVzBF?=
 =?utf-8?B?VHpDcVRmeHVuWlZzZzc0SGFaVWY2UmpGOVdIaWFKcDlXTnNlOEs1NzM4eUZH?=
 =?utf-8?B?NTdpRkI3UTlKY1lmYWhHMTV1d0F4MW5tVm9CRFV5bkxWcGdWdmFHSUNrbzAy?=
 =?utf-8?B?V3RXMndPakUyazZmNHF3MDg1SVoybXZzcXhxZzhzajNxT3VLTFdWSHlXMnVQ?=
 =?utf-8?B?RzBtaFV5UExveFQvQnlXaE1zRUhPUWZVNTQ5VjU1SjlpYkZLRzdoMFpibHBz?=
 =?utf-8?B?RnFqVU9Pdkk4cjk2cFBHZFRwd3RXTjN1bDFvOEpTQWpUTXNsU3gzdWZsN2FJ?=
 =?utf-8?B?dVA0L1lYc2JqTUk2anpHeUFQaitEVVdpMjY1cGM3U2JFTm1oVjFFNTlWbjd0?=
 =?utf-8?B?c09LdmlmVElsSWtzQ0pmaThDNUlMMmJXK2RrWFVtcVFxdGFsVWN6NzBnYVkw?=
 =?utf-8?B?RU84Qml4Z3hreUJ5U2dJTzNsRlBPcFdZQUQ0cGI4WXgrYTlSelE3QkJBY2dI?=
 =?utf-8?B?WXpsWHpUUkZjbHBxaXhUejNEbnZ0a3paOUNLaHloZEIzYXNSY3lpWmRnMHVv?=
 =?utf-8?B?dWpLcjhTMlNUN0dNT1pzTkdMYmd4RG9jTmRXLzZmeWNlZmJLTGhrM1g0RXQz?=
 =?utf-8?B?a1BlRUZzRklMR3lxVVpaclJ4OEJnK2VKbDFCYXhoNEl0YXN5bHJmZTY4QnBj?=
 =?utf-8?B?ZEpRYXlkSGIrNHcrWXo2bkVTNzAzMnBHZExqWDNZT3cwUEpsWDVrTU1MaFZM?=
 =?utf-8?B?eVhrSUZTMVFMa0NKa3l5aThkT3VVUndDSVB0eHhPOTJmcG16ckNyczRjNndT?=
 =?utf-8?B?eU16UGVFVWJlNUdTV1Z5ckdTWXp2MHJuamVzUVk5S2R4cnVJR1B1cWpSUlJr?=
 =?utf-8?B?eEdmQ0k5WWh1WEM5ZG5KaURjb2UwNVNnTlV2L0RlVGtrNlV5b2dta01zclEz?=
 =?utf-8?B?Q0QyM3NuYXVXT1lNbWN5VGhhYVA0V1JXN3h3ai9GUzhyUGpJVk1SWWVhWU5l?=
 =?utf-8?B?eW1mMytYSWJDeEx2NzlUTk1vODd5RHJpU1VkclRRaTNzWGNiVmhBckZyODF5?=
 =?utf-8?B?bW1pcTQxN25JOHNMK25wdFgxT2MvMXB4Q0dxWDNXRzluOEUvMkpyN3E4K2tE?=
 =?utf-8?B?TmswM2xVNU53aC9NSkQraldqTys3aXBUSk00dG5nMHpzYitjNWZNWFgxZExt?=
 =?utf-8?B?ekwydGprbmhKS1h3ZFNUemtGR04zd1lpUjZBUDR1Tm95UDMrSWxJRWQ2b0Zn?=
 =?utf-8?B?N0FYVkxqVVFRNThmcWZYbVJvaU5sUE83N01HTjAvRFpkWkNnWDFnQnNyYnBp?=
 =?utf-8?B?WkQzc2VQY3FjNWFMSUM4eDZDbUtGQWY1ckFhWXB4QWYyR3hkSCtxbXIzNGdy?=
 =?utf-8?B?U1A2RkxxczFMWEx3S3NkYjR2aGdGSE9mck1TQkRwRnNSdTlpcEN6L3d4S0Zy?=
 =?utf-8?B?THp2eUVMcWlaNnhnWlRvVEJYSklhN3JyaEs5UVNTN2o2Z1NOdEppaUFjWU96?=
 =?utf-8?B?YUJlTy94bXRCTmpvQmw3UENjNVJ4MTVJR1B4Zk9rRitUT25DNUxtUVNSN1lC?=
 =?utf-8?B?ZG1kVDhUODRieFNLNE1Ba21TMlpEZEdxWmVGYjhJS3Zvc2tqVXpCYVhuZ2w4?=
 =?utf-8?B?Q0k5QmlMU0Y1ZncwMy94SWZWSlRzd0ZOeXV5Q1RzQ2FMZSswV3hNUT09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249f093b-bd4f-49c2-de76-08df30280ffa
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:34:33.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmJZ0Jlgucg5QUbXojcnVRCmBhTKgkyfO0WDU1gjbqn2pRSBIhXHUJPYw11LJfs1S7CYxPlurw3X4aBOyVUgBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR08MB884834
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 22:43, Zi Yan wrote:
> On 21 Oct 2026, at 16:36, Konstantin Khorenko wrote:
> 
>> folio_dup_file_rmap_pmd() passes PGTABLE_LEVEL_PTE to
>> __folio_dup_file_rmap() for HPAGE_PMD_NR pages, so it adds HPAGE_PMD_NR
>> PTE mappings to the folio instead of one PMD mapping. Each unmap of the
> 
> 
>> PMD removes one PMD mapping:
>>
>> - the folio's mapcount never returns to zero, and removing the folio
>>   from the page cache reports "Bad page cache", or hits a VM_BUG_ON
>>   with CONFIG_DEBUG_VM;
>> - the first unmap already counts as the last one and drops the
>>   PMD-mapped statistics while the other mm still maps the folio;
>> - the second one drives the entire mapcount below zero and drops them
>>   again.
> 
> This chunk of text probably can go away, since no one is affected
> by the code.

Sure, will drop it once we are ready for the next iteration.
Thank you!

>> The helper has no caller yet, the next patch adds the first one. Pass
>> PGTABLE_LEVEL_PMD, as folio_try_dup_anon_rmap_pmd() does.
>>
>> Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")
>> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
>> ---
>>  include/linux/rmap.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> The code change looks good to me. I also find this when I am working
> on PG_folio. Thanks.
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> 
> 
> Best Regards,
> Yan, Zi


