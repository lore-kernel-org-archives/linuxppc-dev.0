Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27969606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=zkjJTfkA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9N8R61sHz2y7W;
	Thu, 22 Oct 2026 21:45:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792665911;
	cv=pass; b=LlOA9PL+uxiIE8PmOld6xNckuCu25/OUA/Z53G116h1KTcSEVK/9KEsiwjym1AcNtTS/cvfZuR3JPR3dtBonVvdKOzPJ/Hdsz7aXaiTlAvBKsbgRNBJPgBcczp/GBficIoShaE/xs8RjOjYpyUm3wzXqJjFSJkBEBDTGWpIrHY14/QH1+kONd6jImHPJq2KURskQ1pbBYBBwM9/9M1eBxz1Fzs4QUaPUd8GJZAM7mZYpAaLGmuVr/amXU1ld3lsFi1QEzaJX2KJC1m7zkBRFdbHuEXVONJozdJkNMkwo5LvuzIQptFJn6kVh3zvnM/PDAt4254HK3MFcAd/6+fHbrg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792665911; c=relaxed/relaxed;
	bh=/H9i0/KxS03TPL9mZSA7OjhCtF4RVQmDgrKmsDMoVbA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l7POZr6kpTs6TkSnt93dsopr03Je4h8mjHvt/DRlz2vChk5woqRiLfBmp/DoyzXs7qv5Mr9PkLE6gsvBl8vUrJbxtd7ti96sB4FKGr/Ksnxaf7udtqRAqjjFvdgD2Gco42awDDLAoUtecTTzX21SQW+rcBjLw+PjwpIKEm9yXTr6NvxqojlkjtTikUmWLwtQhptnnywmfHK9xYd68wencJ3K4+LZPRaEsgIhzp2FRaNBY2Dmq+CJV3HRpzmtnDDuvMcNOLPrH/oE2+E1HxZbXcvhi/QsHbBo/KbXQbQJvILHB/4vSajAvPK+IWNYL9jrpSO5CcH+GLwMAfHDcqsWEA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; dkim=pass (2048-bit key; unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=zkjJTfkA; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org) smtp.mailfrom=virtuozzo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=zkjJTfkA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=virtuozzo.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9N8M224jz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 21:45:07 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zv7aae5LENvPcEjaGYLW8o6Gaf9uaF+b4Bnro0X6CLlyQRIKx2lUP0MbUbDWdJYc3TSiw4rZQOlzBs5xcAyEo7+X7I6AJDMYw6RUVWz3Sjl9moupVtjGsy2a3drHQg2uFrdSGOrVvnyQUbdL0sMbqYqTQhTQ+hllSfZpcXE5rT5MUbXGDey85hyW/4DL1YZ7J1q/ocWuPWC3Q0d3tQ24urw+tHMUP6YnF85uJIzepICL6GwPBm6qXE/9R9exiaUdVQpTYIezqak0NqviL37/FJ6zbGC4v50YOiFkR2fS+ZkzPEodrezCl2tWH/C2yjDPQ3CGcJA0bZ4BstuyyZ7LMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H9i0/KxS03TPL9mZSA7OjhCtF4RVQmDgrKmsDMoVbA=;
 b=duk9rs2ZygJzOR/0TynV7RrKCVGlXGXB6cCCdoes+4dv+cOZ45ICtx9yefeEzFFemmb4QQ5RhwBSDOYQea2LC7apCK6zIPZwubvwMUAFoEgVadr62edg+hPEEb4mJkS4sLeCiafBFflG/sMr2/6QtxZGsOWiYcDaTnUMYcikCe3aC5HrNJjlMS5u3IcwIWM8X4s8cu8JxF92NRC/FhId+KG6dXAZ9x6T8zh/NeURajGjfzuFaPk49bNzprY/XBSPpZyPRYxhDdUZtMJuOo1pIIoS1E4wH2pgUplC7b0l2xpyT+GU6lGWXB5unsZfBtHfkzJ+6yX6P+wZuLv3rYQarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H9i0/KxS03TPL9mZSA7OjhCtF4RVQmDgrKmsDMoVbA=;
 b=zkjJTfkATwtHx9y/HdMX6fkeH3G3XDWDURl/3pg463QAcCgtfAgNdb3KEkWiVYZiVDPUvqOBlEFO6TeXWo3FTpGwYX9DAkV7saO48bwl0KcLdizsflHE2VgwgDo0nwB6KXDd9xIqcN9N45CXi94Kjffi1K7puanSedfD0+Qe7uW1LTJigpEPjlHpxIVVprAke4VeScqStMpVOjCrCCsCEi1DjDK+1hKDglQIj5OkTkeRRpw6wvI7C2CsaT/Ro7gByIK6X+N7jdARHuv6wmwgN1aiWf/Yl25Ee2VAQFv/i/aEOLv/mynGapInnUWlOuEsEffIqoKhrfCt10ikzKEXIQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by PR3PR08MB5722.eurprd08.prod.outlook.com
 (2603:10a6:102:8f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 10:44:42 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 10:44:42 +0000
Message-ID: <71101695-339d-4f8f-b9d8-dfadf7dbd0ed@virtuozzo.com>
Date: Thu, 22 Oct 2026 12:44:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>,
 kvm@vger.kernel.org, =?UTF-8?Q?Lo=C3=AFc_Molinari?=
 <loic.molinari@collabora.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-1-66f00b7a564c@virtuozzo.com>
 <atnEFyGRYGGf9shA@gremlin>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <atnEFyGRYGGf9shA@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::7) To PA6PR08MB10708.eurprd08.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|PR3PR08MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c1a9fe-e817-4e6c-b34b-08df30297af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|22082099003|18002099003|5023799004|56012099006|4143699003|261021121427099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	b65GT7JpOIhauj1iDxG9MscqpG4tRFgjaKiN4g8INQmWciY+ct0ssmTiZ8GA8mxPe9ke8iRR5ZTS4Rba4i/rC5gKK5dhlEGyp4i2u7qrIvQwcvlMjYzCIOf45cLeYL6U/TuZ2Jt5cOVGhWk2LgUort4wpgY9VtGh1B9JBaPRW28yEasLFK/qbfjcea5uEtVMj3QFc7EP2VVKglVijHIXuVl9N78Md+ykXdyWsPp5lZQ//oGGyeefu5ycj/T9rNw707ni18SFd0CMksj3Hhr6WBTJeYfN0V8TxxfmLr4mH6n7AmwAXHePIFGURHpK6mjLtpgob7Whv5yhQ1QOq5tYg8yH9mo5fXFkHLLzKT5tPjrZLqCuD6joQS5yR1W8B1AyF3jJiBLRMtws0xW08xhOCu5EDvM9lyARZkF3Xn8ZPadIAgpno4votOC718A6jLzcBrkndzg+StIUS1tXbXLWIzOkZFVLaWDBTR4o6QGna/naR7br3QGZ+OlMvrr/M+PIGWPmPFMRHZMqZxtFyuW0im+gO+Ziep8x5jVf26hmhmLBJeguaGtO26X4DPSG2+HKZg+6uyasyb0xN3IPbV3IIIPkss30ifcTdp0kGkwg0qrI5+ot9GYjLzj2b0mMpY+1qlz1LJWDayLz0cwDqgRO3bFx3ICnmcwAfqZoLBmuDFc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10708.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(5023799004)(56012099006)(4143699003)(261021121427099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXBrZWFBL3lCY3Y3N1pIYlF0cEo3V1hYc2Q5dFQwbUowOThlRFZrRkREZVRG?=
 =?utf-8?B?RkM2ZlN0ZTJzZzFONHMxTlVXaVdsNW4rNU03cHJyaHowc1BkVkExL29ZVTRK?=
 =?utf-8?B?SXEzQk0zOHZjMWZibTExbW94UDlKY1JsOFFURndVRnNOdE9vczlFckdGcHpY?=
 =?utf-8?B?ZE8zbXhqVjZwSCtaMjcwak1ZVUhNZnBpQUpxRFNpL2lYQTgvOXkxSHpsTlll?=
 =?utf-8?B?YWlNY0h4WVBQbXo2cGlQMVI4c1l6cmhmUWJ4UDc3bWhuQlNyUm44dmdLS1cr?=
 =?utf-8?B?aUVyS1RyK2g3ajlocUxqMVhoTmlldVJ1bER0VGwwRnd6V2tnVjJESUVxYzJ3?=
 =?utf-8?B?Unk5aklxaFgrUEhKSlFzNDdJUi9ITVBHYWxtK1hwOTBCTnlLQTR3dzV0dTJN?=
 =?utf-8?B?WkRHNW1mZlprSDRGaFZlczAvWWFqd2Y0K3U2b3BGckRqREdqUFNrdHp3WWJT?=
 =?utf-8?B?M0p3bnJwSmFFeW15aXdCejVGVDhmaDBsRTJDa2luNUJTNUI1anBKQUpjQjNW?=
 =?utf-8?B?S3ZMSW9wME1neGpYYnkrRldjRnJBaUE4aTBVQ3pGNGFPUHlCNGFTL0pCRkR0?=
 =?utf-8?B?cDV1L1BOOWE4VktwTnI1dkx6dUtwSTZ6NEhPUzdjL2NpazNjanhqbHp6NmQ2?=
 =?utf-8?B?WmJ4Z1hSL3EycjZJNDdsb0lDclFuUU84ZlBYRnZhSWtiSThxUTZVL3g3NHli?=
 =?utf-8?B?UU1UWkVubVNPZHQ2VlNCbFVRRFR5cUg5M3dNbndXN0drMU1wVXJkWmVyR05s?=
 =?utf-8?B?SFBDZEpXNnJIOW9IdlQrcTJLYS9kY1U5dHlXbTNYUDlGQ3ZnVVlNcXdYTFdu?=
 =?utf-8?B?V05YcXdnSzZpcmg5VFJsRGFQUC8zRS96ZWx2cmhFc2hzQjh0eDBiRmkzZjVO?=
 =?utf-8?B?KzFyalJKUDZWS3ViL2srRjlUNG5lNUU2ai94YTFOcityZGdZck5CRDBiRTlr?=
 =?utf-8?B?ZGNvWnJDM0N2NnVnMnRVYkhCb2E1b3QyTUdCQjlOWFljTHVWVkxrZGxlZDZu?=
 =?utf-8?B?cnBuRVFmOHRyWm43V2JTQm5tdzcySlR3TkdQRXFEZXRsdXhtWDdhWG1NOC9n?=
 =?utf-8?B?ZHZiVDJPT1BYck9GVkZGWWtzV3NCQUtCdUhVbmpUaDM3MTgvUHVyLzlSUkdO?=
 =?utf-8?B?WnNpUXZDRFZWUm5wOWhBdUJPUmpNTDAyYjFScnM1TUpzaDg1UXQwUmRyMG5n?=
 =?utf-8?B?YkJZTDJiUUVXM3pPZW1menpnK3RCT1piTG0xSXlyWjVDallxQU51NVkrSEtX?=
 =?utf-8?B?TC9TVmN5eVBvRDZzb0d4RDlKbnNTQXA5aXNNZFVYK3NJSUNIVFFkbFJvalVI?=
 =?utf-8?B?RmtRdmNweUsyM2NrUndwcGNyN1lnTzFCL3lOMER6Zk1TNE5vT3lTWklGcFFK?=
 =?utf-8?B?bVhrWTZ6dGYrclpldThlWXAxRUpYUmlsVFJKSkxXeXpybXpiNHRPNDR0VnFO?=
 =?utf-8?B?bThjZDUwMm5MU3h0VFBhUEdPM2dSV1k2NzRPZ1BidEFkbGc3VjJ3S1BLd1By?=
 =?utf-8?B?Vm82bHZMZVZNRG0rQUNIalB0ZEtZUEhhVW5RbDFwVEpVUkpONWk5aFJPcWQz?=
 =?utf-8?B?cy80MDVHNFViSzRPTWNXRGYzVnlVaUwzWTlPdm92V1J1L2VLZUs5K1N5M3Bt?=
 =?utf-8?B?ZkZ6YVdhTUdZQTJZakNuNW1kL1IyYzE0ekVrTG13WVN3NThOWFJZVE45dFJR?=
 =?utf-8?B?Wk5nUlJEcklUalpmbUh1ZW9LY21qTGlpN0NlbnczNTBYUTlXNjlwR3ZBTGJh?=
 =?utf-8?B?WkJtQXR4OVY1L2pIajlkK2dmc2JTUEdHK0loajJadzdtRVd6VUJISzZYbU1t?=
 =?utf-8?B?TVAxNXUyWjBsa3Z2NlY3YlZGM2dvY29XVlNkc1cvcXhXNEVVdzB1eUNNbVI2?=
 =?utf-8?B?S1VHTll3Q080bytHdjdDbzlrTGd0QUxFWlp6bVF0WFVzNTk0YS9yY2RGWUlZ?=
 =?utf-8?B?Y1FjRVlXTEUvTEZLTlY0ak9PWmIyUDBEbExEKzFpbEQvck5ENUlTeTRnWmQ2?=
 =?utf-8?B?TFloTE5SSFMwS0pidGY4Nzc3YVhyNUtpeGR4aFhEUFA0NTVXSTN1am5xTUNy?=
 =?utf-8?B?bWozbkI5K2dONHVsdHBRR0xtSFBNS0tXNmFmV2VDV09NY1VjdU5UbHhneWhs?=
 =?utf-8?B?dTFQYXZXeUZJZVBsYU9VVzhpVzkwMzU0c3UxMzdzRXBabmdNWXQxUXBadGlL?=
 =?utf-8?B?aGozZW84QUdiQUEyQkhrRkErbStZQlR1NC9qZlBwcW5nVjNvb0thZWdZbnJT?=
 =?utf-8?B?di9DQU5zVmRHaDN0dkprZzcza1poRW85NlJFZUJ1Qi9zYXBBVTU0SURvN096?=
 =?utf-8?B?Wkdkd2wzOVpMTFkyNVU4NmtrelFjcm1GbTlCaCtydVV5d2pyT1VzZz09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c1a9fe-e817-4e6c-b34b-08df30297af1
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:44:42.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmzK/r82wdRxVlLxN+MFiC/2g6Mc0FcAwdzIEKMrHvjtk1LWlqTWTgUE5XqrmMlxwyyJn3p6HdyPrjoipTpUHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5722
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 10:07, Lorenzo Stoakes (ARM) wrote:
>> Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")

> Was this a mistake in d8ef5e311d7b, or actually intentional for whatever reason?
> If the latter this shouldn't be a fixes.

commit d8ef5e311d7bfde54b60ab45026f206eff31b2d2

    mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()

...
+static inline void folio_dup_file_rmap_ptes(struct folio *folio,
+               struct page *page, int nr_pages)
+{
+       __folio_dup_file_rmap(folio, page, nr_pages, RMAP_LEVEL_PTE);
+}

...
+static inline void folio_dup_file_rmap_pmd(struct folio *folio,
+               struct page *page)
+{
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+       __folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, RMAP_LEVEL_PTE);
+#else
+       WARN_ON_ONCE(true);
+#endif
+}

Both functions were introduced in a single commit, i think it's a simple copy-paste issue.

The helper never had a caller, so nobody could hit it. If you prefer, I
can drop the Fixes tag and only mention d8ef5e311d7b in the changelog, as
there is nothing to backport.

--
Cheers, Konstantin

