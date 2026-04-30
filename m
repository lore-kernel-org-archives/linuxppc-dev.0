Return-Path: <linuxppc-dev+bounces-20309-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603ADFF887E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 02:48:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5drz5kpfz2xlV;
	Thu, 30 Apr 2026 12:48:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777517299;
	cv=pass; b=KysRzl4DJd9P+HZks6VN/8wdHK3TWL520dlNbTeB4BJZmxsPDg56/L7sI6l+0epFsFRvcqAB9D1b83B36rqgydjXh+rivTEInL/cfbv16f88rHbhhxiMmW/1gqDencn0EbR++ehRyjEmnCxp5ho398kbn7SuJhvHGyyL8623186bMQv+0EUAFZ7iEIA4NiQlfqZJS/WtboMSdnPB2r0vx0dA0mYHnhm3khAkEI/4Io06R003S1utY8rc4UAMpdnWNUxWuDqNNIAnPqZbfrSbW3ZcnkhYzaHV6JTO8iX7dkn4mI5i19MpIsPTTWIBdJY4R5tUhcGpldefopZkcSeCoQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777517299; c=relaxed/relaxed;
	bh=Ulv5LBMQKQg5bxqPAzsJBS1y6tFswAmR0wTeu10FLR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGTotBzuO/pHQcXt6YzX8EKQTEBsCWW7CvPnoW1Ll08kYrjtapi+AqpPvq2xCrvNvd/8GtrA9CCK8pbB4ZWkHu41VIZEzSdkkGsonKQhDC3X2sS7B6IXDG7rOPG4Z3GHeJmI7TMwBENdL5cuBARACRhiR8tBK1XSjFBD9OxWPYdpBNsX0x0B3gJ1xQjbEVlPZrE2ahaUeMVAI4HCL7dXLDuka/YkM04GOdLgegw2jnBVedEKb4JT5ydsENupoiQYKdQ1pBN9Lx9mEKtvy0URShESLHSMqza4pZJh/8yh4gG3ITDLpazoJ/q+AZirmnzoGIksHb5S5t3lJg8DkiTs+g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WkSiqi8V; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WkSiqi8V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5dry576Vz2ySJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 12:48:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5vzGTG07UZGclLVbjNylSQnEgf5V70tZTd+Ls3Vo4PSGIwmFgbMUP2R14JcZV4PPnHG5ywW+2oskpqKZdR7lzy+iKKER9NYkDWWersf6G1rJ+SEyBztHkM5f6LqmbShytU02fWVo2NN4s3opp36krMuw4sIufanBRNEt/HmqXUxcpD1MQImEXz6EJant+/MVTvPSY+p5R1L9+ptRvbPVey1LGM0tustXt3o7Nd+vpBgEhaKGNaNb/z9ASc95IoZwhuJOTwhJH5o1CQly3CeJveWiTRtMT3z4a4zqP6AuFst/7Yna3pHcltjrqUL4H9s1b+tO3pFemOeQUrM8m8yeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ulv5LBMQKQg5bxqPAzsJBS1y6tFswAmR0wTeu10FLR8=;
 b=Kkz3gdmlHIcO/RECg2wJmFMVr80bOtA4G4kTYwnahTR2fWrmqpeI3i9EHatkfcQYmE+3pC/FE9SVQJb7bGcp2la4WezkYC8h4JLvjdQyY8zuzTbw3Qa3nWMWUKanglMq4llsAiSehkuTN+qtoF1PbEV4v0Ud827EEddqB9qCuOu/D3oVx/8jn48nlWYct7XM3IHR6xCpJn3MV28znEmy+SeEz72FLNcHfSyP7TQQ2xK0EUfQsUN2g7N9TTGPChOu1wDzqfOqXK9NJfw3QE+wWyqMfWgrgAhobN4JtX4mFZkfx4qEygXGeoCMbFHvL/v06dF/QiMi/ypHomzBZi91cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ulv5LBMQKQg5bxqPAzsJBS1y6tFswAmR0wTeu10FLR8=;
 b=WkSiqi8VAKLu5xqv/5+LZFUV8ra16B39n4mGeqopEQoUOhB3Jh04JRbZi0naCIiZ2P0MMoPCCAnPriAQAAlHHtZxWWIlhTe3TcqaDTQh5KmKguph7tBrZxvo8gZ3AUIk6xhepBdUBocqxJLa4HUJ7oqN92Jip7x7ZNSHzVdDigMeLfjpYWHJFEjhFnkzZDHs6/4IBElm1C0Iw8LXgxHJSCJFsFbSt5DsCC58CZJIQoFUIzMv0mBcPYIdDk92qDuAvjL92nlTg8RcPDX7hBkBNKtyejMLOHqoa7j8u0lfBIX3TbxY3E76jsYcd7Khz6zEFs92YujAawLVayeuZZvOYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:48:07 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:48:07 +0000
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
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 06/15] net: enetc: add support for the "Update" operation to buffer pool table
Date: Thu, 30 Apr 2026 10:49:36 +0800
Message-Id: <20260430024945.3413973-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430024945.3413973-1-wei.fang@nxp.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 2faa015d-9477-46f8-ba45-08dea662e8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qqQUqOCURntaSMVp148To/gXQCHTJYz2+e8x0E3uhVJcGTlcm5O7TJJ1GvIcTo3pwEBYbDKJAIjCAatYJ3nn4PU2vwHIy/XifgWpwccSnP+B9BQlW6x/CeJkXbnPRbhX8bK5wUcSsLpsFEGtG7X9NHGb1ZfisrP04awiXHUmoUa/ICojdUK2pyU4WmH2a6a2TIjrKeQZY0jMfDDEZyxxouSc+LrP/Xl81NqRShiME7R8uQrhL2v3CJwZR5dJTy91hyGq6+Ok2oIAttQg5ntBQR7X3HrBzUUIHHaPuPyNr2NxWFyM/j3H1FmeCH6reqUI00g5KcY4kvmEynevLOAeGM/dw68uUvaBt+rsJOqR9aihkGBcUNK99bBeluzqEfe2mXdc4fxI603ShgQctnXt+/EUO0arvPnoEYttzO6oqWTMVPQNH/hK14qEQCN/r+/8MY/Dgaj4imsSLOyz9/68Yzw+rzpDTHWl76IqBCDWp34L53pGBXP/Vrc+WqK6jd+6BwRYq3VBuEoX2EPtXTXbSue5Iw62sGToDJ0/hyph22uf5jDzjL+7VqR3pBhDQIXzWJ03H2au2hc/BACdw6W7GWbbE0ijCp5Ap/X3fyDqX5HgzMzwmv1owoT+SE/XH1MgCEnnsCQSQwIWu+PHkmyhaP7jSLVjxnrj0p5KmTHoB9DD80DOu0ZXnM5PnOZ/4rERluBCZHmma60kGf1hHXqboseB0DM1qh94zGpqNepmPt+R+emRet/Y+rnQ2jUF0s7sjqtQxUT9iYnpHFYge51Qj3oCRVaNHAWeffejFg6Cr4Cv6FRPioHx6kyY+7wdtIJR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+tDBtESTcXIs+HpoCzVtVjfudwXdY2VFgGLzJvjXlBXS4czkQrj/16t1c5/E?=
 =?us-ascii?Q?+rX/kY85evtWXg6C5Lu58AbLK0SPbmnm1YHD3UDFAF1uJK/qgLcBbLCLTwHT?=
 =?us-ascii?Q?zyA0AY0ZK/sLO3tgfhuOcf2E/Rw7fkl6pSQLuRhnJdOU24fISKjFllWeupTZ?=
 =?us-ascii?Q?ae1elY11H6nD6c2/++4EgEpg8C3MnA8ASTcMgVKI21I4dERWuwZWuxePev0z?=
 =?us-ascii?Q?6L8KbhyRgRbxMQkkDJsX/gUwbYIYOK35vjOOjqI1/xqljjsimNGuoXbu7E8w?=
 =?us-ascii?Q?gbZAvVliewGSbUWWBG5qscOzcI3EFZbNZvsCXnT8FR30DtzGGzpisY+PG/er?=
 =?us-ascii?Q?7BdWUrhoSzH5PCxloVZejXhTv15A+Tco8J0b0CzTEshqA+a/esCSONJi2QGA?=
 =?us-ascii?Q?ylGeClcAW2xjaJmeTB91z9Ix6tnyb2rvdPmk5kLsf6uwGvUOcN9ajx0hrH4P?=
 =?us-ascii?Q?BmLCI7+THvUP61FhNFZCR5zaqSxx21moDe9SwAc4NRP0RqJwquEyRgtaIeQt?=
 =?us-ascii?Q?HzQhDPiFwuULijipXLb9CRRlM1NG+EYhdMxOrIdNlDY+TpbKtIeWIy1aAxVA?=
 =?us-ascii?Q?dRjVSpc/xua0OLvE7F0hBtJfm/almDyFYEmoQt3ztWaltH9e7vXrUUTEOMjj?=
 =?us-ascii?Q?mLvcpUDQVx3gzqZpTxn701OGoC7vTd7iWGRyV15d3B3MS/joIBy9EBcxJSxQ?=
 =?us-ascii?Q?ZtS+Onq5xn7EDLLLg/59Q3igozWxtPI76pobEk9r6AaSOoeUIIA0dGsCwtSo?=
 =?us-ascii?Q?61UNPkT0/OVu8zmwJHkuqC2gazgNXAWDDHTihKgq0aT5SoookSSa6pq8w6EI?=
 =?us-ascii?Q?na1PizA0Dt3mkMm89hJL7/s7KaPpyXkQQni74UfO+yKlJMGDIFCqoKs5xM4D?=
 =?us-ascii?Q?Bwe+fe8AIdalt+3x76/TPhWMFPJO9zGIDdBNEEBkJqDCSrbYTa24PAcC3VSW?=
 =?us-ascii?Q?agDNpNe6cLsg2pHqF9TpWOsaRirYJJTG1Y+PqmJU+bE7dfC4J7H+S1NCBgOt?=
 =?us-ascii?Q?1GVVu4Ruf2e9fi3xJ6PQtgS4FkDfor/xVZQ9jN/qaRLpLNfqwRU2x9X/FbTF?=
 =?us-ascii?Q?2FCCYJhWrMAcXnOfQYsnUJHepwfkXFAdlcdw6YBLER78HFlfwIIk+agD472i?=
 =?us-ascii?Q?vAupxsmsx6NFp2lx9vaOEIYFgNKhE382l39f2BPu47BEtke6uwd4rHiA22gB?=
 =?us-ascii?Q?HnZHYdRo75mAfT8WLuP6LJFJjF5UP5+Nb8kJe5ZZuitvKLC5X1zbzAPkACE9?=
 =?us-ascii?Q?VjwYGhirE3/S1O4KkDvkTBDJUs6mZ6ESUCT/lQUZbtC1zDMB5tAS9l3SbnSH?=
 =?us-ascii?Q?D0/XMwNJ2nU0tzgUEoEhIqBKzkWkp8Ok8HLFzSQJDgurmAbKRFbi5ql5h+JB?=
 =?us-ascii?Q?8M9Oii3VtJ8fbd9JoXmLL6FgRLGDhW56Rsji8briV2ytGljfAoF+4xiJ40mY?=
 =?us-ascii?Q?CNVLLdboOfbks8fuQ8qzZSXA55bnFypb7VNN4vff1nHakUweiI+TCi9l02uz?=
 =?us-ascii?Q?SelahLsa+AnNTj2perxUAPINTV8aXkreM0OMaUq/0tiDi+U08KpdTg138NBD?=
 =?us-ascii?Q?pUuRnLEXz4PSiRj2yRp1sYjicuq6IuV3/pKhKCeHzwIYSdNU5DPgCf/tQBpT?=
 =?us-ascii?Q?XoQk272iAHWZlUHvuhGD71VHxHwTMaFOi24h+OPWx4x1dbps/EFkqKzSxFm3?=
 =?us-ascii?Q?PSNaOxxoO9m8ryVwv2jOlGjTvaGRwoh3cE278Pr3UsrXrCJh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2faa015d-9477-46f8-ba45-08dea662e8da
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:48:07.7676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocoYfyG/U4HV24E3JpS2Gvg//v/7sh+80OSQJynupbEanESS7wZEi9lA1mphfZpILRv0hc+vIe9i2pj+fP97JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608

The buffer pool table contains buffer pool configuration and operational
information. Each entry corresponds to a buffer pool. The Entry ID value
represents the buffer pool ID to access.

The buffer pool table is a static bounded index table, buffer pools are
always present and enabled. It only supports Update and Query operations,
This patch only adds ntmp_bpt_update_entry() helper to support updating
the specified entry of the buffer pool table. Query action to the table
will be added in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 39 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  6 +++
 include/linux/fsl/ntmp.h                      | 26 +++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 31e8945de6cb..39d7a14a8bef 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -23,11 +23,15 @@
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
+#define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
+/* Specific Update Actions for some tables */
+#define BPT_UA_BPSEU			BIT(1)
+
 /* Query Action: 0: Full query, 1: Only query entry ID */
 #define NTMP_QA_ENTRY_ID		1
 
@@ -269,6 +273,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_BPT_ID:
+		return "Buffer Pool Table";
 	default:
 		return "Unknown Table";
 	}
@@ -747,5 +753,38 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
 
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge)
+{
+	struct bpt_req_update *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	ntmp_fill_crd_eid(&req->rbe, user->tbl.bpt_ver, 0,
+			  NTMP_GEN_UA_CFGEU | BPT_UA_BPSEU, entry_id);
+	req->cfge = *cfge;
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_BPT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_BPT_ID), entry_id, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_bpt_update_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 575ee783be47..64df49e9a3ef 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -175,4 +175,10 @@ struct vft_req_ua {
 	struct vft_cfge_data cfge;
 };
 
+/* Buffer Pool Table Request Data Buffer Format of Update action */
+struct bpt_req_update {
+	struct ntmp_req_by_eid rbe;
+	struct bpt_cfge_data cfge;
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 3672e0dc7726..d74714a402f6 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -33,6 +33,7 @@ struct netc_tbl_vers {
 	u8 rsst_ver;
 	u8 fdbt_ver;
 	u8 vft_ver;
+	u8 bpt_ver;
 };
 
 struct netc_swcbd {
@@ -123,6 +124,29 @@ struct vft_cfge_data {
 	__le32 et_eid;
 };
 
+struct bpt_bpse_data {
+	__le32 amount_used;
+	__le32 amount_used_hwm;
+	u8 bpd_fc_state;
+#define BPT_FC_STATE		BIT(0)
+#define BPT_BPD			BIT(1)
+} __packed;
+
+struct bpt_cfge_data {
+	u8 fccfg_sbpen;
+#define BPT_SBP_EN		BIT(0)
+#define BPT_FC_CFG		GENMASK(2, 1)
+#define BPT_FC_CFG_EN_BPFC	1
+	u8 pfc_vector;
+	__le16 max_thresh;
+	__le16 fc_on_thresh;
+	__le16 fc_off_thresh;
+	__le16 sbp_thresh;
+	__le16 resv;
+	__le32 sbp_eid;
+	__le32 fc_ports;
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -149,6 +173,8 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				struct fdbt_entry_data *entry);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
-- 
2.34.1


