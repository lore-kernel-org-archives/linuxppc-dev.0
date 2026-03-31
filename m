Return-Path: <linuxppc-dev+bounces-19072-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D801061B32
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 11:29:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flQrL6pPJz2yd7;
	Tue, 31 Mar 2026 22:29:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774956578;
	cv=pass; b=f8qsxBOSx2QrMCBJGGL+79RIiwK1qMgBtE6/LlOmFxW/7mW7z0Opm7CygDp4MIpkv2Sd+Zql6nC/2XHzgCzD18cJhWe+fps6ja/JLIcR5ev9JxxGLj/rf1WS6y3SptmElxa1Cs//6Peomb7oj8O2vtIcZR00dHU5wptFaLUsd0V46Wxegn99IlNsBgiGmapE4zNNPYAXy2KN8VKnR1/1l+S60ewMpqh8QQ9V36mupc3hFJfy8fEyfLdZJ4SJ1iFSpP2PUtyQmK4EW77lVnU6vREjkbA5goih076dpAltXJiVuvVLXc8OqYsW8MlClNNgXTgxySiGRh6x1/2BI+/vAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774956578; c=relaxed/relaxed;
	bh=tx8IlxNoilqLm5+3c5cpJbVBBo14AVY0MDedKr3KpNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZOaix+MU9bDtvH74pZKpfi4xU41clQVt2gBP3vdO0tbcKKNK1m1cOliJgXwdfTN9YTaKSAfS+Woonqwmx87x6MzrimfRmkgWCaJy0iPl9XEruWDe5ZIvcGLpA4to2sZqFbOFLh/dMoC2I9GqVX1dXDI+6brsfVgwThGvL1I6vAFs21773cfIDObSrDFqy2U6OvVNfRaUgsWFBfjalsEts7f1XZB1j54zF4+u36E1h3M7gwdTsExV3UUcAELiLJSCM7CXSzEfJivWJ9eMiczcRR11ojGCZDilJolp1gergWoInxbsW1SJvu4YNlrWcE1IJifO7dWTJZbwUzKxO/Z13A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ErNHKBJt; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ErNHKBJt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flQrK6zYwz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 22:29:37 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmyni83O2c919kSzBKXUP2xbeNPwVAZIL9eSSoc6Ok0Dq8XMgJz0YHSOplncP4bIvH2vN4LGcjf/8cMzmyQ3hisHG6f7B5lbaw9ILbWN2w0TKo3wJSGZSN5ARx0WFxJQRCurx/E9H3sOsqeP2tpMBIwAq3CPWzaw+a9CiMnQJDVRm9I4wF9C2XCJBxKuegVNn/PVg2yH22dJUz2/WAuZTQsHEERBi58l0F5hb1uIYj8C7fMcRi06ER42BNMupbKF6/NjbRgma/t81tD2SU/QdreRY+nv579zgC4o44B5pO/fOVtrpSJCUeI2/lp1Lzt0baHQPbhT3j3nfYzFE8NHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx8IlxNoilqLm5+3c5cpJbVBBo14AVY0MDedKr3KpNw=;
 b=Hu0DuzMNZ4xDx0lsJhin+9lQMk2ioYT5NJSE+20cNOV247jTCTJN2shZs7DKflUbv30YZaagUiW85M/jynQJ4yYwr56VC8vbksivNFs1QagB10XSBoH3MGiU6AW5Cs6fHISAypVzfS6TsabP2D9/v5momoQHiQYVeYUhGukHE7mFz2mtc6jhiu0tAtIn28bRvQFV/6CZyl/xqxB0Y9j2Cz7Q7kKr+/qP+jfEMnKXa4nOIRT5X1/OPCNl0tUjLcTw9KyZouQlNsh6JX2PB18goSL8JWl3elF4DmyAFcKCnjtDsFo5p/RbivXCnFgkt8+bSNle9iYR0NcdOcODl+u+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx8IlxNoilqLm5+3c5cpJbVBBo14AVY0MDedKr3KpNw=;
 b=ErNHKBJtm/kQHTEb5O3nymXV7PC/FkSo97/gbgYImqQgyyttLiVoD8cnAYREGkZBHOi2ydbH9SLsHQ3ez40DOEqqAwJiqj2VWdM6KOvYLBjuNLCIhflFpI3a2biq2A5bNtU+pnxko1/8c37BCXUAFM81owziQcA5YODqrWpkMViFHA9X+QjvCW49C+q0k7QK4LTG+inju/x6kx+fliGxNLrcaYyBSS2yk0bH9IyyjwiiwGYOOQo7CpwWhIaqDiDBUKk5odLOH61aOSNi6XTVojxzycZ/oOGsROodEy0Z5vZfa2DGaMFJGHLGpN7wi1qz/tsz0SN/++Ed7Hb4u8kMkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PA1PR04MB11406.eurprd04.prod.outlook.com (2603:10a6:102:4f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:29:21 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:29:21 +0000
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
Subject: [PATCH v4 net-next 07/14] net: enetc: add support for "Add" and "Delete" operations to IPFT
Date: Tue, 31 Mar 2026 19:30:18 +0800
Message-Id: <20260331113025.1566878-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331113025.1566878-1-wei.fang@nxp.com>
References: <20260331113025.1566878-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0151.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::14) To AM8PR04MB7284.eurprd04.prod.outlook.com
 (2603:10a6:20b:1dc::8)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7284:EE_|PA1PR04MB11406:EE_
X-MS-Office365-Filtering-Correlation-Id: 4128ca31-d7de-424e-5cf0-08de8f18c0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|7416014|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	ejCvOMRdC35Bq8aaK9Gdo4wvw99VWih+5AGNQE7U1LuodlGvnLfVS3Wy7dXbUbD28AtKurPZ4Pz06uC9u3yzl6Vs6IUFEyiTvzAAE72WcEs7e2qhybhCDWRbCaL37PIiiZbfZlg7rAG+j+a+6Mnf9PZoM0yNfelqYRf+SKshxcz5qJN12lTdEvGpIsY+gTDbFAwRBU2EqnUt2FTyFA8uhFwZ0pZ7Zx+Ops6WxM5SjWXASpFeXB95CPp11KNS8Hiy8KOSaslrMxGdNBx4j1jbaLdr1jPREB36HSYszQwVUgSRl9e4uPqTdRR1H2i0IqMbQHGATKuExqyr+wgI6gI+1qiprQtlI4igUdwlnD+88YjjXTPk0zST3KMEDFduUeY2pd++9er6Y2RfoOPLArXhk5O0q67zG2r9UbaAVn+WV/S+k+AWJk05bo/1asTVnaiU1NtMXdbNp1uW88F0A3C6SPJwPqZ8aT9sARwrLvjBxPz+U5FgAIiJKGUyC4/WKHTNmU+ocvvBfxxWkVmL063Ul9pUbZAfcyVu/TMsWe27tOYvRJp/w9UhWIS5TcDgMNcmb+zUIsaFBUERjG702fjIMmW1ArnUQj6WEtiABuYI/Do/5RhTFsmwU4lex5pc4LVh+T3wS8hhDm1LXG9e+3VCqS3HBGJl77CdBB4TZqwUYVfnypk8Rr1x0xh7HHsp7bM8ThTJ7WgAHXwwRkVO7MDb5bwvAvmtuCV2ehJGuRWlzQJHAVzs3aXeNoAacyi45NCkqXFD4clR6FEJdB9OY5nuzguYiliguSFshojq0kD7b3p2vvc6+X7QN06mo0vIF+10
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+rwMW5Rnk6k0QTbHRJBQN3cs1n9ckN1d+7X6XnV6KeJXZCnLMg26imSt3+6?=
 =?us-ascii?Q?lnPGS7S//8y89+LE1HCwV/uMXh1nLiSQuKbASw053EBoIFynEs1uyb2ay8IO?=
 =?us-ascii?Q?K+poqyZYbqWe0RdM05tlirTjCTd7BABUfDsb5tqCu+oHbLd7B4fY4tOXYjmu?=
 =?us-ascii?Q?7RPfPiGacGaJwwItnCWEpvqxIbMv8ZVkVPGAhe1KZOnnn+eAYmJgx2YTA263?=
 =?us-ascii?Q?3JNKP92q9GRW52EF2u/gZDa4iefOecefRGszQuMSfpHWmMfle/KUu3rt0TBC?=
 =?us-ascii?Q?psksCOuWLH2yM/E9xFsLg1yJIDChtFdY7BFcl9lTaXyjOjzLJWlx5kAzXvjU?=
 =?us-ascii?Q?1L4p9IuvBkSQ5ypt8K/AeohANmkV8Hp0AV2yAUIapxx3vhVHldSC1Ubd43sE?=
 =?us-ascii?Q?jtxLkMZFbYpZm2JlUWX9Mby2L0dJvakrwRTpdGarP6OvotxXO++6IwRrvWVo?=
 =?us-ascii?Q?CXtR2aG6SqvmXpIXqD0uIB7ozANxHSYbqAZ+W76lWZxDp52qBalpynkazZ3H?=
 =?us-ascii?Q?6I9mhxmiKFJEP11DC3waBmxDf8HMCFcyOwe1ozZHNDdnQYDROKrXS6Hs854s?=
 =?us-ascii?Q?8HLwVuClHPsuh389xkcyfl1dNsSAh0aE2g4S/4drexEI1drcnZZ/jNGIR1gg?=
 =?us-ascii?Q?yxwG9vCCkzIx35yPvM2DJ8fIZTld2oGrpCwKEebsz1GiLJnp9HVhL70PvmrV?=
 =?us-ascii?Q?OyS7ZWDFaUkOG71N5ZvHu9OeN1FN9RmwgqPh+yITmR0Vxfp4NHRPWiIiEs7d?=
 =?us-ascii?Q?oB+1gB582IE0qIl+n1tCCYmPubHu3zR3NnOSMCLl9RS3Ni62GzBIlAKGrPY6?=
 =?us-ascii?Q?rrxMDUJI7ccvk1q+pBddDAiJeQYaDtBaUeDKEfPof1NNfHZ82shFpHfWMPnV?=
 =?us-ascii?Q?ik8rX6N1j8t9TCNpN6aHDsiwqgupo5bxN1X2+yuX513x4yr8vFb2+1hH1jCc?=
 =?us-ascii?Q?G0Ue26PfDhrPCqZTKQDIfTstc7nUHg5Q1vXLu5HYm1KpaC0p4gcdvujwY+qe?=
 =?us-ascii?Q?+J3E5RiSp3RUcIsdJNl/oYGm1l+z6QLeEFdLh182MPXxOp8Eyat78GhAo/Aj?=
 =?us-ascii?Q?DQd/3LISpkbYd/hYhHS2MAHrCCIgF/99VQObVV1nHgvR6c0ZtKT2qQUmacES?=
 =?us-ascii?Q?OsdwRD2cAtPvgwFPYW7Ps0t2Kx8JaujrHQrWYiFoTefXu7jO8OeYxLDiimml?=
 =?us-ascii?Q?gtalnWNIObQVWWgXodo6JCcTDPUyomEN5wxbdCQHwQpv2p+K/p01AfwyBxt1?=
 =?us-ascii?Q?+D/PILKvNJ+zjhg2TG5T2DmcIePdcLLX8kG64yAEsv+kYU3iId+fVziePRpu?=
 =?us-ascii?Q?E44VNyQjZ35cEDUr+5wPRVm0c/5ADk485T5kqXaK4bdTWAX5acDB3bYtDdU0?=
 =?us-ascii?Q?YuN8fZWQCnNLsOh7dIOjJaLs4br4frBRUKCrIq9ZVKxENQWRvPOEX54cDPTj?=
 =?us-ascii?Q?noXaX7yix7Kd+xZtXxNVxixXAGF1evHZKnESTt8imsyiQpzukOWnAsMkZPdA?=
 =?us-ascii?Q?wCIRkOkCwzOTvo0/gwXluCwYSYEaAQ8gOZdTWzgY2mB6lhOlGYIK9s+QaQTk?=
 =?us-ascii?Q?0TEGl4Xrt808TMqPwrThzmi7scfMHN3izqLQnNcOIiNRkWNPHEVowP+R+9Fz?=
 =?us-ascii?Q?xCHOsu4uqjSmRt+DEx5MnaBSj7SkUOIU7EnKdBptIK4LOT4xV8ZfcuBDfnFJ?=
 =?us-ascii?Q?yLoB1jo6P5y4NGrjN+9j6uydYOYGJmLGysE3GlAeYAdcxzFo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4128ca31-d7de-424e-5cf0-08de8f18c0e5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:29:21.2569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: id3a3vzjtbPJj+JGla7M5s7Ldp1dSRlpbFXmzbpJQjQyeiO87iG/XtLe+UYnk12I2KKRp1W5IfrkH+CCvHP//g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11406

The ingress port filter table (IPFT )contains a set of filters each
capable of classifying incoming traffic using a mix of L2, L3, and L4
parsed and arbitrary field data. As a result of a filter match, several
actions can be specified such as on whether to deny or allow a frame,
overriding internal QoS attributes associated with the frame and setting
parameters for the subsequent frame processing functions, such as stream
identification, policing, ingress mirroring. Each entry corresponds to a
filter. The ingress port filter entries are added using a precedence
value. If a frame matches multiple entries, the entry with the higher
precedence is used. Currently, this patch only adds "Add" and "Delete"
operations to the ingress port filter table. These two interfaces will
be used by both ENETC driver and NETC switch driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   |  76 +++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  36 ++++++
 include/linux/fsl/ntmp.h                      | 104 ++++++++++++++++++
 3 files changed, 216 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 3c59b355c142..960d5be8ec42 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -20,6 +20,7 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_IPFT_ID			13
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
 #define NTMP_BPT_ID			41
@@ -234,6 +235,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_IPFT_ID:
+		return "Ingress Port Filter Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
 	case NTMP_VFT_ID:
@@ -468,6 +471,79 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
 
+/**
+ * ntmp_ipft_add_entry - add an entry into the ingress port filter table
+ * @user: target ntmp_user struct
+ * @entry: the entry data, entry->cfge (configuration element data) and
+ * entry->keye (key element data) are used as input. Since the entry ID
+ * is assigned by the hardware, so entry->entry_id is a returned value
+ * for the driver to use, the driver can update/delete/query the entry
+ * based on the entry_id.
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ipft_add_entry(struct ntmp_user *user,
+			struct ipft_entry_data *entry)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct ipft_resp_query),
+	};
+	struct ipft_resp_query *resp;
+	struct ipft_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	ntmp_fill_crd(&req->crd, user->tbl.ipft_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU | NTMP_GEN_UA_STSEU);
+	req->ak.keye = entry->keye;
+	req->cfge = entry->cfge;
+
+	len = NTMP_LEN(sizeof(*req), data.size);
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_IPFT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_TERNARY_KEY);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_IPFT_ID), ERR_PTR(err));
+
+		goto end;
+	}
+
+	resp = (struct ipft_resp_query *)req;
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+
+end:
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ipft_add_entry);
+
+/**
+ * ntmp_ipft_delete_entry - delete a specified ingress port filter table entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified ID of the ingress port filter table entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	u32 req_len = sizeof(struct ipft_req_qd);
+
+	return ntmp_delete_entry_by_id(user, NTMP_IPFT_ID,
+				       user->tbl.ipft_ver,
+				       entry_id, req_len,
+				       NTMP_STATUS_RESP_LEN);
+}
+EXPORT_SYMBOL_GPL(ntmp_ipft_delete_entry);
+
 /**
  * ntmp_fdbt_add_entry - add an entry into the FDB table
  * @user: target ntmp_user struct
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 7d50af7745c7..6d519d59a433 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -103,6 +103,42 @@ struct rsst_req_update {
 	u8 groups[];
 };
 
+/* Ingress Port Filter Table Response Data Buffer Format of Query action */
+struct ipft_resp_query {
+	__le32 status;
+	__le32 entry_id;
+	struct ipft_keye_data keye;
+	__le64 match_count; /* STSE_DATA */
+	struct ipft_cfge_data cfge;
+} __packed;
+
+struct ipft_ak_eid {
+	__le32 entry_id;
+	__le32 resv[52];
+};
+
+union ipft_access_key {
+	struct ipft_ak_eid eid;
+	struct ipft_keye_data keye;
+};
+
+/* Ingress Port Filter Table Request Data Buffer Format of Update and
+ * Add actions
+ */
+struct ipft_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union ipft_access_key ak;
+	struct ipft_cfge_data cfge;
+};
+
+/* Ingress Port Filter Table Request Data Buffer Format of Query and
+ * Delete actions
+ */
+struct ipft_req_qd {
+	struct ntmp_req_by_eid rbe;
+	__le32 resv[52];
+};
+
 /* Access Key Format of FDB Table */
 struct fdbt_ak_eid {
 	__le32 entry_id;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index a54945dcdc61..efda35e5e22c 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -7,6 +7,7 @@
 #include <linux/if_ether.h>
 
 #define NTMP_NULL_ENTRY_ID		0xffffffffU
+#define IPFT_MAX_PLD_LEN		24
 
 struct maft_keye_data {
 	u8 mac_addr[ETH_ALEN];
@@ -34,6 +35,7 @@ struct netc_tbl_vers {
 	u8 fdbt_ver;
 	u8 vft_ver;
 	u8 bpt_ver;
+	u8 ipft_ver;
 };
 
 struct netc_cbdr {
@@ -66,6 +68,94 @@ struct maft_entry_data {
 	struct maft_cfge_data cfge;
 };
 
+struct ipft_pld_byte {
+	u8 data;
+	u8 mask;
+};
+
+struct ipft_keye_data {
+	__le16 precedence;
+	__le16 resv0[3];
+	__le16 frm_attr_flags;
+#define IPFT_FAF_OVLAN		BIT(2)
+#define IPFT_FAF_IVLAN		BIT(3)
+#define IPFT_FAF_IP_HDR		BIT(7)
+#define IPFT_FAF_IP_VER6	BIT(8)
+#define IPFT_FAF_L4_CODE	GENMASK(11, 10)
+#define  IPFT_FAF_TCP_HDR	1
+#define  IPFT_FAF_UDP_HDR	2
+#define  IPFT_FAF_SCTP_HDR	3
+#define IPFT_FAF_WOL_MAGIC	BIT(12)
+	__le16 frm_attr_flags_mask;
+	__le16 dscp;
+#define IPFT_DSCP		GENMASK(5, 0)
+#define IPFT_DSCP_MASK		GENMASK(11, 0)
+#define IPFT_DSCP_MASK_ALL	0x3f
+	__le16 src_port; /* This field is reserved for ENETC */
+#define IPFT_SRC_PORT		GENMASK(4, 0)
+#define IPFT_SRC_PORT_MASK	GENMASK(9, 5)
+#define IPFT_SRC_PORT_MASK_ALL	0x1f
+	__be16 outer_vlan_tci;
+	__be16 outer_vlan_tci_mask;
+	u8 dmac[ETH_ALEN];
+	u8 dmac_mask[ETH_ALEN];
+	u8 smac[ETH_ALEN];
+	u8 smac_mask[ETH_ALEN];
+	__be16 inner_vlan_tci;
+	__be16 inner_vlan_tci_mask;
+	__be16 ethertype;
+	__be16 ethertype_mask;
+	u8 ip_protocol;
+	u8 ip_protocol_mask;
+	__le16 resv1[7];
+	__be32 ip_src[4];
+	__le32 resv2[2];
+	__be32 ip_src_mask[4];
+	__be16 l4_src_port;
+	__be16 l4_src_port_mask;
+	__le32 resv3;
+	__be32 ip_dst[4];
+	__le32 resv4[2];
+	__be32 ip_dst_mask[4];
+	__be16 l4_dst_port;
+	__be16 l4_dst_port_mask;
+	__le32 resv5;
+	struct ipft_pld_byte byte[IPFT_MAX_PLD_LEN];
+};
+
+struct ipft_cfge_data {
+	__le32 cfg;
+#define IPFT_IPV		GENMASK(3, 0)
+#define IPFT_OIPV		BIT(4)
+#define IPFT_DR			GENMASK(6, 5)
+#define IPFT_ODR		BIT(7)
+#define IPFT_FLTFA		GENMASK(10, 8)
+#define  IPFT_FLTFA_DISCARD	0
+#define  IPFT_FLTFA_PERMIT	1
+/* Redirect is only for switch */
+#define  IPFT_FLTFA_REDIRECT	2
+#define IPFT_IMIRE		BIT(11)
+#define IPFT_WOLTE		BIT(12)
+#define IPFT_FLTA		GENMASK(14, 13)
+#define  IPFT_FLTA_RP		1
+#define  IPFT_FLTA_IS		2
+#define  IPFT_FLTA_SI_BITMAP	3
+#define IPFT_RPR		GENMASK(16, 15)
+#define IPFT_CTD		BIT(17)
+#define IPFT_HR			GENMASK(21, 18)
+#define IPFT_TIMECAPE		BIT(22)
+#define IPFT_RRT		BIT(23)
+#define IPFT_BL2F		BIT(24)
+#define IPFT_EVMEID		GENMASK(31, 28)
+	__le32 flta_tgt;
+};
+
+struct ipft_entry_data {
+	u32 entry_id; /* hardware assigns entry ID */
+	struct ipft_keye_data keye;
+	struct ipft_cfge_data cfge;
+};
+
 struct fdbt_keye_data {
 	u8 mac_addr[ETH_ALEN]; /* big-endian */
 	__le16 resv0;
@@ -155,6 +245,9 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_ipft_add_entry(struct ntmp_user *user,
+			struct ipft_entry_data *entry);
+int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
 			const struct fdbt_keye_data *keye,
 			const struct fdbt_cfge_data *cfge);
@@ -208,6 +301,17 @@ static inline int ntmp_rsst_query_entry(struct ntmp_user *user,
 	return 0;
 }
 
+static inline int ntmp_ipft_add_entry(struct ntmp_user *user,
+				      struct ipft_entry_data *entry)
+{
+	return 0;
+}
+
+static inline int ntmp_ipft_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	return 0;
+}
+
 static inline int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
 				      const struct fdbt_keye_data *keye,
 				      const struct fdbt_cfge_data *data)
-- 
2.34.1


