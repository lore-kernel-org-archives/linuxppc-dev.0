Return-Path: <linuxppc-dev+bounces-24928-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F20DC53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 10:42:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8X981vhDz2ynW;
	Tue, 28 Jul 2026 20:42:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785235356;
	cv=pass; b=SM9Q7wJUgYc1prvbdIwzzA7wpCf0iKMuJl8ROBJkqOZd3p4Ust8GvYuJtTTO57nna0SpP/If8ti+uU7WndVlxVH88qKe4ppp+/CZt9mCwfYx/N+TMM7PoF2NR8jTznGXrnHhi0m529PCiL6L02Fk5pzRH662e2ZrKNzYNHX3rNuss74JiMgRjTb3Ztc1Jq69NeUEKI2QirDZ0cPcgBMO4aiBAl2pSfGByttwrCuSSlmCUQPqNGwr0bw8jTbv+y7Sy6qPoNB3TjP7weeCAa3fVXWkEDykPRL9aS8rpWvNKWgh4HYrvtIK4jCg8Tzoq61QAwyyecNOlolEBAn8dy8I/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785235356; c=relaxed/relaxed;
	bh=/QouqZrAZwxsElak+C5BzMD7oMeQBq+dQQ9xmggQOzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h40vzsnC/3wBqfZT6+tpEx8+gC8vdZPVHtavk2uIKcaFkPxYsn/dE6lY3Es3MBr96UaBlyj1VM/QKtyuVTL9WVIyeZhSyWU2mQJkYD2ML9GUX6hY2OyLB49Lwws4yHojwgYIPBhx9AAIXHKXORQ8SK8lTWTcDRDD9RJpRoGAYPhqJ6kogTFTGwpyW/hE57MjmXux7ihISxkrG/VvehDBRc0PERsj+SXH/aM3kyupE3SgLfW29Kad/dryxdfqDT9PJu/ClPbh8P7UQOkrswClmXZclebQIWE+NraUuT1ClPv/qpKnXWk9hdsQSL75uUguT0KHqQyJ6xEODFGfnG/F3g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=A3z3NIAP; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=A3z3NIAP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8X974NSKz2yl2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 20:42:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBQDSo88kcXdSskwgO9dBIzndNwjYtxInKGe/bTTe35/Fg5hzzg3OAv9momC/WCsdkP0KoZ4JxbcNJWRqxvdoMmdSd+3bQd2nky7EoKD9FpTkyy6VTlfOt1g70yvvauAco7Q/DjyCig2R12kyWxSv35i0aOmjpzH+6K3Vyz5xqhaLqbVULQo4u2jwdZa6fD6BB5Jbze25oRtg0W7psHZgtVUdzC2D2Flc/RkC15AuOQkI1TPkE0gZIVnQ8DDxgqnraXVjUOLD6VXVfOKom7KsRr2HXVWRut3h57E02KhBs2pPth2+y7i5XYkM9S0K06kY0m0dXutyvelT3NWfBEZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QouqZrAZwxsElak+C5BzMD7oMeQBq+dQQ9xmggQOzU=;
 b=kL2uLltYtygaCdDeagzVHCUbyV6huGmjshEiY+oN+s1NqIRPLNEJu/yW8QjO/+KhTtJSx7IsyrFCInXDQUWnEwj72cwSmEc0o3wwK2qDsr3Bz12CkLnhFAb9k4QWijQsCFRBAN/k0HZogIr1Lfs2zixqPK2gXiIrt86XNGia9Px/v+lyO/ulzqbdtpI8x9zkBdFXPSX+rW0DhOI9KkmJQ0O+UJW5EO5xOZFvni7aZOhpT29hf2acI92BxcUmn6xzV95mp9oRfYL3mB5fxAuW+4nT1cEBdHgmLCmodY9Y7lvDSG8gKDkph+8QUb9to8HkV+8rblejedr1usMrXovkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QouqZrAZwxsElak+C5BzMD7oMeQBq+dQQ9xmggQOzU=;
 b=A3z3NIAP5AV82+Z+ZwsrGwdO6c5NB6udG+89IlGOpN1o8oRJ4azHQWRV5eliK4eLOIFgIjuKPbSkf2PAXXcHLK0376knzpgpFhDiT7AGwOw2Fr6udV0geFRxdrOqQDVNyDFMIIVg4CttxBV+cSICVYj/Z4MlJwTNVzn8TaVl1SWwiUl6pcDwpT8AKe7aHqx0/LSNdCeSNMlAGSMcqHcVkNNFvjP2tU/Q4VNlD/lYLYaonYipkhk7qnX3yhs4FRDqBV8zdRNlIAOH9588MNqHgE+4GEcz1MM5JRl5cTaQjLLKZ1vbAv2+kQ6vwUBoxwQj+FyOxUF7CTpatPgvcL993g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV2PR04MB11835.eurprd04.prod.outlook.com (2603:10a6:150:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:42:16 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:42:16 +0000
From: wei.fang@oss.nxp.com
To: richardcochran@gmail.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	chleroy@kernel.org,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 2/7] ptp: netc: remove unnecessary pcie_flr() call in probe
Date: Tue, 28 Jul 2026 18:45:43 +0800
Message-Id: <20260728104548.3301214-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
References: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:295::15) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
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
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV2PR04MB11835:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3df9fb-cd99-45b7-d68d-08deec94e41d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	1k5SPPSqYLJtaZcH0UaOvOaFmBH5+0/MYYesU2F47z8ibV1E/IPPm4JTyYGGRS75sPBAaT4rKz+TotiG1GtnBlxMVWRzDm5623uudvP5lin9fvIyQVB8/yLGKIkO2eTk827f0jwu4ixMGmgAYwaCXZaT2fBcGmz7L8m3Txre/633FWuEp0RLXnhbWXoUg4zyTpu9ImycHkT1EkDnF6NO1HFZ7O4/WKfgF3H34EOGQqkwRoxmZszV54C3gIXmnV2L5EUv48dzOfUMjK+Y0gEJ8EiL1P1nRCoOCYwqTkRKcV5Rjw2oPnVDQMp8L64B+RBEDrUVENCZd/2Gqhl7DLXL7kCl10MSUyvE0nu80fSs5bg0XUwlt/UUyo4eh7lffu7bBu4JMEDBbP5jjIwMfg4Ud0awFpV22x3gMffaih95hkdBaOspYCGkx7PBsSYBQE6k8Mgm4IOL7q5pGN80OMc8rB2UluexojSvKz8cCoPVxBU8bvsD5tcQvRku0VwtoTDSB8TQyLyvXaJm5imZ2+wkdbLUnmx0mW1JckYMpdAsrTQM0dprs7ZRT7fGlV0Tlhyi2DCAa8/yCjJtWUj4tMglHFCJnj2G2FtOkv6zWLLCXAj/fA+sA2RpXifalOsymyq+oNt9s7ff+2vhAwRnvzheD0XJg5Tsz1PPsFpfmYpuGDGS3R3fegCzBVce18c68sCorwQJkJnUgXqRUvEqO7CeZw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BSuzMFAQn5GVB+DwbUmIDKmGNVfgyQwoHSSGLavbmTK3NoLUVCOvMAhEr5Fi?=
 =?us-ascii?Q?h+ioqwOr4ik/qQ5dpGeeUejNY9Hq9xF9yK8wxWkNCq2YFsRdxqjT8xHawfi9?=
 =?us-ascii?Q?6D/afEfWQonH8o0M17SIUYn34XtWpQDQ70PFqXcP0Omcosf2ApOKzJFmWO9/?=
 =?us-ascii?Q?6lMmarVdyw8gbXTvlK+Lf0n8EFSREd3IFB4o9fOyOVSPkXGLF8LnSSJyWm/k?=
 =?us-ascii?Q?Nv0sl7yyQD3+tdV1hEXGCds+Ui9Q5E8tB4bO7QEtXsoQnC6rns55IXS037vA?=
 =?us-ascii?Q?agd56faPUkxl729GuBCFprPoN7qaqL+i4s+bVom5Z6qcHqyPQhBK98Ni/MtN?=
 =?us-ascii?Q?puCixuZYc8UqCVDxL6bgqwpi3wey83b3MOgNPYZiPCTlbIE5jbsa3cLdPQpG?=
 =?us-ascii?Q?JusGfqhYgIiRacEcN7Xrv8g9vYHTqmZRVQhGH3U1zDUamHm61of16saedyBA?=
 =?us-ascii?Q?Fkr2xA5cpC8yqJvythA7voofAazHGC5AmGnfJ+ZzK1tsq9VCysqWQVyGZsqt?=
 =?us-ascii?Q?ZJ7wB/8FRolENPW0ts3iGbP6Zx9HhvJnUoAfZXz/l9+lBI0fN7dXBXiC6Mgp?=
 =?us-ascii?Q?H0Qe9n8wj3Tk5/Xbrj0kxlQ1GI22yYj4pXy28Hfv/4B2OeBMNZxT4kkXISTy?=
 =?us-ascii?Q?fEJoWKx+v3keQ4tmezfxkLM/gGBlDAtRKS/+FlB9KSQictKvjbqAN9sa0M+1?=
 =?us-ascii?Q?B/rUDChxBQSTeJL4SGE+HrmoRiWucrD0fAxLcQWBmaQvb2yu7aH1jmeADI47?=
 =?us-ascii?Q?I7VqDBQJ/W/PhN2dnFHhEqmyC4FTzvlIC9NxtVtG33yInrbqVwwmoYSdjpEs?=
 =?us-ascii?Q?wFNHnuVuZN7OoAXkJUHDqVW8Nya08BBj85ics4EOzjPc+hZFFcbLOOhKVD/4?=
 =?us-ascii?Q?BysF3DBAWF/Qw6k/Qt40CB3dQymX2hkXznCm+DGa5kuk9+lxtKCbMPMo2Uhs?=
 =?us-ascii?Q?YgylYg0RzVNB8i4ed8WIeDZoD+6A037D9YhOxbmYp9ZCRtfpt2CLT4mXLXuO?=
 =?us-ascii?Q?T2NrI9KvcT7hK2pLQrcTYPZpAdCOcZhBjZHt/rpPYZgalPOuxaszr/OTSb2r?=
 =?us-ascii?Q?UGEZiB9NAkfbEjqXyx4r9ApigP5qVFWfGrqd4mL3HkxJmTXz/5Ryhb/l0xSs?=
 =?us-ascii?Q?oJE/hI/1gB6UokRD5QNVOS1teituZCyZHpf4fyxgq9TSkKyadTCykuGOK6yt?=
 =?us-ascii?Q?9bl7lSC6TkCAqG2F390eQcSMnQe4DnPyejygsAA97DSfnih7rxryce8vQlfk?=
 =?us-ascii?Q?/H8oFtZsaRWSNWFGwytMBpPbX4pMot43g5ycqf40/pAv6hHXGZ/qq/WvZdBu?=
 =?us-ascii?Q?YHg3U6cG8nlwG6YAOfEWfAgw5G53JthsLh7tDfIQFfvCrhthDgV7ArCgLJH3?=
 =?us-ascii?Q?gp9ReUXLveAS6FBEzAtik4NFYX3MmrogtB60Op7yLZBBQ4WqCtZJoHd+JPih?=
 =?us-ascii?Q?rx3/PPZTy4BtUHE5h6CivyM9t5BLXxirV0+JKBKESdbG57T+u5zQ0TkZNtZc?=
 =?us-ascii?Q?tiYwmw3aOlr6mQHV7+wOIdgsR01Q914N1EN2/vaDJE3jeVhMKHXPLKMVZqeJ?=
 =?us-ascii?Q?YKGDk4xWaquDrDeDOOTUcaEzHxn03/0Pbc2A3ErEKC5wTc7K+1D/6RrgK2cZ?=
 =?us-ascii?Q?xoiCs2XXhcA+iSIDuSn2PuyDEL1lSDLiBcrNxIWqbnXoPcrA/BGHcuwcgLY8?=
 =?us-ascii?Q?0kM2lcOOBEgsHau8AE2Jdd5LMzMIbTunQSwo78sbZhj9tU/x0IHKwNsRhXLc?=
 =?us-ascii?Q?FqZzF1w11L1qxT1qu1YxkNlo1j6SvQxF979kf1GuL0n2l9GrGpYz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3df9fb-cd99-45b7-d68d-08deec94e41d
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:42:16.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8Jm1mDHOlj3I9GT4zU/3WUtXdclj9XWuarbb0EcnmEzJg1uwDZsCEnIh8VmtyJTFrlk3GlDC4zB8+sxT+TSuo2DfAXGMo5spYJVZ6JI7XE04AAkidHMCOjhTMQEEwtI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11835

From: Wei Fang <wei.fang@nxp.com>

According to the NETC reference manual, function level reset is not
applicable to the timer as a supporting function. Remove the pcie_flr()
call from netc_timer_pci_probe() as it has no effect.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 78c6d235127d..6fd62e708fdd 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -772,7 +772,6 @@ static int netc_timer_pci_probe(struct pci_dev *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	pcie_flr(pdev);
 	err = pci_enable_device_mem(pdev);
 	if (err)
 		return dev_err_probe(dev, err, "Failed to enable device\n");
-- 
2.34.1


