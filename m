Return-Path: <linuxppc-dev+bounces-25349-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD6AC55ABA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 09:56:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDppc4yNgz3bh4;
	Tue, 04 Aug 2026 19:56:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785837384;
	cv=pass; b=ZJyfMFAmPGUnf7a4vTnlKd8gDTIsrtkrF925Z8PBqyYYd2rE1InWCq6WbxXwiEPRR/rgq4aUXOdEvdRw78QUCQ39KAPhWgHVZRwPq7OaK1BRbEtYORspOiq9qFbNAmHSg30++X5nS9b8+8BXlVWXBtYqDh1tykP7TRYHeTaIKmifH2HOt98sX5Xew92Uev9SRPcRv+eTU9WfhrSvVtbHZdEHy58ALk2r1mtB/KpnFvPx8OGs4/f5EY+bHg3F8SoPXwatJZdU0zKFYX6QqDI4j5z/lhZM3Dk/UfGKqUST5D20NSRhRCARWmAsst0tPxE9TqynRCaYoLRGia+jDLoNsA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785837384; c=relaxed/relaxed;
	bh=UJ+1y+O1OaQZvn9BidPuYMuNHIRzzB5IvlTz0VI2loY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lJi6J9Q3gtSbobvrCQa5bKkmPCkgs8fSpF4cNmJ2qnjfi3F5UtzYdkLfpfpnSZfa/6SyBqh8NOpftJMZ9SgAAMaRVUiTBH9R9uTabcKAlPd1iJq5fi/TzoJ/l3Dwxj8zSmn9H0z/ZDHzwf7cPqLUneuJTf5GH4QbCikhUVolQYd66tAeSHgW6vbaWfyE7Rx29q/FTkKpliPDmbTnfi0p5W+a6oGQg5H0HVImPY4dY+vDNVX7IVCk2CYqztnzCQxfUyUtDz+7kAjKHLvoG8atHo/h6LW9c2aAROovA/zSSeq8rDjXZgfRQr0r6wkuS50yBUZACNoRV+DNNoI3lsVGlw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CTHa1kq/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CTHa1kq/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDppb4qC3z3bgK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 19:56:23 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzAnxPvZDKZZVeon6ETwdsi+HyYa5dwUnoqYXuSpC+E0obePcHHQy92G/feK4C7Tdu7Xng8L946TXAlowd3U9OM3jcsVvUxgOCtOLbNC1Zu5PxXF+QbFndF0z559gbyVDoBIXV4NOYf+LzeOfsDp/Y2qzdcvYg+4IaXEb5BLfoMsEEomW7NQU40cTFNcyNSW9arInrQ3HlQB1qxNQTTiihhREe85f/1yp2I1rly/gL5qZgWOKPhzqHJ8zxXqdwkQtu1FWnWAWhdBrWP+SK5u+AhOBWlqv1eFp2qnTcAvmdL35o6gzdN0fGA8IzmVCv/XtogmTw4bFhTqAgJxd5FnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJ+1y+O1OaQZvn9BidPuYMuNHIRzzB5IvlTz0VI2loY=;
 b=nbBP7PoQAGTTtyl/q9r7RgW7i2LAWoJSGTn7cgwOFCsOAnJi0vjQ6MI6ESTXlZHDmUzeyLrZBps5htYUBHoaHYRP0p34kSscQmB0LiYGOs67t23NrVvrSsjWuwrfqB6oXJoJj+Ek3tcHY3cRCw1a2I4fjwP2uhJsL3cE1RCC5Lx3RZBVif8itLxkYCgMbihhYDC6Bh6oR96zJ+zPB3l/yVlI8s+8rW2FlDwYPWE7liWoqOZaw4Skmym8sOI+KThqej0/9JOdcoT/j02Xrrgs4Ci+qCkX5uzRrCgLk/Cx6NYiDH9j5JNPHE/EwAlJUavse5hh8kougDQ6zgIgEdHtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJ+1y+O1OaQZvn9BidPuYMuNHIRzzB5IvlTz0VI2loY=;
 b=CTHa1kq/Fl83uN4HNnkEKG19+d3PZIzKe+fn7vNsfxfUK3DPWN6DeoYkIUXIRxEnOtEOkceId7a4BUycDU47SIzWPV5IJVMAYktcBpezEXy9fpLBq9HMR/arLmIT11hJDuBQWd/qLEXZk3jO8e+ruoIj/80Wma0K1+Dt9CXS6IyBcd3rRpWtse6tncHQVcJGS+F6hojKv78BciZEnZ4WrJZsdHg3QGqmeN21YBb/WYgp02kcGltsK2ET/kDNjFfbwwD1p4P/Fy31dUZA6+K6PR5aMLoHvCJ/s08bbm4mC7/GBzDgWiSrK0WmQEQ0kP+OOGTI4iw2n7OLRw43XPM52Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by VI0PR04MB10592.eurprd04.prod.outlook.com (2603:10a6:800:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 09:55:59 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 09:55:59 +0000
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
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH v3 2/5] ASoC: dt-bindings: fsl,easrc: add ports binding for multiple conversion paths
Date: Tue,  4 Aug 2026 18:02:15 +0800
Message-Id: <20260804100218.49587-3-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::18) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|VI0PR04MB10592:EE_
X-MS-Office365-Filtering-Correlation-Id: 51702151-490e-45b2-7426-08def20e957d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|10067099003|921020|56012099006|22082099003|18002099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	lyEqcvMHtWyJVW2cQgu9iMmRXFsl9vj9IJDL9fvGmKObuulxCZBFIBsnntjhS0auJSm43skG9jlEIF7J5mp6opvflh7fetNoWNrThxMmHmVa+vNyKUQIjFiHp/9VljDrE+V88rXzsE6F/v8L1lagORJ0uacyVI2lk0H6UNkoK2adJ8itGBmd6/nFPB2XttGZ+WoqjHpxGdHHbNFeKPxnicGNM0GuX0UwdppcKez3oOrOeAlPy4XoH3jT+xwDHsQmIS802/iEFA13JtFfjBlymoWGQxNlYjpqEr1U9l9iDzXfNSr7PURVwvEByKMhYADy+29t6BR64bsbyWfI/cE6taOeeCt7PD1QSrrZUFb42HfF3HSPLXtxQq2QYWZEP++gHu09+zYRz8/ZXvxNZvtBTDkeH39bAyZxc+VZf1rwUs3sjr5MDaQPYEwsiG0FjleEE5v4Yd/dTF6vmCbAt7a4dkyv7z04hr8cU7tDCGXop/CuqfhyC8JAcmomMKpZdUC7ADsETDqxq8xj3uWxa+K5QB2LtjZUfEAcOlnlEzwhTDwaZridGq3XRZrpncHEP5lnAU2b2U1J3u+jn7fD8pCOrdFj9RtJttMtpXMFRV8eJBM2ovQUAb4lziObFtjhTHjaFPBOhZFz70o9b/1rGlQYkdGJ0dqDxUXtyTBnsUb8P+sxDiVjS5KRXiVrniUU7glGDmHPv+UeK3lPns92+QAjQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(921020)(56012099006)(22082099003)(18002099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bSgq7/qXkOOJO3b9JZm6w0faiK18mN2zGPi2de/I0zTHUF3bLUzgLWM+96c6?=
 =?us-ascii?Q?1mW/hKjRDdz5oNLh2vrmTZItDDvKkM60+9tQnT9nSUSFNlh6kyfJbJB8MDBn?=
 =?us-ascii?Q?feJ/z1s1UdwznqLPTYvODl0uIbC26qpeqPu7glLNxyy/O6r83FGs+ab6/Myq?=
 =?us-ascii?Q?kTFWcpG5NQAKpmpgKlX06IXGyyhIzJTGd8VtfB9QMi8dIAgtIrXIvFtW+Df+?=
 =?us-ascii?Q?sGIlIY7Tun9numlhwk6Q/8HYU5uCghjL1XtvaFJFhNjqAw0T8+zkHHKk4IUY?=
 =?us-ascii?Q?Ju7dQk9ZPwEts9D/BC3Io7q6DnjxmAndI0iU5e8P4c5miWADSrQBjrTZW+5j?=
 =?us-ascii?Q?XL0QmGu8v8HvSYqzW+hui6jly+QrAZqI/tt+nWL8df3+O3X8NsiE3D2q5CDP?=
 =?us-ascii?Q?ymX4vYI7SUORImBn2tDR6xea8kUHb1xgOFEi3hHkDdmTxvw9zUGUeKcSp3MX?=
 =?us-ascii?Q?KwIrx5Q4IiosW4Lg/FJYwy8NrzHqhht4Z4vtnjGG3aV7X0im57q0cTTiR3RS?=
 =?us-ascii?Q?ZkAYDjzEN9hYrsHZRJTwAjoe1+yRjqK/BBXJBIh4utYYqWplXYXN4JMmGUFT?=
 =?us-ascii?Q?OdPd/4LYAXtGw617rNoY98XvQUDOTL7NU9Ixwt/txO+tEP7PdyW/PPqAGItN?=
 =?us-ascii?Q?w3o15ntWj7uEDdOB5Cx9hiDqC8rvgTDr8bMspAK6joCcXGOKcmLxmpQWoLwj?=
 =?us-ascii?Q?LvKXlSWFqSLYYoaJ2OIoeLqjEyuLTIS+TDe1diAmLewr+gX//1aXnChFauk1?=
 =?us-ascii?Q?UCDiidqrRw393M2EE1+4VaRv9oxJ4x/qBIeZzT+4bKI3V4ouKrKDHjsR8n4O?=
 =?us-ascii?Q?DY19Un2jMQcIItL1nwka4T92YZbpEH7VvP1vf3CWwuuMf4V8oAtS3D3M6fqX?=
 =?us-ascii?Q?Ax5cMGXsxkZnrpSRDB8y6s4CFeh3uriFiXUiee77JktLoZY6rKU8NmzAWI31?=
 =?us-ascii?Q?0scOYLvDJhkFCDqu56GdTJYRjZmRsUFPac+FO6lhqEDlxu0cS06iBrv8lH9X?=
 =?us-ascii?Q?NWTIbXBQ2BuAFFYMe5thF8Xqs54dnEkcl+btlv4TJKBIchdXYN6kl09YXHcq?=
 =?us-ascii?Q?a+IWLfvs6dQxagSucIJ/uQXD0SDO8cAcQC6MCclnkH+1gIYS4oQlYlahpjBG?=
 =?us-ascii?Q?jp7s7xo2vUunHI9UnGKA5DkGmS73QhhFRN6sNMQKdauzuSf+FZcksXhq94/k?=
 =?us-ascii?Q?4bnPMHHaDuSN3ZBt0/hxdcztcC6Pt0gApMCzzsUE1xyMETX6w32mDM7yK1Xu?=
 =?us-ascii?Q?GUMjDcU2GD9aFynIfYbVci2xWef3k3Y8qZHtVVv5SN+F7qGGRXx8YClGtj8Q?=
 =?us-ascii?Q?gA5UUl/7SxojlkxKRmSCMwRfNHhVd444opMauFeys1DfozpZLJtwrPeNZnzN?=
 =?us-ascii?Q?KogxtwXaSCpJRgOnWAKoJKLF3IVT6VG0mDk0HPDkdd6X8y8Ym54Eg9OwLFk3?=
 =?us-ascii?Q?CsQDXy+FYO3L+cXvPFXeDq8yF/POKdCQyIIm3TkTvSecbMOme/5QWr314xC1?=
 =?us-ascii?Q?5xWRo56flbX9CZXQPqBv+91TaVyXNyQ91glXBx+duel2wrPMf+JTkVZn6fAW?=
 =?us-ascii?Q?Sg0TuK9dxAEMNuKGMbtgWGhmUFN5WfSuZv8n4FORsj/GadJongfAsbaKf9SP?=
 =?us-ascii?Q?SL2buCXjguDxcZw+fXLIsNGZt4kQVUElgQYUI5uPdhdshddDnUPMS1FC8Zwk?=
 =?us-ascii?Q?86PpQNiHL0kVhonMJfuhPb+88cynIapFTwoZLA+Hkl6XuMHWLlhjcx0ZEPne?=
 =?us-ascii?Q?duzFaT3TM9HwqmL1nuoLICUfeUniI/ybFFJNA0+OZ4cWQyvVqVPY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51702151-490e-45b2-7426-08def20e957d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:55:59.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zenqXsRdCk6rIPBCRplRXjeUzgGwz1bqEn70MM5BGt5yzTT70buO05C89mBIMF/kSf1/d/Av3Io2aoEKJTALVqs6jdjRpmReyBR4DxWd5Ee3clpaqMGTVuo4TYcTSEM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10592

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


