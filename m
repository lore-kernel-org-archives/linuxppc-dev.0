Return-Path: <linuxppc-dev+bounces-20639-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FB1CD3447
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:28:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMdz1m2zz2y7r;
	Sat, 09 May 2026 20:28:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322519;
	cv=pass; b=Jm9jcwskXznrFHGJ9rAZcSKFX/OvO8spmKjE475REPZZiw1aNQbtG0TyJH9RPALpmOAilncAqlcfJ+cl67HRGhw3ZpOg6swUmBYqcwOeg4NV9JESJNkfWQHXW5U9ZFDa1wn5MJNuwaPfKMUKmeNOSbu+c2bdNYjQJfOMilr6qAw1uNgzWgv5Yi5pEhM2fAv+sAnEuuY3QkOSfsq6ANwg8ukM0Kxdt4PllE7Vxcw1xTyuBLnvhEQAMh7OTPmr4Vg34GrHYBBtPVt1kr0D+03t8WNoK1+wfhyMH36emupt7NIiTbOrJG5mIahHmhZufkqeWbtD2wmbQk/7Lwt8xSdipw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322519; c=relaxed/relaxed;
	bh=fPhYHGRp49Patt5fxY0C8qU+mk9siDBhcqUeL6k5P24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VB3K/t43FTFZ5tCtfucyLaCqwjVDr3uGKRa2HuOMAoFOoD1SyDjDQnIKkxfIOIMjUobWZfA9e4Pd3GsdPEi52ljTMX6gpPmQOYszXykIWD44XXjKQwFegGViLecVMkAICHpjjW8Nja+Spegv7wlC18rAwBB7OF8gT2u1uY0LtxXsv5TD+TrmGr5oQDTO/7NF147ha5vlx+okl32y+77TbG2jdxB5NZ2dv7qxXWRYGxqZI6D7ZOjwJVMtx5L8Kaz0LjC4pHhfjswb6fAQuUj30nvf0wxXgrA3fTrt/B/erMCApuLzgp/vEoYgVAftndUIwhzkweidR1BBNjg8cOcp8g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=C4jP449v; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=C4jP449v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMdy1wh7z2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:28:38 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQP1eVGRPca1lS6ZspSZE5ddZxC+0ZNfoQIi6XeIR+sG2ktbLR+ss3QQpCn2j59Z73rUwHUqw9LuuppS2pR0aC12+U2HDWC3ugqPoeo4YsBxJRbkFjPHKmdiudVcd7qEfPEDO1hkWjhm3pvjTeStbVx8N7anFJ4afrtW7zsFiKHVEALlDSm4VdOahaWpN/767PSPKIb01aE4cSWahg/p6Wc2Wb3Or3B5iqwzVbqduK5VNLtzv0NpBEMBg5XzjqAKIxO7fKgbnkXdMlR9W8fKTMDcEnnc+Krhgg9S/XSQNg/81HtCpIdi7fKv8v0Jd99kNpv/O4SSy/fhZgk74wK55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPhYHGRp49Patt5fxY0C8qU+mk9siDBhcqUeL6k5P24=;
 b=o4fxLehjOk/W2EGiVrxdec3tsSoOz2zW4JwRwBIbyyz90ermhFFZzwxu1vukZq2iSEQlZi77o8h+73U0yyOi1Aib3FKKdyn8CLYPnzZXPJNE3YbBjGizx7hT85J1EHme5t+4mN58JJNMTCDWRELYzNQzfia0wcdHaefyN8O6SmIisgop2isru2tAS6ZAh85A/Ts4lYov3T8FtEFalEQGmGMGNv1YLtMz13n28E9Y3c1ZDX9SeXohklANgRyYflUrgSjdkAaH/wyxoL7R3qwnHtDRX4jnvraGVrNOt7qKEfY+k7x/kgYzBFOdYj9865Nzz2KENKGeN+7PicqMAviD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPhYHGRp49Patt5fxY0C8qU+mk9siDBhcqUeL6k5P24=;
 b=C4jP449vd425nG8uwRZwqjh1Zb5Apv74S6+SWOyncwtY5EGeY7gHeogPwlASQqcFhZueSMrxXa0DFlbxnnmYjvcBELxCyYK8MejXBuj/VXCaZZlShuziDLWbj9TfdwiyTgmjcIdLgI+/hVDJIhcRL8ALOma5VUL5Q2Bn/ru+/GDB4c28czDUHz6WqZHq3U2eJxY7bZxs5EwpvKPQd6NvFS8MSMjemN2G5i/PdmAtzy/7nu1gS8XQ1zrZ9z8nKUWrPlVfr/rk2oRvATWEgqwj9WFfp7JqiPh/cv2SAeHYJAEUUJ/DMfMjW0xwWMtxWA1CGigDLVkRg7upRxN+64sycw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by VI1PR04MB6909.eurprd04.prod.outlook.com (2603:10a6:803:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 10:28:23 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:28:23 +0000
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
Subject: [PATCH v6 net-next 06/15] net: enetc: add support for the "Update" operation to buffer pool table
Date: Sat,  9 May 2026 18:29:45 +0800
Message-Id: <20260509102954.4116624-7-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|VI1PR04MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: bce52976-25f0-4d8a-7765-08deadb5b268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AAYmqAb10gNgx+xm/ng+fLntjPF3Eaut0CNRdnpANPRBRj5PyEy7CeavQ9ePx1hDtV70qvOo7H24Jq9QKVaFp1HfCOxr2WDe+gNcV3hfzw+r8TvNfOsbA4qZGAd0y9r0z3+tsK1bWPbWlDZ4GX9TmUofT/TeD7MgIqfPUFQ76TXUEIq5CSn2FPQYsAedjXG8FEaphG1NaraQYk8bCsUs8jGe29nkntJx+X1mt5k1lsfIAUuyGjHg6Iv4f7AEKWShUS4+Tjs/EfBUTvxGWMznkCMF1T2BewPYAY/tf044M81iggMD5nR7vbgwH4PMQ3euEKluE46mLxUl/2ByWbbFexMHD0UKhSpMOJQ0oo35EQnmsQud38e6RhhJLnAOxafigM6Cn2KuiJW8DJoptkKKX12d6VXiO9Eum6+A5g5JWIDtosIiN8SosrGgds8wsHUtcM52/3YFLN3MOx5dHfM/2eexxblV976sOatJnQF3Jn2WJjSCSNPNRRr72ZTXn0rwM8Z6OJbGFXJJUL9jCkmg+V9i1qBdLuWsLUEWZTQm5QWTW+tQDatF2DPIduTNxiuq34U5D1H0FgN3lpZRCX3XAcnOwn3J2RC5g4Q373gs7bjxGVwFOsVgjFN7h84ROYLRCow1pnKGKlRzOKQR2OUbKt1W+plew3bhDPMVAZOAJE9YuQ9agiQoUrGOeGEIq1gMpxycUU9tmHT/D4EYP8aS5jScH2ij5VXwYM4ogpHrc4tD3UH5/bh56QcjpIf/yVcEESWCE4QJXWC+CEDwHOlsKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9DN/yFDS9Xq39/OmUkWCtZ3r9ET5FNmLaMsRhO8MiGj8KLDcyyjAlIfIG1+S?=
 =?us-ascii?Q?tFrmKK/qNTd/B5EyLVelzZe27rJqyhpQyi8MO2w8ky4aXYlPTB8CbuGVxF+g?=
 =?us-ascii?Q?aFm1CuPjd7rBD4DMkxu0CfeZ8YBUn0Kj4G3iEvo6aWs69ea3nbhQdHqbom4G?=
 =?us-ascii?Q?hwGNxziuRnUdwl3YvDZEwys3iNZSJ427MkqMCFN1tagCuQpfKRF2zmRLYrT7?=
 =?us-ascii?Q?ojlnnF1SooFEloK6JzBKdFWAxIEWGQ8HUcSlJcC8PbhuaGVmQwOhoGSrVw4K?=
 =?us-ascii?Q?iD18zSP5VjRLOxLMCxOyZ6/z5nc+oamqIwM9wfywx3VNaieRWp/9tqojR7Ef?=
 =?us-ascii?Q?emwbdj+pblYTPPeASc+Z8GuVAGutdQm/qmFvCwResY4S7yqokrahuvwcke+J?=
 =?us-ascii?Q?lli+HsjnlvNMfmq3VPSGzcPgn6PIJTj7JIPEvSEOUzBJL6ynNepipXO2vd7j?=
 =?us-ascii?Q?yXnbxPVXJbyKSFGXX365CKQwYy7Th26whvNM9dk9L+TS3Wc0/9gyevkY6NQq?=
 =?us-ascii?Q?91TSCicNwYLzZqqdVx1UpNejzpug6uWyTQy9hSR+fO6CZtg+pkwsX12XtQMS?=
 =?us-ascii?Q?HWdg7/PT3ZlVKLFNucsfoTb5O2AAD1sW+gHPuB+OA17o6QIk5VMA5FyaqYi2?=
 =?us-ascii?Q?s0SZv2592fgE2bWokbc13jiFzlsJCQO8KUDkR4GWxOXYoMjzlgXkaVTQ/N1n?=
 =?us-ascii?Q?8b63zbRuukLUFO7Ho+2+fPJFawuVirqrwjSFkUAFeO9N0gSv2kSM1ICYWhgo?=
 =?us-ascii?Q?gfpnFgGFUNTASo4t7FP5mi6kkiX0VsoGHDSjmkhJnfQNDqhCR2xbbbGK7FYC?=
 =?us-ascii?Q?drM0GsR6X6H/loxMvPhxAwb0e32jS2h6+INg/bjkzx645sJ+IFXRX95anPO5?=
 =?us-ascii?Q?OSOyl6N4LmqoqQM1bMcamgbW4RUz0GQLQiVz7jESbGHYLzVyt2QCJ9lIEK09?=
 =?us-ascii?Q?c61s6t3q8OYZyojQj51qBFDvJ+U/JGgGgvsx72g1D8C7kx+Q96hNG5up5kyH?=
 =?us-ascii?Q?IUZtjXNP3qw9jfA0hEBYb5ckKDKNgK01CZy4IUziwCCZ/9PtC9b7qDmTvqfI?=
 =?us-ascii?Q?VTldR+32b/OdtMdMgUap1i1U6t3LmDAobGRAFqiRzyX46yu1yk84EVcBcsjt?=
 =?us-ascii?Q?7EcTO/hpKcwzG+McaWTc5WCNFI9FqQDPcFFvVMqgscN3zeBBuMsbI7UWeRGb?=
 =?us-ascii?Q?7E+cnwL01AxVJUrLzJs06kyanoHW7zsGwkju5xvmkVBEaDOVSA3haSI5vUn5?=
 =?us-ascii?Q?SMkYna2BgSSog4/QlzpXBdLnosmgE30yFQtG9LqvlPu5ZoKqh3eQws5KkEIx?=
 =?us-ascii?Q?xbW6hxF/obWz9BAYzOfCVxg/ybOp+NxOu+ighFwybT5dx7A4Ja2fEsWYVwPa?=
 =?us-ascii?Q?EUg3eF59RR+/m55VcxYOPUQvZdHDd7zrHAW+6M9tQYvitdlJePNTnK/gh6Oq?=
 =?us-ascii?Q?MUGTfq0Yt+5m8U41sKGUh6TEff1exmzwz+ystNvLr13Hmqr76fEn0BW0oaGs?=
 =?us-ascii?Q?rGZFHCAr3B4Y5HSvC7H1LetO7kSMkBM1oqR7DfsxMgUwPFYjnWVl+uapk+Hg?=
 =?us-ascii?Q?819FLCUp7zXQu1g9cBWeYegL0VeUdcFtEGzgWtppAEjSeDqvLOxLlo/ld/Xi?=
 =?us-ascii?Q?Rd1zI1sKwvBveGjXW2jzmS/3jC4Kr4KWwkvl3NTtlgHbrSNis3aXSNmtzAtN?=
 =?us-ascii?Q?I0rZ8HuBrEqE1PmwpO/pIzuPCLXaXS7gw0EsDnVYRBBZ4ae2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce52976-25f0-4d8a-7765-08deadb5b268
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:28:23.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JN2G8rQ4VLG570K/O/73JYK43ViDKXd9Qs1jhyJ2+HVAcskBVbdC5vHq3oRN5wpLVT2LxB6VzIUdsy682SaNLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6909

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
index db74a9107975..ba80f5e08d80 100644
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
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
  * ID are not returned.
  */
@@ -271,6 +275,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_BPT_ID:
+		return "Buffer Pool Table";
 	default:
 		return "Unknown Table";
 	}
@@ -749,5 +755,38 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
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


