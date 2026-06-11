Return-Path: <linuxppc-dev+bounces-22440-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE56CD98C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 02:12:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbR494ZKyz3bsT;
	Thu, 11 Jun 2026 12:12:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781143945;
	cv=pass; b=WCxQq4+ar3JG3+Wob6KGYqxiDHpqikn1skhniEGX4KSFe89QxEkVWB20ULfUTaO3ZADcM1rUr9WqOmsH0kcqfILI+4+yZHkgkwLBPSQnGe5dEOiTiDhs4PtXk5nTTX0e3gxDOs4lw7P5yG8trxuddyNipvkaJYoA4YPmmpWmxoyEQmNNZgEOUssCZ4Yif34CWlOxG7KZS/5/tBCKaJXhDv8VCPcnv/lIKO93cFeGV70PQtC3++BgfheZXI6NbJyP7CFPB7UnDX4KiPAaA2vtD0dHW5HWYHvxN4oX5tobMEnvENyQYz7K05oeAJcbQZFUy6JK0xHiDqzLQS99rhJhAA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781143945; c=relaxed/relaxed;
	bh=NO3q3FjeZxoBvWVc1q8if2QrGoMmsDL+VfIf8U72prQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m+nxxNAY1gtVg9lpIM4MEuWdjw2nUkSnfQvTSTxDpmzMvpPFAdIreF/xBXZG0kUO8r0pgUp5d8e0hNRPr2H2U+pvGrVoVuOzluQJnSP8eXKj1Z4e64RNQWCJTD5XOpGpVrxqkAsp4r+nV78UxPdtx85Njho4ssetrJU6k6H1zdKgjwqEka/EVHszlD0NPpccR54JEoBr7yl0SkPMhLNoZtuH7N132x8wFLLnWRaUhU/q6jA4UMa3mSVpD1fZUg4CBYJiVZd6WYXHJh1sWmmzQUOftZLNlg3HxYJzsDp7KplL1jqIZXvidsdOhDZubgn9FVOQ4wRT+qTr7ofPPeP1YQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MYAhfJMi; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MYAhfJMi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbR483X4mz3btc
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 12:12:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1bTQbvTr6ORt4B8Fd2Ohl+v6ucX/MPDm+iBpg8EpvdiDdSo0MUmE7HX8U65cywaXjVE4tWma82hQnLrzYpKvoyqS46QXqZ7HUWovLMRXQSzz8pSZKmiPYnqUyFxg2hdW8qRca7qnXn6WIQ+kMmo+FZj9K4Hl5rUUERV83atlDEEWSuf9ac03vqxIznNiraEpPk2I2QM1pDMC6G31Z/mlYoZZuS2Pa45quavrlJpWWb30R/aqbajNNyVhEHTOpJUeF0+diWjtIHbVdVP9OKljDeHK7doPL+/u9iYapcRidFVVJRmK28XG2Od6cwrk7/UdQHmvNvEA7y0jUMz72O4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO3q3FjeZxoBvWVc1q8if2QrGoMmsDL+VfIf8U72prQ=;
 b=mFk+Y0FKqbhjKCTjAEcqPtJ0UdOB252FNL8yDn5gnxWL714N//yfmaniFEUdhmDS1oEUAeV8CJ2arQOoocMgpABtdzwliZZNl2nOzlaVB8JdzTA5SkA4OAlPmoFaoyFDJytGBj7EYA6Qf8Vqc58bG+i8ZjugFXiPSAbdf+4YyL6AVhsiQU34XhFWjaskFFLOCMmWWnz5Mrgd0zQmqhB3eUBXKcdYqIw67W7HcihJIZciIcyzgzbqvxztEM11YKowWQ1Gq/LTx/9S7+0dNZwiptXZ1khdrCCjNfC2OYU9KLBQfudQGWJ/wH+j7jWHH4oDf/WyTl14DB96pabbfTHaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO3q3FjeZxoBvWVc1q8if2QrGoMmsDL+VfIf8U72prQ=;
 b=MYAhfJMi8sRuHcj/bNyfqdVcLoOxBjtR9U/JOSM9QkmuaJQuB8HIqwdRVgrXhNhT3uR8DTvipsY0eQ42iZ98gOQ/vXHMN6JtgcQcQ30y1e1VlegnOU/ZJ4XmFApxahSFKRXp1JYMF5PApCUR8FLO7eNp0Ue2fuk8hdpTvjbFDzr9993Kp8ZRgoBqKhEaBOSW6W9hNaAcBspsFV/EhZsOy206yajaKHJyrbThCZBbSM+v/zeSVoacVh7sHPrZkYp/x5HK/SGX2mMeqCY1Epm5sY+LqGJx5M52cNC1wv5poC19T2C/Wa7BaKYSMsV4/vwlhEc4OcGM3d3AMVfAzLRg8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10824.eurprd04.prod.outlook.com (2603:10a6:150:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Thu, 11 Jun
 2026 02:12:16 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0113.011; Thu, 11 Jun 2026
 02:12:16 +0000
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
Subject: [PATCH v5 net-next 4/9] net: enetc: add "Update" operation to the egress count table
Date: Thu, 11 Jun 2026 10:14:53 +0800
Message-Id: <20260611021458.2629145-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
References: <20260611021458.2629145-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0280.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21d::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 354ce70c-91d3-44eb-c5a9-08dec75edbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|19092799006|22082099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	bY7YKI+y4gD1JJd3FbNb+vxyoE7xsYdcPMUnVwrgYqqfHkbJxQGKqyFZSpgkqeqZqweu5om7MQCcIH7ZzVtwxcpw8yTdb9FS6/VXXtuK35keuARIJ31hrMkpoOVjZ3TjttRPUBwUZHsIEm7Pc5riWYyQAA0lGx5W6pYs4blIVm+7dQMDW0CylD+/MtFMowSyNEU7O2xq0WJ3KVpbucdqZK07y8l5nJHieZpPSmM4Uh3Ney5zWSUEuMf716b85yawe7jKWbNDBZ16+tWXRHav4rBRPwE7/hxjCVSkENyYcUBby+0eTitSjXYW+3oaXIzSWh2k62sgi+zjf8KFPPKG78hpNmsQ9ggBOIVAeWu00XvAds7/KpxquZf+yjUI1Q6tzCfMeqMAP1hNpTjZ++JPTVJBnke5z23hLDNcUZc47eiAofwCZ99aejnOt1FpW1Znnt4zl87OeWrO+9jqB9F9ZnWbnVMT8bANtTfds9aUFLyT2EvStsa84XgsmddyY0Z7lOM+/xONL4rgTY6Mr7iHIvAlZGI91U2UPf/ARyIbRUZKVU7+8ItFLwQteH058BmlVOr9riezcejGzVSLJce0pRDlFdcZ1GyMpbU50hpffLUUmcSmyND52cL2PqfA9BG93yoPW5tfVyfhIzradVbVHN+DSzaLdBtbt7/zF1KlfCECBaQNY9vSa2/tq6R2QFTGViNEkpIeUGilFO/6cBASTXGPQuQEgTl5tdPVa1k8nnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(19092799006)(22082099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UUelyHufO8x/SwpqIYBw9GvMgLHP+WgAATJWPHthJycwYHn0XQ4hXkcmHCoU?=
 =?us-ascii?Q?izLOMm+VMXaCOZyrNqOfg2lXqHE4M4tbjnMsHCeW5H5rnkl44kiCxAxl995K?=
 =?us-ascii?Q?3SbTqnK4ShmvSf8hRESS6/TRgnkuXL0/YXQ0zAZZtPakWfrc7A+qU7ZKC49L?=
 =?us-ascii?Q?K31bZgUIv3Q3xOjuPyAGS2Al0loVaGj06e0muKX85V9iaVUoK+nOfuBBk4qZ?=
 =?us-ascii?Q?Whmy07yougWQihwj/LM1zWUbidDry/eSJ8u7dOtF9Ey9fNOYhPC/w5QkZRx8?=
 =?us-ascii?Q?BJyQ6MkVznu9soQ8iRJUWBVVG4ymeKGUYfuhWRuGxLBrPDkcN2heYMNfJ47+?=
 =?us-ascii?Q?baFaApYLPpTVUr4ZsixSwy1IBdPfbTO84e1l09utvyzZiKCLLKKMcrplYJ0t?=
 =?us-ascii?Q?RDZbK+/l554JFA9vLDH5Oi1VE4SVr5CCatGUjFWKe+au/UVBZHMvMGo57ve3?=
 =?us-ascii?Q?eeWhSrQsg58wpjA0oXU6RORxqtjWDFEsTE+/+749UaD111hYO5oS9fFB8T3E?=
 =?us-ascii?Q?RZw7ehBVNbvJA0gfrKJw+vzKWxl77G66/VKI1zLHZPuo2iEa0m5OQwBdZuTL?=
 =?us-ascii?Q?m/rQMpCpSDCuqcefvuGGyvGGt0bWcPbA9mO70M4cWm9gf64x8gTt0MpM/xBh?=
 =?us-ascii?Q?p1zM4JuDawbuicMplqaOziUchZU9owjYAL2r7qmIo27ExlZFgHsA6pclnvqb?=
 =?us-ascii?Q?K0SEkG2ouuVg0wiiF1jQq0FDBhp+RMxYRrj6yXVKuvJIItImcjgwfLSSaxa/?=
 =?us-ascii?Q?JQHrmgDnZKP9RZdwr8ARrMzb/2cEpT4vgvIaaDaFJ9A33w3MaUc1NM5pcICF?=
 =?us-ascii?Q?KTVBMXRUWRiTiiZPQ8ql1opDhP+b3TVUbNukPPYIMgwBMjprAjr5zwmT19FG?=
 =?us-ascii?Q?tQOi6XmFLERfifhQo4Xi/wSrSB4bN8OToBzMfYA4+ERD329kaNQnMMuT/wQi?=
 =?us-ascii?Q?uXoMfPY49CNIEHBVcSpsghgJmfxYTv9ep1rm0QBUIsghY16ZCi//rHoZ5iWD?=
 =?us-ascii?Q?oI0hMdctWLb+/SbYcfqRL0Okl5vnhJyddLnwFegOmK3JPg/8uhVrRYzX4vOs?=
 =?us-ascii?Q?fQGQun0SS4n9+JZ84LUUhdx/iCFB+ma9Q7Swq0XbkrCYgnrkb58xiwjzH6x3?=
 =?us-ascii?Q?cUtsWeVvf/1GutijdQlSVdGxKqivRYvDi6IRp4iNOQJbQOZEOxoGYJF+BaP0?=
 =?us-ascii?Q?ktBVEuLx8mDyy1A8dQE6zyJFub4CrqH8HiackkZPUMRVHLNLCZMAewbyJ6uW?=
 =?us-ascii?Q?nk554Yapts1qideIYSCTIAxAJpmR5467lyiyaQZ9hNUJOiujWRIf9mmc5MKJ?=
 =?us-ascii?Q?xcIHy4fgg/b1NLjYsdb10//aSXvgB8P+gpLrI+e7oSvhTPv4Q+DlwdKEdTMy?=
 =?us-ascii?Q?lrEGQrhvDuKCOKurOGAk0uhzAqgbI6sM1NdjgcrJ6SX9MuiHY/fK0/hRP0YN?=
 =?us-ascii?Q?SQN/cuJDhawYkfnoevgeyiCx4nzyIxEhANKcAsTon304EDPSMb+GNwGtvOrf?=
 =?us-ascii?Q?+t6f62TZlJWDYmqzQZp4D47IMnVii2SqKxFZDujuQePqOYyGrMUwO5XU+N2D?=
 =?us-ascii?Q?vP7s8tk9WYBEdC8XYOlyQKMW+5yo3ypMyFEmYVfztoAMA+u9p/S4z4k1AMP4?=
 =?us-ascii?Q?rlu23Y1UqyWJxLSPlFcewyqlRF3j8Fej/AnPe/q5PTHmDOPUcxVl/49rCQLg?=
 =?us-ascii?Q?sc3nFbD3rppFDL83lHcoTueMDCN3swPzbAuW5CYsGX8aoPJoumloOdksLHcz?=
 =?us-ascii?Q?z/DLjpLCeEiH1rR0n1zxMT4zzGxPRLA5M9Dl+p1T3nJnCe5Ysfo2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354ce70c-91d3-44eb-c5a9-08dec75edbbe
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 02:12:16.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKUXR2VoYdLE8OgY/qnukLbTUwfXVMpbAPrfBOGGCslg7RI9BNIR4XbwqSAV+OEAWZgYSvfeRTtt0RnYaho48XQ2yvmnKKy0OEae7sEIiOIzE0ubbLBl4doz8yCx+byO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10824

From: Wei Fang <wei.fang@nxp.com>

The egress count table is a static bounded index table, egress related
statistics are maintained in this table. The table is implemented as a
linear array of entries accessed using an index (0, 1, 2, ..., n) that
uniquely identifies an entry within the array. Egress Counter Entry ID
(EC_EID) is used as an index to an entry in this table. The EC_EID is
specified in the egress treatment table.

Egress count table entries are always present and enabled. The table
only supports access via entry ID, which is assigned by the software.
And it supports Update, Query and Query followed by Update operations.
Currently, only Update operation is supported.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 45 +++++++++++++++++++++
 include/linux/fsl/ntmp.h                    |  2 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 9249f78219ed..601435966ed1 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -25,6 +25,7 @@
 #define NTMP_FDBT_ID			15
 #define NTMP_VFT_ID			18
 #define NTMP_ETT_ID			33
+#define NTMP_ECT_ID			39
 #define NTMP_BPT_ID			41
 
 /* Generic Update Actions for most tables */
@@ -33,6 +34,7 @@
 
 /* Specific Update Actions for some tables */
 #define FDBT_UA_ACTEU			BIT(1)
+#define ECT_UA_STSEU			BIT(0)
 #define BPT_UA_BPSEU			BIT(1)
 
 /* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
@@ -287,6 +289,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "VLAN Filter Table";
 	case NTMP_ETT_ID:
 		return "Egress Treatment Table";
+	case NTMP_ECT_ID:
+		return "Egress Count Table";
 	case NTMP_BPT_ID:
 		return "Buffer Pool Table";
 	default:
@@ -1197,6 +1201,47 @@ int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id)
 }
 EXPORT_SYMBOL_GPL(ntmp_ett_delete_entry);
 
+/**
+ * ntmp_ect_update_entry - reset the statistics element data of the
+ * specified egress counter table entry
+ * @user: target ntmp_user struct
+ * @entry_id: entry ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_ect_update_entry(struct ntmp_user *user, u32 entry_id)
+{
+	struct ntmp_req_by_eid *req;
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
+	/* Request data */
+	ntmp_fill_crd_eid(req, user->tbl.ect_ver, 0, ECT_UA_STSEU, entry_id);
+
+	/* Request header */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, NTMP_LEN(swcbd.size, 0),
+			      NTMP_ECT_ID, NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry 0x%x, err: %pe\n",
+			ntmp_table_name(NTMP_ECT_ID), entry_id, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_ect_update_entry);
+
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
 {
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 0c951e1c763d..1222901f48a7 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -37,6 +37,7 @@ struct netc_tbl_vers {
 	u8 bpt_ver;
 	u8 ipft_ver;
 	u8 ett_ver;
+	u8 ect_ver;
 };
 
 struct netc_swcbd {
@@ -294,6 +295,7 @@ int ntmp_ett_add_entry(struct ntmp_user *user, u32 entry_id,
 int ntmp_ett_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct ett_cfge_data *cfge);
 int ntmp_ett_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_ect_update_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1


