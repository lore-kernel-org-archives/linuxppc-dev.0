Return-Path: <linuxppc-dev+bounces-18796-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1E2109E559
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 06:27:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhDNN3hJWz2yhY;
	Thu, 26 Mar 2026 17:27:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774506468;
	cv=pass; b=BoGEkgEU4pcvLIpncsTS9Qpn++188ZVmbr0Y6euybk6LvqOxDw0Y8WdahdaWWEIb1n61meV/8/FnlXrYP4XYBCPYco4rxoVmYQ7sssq/SlM1TuA6TUzC5tGTPQwsWC1hz152zurOdIx8ApnY8l6gwLiqL+dAEUxLFqxFIQkMcRIUydALdfmC+7s9PaRBE6ZyJjR0baRzTBGUKpMFIgRayazes9UjMaLXD5IbxK4efGEwm9ydGGnEqtTOZ0HH8YJJIgwJ0DTytFx3+ibB+em0iRqc2aoSXXxK1T5CIHTK1k5+DUyva/saS1Dlo9b9G8YC78Ju3bA7zw+yp/YExCCn8g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774506468; c=relaxed/relaxed;
	bh=b/XZWFlsxzM+0lZxykfSK1STJKtwotZ7hmQM6Y2ONMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LDraqUoMEufBjwovVAYBk+6EUZlh4/zNOn2/EhGtTYZaIQBTiQPCS65X9duA+9PmYji4TL4bIe7UC/MuepN2F93jONyowGcAqsy1entiNN3RhmKofUcdMD2gyJsBikzrHhi7FhEbmwhuUDcTOz0Do8IdEXlWsj2iuqQJqEbzvMHEDI5+5QchCXXycQ/qKYL5Kh9adU3N+Xiw76EzdKV4WKVvlFCuEwt7H3s1DYhO6Y4CmMp64ny5jRV8LtTfF9SG3DmIl9nj7mxc6khZGmcuOYksPqpDxXCxlTGhDdjYvvkjh9hRmIU5VB2uOSgPBUco3Z7rc7zvMQ4NyAZdcJJfsw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=DZ/tCcKF; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=DZ/tCcKF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhDNM3lq3z2yVB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 17:27:47 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBlgWHIHEiC/4dke0gfOxWTjqqzvqHDO1Ww+C8N5Fth+aOJy1fSIJbXK49YrO7/uYr6YYsi1pnCBFV04xq6mobvsVYAcpKfVMt6QmJkrXGbG7N/CX6Uwygwdl0nI5dpAnkaBhrtoPcSjb6pBcGeEJxqvUCL44jix4VPRwDReSuS5iU7zuOEeE2lzMMIMKK/InjRACJBK8zvLBIfavebLlbP1mjHrhkeVX5I1fahRT6UkKZkpPvrluoGUMQHjlyK47NM2rVIXohxSH2dmvu3usEWyU7bpxdub94pTTP2aEIzMofKs8KSXCaLVhlZMmFCoLL0TIJadMRNTr8DQFNmbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/XZWFlsxzM+0lZxykfSK1STJKtwotZ7hmQM6Y2ONMU=;
 b=pL8A2tDd/ZcbWbpDpTOvr2aJa2MvXWhgAtD2b0Zn9nhuOHk6mtCEjSkwP+Y1APJGofy+NEZMlVQKzGQpa8AUqawFwGWk/6OY6I0azJaB5XJLZKUPUl3buMV1f+09VMM8QQVwWS6Kz+7h179Fx58sCFMlCngV894Xr9nX3ypq1JZxtDzySqNZTJVt0rFYTdnz1SpzWcErdn4CrCGyPNjuXhcbHvJ0DcAG/7aAAUV3w1/+Fd3jGb53EdSogC50zdMDdueitji5baKIQaK6R/YeTKoJbkPfAsuJIYl5t8bE4PDa0cc+ToZsKCyD6bScOlL6U5H2e2HANQEtSL7bWbtqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/XZWFlsxzM+0lZxykfSK1STJKtwotZ7hmQM6Y2ONMU=;
 b=DZ/tCcKFImVPq6aPOsg1EbHPwKzZVQI1MGPaKUIEyoZYjN26CeBzJdd2hbYEREME02Qa9qAUTdD48QYRnO9MBzIeNTsPeIMKVF758hT/aUJK7xMukV/DgNPsBAp9AWAj487GRYGAOHVOJDnlNHnyXELpfAhS5Ukhbnw8B7JMjpF8rHdXL6iQ+/OGayNtoQJtyR2Npx1ZgsCdLSiDLAK1e/3FQZqypwgtAckvXqyR5aeVbp662sNmzSSan/3w/jVGa4hvgK712GPImTqxtHpyfrLipWig3zAL0yPLYnXZrPLR2peeUKBMt2Vh/s7iMFg+YT6VG2xyS6YbYG3v95mgSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10309.eurprd04.prod.outlook.com (2603:10a6:102:41f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Thu, 26 Mar
 2026 06:27:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:27:28 +0000
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
	andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 01/14] dt-bindings: net: dsa: update the description of 'dsa,member' property
Date: Thu, 26 Mar 2026 14:29:04 +0800
Message-Id: <20260326062917.3552334-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326062917.3552334-1-wei.fang@nxp.com>
References: <20260326062917.3552334-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10309:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff94605-0a7b-4349-a2a6-08de8b00c0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|52116014|921020|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lXlUz/qDiaZjDfUAk7tMNCO/GB+8n5cmCKZKrC2J8LpdKFlTbGS0D3d+x0JKuiZvsqcvXLeZxvBVAFsowwNYQzfrjD6tqobsCV1+pYPbcpxYtem4+UyiwJ3nMzSEXZGA65W4Q3KtH6GWxQrO6OUOL9I18Zs3LN+tXBJ+FqlRYIE8xix400pQ/5tyemQoMasO4Smj/dqhk2Tg5fl8sIrjv7WCblBtTcDY96qhRt+zbl/72hQPlCX+/YGHzFh482R75EFxB2BzCNUns+W5cpVExNKFP0RgigxjomIl8EvFG2F77d73INxbe+alekKymkJuhUWmU8J6Zhl+sMG0NxpUOWoTjjCTHMpZs7Xite2vYUXzXWXW3l8zi8aYN41QBEUhpDVfum651GHB8ivVDGySA57zetJURgTHs/P90s/7J2phLp/u5abcIZjpAXYVSdp1Kv+k/35AyAEdBw1bX8nNLl5gg5mFBoqUSqfjBb3CZxPc0dOCqqeicyee48sK/icbH8khXbh56hSgtwLaneQLgFOHR6/lpf6rLYWvsVpG6aKScb7bnZnyaIakly2KNdxA5YJK4UTCP9FcXlNkYkIRaE11q6alGZcLuUFcFYOnavGVttE+Epyv+/qgVHLEoks5NiGsx+I9NQkfQRd2IdwEYElmXyGs5F4cp3YEWhYPmzGoozLUcOSYG8mJv8eVXAVR4KWkD6+gkbj+kfHGBymAVVP2ezAxzPCatVrSyypENe6jd9JHhb7c7ftLlACmOaxvdM5mqhkp6JmQCtgeNvhi5ysSUaz/k9DGDGi9vsiHtvmibKDr6CNTW+mIdbnVfW7P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(52116014)(921020)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hzpJBJTG56kU5flPX+ZtgkWgTRibXUD7CYdjj8SRJD8b//lK8yVyzAOwB73U?=
 =?us-ascii?Q?tPEZwnR8IHAjgjTrK+k/v9kMTWy+cKzwgbdFbYRvXsU73E3ShcN6FQLihRN8?=
 =?us-ascii?Q?FFyz2b8Xc1zi4Mzp2VJ6eLwqZ5scutb6dMUPVSQtkckXl7xbqNx6IZEOAFGo?=
 =?us-ascii?Q?cjjGVw0fBSA/CIqC4xvCn3px/63W+TARCC1hUrI+5P9HnHNPR0yfu9Nuf9vP?=
 =?us-ascii?Q?MzULLA+AbY0kZOomzFtVeXPMHegt/jn2Y4cEwCfbga5KzIzGvT8ASyWzElZH?=
 =?us-ascii?Q?yw3Yu2gXR79B7eQBVM+m88rG6wOPfXPkgESHGW45+VeugQPjtzHD1FLO5wuE?=
 =?us-ascii?Q?E8KBO6OwGVKxYDBbj2ZlN3MiL2UEvLW/d+lIzgiwYXs/jhkkL9a0d9VxkKtA?=
 =?us-ascii?Q?T1CL/Ggq2VcArx1uRyz9qeXcdItJLFpRcb4hIG0po/GY3MdLRJEFBdJDgX7z?=
 =?us-ascii?Q?Nx8ZTEotBx0912h0rc4kqfZ4x0SglK7TpSWvPhSP7OkTu+fXzusKavOZ25vc?=
 =?us-ascii?Q?z81Qrdl4NrAZvxvt+b+2Pvf8r7o7CEy8vDutUXzcOZR4Rjl7oKgpg1TfMVxk?=
 =?us-ascii?Q?qMJTUlAOR4MITRKd5bz9U6ov2cfaYKJVAIg4vQMDS5sUnfrOVCPA0latu/Zj?=
 =?us-ascii?Q?2g3708wPVvEfPkVi6Iy4vpcddhUKNxs40DTzXxPv2REqjVUjgh9xiyQAwuGE?=
 =?us-ascii?Q?CnXS0PtpIcfCCUSFeuLO7ZpqErMHiO0ehCqciAtnwBYCTxmdchGUChfOqHxj?=
 =?us-ascii?Q?7GYvXadc0OENbITgSTtRLXWI+s3Xu9UkpCvXiptf+wtV6rja425CFEkbor/L?=
 =?us-ascii?Q?2mDFeszaSRQKbcxgcOI364CHUu85SYt7PQ0xMPYR3su+1a2oTrnTLXfoxR4t?=
 =?us-ascii?Q?p+oBY8JkTne2MfdJ4/WBy4626VfNiC8YkpM92l+5czpj3DYqOYzra9AsPqw6?=
 =?us-ascii?Q?kmmfMzCOcJ7ToqPM1XXJq2kxkMR9nlE9J0WnrHY7X3yn/0jsSAxUaWxZ1jZP?=
 =?us-ascii?Q?hK+iAMePmV35z7EHB6VrAaVk7g1lJYmFX0owMpJDMurVe6ZFN84s+oDmuRvp?=
 =?us-ascii?Q?GpJnNjjl2eBR0lKY0VwEOXrndpZB2Yai9OxUDdXrXD0hs/sdwi+j2s2e6GKv?=
 =?us-ascii?Q?2AMwd3i5Yprd9KkOzh5tTsK+5rv8GeQ3sSxMHoi+hu/QJd1ZgUQU3iBMbUBA?=
 =?us-ascii?Q?A99vWWtMsth28YVW7i8qxw7tquvCIQB3VVO1Hmnu1DBLus2Oq4AD5oGQERf0?=
 =?us-ascii?Q?UzZXiPuBYakO+pN0UicANmjGiM9t4XxfMkf5bB5yJDtDKjHL91E6sJIPwUoN?=
 =?us-ascii?Q?gCFp2xm12mQDTNwng8VqLDBlcnfl/6dXJgpJlHisLAfkMEbTDal/PGERKIDr?=
 =?us-ascii?Q?bAsnMbyKOKJ3F3q8eysmtDXIcbgJYyxD2OimofELRt9uDoX1s478hsPFuj/j?=
 =?us-ascii?Q?YtjXsZa3Rd2hHoj1w2sFCFz3xOiNjOL9GQ9T3WQ1dVFLfqjGiP+M0irRuml+?=
 =?us-ascii?Q?AXhmj0JhrYzzGlpYdxHyIre0pFVhnd66eHt15e/K7yGD3XHOJdPSVr1yKjcX?=
 =?us-ascii?Q?SN9IujDuSFvRxu3loSln4VJl6qBup2mXoPymEe3P7yUH4qU4Nptta3pCZbiH?=
 =?us-ascii?Q?Q7MHBbRtGB6+1wABTjq2oZwvqJhkSTPjJbGTH/Ee9WL0399KpTtIv0nMHxWW?=
 =?us-ascii?Q?l0QG+BdVFrVxB/F0bDuPrpNK0Ai6HCROeXpdCIUc1aSYonm2JMuSCT7s5zC2?=
 =?us-ascii?Q?w88SGjcoqw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff94605-0a7b-4349-a2a6-08de8b00c0ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:27:28.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIZL80wALNxnI4U/n/M0IHnseJhedYqSVO3L0zjfLGwNjxPc9OP2IlGzNSg9Hr2QU+w+oVvWGmwnyqnEEVFebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10309

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


