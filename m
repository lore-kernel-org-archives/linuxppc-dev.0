Return-Path: <linuxppc-dev+bounces-21082-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63C1CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 08:23:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJrRR2hhVz2yRM;
	Mon, 18 May 2026 18:23:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092611;
	cv=pass; b=kBSKDkoY+TPFMlLpDPtrxQ+qs4Xb6GbL1DFJ5tfhxttXymqjeOdtpw451OE+I01Ieo4XU8CbbxJOaBKKdfYJE5FKENABu1ZD1qi6N7N41qneqbS5Ry3RT0iZoYoqQ+0TNyLdipQ8RHltkGiLQ5K/mkNz1k9p0aPXUfrQwFifbImBWcfRu4i/O1VOAiiz1+ESPKkESAxcFfGT+z7bp4KoErrTYupEMS4z19Dky9fmTkhMAJ48sns6v+5LNvWRvfUSIWGZy8z7lPUATcXwCDHyF/z28wBUaPW5YHar/0wS36cPusyR+GFNdb6R92BD3UuihTXJveS2DMhY9fe2oyoR9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092611; c=relaxed/relaxed;
	bh=+OkTituhj851UTH98eKeCkJCczBoTU+PcRf+naGINh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XaWVPKC1hfcCfuHn6Qacgkkrkg5LJ1KKEuKmXGXZCWxagh2Ai1Ea/t/iI/OWTzYyB4B/oyyoCHIsR9LMNHQTlY/oy3rZkTK9yAUB+lcuCiocx6crN0PKaDsjttBL/9pGKYA77ljp5pStcCtC5d44gw+LBSJrDidW5KGciHbrsSGLhO3KxqkVTqiU+SNmV1cI509LgFSQkYpWEKbmPcJM+N6kfsqtt0Pk8W0v5F91KZ/vmgzuFfJvq2cx/YorIci+Pu+CD7vZ60/T7GHpihCif9LpIxVQ8kMmTaZ3Mp0Z/JT33BglyxtnJbnlL6syVXpikWsnHnEmM6SFWJ+yQ+88gw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=L0hzpxGn; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=L0hzpxGn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrRP6m0Fz2yRG
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 18:23:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgHruWpo8T49nfD9Svr6Uhc7QYys401r/tzU5QEEtIib1rI8Mc8pqLH+BlaZXwUrYH703lL+mRN5xcJAjJhTkY28hGdjkswxJEw0Zh4leBZQFp8k3cDr5aRBhIpctW6EBqiZN+2dvBGUy36LgG617T9WnmC2zz/czS2z1rlieXwQcpduKDu4YifTWHe2UXCFpeemfLZ697GyTEb46IMicdgKtP6aKm6CLaz/oRBbToZvyXvH6CAZYB5v5TkQeZ24jMZc+IT0KDP7pLjLQyufle3BQmf/t82PHCkGgJ2YWBv36TRn+ODeLJPzhopY09PTT9FLXgErG7vZltFjHguBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OkTituhj851UTH98eKeCkJCczBoTU+PcRf+naGINh0=;
 b=C3evI6QXC4vgD6HYiXGw9pdEH2IWMYJ8HdUekrb68kirH8cdV/TwjpoJTSFVxf0LRMVJ2n7W7KBAvI+ZaxyEbgJkLTtNOAqWdYlA0IWoaxHElpz8e4+RzSJz8ue+NK6Jzb2Tnh0Ja577f70ASwuSswqSaEdHpm+TvLrslkFknWI6ddp5kUs7x/bMGHysZ6a5G0h+7IsN81DJ3Hpq5poFSl4bAqHSXKexonYkA9ruzVe0DRvR3oU59BlieYMWG5vKFHj7tjOUKu/6AQfHFwT9Q3dJbIrwdIHJ91cC/6PuKKzvn3usrCwpK5DRK/I1bpRHQhSkKmAFwedjm5X4FHk3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OkTituhj851UTH98eKeCkJCczBoTU+PcRf+naGINh0=;
 b=L0hzpxGn1T2N+ALPyo0sn6eYEl+L+C6VAqbAzZp3bPIZFU6xCz6QTrYY5iTCQGLvB5KfC2FrCN0FwCKUcjyFPUZdmKnaVttjNjkliV+G0Jr+iDEcClFSoK7zwouoNMLOE+xWrAnH5X5dWxpdC9uImHiDhTL2jsFnWvM+7b8mJrH1VWZn18j4bNIN5OBWAxVIH1lbi4fL7r9qisWyPN1xBnBmg+2XmlDecEClcwWJ2lrFv9+YC4Y50o4f+a3NoInpXDLROyJD8SJsFXI+GKqDV8gqkYJWaY4dEYpmIgIlyKkzrcvv3WeoEbpOgyG4OT/d2Rvs003/XkiWT1QW2JxRLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:23:06 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:23:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v8 net-next 03/15] net: enetc: add pre-boot initialization for i.MX94 switch
Date: Mon, 18 May 2026 16:24:54 +0800
Message-Id: <20260518082506.1318236-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
References: <20260518082506.1318236-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: b89cfda7-fac6-4328-fb6a-08deb4b6afe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003|22082099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	as60KQhfKIc9AdKs/AXcDyThi94gF/GBL/djEo3Fu9EOYIefPXI7PP7EnZff9syvbaT4RN93FBBYv0XXBATtYJ3Qxl/duxmHY/kcteW7/NfIAi3iw3aGu7v4Sm3Zh7BNtqvNUyRO9pCUzSfBRb8BajigDQA4/5FxqiIeWiu2CVmWN7Zec6qYtz3qd/6U6JVRlaiRUbykf4kjDEI4ih15k61pVsRlZWav01+/OtEMy9LmGwYJ2nj0tOojJ26P9VTJZz+5m1VjCgcp/Bwpz/d/oUP1BEPgKEju4NI51Wp+opaDaM7QJzjsAyiK9ahzWHu+RLK0S1MEK9CtvzoCcSVOmK1LSxfqDLPXb2teSFoTxB6NPa8Z20cm63aP7oOrd85pzdeb/UP/6o/RH88gEojB6EqkrPYNoU/GvlB70n645ImpBtH7ZkFE4ZDyRsQBQS0aPnQAybFGSpIQqTiLDAcY3H2sZAgGCdGJBtjX6ZyykzhLa37flydrWla8UmG0NraS5aCvFN8jPvuRbqD6hYkP4WTcsYpKEBvhpK2x2fLMZ+cYr1DecsRlOdxjqEafHLk8olELrOCK5t6GLE3iWikeYHnQG1ZLpF11VgYZQvPmNn6W8Qm2DDcz/6oTSV3CAL1/eYhbWJpmpEDWcQFZiRaSUtBUICYP72xXhRaTCuQS7ZK1rmx+xU2C1WDukGEj+4x23IgSN9805d9VXC6MPlyQ0wj3yZteOqFraO/EuFGdejXLYoHnIK6zVyRNt17iIykDPipzsJJXbnnEQsRxwpec9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bY5dyUTtAqBkNHGjAyUMCXa5f+k3d7kT4LE3z/slFa7qQbdCuvomigPa46kR?=
 =?us-ascii?Q?lz68F1JdYqPMxdLPtuSCosDTK92DYf8WXpE+O2hNMjnM9njVX25NNElwV5GH?=
 =?us-ascii?Q?Rv4V4XRzumw9+wg0IzQMpHHnx6CbymXBeR8OeQsz1uL6+NyIlwNCLsVlh/HN?=
 =?us-ascii?Q?YcxvnZuQR1RGW820ds7a2KTzXrHHd5YoXA92fY767I5zL3vLOYbTkmmD0yj7?=
 =?us-ascii?Q?CtokbfwEyVRVxhUWNQQeHxilL9ows2su+TWeQOSVbrAoe1cA+SD4QHgOTvak?=
 =?us-ascii?Q?BiObapOqliOS0QUuEeAaD0BKtdhYmKOxxKr/6I8qNj+R3QuciPaJNE4LwFmd?=
 =?us-ascii?Q?CWv2W0RktYV7id23RkpH141s1XaV+f1ik63XO7YRsC489yU7UdcTCPaQC58h?=
 =?us-ascii?Q?gBK2Aoz8fGL5bwa3xj2TnTzH82jVIRCrCN7JpIxVkX89KWC/uaFnf5TQTfZ4?=
 =?us-ascii?Q?MthErxstjk6gfocn8B2Ht7ZYd1GKe8z+HudqB6roFAFFvVcuS6kU5IFKhERk?=
 =?us-ascii?Q?dfX1AnL773NdbNjoHItv/TgXxp76Tcr3pHMoJnzjd0pf6WKeXIHRLjwmLdA/?=
 =?us-ascii?Q?gvhRni7JsctYg+OpD31+4b+4vOat1Cz4aXlDWQfK+NKYiwlkkPaYKitxbiqO?=
 =?us-ascii?Q?OTDSMfaCUiq8qEocTyXXHYWJId4WZrk+xvWvhGLOzY+mDm1hSb8B7CBC5DJ/?=
 =?us-ascii?Q?2DMPVLkU5cEoq5BUUqhBcdSO0VgaSjvcVJTfsmfVkxYjfSSpTS4yO0nNz3+D?=
 =?us-ascii?Q?7tDFM1EiUwpZ3Rtwxmww6KheQ//EoZKS3stpWriAC9pTAP0G3QjBDyqrhwvI?=
 =?us-ascii?Q?qhmS9M2Wm7pCQV2TIWN5uLKMFwVdH9DdxAo4WugRLsgMdy8GeRLXBTouEQ4N?=
 =?us-ascii?Q?99C7L4sJWI2cbNXefyilYEew5PmCPdlK9EalrSCpaWr5BdCqNIYOkLvSS0Mo?=
 =?us-ascii?Q?JsipOh9iqTVmtp2jE9HXukQiFPjJAIBmaDmlCaCTZfPhub4LIqYb14FJ3el7?=
 =?us-ascii?Q?W1OJ3z1c4KSVm8aiK9gIWGEE5R0PMbuMJIrYFvfo9Sal9Fx60MX1snt30wKY?=
 =?us-ascii?Q?BF5k4j8jbEBVTW8O8h22D1KO5FNc9rwfS535l0INujWYql9JCIgdJ4LoxX3o?=
 =?us-ascii?Q?2tj44yHYarCqjPk4i5i7Yj+mrodUlrWUoGT5dMv7+0o3ptbENVr62XyopCYD?=
 =?us-ascii?Q?XJUT1MwgQdVxz/8P6p/a6/SNLrL56KaJsMYpuhb0lnE9t0o5xDj/w50qBdr/?=
 =?us-ascii?Q?CNtfdRpL7ZcXCeeMRMFBvpXP4leSGZkJn3H3bOp6lrsBDooaRutPNwRJHUNo?=
 =?us-ascii?Q?PZRYsDMfPi41uGXKZOJSLrR//rnj4Mfc5fw+SRNTc/Pcwwg4w7LVWT7rmIea?=
 =?us-ascii?Q?8mwbHD2hUc/H+h5A4Z5pSddfSyPsL4/Yhs2jBShZH0YwokosLXTjlpB0NIXF?=
 =?us-ascii?Q?0Z8QNLOzREE1lLKiKCZsO9hTrrDLxh5ApAyX9SmI8JVTnX7kwCIewlZbot0z?=
 =?us-ascii?Q?zOKyzs9gwgxW0UTS5snWx0BCD5U3IhWpKMllloE/1BaYRFo+OHcNOuj9oVzX?=
 =?us-ascii?Q?RIFzlA5eFoq70/iE4SVIthGD2Yinrg3RRXxR1o0bKnWGhVHtciQQJFWFIuLz?=
 =?us-ascii?Q?Z8eWQFcXfTKCR29BFj1lsfQg+Zq+FtBWOTBXwdS6uhQ6DVqLcKQHVJj8fWVn?=
 =?us-ascii?Q?0bk/e4gnOlQ4uljgfhToEQjyZW8GnwL9Be/LjS/98kiBASwHPllYe4rQ98rq?=
 =?us-ascii?Q?475p2alOzg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89cfda7-fac6-4328-fb6a-08deb4b6afe1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:23:06.3672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85IY7QE7Gn8fDxRfQPfD5ebFwB8AG5GOGu9o+YnHFPmQNxkmNm164XonE8hQVpLtihTZWyfctumuLHiiyMy6IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713

Before probing the NETC switch driver, some pre-initialization needs to
be set in NETCMIX and IERB to ensure that the switch can work properly.
For example, i.MX94 NETC switch has three external ports and each port
is bound to a link. And each link needs to be configured so that it can
work properly, such as I/O variant and MII protocol.

In addition, the switch port 2 (MAC 2) and ENETC 0 (MAC 3) share the same
parallel interface, they cannot be used at the same time due to the SoC
constraint. And the MAC selection is controlled by the mac2_mac3_sel bit
of EXT_PIN_CONTROL register. Currently, the interface is set for ENETC 0
by default unless the switch port 2 is enabled in the DT node.

Like ENETC, each external port of the NETC switch can manage its external
PHY through its port MDIO registers. And the port can only access its own
external PHY by setting the PHY address to the LaBCR[MDIO_PHYAD_PRTAD].
If the accessed PHY address is not equal to LaBCR[MDIO_PHYAD_PRTAD], then
the MDIO access initiated by port MDIO will be invalid.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 185 +++++++++++++++---
 1 file changed, 163 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 92a0f824dae7..c7eb0234c785 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -261,40 +261,108 @@ static int imx94_link_config(struct netc_blk_ctrl *priv,
 }
 
 static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
-				   struct device_node *np)
+				   struct device_node *np,
+				   bool *enetc0_en)
 {
 	int link_id = imx94_enetc_get_link_id(np);
 
 	if (link_id < 0)
 		return link_id;
 
+	if (link_id == IMX94_ENETC0_LINK && of_device_is_available(np))
+		*enetc0_en = true;
+
 	return imx94_link_config(priv, np, link_id);
 }
 
+static int imx94_switch_link_config(struct netc_blk_ctrl *priv,
+				    struct device_node *np,
+				    bool *swp2_en)
+{
+	struct device_node *ports;
+	u32 port_id;
+	int err = 0;
+
+	ports = of_get_child_by_name(np, "ethernet-ports");
+	if (!ports)
+		return -ENODEV;
+
+	/* The switch may be owned by a guest OS, in this case, the switch
+	 * node in the host OS will be disabled, but we still hope that the
+	 * host OS could do some configurations for the switch, as the
+	 * netc_blk_ctrl is owned by host OS. So of_device_is_available()
+	 * is not needed here.
+	 */
+	for_each_available_child_of_node_scoped(ports, child) {
+		if (of_property_read_u32(child, "reg", &port_id) < 0) {
+			err = -ENODEV;
+			goto end;
+		}
+
+		switch (port_id) {
+		case 0 ... 2: /* External ports */
+			err = imx94_link_config(priv, child, port_id);
+			if (err)
+				goto end;
+
+			if (port_id == 2)
+				*swp2_en = true;
+
+			break;
+		case 3: /* CPU port */
+			break;
+		default:
+			err = -EINVAL;
+			goto end;
+		}
+	}
+
+end:
+	of_node_put(ports);
+
+	return err;
+}
+
 static int imx94_netcmix_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
+	bool enetc0_en = false, swp2_en = false;
 	u32 val;
 	int err;
 
 	for_each_child_of_node_scoped(np, child) {
 		for_each_child_of_node_scoped(child, gchild) {
-			if (!of_device_is_compatible(gchild, "pci1131,e101"))
-				continue;
-
-			err = imx94_enetc_link_config(priv, gchild);
-			if (err)
-				return err;
+			if (of_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_enetc_link_config(priv, gchild,
+							      &enetc0_en);
+				if (err)
+					return err;
+			} else if (of_device_is_compatible(gchild,
+							   "pci1131,eef2")) {
+				err = imx94_switch_link_config(priv, gchild,
+							       &swp2_en);
+				if (err)
+					return err;
+			}
 		}
 	}
 
-	/* ENETC 0 and switch port 2 share the same parallel interface.
-	 * Currently, the switch is not supported, so this interface is
-	 * used by ENETC 0 by default.
+	if (enetc0_en && swp2_en) {
+		dev_err(&pdev->dev,
+			"Cannot enable swp2 and enetc0 at the same time\n");
+		return -EINVAL;
+	}
+
+	/* ENETC 0 and switch port 2 share the same parallel interface, they
+	 * cannot be enabled at the same time. The interface is set for the
+	 * ENETC 0 by default unless the switch port 2 is enabled in the DTS.
 	 */
 	val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
-	val |= MAC2_MAC3_SEL;
+	if (!swp2_en)
+		val |= MAC2_MAC3_SEL;
+	else
+		val &= ~MAC2_MAC3_SEL;
 	netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
 
 	return 0;
@@ -610,6 +678,78 @@ static int imx94_enetc_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
 	return 0;
 }
 
+static int imx94_ierb_enetc_init(struct netc_blk_ctrl *priv,
+				 struct device_node *np,
+				 u32 phy_mask)
+{
+	int err;
+
+	err = imx94_enetc_update_tid(priv, np);
+	if (err)
+		return err;
+
+	return imx94_enetc_mdio_phyaddr_config(priv, np, phy_mask);
+}
+
+static int imx94_switch_mdio_phyaddr_config(struct netc_blk_ctrl *priv,
+					    struct device_node *np,
+					    u32 port_id, u32 phy_mask)
+{
+	int addr;
+
+	/* The switch has 3 external ports at most */
+	if (port_id > 2)
+		return 0;
+
+	addr = netc_get_phy_addr(np);
+	if (addr < 0) {
+		if (addr == -ENODEV)
+			return 0;
+
+		return addr;
+	}
+
+	if (phy_mask & BIT(addr)) {
+		dev_err(&priv->pdev->dev,
+			"Found same PHY address in EMDIO and switch node\n");
+		return -EINVAL;
+	}
+
+	netc_reg_write(priv->ierb, IERB_LBCR(port_id),
+		       LBCR_MDIO_PHYAD_PRTAD(addr));
+
+	return 0;
+}
+
+static int imx94_ierb_switch_init(struct netc_blk_ctrl *priv,
+				  struct device_node *np,
+				  u32 phy_mask)
+{
+	struct device_node *ports;
+	u32 port_id;
+	int err = 0;
+
+	ports = of_get_child_by_name(np, "ethernet-ports");
+	if (!ports)
+		return -ENODEV;
+
+	for_each_available_child_of_node_scoped(ports, child) {
+		err = of_property_read_u32(child, "reg", &port_id);
+		if (err)
+			goto end;
+
+		err = imx94_switch_mdio_phyaddr_config(priv, child,
+						       port_id, phy_mask);
+		if (err)
+			goto end;
+	}
+
+end:
+	of_node_put(ports);
+
+	return err;
+}
+
 static int imx94_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -625,17 +765,18 @@ static int imx94_ierb_init(struct platform_device *pdev)
 
 	for_each_child_of_node_scoped(np, child) {
 		for_each_child_of_node_scoped(child, gchild) {
-			if (!of_device_is_compatible(gchild, "pci1131,e101"))
-				continue;
-
-			err = imx94_enetc_update_tid(priv, gchild);
-			if (err)
-				return err;
-
-			err = imx94_enetc_mdio_phyaddr_config(priv, gchild,
-							      phy_mask);
-			if (err)
-				return err;
+			if (of_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_ierb_enetc_init(priv, gchild,
+							    phy_mask);
+				if (err)
+					return err;
+			} else if (of_device_is_compatible(gchild,
+							   "pci1131,eef2")) {
+				err = imx94_ierb_switch_init(priv, gchild,
+							     phy_mask);
+				if (err)
+					return err;
+			}
 		}
 	}
 
-- 
2.34.1


