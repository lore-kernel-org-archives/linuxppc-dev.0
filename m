Return-Path: <linuxppc-dev+bounces-21570-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EEDCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 12:12:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQT5H5J97z2yft;
	Wed, 27 May 2026 22:12:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779875993;
	cv=pass; b=NEJNzLJ539bvDkUFh1COKUOPcKykRLwHoqz7Zu51dS6Sp9rOjHpdJ1frolM9fjhQyTwE0OuC7oZc8m0NASgCi0G6lOPbbQ0HYZ2++2W7hqpOKv5ejE8+iflNoPpbuTOr67/7BeHUmswJrVAlDS7kHsXUk3L+3s75IzRYTtmgUQELByntNtyU4P2UfSZKiXcILFAIXNplw/BFlAxpMAsqhY1euWtW7lGpCF/kjV0YQxJ5xcvaMvnCbQy2hoQl+3oTQjFURGNXkyzuEkeH5tmEypsfrmUBVMP5RSNXpOhbgIDsj/gh1iiVZeazm0240jxlZ/rYwQEJayLEhlZ85LaKtQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779875993; c=relaxed/relaxed;
	bh=wm7uZcoRi2b+y6XgWskw0ORBYgR1sjxcFzUcNDwCcz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NU/UGBot4L23cjsyOX+YDsct+0yJBhxsvrwfLeZ80S8AOxgZieUEOFc09A8eSPH2e3XuGXLjHrMHBr0IrNjUi3rSCK8AhpoVvIQy946sYl7buDHMSl92+yunW0iWY/Wy6n1FDl+x+Igjat1FhSA010E51hJk4Wx0DZWVDnz7q4lR/AVwYW/X/fCOZIPk6kLOpbp4XvzeOxh7h9KjBZai4nxHe/LgaeONtCbQwI4NwuS/ARVB1lqAHo/43HbPBcGikZhYk3rk4KpNOAXrz+rjwkvh6b60C9cPrZaMUCUpJRNohFrombP9lwgZICu/5cAJd0M+onxezstRL4DJw/mTVg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=T2yj8WED; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=T2yj8WED;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQQ8S4ynbz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 19:59:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUZJziZtDCf/RQUWLRrh1Hmwd6rrYKVFKpFKpbYcVo8JnjvRLfHuqcoNdhVYvRH6CkuYAsWY5vwa6rrQo1gCMT1lgR8b5HWgHZ1JY7pFAzWp7uC3t65Yhdl3/Y1KAVkvzQQ09/KSnVIRfOJUpgrDpkS43z9+42fGWyQr3tIDznf/9/xLyn/0Tm1b1dtFBW422cl+MQJk1FFl+YAYQ+9X2+2FmCcdPsCFVujzc3GgdB+BalAnsZffigYn3Oth+7KEgKcF1yZMyuTG1nGFuihgkGtBG5KDrJ09NObyNvuCOFAZdQzGjriSLpz1yOyEU4OpDCHsv/At6fJZNwllKMUKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm7uZcoRi2b+y6XgWskw0ORBYgR1sjxcFzUcNDwCcz4=;
 b=p/o4e5O3wGpJVTNwSt8XAuBM6bQdbGds5QImcwr3/lbx0j8ISzpfV7e4s0V5TxM4IytB6JDBcpsZDPZTIPidvbb5vOEOu1F6ZHQEREHYjwWadQYblKK4+ih3Ykoumq9en/6QrtOD3XKIVwQvoOa/zvQGSJhKHot71Ktze6M0uS9GWQOyEquvjhsFvRZ8ibpUYU4u8wftU6Ma6zv0md4pgABFWNtyD7wA/jjY1RXNSbEUS/iM3vxlJe7pLDabNSfdaVqXZ8wGOaIDnUQgKDf7Rqd01PXwb+Tshn0D92bP2NeWOR/pKVKVh3HnzQSgyve2xBksUYd0Nr5EJtbRtWzdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm7uZcoRi2b+y6XgWskw0ORBYgR1sjxcFzUcNDwCcz4=;
 b=T2yj8WED2Hhy7/RsbR+kqa87QBpUzvJ0nf+83qKOLLgo1wyUsY0i8kNpuW2Q5cC+7i5hIELSwOM79ZBYaY6F2WP8TDY8FlzxZVvTRXM+W57kbljioHyxAov0xbkgW/D45egkVjjDta3SsKW2cCrP3+S62+VrI9PISaLgx0cxKSsiIITLZs0/i+OHNiNLx1k+4eUd+MSYRthe9js0q1nPv7V+hU5jSCH7DXMD8aMMBhN+5pwYS8ksYei0yisVlsF3ruSdZeM+hlEY2XVjyE5Kv2rnKETu+q97kkRHPCwd7lPfRQ9K/nuXhe8H9seRsRao3RiArMF1p8AFRoMoePhTBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AMBPR04MB12205.eurprd04.prod.outlook.com (2603:10a6:20b:758::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 09:59:28 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0048.019; Wed, 27 May 2026
 09:59:28 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 2/9] net: enetc: add "Update" and "Delete" operations to VLAN filter table
Date: Wed, 27 May 2026 18:02:10 +0800
Message-Id: <20260527100217.794987-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527100217.794987-1-wei.fang@oss.nxp.com>
References: <20260527100217.794987-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AMBPR04MB12205:EE_
X-MS-Office365-Filtering-Correlation-Id: a41ebb25-c032-4274-83b0-08debbd6a439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|11063799006|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	2Ezv2rec99RFZZNGVcXESzoBmnF55nSjYbR2XvrnKnWFiol24HE2182kRwA7OXDlunGJbkU/OJ+cKMWEF6weq4aFaownho9bZ+BVf5fT16IieVDAz3ug0I/alJHbSpaKUgiRw27nCgtSgtUvc2xzGYttvO2VpdLllVkHm0aZDC/gk/e2vGH4UUMKSvg5ddGc6aiHejZLAfIz/OSndQL1LMvTghOjp+152D+rN6qXmhK03j9L2DbCur7eqfkaR30P4CVz4ZcWNHxcedfZ7TiQSbUlq+atPVBva/70yxGFWbkWDpJMHp3kBGUxvHTadfk4wYzC3NnJiG7NbWmn090ptjpIFmtRv23DcQRB7FHZ0qUA1X0UDBAr7NB5+bMXjz2H3VnzrScUS2TGO727V5qSgMTXVEfj9OWGTF7ku8/CZYk9xyqfYoGaHVTbL5MIGK8h7GZIe09pTGn50wqCkz8uQJs/Vk9WOLS21EP72M/yARTX38ylyPwPIGVX5kmSh6BgMqaXkalgK2enhgy89sP1oRr3Gw2Ms7M4DxNVRA80YYOTOdLzoL/4MgRT6vdQc7AVuhz9oDd9hixh3mBQunog4NbR+9n8GUSGs7raJ85eJRqvc2w0ITpjvSCoZJ5fYS72qr4ijAI0vVD33cBR8bZn9d8/A7c0Ivy+gmsJ9hIYIxjLhxCrVPY5a2kKXiIQ3IaxxnAvxgxAdCkbdeJxfhXKL8egU9QswA2cKXg03sz73Fg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q45e5kNyozO15377UClbafPef5+GFENkfN5vZXnzrIFm3avZczRWesWfvqmu?=
 =?us-ascii?Q?eCsnDiD7hWmJtTLJwuX+EnOFOkZewAL2NvqLqGl9gO/o58eYtoU/6lNg8vnN?=
 =?us-ascii?Q?po9aHpdz1qWSSHYCy3lPmI21cS/azzKQCRH3gMCzS/uxgs62kRMgrJtecxr7?=
 =?us-ascii?Q?MMScCt15pmhvxOEL3WRP/41KqcxYETMx5tpWOOLC5ahcAf5weRWZ8E02Pz0G?=
 =?us-ascii?Q?GFKRNM9I7yIBmiNi3a1pksNe2ai46PuzbJdzbZi8leZ4wCVrAz8WoWQWC9ug?=
 =?us-ascii?Q?7QQrHCRYEyIjo6D6P/bmAwZyg6waHvN9ONyaT6ra5foDPg0lgWqgPnE+xPFp?=
 =?us-ascii?Q?L0znyo5bfzVmYTqITT/PQJ/ucGuWTKC0NdGUkmhOz7mJCJZW/RwRzmiyvshb?=
 =?us-ascii?Q?hqb190eSta0plIBNsS90ibBHnQLUsZFV3G+dNP32KQDGU1+YMCMPTkJzSlIt?=
 =?us-ascii?Q?d9aK4PmOET8RIXpPTvLVQIERd1GZOHGbsd7I0zv3sEaigaEt6P5M6NUwgiu6?=
 =?us-ascii?Q?7WS6qwDBGMbNehpcW50hciPp4zRzOxLsDdVuh6ccalbGVJ+GKSTlL4UmIStg?=
 =?us-ascii?Q?1CgERE3b3R0BwXaJQFxXXAbniDYqPLEhTfwjzY7CAO1WVe91wXqI2fp6K11O?=
 =?us-ascii?Q?FKBqIzFlF3QmDA9t5iy7H1HtNKxz5ApN5HPYXGTeVHZP6Rht0h7erDiqB5Nl?=
 =?us-ascii?Q?tpsSQY/AqIifSbS4e4K+0332ZUlJhXqRtRDs1zM5iEvkaHWqvCy/nAL7R7iR?=
 =?us-ascii?Q?jYdk3T3cj73Kv9bdRMkzT7jmzPsywOpsX4faQl/CjUitNqqUDDzy7gAdx7cf?=
 =?us-ascii?Q?B3eQCehUlc8+FoSe+1FUfhTnhN0XNzL8TVLtUPqd50XAl3TBvjDSDb0WRkCw?=
 =?us-ascii?Q?TZi7yQY7XT5GcCdNJr9hyOtxvATK1WjDxKt7xJkaytgLPfr7R4W4oehILvIl?=
 =?us-ascii?Q?LGWkLbVLVSCJ3qRFx9xuaXJSakUxJ2tORcEGgz/1FTIKk6Befxd6xb5bX3Aw?=
 =?us-ascii?Q?OenVU/9KpQOnS1W9JLWwb9Kq4WH9sk1Ef85+wBkaejFBY7KqjmnvZoGK6/6O?=
 =?us-ascii?Q?PO73EykVRIAXNHWUMuH722sE81jUzTn4sLzh7kpRYpbIxmlNRLnmcUoHQprt?=
 =?us-ascii?Q?rkJAbQfwGm3XDYmb/ULxP3liAcgo0LAxOmcAkA0KESZ75IeuJS4zIv8EWaag?=
 =?us-ascii?Q?M6/lR+JfJszCUK7yrW0K+cMPR64Oc5lmPdkAozXeM5duJkicbeY7Nml+TzvW?=
 =?us-ascii?Q?1LJXGFcC4Tuo6fdOEFg3nIAOIc9VTEjlv8Q1Gd8LjQJqyLwgvu2xQRol2rja?=
 =?us-ascii?Q?b9dRCfrBBcvKmQtnyRpY7dZmGZtvzMVUPXzhMhsWab/XcbLqxcL9rBNp/Y6X?=
 =?us-ascii?Q?2KGOta/wScp8bxwxZbjNP/KYKhJJn5cx2mNlxoh4PAg8wlGmoCOTF/WhKyai?=
 =?us-ascii?Q?+oFFmE4J2HhFDhzylGLQ6p2kbU9u9lTUcPfOgyvs0R0HDwVqD4TBsvFo74om?=
 =?us-ascii?Q?IEipjzAGcuhi6lOJ2c5kqOH+NniBguOeT4OuyJsH8J+XwOo5DqNFLaG9roXo?=
 =?us-ascii?Q?DlMQjDmuqbDwYlqfwRU40yOwCYIneoSzCxCBU8MPTgMu+7iJUMyhte5EPXKN?=
 =?us-ascii?Q?oOKYThxaq8XewCrEA5a9kw2eukWKWgb6UrmO09z9gJtVDshpzTgdpGHBIpu8?=
 =?us-ascii?Q?9wn0BQG5pxylo4NpQEVAEaUXW6fHPegnRa+Nkot2H6LHSspoRUBszoCTPcQX?=
 =?us-ascii?Q?5gKLWDQnmaQPfe2ZKY48cNX5+S3Ho4RCDOfwjx3TW9HYghGU9Hm8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41ebb25-c032-4274-83b0-08debbd6a439
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 09:59:28.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1b/Ier23krp+0SMnMPpTrDGAcREbOlIiNiFopK8Dy2wWbAkoPid+DM8t1/GLy0/3YAK2KQNAc2DIgyMu2b8oZMyEV5DxWCYdukIRrsmWVw2ZPfj/O9WB6IOugzFT3RK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12205

From: Wei Fang <wei.fang@nxp.com>

Add two interfaces to manage entries in the VLAN filter table:

ntmp_vft_update_entry(): Update the configuration element data of the
specified VLAN filter entry based on the given VLAN ID. It uses the
exact key access method to locate the entry.

ntmp_vft_delete_entry(): Delete the VLAN filter entry corresponding to
the specified VLAN ID. It also uses the exact key access method to
identify the target entry.

In addition, introduce struct vft_req_qd to describe the request data
buffer format for Query and Delete actions of the VLAN filter table,
which contains a common request data header and a VLAN access key.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 91 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   |  6 ++
 include/linux/fsl/ntmp.h                      |  3 +
 3 files changed, 100 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 2e79515e1772..85abf9303bac 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -1046,6 +1046,97 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 }
 EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
 
+/**
+ * ntmp_vft_update_entry - update the configuration element data of the
+ * specified VLAN filter entry
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_update_entry(struct ntmp_user *user, u16 vid,
+			  const struct vft_cfge_data *cfge)
+{
+	struct netc_swcbd swcbd;
+	struct vft_req_ua *req;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0, NTMP_GEN_UA_CFGEU);
+	req->ak.exact.vid = cpu_to_le16(vid);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_VFT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_EXACT_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_update_entry);
+
+/**
+ * ntmp_vft_delete_entry - delete the VLAN filter entry based on the
+ * specified VLAN ID
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid)
+{
+	struct netc_swcbd swcbd;
+	struct vft_req_qd *req;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0, 0);
+	req->ak.exact.vid = cpu_to_le16(vid);
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_VFT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_EXACT_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_delete_entry);
+
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 0a9b87286105..ec2a1cdb0768 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -211,6 +211,12 @@ struct vft_req_ua {
 	struct vft_cfge_data cfge;
 };
 
+/* VLAN Filter Table Request Data Buffer Format of Query and Delete actions */
+struct vft_req_qd {
+	struct ntmp_cmn_req_data crd;
+	union vft_access_key ak;
+};
+
 /* Buffer Pool Table Request Data Buffer Format of Update action */
 struct bpt_req_update {
 	struct ntmp_req_by_eid rbe;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index f18556b072c8..f34151cc160e 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -270,6 +270,9 @@ int ntmp_fdbt_delete_aging_entries(struct ntmp_user *user, u8 act_cnt);
 int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
+int ntmp_vft_update_entry(struct ntmp_user *user, u16 vid,
+			  const struct vft_cfge_data *cfge);
+int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1


