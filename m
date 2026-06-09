Return-Path: <linuxppc-dev+bounces-22300-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026EBCD8C85
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 03:27:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZDqd0s6hz3brt;
	Tue, 09 Jun 2026 13:27:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780975645;
	cv=pass; b=FFv7hAlskM9njdO/fS+61g4O/IOaX2XNrsS02yh3qhrrV6Q7QuD7OOfsovA0m+rD1bdvN2no5bN9ll6xVv2ur3kW0FkAwQW7mKLo7ZZv99QQjevMKGDf6gmCp6mWg2NJ78Fo2I9zMBT8rHU1ACVqEOBr0r2w8jwAO5kdgETNqIhOuCRATROA7C5vR0zDwjtmsygpsHcLMOJd7oVAXEUT2USq2qf9Xh2GzQ0WBspDKGDjBcQurLT+A6n/uwgz//wssIi4HlaOILf6w+f8YtmobM1g80h2HhLFtNL6utIJt2yDuMgTtEEkcQChxGL0U7nqxy9KEBNDUSqXJ9pRkr4l/A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780975645; c=relaxed/relaxed;
	bh=NO3q3FjeZxoBvWVc1q8if2QrGoMmsDL+VfIf8U72prQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OH8i4xUy9VaAwPaHc+6GMWY+ZLHC/UpiBD6Nde6Y53xCkfKATDESqHuFaqCrhQVRj7kfkd2XRYZwco+/a33+2gjCQ3TgWG6g5YHr7Dk0Fswf+sNLooMH8l8tZ9AwrjtSWaWC8ERbt3u7PW0Da2YB67/+C5Mv0+7ugbgZZr64tmQLQO4CXq4JpqeV/PhFXxis0bl5u3vTvqeCdmuWSq3mD2JNa7a8IwMMVIORz9xxqr64npE6q4Zyjn0KE8TmYHpJhivIPjS/fmjE0jwE8RVNspDiWcGyU6vWWxDsTqutp7QC+iHAswGX8q8wiXGVPGWMoQENTWYdGjkY37f/wLcZqA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=u8hUFSP9; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=u8hUFSP9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZDqb6sKgz3bsj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 13:27:23 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WREinlYhtorFdCjVviwBEhBV5eJSVk+fWwwU4fTfGqa1icEi7+SoD7cJpPYcS0bU0NTWyTzGmz0+cyOITAlDhfbkfLOq+36txwi0/7GjpwRnTwzigg+8aOwClRxkiNj4MnxCehaIAui9qU/Wz27n6/LNZq0uB2sAF+/QH4ClgpiakM1YqeG8UkOjcQvHStWqguyAQ4UzUxvoOKCIB3fmMlHQZwqebMkT9PLH5WBkPoTI+qT7LQfW/grAk0IegmlJZ0ZLgC1ekOrF1cWNF0C3moha+Tt5spllyCirjlB5bi8fE58332u5G1vk77mguKfzuNBXfMhQjf6KsalhwoUhew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO3q3FjeZxoBvWVc1q8if2QrGoMmsDL+VfIf8U72prQ=;
 b=bNlC3CVcTDRgyCGXBazMUZyT9KpeF2Lx+UtvzHDZ7E9saBUBhaf5O08RTA2/r3nd755ThwJWSBAWLMfEWavLGhvcwDvPokstz2vFLvcauAx728Z+7q+f6S0lgflYkP27Pc7V70KwDfAYJiezm1QTZ72Ee0pZ9I0/0iFgHLEtnKw4MGwF1HJLCdl/gOZJPaT6gWXzLb7dhb8z22+vIM049od5wnRSHYad7NO/zIWFLkCCYi2Rm6yQqxqj0wNtwmzgomZJwih2m3MXJWpsIGVnvzjcpitz3CeOdIZ96PBJ3UoGHipKjRrax3awaNf55n/UJASyu6tfWSIeQNXKAflpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO3q3FjeZxoBvWVc1q8if2QrGoMmsDL+VfIf8U72prQ=;
 b=u8hUFSP90ulxWX0rk2YJYUIINkuRQaeaFqTiUPJd5I9X6EsOYuaZzxOMB68UhJ3MqRmNXv/AHDPE3GybxRdnhMIjSxBdNIXcXtghgx9kmuIUvAa7ob/UvM+VlgvG2FFt7EZrzvAYvyESju6HzK26X+pqAwFbEiqjCP6HAh53rYAKieKZ/iYX/G7HdYnadN0gBMuc9xZCc7J6aS/uwcCpjo3ClSrwft4WZ3Fo5oHaN9nrLAPXtF9fOaE5p+QfiaaB4sN/xNEFtcwyXYiint0pQrvWIkUpHUas+5Kksi8dxXnGiQ/Nmbfjqij3WUNJ+rPDOlUVvFM34YoNBNtA7j1YDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 9 Jun
 2026 03:27:22 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:27:22 +0000
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
Subject: [PATCH v4 net-next 4/9] net: enetc: add "Update" operation to the egress count table
Date: Tue,  9 Jun 2026 11:29:50 +0800
Message-Id: <20260609032955.2066089-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
References: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::19) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 548a8c6a-4a10-4521-07ee-08dec5d704e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|22082099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	9w2CnpYem6iyvTcYePKXcR5kScmPfGOkI9DeRWYQcgpMx6Nchu5XPTcfOcqGdbO4b3ETFW8u5gPeOu1KNwGkdvCAUGWHe1R9GmOf2aNTADlwokKtnA2vEj3liYVyHzTp7YpSCq4oJykNm9cYCHzHrHPjCs4NC5hFWnAWi6UQyOiQ5H5m/Lajm3UqEJ5VdYxpK9G5MOeW8P4uh9L3YsjSllVg6fyqygPrY8kA1/3pSPpbLfW83h9oZg2sPrbVm5JpCCUOzi8yUzQGX7/l+aXlbZFXettPicphbxPl964TIXStmhWcL68u7r1dLkWNXOF1ry4WnSlBd8qo5e31uB2TDiinvB0HhfGJd52l85nV9wNea7Gb0pbWJVgeyf86fUKcB6LqG/euy3JugzwW5x3TpoZ29Eb+fJqJJXcU2s3Nju1Ck5lF+ZWwMkhc5ynhx/pJh67Puwbr9/kokc+8YXQerRGtwOATiYO215xgMFqGGWVNcfxKEUzTCIEYs7bFOZcE7F6UCGEP1OBl0Q78Fr3RIa90M2YsIfNIhMcscDOpv2mgaxiN/UWpOgfGnHVx3+Kss2lGerizWqYCorex6eSkEXXnvHXZrfCy01lu1FyrI+7eaEf6AnEefRWTGitqN0aEfLSjPeIsQb4VHEGZiH0phvZQu/atjDmLfLsy08z65NxcJfdgGZc1gGOEMeMiASAOQIA+TON54kCnPSnxgsI8CbvddulVulBfLbqlzFFp/PU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(22082099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2S6Xdi3Y0wqRxQBVP+OuEkc5M4qB5s99Y9Dq5ZbM5pw9/ZXjWnpojpMr2e42?=
 =?us-ascii?Q?Rd8bY7uLe1ckWz6Xg0eCh3DC99bo+p1HjzBn/35lE660YIAYO1M5tGkcyfuk?=
 =?us-ascii?Q?yXEOlgklRsZR2aOc8PLkBEQKYz1mqhchMF8vhRdgIU0qmVDjRj6B+cJKvlfT?=
 =?us-ascii?Q?/BMCEK84BDM7HOf1cpd5Hl3W4e8KFxpENd1l23T0xx5im0uksRFIy3fuPyA9?=
 =?us-ascii?Q?xYVqouxp5+FVx5oTK33Tmibe9cLwgcibKIfBsaD/z3Y5zpI6Sa9mJvwVwtn3?=
 =?us-ascii?Q?KdvCOvZnep0Ue2v3cWUHpwxUPQ1+VQV0YfJh061GKWAoz7CLqxs0uPYFswvh?=
 =?us-ascii?Q?WETnOf1iAB8blNkvy+/HnfILdl2p9ITxupXKmKziXCb6QAO3Y/sAXhNQ3tJM?=
 =?us-ascii?Q?ZEjFP5o4mCE8eOBrq9Wt1dqKsfjQzF8o5fkeRi+x+XrlwOenJpV8hjhORU+G?=
 =?us-ascii?Q?yccswMrc6Unjljmw5qnNRs+Uh4X2rtKh0UrPujFRbwF4Z4OwS6trhR/Cj4N6?=
 =?us-ascii?Q?+0A3W7K0ZZy/nFSSznLlwqK7Nunp1w3VMKiCSHAyWDJRU1AxhkSjaYChQBji?=
 =?us-ascii?Q?BL3fusJuv50HJZti2sFaOdAiByLmFvbT5P3NIcWcJYywzUrhNXepfwDaFT7g?=
 =?us-ascii?Q?wzyiADt366ahvhnyAx7kaoMnV7bpfmOQL2qFWl7QaSE1I5N1REQ5kNoeUff0?=
 =?us-ascii?Q?OOs1sNxt3BMiR76j0gndcDVvuRW8mOzs+SuVHOydl42vgbJCON9PC+YCWjj7?=
 =?us-ascii?Q?Cit8MZBtziwYEI+6KKohVcXQeYz1AzAdhQ7a0IrpgEgF+GhBJHYX37XmPGtL?=
 =?us-ascii?Q?Uk8+VF7ZKDXL2J/V+FbonvfHlnv06DpA1BMIxIfGgJHPu/3c2SnSVa0WECMq?=
 =?us-ascii?Q?PD+PvQE8dHiM+gvesHIfokSwuz7gy3e9BQlNi+QwUHGX6Ryr623p7ItE4Wmz?=
 =?us-ascii?Q?t997IukD6PNI+TQFKkqTLv6iUjpKmpFhvPthiuSF2gmov5pSNb1gmRFsr791?=
 =?us-ascii?Q?EhJGmV86fPhbnZ3paM5LXtiv5LkD/is6K/HWrRETZcvz/JyUk1mx7uq8A5dZ?=
 =?us-ascii?Q?lhLSTgfnKfwQr4wC1rHZ9qnGwkmReYVl36WfVffiydP6QnmEBtHJHKuHRRiM?=
 =?us-ascii?Q?N7JsOmUqJrdmCjdPJc1PcMM468pWOmIaq99sAHHNN/0oI8khVeZm8eqSzPos?=
 =?us-ascii?Q?n1zbPAwg/WDpVMOPBTfgmgFVOl3QclL5RhqNAX+GAp97A2mIilq6lOpCQDPM?=
 =?us-ascii?Q?LkY89hm2lN92jqZWzyawknjXegEBJvb+wGJ3NoZALBminJZ5XvABSj2gi2O3?=
 =?us-ascii?Q?+xUO/7BCAodw9tssMPTQ+PuENF3BepV5ERr4c7U7oQ8ce17rZssVeTpb+MRZ?=
 =?us-ascii?Q?wEAvcK8bggNJXtMUHJDAOqWjirjLRlUXBHnQ+wtUi8ZsfTxZus9nQwBC6A8K?=
 =?us-ascii?Q?vJgEcyz2faIILwRFTWREczSuJlFz9jcbFNssIGMYBcC6CynLaSUTrkrEhIWx?=
 =?us-ascii?Q?H8FWpDDauAQu0cR8T9+YhUQs+qQd7m6hTXXO55l1/QA/FiaR1OnkhaHYPGj/?=
 =?us-ascii?Q?wPVmaDv2jfxJJvlDwVdtbhd//Btu6ax8l4hdVXVwIcQ+2vpzoijXkBjxTNO3?=
 =?us-ascii?Q?MCrv9UXGQE3riDgy4N/AcMiQZk+PSYVPx5t96sON8k/99KOkd80wBB3ILPvT?=
 =?us-ascii?Q?H5pLZvQ7zB+7/fb8TibosGa0oScEE+TdrB+2EAHfL9F8eTtULuV966zMEzgf?=
 =?us-ascii?Q?COP8pbrvI4d14pOUjpt8i//kKGKAn27KAOc/kQsUb67PZbJScKOE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 548a8c6a-4a10-4521-07ee-08dec5d704e2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:27:22.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PU1EsFbj0ogHuSqc7uMblfcTqdI/0owGJ1QThkGj3c7wx2eOSQ0FJ/TMO7Qca0w0bTsqdmJfnRn1eLhxV84w4XW/OOuYj8ZLMhz5MnqdQmmRU7gWGojC2M0IGfPycLKh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946

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


