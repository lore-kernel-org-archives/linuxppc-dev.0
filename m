Return-Path: <linuxppc-dev+bounces-26762-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1DDC79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 08:17:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfGy254Nnz2yrd;
	Tue, 08 Sep 2026 18:17:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788855434;
	cv=pass; b=VSEREUIx/eZM1HIvJ/fq9zDEAGJYqWx7KxasZ/eLFUUOb1cssGoyICNouOuMFl2JWE7QRXGi+kFTWaNy2UYTRm9mrBNNpw0WZgnl0v2ZzUlXl9dPNCSv1VWNwU5J1jbyzuieZ9ryQkghbwOpUpvlW7rYkRPeDw4xX8qZZpjhfT2BzV1bs5bz3l96gg4izTO5dF4PTMjbLT3XpqCMXti4gZbcYIJoPHzO/4YAeOCPkWbcBrGhJUDfR76QB405RGmqebZsO23Os7SkecOwo4BJF85XAQbiANyGlIzgTgCK5h2jbbmXNGltvxtPwMvWJcuuhTTkOofb3oBzaApqEnNRMA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788855434; c=relaxed/relaxed;
	bh=Xqoslq9+UXKbgYbbpzruPuNUbkPeE6MWTCD6fTdZ6rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XP4zfoPTh3kp+914g7Sj38RPSUSoam+m2n+P555HYf+RfdZz8wYexmEGMs8lU6N2a+9F5p3Ttcex1VcdnYYmqVsoC4hRSnBRSFCU2QMp7J7BHKqaHHNGgiONxg4wwgFCA8pnvLVuJOsVn/vdum/Pg5e/gfUS867Mu90mzm/VDQJ4gem2AyfY+RWZA+ERdD6JYQG3QJ6vBApvVqSVJkyTC24ioNAcPOf3cH3XPZyJEn0el58007SrEKYzHpBj60+E6OrBC+JmrqihubdPo45O8RJFGr6NOa5e9z4uLRnlkw8DlrUwxwn8jcy4LQe5Zrg+aIUgASzydlSkUcB+YsQYdg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eitVNIdf; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eitVNIdf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfGy209gcz2yr9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 18:17:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Boozm0T8TscVTvI5TuiQ2XGxqHxvjdz0ouro0UKAa1oxIXgyv5u6GeENp+iu6/cUoSbxsw+IDYOrHonQlitiDJjVVvvIUZgoPIJxmVEZpbRw25QvFFUFLxWfIgZKMuPhgndRzTW4AyLDwMARTJXXDkZ0TQPcv+lCbvaSkOJbhS4fifm0qm+6/TqDNk/ezY3NIUfYHGfCJP9fWYe90WA9oVH3yRKg+XBEc8TA9xkmqwJvQSfhO2YxMzs/LsePAaSpS/+HC+jJdv1mMeKZ0SUGiawxH3eUFYzPpIcZIViRXC5MfKErb8s76TGXqbW3u5dLwmb+rzFEcFYUnQgj3PhaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqoslq9+UXKbgYbbpzruPuNUbkPeE6MWTCD6fTdZ6rk=;
 b=SyEL7gmUvgfN+Rvnzld/S3jKL7YMctJDkKH3W/XsqNmwm2xa1O+v81/5XBnVw2hdobQMgRvFMTzm6R1pP0eMv82WOtjEk13yn8zaQ/Q+NRHiT7BXrzneML4FSHvdom+aTQvTD5WUga2h2BEQsgdgmoxdDwR6iuDdd/ZYIvGXJKms8seMMD2rSnGaa6UDKjt1LBAz3V/raw3wpQj6hfi8CRzNWZJ3O2/hlpsoDMjJjxgvT8YhmqlWwPUzjYtNJsQYFpCsXa+puRiihUztK/Vst80SZzXSHJp8FwEHkzkzPwvbiBuTkuYgdaXDcMKe2pAVI9mDWPWKd55QWMZbFmX4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqoslq9+UXKbgYbbpzruPuNUbkPeE6MWTCD6fTdZ6rk=;
 b=eitVNIdf6buz7PJRYZHsGxc4Gv3PSDSIFEmqQvvL7ImXGWra5Cd8chT7iTaoSKMMcl9YaQq/whQ4d6mhcNcT6qlVAwByVrc3Q75H9BKFI6sfWC2tOcyVOaWJC1Iy/PoAdv/cvsw2MPcvx3KncNbGUXH+55nwxUhkL6jJZVQQTO0GHJLvFc8Gr4iKXp2PNH+kNQR6vzoHzNoLBhqyhAgbhNjlocYOuiRugiriXGdpU6WE5yUDg/ylUxuucEsMAKP29CN7a4eaYPA9o7/0KMxgbCZlPV58Xw39u9ikxi7MiVFS9Su8ifwgU50Es84TvQIFri4EPhlIMAxmgLCsRT0DPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by VI0PR04MB754002.eurprd04.prod.outlook.com (2603:10a6:800:364::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 08:17:01 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 08:17:01 +0000
From: shengjiu.wang@oss.nxp.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shawnguo@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 2/5] ASoC: dt-bindings: fsl,easrc: add ports binding for multiple conversion paths
Date: Tue,  8 Sep 2026 16:21:37 +0800
Message-Id: <20260908082140.1316872-3-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908082140.1316872-1-shengjiu.wang@oss.nxp.com>
References: <20260908082140.1316872-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::18) To PAXPR04MB9351.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::17)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|VI0PR04MB754002:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e46f858-0e4d-43fb-ecb1-08df0d818ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|366016|1800799024|376014|10067099003|3023799007|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	OS9HqZGtKzlC4QPam3bnQ4Tm0q2J0orqhLy4CWdjEyV5i59IpALisVhM6dk+mowv1M989UH9/JhbQSkNb0xoU6IZKJY7p+j4OJ9u8mGgg36LIjZdGfn7eyOmjC9OqoN1y40L4HUrZjG8dSwfGGxoJ/rKG3GWA5HimBXK0qgfJtsTiAXTjLa1sKDK6UKwJMyQZetdiqOdLl/8dcBKzBaKw4V9xASp+fwXUMTPbw1E9MdCln1tOkJiOtvg8wRXsSI0l4IL0yCXMFc+9am9ZkcgoEq7t1UoErmYM1TlNSt1Thas+mxXa5H6KZpc+NcapuwZac0uXtrDeobi++q/JT3EXI8DX5Myiimp2pNqCv6kELRlx0Fw9G2J1JIpgcvP2r2Qc9Wa0bukciF5mlll6Q4xBKM2j2zHEi9MBwNmDzlZPxlmR7/LTXi5MzEj9p0kkOKyTFKxjuiP9bpfBxGXF2pq4bZ5I6JfVyO+aVXW3zOaLnOM0vhl/d5GDWFRhcLWvKF7HXpCchsQaNjHQAMg5x31wfBWOaF89a/cd9ieK2TeJqJJXVgCjJYTziE0OPZcHZvLvj8FpQVnQEkHB4E1oDVg+wpcmY60TyKWUf6nUSkXZAGRyiqx2b+3GAGC1vpUV/WV9x+1m1XgB4pMxOml2yAoDwaWatufz9pJHDqAIkBJAY7OvJzy/nsrwfuSnJVhNKoyOMl9at7xqFv3mimKll05gQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2wbtlA6ZICoVtFFvbs2C89ruesv2g9DIHI58Ip7JxEatWzgy55SpDE8WJcII?=
 =?us-ascii?Q?GpNM+2iZYo8Qh05YzV6wLdVej+7ASnM0hdHaTKpo9bL1/pCX6fc1n3LtBqAW?=
 =?us-ascii?Q?MwZ5jeKeEVMVJ2h17Lhm4rzk4PaG14YR2Je2Azv7qHwyJbPM3gZEK3NroUlF?=
 =?us-ascii?Q?sOjwLIHDOMMQOiMFSLVwuiwcfBrbVFuCP6BXGg0TzhXf6VUMVJq8MRI4XwJ3?=
 =?us-ascii?Q?VgpOaLeyFoPsy6FBmfjsFv3VS5juLwicu5LzxUdpDg3Bo2TMyxiAmGExe10x?=
 =?us-ascii?Q?TQEIjf4FbNxC0EqjQqX6yTBbBXf623HDkHxda9k9Nec1vV01UN5jTKGgG+6n?=
 =?us-ascii?Q?TrtKv3p0hIOJzYzvEG8IzddERYQH3Sod3tXFZoh75TbTDrzYFxCAfXjEkjWE?=
 =?us-ascii?Q?Kg7UJNJRoFqwQq9hDXv4LRFdBAUnnh9v6J4cpOOt7ZK3fPJw3TSSkUFdQ/aa?=
 =?us-ascii?Q?188ED8dWlTHJeJdIrUrAQmx407pB22ulv0Vg8uC1Tl5bc+OL+DRzNS6KwuUw?=
 =?us-ascii?Q?K1DRy/KTUkb93mBNMMkhp1Sg5RaOR37Bru0pbNeM2OwzSl2BFig7w3IleH99?=
 =?us-ascii?Q?kuJ+q0O4ZmdzOKaVQLZfc1jgGF/sQ9gK5HQ0GOAMDPl3iWfDof9rUQOCFonx?=
 =?us-ascii?Q?V8OLAPZoDkmdvnaoWO9JtiRk2+R/1/E3XBE4QPOUIP5bXfRw59vLnp8vqJl8?=
 =?us-ascii?Q?53aODaH+R/PJpmFN1VFJ3uivp/6ufj1gnsO1d8tc9xDgIqP83L6beLNZ/N3M?=
 =?us-ascii?Q?Jmk3/tpSx71YdCyvMK1coOv48SA0lSRoT9PfXb5YMdlxNGX87TYSqmt0o4qn?=
 =?us-ascii?Q?YaYZhiZNM6nVJ3gusEPpkEM4BZeDjdTafcZgMJUdiHSq3kyOEGRZocgD74qY?=
 =?us-ascii?Q?VYiPrThT6eb0TA3nv73lBryGvY5SDtnDg+C21z8QD7nOsMF4SgmdE1AjEkiT?=
 =?us-ascii?Q?FwnoOLJRWpCXnNX+ODk+um+5d7cjt2/4n5znTToo5QDLMuJ0YQg45XnrcHD0?=
 =?us-ascii?Q?2v9gcGIqYNAxXAuugOFHnDUFmoqTTZWSFJrXrbO9B8xNszu00/Kgb/V34XeB?=
 =?us-ascii?Q?ESldhnb8Mz1zYAWjNdXijyXuZJH44ntYVGG/YLZirbtHb7+TlMuL6LB9fyqs?=
 =?us-ascii?Q?3Kyg9X8pbzTmOTxax/QwBWGOurgviBXKXg7wDEyx0NMABj4FuhQrffFKFz6x?=
 =?us-ascii?Q?V6K5ATIJFNd+hbN2HTOEbqZp0pS4Q2B6TNi9ulzFjL7AoNFHUMLKVueUlTRA?=
 =?us-ascii?Q?HnVN7FjM7Zl6Y5kV8+FDjHWB2otbS5wIhnd0aEv2/bm+3qbcCbBSRGLsOYP2?=
 =?us-ascii?Q?lkbwJEKcQG3cceT8kZUwaL0cIqQ//ZT76oUeM9I1h1tGBBytuUhE5Q6Lx3sZ?=
 =?us-ascii?Q?boeXvi7FKbFqIL/gmyqYM7jHEO+8+/nZX/NUrq1rhu7BY3rA1O1oth8zgT/A?=
 =?us-ascii?Q?FFwHOb3esEkQWQmcuGYDDwquXUvHGUpA9sEa2nrctB4KKL82KaCUMbSgMppK?=
 =?us-ascii?Q?n/uX5lOBXaefX1QVMsPnDYwNIvcJ3HaaYAoNgo0ZiBgoSM2P0jqfRux99q9N?=
 =?us-ascii?Q?gy8J6R/PeO/W3A4l0mrSjZNJ4QpDutVaQUV36cOgbH84Ihanizv3jx9CcyqE?=
 =?us-ascii?Q?zL8smR/gblGNVdvy5LhKPZiUqbgMD6MgO3Hk4DdYrikKE1hGbL8jT6EnXXSB?=
 =?us-ascii?Q?Y2wkIGlLUUXu9AIqHH1CHRZUhW00IQrTipdPD1rmBg0NKsgBGc2E0vXa4kMu?=
 =?us-ascii?Q?BKspRBTwiqVkk/I5HA3RNzVnAjrQNbFQiBQqoAyIt+LHJECQZEaB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e46f858-0e4d-43fb-ecb1-08df0d818ed4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:17:01.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caTzWMMe8YEU8yi+skX2r6SETS4A12IjCkcVHyq9glBZ2RB2UCPxP7ZVtunODa7WHLZItNEFaSdgXihXNuEDqsdMT7gRgansSl98KqSqBf2IOCnnG5PenX2yxluWCIeo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB754002

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX EASRC hardware supports up to four conversion contexts
(A, B, C, D). Add a ports container property to the binding to allow
each independent conversion path to be represented as an individual
audio-graph port:

  port@0 -- conversion path 0
  port@1 -- conversion path 1
  port@2 -- conversion path 2
  port@3 -- conversion path 3

Each sub-port references audio-graph-port.yaml and follows the standard
audio-graph binding conventions. Contexts are allocated dynamically at
stream open time; each active stream direction (playback or capture) on
a port consumes one hardware context.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/sound/fsl,easrc.yaml  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
index d5727f8bfb0b..a53ec4f6f1c0 100644
--- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
@@ -55,6 +55,14 @@ properties:
       - const: imx/easrc/easrc-imx8mn.bin
     description: The coefficient table for the filters
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    patternProperties:
+      "^port@[0-3]$":
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: port for an independent conversion path
+
   fsl,asrc-rate:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 8000
@@ -106,4 +114,41 @@ examples:
         firmware-name = "imx/easrc/easrc-imx8mn.bin";
         fsl,asrc-rate = <8000>;
         fsl,asrc-format = <2>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                playback-only;
+                endpoint {
+                    remote-endpoint = <&fe00_ep>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                playback-only;
+                endpoint {
+                    remote-endpoint = <&fe01_ep>;
+                };
+            };
+
+            port@2 {
+                reg = <2>;
+                capture-only;
+                endpoint {
+                    remote-endpoint = <&fe02_ep>;
+                };
+            };
+
+            port@3 {
+                reg = <3>;
+                capture-only;
+                endpoint {
+                    remote-endpoint = <&fe03_ep>;
+                };
+            };
+        };
     };
-- 
2.34.1


