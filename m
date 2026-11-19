Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949760A382A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GnxPeWsk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVNXZ6L41z30T9;
	Thu, 19 Nov 2026 14:01:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795057294;
	cv=pass; b=cBGfO5c4rYiv4n///fb+J0FUXpbQqgbphMtMbXNQV7gAIiYo+1gXl9TFjA5p/Pq+aSlzKpLPCqQ4IR+WpUaoWgJA8t9jCOGpKljNXoikaYm23hJK/s4cr1qlK4BnmmEqHh8zcBoM4wiVSZ82cv/X5F4QX5s8LtlaPr0NJCB8K6k8WTXv3KKt5/2AYKw5ujwH2CICb42vNX0KSYuuecIhspGGdKgOyxZQYoD7PniPf+Z1RT0T5vSUBb6tNMjBf9yEvPo4HkmkIcNKGSzuAJQkKmZlPJVdh9UYrzlFKVHBCiFySBSYjfwVg08IBwfNVNR4kDMRTgR2diLBDcHnrrNGHg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795057294; c=relaxed/relaxed;
	bh=64trQo1KQ8ygkGba2mybltlcSBlCEqQWRKRhxCQ8dTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hVRbd5hXwVJ8Td3gHsVS4kU5NKtzgtLE+z2gZ4KiUFXRb0GAht3IHpbsOCQ5OP14/Faxy/iRXiJ3xtBZf4WTz8QnPQWXKuseiwBHHUR5D2vznW4JPWPEEksrM+JwaaXVlW/jGspUL0j2uVMAR//wm1WMFX2fkdFp4wjmWQTLx5icbsZCroklM6HvY81PuQ1djSN0wzIJ78xPcx1laVT9gGy5qkAeO9XkfRyiqxuG+3xbRbwSM5rPYhJjDFF0zThv4Z79aF3KY/kW3/mi+9eGySVxZ8uDDMHh2Ucvys/53NS9XyOP1EDuB0UMTS2oqFTtYJQrXwX3Uztn9+yfaGFG4g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GnxPeWsk; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GnxPeWsk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVNXY4HTFz30FB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:01:33 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wg6Mgm9TN8NTlT604mQBSzeaPqYBigHAM3omwu4v51p4puXEpoe1Qgqal9UqVsIib/e1JWH/d7boF8xFIvVmanqWKuGg9FC05VeR2rd4uNHbTxm9lkenJ+1BDY3U0lppHJojEGidCQrEKNrlbJik3qqKaGCOc2+tMX+ibGOa55cQyzSwlrBRzZKzhVZ5fMTnwxwPK1IrIWMCyNKgA6KFHPD+DHFFSqT1osVgp7ThS3CgrnCDwWCK2f1ohDFBVnUglY+Yxg9CqA9HuProsqMVBFWHwqTqwjlSOyYR0YYBthr7D6IySv1IMhcmXw33o0waBVBCPZ3kbdiO8SO76LB8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64trQo1KQ8ygkGba2mybltlcSBlCEqQWRKRhxCQ8dTg=;
 b=EFrSYgVZC11goMKpgdee4TIYt39XzZmgYXPxyNiIWAkHmkg5dlYbchGrjRVoAJ6jEDU2q5Xw34sx8+zGdaTuUck50kf1ZE2pBTP+2Dfyw9D8EMtvTKXkWSV+FpnpqLtNiDnGaH5/tqzd5Ddw0iWZAdwz2zoz1KAQaE9Gkwh409BiSx6lASfsKacKpVvCsfYBw4uy1dxOZS2hUpRObAdwBLCtka2rGE2sASgbed+RnRT9TldfFfGH2/0WoBFYM7Tj0aQQo81j44erlEgDQBHFp1y0rXMq9nnjybKwlcmna/f74ImSC8sqKo9yXL7TFUGw/jRK6s02C5Oe4oj0RKbMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64trQo1KQ8ygkGba2mybltlcSBlCEqQWRKRhxCQ8dTg=;
 b=GnxPeWsk4f48HA/acij968SKwtsZAY1pah9A5tmRTDSozGhkL/ck/mmZdYdU5rOxEt5CLyYXxxDhl6fln7E3cxioaNVcnUZ+YAQ1+MByB1USj4NMb63ht0AWz629fIDu1hkHlXhmCJcG6F4wDwAkxFaTf8kY2SSE/ePzlAHlwwbwSmGq/dDka0bhzr/BKm8KbmYRknhaF3zO/qJI1IIOOrvgYyltHOrbsr52mKImed34ZFhjV0P/zOGdnyD6b9cSrMXSluEqb2EKMvJCtom/m09GMjs+05QXBQPhqxun73ykjFBgbIn1zh3Ykaw4rsmSStLFXAnKsOZdtAv7dEF7eQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM0PR04MB11880.eurprd04.prod.outlook.com (2603:10a6:20b:6fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 03:01:14 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 03:01:14 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	linusw@kernel.org,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 net-next 6/9] net: dsa: netc: check return value of ntmp_ipft_delete_entry()
Date: Thu, 19 Nov 2026 11:05:31 +0800
Message-Id: <20261119030534.1892935-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
References: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0012.APCP153.PROD.OUTLOOK.COM (2603:1096::22) To
 VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM0PR04MB11880:EE_
X-MS-Office365-Filtering-Correlation-Id: 689c253b-4037-4bfd-214f-08df45e95f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|376014|1800799024|22082099003|18002099003|6133799003|261009223027099003|3023799007|921020|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	oPwYU/oNoRZ7DzLUIJ7TRi1X8moiPe/kNm6iKLNtl7TjUb16GViOB2ICGcgmGby022ihcKPz0CxaoVs/lO0w5ZKiq1MIIBsFf6H3ZrhuurxioAKx/+UvaV4nfUSkIq+ziX+8Y/v0kbbcBh0ZusJMn3iLR6xjyMz0cBjaUIF9Mi5Sas1NpIkPOexx+GJp6gx2PhD8o/QU4iTQKu7AJ9wGNLlmI3Mcg7GRc3u8CPq93cE70ycdsRMXAX2SISK13CvvP5kIqNuptZbMgE2KrWhOAeXRH/OcGGlBykyu4l/MinSmTZbw3QkqA1xPP3NPmfmBW/kXh2sN4+69ife/9HlYmoAYS8FwnazZMiggAnR39VOsBojFSWIO80OvcGITwTTC6nf6EJTw0Fktq20C8fVrn4nTUKzBrSc8fA5PIw+3T4TL4pfOwdKPsADSmmgF1Fe21GTgGxrOT+W3XofpfAbGEywYtEoPu4MzjcOy2e+RWmso6cOESpOC04Pt1BLOuz8yymgtMxKb6KqxPaSwL5yh2OsvpBQ3CJMLTw8DCt50nfa8tesO+cNBVye6BFAXnjPFkBIS9bNZDHX0BEYkm1xgG8kjelA3axhURuMO4KVuM3qx1dEEHx6MICWyvd7hgiynUjDQjHCKmda2hbb1YwsQukauaTaKuusadELzV7nKgOpYXUp7NUNEazasF+0vO4XhuxPWajfnScZsxfKc/HRQlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(261009223027099003)(3023799007)(921020)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6hNzUVt1tSyOc+MbJRim22+CfBH3+HUPycNwhieFc9KVq7S39ZXbKLgkGeyq?=
 =?us-ascii?Q?KwCe3rANK2wEDB3TbqTb9ND5izveC1UxFw3JhALJUYMMvjzblVUw8bDUHAwo?=
 =?us-ascii?Q?/ul5d0LkW3/IM0evxKUMcUqDoVdajbedK738C2TnnJjXpuZELRsW1KB25XCu?=
 =?us-ascii?Q?qVtmGvUN0j9cADM2X0CwWJISgC3YQ6iX9a/ZW7kQ6sZwVv9HItYcetEUQeKK?=
 =?us-ascii?Q?YAA0OfnIwgggJ/ipxparlbSm2GlrNQlAHoBof61PT+yN5tyW5fNieAUXCZzL?=
 =?us-ascii?Q?uwFQwP5J9LZBa57IPaA8+dFWbgczcNpnFmdJUXQASf8wfEqiHChVXmTgO/Bw?=
 =?us-ascii?Q?X4e9MkF+P2x3mdSMvvzZ7cxIVOLyZXzMEr/Lzk0g37LA2hPio6Bdxik+8xWp?=
 =?us-ascii?Q?+5VZ4N6YMcy2Zc+cVuqjYwpHJFsZs6giBJjorFsUQTmLY8YUa+tionjkXqc8?=
 =?us-ascii?Q?0M7wIwhKNn+Z+g7pfbcy5suaK+tAr7lHNcvbTZLB45lryy/NEGVmYb8lRpnB?=
 =?us-ascii?Q?5rL8JsnD/Zqk6KxhN3ryB3LqJ/HjZ8oYRvnPCqsgqR5ShCZoCpDF3HeUGkLA?=
 =?us-ascii?Q?DIPerBSAMkBFzEKKCn05hlPswDoiO9Wn3e1UzHc6LkmeJUzpDpDo3LjKxW8f?=
 =?us-ascii?Q?h4/6pZJvo1p+MC4v+pfyCEqd2hVJmqT1NjdEpyyFfWzhBxgd3VZgcGzKtoLj?=
 =?us-ascii?Q?dG+k62dv/6d9MwyA5Xh7RMJsYfVIt8TTDBiqbznK2WAmZE+7zVZCrZx7d2uY?=
 =?us-ascii?Q?isuuhMoEvs6Mznhb6hCrpq9oIiGt223c2/lPSbui2lYysh0WfwGx+bLFc0ws?=
 =?us-ascii?Q?MywS7xsRtSpLCoM9ATaS9gCKyIHt8tt8FPEw6PlzuBe/fwqY8wl3gewCxBPa?=
 =?us-ascii?Q?28wII7dS9VCJQkLEetgk4ZXKpgccSHZZfuE7Rxdkp3mGv8QnWHKch+Z7ukBj?=
 =?us-ascii?Q?64Xs3nlG3mj6zi+4JMfpgCsFH9DtmyqGJapIog1Y71ix32ls9B6AsV2q3Dm9?=
 =?us-ascii?Q?FxIPgyg+8unsQwIpxZsIB1pzCjgKv1v2sRWF7DyF6BvVeEIJC5Iv9w4bybmP?=
 =?us-ascii?Q?OtyFpzWXF1InOrhLki+V2u3hH2GzRMFAcT9adSiRECUcjGQzvi9mKx64RcsQ?=
 =?us-ascii?Q?5/vx7vxeaV6mk9WeuK3yCTCJ1A96jM3ZtPe2kiR4qSCfuKm4nUQvo9aNY1Pu?=
 =?us-ascii?Q?UB0W35oC6EebnYR7s4sjQJ5s4IzDEIfNX1kaJVcGqIambDcVpOgIxi1i9RKf?=
 =?us-ascii?Q?15lFKlsNX4WJZjhUddlKDOJf44D/e/5g/y0RArn3jzDyM9vMBiEAtYnNs1Wf?=
 =?us-ascii?Q?6almfPGacjZXIy52gSVERwi7TQZHYik3N9AyqPjdB9tD1iBl+BnHYCXD3h7+?=
 =?us-ascii?Q?0dD0wLs0XD4aoZFJc4bAQB9isUGyfPt3ydrELRLweBttxZYFgA8iCYPPDW2u?=
 =?us-ascii?Q?ZuuYShlvwT4uo+K3/rUfHmDDwQ5JD5GqQqdCFxNSbg961EmtWejx6GXd62eU?=
 =?us-ascii?Q?eQBsn9tbSp1S5+1cV03spkXh6kw7o+sHoW6FeaXdYPHhIhuIwnt+hHghSsZT?=
 =?us-ascii?Q?by/4Sf2ARwmJVShVhEfsByBnLGbnAM0uzIBT8hlFEhoZMKi5Q6PnsCp2fTw7?=
 =?us-ascii?Q?sadWbWrLxniO56RhcvGcGTTYT9wYPcG3Ury/N6JwpKfhQWdvGI4lg0gO0oQX?=
 =?us-ascii?Q?C4l/EO5B92/pweNXAfLE1rJqhn34XUwq2fwxScAIe5TY8bvQ3c5V9Is541IT?=
 =?us-ascii?Q?XB75Qb+5MzMS38+xoUFG2TC5N/hXrR3JgGUiQp9cPZZhLx9NXcYi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689c253b-4037-4bfd-214f-08df45e95f4f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 03:01:14.0561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2KHIK9ea1C7/xdVZWoy1jVy+GKEpg+kcCHvvmrI0r/R0SXFfJc4RefDHgeKRhztP1PLVOMj6P+KODw8lSjGVVv3I2q7yopNNjYmAJHEl+p1VOdQEH0S8wb5R75lNKzA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11880
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

The driver ignored the return value of ntmp_ipft_delete_entry(), so a
failed deletion left the IPFT entry untracked and impossible to clean
up later. IPFT is going to serve more features, such as trapping PTP
packets and flow policing, so make the deletion path robust to prepare
for these future uses.

To this end, propagate the error to the callers and update the driver
state only after the entry has really been deleted, so that the
software state always stays consistent with the hardware.

Once the deletion can fail, the order in which a rule is replaced also
needs to change. Since IPFT does not support in-place updates to the
KEYE element, replacing an existing rule requires deleting the old
entry and then adding the new one. Keeping the previous add-then-delete
order means that if the delete fails, a port would have to track two or
more stale host flood rules, which needlessly complicates the driver.
So switch to a delete-then-add order instead. This order is not
perfect: between the delete and the add there is a brief window in
which packets that would have matched the rule find no match and are
dropped. The window is very short and its impact is acceptable, so this
is a deliberate trade-off in favour of simpler software.

Another issue is that if adding a new rule fails, host flooding will be
disabled indefinitely. However, there is no good way to fully resolve
this, because port_set_host_flood() returns void and the upper layer is
not aware of the error. So if this corner case does occur, log an error
to help users find out why host flooding is not working.

Note that, a delete failure has never been observed in practice and
is highly unlikely to happen, so this patch is an improvement over the
previous approach rather than a fix for an issue seen in the field.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c | 83 ++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 7d0893bc0f163..e1ec7aecab0f9 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -1825,14 +1825,8 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	u32 cfg;
 	int err;
 
-	if (!uc && !mc) {
-		/* Disable ingress port filter table lookup */
-		netc_port_wr(np, NETC_PIPFCR, 0);
-		np->uc = false;
-		np->mc = false;
-
+	if (!uc && !mc)
 		return 0;
-	}
 
 	host_flood = kzalloc_obj(*host_flood);
 	if (!host_flood)
@@ -1880,32 +1874,36 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	return err;
 }
 
-static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
+static int netc_port_remove_host_flood(struct netc_port *np)
 {
 	struct netc_switch *priv = np->switch_priv;
-	bool disable_host_flood = false;
+	u32 entry_id = np->ipft_hf_eid;
+	int err;
 
 	if (entry_id == NTMP_NULL_ENTRY_ID)
-		return;
+		return 0;
 
-	if (np->ipft_hf_eid == entry_id)
-		disable_host_flood = true;
+	/* The command BD ring is always enabled here, with the ring
+	 * enabled, the hardware completes a command well within 1 ms,
+	 * so -ETIMEDOUT cannot happen here. Any error therefore means
+	 * that the entry has not been deleted, so keep tracking it.
+	 */
+	err = ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+	if (err)
+		return err;
 
-	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
+	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
+	np->uc = false;
+	np->mc = false;
+	netc_port_wr(np, NETC_PIPFCR, 0);
 
-	if (disable_host_flood) {
-		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
-		np->uc = false;
-		np->mc = false;
-		netc_port_wr(np, NETC_PIPFCR, 0);
-	}
+	return 0;
 }
 
 static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	u32 old_entry_id;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1913,7 +1911,12 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->ipft_hf_eid);
+		if (!netc_port_remove_host_flood(np))
+			return;
+
+		dev_err(ds->dev,
+			"Failed to delete host flood rule on bridge port %d\n",
+			port);
 
 		return;
 	}
@@ -1922,19 +1925,26 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 		return;
 
 	/* IPFT does not support in-place updates to the KEYE element,
-	 * we need to add a new entry and then delete the old one. So
-	 * save the old entry ID first.
+	 * we need to delete the old one and then add the new rule. If
+	 * the deletion fails, return immediately.
 	 */
-	old_entry_id = np->ipft_hf_eid;
-
-	if (netc_port_add_host_flood_rule(np, uc, mc)) {
-		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
+	if (netc_port_remove_host_flood(np)) {
+		dev_err(ds->dev,
+			"Failed to delete old host flood rule on port %d\n",
 			port);
+
 		return;
 	}
 
-	/* Remove the old host flood entry */
-	netc_port_remove_host_flood(np, old_entry_id);
+	/* Restoring the previous configuration is pointless because
+	 * .port_set_host_flood() returns void, so the upper layer cannot
+	 * detect the error and the RX flags have changed. Furthermore, we
+	 * cannot guarantee that we can successfully restore the previous
+	 * state.
+	 */
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_err(ds->dev,
+			"Failed to add host flood rule on port %d\n", port);
 }
 
 static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
@@ -2099,6 +2109,8 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	struct netc_port *np = NETC_PORT(ds, port);
 	struct netc_switch *priv = ds->priv;
 	u16 vlan_unaware_pvid;
+	bool uc = np->uc;
+	bool mc = np->mc;
 	int err;
 
 	if (!bridge.num) {
@@ -2110,6 +2122,12 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	if (err)
 		return err;
 
+	err = netc_port_remove_host_flood(np);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to delete host flood rule");
+		return err;
+	}
+
 	netc_port_set_mlo(np, MLO_NOT_OVERRIDE);
 
 	if (br_vlan_enabled(bridge.dev))
@@ -2123,8 +2141,6 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->ipft_hf_eid);
-
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
 				      READ_ONCE(priv->fdbt_ageing_delay));
@@ -2134,6 +2150,11 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 disable_mlo:
 	netc_port_set_mlo(np, MLO_DISABLE);
 
+	if (netc_port_add_host_flood_rule(np, uc, mc))
+		dev_err(ds->dev,
+			"Failed to restore host flood rule on port %d\n",
+			port);
+
 	return err;
 }
 
-- 
2.34.1


