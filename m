Return-Path: <linuxppc-dev+bounces-22302-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E103FCD6E79
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 03:28:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZDr83sFKz3bxf;
	Tue, 09 Jun 2026 13:27:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780975672;
	cv=pass; b=AqvGGvtmvsu1Kn7WBaNMDhgAxMve0GwiWyA3gCv59b4/JVUsoE7WvzkFLWZ+sJyEze0PSUsk5M1jwF08zA21ezoZ8BSufx/T++pZCpKRDhxoWe2pjZQfA2CGh/FldSxvKGDTKka4XGMd61KKxPV0ai3RloCEh0etbUK1XGz7/CaXP5IYIH10Nv6DK1LVv9crCXbdxSL8MF/9TwMZmFk4SC+YMnZgh1cVdFzK1qCblFv4oXm1IBsjn+CbFni5R2oxED3sofmTPJdQawFEgHW5jFZe4HncQjom7luT01Ar8sW9L0NxM+f1pjh/wgyr1N5Nwf99J3XEmRFGTMn5su9Pow==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780975672; c=relaxed/relaxed;
	bh=3xEuNbFobIfq47a7fzRigST3BA251er9sMioTh4rLKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SdBBhKAGSDr/nB8tyKirYS5QCjzvEDIXEmHhIZPVR9BSd1GXs3kiemXBs7zIc/CNEfUY7KfCwpIIUP8h0aZ6h2FynB8O2MXxMgy83jWjHfh8whbrjzcrmgqC13ksBPDwiX1Hu2r4PSmRDSVhTp1vT93adi9s1ID5KTENcfvDa8IPBJbZy3a93FLTjdnU7tGNWTEULj+QnKrifO3jFGV+LLpAKPPG/L2t8+GQuQ2eGPBhZerC1y0VkV7jy7TcW2Rv9JYbVGu8SlP9vrjvEoYOLCcPcDAUg1M5R+ANGg0roP0vZX0kkelEjBX4Lq7WTrwWro59G9VMDiYfHOB3elsvXQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ctq6Mm+i; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ctq6Mm+i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZDr76VMcz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 13:27:51 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p81fOVzaz2D59AdxRB9IQCE3CLPRAEe2E9wb6fkiw2saemB4Qc+LD6FLl4+JTDBh54DHYMWRYmLtDu7G2G92MBlweQMgr+mKDNRJujoAWPJqJTyQXKQxUhdLQ9IShRaLGwFQZBtWpeJAJB18mvokvc1LHG9pKcvJEsowX4p6renDbHkIZM9IjtXB7djOIWYieVcwarlUGXf7G4T/X7u+uGfU8atEyZ8MHZ3g2pcWwasopzW5VCzhAZ5SFzUQw1DFTt1AJeu+1PFioXlJF6OGdFKVK2Gws5kaO+WLfHDGoe+Oyb5fzu/VpYIZ06dQBvDeGatKItNoCLjTOwOF0VyX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xEuNbFobIfq47a7fzRigST3BA251er9sMioTh4rLKY=;
 b=IXXv5Yg20pYp+ZttUGNJtscgjJF/eFBJR/SStS0vxF7poKrsYSFCblnSSvSf2EkT2T8ad8kRCsX9bcMfNlRJ0/iKwxaYAC+6U5762jo5TrotLJgS3/jL0IST+Td0JIeaOWbfm59M1+2bgssw3Ctv4J2EtUWN07XfOhO6dyVJDfqNAArU2med0q38Y1KmMTYJiLpoHrLG7L6lxJ0gZjZbXkrXkKSR+VMLinnHGCrsh1yc01UVWV3l41Klmgif2MqHHZWVqLLoKKAwCBHOKlyiYQrXJWmsC4ZXilkabzTaNAleiZYO9Xy348Kw8hKUA4otDypqRfkQFBkxnXOLrBNftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xEuNbFobIfq47a7fzRigST3BA251er9sMioTh4rLKY=;
 b=Ctq6Mm+ighRT2oJnuMvNmX5f0uv9M+bXshanX5BGX7tDofZD3Z5hy0LgPWEPgnTCNSKfiaiqvIWRHWulCSUXSx2+AlEVK1O440glmATG2QH0IpnZKRWulQbYvYMY2riRP/muDXRMvMxvb95XaDAaqsmyKxIq7xYl25KpR+W7jJYn790GV+rCCiAaDW/1whEWqHhPGQPA5+UuphBOHNDxPnyAI4mWGzspvbbM7mg3LjvSy/52a0R58YGhGYAJLkVwMXAM5x+oVFf7pqhbvCHYzaE6hEo2tGr592ZZsPXpPNTd4qgYtVXlt3W+3Dc1WIEMbEUU2sx60LFCxnT2ax71Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 9 Jun
 2026 03:27:33 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:27:33 +0000
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
Subject: [PATCH v4 net-next 6/9] net: enetc: add helpers to set/clear table bitmap
Date: Tue,  9 Jun 2026 11:29:52 +0800
Message-Id: <20260609032955.2066089-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
References: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6ac496-b6ac-4153-274a-08dec5d70b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|22082099003|18002099003|921020|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	lCR4zyd5sKZnZ3nMnfLhKgUpSi3FGJzFD3q1eAx9+zW0ZSrGjPC3hOyoRdnbcs/G5kTqQuZFQ3COt3ugG3MyZ0XmtjnUweC3Tv/KwsoiSeHtdycLHQPdcDfl1ayVTZXfJe6TrltFqq04Ynucqq9C+IZEfEwAXr34INX6NC4rXQp5c4rNezdwuYEcQq0Cc2quyE6q8O/RuAHVhmnsUzHjotSSU6i8iRKhS4yVBWalNmgB7RAEdTHG26X2juyLm0L5Ig5+fBa/HyW38Jdm1PvosHeBW41JkljWhoih0cDuZ/9QlNVuT8OsCU6xcd7Z/BeQO/XEeK8pwFxzd4sK5G1VlvDnW7dwb5y0wlFO6Iy66ThIl5TfjDzIT6jSjyX8fGeoTVGQdogOZ9dGq7v0vtVrETKwmrfdb3UiOhlBszZlZHCqzxFW3P7F16Wd2yIKKkUqdEzKk+XWl9vojk32Badsnl4x9oA2Sv1hHb1lKLikUSxgzX6c/Hj59aVdW+LlIhkBDXNl535JHQ4UTYiLRVm+ke/6uh7XO5Dj3c3HDfW8sYYPn5kFARmDLsorCWVf8m2CGOGG9cUefylywWoujnabVkhRK5pjwuhWIggLIAF71EmICHO6MiQv6mA2IIotWkGt9HPCGyJl9cVklPOz021rU8DkVevaMOiASxO9MJYLKfcz37HC2IBrvl4+cOhdywFFlZwtI+cOthsv2aagPgBtncO2M3nfpi0zaraysEOuFnk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yzBod8xWS/svx4QbIFYQ+KIXLa5GG1eJBgpgvIBP7wTwNwQ077ToaXjVi2/t?=
 =?us-ascii?Q?vpx34p9Clhz5QuhwR+EeuLC1Q4xEl2jmlTb8j8wzlC3RRYP5/b9ZOe4ABNUg?=
 =?us-ascii?Q?B6JLhoSWraAMlb4XimU5UHI4gq3WzL7EaTiDBW/HFP0MHEhuAiN9VH+AF7kg?=
 =?us-ascii?Q?w3t/21sj8mtNPr7/32PXG3jfSH+nzWCOJI2rrxQ8o9qfzdXoIkth5ubjSotM?=
 =?us-ascii?Q?1wokbnSnB1bzjbd5MieyiKHRpaILAuOsbfkA3Qzb4qShfy+ENyD+Sdo8iMVg?=
 =?us-ascii?Q?1SvarqIsPNXrwFyjsVAmGuxGiYADxB946+YS8KRX3iwqagFC0636rJ9eDDvc?=
 =?us-ascii?Q?CP0F5SBYIPnERTWR4KVOHxU3ESD2V8RMjJwhbOOvRhBhIvJkqcQRbyzdgcAs?=
 =?us-ascii?Q?MEvUCYAYNTy1LEb5s06UPsdAh11cvGdIAWoTcTLPeh+DQArxrUORag5SrcSQ?=
 =?us-ascii?Q?qo6h5ZSpRuH7n9Dc0vDPIy+yLH1rqwlgyo+Jxg0qvQg8BO0xjle1ckppygGP?=
 =?us-ascii?Q?NnRhTn9e5vXde9VQYOMfKRzUfzEbBZi29lWvaSslyyCHF7qY3r8qurNXWzvS?=
 =?us-ascii?Q?ZbTML99txtEKg4XZxwO0yHad2gN9No2fYgHugFTIKzFmw8YuFdlGx1Bkkle2?=
 =?us-ascii?Q?jH0wj57d1zc6TnwOePjoAe8Wt596Uw/5GEopR5j2a2887KFtIh6YKhkpSeYu?=
 =?us-ascii?Q?o2NwQsEHUEwWW6hTR2cpxehlukmSGwZh5C0ifqWz1aWMSvp6MleV1QIV27Fd?=
 =?us-ascii?Q?GU+m3PlVbhhMKYd/o6Ln3xbRmuaVn94x33OCUlSRdREZFzXODKmTCPz6JP0V?=
 =?us-ascii?Q?ftV2mtc5ZXWxXfVlUQD6yY/ScCZ8uFsxYNoUtB8zvWyjIqBuQidXfeg8LHGF?=
 =?us-ascii?Q?eiTT+UxSzw89hvr8joKBP1/bwOSqIeuQ7OVnHL9RZg+4LziTL8vpCB3sSlT4?=
 =?us-ascii?Q?GFvY/U6GiWaNz2dE9hzvZHbnsj6RXiyL5SbCM1HMFn23ycFtDJd/0bkAlOSs?=
 =?us-ascii?Q?Sf+CcbHGDH3rlIs5EKRo21LSiOEYC5cPSNejboeyX9YxUjvNmdvr43XhQ/Dd?=
 =?us-ascii?Q?0EIQ2DMg8ao15ODe4b7S4/HLa2UyzLNT7XYN+nbdbveFKsQ6C/lgHCmRTZMB?=
 =?us-ascii?Q?m2fUf3IcySz/8HiCYkH8p1r7DEvFaIO1QHnUu5FlaWqXp5o0MQ+YMTPqLewi?=
 =?us-ascii?Q?Y8gadXGdbuz+pOxuIr0VAsVhrlcjBCrvW4TMyjJq5d/mJoYxBhG239Z/5gKb?=
 =?us-ascii?Q?LajE7GfB+m7LHHxDp32gGQ7NI7nh9Wrt13pyw13uSh6OC6eeM9nA23ENlB/M?=
 =?us-ascii?Q?F9zw0eUtLR3uUfq1Zuce/5KVHDu2RRUowIfVpA5TO/rIuSbq1jGf/3c7lnnb?=
 =?us-ascii?Q?G0u5JXIRNrw4P7ogjF37k3MT+NIZXlbpc7LFlVrRMGEbzpUmy/v/7JOYJnFj?=
 =?us-ascii?Q?MltC3h1KDTIxRfk6MPJ+ss1EzRlTsNoXhSI0uGkwPGOjZWa/2WptBn6TrCVg?=
 =?us-ascii?Q?ZihIZ564Iz/wHAS9G+m5FqJCUrdF9aq/IucwpQ4RNWd2UQaNwV7w6XsiJDp3?=
 =?us-ascii?Q?WPjScJzGFRVlWjYnFoxyRG2MCkbwMmd742kMEKxM8ARvY+8M1jQpzIjgGfaC?=
 =?us-ascii?Q?W9lQIert53CA3YH+qVby43yfurnwto9cR8sKTsgHFbfvG9yS1NlDVPek1zZ/?=
 =?us-ascii?Q?+tW613LPlnBsNJjBB1BCfv/Gxv85W1c6wVs5UmzO/2CkugkCbEsa8wEXm5XZ?=
 =?us-ascii?Q?sNwl0REdw6jSh/1dDDku+qwTsqzt5Y2U1ZuXWaa+l/8P0kWBw2Br?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6ac496-b6ac-4153-274a-08dec5d70b60
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:27:33.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9hvwwLtJh7JB33IC2V7OhwxsYrA7aWozzsVgtYxgD4fVZ4fgqxuAQPS2aE0iobKhjPlNnXJ7tj6dmdR115h7t6tR/SeGgrV+sfQhS+L6wpuE+cE29eagFCQavzg1ivr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946

From: Wei Fang <wei.fang@nxp.com>

NTMP index tables require software to allocate and manage entry IDs.
Add two bitmap helper functions to facilitate this management:

ntmp_lookup_free_eid(): finds the first zero bit in the given bitmap,
sets it to mark the entry as in-use, and returns the corresponding entry
ID. Returns NTMP_NULL_ENTRY_ID if no free entry is available.

ntmp_clear_eid_bitmap(): clears the bit associated with the given entry
ID in the bitmap to mark the entry as free. It is a no-op if the entry
ID is NTMP_NULL_ENTRY_ID.

Both functions are exported for use by other modules, such as the NETC
switch driver which needs to manage group index bitmaps for the Egress
Treatment Table (ETT) and Egress Count Table (ECT).

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c | 24 +++++++++++++++++++++
 include/linux/fsl/ntmp.h                    |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 601435966ed1..9f38f885ebb5 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -47,6 +47,30 @@
 #define RSST_STSE_DATA_SIZE(n)		((n) * 8)
 #define RSST_CFGE_DATA_SIZE(n)		(n)
 
+u32 ntmp_lookup_free_eid(unsigned long *bitmap, u32 size)
+{
+	u32 entry_id;
+
+	entry_id = find_first_zero_bit(bitmap, size);
+	if (entry_id == size)
+		return NTMP_NULL_ENTRY_ID;
+
+	/* Set the bit once we found it */
+	set_bit(entry_id, bitmap);
+
+	return entry_id;
+}
+EXPORT_SYMBOL_GPL(ntmp_lookup_free_eid);
+
+void ntmp_clear_eid_bitmap(unsigned long *bitmap, u32 entry_id)
+{
+	if (entry_id == NTMP_NULL_ENTRY_ID)
+		return;
+
+	clear_bit(entry_id, bitmap);
+}
+EXPORT_SYMBOL_GPL(ntmp_clear_eid_bitmap);
+
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs)
 {
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index e8b1bd802f19..4d329488763d 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -266,6 +266,8 @@ struct bpt_cfge_data {
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
 void ntmp_free_cbdr(struct netc_cbdr *cbdr);
+u32 ntmp_lookup_free_eid(unsigned long *bitmap, u32 size);
+void ntmp_clear_eid_bitmap(unsigned long *bitmap, u32 entry_id);
 
 /* NTMP APIs */
 int ntmp_maft_add_entry(struct ntmp_user *user, u32 entry_id,
-- 
2.34.1


