Return-Path: <linuxppc-dev+bounces-18225-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FE1F4643A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 09:41:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ987097Yz2yqf;
	Mon, 16 Mar 2026 20:41:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654070;
	cv=pass; b=Ub/t9H5qRVi6NKWCRs0+xz05DIIWkHqdBOhQEYvgwpyKJbHY4i9b/dQYzqx00TdCfka5nGin71P0sUZOpvsMDfZkjRLq84XQ2+k+/ZC8NcsxmQ3FxsnUZUGqeQHUrnJiJJ60kHHvfkXF2V6uLKFFBBdaYc83gHmku63sAI4zdq25Ei5gJY8MAltLgBlV5+TKsc5m0bzfT5SeXt9oHqYa0Z2rpoZkxO6H4rytdF2yZtiZteAHHkVJ6DesMXSOyDff2rM8Y2CDEEOY7UuTkMnQeIF//DVTFqsGp4uC556tFaWIIadUCimInB+YfTbJQU8HQu11LIDrg4rHuO/3DGxbjw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654070; c=relaxed/relaxed;
	bh=Biz3Z8TYdAr8j8h6kXOQCq+Y3rJg0Nc/Tp8eWGxfvXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YTuvTeGLNlJ0vidULvIZrBktBpH/nviSg9OuqfgJQUlr7ASM0i0n62+Xlrr8oCe7ng7AquFJd5GTTsWdDPD42WG1DOpNyl7HULmriazT4tXL343iIYtWokjYMsWXxxyYfangp/LH7J9rNogapi8OjSzAZSApGrcbFSwD8VTX8LCPrkIIxq8D/qpACC13tzWngZOjxMRe9K47BfcLMVKljzY/naAiYYUd+OICsYz/WHKzUzJ8jySRGPXJX/WBGbZ9t3urlpYEh+Eqh902LwAXyjzhW4S+wUP0wxblloIzQbYKbYgvbPAfy94xgM7LGiQRgZalp8ZDYQ3jGlqfvWIk2Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=J+hESxjL; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=J+hESxjL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ9861SkSz2ygp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 20:41:10 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGAz8j3uF0DDFpyZhNYNXDMzwHTzHAUqe3WhbW1xXd0ZA3uo2+EWVTNia4BusnziD6cOTOsV1dZACeaQF19emTn7T89VgiK5MVH68XHlQIjv6RZIeezw+5u8w3AzScz3BjkOKrSvHC6Q9bynsQ6tuEUhac7Hx56hfcJvQWaMmXcP1Rsoc70JgVusRIgSUDuF7eqKz/V5Cm0Rgl2HpDB9YNGGD/lsyDqpzQUrtK57mtn8QlG7aC1/H9TuGQn9S6SW8m+w1XFJpLS4N9gXC31EIXGSkgMK6KZpXboZu1gsqEZYsJeNe3OQSQIsTreg1DNC8UizY1UvQOfuuaGwP5ZkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Biz3Z8TYdAr8j8h6kXOQCq+Y3rJg0Nc/Tp8eWGxfvXE=;
 b=Mu+pOrJrHe/OIXs3XeEjxuCzHgeCdQ/jsCXp0/QqLq8R1B43JiICkvzFavmQNXnmPjAiYeUpSlCKHBOsyl5oVjABwM0mUAr5E+pIA2Az98wdX6rTv60eo1ZFyeX6lidx6yTaNvZFoz81+ZgBkSeS7crslU6mfc1j6jcWs0b7m/8nanXY9WiTKu84GP/+dDFxTTNNOGfzoiifV4GVLfi5n9sKBqXUQ1hj9C6qpywSBchUvId7DzJglEgBCX4zMcdu5fuD3PUS9IPBz86sxT8TbhiGCU2zshtt5XcFMefUYVsU48SNvzwEWaDis4CtrrvzoKmCyB/2CZeRXmCr74jmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Biz3Z8TYdAr8j8h6kXOQCq+Y3rJg0Nc/Tp8eWGxfvXE=;
 b=J+hESxjLfqCjiZPFOun5UHR+HFFiNB7fq25YZbiBPKa9FA6rg0jX8TP/4i3FwWJAIa1/P17Bj8zIIHlY5DQsjzJyCktF9h3SfRIfU9xldTtWN2IwUn1jGUALT3WpGruIcC6YydzJlrZXduruDsQCn410TxF3Ov+hPiznXCUUj0LsfgTz31nDNLY2g9EkFZxzHuDFbqfqLIBASV+Ir1Pb4JK2NoBQuLU55zVlp//qFByFNPJXInPii06wt/HpvJG8WfAuWzSK5/Go0JTiTR64RqpCDMDYYDp0vQJMoLqeI73ticRQAfyRj8dO8j3BrYM/FNOJ3/whc4GRNMsNvWMwkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 09:40:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 09:40:54 +0000
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
Subject: [PATCH net-next 04/14] net: enetc: add basic operations to the FDB table
Date: Mon, 16 Mar 2026 17:41:42 +0800
Message-Id: <20260316094152.1558671-5-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f4333f8c-5fda-4f90-cf07-08de83401e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|52116014|921020|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	up1Y3RPICzJG3toBQTf3asay6+Uvrw5EjI10Bi7iPU2zCDauXx0Wi3yVidvOjwEN/CYHJSsJOwflA55pnrIhgtgSUrv534Uwa/R0GtPnJycMA5gCqoy2zy9BGDREVr+ZrpPckznsRwLrD5yiKNKM3VFoiZMqwW0e0pZYCcHdhy8nt6+KpK1M0AUke8xFuPNQTFpF2z1fMr6zf8h6yiEufrmOMnP79prA7KsGz9wyOY+LC5/cxXTLllt00I8Vs8NKLAXkm3WblShVUOlYNoHzICHX4LBgdfQMUQRxv19Js4YvxgUZg8aD1+oyPBAZj1zx8GIpdyae2Me5OeSM8E0EKLtk/dlPUCvBlzqOwvKRjk1Z62d8dBIU6uss5ncu7NJPcDKa0c+BroTgwMIeRZLVvzAZTJSHq0Ugp4EJcHG3lurF81tBInSZyLEWAXuowY4Jt+5TdeaookxvH/roonJHLJQQ3XNX3NkRuDXLAaNne99367PDSlV3a7NCoFr9w/rT4r3xxTigM+/KTJ5U30HovkydfvmM+exsHyrRgGskEhNvZNKTLf1UAgKp3xTNFKUMsLT25jCnnTLC4LEUaAwYnAmnUe2CGfkcA1OqSKAHzQ+aA5VNszn74eul0qdBXvYVDiZYrYkRdQZhNoKKLgFjGpg/b28LHS0YjNURAXVo7RjZYVW9xiEkuoGl7Rnbc7OMqLxamwk92/YKI/fxhbj6JnV4c6ncB8YzA+fiaT8yAii+tD0pOaazfklJpjNnt+0uouGv056E6OUssJkxqMUgH9G257tzoIa4jHcYGOLUF6bjABt4h8H10Lxelq8bQVOx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Ck0uEHuRNCx9s68Pdajpryu2yoKGjjKuqrCAFgfyMaYbpg+6730surHtF6/?=
 =?us-ascii?Q?v7PssOD3ha8/hAYrxSaOTlabM0TN2ZRFZXynU7GfCO1MJLVBkFTSvaAiKCXp?=
 =?us-ascii?Q?dI93j0OJfOtv3oDJ8hTVBZz11h326Q9OLs0pOsWp+oj7VN1+CUT7uwRG/KV8?=
 =?us-ascii?Q?H12qnXHExy0pFx9ubau7gVLF89y2MTqb4C5fLM2tO7I+3mndwUSwkeI7MsJM?=
 =?us-ascii?Q?/CR2CEjLgZDhlSUC/W4cu1Sc4MJdJXj+jEkRsNUPSDDJId6pDSEkM/8TXjVK?=
 =?us-ascii?Q?yzliaClKl9waDLMW9WpvEuEs+3K7ici9GHGHcpomdV09AlkHT6izaVK6/Qpd?=
 =?us-ascii?Q?4oRNtD6PKb76SGFZ1/MdkSaDbiuP6gCHtamWDEgUp18yPt3jHE8WvbjfIXpc?=
 =?us-ascii?Q?v4c9RDIYyUZlhzt4k71aOblGQGDWtEtuaTYtCYnfBu4Wm+il46+aIFei41QS?=
 =?us-ascii?Q?8rm7oYbgtFTmAldXURDkZERbl7Xe4izpGcsQFd02QBs+3XPyCzR+AFHALk/j?=
 =?us-ascii?Q?JKRumk1m64IceLqLJ+esXXeKJ4YhjUlp2WfQKlpylcT3+voAqLIaNOi1/Koe?=
 =?us-ascii?Q?GXwrfEAbOMURd8U0f4s0Q4w0jM5/1evKtsfLIW6N0Wn31t0QH7a8aEnWOpSA?=
 =?us-ascii?Q?5xIVQj3AHp5VKLsTpyYc/JBld1fCAabqAyTCHSFI4VyP9LT/4iC2xQgo9Yvy?=
 =?us-ascii?Q?s9yhbEW6Qi0mnkktJxQwerTqAxRIcHTZEJ6VDP5EBdAj62fWVVifDWI70EO3?=
 =?us-ascii?Q?6MPmiNr+qFP/nWfIYNZKE4JRGJtiTTQodf6aCUWzbaiVlj/8553Fk2w/Nc7m?=
 =?us-ascii?Q?aCH9lVkQfoB9og9PR/PBVjilkTZ3EAmI8ol059FG9hx+f2+cc18xLRbaWBwc?=
 =?us-ascii?Q?WeMU9hI4SPnyT0WxkAXbl/UvdzJDVYTRtu3uCnf6VqXJRVQOoYSdQvHQlM2P?=
 =?us-ascii?Q?f4Hbec+FIBwBWb9NWfA1vEfg1WiwGGnYAAGGiRz9ygB4V1CCrUtptNqNLtSj?=
 =?us-ascii?Q?WxU4B6Jc0zuROMFW5w48nl7zpif8FlHabzPxFcQM0iR+5N/nRtBQ/7JkmzZF?=
 =?us-ascii?Q?a9DspzR0JnOR5dx8yHxA5t5G+rl6JCCEzIxTpakEIcQp/3c3mRgwpkDU1P33?=
 =?us-ascii?Q?Iw1fAKfTkA/3oWF/NE+0N4AuA9w+QpDKrTUn8/R//0/bY3ZM5p7T5wt7kvVa?=
 =?us-ascii?Q?wcUNvNk9hqLjrU+PSmJMTEayKV02ntvMjXQtQUtNbxq9dGwV+zsmUkDuhH6e?=
 =?us-ascii?Q?QfrCqDuFV+Z3GDOXP6hk5m9odS+l348OvGcHEshueoCFjUmHcLtrbJq5mIAw?=
 =?us-ascii?Q?/hd5TJx6l+NcRFBj/6Ea54r/XOoM1kSkQH1Sjveojo2HkCYmNpjvdaa/Uh+O?=
 =?us-ascii?Q?QaclSqrl6VsRoIkFZ3ESITwNIP1TyiHjO75IXpf9mNOGdwwFrvzlj9xIprKU?=
 =?us-ascii?Q?l0S0h6K66kvuDFENmeUkrb+/RTziqgljlc0BHZ+32K7ir62KFD626QiMbsnW?=
 =?us-ascii?Q?YilHnU50R4XxA3bv311DCfAr7xjbmlF1oz+0Uxn3Y0CGmK3CcP2a7OD3ue2o?=
 =?us-ascii?Q?fZ+65e2Ezjyb1I1jKVMT52JzIJCPr+9p03ZPNYEW3s/xFJdJMYGt255utjIN?=
 =?us-ascii?Q?lEbJ2gcw7CRs1TxL0Yt55cZp1k7vmQ3hoXcZ/rbmcVmOpNmJCo/wOgw3MP7i?=
 =?us-ascii?Q?oxGXSHge2JP/eDzeQV2bQj8VW1eV2UfPTih3hZnwQLYpqQaE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4333f8c-5fda-4f90-cf07-08de83401e0d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:40:54.1690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJWiuLQdLhvl/TdcQg3gD3RCrvId2IE/6KgqGqawL1U40GhlquP1wEbaQJVOAzBXyZvDlpifPMPCkG5wZf2oCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195

The FDB table is used for MAC learning lookups and MAC forwarding lookups.
Each table entry includes information such as a FID and MAC address that
may be unicast or multicast and a forwarding destination field containing
a port bitmap identifying the associated port(s) with the MAC address.
FDB table entries can be static or dynamic. Static entries are added from
software whereby dynamic entries are added either by software or by the
hardware as MAC addresses are learned in the datapath.

The FDB table can only be managed by the command BD ring using table
management protocol version 2.0. Table management command operations Add,
Delete, Update and Query are supported. And the FDB table supports three
access methods: Entry ID, Exact Match Key Element and Search. This patch
adds the following basic supports to the FDB table.

ntmp_fdbt_update_entry() - update the configuration element data of a
specified FDB entry

ntmp_fdbt_delete_entry() - delete a specified FDB entry

ntmp_fdbt_add_entry() - add an entry into the FDB table

ntmp_fdbt_search_port_entry() - Search the FDB entry on the specified
port based on RESUME_ENTRY_ID.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 199 ++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  59 ++++++
 include/linux/fsl/ntmp.h                      |  67 ++++++
 3 files changed, 325 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 703752995e93..f6f4316169b6 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -20,11 +20,15 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_FDBT_ID			15
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
+/* Query Action: 0: Full query, 1: Only query entry ID */
+#define NTMP_QA_ENTRY_ID		1
+
 #define NTMP_ENTRY_ID_SIZE		4
 #define RSST_ENTRY_NUM			64
 #define RSST_STSE_DATA_SIZE(n)		((n) * 8)
@@ -225,6 +229,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_FDBT_ID:
+		return "FDB Table";
 	default:
 		return "Unknown Table";
 	}
@@ -453,5 +459,198 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
 
+/**
+ * ntmp_fdbt_add_entry - add an entry into the FDB table
+ * @user: target ntmp_user struct
+ * @entry_id: returned value, the entry ID of the new added entry
+ * @keye: key element data
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct fdbt_req_ua),
+	};
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.keye = *keye;
+	req->cfge = *cfge;
+
+	len = NTMP_LEN(data.size, sizeof(*resp));
+	/* The entry ID is allotted by hardware, so we need to perform
+	 * a query action after the add action to get the entry ID from
+	 * hardware.
+	 */
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_EXACT_KEY);
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+		goto end;
+	}
+
+	if (entry_id) {
+		resp = (struct fdbt_resp_query *)req;
+		*entry_id = le32_to_cpu(resp->entry_id);
+	}
+
+end:
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_add_entry);
+
+/**
+ * ntmp_fdbt_update_entry - update the configuration element data of the
+ * specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified entry ID of the FDB table
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct fdbt_req_ua),
+	};
+	struct fdbt_req_ua *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, NTMP_GEN_UA_CFGEU);
+	req->ak.eid.entry_id = cpu_to_le32(entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(data.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err)
+		dev_err(user->dev, "Failed to update %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_entry);
+
+/**
+ * ntmp_fdbt_delete_entry - delete the specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified ID of the FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	u32 req_len = sizeof(struct fdbt_req_qd);
+
+	return ntmp_delete_entry_by_id(user, NTMP_FDBT_ID,
+				       user->tbl.fdbt_ver,
+				       entry_id, req_len,
+				       NTMP_STATUS_RESP_LEN);
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_entry);
+
+/**
+ * ntmp_fdbt_search_port_entry - Search the FDB entry on the specified
+ * port based on RESUME_ENTRY_ID
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ * @resume_entry_id: it is both an input and an output. As an input, it
+ * represents the FDB entry ID to be searched. If it is a NULL entry ID,
+ * it indicates that the first FDB entry for that port is being searched.
+ * As an output, it represents the next FDB entry ID to be searched.
+ * @entry: returned value, the response data of the searched FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry)
+{
+	struct ntmp_dma_buf data = {
+		.dev = user->dev,
+		.size = sizeof(struct fdbt_req_qd),
+	};
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_qd *req;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	err = ntmp_alloc_data_mem(&data, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(*resume_entry_id);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	/* Match CFGE_DATA[PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(data.size, sizeof(*resp));
+	ntmp_fill_request_hdr(&cbd, data.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_QUERY, NTMP_AM_SEARCH);
+
+	err = netc_xmit_ntmp_cmd(user, &cbd);
+	if (err) {
+		dev_err(user->dev,
+			"Failed to search %s entry on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+		goto end;
+	}
+
+	if (!cbd.resp_hdr.num_matched) {
+		entry->entry_id = NTMP_NULL_ENTRY_ID;
+		*resume_entry_id = NTMP_NULL_ENTRY_ID;
+		goto end;
+	}
+
+	resp = (struct fdbt_resp_query *)req;
+	*resume_entry_id = le32_to_cpu(resp->status);
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+	entry->keye = resp->keye;
+	entry->cfge = resp->cfge;
+	entry->acte = resp->acte;
+
+end:
+	ntmp_free_data_mem(&data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 34394e40fddd..9e2a18cf3507 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -11,6 +11,7 @@
 #include <linux/fsl/ntmp.h>
 
 #define NTMP_EID_REQ_LEN	8
+#define NTMP_STATUS_RESP_LEN	4
 #define NETC_CBDR_BD_NUM	256
 
 union netc_cbd {
@@ -27,6 +28,7 @@ union netc_cbd {
 #define NTMP_CMD_QUERY		BIT(2)
 #define NTMP_CMD_ADD		BIT(3)
 #define NTMP_CMD_QU		(NTMP_CMD_QUERY | NTMP_CMD_UPDATE)
+#define NTMP_CMD_AQ		(NTMP_CMD_ADD | NTMP_CMD_QUERY)
 		u8 access_method;
 #define NTMP_ACCESS_METHOD	GENMASK(7, 4)
 #define NTMP_AM_ENTRY_ID	0
@@ -101,4 +103,61 @@ struct rsst_req_update {
 	u8 groups[];
 };
 
+/* Access Key Format of FDB Table */
+struct fdbt_ak_eid {
+	__le32 entry_id;
+	__le32 resv[7];
+};
+
+struct fdbt_ak_exact {
+	struct fdbt_keye_data keye;
+	__le32 resv[5];
+};
+
+struct fdbt_ak_search {
+	__le32 resume_eid;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 keye_mc;
+#define FDBT_KEYE_MAC		GENMASK(1, 0)
+	u8 cfge_mc;
+#define FDBT_CFGE_MC		GENMASK(2, 0)
+#define FDBT_CFGE_MC_ANY		0
+#define FDBT_CFGE_MC_DYNAMIC		1
+#define FDBT_CFGE_MC_PORT_BITMAP	2
+#define FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP	3
+	u8 acte_mc;
+#define FDBT_ACTE_MC		BIT(0)
+};
+
+union fdbt_access_key {
+	struct fdbt_ak_eid eid;
+	struct fdbt_ak_exact exact;
+	struct fdbt_ak_search search;
+};
+
+/* FDB Table Request Data Buffer Format of Update and Add actions */
+struct fdbt_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+	struct fdbt_cfge_data cfge;
+};
+
+/* FDB Table Request Data Buffer Format of Query and Delete actions */
+struct fdbt_req_qd {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+};
+
+/* FDB Table Response Data Buffer Format of Query action */
+struct fdbt_resp_query {
+	__le32 status;
+	__le32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 resv[3];
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 916dc4fe7de3..ba56d4ae0ff4 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -6,6 +6,8 @@
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
 
+#define NTMP_NULL_ENTRY_ID		0xffffffffU
+
 struct maft_keye_data {
 	u8 mac_addr[ETH_ALEN];
 	__le16 resv;
@@ -29,6 +31,7 @@ struct netc_cbdr_regs {
 struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
+	u8 fdbt_ver;
 };
 
 struct netc_cbdr {
@@ -61,6 +64,36 @@ struct maft_entry_data {
 	struct maft_cfge_data cfge;
 };
 
+struct fdbt_keye_data {
+	u8 mac_addr[ETH_ALEN]; /* big-endian */
+	__le16 resv0;
+	__le16 fid;
+#define FDBT_FID		GENMASK(11, 0)
+	__le16 resv1;
+};
+
+struct fdbt_cfge_data {
+	__le32 port_bitmap;
+#define FDBT_PORT_BITMAP	GENMASK(23, 0)
+	__le32 cfg;
+#define FDBT_OETEID		GENMASK(1, 0)
+#define FDBT_EPORT		GENMASK(6, 2)
+#define FDBT_IMIRE		BIT(7)
+#define FDBT_CTD		GENMASK(10, 9)
+#define FDBT_DYNAMIC		BIT(11)
+#define FDBT_TIMECAPE		BIT(12)
+	__le32 et_eid;
+};
+
+struct fdbt_entry_data {
+	u32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+#define FDBT_ACT_CNT		GENMASK(6, 0)
+#define FDBT_ACT_FLAG		BIT(7)
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -76,6 +109,15 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
@@ -116,6 +158,31 @@ static inline int ntmp_rsst_query_entry(struct ntmp_user *user,
 	return 0;
 }
 
+static inline int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+				      const struct fdbt_keye_data *keye,
+				      const struct fdbt_cfge_data *data)
+{
+	return 0;
+}
+
+static inline int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+					 const struct fdbt_cfge_data *cfge)
+{
+	return 0;
+}
+
+static inline int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	return 0;
+}
+
+static inline int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+					      u32 *resume_entry_id,
+					      struct fdbt_entry_data *entry)
+{
+	return 0;
+}
+
 #endif
 
 #endif
-- 
2.34.1


