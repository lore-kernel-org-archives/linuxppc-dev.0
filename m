Return-Path: <linuxppc-dev+bounces-23165-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE5EC43327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:49:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFdt6Ckkz2yk6;
	Tue, 30 Jun 2026 17:49:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805746;
	cv=pass; b=b8oMVQ0vCJyq26EdJPeAPrO/KkjCyQAiWTReP6SVt7XZmHmg1WRXYWVqk2/yLG7l6tuQBJTo7+5DwpEY8aevpbOi41WAGRprdR59G/DPtE3c2I1QUCBaMmEGzmGk8SvHAmHaDtb/LDZeZMJKSWojM2HR4g/N7Yu0thtji93JpOJcJVcPXuuQ+yaKkFf+KArbZXMGgK2b5YBbyYeUJEjawGRmFZbQtT3yNnXwlKI9a3PQ/T8bmcxLsvvZgjJ6KZb3x2/I1urzt2DJ7UIs7asJS5P9LHwwyprH6pWNlHdxpn3nIY0VPQ7i+vBRKgvivSp3/TMjvD9NzkJp7Rx8ZOkrcg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805746; c=relaxed/relaxed;
	bh=9z8clp8wa5MFnbKK0sNU25Urm+cj2U4ZqtJ9y/jUgGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XzxFulDrPZBuxABKLZQF7srJcWl6Ag69KJbTv9zOlr8t7lyVHw0t6bMZNs0WH068YwX28SCtlYr8FQRId2BS/+QiqAzBGOdc0j4Iz6BBjSZbvHpQ4kbaXpp0+j8P5uCtFLsXJtGSeC7cj/0DUwBhi3WNUSQW9A6XimMeV20/AQKCb+nhDMPW2S5XhYqk4GOYQtxTxSlzta6CWI/czpHDcG010DOU4yEOEJ+buc+8Vzza/LCAgfJHXsciWej/Rke/+WXGXTA2zWuj3omOSMeQR9joS455OQ4yZPQ4IsEpxFcXY+ifpHcf/RffZgON84Anm3cLcmOmPEATuIw1e5vtAg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BWnHnBD9; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BWnHnBD9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFds5Ftyz2ynh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:49:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m22Gd0LOzwoeio3jNx/sKquj4xTaJ89MQY7vKYeV4JhoSvgpFbsBxd+mqUYXXTgsK75832Ndvr82+XYAJNdEuyKd3XuYpxlOUDaX1xsjuVt2bT1V3E2c2G3UQhzpVhXDUu7KwUeOLUpxKFefngvsFCGVNQZ3TDF3VCumQMF77GxzuQv+n614UThQaJB/86UftzK5lOonKrPzqV/LY8MJeCMb6f3iF0H25lCGh6nr32/oWfy2aJGevmZJYdsl6cXNASLfCfyqzu8DJkBHcDE3D+i5fXdMmvUVTI3H2vuaIYPxMDmL/BE/cRHmtWiwAXF+6vnV1c/l4oMEgJYj8Q01aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z8clp8wa5MFnbKK0sNU25Urm+cj2U4ZqtJ9y/jUgGw=;
 b=RAtv2xBGgnAQUqVcqNIdCUbqVqfyhK/PDb/2RGrQasrisyGCBqUrEIBMNfK6E+3ebjAxTQwbtfzC6ld9xe53wvjY7jPqwUk8pIP9020lY0R7Y5ZZLKOuyBi+Wd26mPXgCaj/IjQOZvtAFu9BkeuJqizMIbZwKF5l4DSVxvq/TQ3MNrxYVRpPm3a9tHPCxYeXe8cuzQX9ysnAobVLQ8InYX0mMYc2WnuHtFNqWY0HWf+rNqgq1j0XU7NO7nIcpJr5+Ft9feYrgwcnoN3Jowwrlq9kuE/lr8y2lqR1IcrBR6k6yk9USD5iCGOsI7GtXBJlPi9WJh+t5ITjeAZjA/nvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z8clp8wa5MFnbKK0sNU25Urm+cj2U4ZqtJ9y/jUgGw=;
 b=BWnHnBD9YpEk9WWAAPKnjJPQEAnkjIV3yy4YPA2Dt+p6U7++pP6DMZGCZYvKpqlACKTg31DlDG7XoWZOcEmvnheTFdQ84N9ilKOm/0+PijnGufTC1XpMzNXuCnB92yQIcfRoXFxPZl6RqJV72rr+KpGErMlJ/+zN6DeV9/5TNRLx/rzAoGS/f83MdQ2apB1tvFc/08gMJzYsedslTazHoJukDjKqLfvKzluBWTSFkzWlbLeN/pSmsgv951GyBndpCsJ1lifJHvcq1pSzhOKUlAw0/MXjw8U78MbKYZfuXCOk7Cj3P0Qedg9R2527ywFx6gH+71LYJFoYZ3PpsS0z9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU0PR04MB9561.eurprd04.prod.outlook.com (2603:10a6:10:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 07:48:58 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:48:58 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 04/14] net: enetc: improve MAFT entry management with bitmap tracking
Date: Tue, 30 Jun 2026 15:20:26 +0800
Message-Id: <20260630072036.382761-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU0PR04MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfde268-d7f9-4997-e46c-08ded67c0ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|19092799006|6133799003|921020|20052099010|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	QF0pmvalNG1jS6n7GYUeGAZm5ryzTj5mebY29Webmdk6J3SMub6E8aX6j0hEB25Ttzsrre6elBvrA7Jayq8p5xdQ5a8uCSkM1GFBiLMUBxJZWS+6aO/2TG7VjRT1ItD8GuO0HtArEQqC55mhdlhMkY77gBAP4r0IYPrdHnGPTZyEoriMiCxtbF8MHmBn2fuLEu1Jx/mqSM5jTs5b9OQ7/ZT5pqJnpigHvavCdbzGG+Pb1A55a9vSDZldjh2govLbyd210VBIGeJ+Av08ULPXgN9aP70BvQc+dvKOdKvdHgDe7ETnPT99JYSNTt0hnAhGMxTevN7r8mLjaQFpMXGpu8PROTivOqkBhCQDLxTfnCE5XYqxY437vL44UqIXQC7AuZudxhb5RBkbI2mikp+PFHItfgwUDBx/N4k1q3RggbXYkWiH8koQ86S77udJhytjyR245LpAsOndgbT6/aeEeOB1770i5GZ7KgVk0MX48qS5QLAhYzJjHwALZeJrV0gwvjILzQOvxdL0Pv5AH8fn3RopIQl79YcQkXCK7kIjQesF7nZqsQk6sbcBAV1QIh4MJ1SPfx9Xkl3qS+jJaYyMKHEMet0+5WuCnah+9Te8wf0vKwTKDaetKJIqz6GwQ7f2dEym0mhv2gMDOmcJn7IgBda1db6qz6BJrhW3E8Yx7uGmdG3sU+GTwO44LsLzcFLei4HhYyMMpCOclDXBfGoGmw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(19092799006)(6133799003)(921020)(20052099010)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sPI9LbjtWD+16SFo+/XF1cjI7rGdo6qldWFvx/UCpcbmWkPqjZl545LUBTB8?=
 =?us-ascii?Q?EujksVAZqm/HlJlI92LefchkaJoJ6h9yKT+QecIkjJ6Mh1VAaUP2B7opECr8?=
 =?us-ascii?Q?tgPiiqprGnO+5lwIcu6ovDgonAcQzEx3e4wJIhevvG/9wFdi9UkNXm9rwpi+?=
 =?us-ascii?Q?0nl4yfh00Ow9DAp1rTfBYv/g4cDfTHVTLwULl0Om3fIMvacub4ddfiV/ddl4?=
 =?us-ascii?Q?K/wR8Hwfv7IqkEiBLaFt+qNX2u87FiyhmGYlGsk46GpJV9JfkqkWCMPNU/IO?=
 =?us-ascii?Q?cph62RemoNx3RQTXiBT9x7ZuP8k1ZUUkJI5/1ijXNkeQHuyLQVpgWHLlcdAl?=
 =?us-ascii?Q?3kLwHHLh3OnBfrzTX2tMQMgbKq2omWiEUUpW8Qd3oaXbUtCX4fbjSD1DTPQL?=
 =?us-ascii?Q?IxbVUeG5ySqoEKi95iSf3A5BGOp3+16xiAfiGFkXV0MIwqTwxIzDqGqeiDvj?=
 =?us-ascii?Q?dhEzwlHPenay5xBZv6nsbjcCXhgiplE6q5mB408W/Edhovatx4mFnhLzezFB?=
 =?us-ascii?Q?TPW0IwPhD3dftVJVU13iPHzWgAGj4fUVFlgscKwF6fjRrxsX+nRxGPs3NyZ2?=
 =?us-ascii?Q?vqAusWs17tysMYUsaux5qCabJHh2GPK7jo8knvOe2/y08DyvJyI/FXpros2D?=
 =?us-ascii?Q?AiJfiJXyhIIi6n5plWVt8f9mB6WklA3xv3zwU3Jj53F5iw3eb9XZAyIgIhHc?=
 =?us-ascii?Q?YVrNfeuXDTQqJ4exXL1KledKhbK3y7WZXualgtgWfwVaTTFMV68ogmfp5FQa?=
 =?us-ascii?Q?PMTxnCVvh/k3/bbvWW0LFWIt4kWyNihD3h75fvq9FDy7Tjn3EF248DyQN4rt?=
 =?us-ascii?Q?bE67ciZH/g3HITQDspixN2gMWzmTZTSdjZsKEoehVcByGStYcmwuj73cyiWI?=
 =?us-ascii?Q?wpCsWMH2wE+cAZHnB5rLFnl5BgkBopL/1svNpgCNIdYZnR9YiSbH/1XI2+So?=
 =?us-ascii?Q?t+K87vHs2Wx5f6rqxmiBWIHKpU3Ntp33UnWuCTSL0Ii9FMgboYX2NnfabUzO?=
 =?us-ascii?Q?TKiMXLPaKcET61ObyBuT/aySU/QJUZ2f3YFb28qQhHgx1DfOcpeeY+ntjIQF?=
 =?us-ascii?Q?DJfADMGqPfZNyIqcYh9Ljmut5hceGN4vPONjzzfKxeYBIptgXWY2SA3TkNNd?=
 =?us-ascii?Q?jpwLsuOh2tt2/q3qOZAu0ak4ikV/bV8He+jttNZY6/NDgrsrz+R4jgFANcu6?=
 =?us-ascii?Q?3vB4Z+5vRk7rs4LBn4CZng+OYYe+3L1qh2KmENIjcQZ6IKgHViHRABpgtoh1?=
 =?us-ascii?Q?fb8qLCxlYv8sxFPNVBSb7wGbucXaGdpDuoWY2dt/dWiJuUl9V7JQ1iE+UR4P?=
 =?us-ascii?Q?Jc1EZ2yh+yL1OLCo2B9KTBpvTO1OQhDRHnDRJSN8cY0WwGS6Aw8iAlQpxI1v?=
 =?us-ascii?Q?viWcrsIQqZ44WzYyVLgMKn3FiCQAG6HMlKo77G+V2xz02Q+H0kD1MxmDdjzb?=
 =?us-ascii?Q?jP4FSEMhaGHmUPL5grGBPeZvgCwkna6qjWf4/lEUjm73lynToO8n3GJQIsQg?=
 =?us-ascii?Q?Lprld/gux31hY/joropyeNyZA6gXh+SLxQ6bpRRwTAuz/XtDEWBsgNs+5TeG?=
 =?us-ascii?Q?upGx6V6soj1ZB+q3rArVVZfl/n3fTIDoklaZgRPNzXmAcNV2D9lNn1V3fDmI?=
 =?us-ascii?Q?ryTLgb1MGIIB+zSaK4yQNKeupzdaApdaVgxJnjs6G7vuwM3F/AxWrLx+HWkW?=
 =?us-ascii?Q?7F88j5g1u1KRxlMc36CWdhmUC4a7Iy/DK4oCkGaYNxeVR1rb1xhVzm+ayALn?=
 =?us-ascii?Q?3UrcYolAguN4RPwfKCfIaeN3zZeO/Vr+egVywA62js+N9DxcV8T+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfde268-d7f9-4997-e46c-08ded67c0ad9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:48:58.1013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQ+aX06zI1AM5s8paBXWtWktqsvVUy+BTdbUVD4Ny6raA7qk1izOXBqwmReOoEeJ9nHFvHhSM8AkmChQna28WkBOhBlRfojE3I3FRKe6iAisebtRWAy5DTd/0hzIWgJW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9561

From: Wei Fang <wei.fang@nxp.com>

Replace the counter-based MAFT entry tracking (num_mfe/mac_filter_num)
with a bitmap (maft_eid_bitmap) stored in struct ntmp_user, which is a
more appropriate place for NTMP resource management.

The bitmap approach brings two improvements. First, the entry deletion
in enetc4_pf_clear_maft_entries() now checks the return value of
ntmp_maft_delete_entry() and only clears the corresponding bit on
success, keeping hardware and software state in sync. Previously, the
counter was reset unconditionally regardless of whether the hardware
deletion actually succeeded.

Second, entry allocation in enetc4_pf_add_maft_entries() uses
ntmp_lookup_free_eid() to find available IDs dynamically, with an
upfront capacity check via bitmap_weight() to avoid partial failures.

The MAFT entry count is moved into ntmp_user.maft_num_entries and
initialized once during enetc4_init_ntmp_user(). Helper functions
enetc4_ntmp_bitmap_init() and enetc4_ntmp_bitmap_free() manage the
bitmap lifetime. The debugfs show function is updated accordingly to
iterate over set bits under rtnl_lock().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/enetc4_debugfs.c | 30 ++++--
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 95 ++++++++++++++-----
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  3 -
 include/linux/fsl/ntmp.h                      |  2 +
 4 files changed, 95 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index 1b1591dce73d..4a769d9e5679 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -31,9 +31,11 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	struct enetc_si *si = s->private;
 	struct enetc_hw *hw = &si->hw;
 	struct maft_entry_data maft;
+	struct ntmp_user *user;
 	struct enetc_pf *pf;
-	int i, err, num_si;
-	u32 val;
+	u32 val, entry_id;
+	int i, num_si;
+	int err = 0;
 
 	pf = enetc_si_priv(si);
 	num_si = pf->caps.num_vsi + 1;
@@ -50,22 +52,30 @@ static int enetc_mac_filter_show(struct seq_file *s, void *data)
 	for (i = 0; i < num_si; i++)
 		enetc_show_si_mac_hash_filter(s, i);
 
-	if (!pf->num_mfe)
-		return 0;
+	user = &si->ntmp_user;
+	rtnl_lock();
+
+	if (bitmap_empty(user->maft_eid_bitmap, user->maft_num_entries))
+		goto unlock_rtnl;
 
 	/* MAC address filter table */
 	seq_puts(s, "MAC address filter table\n");
-	for (i = 0; i < pf->num_mfe; i++) {
+	for_each_set_bit(entry_id, user->maft_eid_bitmap,
+			 user->maft_num_entries) {
 		memset(&maft, 0, sizeof(maft));
-		err = ntmp_maft_query_entry(&si->ntmp_user, i, &maft);
+		err = ntmp_maft_query_entry(user, entry_id, &maft);
 		if (err)
-			return err;
+			goto unlock_rtnl;
 
-		seq_printf(s, "Entry %d, MAC: %pM, SI bitmap: 0x%04x\n", i,
-			   maft.keye.mac_addr, le16_to_cpu(maft.cfge.si_bitmap));
+		seq_printf(s, "Entry %d, MAC: %pM, SI bitmap: 0x%04x\n",
+			   entry_id, maft.keye.mac_addr,
+			   le16_to_cpu(maft.cfge.si_bitmap));
 	}
 
-	return 0;
+unlock_rtnl:
+	rtnl_unlock();
+
+	return err;
 }
 DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index a02b01753ff2..4143438ea7a7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -32,9 +32,6 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 
 	val = enetc_port_rd(hw, ENETC4_PMCAPR);
 	pf->caps.half_duplex = (val & PMCAPR_HD) ? 1 : 0;
-
-	val = enetc_port_rd(hw, ENETC4_PSIMAFCAPR);
-	pf->caps.mac_filter_num = val & PSIMAFCAPR_NUM_MAC_AFTE;
 }
 
 static void enetc4_get_psi_hw_features(struct enetc_si *si)
@@ -92,31 +89,45 @@ static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
 
 static void enetc4_pf_clear_maft_entries(struct enetc_pf *pf)
 {
-	int i;
+	struct ntmp_user *user = &pf->si->ntmp_user;
+	u32 entry_id;
 
-	for (i = 0; i < pf->num_mfe; i++)
-		ntmp_maft_delete_entry(&pf->si->ntmp_user, i);
-
-	pf->num_mfe = 0;
+	for_each_set_bit(entry_id, user->maft_eid_bitmap,
+			 user->maft_num_entries) {
+		if (!ntmp_maft_delete_entry(user, entry_id))
+			ntmp_clear_eid_bitmap(user->maft_eid_bitmap, entry_id);
+	}
 }
 
 static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
 				      struct netdev_hw_addr_list *uc)
 {
+	struct ntmp_user *user = &pf->si->ntmp_user;
+	int mac_cnt = netdev_hw_addr_list_count(uc);
 	struct maft_entry_data maft = {};
 	struct netdev_hw_addr *ha;
+	u32 available_entries;
 	u16 si_bit = BIT(0);
+	u32 entry_id;
 	int err;
 
+	available_entries = user->maft_num_entries -
+			    bitmap_weight(user->maft_eid_bitmap,
+					  user->maft_num_entries);
+
+	if (mac_cnt > available_entries)
+		return -ENOSPC;
+
 	maft.cfge.si_bitmap = cpu_to_le16(si_bit);
 	netdev_hw_addr_list_for_each(ha, uc) {
+		entry_id = ntmp_lookup_free_eid(user->maft_eid_bitmap,
+						user->maft_num_entries);
 		ether_addr_copy(maft.keye.mac_addr, ha->addr);
-		err = ntmp_maft_add_entry(&pf->si->ntmp_user, pf->num_mfe,
-					  &maft);
-		if (unlikely(err))
+		err = ntmp_maft_add_entry(user, entry_id, &maft);
+		if (unlikely(err)) {
+			ntmp_clear_eid_bitmap(user->maft_eid_bitmap, entry_id);
 			goto clear_maft_entries;
-
-		pf->num_mfe++;
+		}
 	}
 
 	return 0;
@@ -146,10 +157,10 @@ static void enetc4_pf_set_uc_hash_filter(struct enetc_pf *pf,
 static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
 					 struct netdev_hw_addr_list *uc)
 {
-	int mac_cnt = netdev_hw_addr_list_count(uc);
 	struct enetc_si *si = pf->si;
+	int err;
 
-	if (!mac_cnt) {
+	if (netdev_hw_addr_list_empty(uc)) {
 		/* clear both MAC hash and exact filters */
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
@@ -157,21 +168,19 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
 		return 0;
 	}
 
-	if (mac_cnt > pf->caps.mac_filter_num)
-		return -ENOSPC;
-
-	/* Set temporary unicast hash filters in case of Rx loss when
+	/* Set temporary unicast hash filter in case of Rx loss when
 	 * updating MAC address filter table
 	 */
 	enetc4_pf_set_uc_hash_filter(pf, uc);
 	enetc4_pf_clear_maft_entries(pf);
 
-	if (!enetc4_pf_add_maft_entries(pf, uc)) {
+	err = enetc4_pf_add_maft_entries(pf, uc);
+	if (!err) {
 		enetc_reset_mac_addr_filter(&pf->mac_filter[UC]);
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 	}
 
-	return 0;
+	return err;
 }
 
 static void enetc4_pf_set_mc_hash_filter(struct enetc_pf *pf,
@@ -393,18 +402,60 @@ static void enetc4_configure_port(struct enetc_pf *pf)
 	enetc_set_default_rss_key(pf);
 }
 
+static void enetc4_get_ntmp_caps(struct enetc_si *si)
+{
+	struct ntmp_user *user = &si->ntmp_user;
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_PSIMAFCAPR);
+	user->maft_num_entries = FIELD_GET(PSIMAFCAPR_NUM_MAC_AFTE, val);
+}
+
+static int enetc4_ntmp_bitmap_init(struct ntmp_user *user)
+{
+	user->maft_eid_bitmap = bitmap_zalloc(user->maft_num_entries,
+					      GFP_KERNEL);
+	if (!user->maft_eid_bitmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void enetc4_ntmp_bitmap_free(struct ntmp_user *user)
+{
+	bitmap_free(user->maft_eid_bitmap);
+	user->maft_eid_bitmap = NULL;
+}
+
 static int enetc4_init_ntmp_user(struct enetc_si *si)
 {
 	struct ntmp_user *user = &si->ntmp_user;
+	int err;
 
 	/* For ENETC 4.1, all table versions are 0 */
 	memset(&user->tbl, 0, sizeof(user->tbl));
 
-	return enetc4_setup_cbdr(si);
+	err = enetc4_setup_cbdr(si);
+	if (err)
+		return err;
+
+	enetc4_get_ntmp_caps(si);
+	err = enetc4_ntmp_bitmap_init(user);
+	if (err)
+		goto teardown_cbdr;
+
+	return 0;
+
+teardown_cbdr:
+	enetc4_teardown_cbdr(si);
+
+	return err;
 }
 
 static void enetc4_free_ntmp_user(struct enetc_si *si)
 {
+	enetc4_ntmp_bitmap_free(&si->ntmp_user);
 	enetc4_teardown_cbdr(si);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 285b7e5c48fd..6f15f9ea1664 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -22,7 +22,6 @@ struct enetc_port_caps {
 	int num_msix;
 	int num_rx_bdr;
 	int num_tx_bdr;
-	int mac_filter_num;
 };
 
 struct enetc_pf;
@@ -60,8 +59,6 @@ struct enetc_pf {
 
 	struct enetc_port_caps caps;
 	const struct enetc_pf_ops *ops;
-
-	int num_mfe;	/* number of mac address filter table entries */
 };
 
 #define phylink_to_enetc_pf(config) \
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index d3b6c476b91a..764ef2892608 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -75,8 +75,10 @@ struct ntmp_user {
 	/* NTMP table bitmaps for resource management */
 	u32 ett_bitmap_size;
 	u32 ect_bitmap_size;
+	u16 maft_num_entries;
 	unsigned long *ett_gid_bitmap; /* only valid for switch */
 	unsigned long *ect_gid_bitmap; /* only valid for switch */
+	unsigned long *maft_eid_bitmap; /* only valid for ENETC */
 };
 
 struct maft_entry_data {
-- 
2.34.1


