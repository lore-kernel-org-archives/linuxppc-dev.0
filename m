Return-Path: <linuxppc-dev+bounces-22438-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0266CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 02:12:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbR464KNJz3bsP;
	Thu, 11 Jun 2026 12:12:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781143942;
	cv=pass; b=VWbb5ae89E+0PY9ML6ANO2bOr7zRVMf52IO+zQAcoMvGhqpjDkOXBtKl6mPsjRsVm9nw5NdNx2tkALQ5P9nwxoRLec34yjY/A6KlY7U9NDC70W6Pv6DSi+uqYBNf7CpKT9VZ2gAApN3ScZVDP/adxDdo1MeZVQdiPrZf3QppGwgKOTm+b1iyAm6PPwEnXuphmbycsVNCyBmbt0jPzMKVjrROkCgsfos5cDidlkxQW09GCeCUX4yyGHog1WX8VkET2l52sDIsmBYvEVeMjNjtRUf41d8FTxuwhemU0xHVt4k5R2SNcxKZVMva0W5dk/h7k/7OCO3ge+hiIQeChpJ0qQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781143942; c=relaxed/relaxed;
	bh=xPIjIj8PCZdtQNvztWwE+3hzAZNMvxpMCkaazKnjtLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYoYxtQ3W/zGSScA9hZW1mdxIoCR/8PKJdDqrwx4jMn5f1dmm9TBEIb8xVlgr+aQFvvOMRbpBclZZzJ9wkvcmT8ozy+p8kts4dm4TFK+yZk3PvEUXrDN+yIjwe80C4UWYn+kuAlgamMig/vo6obgz0AzEBud7gT3LyqqCNyCc0e0APO2hgpyzC4wajj0c4PF+VWjp+r2HBqwTqpcHcqbdfIwGQ/4UmQ6g1LuMQB/BIZ2VfFXeX9pB9cfsWYn/WLcI3cSoZRCBGxRiJnN2eU/Zonfu4raFNZrGw6onWk6kLpoO3x826w0jDHItTHuqPSEaVSL98X379CXGEb3VhyE0g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wFyoPVy+; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wFyoPVy+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbR452fhxz3brc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 12:12:21 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMoZMhR2D2jwTY0puesKB508h8rwjGJE0Kj3eEOwBnk/9iwSJKaAiK6iQmrqZ9i7oT4I+ZDAEOitP+2kont4ZuCgTBhCLr9wu4y0gK7J4OeXMrZjkIFUpSo07EBDkNaIJtR486DzeqOOfFkydB0PzZP3qR/ZXEQ9/9X5/I7JLNj3ep0mt503UL0d0EetvxgYf9E2xOeFXEGavsWEFkKOs1BLMiPTFgITP1vuZst93yIIxKudlw1FODMrYDr/Z+7xiyLa9/iVPu6mD83e8KMXrxCh1BsCofa3kRhueq+i8vAoQCOFWxfjXAqqVH9DTTUvvd9TgnlMLtDlMUYq6YvM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPIjIj8PCZdtQNvztWwE+3hzAZNMvxpMCkaazKnjtLw=;
 b=jVrdcj/gVYNnVZzy9A7NntwuQInW/Gxbp8ffKaOTEKTzn7RxGjQs12gDWEqG3d66XagmUkzNhdFngXBOf39T7c0/kgdSARjuY9l2oyWWfyuUqDRK7VtycSJPoQmnpkzIqirbDQ0+cQKE2PqVBi0tl/fely7DjAg3Z/v2bNfFCp/k1FbNW5erNZxfSiKbQ+HxnD/vC7jqcFaEXwN6FvMGJkZFwum9Vk7ra8C9+vqDIqERnjUNiLfGuf73ykQUWaNlOJKh0xGkfCvPPN4dmaCvCkcpRUStsoksUPZ5hu0ErA5Y3JXBqpUU3lNWAGbLEN3diTxwy63RO9S4UEWa75T77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPIjIj8PCZdtQNvztWwE+3hzAZNMvxpMCkaazKnjtLw=;
 b=wFyoPVy+n4Nko0zXGIdkJxtIsh5ZU7AorJufk8uGGRP1QGBuuRatO+5LT4cezxSQgCenHBRWE83E+M765uzRKhKen/fBnMZxk3bh12Q/eHOxzwN6xMnEEZ5qgKnO3Kscrv75MO/3sbqXxK3bo90iGct9ZBphRBc6GvwHiHd1C5zDWt91wjbpS3U8FRxl30xu1k3ojKG2IMp9X/oTa6TeVe9W6d+eoOZSxQcjp7HQKZDC2gNNaBOO034+tAItEi6JYmcNpin0aKOHhtas7oST3jhrqJxEznVX1zO8nlkigUh0x7PXwIEtH/7E61kp5I4rKNMH36aqmzwZjdTSyx3Zyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10824.eurprd04.prod.outlook.com (2603:10a6:150:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:12:04 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 02:12:04 +0000
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
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 2/9] net: enetc: add "Update" and "Delete" operations to VLAN filter table
Date: Thu, 11 Jun 2026 10:14:51 +0800
Message-Id: <20260611021458.2629145-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
References: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0178.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10824:EE_
X-MS-Office365-Filtering-Correlation-Id: ab62e0a7-e0b0-4eeb-501e-08dec75ed4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|19092799006|6133799003|22082099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	d0wwi4JrggxQOaDRN7MCInKbDfivNiqNfrLvgEwF4hEtvEoPxNdITz4xfFnbOMZsNNCx+agcq5C9O26aG3O5PzLFPl+AOrQiOsbh0lRtjCC/AYHFZoaSXqpPP45xodZnEmyIsZTXc1Lc8byeLXv3vpsO2BUrO/QWxkdqYQOASSsCScU+qgjTtGGnDoeGLXzVZjXpO9m9wedMUf9c8erhkx8T19GoX7puhkOVqRuW5v81RoDnv8f9EkUhPK273rGv+8V9GoResCS5Wj7j2khQ7QfCrG1N/PyprE0BOSOg4btka60CBou8QLiBV45ed2QVNpBROjKIzCz03wDUMY22i3qROqa3GDKe+umI7PTDTKygg5w2MYPueL1MVUn9z4yS8ZOjQUjbc5dorf/P8sB2rc9xeOp0uyXOGoxlFzvQkIo16UmNfH7KlkDJbDXn7ReB1tnFhnsy2cnnLZhFeI6e01dNxIVlsxjKvoImXFbAS5i4Ftn4qi/KcO+Zz6n/w1tYq2RyL+cGX4FkV2zSuQvhTkhVDWbTCudJw/edXgo2yHda7yQJmRJiu+PIK9gUWWItdFLhSLTn4AszlZuqElOFdbT5U7ZuxiXErDZh8Yjogd++JpTOnlrgGb652jHAb9drSTgWCr8Vqlgp4vyw8nO5LuyF4CAMv2Hs1mqNzPcuAs8j+0zg1sdZX/HKyr3Tts3zHQkXNYiTOXlXQNPYNPTVdYF2iw5rNKHbbTCaoQtO2VM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(19092799006)(6133799003)(22082099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BUprE78qsgtOuPz/EhlJfxTJdkFZKZlFo8Q9TU60S44y/aByoIntLSZfBNyn?=
 =?us-ascii?Q?DzZ4gvZYqfmKN/0OLRSUGjYB4vLtHnLc/SJhryRdg0BfYwLDxxunR0kHi2GK?=
 =?us-ascii?Q?fYOwB7SzzDXdEygmE11CuYMkkbmv9gNZ7XH4ro36BZh6oOP33yoTmP57/o3V?=
 =?us-ascii?Q?F91SHheNhLS7vPs6J8jEDquyT8i5QqjYOvivKFxi2/5rI01zWVl0xp3IrUiw?=
 =?us-ascii?Q?kDmffRUfpKEy1h+GrNCp0FrM+C4CFw1q8Mn7MF7KjGhn8BYTrERldqZfC18B?=
 =?us-ascii?Q?apTfZ3ZxHgw0rQMRUELku65XbdfNQIotlrHeLr9AQylEegEAe/cLODA6Vu7u?=
 =?us-ascii?Q?MdV60gPdZEPuum3Z3tczhdW3kPWr20euXflsmteIeIb7mGYL8k4LH+ILxjdF?=
 =?us-ascii?Q?B9QvLpoAKCqNpTE4RjcrqDQx77N9XnnywReUErgONvXZkrIn76fm/eD52MfA?=
 =?us-ascii?Q?WER2ZAHjDzeSIq/etw3/GsZampsrtxNmvcRXGLGeFd70JSplIaLa0PgwJc4L?=
 =?us-ascii?Q?CK+6nOHCo+6cShTOg8LAklp+vFtkU6mgRnC/zMqp9c252Dp+LUcUILs6sbad?=
 =?us-ascii?Q?ZK8gL+HU3FbubhSebP4UNybMc22pGLKoJhTzgZsglywAsA0Xp/pUF+fW/z7/?=
 =?us-ascii?Q?owiKR0XepFBJEccCMWyIhd0AxKGxG00VwWbp2h2efm3bej1A3UPEhXO86P+3?=
 =?us-ascii?Q?S1Vew1mzQRMulY25ejPaH5VrbnQIyzzvpqHpxw+lF6Ai1R35etnEW28jJyfZ?=
 =?us-ascii?Q?eT0Vy2A9RcS3CZ2UZznDiKs01FqDT/iVIIR9HMAoKed+W+c4nzeBf5lWJbYw?=
 =?us-ascii?Q?3DD8oDbLwQbsHMD4dCZrp6B7OzuVtI5+yeCXiCFs0gb2G1B3dN532ps0sz6f?=
 =?us-ascii?Q?zmCh4pn3yn9BH+4/Q6hpcnqRiuwlFLUoanYBFKUw6iGzrYn+m3CQ5WoKo4xs?=
 =?us-ascii?Q?QLgqn3O4cwnNdkRJntgvvEy9hVO5eGoioEFvJ2FOm+sDnDXBD+eO2XIcREKV?=
 =?us-ascii?Q?PicniMDOkntN/sMgr5SNOzKAe+/A5pEt+0sGgqX66l2IyonKAeJs/PNH4Gg9?=
 =?us-ascii?Q?6wVnW0f9lNQmNs9hQtqBeV4du2X124ghezuLvlgB98y7UxfzdPW/0QVznz6o?=
 =?us-ascii?Q?PEGoWosJtLp0dJol/uqxWtKH3bWyyXcpMBjjSMa6uc1y67GOkPCHTJKt2nal?=
 =?us-ascii?Q?6pbRg/1B9/TyppE/wDl/H1qF9RBUZA9H6tkt3uem6ZwAqQGCVmHEA1B6uVyj?=
 =?us-ascii?Q?glyY85cl4XTe0soXEm+KHLAhd0Vwjlru7zRqD3Xhv4JzIeZzM4FooFUCBUVP?=
 =?us-ascii?Q?THcVNA/2BcofnoqgZp7ZpXcutdjtQSYq6FTtveY3ukjXVB1bi9PyIC2UyxaU?=
 =?us-ascii?Q?i52+aCOxwzHy4UW1VqbWh6TCNmcbC3CA8W54EhIVKOfv/ZozNijV9OEPcix+?=
 =?us-ascii?Q?YDCVrE/hrnIGkav9cFDDR6gnaI+469rrvqdj1BgOpGJ5gCECMNgk8Mv/m+R5?=
 =?us-ascii?Q?vpqClrlY7BRatVNvylUMzuVC2/RnseKShZ9itcZ05a/GuZRjxbW0WUuq9RKR?=
 =?us-ascii?Q?fJ5rqlCjqNIS1RQKlDvP1AJ5Dd10f1tfv3ZBBn+duKia572zXulQxyNVFd9O?=
 =?us-ascii?Q?XP6ShodwJ7JpB1Db1/rQGRrvhpVO8WeqJVb62+vUTrfmoE+nosqVTr67JLrx?=
 =?us-ascii?Q?0kjTIKXTHDZOKPSw6/ZZ0hdQxBd0562H7BXv0gC4lF3RMkaUhGtnO/10Y4IR?=
 =?us-ascii?Q?wkHvauCGqQB/4N/N3J+Cj/jEsnrhtwVYK7aEvaxHU6eofUEptmQY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab62e0a7-e0b0-4eeb-501e-08dec75ed4cc
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 02:12:04.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /l9q8thZyJ28fZ6px7wVTKW1xon7Nq+JBobMzBCus8JxF7mCC+n3I5LBH+YDGG4nCGvL44QiByTfKsWgABpu1JcyBKcVCJgTAeE13DeYgv1u8T/6csd3U22Yfi3kkjyi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10824

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
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 103 ++++++++++++++++--
 .../ethernet/freescale/enetc/ntmp_private.h   |   6 +
 include/linux/fsl/ntmp.h                      |   3 +
 3 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index bda26fe93b8d..4e60bbc38cfa 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -956,15 +956,17 @@ int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port)
 EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_port_dynamic_entries);
 
 /**
- * ntmp_vft_add_entry - add an entry into the VLAN filter table
+ * ntmp_vft_set_entry - add an entry into the VLAN filter table or update
+ * the configuration element data of the specified VLAN filter entry
  * @user: target ntmp_user struct
  * @vid: VLAN ID
+ * @cmd: command type, NTMP_CMD_ADD or NTMP_CMD_UPDATE
  * @cfge: configuration element data
  *
  * Return: 0 on success, otherwise a negative error code
  */
-int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
-		       const struct vft_cfge_data *cfge)
+static int ntmp_vft_set_entry(struct ntmp_user *user, u16 vid, int cmd,
+			      const struct vft_cfge_data *cfge)
 {
 	struct netc_swcbd swcbd;
 	struct vft_req_ua *req;
@@ -973,34 +975,121 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 	u32 len;
 	int err;
 
+	if (cmd != NTMP_CMD_ADD && cmd != NTMP_CMD_UPDATE)
+		return -EINVAL;
+
 	swcbd.size = sizeof(*req);
 	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
 	/* Request data */
-	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0,
-		      NTMP_GEN_UA_CFGEU);
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0, NTMP_GEN_UA_CFGEU);
 	req->ak.exact.vid = cpu_to_le16(vid);
 	req->cfge = *cfge;
 
 	/* Request header */
 	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
 	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_VFT_ID,
-			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
+			      cmd, NTMP_AM_EXACT_KEY);
 
 	ntmp_select_and_lock_cbdr(user, &cbdr);
 	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+
+/**
+ * ntmp_vft_add_entry - add an entry into the VLAN filter table
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_vft_set_entry(user, vid, NTMP_CMD_ADD, cfge);
 	if (err)
 		dev_err(user->dev,
 			"Failed to add %s entry, vid: %u, err: %pe\n",
 			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
 
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+
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
+	int err;
+
+	err = ntmp_vft_set_entry(user, vid, NTMP_CMD_UPDATE, cfge);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
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
 	ntmp_unlock_cbdr(cbdr);
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+EXPORT_SYMBOL_GPL(ntmp_vft_delete_entry);
 
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index ad532b059ba8..9d30f128849a 100644
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
index 5db078e1caa0..36a9089526ad 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -268,6 +268,9 @@ int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt);
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


