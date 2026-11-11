Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6F60A2607
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vcok2eOE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPYP66wRJz2xWR;
	Wed, 11 Nov 2026 17:23:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794378202;
	cv=pass; b=EcxNzX9TQn5NdA4RC4pr5ZAqehMTJcvhKWmLpi10K4j0Ho5a0qSk5rESz9I+ZLUnidHGsSXS2EylhpSe0YEJYZNR/xwVmxSxL7f5wFTPvOJkV+BJWAV9szu754McCEJ/wKf0r7t8JWoTnFtqNN+sanCZMjWHZBLrgn+rO5SLBVwj8BesE8JmXNvsAMRX43j00r3eLMhhz1ibqYxr+4HLAksA00jP3jn1PJgG8Np8I8dkvWD2ShZ5T5OBMmSph8YNgYJMazsElXyEkMBd4N8bkc8nZpJuSl770oFoPA8IvwAbr/1pgdAhN9zDnx1vPdxnnTNm+j59uw2PSmy5bBkX7w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794378202; c=relaxed/relaxed;
	bh=0pnwXejhk1n8WCza1W3ydKGUAUIWhfGXOr70MqEVUkY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ASTPKuBpNzIoEVCjhr3e5m3HJ5I7Vj4n39rfUWK6K90VkP0Qf0f0VjzsWsO0DxCe+ZhShXC8x/hUFdYcx8W32l49yXNaXxYmkhiY/ZK9782A1AKghuBpsEvRo8moJwpbcQWuZ0lvRj7IAaw44juDDA9Z7Mj/0gcT0hn8la9dT4VbxEW5A6JPSyPLR/2Pt8z3MDiurLbJU0XEPeSP5Zn1U80j0mB5KhqotNWjacUW6c53SMjAI/8+9wqRm54N4LhWZTbT3YDOvBGS0/+3A53YyQViuRMnjoZvqNC9tIruocEsgoPw5GaDOWEsmb/hqLxh1Cx6N/ydpdItn/cqjqFXJQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vcok2eOE; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vcok2eOE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPYP52TdXz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 17:23:20 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9EGbsjHqSXfhSfoUe9M6xDoeb30sAOyMO7wYexIt/2LnHyMmBDQqE5MULjxGU8OTAprBeMG31Vte3PqqFWOsqRjVmJ8o8ziy6PYF5XU5IG2wEZgnbYZ3ALTGvrI0HepcPxqZq5JBYcy9AZZQuRl0yAqlFuEFdgzmWt54C95OiZDAJFBNq4e74oPsWHSWJg07Hp7vfJQJSVGvgp/3AvVuUrMg1polvfp8augwpUy5WXscVHKOpMDBiwvsMAq+cDuAJBKfb9pSUGgi6Q0/1Yqwy1iiLTkSnvx4RSPiOqZ5YPRj2hyhb8T9rvi+keqqVNQh1JQn5DL3KMQtIVXnWC/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pnwXejhk1n8WCza1W3ydKGUAUIWhfGXOr70MqEVUkY=;
 b=ZXx4G3b7ISH/tjLhgTUDZGA6dNWTQEdIK+BeOFBzj52WolC3f2wRZ+NnO4zZyjhjdF5WsY0HBaL9EXY4WtLmcUfoVOSDS0kwnRRXOC/Dr20zrTSasq/h2Nfsw/z+LbrejliHMPOJ5xTqVIUdQqiQNMNGEnxehjDpr4EPn8XceghNZyHJp7SF6K7TVZ161I6DlvQLJD8I4COflXNeGXXOMtdKF1tpmLBLZ0oKpRSd2bBi6wbtZFWjqp9SmZP9IvVxWgaCAgJYaBm52tPmu8A8DvD9q+h9uHsl+rXlo3t4HKLDZWoMnHz7KsqcWU9zGKSRcpbC9m83uuqdYwq3BNj5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pnwXejhk1n8WCza1W3ydKGUAUIWhfGXOr70MqEVUkY=;
 b=vcok2eOEO4eKfX8cx15BW/CDZtbjoUSiwSbGg5N7/UbI098jtxAi5viE1cRcD2pGc3nqOaOvGKXDbN/cajy/AJ+oACLKQS7GbVJrsYjeB2IOBi3FEe7I/4iZ/hf9KTVdTM1dIMaHzZNG5usEiiL4HjLl4hDHENifjx9IDxU/ncjyOHEsBCORKxIO3qAim068188IPf2pYyCA6DDrWynnuje7Y2ORf0VQCz4B2X2HGcqLlcE10HDeSwGJRySNvOH/yv83lw6nIYyQFCcA1F59F+wz7Jh1Y3IQizVlH4sV6Eoed+QacDGn+NCH28RO4+SKiNPM1DGS4P9eWIwDxkPIow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:23:01 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:23:01 +0000
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
Subject: [PATCH v7 net-next 0/9] net: dsa: netc: add PTP support for NETC switch
Date: Wed, 11 Nov 2026 14:27:44 +0800
Message-Id: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0013.APCP153.PROD.OUTLOOK.COM (2603:1096::23) To
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI0PR04MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: be8ea51b-8042-499e-052b-08df3fbc3c2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|921020|261026121527099003|11063799006|261026140227099003|261102123227099003|261021123027099003|261009223027099003|261021121427099003|261102130727099003|261022105027099003|261028144727099003|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	G3EVO1SQwUOQbSvPPWvD79avjhEt5tJbYTW1yaJSYZ6opu9SMFDrdsZ+CLJP6gYJ7z5LFgC9JMyPfxBeDC1hz/VX+/sM+Zua1Ba5f3CX7YqaAN1qYSaYrtzsyMa3l4V7nmfx514L9eUAJBFGqsv5IA2lFHcEzSDUl3kmopIJONDV7vDH0pFs1XLONAKd4972pulW6gfZOmdmuObQamvLis58QypqZlvI1QMtBfmKx3Nx7Ji3rvBUo2+zqF7KjkaDyNmvxxxxSrsz3WT9Y80KmgYobH2qyIgKlN2t2rPrAXRsAhk5+5PAqpymoIC7zSUDTJOPyy/2OQs8XlBzZHKAGicOFRLdjY1fFxjqdFAzmVMyFtoTFFGk4ws8vvEuZpgEv4mpOs7NAolc5ryiURUHI4/8CwR4yIF9JMgpqS4hPDik+Tnjtk0DWio6ATb+PTo8CVDWbrN3/51qdW6sn5bzWuAQ/aCqZ39HdHrA4AW4UJo2oGtFFAhEro9rUYWmwg/yf7E7Z0Tjf0puVKIcxwCHblty5650iTUqbUsaq7+ogYMYpwtYYCzv55CVjNwDtLduzdltJ2jqSuA8vrqDcv+YFBeTqpJ0D4Wup0kQ5mDArgnzWPmQ+aoR6sEyldH3WLOj7nFidWRTmdn6Ep0wUKYBoSa0Kkybfn5R7Pnk8f6rCVA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(261026121527099003)(11063799006)(261026140227099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261102130727099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/xevy80/ZOm4uI2Mq8rI2ghYMonSK693bGKSewMp0O31+dZwgKHx9DhqUeiQ?=
 =?us-ascii?Q?rmkpCuMXUR8zh6nUIe45o/pbjweyMxDtPdr0M3fkF7Dw4RTsCoFLkIqoPsOV?=
 =?us-ascii?Q?qmznhSYxKT5JAUuBS4cdOFd3chMO4a+H7zyG033VQhBwM2Oo9dO+EMS1e70y?=
 =?us-ascii?Q?+4tqqNH6khQ3ocaWV5tq06LGtbWvV90pZF/iWeR7d8ZJI7ArFgisjDKXT331?=
 =?us-ascii?Q?l3VQ6V5iBbWyvIpXYaa2koUptk0D+P38wzRVU4gYNljRjRpeQYGBvZSbY0F/?=
 =?us-ascii?Q?mLvtGTPLE9QBynHnngzPqWFSPFryURWzSp2lEnU1qtdJANuOXyKwwf4zUG1N?=
 =?us-ascii?Q?eMYYomPLPj1kfiUopp7PlUEgGQf7+mkd9+Dto2TjarjWbpT03D/VeEq807BK?=
 =?us-ascii?Q?SeCE9bIdXdlZurU4wACNCLmlbtFFhDET8nnwtqrAssTHZG8gZnIgqlf+yxBP?=
 =?us-ascii?Q?DTKyXLwuP1wc1TustVrmtKm9NA2aMaqFA7/+Cz+H+bGprdMg6Lekey/TSXVU?=
 =?us-ascii?Q?+Efuf641AeOKcWWvVOwb8M6MGscQX0VwkazRzqkntWKN54LwnyfuO+gmk8nw?=
 =?us-ascii?Q?NzYaR/5GlBnc4wMzKZ2wQu1zifoWbBVNE6KQJhqDNQrOpstx8wz0YLN7SB2q?=
 =?us-ascii?Q?zb5jrgaOit+Y5R8rnipwinEFMJnZQFzZOb7XddV8OvtHSxwkxxhqxtHTEgFA?=
 =?us-ascii?Q?m9y7sSTkFLvXaMw40DBTVzws4gn1svoY2WF6uLBYXwCnsaVEw2P5d94i3Y69?=
 =?us-ascii?Q?3UmZQQwyG1Gs8wO+6kMMKK2c/zO/eEBXWSMwXBzTwgRVamM5RYfASnfMS1Pp?=
 =?us-ascii?Q?4WlfPCkNOhudf/SBNbUYRvm7v9ihJ+O9yyUeMzJ0L3QmtCh5BIv9PA1TKtJA?=
 =?us-ascii?Q?tvjRFKAqXn83gGvm4JQScQPfLwmHlLgNurnU4jpUuQPySrprXrmAQ3/f11Yk?=
 =?us-ascii?Q?6O+kfD9BYWigrIoJGjouRAAUg+V9LbtT8+1LW8DGaEnWyeqNoXfnJAeCNBwU?=
 =?us-ascii?Q?DM2jppwMHZQPSzTlim7A8nMo+oTc8lDXpjqs3jyj++sFUnusa7xRXyzatzxj?=
 =?us-ascii?Q?KHKi9CVaIHOpdtg/a7hlDL31T6yjLfTBa57Of07OvZzf/0bkYGMuNWmAHTNi?=
 =?us-ascii?Q?yytYxv6inP7XfrMNgAKQ4O7hx1I3vCCx6AwXcC6tRZKEgcnQk3sfcEi4Hafb?=
 =?us-ascii?Q?XF9Sjkf6/sIxvI2zlhubFHfhVbdyslzHsv50ygqkx2AQn1bDiqUhptxE8px5?=
 =?us-ascii?Q?CdZ/Vwild0DX5phLvd3OSB9NMw3Smxixjzdxvo7xBGr/d4fMufp64/Ma+z4K?=
 =?us-ascii?Q?lKM7B7X6z8q+JagaUAASXB0BRtg1uxp5rg3dE13xgDhGIhsshOXrTy4HXPUZ?=
 =?us-ascii?Q?Opew80gHcs3TyC5EcMN2J1iKpKD1WIwVHu+9jw+G6WppAnYWUWP1r8CpE3Mt?=
 =?us-ascii?Q?q16JM8zI21Phus+6oVNoKRxRUe98UoZ8KbFsNo9OISynrsrAvruJs5JbkR6S?=
 =?us-ascii?Q?NbXB/sweF79aJ1duhVBCdSelEzNQ6h2zCq+1BFIgRgw1V82kjjldn02iadDq?=
 =?us-ascii?Q?91bJk4NKgbHfaE0REnkKBeYJgCECZfie7uIuOgtuRt2SWkP8Jy7MFM+t8MWw?=
 =?us-ascii?Q?Fo/uWIaD/zcYeAwuVlSG8aDEmynML2QH9oKunkY1kSk22K/OchfdgaqYT+hQ?=
 =?us-ascii?Q?VxzFrIPT/St0uyPRgmwEGWDyXyCXhASIjJelxQZZaaQ0q1raCcq71ZUmEkpe?=
 =?us-ascii?Q?xkMtFNaTQ69C5s9cpOHfMN4hIn6qhRdYcHlvmoyjcD+0XIJMd4/F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8ea51b-8042-499e-052b-08df3fbc3c2b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:23:00.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqf9vEjvuA2dizVdNXaK102H1H3r14Qy5P9GQNiZWpS+D6oUKQ1HXjNqhG+sixBTIqFxzdMg9zSc3MO0v+c520wmFUwTJUqGvXOipuv1X8tZ5Ut8ddmfth5U3+3GRKGN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

This patch set adds PTP timestamping support to the NETC switch, so that
the switch ports can be used for IEEE 1588 PTP synchronization.

The NETC switch has no time registers of its own and instead shares the
PTP time of the NETC Timer, which is a separate PCIe function driven by
its own driver. The first 3 patches prepare the Timer driver for this
role: tidy up its 64-bit register access, drop an ineffective reset, and
export netc_timer_get_current_time() so the switch driver can read the
current PTP time across the driver boundary in a race-free way.

The switch redirects PTP frames to the CPU through the ingress port
filter table (IPFT). A few patches harden and simplify the existing IPFT
and host flood handling first, then enable the ingress port filtering
lookup by default so PTP filter rules take effect without extra software
tracking.

On top of that groundwork, the switch driver gains RX timestamping and
both flavours of TX timestamping. Timestamps are carried between the
hardware and the driver through dedicated switch tags: the ingress and
transmit timestamps ride in To_Host tags, and per-frame requests ride in
To_Port tags. Two-step TX matches a queued skb clone against the
timestamp response echoed back by the hardware. One-step TX defers the
Sync frame to a per-port work, where the driver reads a fresh PTP time
and writes it into the Sync frame's timestamp field, then programs the
single-step register and transmits the frame so the hardware can add the
residence time to the correction field on the wire.

Together these changes let standard user-space PTP stacks drive hardware
timestamping on the NETC switch ports.

---
v7 changes:
1. Rename in_probe to configured in struct netc_switch
2. ptp_ipft_eid[] is initialized for every port, next to ipft_hf_eid
3. Return -EOPNOTSUPP when netc_get_phc_index() is negative in
   netc_port_hwtstamp_get()
4. Initialize onestep_state to NETC_ONESTEP_PORT_INACTIVE in
   netc_port_ptp_init()
5. Drop the netc_port_enable_onestep() call from netc_port_enable()
6. When the frame is not known to be a one-step Sync, set *twostep to
   true instead of dropping it
v6 link: https://lore.kernel.org/imx/20261103021024.3121936-1-wei.fang@oss.nxp.com/
v5 link: https://lore.kernel.org/imx/20261012095924.1129312-1-wei.fang@oss.nxp.com/
v4 link: https://lore.kernel.org/imx/20260918072852.501420-1-wei.fang@oss.nxp.com/
v3 link: https://lore.kernel.org/imx/20260831082335.1184605-1-wei.fang@oss.nxp.com/
v2 link: https://lore.kernel.org/imx/20260808032146.2335723-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260728104548.3301214-1-wei.fang@oss.nxp.com/
---

Wei Fang (9):
  ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register
    access
  ptp: netc: remove unnecessary pcie_flr() call in probe
  ptp: netc: export netc_timer_get_current_time() for cross-driver use
  net: dsa: netc: tie setup resources and reset to DSA setup/teardown
  net: dsa: netc: use entry ID instead of pointer to track host flood
    rule
  net: dsa: netc: check return value of ntmp_ipft_delete_entry()
  net: dsa: netc: enable ingress port filtering lookup by default
  net: dsa: netc: add PTP two-step timestamping support
  net: dsa: netc: add PTP one-step timestamping support

 drivers/net/dsa/netc/Kconfig          |   2 +
 drivers/net/dsa/netc/Makefile         |   3 +-
 drivers/net/dsa/netc/netc_main.c      | 404 +++++++++---
 drivers/net/dsa/netc/netc_platform.c  |   1 +
 drivers/net/dsa/netc/netc_ptp.c       | 895 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |  67 +-
 drivers/net/dsa/netc/netc_switch_hw.h |   5 +
 drivers/ptp/ptp_netc.c                | 136 ++--
 include/linux/dsa/tag_netc.h          |  38 ++
 include/linux/fsl/netc_global.h       |  10 +
 net/dsa/tag_netc.c                    | 228 ++++++-
 11 files changed, 1619 insertions(+), 170 deletions(-)
 create mode 100644 drivers/net/dsa/netc/netc_ptp.c

-- 
2.34.1


