Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28B4606A33B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XqFDwH2g
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVNXY2G3sz2y0B;
	Thu, 19 Nov 2026 14:01:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795057293;
	cv=pass; b=ANgy21Y3WtSAGbk9TDX20tJjDtkE2+qCIfwMMpG4XWzvpwZAftGlML2XWtD6oFxDuKPfjRDbBG30jNSb6gJptxkUylyWvwmki28O0oNkF/5IsnVMV0PspLjWsMIGwbOPKzUrjMjxy97ckGH6bxliveIO8xKiTIPBPG+ceRQoRxWdGSCJtDwqggpFfkMQH9teXdVu6ZaIdrhN9jUvWN1r3/+SA2ZhhO1WA08hKc2vlQv3vN43PrQ9kkA0ch0YRKqU1w79C6/9yTFemvWHUV9lPFpZMbOaz4Xv3v7l6/e+wpX5aehrC2oDyIFtaevABsk3NXQ7Qo5L9HwAw+2WeCgsFw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795057293; c=relaxed/relaxed;
	bh=4XbrmQWQHsp+6SXJ86YsiIp40K0nThc49PsLB52P8+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iv7CXzBHPegNCu2m/iXoIiA2szd6OvM43bDyiGa15R1+/ItME/9fstNLM3fz/cmuMmNKFrjyoxGhsG/YhtGzuE9fvqPd81MNUKQ+efW2c16F+XHOkwnNyZnsJy+UFKFEQGSlYtSlrZ+av8auWILuLszn1Q0zk9PYRNJkUh00ec8nQ8agTwFw3j6BhPw2BTEmRW7EnRB0RuyYm/qNYuxzsPdxttXOjMlipAihwboMAcJIOIWbraY+jrARXoUfli1Aceix6DY+GA//KnvTFFCfewGHTeS5YRhLjTobBd+FY+tLjEU+hocAX9X4PrYfnT0Vpjl0cCdWrDW6gSb6fZ+p2w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XqFDwH2g; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XqFDwH2g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVNXX2THSz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 14:01:32 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nrzv6CD8f0tWVxi16/GH5HDRYRk96jRjpvvCYglmXQ24g81No5TpZyPGn7egu7yREdk1RjMb0zfYmb2mYb5HNLZPL9YFExDmLbnnpaIEykiPJ7wFJra7tWfLSKuzq7WJHfmhJ7hHTqVxB0i6AFll3XsQBSgM3zxR6TlJelYN2dnn1RkduFSqnEk+yle9wWoOGAnSKeawIcRDQzZaBdDvKqPHlL5p0tu+ICCGFXA4GkrgVb0fYI0q+jsmtMeg1h/bEv3FHGwKBNTAajJ3lK189G7FUoAZPxVwSEMc60z7UqxkiH3SHj95Qrj5HsNHbSD2mQKOMUsVmHkoanKJEfGikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XbrmQWQHsp+6SXJ86YsiIp40K0nThc49PsLB52P8+A=;
 b=o/9GynUz5oypwDyMBuQfYWH5S3bAq0cJeeoL8ykacxWNZ5DQXKVwWGEfKiIif9PbzHVAe/0l0r2cL5dOMfajh1/svSYsM8tdLVIq0R0I9+ThRl/8mp1qUHt8ZrDczukiBPigptNsiv/xjsCy1ruf5wPGjgqgQr9LbZ30aOvJg6qdtZNDHFtWs962l/f0OINgc+54Uctl55Zpag78gCqrT2ln1wMdFxd1yr5yWsnc5Nz5CI1FTOORk3fcl6dH92uVBaqJQu9Y9A+UxeAGYofctog8Oz+4wwRuhn2FcssMvGO+yop88X0Gx5iSv5E4Gu6d6FFURha+wx3oiqkYaEBvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XbrmQWQHsp+6SXJ86YsiIp40K0nThc49PsLB52P8+A=;
 b=XqFDwH2gzzQr4MUYXhG96mLWJv7zFGu4iMYOIwzOLWsCRjdrm+hhL1OlKghZt/97wPH4183O/BB1ti0ajz/GW31f2HP/Cu4yZDhYp7280Ev/Ybg+Vio7ypzW6PMpEWwxAcOukGvJ3j/Q3gbh26u4miAAWkTVv9H2B2AzMSq2ec/GqsiuRwNx10a++nPxeJz/FAoC9vA4C5JhnfUCsoPfTvZniLE65pKc8PPbGUljDBIn4CKHoD9ApIYvVprA8/BE38Qn2Fq5IPeYLXuvexr5cLJj3YsQ8+kkA/0vvQLp1VnB5Tx30n+xQvLeiD1UPHohtPFIDi146HcgGdaYImSf6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM0PR04MB11880.eurprd04.prod.outlook.com (2603:10a6:20b:6fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.16; Thu, 19 Nov
 2026 03:01:09 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 03:01:09 +0000
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
Subject: [PATCH v8 net-next 5/9] net: dsa: netc: use entry ID instead of pointer to track host flood rule
Date: Thu, 19 Nov 2026 11:05:30 +0800
Message-Id: <20261119030534.1892935-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
References: <20261119030534.1892935-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR03CA0001.apcprd03.prod.outlook.com
 (2603:1096:990:6::8) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM0PR04MB11880:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c18339-07f8-4fa1-1cba-08df45e95c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|7416014|376014|1800799024|22082099003|18002099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	lyId9d7og0GBQ4vOvja5gqCOvkg+NsWTnyXOHzv1/YY5eps978iqc3QlxBRPpJJuNSTgJ8v7cW4OBIJFhpSXDLtStkgQ4wIRdJgEA6Pifoac2++iLQpaQe7m3AsbeNU2R2n9lwwV/RXzazeTJ/PUBdbRb/rptFFHy6oPixy0AlkB5c9/rIqvwjg+hLo7KKpXrUkqPFVjB4UfGXA1dozPiPhSIShinVpD/IGU81m5dVgAMJJ3qAuBPP+7P2EmqMf3yncbvMVUWgfNQcyQcBu+uioHtjx8VYlvLNAMX2I02r48aE/cB/zHwjmeloPtl8Y6EgmhgyipME/xgS37EafeON1vCMFvC9cEGvZy4zXaIcI9G/fC+8mW4j4bdqwvSxjK3XEys1KaY2EApVntyInze1jt0PA0dKWlZDoa7JJMRS/nGd0B5jrshxy7qSUiTXndRBlGxxexex7dLPbcE3tB5DhchI7w3MrfqngmUfp+KYOC9vjeouWy9Dvv+gOzFzvCe6UyzwnLarCtjfhP4R8Je5baFXVddI5HD1kleuuwW4L1koBY3xQUAG94zu+cTOZZSmcejXH3DmaO8d7nqk/mNmuytuHoe6DqzvTdJYtoQijDtrPioy27skKBRrdcMLr5QASvJK0aNQFueXFhb1aMacVUAeW1i/awSldKzN/oe0LTGIkklVlY4zBcsV3oFeWfpJatpkkF4oNTera23lbreA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(7416014)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y6tpoJwX279RRBtlGLFL/W8ac+mALVBC8mrUGqgMAD2IFf/CQ97NCAA0ivZk?=
 =?us-ascii?Q?2HEB6pU0q96JG9gFrV82gmsVRel/GeN4cnjubF+pAyxwJiABxoOdu3G0m3ld?=
 =?us-ascii?Q?cIJaJhumy3kHk5zIu/bYbwO8/5V1pCuY1HYBZZ6ffEULDE8wAEfRlI4UJQ/P?=
 =?us-ascii?Q?ViBislQt+lGOiL2/crlvTRG/5WtiolsWEasp0XqGlPKLSKwdSiaL6avz89lR?=
 =?us-ascii?Q?xaJZ2clJ2ASucVD1IdXK4Z5uF9FHqdkeyZsCKG3Enm9qXsVLDFY1qyDKh1FH?=
 =?us-ascii?Q?OZdsT3U/L6yprOzP3uGkKeiO8KAljJj5EhI/tjEEGM50FK9yQ98XB5kA5xGh?=
 =?us-ascii?Q?w8m/6OfsfFaTwBq2H1BJ0kYPH0DErcyrTtJZ63ppLJadxzJZudR7XLJnvD3P?=
 =?us-ascii?Q?Dz3psaOSw8bjeNqKqyqr9RWYuqD+shMEwFWzSdiQSYRWrpb+gSNFMGpwXkQP?=
 =?us-ascii?Q?HKqIcrXlxI1z98vFBiRpEp+QjU3E2Lhzp6ecdpeiUWei6Ex+XNKR4zZtTXm+?=
 =?us-ascii?Q?C6raj/pL3WpsWuLtQVJb1NHKTeQGZlLn1zmeyCzRsca2BtnwWNl6oGhUF77p?=
 =?us-ascii?Q?9hp34NmYySpPg7UeNsyFAqontoofmIIaorbH4FCeDXf7R+rZEWpwscBL26fN?=
 =?us-ascii?Q?cjpA8Z1VrZdgLY525lwWU7G3bSsYgcN83n2ppG6EusMZLhrf1nKHDsIesTZO?=
 =?us-ascii?Q?ZO7j0n+PO5KfHFE2AGSSr8CvawPsOBtKrUkMV+t/ahDb8redbLFi4nuTbmHn?=
 =?us-ascii?Q?UdpPDEfwd8LRV5YAMCo0WHRgReUBURCZHD2jjtwmbGbcpBNIx/MYeox2K0aY?=
 =?us-ascii?Q?W/P13jDyQiFOtGFLbKiP8bpjXX29f8TSYLVXQwpzEFqFU8vDcyogXtIeY/kc?=
 =?us-ascii?Q?WWmdkIIk1RMhGOT4XKoAGTlfEfNuysCN+DHfcF5oiZ0cPnwWItmOFMHsigLG?=
 =?us-ascii?Q?FOC0y7LedZockNlOnCY1H40kp+RO2G3zuhmI4AZjya0FdksKvuGRNz+Df9tY?=
 =?us-ascii?Q?pjaPyzHmQUch+NOQQyhiUXWSo4AyxwpWoDSm38BZQytA5SNhJYDxv9CkCLUH?=
 =?us-ascii?Q?zrG4NK0yZ+XvuMoBwjBgE6pxv6WwOub1QHWypWlkvRcnKl00YeaRUOHwzLux?=
 =?us-ascii?Q?nTpi/2d+hXZdKdC4CYYShhCKRHTMYBkYUXZ5pflqZKVlMrOqrbIvbt5GQPO5?=
 =?us-ascii?Q?QIN6sWLIFf/UU3mjzI7cc2MbsMitUkV4jbCu9jAxuAenu5PCHUQufJlaJAFa?=
 =?us-ascii?Q?BEPvjT1KWe9o15HZ42aPwEx5hPtyohGzO9p/6vXCA2IdK/dnKJ6WVYO7ZvrV?=
 =?us-ascii?Q?FlOsbPrKRrpMB7z0snTTDcisrYzc+nOokDSFAc5QUGzbz9PaapkqcfR2DPq4?=
 =?us-ascii?Q?nYWQAuGSq9Vo6YzH9Cc6MTdPbXlSC18Oe4p/pOBTeinE5tUH8mL11DPJpkTJ?=
 =?us-ascii?Q?iodmBmlOosCVK09wq3vCO9TZLpkn09oasQmHTMYOoR5bqTy3K+Hl36o3eEOj?=
 =?us-ascii?Q?Np7yA2LYttvkp2pSUt3F1PugxAEu3QPlFS5L9FtfFfyXp48jgf1oMCimDAG+?=
 =?us-ascii?Q?e6UpahP8KOPErPIj4HZbx7AsXFEgjkBk0MtaC+cWFIwACsnnCQxrKYCQai41?=
 =?us-ascii?Q?BP/49Ss/OzlvfqZkUp3/hNx97oJ94RB5Dhfgs4SjK7px2EbLcO0xAZBXxznC?=
 =?us-ascii?Q?PLpSIA+ucqS6iD7N3mNKYaqAT59BHFfwg/py2Ojx2MZUbhl8Bo9P8gmYOosK?=
 =?us-ascii?Q?6eI24nPWqxyMbECXlrp7XsEa32cVy6q/acg1YCfAK0str8Yv9MDn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c18339-07f8-4fa1-1cba-08df45e95c56
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 03:01:09.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxDndEtd+A4N8wAOeB2p+8dhmyKkmvkIsBkTELLXbLrp/0tD/ARibLTCO8z/W0G5NQbIQCHRXk0i1VUj/EaBZiDC0BVBNMdKwwjsI9EMedevC6OwyTkGPEX942TCxmwE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11880
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

Replace the struct ipft_entry_data pointer in struct netc_port with a
plain u32 entry ID (ipft_hf_eid), using NTMP_NULL_ENTRY_ID as the
sentinel value. The ipft_entry_data allocation is now freed immediately
inside netc_port_add_host_flood_rule() after the hardware entry is
committed, so no heap memory survives beyond that function. As a result,
netc_free_host_flood_rules() is no longer needed and can be removed.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 62 +++++++++++-------------------
 drivers/net/dsa/netc/netc_switch.h |  2 +-
 2 files changed, 24 insertions(+), 40 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index f724f95add36b..7d0893bc0f163 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -321,6 +321,11 @@ static int netc_init_all_ports(struct netc_switch *priv)
 
 		np->switch_priv = priv;
 		np->iobase = priv->regs.port + PORT_IOBASE(i);
+		/* The ipft_hf_eid is initialized to an invalid entry
+		 * ID because the host flood rule (IPFT entry) has not
+		 * been created.
+		 */
+		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 		netc_port_get_capability(np);
 		priv->ports[i] = np;
 	}
@@ -1052,30 +1057,12 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
 	mutex_destroy(&priv->vft_lock);
 }
 
-static void netc_free_host_flood_rules(struct netc_switch *priv)
-{
-	struct dsa_port *dp;
-
-	dsa_switch_for_each_user_port(dp, priv->ds) {
-		struct netc_port *np = priv->ports[dp->index];
-
-		/* No need to clear the hardware IPFT entry. netc_setup()
-		 * resets the hardware via FLR, so the next setup starts
-		 * from a clean state. Only free the memory here to avoid
-		 * a leak.
-		 */
-		kfree(np->host_flood);
-		np->host_flood = NULL;
-	}
-}
-
 static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
 
 	disable_delayed_work_sync(&priv->fdbt_ageing_work);
 	netc_destroy_all_lists(priv);
-	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
 	netc_switch_free_bpt_list(priv);
 	netc_free_all_ports(priv);
@@ -1878,37 +1865,36 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	cfge->cfg = cpu_to_le32(cfg);
 
 	err = ntmp_ipft_add_entry(&priv->ntmp, host_flood);
-	if (err) {
-		kfree(host_flood);
-		return err;
-	}
+	if (err)
+		goto free_host_flood;
 
 	np->uc = uc;
 	np->mc = mc;
-	np->host_flood = host_flood;
+	np->ipft_hf_eid = host_flood->entry_id;
 	/* Enable ingress port filter table lookup */
 	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
 
-	return 0;
+free_host_flood:
+	kfree(host_flood);
+
+	return err;
 }
 
-static void netc_port_remove_host_flood(struct netc_port *np,
-					struct ipft_entry_data *host_flood)
+static void netc_port_remove_host_flood(struct netc_port *np, u32 entry_id)
 {
 	struct netc_switch *priv = np->switch_priv;
 	bool disable_host_flood = false;
 
-	if (!host_flood)
+	if (entry_id == NTMP_NULL_ENTRY_ID)
 		return;
 
-	if (np->host_flood == host_flood)
+	if (np->ipft_hf_eid == entry_id)
 		disable_host_flood = true;
 
-	ntmp_ipft_delete_entry(&priv->ntmp, host_flood->entry_id);
-	kfree(host_flood);
+	ntmp_ipft_delete_entry(&priv->ntmp, entry_id);
 
 	if (disable_host_flood) {
-		np->host_flood = NULL;
+		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 		np->uc = false;
 		np->mc = false;
 		netc_port_wr(np, NETC_PIPFCR, 0);
@@ -1919,7 +1905,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 				     bool uc, bool mc)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
-	struct ipft_entry_data *old_host_flood;
+	u32 old_entry_id;
 
 	/* Do not add host flood rule to ingress port filter table when
 	 * the port has joined a bridge. Otherwise, the ingress frames
@@ -1927,7 +1913,7 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 	 * will be redirected directly to the CPU port.
 	 */
 	if (dsa_port_bridge_dev_get(np->dp)) {
-		netc_port_remove_host_flood(np, np->host_flood);
+		netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 		return;
 	}
@@ -1937,20 +1923,18 @@ static void netc_port_set_host_flood(struct dsa_switch *ds, int port,
 
 	/* IPFT does not support in-place updates to the KEYE element,
 	 * we need to add a new entry and then delete the old one. So
-	 * save the old entry first.
+	 * save the old entry ID first.
 	 */
-	old_host_flood = np->host_flood;
-	np->host_flood = NULL;
+	old_entry_id = np->ipft_hf_eid;
 
 	if (netc_port_add_host_flood_rule(np, uc, mc)) {
-		np->host_flood = old_host_flood;
 		dev_err(ds->dev, "Failed to add host flood rule on port %d\n",
 			port);
 		return;
 	}
 
 	/* Remove the old host flood entry */
-	netc_port_remove_host_flood(np, old_host_flood);
+	netc_port_remove_host_flood(np, old_entry_id);
 }
 
 static int netc_single_vlan_aware_bridge(struct dsa_switch *ds,
@@ -2139,7 +2123,7 @@ static int netc_port_bridge_join(struct dsa_switch *ds, int port,
 	netc_port_set_pvid(np, vlan_unaware_pvid);
 
 out:
-	netc_port_remove_host_flood(np, np->host_flood);
+	netc_port_remove_host_flood(np, np->ipft_hf_eid);
 
 	if (atomic_inc_return(&priv->br_cnt) == 1)
 		schedule_delayed_work(&priv->fdbt_ageing_work,
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index de2af536c5945..b0e1eb4621531 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -84,7 +84,7 @@ struct netc_port {
 	u16 uc:1;
 	u16 mc:1;
 	u16 pvid;
-	struct ipft_entry_data *host_flood;
+	u32 ipft_hf_eid; /* Must be initialized to NTMP_NULL_ENTRY_ID */
 };
 
 struct netc_switch_regs {
-- 
2.34.1


