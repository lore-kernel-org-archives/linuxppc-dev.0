Return-Path: <linuxppc-dev+bounces-20634-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7188CD3447
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:28:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMdV0dSnz2y8p;
	Sat, 09 May 2026 20:28:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322494;
	cv=pass; b=PpQOCzY8cfU8Aaw4bDOSSDuHq2qdpFvhrGPIKAupMwLTHyakc7f8qrJJ4EhdxniT0ZGPpdqb/3K/vhWxbQMCkpRlBoEdXyymVI7Taw5u2eomRVjBqj+XMjVtvfysfnhuCmIrbJBI5noZNMrDSWgO2N219O/D2eYeDQtJyGLxZ6BGVoaDUcod0ngy9faiCprj2DWKSbXFQSwb/0egtwE5b5LYzgcqlzqsS7Y1Y1Z6qZi+nYXv3uWvN5Fm1qSEZMIHNMnpiKOTzXlMdKItQmW3JvdMFYIfitTKeqcgbsDBezOnwJfWjB6iv2v3N3aKxhkvlCdn6zORYdSjR/JuC2rGNw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322494; c=relaxed/relaxed;
	bh=1QIpneJD6m/S/80aesbxQwAdUvv860RySfeuq8k7Lt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jncdNCI1VJztfPAOnJRzRJFKKDOjviy21/Sc0WE2xtxHtZdYdL9AXyzPQ0ttbxZoBrextJcFTwD2KNLOsdmFEl67Bp0zB7Nxry/K1x5eXDXg9dM3NPuOSVmzGjzscg+QWYLOUca/dyLpEE03PK8XXpqM7mgX/4hFDZ9P/jORMIbZHXBUUfweupImJiuTmfIskzRjkJrAlEiM9+1ab6jNXTGn83yfvKXtbn7ADS26EQ735E/4tCrtCxo+2aYgdRo1xvZVMBfIqhMRqBIUdKk2CboFoUVBlgpBsz5jKCCoG86OZcc9er1pkUpOBlkiP9ibKlfbh1XV/KKjZO6RNKbr6g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=jLJHM0R0; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=jLJHM0R0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMdT2Jgyz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:28:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AavcQ8nfH33tZ/5rAfK+dkQsRsfdt2Cb7uMStYhg2jaMPw1bILJ0K2bcunyc3bgRsvExHExwcCsY2vJ9DfvOIzYz7QWlvGqlyC0nhz6l+Kdo3JIT4KvJbCTpDX0CyGa84e3IQY9FpDPEKOaiWYVxPQOjhkU8DnXV5CwcIiKZOzePlIRID6iXo1yh0oxGnQfDXey9nPB+W+4c9r/EtWWViA2+pDnenAOQJRBS5aFW7Bewa2RGHBqbcPeozki7VmmgrIDR9pyXNbyCmDvf/wnokNOq5KOm2bWPaL5rnoyVAD/Yp2ICB+CfgQwuFTEKdRvNJo35M/X8/RThx214JmG91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QIpneJD6m/S/80aesbxQwAdUvv860RySfeuq8k7Lt4=;
 b=DUqAv1FWNpZ0/sF2PrWDXnneLj/Ag0YLY2zAXQ2WnbFErdAZiqV5LYOqYMlndnr6Us2kie9wjYtu+GtkW8ZkojAPAzBHVi9o0fnKBuCnMu9/oUn4xMQ3yK3NIpbW7JWrCFny4LkFe2dpgaRK9w2p+ovSTRTbEZlwb6n+Ay4DEyjgAsOmXoGsBgc4ENogT9vhazLHQLZbnv/t0J41Ui08t6yui5YRh+N2uh7crAnpRzls9B751aWJ4AjoqyIHvrjfELv/TdMuSVWhFh/R24Ry8vQjxFWnoUqaT/0Ca4BI6W/ULnMZ3ho5TCotLNO6uh4n9WiXwHSnmlcdjHKw2HTSYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QIpneJD6m/S/80aesbxQwAdUvv860RySfeuq8k7Lt4=;
 b=jLJHM0R0Y8koKdC/+p5Q0XdaGi9BYQeMLWTPksbXFXCecBXs3ozV2zyUeoSvibKPBsntqcg5AhrBU/e74ak7jpir5KftaHE+uWs1A0W8VBB0AF5araeajjUZfxdmfx7iYo+meYC2d+efHtyf3vFAwN44xGVg9nvgCRv+2AKfvyYA4Rn4yPwdqcJbKHEyNFPQz9zGeMJgqmsOp5Q5W1BczROZJ1emR9GQwG+W0fpv85v6+AW6C/8EBssjp/G4PDNEoik4ZblGHQoPLIAyLaPpTiWDK6IRFbPHPqodoSYCKJvQVPXRikbjajBBMEeXMLyIxn12zsPSRGZUrj+mXlTPXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA1PR04MB10604.eurprd04.prod.outlook.com (2603:10a6:102:48e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sat, 9 May
 2026 10:27:47 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:27:47 +0000
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
Subject: [PATCH v6 net-next 01/15] dt-bindings: net: dsa: update the description of 'dsa,member' property
Date: Sat,  9 May 2026 18:29:40 +0800
Message-Id: <20260509102954.4116624-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509102954.4116624-1-wei.fang@nxp.com>
References: <20260509102954.4116624-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA1PR04MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b14a6e-8418-43ad-fd40-08deadb59d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|7416014|376014|19092799006|18002099003|22082099003|38350700014|921020|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	hhhd7zlMsd3DerYjENSEHx2c3Ek88RYuGwu5hsQW+Z4Nqaimdszv/Y+j56mush7w5N7l41x/OSWgVxskp99h8cuMX460gKk17cXg1GlKmDESUNiIeGB92U61S19SasCMh6pK24Lmd5tM5Ptt1GJcYhQZM/69KBtykcyisJn3C61ogCA2p9Q3YOMWkghtY6d7dnVctxUH6dC53dpAyebICKXzfebglgaaMVIHy7yZ02PgCybZ+17HNoYsoeB92bPP7IaR5OiqtTSmabHg1osirEwGbWfQsnvMctw6UG7xEXSGUZ/jLnnlpeMA3CdruiipXEa5tSsaY+eR64AyG/811XwVhiHM5byh+HQkpml8THknznrxJHCqZjLHMng8rN1D3xhX0VZFYmm0WINAFikJdqiZzdwt6xuGBUsX/h88n2kV5/QkcuAFA47K73oTojignSs+8+Zu+6H4vZxLl46pVsP8za4CCR0BkAQduxBdkXzN2Kk1Y3SULWEfw7B5EpadHNV7JZXZpxfNCZHZIE0gep9WaMdgT1Bxd0gaBGc8/nkqXqaiL6O3H3j2koSBPskryE7b0zgFrXsLEDZpTO0psFxCdBMchUqG/8kBuvnm8n4XJhiycMz7aQ4pVKcdCzYdb2ipkd3PpaKSt5wBfAb0JgADfmv+fIQz58u0yyApDQzxkyD4jZfvZLkDGTf3qgEzAoK77DtuZh86ggFKekENPiTj7FJjMunD+CAvlP0IWDzLT/8UZZAuTYEOtzcMMy5rd1oa3j0pbrEjTsyRXpBBmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(7416014)(376014)(19092799006)(18002099003)(22082099003)(38350700014)(921020)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jsOCUZG8dRaLhm5YUo9oM7Qc5vzoRxkeDMEdJvaPMMp9HwCjmCUmT1YjJluW?=
 =?us-ascii?Q?m0l12KDoL6TmkTVSX8kiinPoQwLYqdPAM74XqrM1NztR9GN+DspTMThAYTZD?=
 =?us-ascii?Q?OqDdKrG1gcWfGpoEDlxZ6Dt1jfSsItIvWlpAYN1X0a4nEHf8XizF4wX7jo1V?=
 =?us-ascii?Q?+t11XsBVZgnY/LUhnZbzq8TwWyYtSnvj3m8kohTml2ouDmd9zBfDnwC9vtfR?=
 =?us-ascii?Q?EJBEmNB60lPJxb/A2rInTXnRiRskmR/KlUJwuhOFKy5xw0w4oHKDoR5Jdbcq?=
 =?us-ascii?Q?3RdCpBKpUIc07Ihwl21WPOxQXjLU1xKpTEaHVvE3XILIgnvukrZ+MujxqgeZ?=
 =?us-ascii?Q?1pA38Hx+dHYlgmVYp1lmrIHB2U0vyI/pTwgB4C3MOTo6Z7B7oACiQXjdoMhB?=
 =?us-ascii?Q?VUYuRC9q0orowVecH21MZYov8Ksrz57mOG2nZh6H3Bsl+qlpYt4CWNjJU7ak?=
 =?us-ascii?Q?5BX5TVSmGITM68h8Mw4mmLlUsIqn7DGqxdDU19SXPycvJe3HAJ8bytO4mYQZ?=
 =?us-ascii?Q?WhwS97dJrQhTYVkR27ljkmVqCfokkYLT0Iz1MmoFkFuS/0NtxjdaDhsJTMcB?=
 =?us-ascii?Q?BWKJzDtZBRyaANz6bCsmmJsYmAgNGgR4O9UgZGeNyi+vXn2dcwqYuzTd1oGk?=
 =?us-ascii?Q?KJuqZVTY4gFplFUDu68RQCpFaai4xOzCcHsSzaNM/6zjQTXI/v2Vxf8AmDzm?=
 =?us-ascii?Q?t/9FLt5McFq4/ZscfraMCgVGNg4N5iZTJQWrHDQq51xAMgxL1ByX9xssImiR?=
 =?us-ascii?Q?7dEleQnx4pE2z1IHLVw8LFL/MNpr44G0bY18c3CdZeAQapc8MShhrQCE9PS7?=
 =?us-ascii?Q?2rQ/bMtBXFaG8fKHZoLmXkMCMdiQRQ/HQBQridrZcuRsb4fGDEkIa7zaN6/t?=
 =?us-ascii?Q?I4lOxosEgSnF0Jivai8JZMiF/wwlUN29jXuqcffW0xMLkaA1gykel5nTnwow?=
 =?us-ascii?Q?sb84Fs/2KSNpGYPnpp040eydEkRcEWb5Vkb0TLkhXgvLAXcVdMQuSRooMPpz?=
 =?us-ascii?Q?0fFhpWnG1urRilTcwclhdssNebSAWp586YCuT5FZnistyW+wZFhPF+2gVP6E?=
 =?us-ascii?Q?mXvC987Ep4VwmvgNIyvPBi/Mx2ZwTKnr7QST1IRun032GJKBRyZfVuIqzghJ?=
 =?us-ascii?Q?NyFGfRAkUgyToqAUvGYnANSyX0wtQ3i332Pv0vB/TLyLrtdSuhLvOjP387bF?=
 =?us-ascii?Q?UeqJhvhDGmkF60RdmXeyokf8paMOSiAaHPNl0GgSr/ia4r4Ypcw+ZTeJoj4i?=
 =?us-ascii?Q?AqMpba4zxphKei93SF5ZON1ryKWrojMd6aRIvnM4VUA1MVAgSn75UbUdzm+S?=
 =?us-ascii?Q?iYT2s+PHARmiM9tih9lsUVwRvoQNwzGG9iUNrRDK7kJJdYTebkA/WNA+3kl8?=
 =?us-ascii?Q?u6lGBh+OQAgcDu9yvYNObIxWn0EPrBy/KiGRbL7F7yDjD+wOgO0YuDTPm1qY?=
 =?us-ascii?Q?RF+27HXXc/BOgLhyiI/syNFDcZ1kmpsqsT7+3Qj7tMnc1d4bEdkdNf93I97N?=
 =?us-ascii?Q?bHuDahiL/IgXqPuRXZFbWGUnWODiQF51bcqTE9oe7kRzpD/UZ0SQ+vs4XCq5?=
 =?us-ascii?Q?teDGyPjHubZkxV0/twh1Ck9Rz+Kp8347wO+a1Yz7QlJN73+P9VGDQMnuzprE?=
 =?us-ascii?Q?XscLhRMnyLAGUGZ6W0t3WFGTVIiJvWdbe6Upnfn6f5aW1ES9R6M6cT9UdBan?=
 =?us-ascii?Q?UmSovtUlGTd+RPKCd67u3e5WHSGvQ11gif/iaFJJr6aiupD5aHtdCtbK10fK?=
 =?us-ascii?Q?fhYwLrYGzQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b14a6e-8418-43ad-fd40-08deadb59d7d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:27:47.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zD46NPwAe3ivAw3tXBAUf0VKxe57CMIajt4bowN9dtXCKc7L21F7B/mpvv3u3cnL2lroCifr/QMf51WftRhTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10604

The current description indicates that the 'dsa,member' property cannot
be set for a switch that is not part of any cluster. Vladimir thinks
that this is a case where the actual technical limitation was poorly
transposed into words when this restriction was first documented, in
commit 8c5ad1d6179d ("net: dsa: Document new binding").

The true technical limitation is that many DSA tagging protocols are
topology-unaware, and always call dsa_conduit_find_user() with a
switch_id of 0. Specifying a custom "dsa,member" property with a
non-zero switch_id would break them.

Therefore, for topology-aware switches, it is fine to specify this
property for them, even if they are not part of any cluster. Our NETC
switch is a good example which is topology-aware, the switch_id is
carried in the switch tag, but the switch_id 0 is reserved for VEPA
switch and cannot be used, so we need to use this property to assign
a non-zero switch_id for it.

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index 2abd036578d1..801e1411e5c2 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -28,7 +28,11 @@ properties:
       A two element list indicates which DSA cluster, and position within the
       cluster a switch takes. <0 0> is cluster 0, switch 0. <0 1> is cluster 0,
       switch 1. <1 0> is cluster 1, switch 0. A switch not part of any cluster
-      (single device hanging off a CPU port) must not specify this property
+      (single device hanging off a CPU port) does not usually need to specify
+      this property, and then it becomes cluster 0, switch 0. For a topology
+      aware switch, its switch index can be specified through this property,
+      even if it is not part of any cluster. Also, topology-unaware switches
+      must always be defined as index 0 of their cluster.
     $ref: /schemas/types.yaml#/definitions/uint32-array
 
 additionalProperties: true
-- 
2.34.1


