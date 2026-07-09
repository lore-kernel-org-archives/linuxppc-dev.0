Return-Path: <linuxppc-dev+bounces-23876-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9D0C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 02:03:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwdYF555zz3cX6;
	Thu, 09 Jul 2026 12:03:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783562625;
	cv=pass; b=hXcJ3+Ms8mtBAf+jXmyzUVF9Jj7hgOhDPuCAXQ8e9o7croNfuAejpewhgBbiAgoqGzV95mUN6o2e1xREn6F82z1MI7ma/6nRme/PS7rGIq1utNTIz8Cb99Bogbvm41squrgZHlQw/JyEUVSXF9hgxLb5MDgjlQHAt9lmh9vRdpiqOMwD6VjAOZM6vNO9dkW8OaEfxHStVqYgfedZJvkzhyOatnsxYPrALhd85v+e+XmcnBeKAyl+YtD4jqnIM939AsYb+d0whhjrXiWFj/C5FUWOE6UccS+ZsaUug/xlXNvnPtt7lg8KcE2F/+ALXb5NvkUpr9Fmvp9HX+qQzdy15A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783562625; c=relaxed/relaxed;
	bh=srchqatlx5qMcQox/Ma29ZACWMBoLLiqzu/saDd1LxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aKy33CrHMajxrb9WZFl6ErT9F+h5gPLqr7QZ1x3A1WFkI21P6c/oRcpKpsMW791mYmOQYg8AwDpJHQb+aZIM3RBX7ThMYgb2UsqXD/06n2FX0/7esbg5s0wJiGrFio1s94FP0mOQc0nmT3V9Sp0H12kP4L1/bYxvWaNBjNodnVNSXu07MVyFsaSxwAKDi7tIBdjAfBjNEa1blFh4IW4kZTJnDLUPQBIiXhSDlH1VLSK/9eyN5HxFPd776CRBQEEGWNM/stC3NMkA9/Skcc+RWn7fxhdDjt+jJF1q/IS00lJ9ToujlcjKVQ/5PK0eU2fWxnPai8UmZfboDnV+iQ2Vkg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lywOzOmN; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lywOzOmN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=ynorov@nvidia.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwdYD628Fz3cP3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 12:03:44 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yP0gBc+f5IhFZTUhPEyHHHOvmlIHIlztusP92N8eXVxuJ6rzYehLAIl1vFdlYf7XQ8VAOuxtDCTvh4umuYdd7ALorihc4V4X1CtG9GuSZp46EPFNZZR45Bfmcn3yCrEtl3XMvlqsH3nKqTa0ZCplBtYiTchiJnFC5eVbNQ5l88Q5AxUYYpP7h81wuhyA+RRUGxeIXblZyvqdTyUBliv2fUT3jKh6ESN/hksOCzsSBACfJZynk/lpFgN8kx5ZFFhdOa9qaoduPFwPLBKogJPeDzXVEfrB3ggyNhl3EQUmw58ONu/26QEmmgtO+/DvkK0THlgWN7hJvWZ2rafoLAiv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srchqatlx5qMcQox/Ma29ZACWMBoLLiqzu/saDd1LxA=;
 b=e6/B8ygdcjHba3S7DsIHKPqDt9oRaCv7+w7MSdv7EB4ftqaZ8P74BgXMRv+qAhHiOguFJvV7y06aSfTnJYwWKBKXna8Ca6Hw0FuslWErWOGy6Gbl/YNet5bkL0cspVP287wkzenGjNh1mhVo/rOa/1nyeceE7gRp3pzFb50+XUrrHA73a0YCBBPqia426x847tngKxOCnJyTIiLJ/QR4HFACZKvLQv5X0qHlK84VyUDUdry6knFXzRnVx12q9kCzuTGaiJTv0mXF6Fi5O7XOoMuLnZyNV5pFN2NY6tmD2ZXLiZCp+jRNAOxvjcak8IAi4O8+U1U5wlNtOEp2y597pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srchqatlx5qMcQox/Ma29ZACWMBoLLiqzu/saDd1LxA=;
 b=lywOzOmNiDImAdZL3qjq7SyeW+kNjfX/SV4NAusHEdf7sIiS3pd3HsyPrU/zu65uU+/Lk7gZQRRMVa9566iEnDoXq4CfXCxa3Yir8r4hLuJqtwibLGJveHZP90zW7y44JBhKRnME3byqjIgipl5WNBbOBzcDgim8/V6zwLArFl2CpTACuMCIpI/2mI3C6dZCIOtD7ZD19MFF5VjMpKDbjWhyWW9rto115k6nqFSuqLyZLlWBl3NukEc7juUU98SXTQovngCrMG2xHdJeRgIRvLJouLK8PjyJqg4QtcNOqM6fhD5sYBnz26dG3NqWFIUqZoTA1LD9STuENzEn9n7lsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS4PR12MB9818.namprd12.prod.outlook.com (2603:10b6:8:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 02:03:30 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 02:03:30 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Russell King <linux@armlinux.org.uk>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Allen <john.allen@amd.com>,
	Kees Cook <kees@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Yury Norov <ynorov@nvidia.com>,
	sunyi <279644543@qq.com>
Subject: [PATCH 5/5] bitmap: Return size when no zero area is found
Date: Wed,  8 Jul 2026 22:03:11 -0400
Message-ID: <20260709020312.133977-6-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709020312.133977-1-ynorov@nvidia.com>
References: <20260709020312.133977-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS4PR12MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 72be6ac1-bdc8-44bb-6773-08dedd5e45ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	LsOcIeqqiHyhkbV6lSaxWcaUb34rVbNWLZj+xInMg8gryLxVP+k31mg8W5MukFFsndKc2f+HECqFOPTOSJHDRzHiYKJ53X8DSy8x/0OGmZyScBCUaD8n/oO9GpR2ngVGLQgyEC7ILfuXRwcvJo6TElOX6bXajdM6dFd7YIBcx1NaUeq41Yx9JN//Z9kxMf/BUWRu3Uu1DbaN+we9ImfkBcI9kusxMKGcHMaWu/2J9MgDN7mhotxIUOd0i+WBu9OnYYWl7r+caB5zL9SSqUL6UVq02wkJq+XLV9b1XT4PVrUdyA+RwJnnRQVx6tOiSFkPicqn89zMjSLvUAaUKHuehtha/IvnE5nPnPT8P1qmO0sFdACyhM2ORrsz8k8AFJkjFH+PGmTVjVtDsmq2IYjG7TKotPZBVG1Y6Prs7EU1l1YkaNEnxpQN93nf0td+cyUjvU6ms+W3Mv/oVGRJsbawY1rBDy2HAnUcQnQSRIVvnmSJze9CcLY/RNjdzpDa9e1sPiUDBzQGuRJsuGs4PD2dudZVOPStL5KcCRZiVsPhTTqqR/okButTeLlhTyyTc6Vf7fyqPcLf9D7/1JeOPt5KpgfT0sGlTWecW8eP0Zf5SxtaoQ8QnZeJZO75zfRGPURPzFEiC1ezDq22pR/J7ZFiBrIlvlAMf/qDlSGmUpQ84d2CH1EcpRwJZl2szFlH8MD5vdQQ1nngYtCUw+AuwCNUBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iyP59F4yoSaCY2+Rcioid0EthMdmBF84TUfhB3i/qzjO7NcRwg/azatsprY/?=
 =?us-ascii?Q?vxDtJ83JyCj8A0uqbCf482ZJqArjX59f6tl0JLfTZpk+tbge2xIQL0qVVHD8?=
 =?us-ascii?Q?WTF3TFOWcDkHOe3OzVtWGIJiQAhr9KoU4Mthw2aPwuK6qzMJfDjFoUsvPoc5?=
 =?us-ascii?Q?9Cy3PFyv7GM7XfRjOTjqQmu6b6xhlAi+TMzjF4uLM0K0Dh36kEiv+ZU20wSf?=
 =?us-ascii?Q?WYssjTrrp1OLID3zGaVEIHQSUHGh+8r65Up70fcF7mN7+m/w6I83rmMYJHmd?=
 =?us-ascii?Q?MMGMJR87qPh/y6RMmxEf0Czp6hdOsA/u6m2eK2/McBSSwvG1kz65M9/zDAId?=
 =?us-ascii?Q?ep9toZgrl4AMo+bWNGyl2vyzvuuL4HzMddOG2ZrkWZgeyPIT8/FAVH9w4CVq?=
 =?us-ascii?Q?j5GkySFSNHGzH8I8dD/qy/w6xQthftf57rk0TO2y/wchmMSAoThnH5BvNilI?=
 =?us-ascii?Q?RPK8rHKsJpglHP1wgEtOfKWAQP5jbvnYdBPuzKQIJERP/+c39w0YN+GvHOVq?=
 =?us-ascii?Q?y6p3JDSQLyKhJR7Gni+xixFV2XtawSr8V0PN5/rzJrOfNTowlgjtZo2GJbqv?=
 =?us-ascii?Q?smxeFTPZGor4fjL6wn9DiMmO+Bii/sBH2FiC+6pt5XeevWAMnnh7r8E1oDa3?=
 =?us-ascii?Q?RLo7ObDDD0DKDEI5jkMpVenBmeuHo8RgdVWTIHojL824xGkfTJzysY1JKWGL?=
 =?us-ascii?Q?TGoL3yaQBKJWx54zdpjlVegzcsiXDRGpxVS1gKHCPLOC8GAIamMQtIdNVdcF?=
 =?us-ascii?Q?THIZ8ygL4SKeXYJ8X2e/5KoGhXr03fTdaOfAImk7P59pkooT/PmRHS+/bC7W?=
 =?us-ascii?Q?s3y+QKPbu96UlgQkjXq0m9eAR00cMH/85bqw8NXp4kw9D2MIw39RgOHEJTnc?=
 =?us-ascii?Q?PEtZov3cdn1NCaFKB7vfm6FupOqgbN25eA8e9vMClmH+mrqSvmFH8rRV5Pzn?=
 =?us-ascii?Q?yOHSVOBHn9yZPDikElynHi9HpiIIZFJZY502/lxDVUh2BP5vsW+lQNR/H1pU?=
 =?us-ascii?Q?wuNe78d+blNA2bz51RTGDU5FaTkSZ+gHVn5I56kkQ95qMJkIM7gcEa9Cj0PP?=
 =?us-ascii?Q?jDnU/a01iRvHD+iLogqdaCQXFHirLM4oK1LT+GDzDUU7C4QOcB8vVlVz1a/R?=
 =?us-ascii?Q?G38JCJG/ca5cCZU/QAvzV2PgQw8Pg2DaBwaBA9GARY4ZannHOt5bGK5ilii2?=
 =?us-ascii?Q?neURdnYQ8u94+vwPtsTCgNn3hEKxQ7St/S50b8dMnrSqHx34H8r9UUdRwEWz?=
 =?us-ascii?Q?AYDGr7b9yS4kBypx+x7wwUtCswcAlk4EvZ5RjJvI+PSEBEWxDo3ffO0CiH9M?=
 =?us-ascii?Q?ONeaTriKt9UEwgxRiHUWpoQTa/BMVQfY57gMonoyHTHqDfJDZzUdVRIsQfKk?=
 =?us-ascii?Q?guKAbOganx1nK6/QdcGQDg5PFpR2ozWsD0kyPH9jt5jH5/5jaw46w0YrHDCN?=
 =?us-ascii?Q?20Fl9oJls6is69lU8M6H8iZIzzpDgsn0VTfCetL0qOxrFR/a6Kp4Lb9eE9H0?=
 =?us-ascii?Q?MtG/hWNSnJy8Dn1DIb2IYlGNKhpp1WIB+C1EVPfJFhyItFanfRRkT898QpvH?=
 =?us-ascii?Q?TKKP2g0jXJBFPKsdN3yqubrSMsdV6plF+lG7eczrD4Na3aAWnVHqzWL5DxO/?=
 =?us-ascii?Q?0WK4WHbxH1lHGjaCTmcexd9nieauCmoHf41G+r3DgvclD/Sl/57/DwgtlOsj?=
 =?us-ascii?Q?M7Neq7UH7ifN2xWv3ycSp3zmGtJXEd6wgOY0sr81GfTLsHNJskjpCVR5ghZO?=
 =?us-ascii?Q?+ofS/i9Y2Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72be6ac1-bdc8-44bb-6773-08dedd5e45ee
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:03:30.3829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQVqMSjjnq+3AgrsBQKXSLDKZyBhf89flAUk6vVYbqipua3eP0gJOKJAEU6P3ScS2JeWAiYQIO/S8cr1vL5JGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9818

Return the bitmap size, rather than size + 1, when
bitmap_find_next_zero_area_off() cannot find a suitable area. This
matches the conventional find_bit() failure sentinel and still lets
callers detect failure with an out-of-range check.

Document the public failure contract as a value greater than or equal
to the bitmap size, without requiring callers to depend on the exact
sentinel.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/bitmap.h |  3 +++
 lib/bitmap.c           | 10 ++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 8854acf77869..33f175a30304 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -209,6 +209,9 @@ unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
  * The @align_mask should be one less than a power of 2; the effect is that
  * the bit offset of all zero areas this function finds is multiples of that
  * power of 2. A @align_mask of 0 means no alignment is required.
+ *
+ * Return: The bit offset of the found area or a value >= @size
+ * if no area is found.
  */
 static __always_inline
 unsigned long bitmap_find_next_zero_area(unsigned long *map,
diff --git a/lib/bitmap.c b/lib/bitmap.c
index b464d843f4eb..ed685127a107 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -424,6 +424,9 @@ EXPORT_SYMBOL(__bitmap_clear);
  * The @align_mask should be one less than a power of 2; the effect is that
  * the bit offset of all zero areas this function finds plus @align_offset
  * is multiple of that power of 2.
+ *
+ * Return: The bit offset of the found area or a value greater than or equal
+ * to @size if no area is found.
  */
 unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
 					     unsigned long size,
@@ -448,12 +451,7 @@ unsigned long bitmap_find_next_zero_area_off(unsigned long *map,
 		start = i;
 	}
 
-	/*
-	 * Here, returning size + 1 is to maintain consistency
-	 * with the old version, where the return value is always
-	 * greater than size when no zero areas are found.
-	 */
-	return size + 1;
+	return size;
 }
 EXPORT_SYMBOL(bitmap_find_next_zero_area_off);
 
-- 
2.53.0


