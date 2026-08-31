Return-Path: <linuxppc-dev+bounces-26255-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1117DC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 08:20:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYMP04Gfbz2y2J;
	Mon, 31 Aug 2026 18:20:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788164404;
	cv=pass; b=kSnFcf15E6MoymTtqZTC6cSFLxhOz0aVLrDKZqrjrnAtMM5ZxpNqXeZSC856OdYxQUwFZDRZ8SVPml1nywTAGy7cLjoukt+yfVR+xL8QX6lmrL56wJLpXB5BuuG2eoDi4aOXV08WXnTWKhwaruTOJ6vtsOV1AcwU7E4DoyWFQJQo57hxtetdyceotR/vAX0Y/TMtzhPII2by97X43TrXCcIeuZ23S+LGM4J5LjMKegHN1g1WvanGFxAVpqq1/bvJsewlRK3AJm4+rA0mhHVxwnCQDDmzwP/G3JvP8HEVM+vm7Lu/bqmgXw4zgcEDIjF0prVodO14a8m5y3IQClQ+3A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788164404; c=relaxed/relaxed;
	bh=/1F1XUZsEvCOW7bQdCdNh5B86sIPtyCvmSruztoQPL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QxpwVZlnqTTcVY4OP1veiRsKOFwZ3b9Pg0HDo1opplJ40hNaTopX8f0USkqH7SEd4z8wS59O0Gomcp9CKCmv4qi1NnE3/2Fv3/JiCiiSHEdOCn3gZd5eUZ9qzuhMd/OCmg9c4iyhq7rRC8kGmgc4onq/XKA1YdYubwWdftLaF37r730z8VmFhucENbObI7jTkydkIR6K1lhnDxlOQ1k3re9/LgvBcjctKmy3ld69Lr8Ad5h73EhS3nCcEIdgQGxANYzfE+kvqPdwsU1zUQJRQ0F5EAMLUQP5AdWQflH7KRkbA1/DyL7QH2fWVJjx7MnaAf1+Fi8uxfC6//QUtKMVTQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MfvQqg6A; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MfvQqg6A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYMNy6FhWz2ybK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 18:20:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=leX2ppka8IxUYzcA143eqQJTpLkRfq8k1F8olXzfWclC2UDQjIdyQYk/vMnVntfS607hIEuUufJ3ZVZGjDSsVuXWle7hli5qbkRRyelUvK4tR3NmrbMk3czPZwekYEVuvg9fx6GUx9OFMnqSjejkpf+1rPJ4E5kI2nzC5Qr9iNCYSF8lZe2R+9csslQrGMlt1sm4rp68oRczMR1DRdCBnxnoDyLhqRf22eb3QbVHhyy8qRgj9hW2DWz3nsSdPPv4M5slm13sXD+6ipKaRzwi2tV+Xdf9avxQuXC5qkk7zWdg6Hi7o4Av7cbdWRaXsavVJFpAKUWcR+4FDdUCTzrQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1F1XUZsEvCOW7bQdCdNh5B86sIPtyCvmSruztoQPL4=;
 b=ZUlyRKwT7SGTK7oBC25frsXTQA3qYPdkydE73jEHTyTQnrxQwLanVIKdc8SWUTPsvYrAA+g3anJT6avP7I92UGz0HCFGnp6ad5VtsOfQXpa3Ndx1rq4UvxNXXS3v37I8RDX9BWy1hrDudlp7UOT9aeICIoHzpfj5HcEy/rZQ7dG2wmb4lKk6oqD1iMvHqVVvShHjfpNWBdGJs+HouNO1Jv4r7mRFw0uO7p8/ckRYC9GYbi3mz97P+OFH4OppERYdsipzbHPP25JHg7Mc5LRobZ2Wh3Sz+XbHsxF6yeg3ePBgb1PK3ev8lfPbwDKhZkJYrkN+KYEMBuJ9Pe8i1FwMgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1F1XUZsEvCOW7bQdCdNh5B86sIPtyCvmSruztoQPL4=;
 b=MfvQqg6AAeb0ZEprIi+tHe/XlMMCM9CkKHhf7DHkRsYiSszv+t5z51M1jWlSIQ75EJeUx+o8lCXZoKXjEAkkWT+h/CuMhein1YK88AOptAJsD5Oqd7jOvY/y03YiGlu+mg1mlaSt8MuIE8tHre+92rKzTqQAAYOTQlgr9vYbV4lTdQpTe2aKPB9zdHSx7zajlFKUlkN6yNDaSL8Cv6PyX5wy+n12PlejgTWT3I8HNaBVoXREFh+TNRo8rqJSVAUNz0f+vdiTTawsBLkiqTbtd9/Fr4VBP3l/lZW268m5buTecD/G5UdAX2pPHeR8mz1u1akhcNedQxL8wNWlJhc8Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM9PR04MB8440.eurprd04.prod.outlook.com (2603:10a6:20b:3df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:19:36 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:19:36 +0000
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
	richardcochran@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 net-next 1/8] ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register access
Date: Mon, 31 Aug 2026 16:23:28 +0800
Message-Id: <20260831082335.1184605-2-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
References: <20260831082335.1184605-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM9PR04MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: b3274eba-ea85-4869-b0c3-08df07389815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|19092799006|366016|23010399003|376014|18002099003|22082099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	s7n9Zp504odZRaO6bWDpnNEMAywXLHYUBdVZXURkQnLvOzArs4/AIHhASZZCKG7fewsbMkkx6GytzgQ09eJRyFOEk7zVCtMIPiUDFzXPl8E5tzOMWWz5ZdwG0WkmfFWCwUwxGI0ye7+wGXICQmRdif7mosrhmBkESY3FOcWShCqKAwhFFr8q8cSbzfDdm0JL0A9N1An1HJILW2RhiH4C9/u/d+xhzbxKx3aKIRWHvPmIyFf2RPBX7O/hNeQ7mULZvqwx6fMaZ/TQnBgGeEGVupbFSWy6FxmWq/zUJzqDvWDk8319rWHQpnGSYGYF6Ye5DDGky+KtvpQzXGh7oPkLdMe/huo6lxNLptWedtHHJqD3rkNx+Vk4xOg5v2gVQHMldVYRhDNxZ4/Alas+J87FGEewOoS9jL7Q8b6PwcCcrNv4lAwJCFS4jFkyv1tSKvKCIBBtdNnySV0azQfk+85T5rttAamaE9LlHaTIv/ThkNV2XVLZP0KrASuvwm3Mt9HM8HZfsLk4Km3EV+kqH3lpnO+N62gUWzTCqggGQNShJ2zG8orVyVe/bEHzhGR3AmzncZTPBESycC1+dYkG4WWpQ7NKuvTp9bn5uE797Nz7UO1FKngyIPpiQLLz5gv0zx+7W3HWBZULZMpzIbwhPXdZatOgSXFTWhG4v5Pl5VNI4+wwvEoY1EaxiF9LSr+agy8bT4PNlnD3QS3Vj6/NCzWeoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(19092799006)(366016)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fzG3ti16a6J8KAirxAi6r4zISZkfm0uYZLzz45TB6HA0NY0oAtLSYjg8ooKh?=
 =?us-ascii?Q?nJmnJ+0JgQN0vx7svw67kPtjpfWl1fNq4LCXKXmgcywubl55hT/4GBrmH+M+?=
 =?us-ascii?Q?lIeR7VM5PPYbxR2skhDEwiqo4NqejNTgIHa+3ZyBZhgfnePitMRZWkq0sWyx?=
 =?us-ascii?Q?wwQCLPD514qCL6/79+Fuh+44SUI4cWY00kx9I5SP97YdeJdwJJl4pPzasnf1?=
 =?us-ascii?Q?zXqLnQaur0Tdf7V2pvb7UCScvTnyg+18nhmxNyiX4W78osU16T/zB4gSKnzq?=
 =?us-ascii?Q?VtUTF/qpNXhJTD5ZSw2gt6cY8d7FtGWM0/He9JBojlAvO4uYFpPuVIQq9Edc?=
 =?us-ascii?Q?eL61wwllEZLOzTNC3kXwWT917kGREoV8IuHX/us490uMpNRQEMVAq0letKmQ?=
 =?us-ascii?Q?Lg7XXLk+TzqJpaGHzUaRNk3NbkQDGMAgsMqRu+WNp577GLRw7mVfUX1cGn/w?=
 =?us-ascii?Q?9vITTWgn40B685O1VXM0vTHEmakxQNfrEhU/rknIzs6JB7ek6cCfa4y8Q94l?=
 =?us-ascii?Q?EJHuv2JPO8zwlthBaUPOn5ajaFSxW2YW2IJT8JPOjocOgAo9nQTJwTo29bXD?=
 =?us-ascii?Q?d5ELpq2kJXi8ko2mTBOcengmhbfkgZNbEmw0lkcKbWWFl/J9U7vYe3ZcaPuV?=
 =?us-ascii?Q?HzUSfZ9Ia58nzQn8FgYYWKZ40Wg9M8fBqKFCS60YWuOceo2XqEu6mBOiNIeW?=
 =?us-ascii?Q?4gpRNeuyd4xil6q9LlJm/bMX8mPvmZtPqnAJCdv3rFLUpV4iPR9MeowgRTV9?=
 =?us-ascii?Q?ub6YWH7XabdGbQwaMkjRFd6XSrD7pEKCQofhf7SuwNfrvNI5qiqrJan1gS4v?=
 =?us-ascii?Q?A4VTb+8rjAfzKV/om45MJrjcZ+skX0insoqe/zeBA1HCyENr8bnqzA/4gxvT?=
 =?us-ascii?Q?J5/FT0txjt/KjeSc8xqgy46IquI+GtiDoqUc0N3o6BRdO2MXFmo9GdItb7HQ?=
 =?us-ascii?Q?1oMVlwxfVwYI91S41yjXMkCFifUVS3Yd4/XLmRFIxeA3/cwi0VaRCdnKTUjB?=
 =?us-ascii?Q?hQyxx4kLJ4qwg2cbsQkPkaf59MZU+0341bvzOTb3hXJPN8bKiEV8afRIPXjd?=
 =?us-ascii?Q?W6EL1rKSRrTyvmF9NZElIUdLmPXElErM5YdnysM3pbsUp4C5nEuSzFgGoeG/?=
 =?us-ascii?Q?fTDUOSVhAFOx3TFi5QHSNKiA1u50a+H1vuHMeygt7E8tC6amJOMx1W4vSzgQ?=
 =?us-ascii?Q?DlkeeOOO2YibehJSuyE+IzGOR7d2yxzcJS4iF9ex9AT4AYmBzQSQznahJo9a?=
 =?us-ascii?Q?jZNbCQj3jWHCkaxDr6VH+asfPNJn0FpmQQF06lQOvgOfGgPkLjXvR1ljZmTw?=
 =?us-ascii?Q?333YE44OKWuoAOjNRGEOIofsknTFkdFWQXyO83sl6fzh9a1Po2MaYey3xjsv?=
 =?us-ascii?Q?zZyWw1Kujd3v96SWHlt/bB2XZQvmlymfSPfX+vhLL/LqrJQX++nVGPOj4dHg?=
 =?us-ascii?Q?FWKjMwIa2M28XNBHeVQGt3h3JPT65pnXtJhPCaXp8KUa9BL1qQUrDVuKk9Z5?=
 =?us-ascii?Q?A6+58cxHMzW0B2Y9hnMJbygPXH24T5hPcjIPh9bAaQtZEyzWrP/9x685jFua?=
 =?us-ascii?Q?mm2CdBd9Tbg3KWls3/Rh6ABeJwmbX1pRDb59glbzb7gL8I8w7UzpZqcUgJQG?=
 =?us-ascii?Q?jnfoeRLvPfQGJKPOvDnqFAufM4fO/qWdMh6d6QR1urSTdjoCMUcfUWx4AVyC?=
 =?us-ascii?Q?NtLC94S96zdYQG8H1KaLzgJTLOgPLLtdOOCJPoH4o2V+6zPFycfyZmRpq7As?=
 =?us-ascii?Q?eZ1FLeWI4svGcxbLpZcwQYil+6/8XjgJQFxWQ9W2sTw8J2ZfqFiS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3274eba-ea85-4869-b0c3-08df07389815
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:19:36.3656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /o/bur6QKQMmKUZBujKvcAarkiVm7Knfh1qnJlyWCxbLSqLd+C9ePhgJ1iJntC8PPxe47NznqaAHbCF8aeoUvkHHUetbeCr+eYkLJJyayIePee0imFb0ZoKp1au1BW9f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8440

From: Wei Fang <wei.fang@nxp.com>

Replace the open-coded 64-bit register read/write sequences with
ioread64_lo_hi() and iowrite64_lo_hi() helpers. Introduce two new macros
netc_timer_rd64() and netc_timer_wr64() that wrap these helpers and use
them throughout the driver. This reduces boilerplate and makes the intent
of each operation clearer.

The high-half register defines (NETC_TMR_*_H) are kept to document the
register map; they are not used directly since netc_timer_rd/wr64()
address the 64-bit register pair via the low-half offset, relying on the
hardware layout where H is always at L + 4.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 72 ++++++++++++------------------------------
 1 file changed, 21 insertions(+), 51 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 19ca99d80e95..376b3b0d1a38 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -127,6 +127,17 @@ struct netc_timer {
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
 #define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
+
+/* The 64-bit timer registers consist of a low (L) and high (H) register pair.
+ * Hardware requires a strict access order: for writes, TMR_xxx_L must be
+ * written first, which latches the value into a shadow register; the write
+ * to TMR_xxx_H then atomically transfers both shadow registers into the live
+ * counter. For reads, TMR_xxx_L must be read first to capture a coherent
+ * snapshot. iowrite64_lo_hi() and ioread64_lo_hi() enforce this L-before-H
+ * ordering.
+ */
+#define netc_timer_rd64(p, o)		ioread64_lo_hi((p)->base + (o))
+#define netc_timer_wr64(p, o, v)	iowrite64_lo_hi(v, (p)->base + (o))
 #define ptp_to_netc_timer(ptp)		container_of((ptp), struct netc_timer, caps)
 
 static const char *const timer_clk_src[] = {
@@ -136,66 +147,28 @@ static const char *const timer_clk_src[] = {
 
 static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
 {
-	u32 tmr_cnt_h = upper_32_bits(ns);
-	u32 tmr_cnt_l = lower_32_bits(ns);
-
-	/* Writes to the TMR_CNT_L register copies the written value
-	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
-	 * register copies the values written into the shadow TMR_CNT_H
-	 * register. Contents of the shadow registers are copied into
-	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
-	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
-	 * register first. Other H/L registers should have the same
-	 * behavior.
-	 */
-	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
-	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
+	netc_timer_wr64(priv, NETC_TMR_CNT_L, ns);
 }
 
 static u64 netc_timer_offset_read(struct netc_timer *priv)
 {
-	u32 tmr_off_l, tmr_off_h;
-	u64 offset;
-
-	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
-	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
-	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
-
-	return offset;
+	return netc_timer_rd64(priv, NETC_TMR_OFF_L);
 }
 
 static void netc_timer_offset_write(struct netc_timer *priv, u64 offset)
 {
-	u32 tmr_off_h = upper_32_bits(offset);
-	u32 tmr_off_l = lower_32_bits(offset);
-
-	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
-	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
+	netc_timer_wr64(priv, NETC_TMR_OFF_L, offset);
 }
 
 static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 {
-	u32 time_h, time_l;
-	u64 ns;
-
-	/* The user should read NETC_TMR_CUR_TIME_L first to
-	 * get correct current time.
-	 */
-	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
-	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
-	ns = (u64)time_h << 32 | time_l;
-
-	return ns;
+	return netc_timer_rd64(priv, NETC_TMR_CUR_TIME_L);
 }
 
 static void netc_timer_alarm_write(struct netc_timer *priv,
 				   u64 alarm, int index)
 {
-	u32 alarm_h = upper_32_bits(alarm);
-	u32 alarm_l = lower_32_bits(alarm);
-
-	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
-	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
+	netc_timer_wr64(priv, NETC_TMR_ALARM_L(index), alarm);
 }
 
 static u32 netc_timer_get_integral_period(struct netc_timer *priv)
@@ -500,22 +473,19 @@ static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
 					 bool update_event)
 {
 	struct ptp_clock_event event;
-	u32 etts_l = 0, etts_h = 0;
+	u64 etts = 0;
 
-	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index)) {
-		etts_l = netc_timer_rd(priv, NETC_TMR_ETTS_L(index));
-		etts_h = netc_timer_rd(priv, NETC_TMR_ETTS_H(index));
-	}
+	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index))
+		etts = netc_timer_rd64(priv, NETC_TMR_ETTS_L(index));
 
 	/* Invalid time stamp */
-	if (!etts_l && !etts_h)
+	if (!etts)
 		return;
 
 	if (update_event) {
 		event.type = PTP_CLOCK_EXTTS;
 		event.index = index;
-		event.timestamp = (u64)etts_h << 32;
-		event.timestamp |= etts_l;
+		event.timestamp = etts;
 		ptp_clock_event(priv->clock, &event);
 	}
 }
-- 
2.34.1


