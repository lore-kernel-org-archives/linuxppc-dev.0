Return-Path: <linuxppc-dev+bounces-18226-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B251F4643B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:41:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ9880jFPz2ygp;
	Mon, 16 Mar 2026 20:41:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654072;
	cv=pass; b=hx59ySSvNHO3k3GPxP2FaawVDRHSLVbflcCxxVANSG2ylCy45Fk3BOeo0iw7VUOuKzeQsl4GWCn0/fRLKU4the3KXdapHsFy/nnMCjgBHqMywteIIsc/+CzJFEu9uyqVdMfH6D+6cMQVcn/Taq6jVcfmZr1zWL5AkskCYgwWyp6Bh74+PhZkNpdMKkujoDcAHFCsRHM9SNBpQVHT/mDVDhn1Hq078FDXHTGVPVPPNyGYIpDsMmQN6M+3BqMb6D6zB+Uk0e22L9lIdch9e6XNeRBIg3RaqZ28PZLBvDRuEc1btQpWWmrNgSMMrEeK2OrqzvYlrxIgR/G+E85SACJwUA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654072; c=relaxed/relaxed;
	bh=04MC9DKeiJNQWmiQVCBlARtp6YQElKTmx28dmv44TNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U0BQa7WcnGj0KiEirANx8OpiD9onRTho9u4RX//o5AeITtD4qEudFlJ8B2oQpzb5fxlodL+Cj959MYQNmPxMGCXY36ejdS+84lko2DxIuggEcXWBn37xp6a+JXqmhBabQrjJwEaeOwM6Lgjwg64vrZg0ohX1oo8e4xSoWKNWx1jr5TSflBFTBJ2jjEdzv6gfMhoguYCI3YtxEHFpYzCIR6/OW42vuT0AR9r/jbkV01X4Isgo7jzsSzEWc56NyFdHKFWKRKT1Q6QaWhAfJNVCI/BECZ9RSp0lm1LLX3GnAwMeuROEju+Vk53/hDeOCMV6j/2UQ5TRlZ6Ulyx0BG7MqA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=a5glrEsG; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=a5glrEsG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ9871zJfz2yr4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:41:11 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzqOqEJLL7ZaeKaN6PgcdwU6Lxup+OiXTDrvslLyG3gGb7MuzirBBQD54dpJtv/skEZHn2/vO+wS18RfGmCmgk9Lc4WPBUN4cPneqI+9S9pLydasprYx6rkx4Yz7fqzMD4gwrqNOQKK+DMfBYz48SmDFTVVhy7kgp5btpHjqqn9m/MEuMLvtJuzQT6iwA4//7zz/0E/hrNVkkkFPO/y2UgjV5QVZF7tMOj2x889QACLdJrFPsPICS6JcYbZYLYhAil6Q/LIjMHX0atr5lbO+G54cvNzlxYYlH58WZ8Laq9WN0+C0BCWeqCm/72C6he6KRexuNT0uxFBF8Oqw4lrJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04MC9DKeiJNQWmiQVCBlARtp6YQElKTmx28dmv44TNc=;
 b=bafAuxgdpzQOSOXRzXpcdZiasfCkZFTXEz9EC/kkorRHM4F5kOLT9hgjxyuvqPE4AwF2kTCRnHNlStpW+DA8uEkr42jVF9krPHs632kowHdp6sCQDR23oLo2/Bjpsd7KOe6AfWnJHOWJ/N9CBlHFDQyWln5mksP4Kd38IHdCJgbj2u4IVYZUf54lrHsjoIVUpltKwAhUhJl8bgMsR9z0P1xKfnpsfNQgpDVfPqRkwkP2fYUTIo5FJK+TcinXj22rXQzZMAO7TYYLqGfEZrhT1FJWPlt+V70zD8zZ/t6yetJFLy7et246zbNJZ83BfJZBGPPewjotEFjscT9iN0iS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04MC9DKeiJNQWmiQVCBlARtp6YQElKTmx28dmv44TNc=;
 b=a5glrEsG6VI/1zHgeivWWTWBBrLKpuTq0jH4c895HiN8Vs8kq5ZKywELsji0TINwGrwo4PV8jsNpLLJsVcR1h8VR2lXi47ORUSdAYzHhm6tEdnoFiJ+ArhUTtKhT8IGVyVLNS9v0jip7XJEczsmA4dOVVghNlMjY4RI1R5hfpKTUrbnrzix8Wk7e9UO3NHRjUIiJexCa67hngjyzp5uq/o2IgWBVpVYC108hjB4vG/9ZuZ3voaEfyb+ItBxA7vnPx6BvPiWAhDSs0DUyaMl/TKsgKuc2aHZ3cnHxdgNNRjlmwmKX99VCaszkSzCYfWyHr1DT7uab+bVKIFuSXNUzoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:40:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:41:07 +0000
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
Subject: [PATCH net-next 06/14] net: enetc: add support for the "Update" operation to buffer pool table
Date: Mon, 16 Mar 2026 17:41:44 +0800
Message-Id: <20260316094152.1558671-7-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316094152.1558671-1-wei.fang@nxp.com>
References: <20260316094152.1558671-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: e724a50d-38ff-4e67-2986-08de8340260c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|921020|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o0GJ5lejY+58myFOWQbb94OY+9B0z4C2H7EcmBsdm6BpcZVRB91LBl4Ffu4LLT/VYVozVP0c5j6AmSTPJTDOsXb0nvLrZh/82VV+wvVG6JxO62o90svBR5fyXEfAQg4YxaRCXXLU+EtXAUbB7VNbbArRNnJLjD+Laya/x1DSQjfLT3M8r2osgAIu9v/7g6pCtlIhQ4M+kgjVF7Jux8tObuD4i0Oxgtb/BAQ7pzDADC4ClOqRiq2FtkoRzZDN1HgftyvMqdaeRxSns3bcqUCIQpifEyef8qL2Qsqx3+SE5ZPZ1fDwtcyd6iFPxOFyHtFAnFZZ0oclE3pgaQNyWqWOZ/g/3V0e49v9FBLViB3NRh40/L/JwmokVEVFWJPoa/AV/dSbzSVto8L39cYz+4TMzv3y/yO/hE4PdLD6LRaUWlSf5WJl1XGpemermz2WwU3QmmQP+twjnxAydH4H+EiWYfPlsmMAISe9YwbP1f7EwJ+Rybdpqdnwf3nMLfxWAVLKRco56tbnqVX4RunkzyT2JfXFzc9q+IaMOY2+knnSyklJBnyrB2OrwhJUHmD/x368/Fd/o6Mh12fk8mCAbYZ1AB0AP9kDsN42mdiV7Og4xJaseMH8bLvd5Nsomu+EXUAOO2RvliD+YGLeEBulAdho0w8sq4c0naR1lHt5tz605k2YtOG0WQNfsrpxlk1rGblhjF1WRHjUiwqH0H/DGtRRiQiTZYcW2fiQoWhrqRdPpGhLLXFStkhbrrVdBnDOWZ8j7Vm5L6B0tlYM2AtV5QHhSpXT+9/zuq91Ixn6whmMdsnuZhdm02pxS7FEGE97fR0r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/cfXuZYOdf41PnChB7Gf/6bB+9lB+LeR/YuAsU1mGs9qA2neygHd2a3/c5PO?=
 =?us-ascii?Q?FwD34VcbSbao3XmCq+TqTON9HqjGolOHvAD3q5pyP5xE7wb0rmkH4Vx3559y?=
 =?us-ascii?Q?rFev5jkv0mcG85hB+42wHMQN3IvrF+38atSUapFCMnsmatM2oEEQ0Yz0p49q?=
 =?us-ascii?Q?5ELz02bXftx8WhYL7hyGlpkjvYnU2EnkM2hCsHoqte1Ax1MGcY13M/65SJ48?=
 =?us-ascii?Q?xSp4ilVJCSVQTh2q/CX2Da1DSSzKKr01zpzweItQTsoIvKm8fVvg9LiErAj7?=
 =?us-ascii?Q?NV20zmD4FmEZ6CYy8MYKtfCEqOkT3tmiQFEXyr6RQHjDs9PGPetEsYdGMY0Q?=
 =?us-ascii?Q?HZktSXqfbezngs7S4wA/3UPO2AHGr2kyNWexRd/wRUjjxOYL7icJza2iR2Ke?=
 =?us-ascii?Q?/w+FkgKI40ir1ExoaBDVDWd0uesRURYzIfjUsnKlEBWOM1dS034saN7+FK6R?=
 =?us-ascii?Q?EjAscWQ19m7zY5ECz3uIgW2QIHS7m/En2Y8ErKEPjBqoDmakjaXOXODM2WO5?=
 =?us-ascii?Q?+cYTwxZ5jEOgJCrDyEE6Tfvhzj57HgNpw/7AZ/m6NutPcIf7cCXFvq3LnDSm?=
 =?us-ascii?Q?HddvzyMbaCFH1mHLAeOz9oItKgg7PkIZCiG4mF3v/J7NGN/U3JN8I3VnP7Pl?=
 =?us-ascii?Q?8A1AX+1ixmEeFPtExNwaVwqmB1RSwH20tXF8m/eD3num9f/oj2Az7p5hzKt5?=
 =?us-ascii?Q?n3wRH9IfYlIRxfuF4ne2ZGwbJ5D5rVh+sEX0++Gvvinv3tCA1Zt7YHFiD2vt?=
 =?us-ascii?Q?o8bozOFqT0Vo7xlu2DrwqC+9sH8WKGfhEVuBmEQe14S6803dqAaIAQ8OiTZI?=
 =?us-ascii?Q?q0YuZz6Ukr7lX3FIhkC4mV24WjcHCTvB7TFobtcz7hdLSKHXX2NmoWXIkM4Y?=
 =?us-ascii?Q?E9xb7GT8f3UrF0D6/rO0tHQ7fihj7QR7/cCRfYvYz2JrTXrCMFHSwjT+PIvQ?=
 =?us-ascii?Q?9arBVmvoJNob+josUkzoCsWskvwHC+5XrEiI8n01ymcCvaBGmZO+WdAdTYHN?=
 =?us-ascii?Q?bMTmC7AdZZCFUHQlAJpjmtbY74d0gFijqSLOQjW6KJuFBZW6aqfhH02Ph+fs?=
 =?us-ascii?Q?aHExQg8FdwZOrCg66WRrh/1ICKAWjtOcfKxvn4EQt4o4Mf1t4MPRHTSDnezF?=
 =?us-ascii?Q?xDIpX5XsUdE9ktf9Dnw2g1ZK2bjN11vD/iF9La58/UOwcSMJUKqH2+h11+x9?=
 =?us-ascii?Q?9U8LLUvtqdUS7NAJjqMgLCKhhbF8q29u7jBN8vXa5vdlZRM0xZBe+zOTssin?=
 =?us-ascii?Q?Xi1mdp1EpNCNrt8M7taWqUvM9zKZjMk5ozUeqaf8vml6zzle/RkSXJKXPGjR?=
 =?us-ascii?Q?hLQugXdJsxpl2HuY27uGRiBNZJztax+s2lyA4QVzEJ6EumEU+EZPwoJYpxWG?=
 =?us-ascii?Q?05Ap4k+rw/uzm3LNgKQVKeGMw8XZOsH2RvApmqUFT9Q1hCmrgf81S7DV5m4o?=
 =?us-ascii?Q?TyFL4QYBcnKOARqjTbuVKW7kzSnDDIHsRNSjFUUP9eLRF7e+ju8U8iGJcdNZ?=
 =?us-ascii?Q?m11GkdiDTNGTU2mFFZUKEt/VGklPOO9E9vb5j72yYa0jN8guckfexZASDXmC?=
 =?us-ascii?Q?wwx6xvCyR7MPWbxpGzF7n+o2PbybVfHLtocn81bwsMGWuH0WRXR4ghaX3rnH?=
 =?us-ascii?Q?Y6e66d/4uCfC44FOWzpFd36CmIyf5IEMHAF4TcQlILtZoLZqe/HBAH4TMKt+?=
 =?us-ascii?Q?Ub63g4VW+rI36gQja7Q357+GnKceqtKYHPfFRpEk0LNCgPzI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e724a50d-38ff-4e67-2986-08de8340260c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:41:07.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0sY79jDZ8PQv7YYQG7lgCGbdg862XKVmGbOOuEVsQtNHF0JNMqD5jYZvlpRti5mUhrFNaPfMOuYitiZcSfVYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195

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
 include/linux/fsl/ntmp.h                      | 32 +++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index e8c94157ceb1..ef38ebe94da8 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -22,11 +22,15 @@
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
 
@@ -234,6 +238,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "FDB Table";
 	case NTMP_VFT_ID:
 		return "VLAN Filter Table";
+	case NTMP_BPT_ID:
+		return "Buffer Pool Table";
 	default:
 		return "Unknown Table";
 	}
@@ -702,5 +708,38 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
 
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct bpt_req_update),
+	};
+	struct bpt_req_update *req;
+	union netc_cbd cbd;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	ntmp_fill_crd_eid(&req->rbe, user->tbl.bpt_ver, 0,
+			  NTMP_GEN_UA_CFGEU | BPT_UA_BPSEU, entry_id);
+	req->cfge = *cfge;
+	ntmp_fill_request_hdr(&cbd, data.dma, NTMP_LEN(data.size, 0),
+			      NTMP_BPT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_BPT_ID), entry_id, ERR_PTR(err));
+
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_bpt_update_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 8f94572eaf0d..c5f6dca7b660 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -179,4 +179,10 @@ struct vft_req_ua {
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
index 6fb2c8c525de..925a455935b0 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -33,6 +33,7 @@ struct netc_tbl_vers {
 	u8 rsst_ver;
 	u8 fdbt_ver;
 	u8 vft_ver;
+	u8 bpt_ver;
 };
 
 struct netc_cbdr {
@@ -116,6 +117,29 @@ struct vft_cfge_data {
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
@@ -142,6 +166,8 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				struct fdbt_entry_data *entry);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
+int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+			  const struct bpt_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
@@ -213,6 +239,12 @@ static inline int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 	return 0;
 }
 
+static inline int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
+					const struct bpt_cfge_data *cfge)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.34.1


