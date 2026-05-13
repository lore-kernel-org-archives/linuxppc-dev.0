Return-Path: <linuxppc-dev+bounces-20810-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC83CD37AC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 03:04:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFdZh3Bgmz2yjV;
	Wed, 13 May 2026 13:03:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778641420;
	cv=pass; b=JgsdIEdN6l1h+M74SiQ631hmgTKKQpcdpCOy3pWF4TbbvYjYf8XVTTZMPg6r49lLGk/SLbHcA7fyTKpvePIWfYhff9VRyleAFBebSxt51cK0rBPr1Hw9f43YpBVjTkXkMMaD3+7uogg8/rkPHfy8FROVgUAtm6veVNz1qZ3IG1vFxbDPKWcVHPNMjvHLK8ZFCATuGrPM2DHUnwVaA+mlRLdzcXRs8I0yqDC+PUAsDNZSoGYADAhLyutHqpyqCVwG/GhJJGSlcSHYEodn1UelnPonmvKLpRd0DHYG6LrF7KacIP/3keOrGkPQfLiucc+rmyEKSyqH91BrkD7Wr2Nw1w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778641420; c=relaxed/relaxed;
	bh=qvZD7RKAOit+A6vLdSJFZZBr2RIUJUB9qfD7p2UAYNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kT/0V+WzDlPNEaN3XPd4lGOfcgzlU5x0n1KKDbBs1QDNTIByYvZnToFe6q/BGc/Sp+qtONH5tz8ql2A3/v1Rwsv510HigfC3QYh3Ty8JDoDecjCUhBbxc/l+XkK1i9A3DyC7V+gS1yMAlsJFXRYA0CbMYHfvLVuRA5t77JQTs+czUv+CscR4thGeGJfbg02+7t1gqozDvxO4GU6HO5qfmGqbWOQ7sDxAYzRPzKQSS0M0dRzMAtQu/PHeEDwxCNol376g47DLlq9XOXSbUtO9urjL3yC8XCJr7t+FzJinKoYs3MZIoLmbRMUOzb//upDVTjMvDQMjLqd74R6MudXFGA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=hnSqcZ9C; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=hnSqcZ9C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFdZg2p9fz2yl2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 13:03:39 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbryvYNkFWwnZpZ6pmgg8B758N/n7m6SR0GkE6fI5+WnYDUyuK4OyqP2G3LV+0PQsYIvwNoCutvmhJHLdfUvVcq2GWq9fhYoubrKxePS98WRXxracP9XBTi8HqJGWVDqGghBOgx+Hv2vIT3nbvhdMxVhHf7EMLbOp05qJhCMMhzS2zCEv4RSZp7AegpFUIrXDVsM6n3HCLOn64i6nbvz210FgFgJ91oo1ALr2pJ72Dcm6el9o0dxIpEzQUSgTLI3rbJ7g/ku0urc+kPSPig4O4hr0kEreYtTeIGE3dy7lzF8KL74Ep+omd+sxzcVRzrprafA6YXNQ3mNKzMPHXGXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvZD7RKAOit+A6vLdSJFZZBr2RIUJUB9qfD7p2UAYNs=;
 b=Mm6aLV6QTwC9jrOmKJIWizQzC0fObTxqp12fSlijkzlSrFxGwr7cQUUx5t/NBhcSbJX7cVhQW2CqiUdmXipeufIvcYdqxqhm4NOgxMPhesqumjxT+aRsDaPX5iyYMG3x7r7QOQD3Y/uJ9WNP995SNVAox1zQePB8cKTPIgFR34HGSBb8o0EOoviSv7sKBxlkgI5jd1/yTdBnHUNn9RbM3CoFD9XaeYRTYKOSzrzVoJDRVOnLTC7pswv9k9OKgICGDPtRLXMjzP7QhkvKaCqTS0VSxKrZwZzAznk3BhblRUL2731WHj0lP9GU+jV8mt1xcX6t5W3eWYUi4Ek9NOmEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvZD7RKAOit+A6vLdSJFZZBr2RIUJUB9qfD7p2UAYNs=;
 b=hnSqcZ9C9mWLF3LFMX5oKubvrsX6xzv//G3ehJWurMCUHseFNm/r1M+fliEdgW/yWj2pBejZrHYJhQ2EJYyUvZ4cWrPSiUqgUMRP3F1dxRzD3ke/EAluG+8Pt6irwluZxqFYCCNQ39kxE4c3jmx0WA/lnxePbfzRowA9n3v8kRFr4L1Do+lyM8PCF7SIuKHvMU1AUG0/joAqIbouA/IcJcVqGaxQKDNIyROmtvnKaLwZg6Aious7B2WK8iPnI4N41L86hwFYF8r3amd41raY2QnxGip5orAJtVIPq9VeJncXhGLqbdFCOSxf4S3V4QDR/qDJggSjeEZk6ry/H6bvgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by GV1PR04MB11525.eurprd04.prod.outlook.com (2603:10a6:150:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 03:03:32 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 03:03:32 +0000
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
Subject: [PATCH v7 net-next 09/15] net: dsa: add NETC switch tag support
Date: Wed, 13 May 2026 11:04:48 +0800
Message-Id: <20260513030454.1666570-10-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513030454.1666570-1-wei.fang@nxp.com>
References: <20260513030454.1666570-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0029.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:17a::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|GV1PR04MB11525:EE_
X-MS-Office365-Filtering-Correlation-Id: 1efe5f85-b767-4a1e-85b8-08deb09c375c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|56012099003|18002099003|22082099003|3023799003|11063799003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	+O9e82mmZNmvAgODan+XipIZWKJAIWwL/tPFUXuoJ1S3cDWhM9HPwsQLuQ1FmUl8qL8oBTZPxQUxYx5mVthSXKN9MFi9QDlfAlbca+KNdk1zlm7HGvoOPLVaLp8pGeeJjrAA7SPSbO6THkRyq2jtlcnq9pzmh1Znhosrl1OJp0Ch+321VRJ6+iKZuOFWxnEmPNaOjKNOvAw6E9BP/Hme5nG5Ay4UQ5LKBikwE91i/ezPPK2RBF97k29ZQ6Y/S3ZUuugCRmP51Hb28fIaDIijgKuHrMG+5dud93R5WJ/8IosyPYogVW5h/NMSCV19Lj702D/wOmBosQDW+twGHRGEfITkxZJxz56KXYHGN+OjqcwCfuF5L+aRVcyMXdeAaJZwrMe4AgFbRRwwMoiXyjZ4TO26+ul4aclz5mjRkE00NOvYsDeGsyG2Wbsd2nkkvY8nQiw6JxpMw/9Q2YW7cX8zChRZ8Bsh898TethGvZr1lKLi1VzU5mSlENOWSyzDOU6AgdoTMdeL46Emuy3Ovc1SoNwpOjILHsvLhimlRL0W8CCv6MqDEzYfCGUF5XeTRzvDqlJFfBYTQ9Oo6t8ZF7rJq0/j+/p87+RvLl4+U1VXI+XT3uu9Gg21R/HxwJrctDElzWeoVbQFCAr3wiPG3vJiq5QP5IXWmQ+ldOV4+v+D6wTuHchmOwAvfCgGEJgXjtmrNpOcnIUcefQon3AhCGoCjHO6HaIWVYdvaEUxtaoRfc5QaXEwoXghcWtNE9wZfenwYGta/kGWL8gf38iXEMkpqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(3023799003)(11063799003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zvAgQGe5upNBmZBYEulYKTy9w4/N48OiCKyR+qxta08akVPjzgbCLigWqMLx?=
 =?us-ascii?Q?B0IWd96rLWV7uxTB1tAAzJbwofqG1D1RKyxZ64mln+aWQG+9MTh/LJ7UnKye?=
 =?us-ascii?Q?AKgIupI6vnMmysdD/JsQwDQPh43yaPNoCTl9XsDH2jiD27aZWsaQH2Gq6Gre?=
 =?us-ascii?Q?/kucqp8XQMxp0FJ9xSIW+3dBAp1OJhpJAzqghWCSlaVeo+Fy0CeI6L5f7gEA?=
 =?us-ascii?Q?jnpocC+Um7IRZtuUTfCwxuKDO1nNUCetbpAlQsU/yRVRH/KB+KZgi7I9rmpx?=
 =?us-ascii?Q?4OymB5ThM9ynjXPNvA5j6OgyBYhrna1kf/svctVAzHKheBi+PQJzKK29yiLu?=
 =?us-ascii?Q?jtzw1U058gP51s5SPHTyAaLs5NoqsrYXw2xt+dWluPsQs+9VKkjNp6ihQpNN?=
 =?us-ascii?Q?LAYPs7HMiPMdxuhfKTiSLlxydbrB2omfMqHj2CDjaZZj9ckva4qPuxn7hY9G?=
 =?us-ascii?Q?EG7xh5G2sn5QF7JUmHaDUZy0rEo+YGkgPlHVsaLBrlEPYULoczSt6PMridDV?=
 =?us-ascii?Q?9dAJizaB676ZgVzJSSgkq+DtyTc/++/xQxUypj69msZ3sJGUNgJ848jM7Haa?=
 =?us-ascii?Q?JnjQBpMNik963uQcp2BVizRsnz9VoZ7GuwJL5THiVnU+/BXtTK06HMy6wQcn?=
 =?us-ascii?Q?jvlytm92my/5XaLbglQVTe5MILePIl++u7khrg0zYtuKaPxYP/hfzV8ZBdlf?=
 =?us-ascii?Q?NC5oDbHjfilHIXeh55yPWx+4npr9vqZ3iRAEuLRyDtjiodvdxJTXl7CtvRxR?=
 =?us-ascii?Q?H0koF1PmCiFDRJdCai6Fsufnlxzdvmy47Of1lh7yRrEoDHWtmh1u/79ZesSW?=
 =?us-ascii?Q?BpY1xwESwqE4UHblDV5baqlgnSK54QMeke/YbrHMSO3vrIy4QjinGs6ixFIA?=
 =?us-ascii?Q?0xyGR0TyX91xdSmqu5LjattcTea+MYygaWE6v3BgF5QB4YZZA2sbW0IATKn8?=
 =?us-ascii?Q?Grnp8l/BFramkvtDHMUmUugnXng8wz6OfeInOES0Sy9JxtvVvWw810IcFYph?=
 =?us-ascii?Q?yftRvQSQuVPxxIw3ido3cqKhcX3D0P2v429ujw+dJAGYE4NCSOC0mjUL99Yy?=
 =?us-ascii?Q?15Cfv5b1oS2zt4BfZZ3/J1oGn1skZOr8/OPvqC0aUcBbP8xyeKTl6GZbsv0i?=
 =?us-ascii?Q?a+jjiQhGWbEn8zVcjGdjbFZURIEO25n8QUaumlN00xZ8U4BaUVcAXWKIaJY1?=
 =?us-ascii?Q?7Gq79KZ41f0p4Slz4d6ul7JoW1Of0HI+jZCtAn7X9F1NsucSGCkroAfCWEF1?=
 =?us-ascii?Q?F7CX6GI6RidMN6HpYjMeR6+kZF+JKnXu7o7xaSev9dtHK5r81/0Qx3TGy51H?=
 =?us-ascii?Q?9MusTDJjtg+Ie6pXs72v1TO6K33qiA206WepMttzoqy8nTp5mPsdu2VPAwJH?=
 =?us-ascii?Q?VsW9SmTobOiTfo0agKqFInB2SIj2qmCdkKXk2sf+qjtAW/t//KkPwgDJ2jR8?=
 =?us-ascii?Q?zKljbzlzzA6o4m531ckE/io6X0btZqogjS0QCj0wKKOp8CLrU6i4M6PPeXlO?=
 =?us-ascii?Q?djVmPpUWaWZLSA5DuMZnrPesULkzvwyToGe1X5ZG+pEDSRTVyPjGLq4e2Cm+?=
 =?us-ascii?Q?YVFDLXMyXA767Cq675fV9EznfQNdoNaIPhkJm9hK5pvCHvJhsWUdXTUKETDq?=
 =?us-ascii?Q?XPPpkpi27X8JYnp43ExPH1eIqqhz1zbLxvitb4WtzAHrbfEGutl71Wyf7nS0?=
 =?us-ascii?Q?GrMbiLS5go8XS0kG2CZU46nRLrNStQTjAHomv7ZBnuNTzKOd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efe5f85-b767-4a1e-85b8-08deb09c375c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 03:03:32.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IaspN3MqpamNwB03KWS6/R5gqlXBlaOselvNBxoCZb9ejbzBEjpSv9ajeJQ5ZJpgiJHZGuuhakuyYTdruSSJUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11525

The NXP NETC switch tag is a proprietary header added to frames after the
source MAC address. The switch tag has 3 types, and each type has 1 ~ 4
subtypes, the details are as follows.

Forward NXP switch tag (Type=0): Represents forwarded frames.
  - SubType = 0 - Normal frame processing.

To_Port NXP switch tag (Type=1): Represents frames that are to be sent
to a specific switch port.
  - SubType = 0. No request to perform timestamping.
  - SubType = 1. Request to perform one-step timestamping.
  - SubType = 2. Request to perform two-step timestamping.
  - SubType = 3. Request to perform both one-step timestamping and
    two-step timestamping.

To_Host NXP switch tag (Type=2): Represents frames redirected or copied
to the switch management port.
  - SubType = 0. Received frames redirected or copied to the switch
    management port.
  - SubType = 1. Received frames redirected or copied to the switch
    management port with captured timestamp at the switch port where
    the frame was received.
  - SubType = 2. Transmit timestamp response (two-step timestamping).

In addition, the length of different type switch tag is different, the
minimum length is 6 bytes, the maximum length is 14 bytes. Currently,
Forward tag, SubType 0 of To_Port tag and Subtype 0 of To_Host tag are
supported. More tags will be supported in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 include/linux/dsa/tag_netc.h  |  14 +++
 include/net/dsa.h             |   2 +
 include/uapi/linux/if_ether.h |   1 +
 net/dsa/Kconfig               |  10 ++
 net/dsa/Makefile              |   1 +
 net/dsa/tag_netc.c            | 214 ++++++++++++++++++++++++++++++++++
 6 files changed, 242 insertions(+)
 create mode 100644 include/linux/dsa/tag_netc.h
 create mode 100644 net/dsa/tag_netc.c

diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
new file mode 100644
index 000000000000..fe964722e5b0
--- /dev/null
+++ b/include/linux/dsa/tag_netc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef __NET_DSA_TAG_NETC_H
+#define __NET_DSA_TAG_NETC_H
+
+#include <linux/skbuff.h>
+#include <net/dsa.h>
+
+#define NETC_TAG_MAX_LEN			14
+
+#endif
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 4cc67469cf2e..8c16ef23cc10 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -58,6 +58,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 #define DSA_TAG_PROTO_MXL862_VALUE		32
+#define DSA_TAG_PROTO_NETC_VALUE		33
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -93,6 +94,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
+	DSA_TAG_PROTO_NETC		= DSA_TAG_PROTO_NETC_VALUE,
 };
 
 struct dsa_switch;
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index df9d44a11540..fb5efc8e06cc 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -123,6 +123,7 @@
 #define ETH_P_DSA_A5PSW	0xE001		/* A5PSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_IFE	0xED3E		/* ForCES inter-FE LFB type */
 #define ETH_P_AF_IUCV   0xFBFB		/* IBM af_iucv [ NOT AN OFFICIALLY REGISTERED ID ] */
+#define ETH_P_NXP_NETC  0xFD3A		/* NXP NETC DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 
 #define ETH_P_802_3_MIN	0x0600		/* If the value in the ethernet type is more than this value
 					 * then the frame is Ethernet II. Else it is 802.3 */
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 5ed8c704636d..d5e725b90d78 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -125,6 +125,16 @@ config NET_DSA_TAG_KSZ
 	  Say Y if you want to enable support for tagging frames for the
 	  Microchip 8795/937x/9477/9893 families of switches.
 
+config NET_DSA_TAG_NETC
+	tristate "Tag driver for NXP NETC switches"
+	help
+	  Say Y or M if you want to enable support for the NXP Switch Tag (NST),
+	  as implemented by NXP NETC switches having version 4.3 or later. The
+	  switch tag is a proprietary header added to frames after the source
+	  MAC address, it has 3 types and each type has different subtypes, so
+	  its length depends on the type and subtype of the tag, the maximum
+	  length is 14 bytes.
+
 config NET_DSA_TAG_OCELOT
 	tristate "Tag driver for Ocelot family of switches, using NPI port"
 	select PACKING
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index bf7247759a64..b8c2667cd14a 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_862XX) += tag_mxl862xx.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
+obj-$(CONFIG_NET_DSA_TAG_NETC) += tag_netc.o
 obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT_8021Q) += tag_ocelot_8021q.o
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
new file mode 100644
index 000000000000..07684e0ff064
--- /dev/null
+++ b/net/dsa/tag_netc.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/dsa/tag_netc.h>
+
+#include "tag.h"
+
+#define NETC_NAME			"nxp_netc"
+
+/* Forward NXP switch tag */
+#define NETC_TAG_FORWARD		0
+
+/* To_Port NXP switch tag */
+#define NETC_TAG_TO_PORT		1
+/* SubType0: No request to perform timestamping */
+#define NETC_TAG_TP_SUBTYPE0		0
+
+/* To_Host NXP switch tag */
+#define NETC_TAG_TO_HOST		2
+/* SubType0: frames redirected or copied to CPU port */
+#define NETC_TAG_TH_SUBTYPE0		0
+/* SubType1: frames redirected or copied to CPU port with timestamp */
+#define NETC_TAG_TH_SUBTYPE1		1
+/* SubType2: Transmit timestamp response (two-step timestamping) */
+#define NETC_TAG_TH_SUBTYPE2		2
+
+/* NETC switch tag lengths */
+#define NETC_TAG_FORWARD_LEN		6
+#define NETC_TAG_TP_SUBTYPE0_LEN	6
+#define NETC_TAG_TH_SUBTYPE0_LEN	6
+#define NETC_TAG_TH_SUBTYPE1_LEN	14
+#define NETC_TAG_TH_SUBTYPE2_LEN	14
+#define NETC_TAG_CMN_LEN		5
+
+#define NETC_TAG_SUBTYPE		GENMASK(3, 0)
+#define NETC_TAG_TYPE			GENMASK(7, 4)
+#define NETC_TAG_QV			BIT(0)
+#define NETC_TAG_IPV			GENMASK(4, 2)
+#define NETC_TAG_SWITCH			GENMASK(2, 0)
+#define NETC_TAG_PORT			GENMASK(7, 3)
+
+struct netc_tag_cmn {
+	__be16 tpid;
+	u8 type;
+	u8 qos;
+	u8 switch_port;
+} __packed;
+
+static void netc_fill_common_tag(struct netc_tag_cmn *tag, u8 type,
+				 u8 subtype, u8 sw_id, u8 port, u8 ipv)
+{
+	tag->tpid = htons(ETH_P_NXP_NETC);
+	tag->type = FIELD_PREP(NETC_TAG_TYPE, type) |
+		    FIELD_PREP(NETC_TAG_SUBTYPE, subtype);
+	tag->qos = NETC_TAG_QV | FIELD_PREP(NETC_TAG_IPV, ipv);
+	tag->switch_port = FIELD_PREP(NETC_TAG_SWITCH, sw_id) |
+			   FIELD_PREP(NETC_TAG_PORT, port);
+}
+
+static void *netc_fill_common_tp_tag(struct sk_buff *skb,
+				     struct net_device *ndev,
+				     u8 subtype, int tag_len)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+	u16 queue = skb_get_queue_mapping(skb);
+	s8 ipv = netdev_txq_to_tc(ndev, queue);
+	void *tag;
+
+	if (unlikely(ipv < 0))
+		ipv = 0;
+
+	skb_push(skb, tag_len);
+	dsa_alloc_etype_header(skb, tag_len);
+
+	tag = dsa_etype_header_pos_tx(skb);
+	memset(tag + NETC_TAG_CMN_LEN, 0, tag_len - NETC_TAG_CMN_LEN);
+	/* As 'dsa,member' is a required property for NETC switch, the member
+	 * is used to specify the switch ID (thus the hardware switch ID and
+	 * the software switch ID are consistent), its range is 1 ~ 7. The
+	 * NETC switch driver will check this value, and if it is invalid,
+	 * the switch driver will fail the probe.
+	 * In addition, according to the nxp,netc-switch.yaml doc, the port
+	 * index will not be greater than 0xf.
+	 */
+	netc_fill_common_tag(tag, NETC_TAG_TO_PORT, subtype,
+			     dp->ds->index, dp->index, ipv);
+
+	return tag;
+}
+
+static void netc_fill_tp_tag_subtype0(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	netc_fill_common_tp_tag(skb, ndev, NETC_TAG_TP_SUBTYPE0,
+				NETC_TAG_TP_SUBTYPE0_LEN);
+}
+
+/* Currently only support To_Port tag, subtype 0 */
+static struct sk_buff *netc_xmit(struct sk_buff *skb,
+				 struct net_device *ndev)
+{
+	netc_fill_tp_tag_subtype0(skb, ndev);
+
+	return skb;
+}
+
+static int netc_get_rx_tag_len(int type, int subtype)
+{
+	/* Only NETC_TAG_TO_HOST and NETC_TAG_FORWARD are expected in RX,
+	 * NETC_TAG_TO_PORT is a TX switch tag that does not exist in RX.
+	 */
+	if (type == NETC_TAG_TO_HOST) {
+		if (subtype == NETC_TAG_TH_SUBTYPE1)
+			return NETC_TAG_TH_SUBTYPE1_LEN;
+		else if (subtype == NETC_TAG_TH_SUBTYPE2)
+			return NETC_TAG_TH_SUBTYPE2_LEN;
+		else
+			return NETC_TAG_TH_SUBTYPE0_LEN;
+	}
+
+	return NETC_TAG_FORWARD_LEN;
+}
+
+static struct sk_buff *netc_rcv(struct sk_buff *skb,
+				struct net_device *ndev)
+{
+	struct netc_tag_cmn *tag_cmn;
+	int tag_len, sw_id, port;
+	int type, subtype;
+
+	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN)))
+		return NULL;
+
+	tag_cmn = dsa_etype_header_pos_rx(skb);
+	if (ntohs(tag_cmn->tpid) != ETH_P_NXP_NETC) {
+		dev_warn_ratelimited(&ndev->dev, "Unknown TPID 0x%04x\n",
+				     ntohs(tag_cmn->tpid));
+
+		return NULL;
+	}
+
+	if (tag_cmn->qos & NETC_TAG_QV)
+		skb->priority = FIELD_GET(NETC_TAG_IPV, tag_cmn->qos);
+
+	sw_id = FIELD_GET(NETC_TAG_SWITCH, tag_cmn->switch_port);
+	/* ENETC VEPA switch ID (0) is not supported yet */
+	if (!sw_id) {
+		dev_warn_ratelimited(&ndev->dev,
+				     "VEPA switch ID is not supported yet\n");
+
+		return NULL;
+	}
+
+	port = FIELD_GET(NETC_TAG_PORT, tag_cmn->switch_port);
+	skb->dev = dsa_conduit_find_user(ndev, sw_id, port);
+	if (!skb->dev)
+		return NULL;
+
+	type = FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
+	subtype = FIELD_GET(NETC_TAG_SUBTYPE, tag_cmn->type);
+	if (type == NETC_TAG_FORWARD) {
+		dsa_default_offload_fwd_mark(skb);
+	} else if (type == NETC_TAG_TO_HOST) {
+		/* Currently only subtype0 supported */
+		if (subtype != NETC_TAG_TH_SUBTYPE0)
+			return NULL;
+	} else {
+		dev_warn_ratelimited(&ndev->dev,
+				     "Unknown tag type %d\n", type);
+		return NULL;
+	}
+
+	/* Remove Switch tag from the frame */
+	tag_len = netc_get_rx_tag_len(type, subtype);
+	skb_pull_rcsum(skb, tag_len);
+	dsa_strip_etype_header(skb, tag_len);
+
+	return skb;
+}
+
+static void netc_flow_dissect(const struct sk_buff *skb, __be16 *proto,
+			      int *offset)
+{
+	struct netc_tag_cmn *tag_cmn = (struct netc_tag_cmn *)(skb->data - 2);
+	int subtype = FIELD_GET(NETC_TAG_SUBTYPE, tag_cmn->type);
+	int type = FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
+	int tag_len = netc_get_rx_tag_len(type, subtype);
+
+	/* The RX minimum frame length of the NETC switch port is 64 bytes,
+	 * and the frame is received by the ENETC driver. From the hardware
+	 * perspective, the receive buffer of RX BD is at least 128 bytes,
+	 * so the switch tag header is guaranteed to be in the linear region
+	 * of the skb.
+	 */
+	*offset = tag_len;
+	*proto = ((__be16 *)skb->data)[(tag_len / 2) - 1];
+}
+
+static const struct dsa_device_ops netc_netdev_ops = {
+	.name			= NETC_NAME,
+	.proto			= DSA_TAG_PROTO_NETC,
+	.xmit			= netc_xmit,
+	.rcv			= netc_rcv,
+	.needed_headroom	= NETC_TAG_MAX_LEN,
+	.flow_dissect		= netc_flow_dissect,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for NXP NETC switch family");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_NETC, NETC_NAME);
+module_dsa_tag_driver(netc_netdev_ops);
-- 
2.34.1


