Return-Path: <linuxppc-dev+bounces-24292-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B50C4450A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 02:44:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0L8r17SLz307v;
	Wed, 15 Jul 2026 12:43:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784083436;
	cv=pass; b=nQpRjVPwKp0h7XZ9YfE4+EDthYaHfhLUJqVxTIOzE9oN0Xj9hNUxsY4EFfHD8AINqqagfq5h6DUyRxS5iWNRtefT5R5y3e3rsu+k9/etAKFtIFG7mI3DR8n31UMiVRedwSH/UsgfW0TYLrjZ56KJ9Zbp4aacRm4Q8GZF1Fv+fuafyfaqKbIQZducc8TOGPeNKOjGWmJ1ZfYhIl8KyH5iS9GNgp2xHze+fD/6OkhbTsfFx7yRtU5NQmq9i7ZmPeG90nbYB7mQq0tA8Rul+wAtDewJ/fRMuyez8EKETBw9xPforYMMi82B4xm9D5ZgYT9Bd8YpocDeInAPIey50GC4UA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784083436; c=relaxed/relaxed;
	bh=rKsDPPz9YJMZ6M4C45Uu1wlwMP6Ub/0ZLi9ygcHmqJo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X6Zi4qgov6hveNS1Z5Mj/WYP7JNBVG7e54QSJh9d44fZBjM3HpeqqzYuIknbmUJUrXtHRz9IpXlw55h6q3MPcwYNzMVLRQLNyudJl4jc4n02/iyqmEDNcGRkbsxg9RbLh5BJHzr5w3dObRZshMcbXHneNwXdsezUfGgu/tJCKsQ3F9GcaktgXcnwz3zQDKXnDZ4z6NGtQmUyBZB/W39phmxAzx32UODrdlVnjjszlmVxtuEEMEV4ooFqEaQ3NW7eko8T86G4b0gkgZ63MLKFepT6hKAmlQKmL3fUXCHxvC7FbgxOPgWe0lCnN5bq3dt0t0lOs2sLuqyGDpcGskSz+g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=bBgr8hIi; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=bBgr8hIi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0L8q2shPz2yll
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 12:43:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGH8HKUs5YJsEY2sNi5mvwkduOeWzwHRls8NLsfuDEwDyMO0GZihGnF/lTzjIQdhjNZCbVDh8rEDX9qBA4H5LQZWOt7kSR45pOGnbrE647pOhdYS/7x1WR64SBQewcPRWpJzlocFl/qpFBSdHLzZfT2wDQSWsTr0LHeLADfm9eNxzkbk6QID9oynsQr+oDzoxAOQPZn3jKtvmWArrNF0My8WwO2xirST/FpoUasBgjVa/qy+GLn1FsM6hY+8GP7AB3uUR9AmMZEaeopiBmvr9Yd/JJr1X7Uvh2XGrrus9qMxuqo8WHX8elwA49/3SVVmi1z5HjHVzE1ANXeq5yF2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKsDPPz9YJMZ6M4C45Uu1wlwMP6Ub/0ZLi9ygcHmqJo=;
 b=DRws5ej9K93z48nUQC4gt4Qgajfd7fFQ29VU0Km1MTFgNoD8EmNlldfpMYI3+7y3g1an7FA/a4Uot4l7wnwAsCUANPnuqymmRk8kRtPmTu6M5PBOGscop0KsYh2uTjxm0WKABSQp3a8froxnW1nWRKFWhalsQnaJetBTIDJ7CKRu1iSpY0Z73ULagA9TWmdMHaS88emJ2ccOlcX+G2CZZVhXLJVzaYg+5H6WQX9ABMifn40ChfvSyJUIpJIjVCiUOYTJFQm9LqTc+p5zv5vqGhqHSM26yTZd8dGMC/VPTNAisHfUKAqWx27cP+ciAMGkHjuH/2fDFVC80R40dH7BOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKsDPPz9YJMZ6M4C45Uu1wlwMP6Ub/0ZLi9ygcHmqJo=;
 b=bBgr8hIiQ2lsIauT8CCgD7fWYTRHpp9UzsEDSgkLx1oKm6BjRoOthzPuKrPWzQ8R9MsPojeWq/9xEHinNHSmwUnFdOTKzCfVQLwzaRJYgLgOeAEvWtdezgIlgZX5pNCl5vhtBIa7579OO9Y4J/gi+To93FTftnpu9llF8vhJZ6lM7z07LSTZr/+hFGFpSRscafMzn0FqW994lqj9Agv3V9AWD7BMJLWRMy7I/hqLX7XPbH0OvRSHZBIvV6DFHpUTQrR05H4Pfqps7+4TQMMZrGmPmwHF1J08z2Pd00Fk0W/HuXL5jeCeIKb4IrtTBY3/b0cmhXNS38yP+9HK5Emw4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 02:43:35 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 02:43:34 +0000
From: shengjiu.wang@oss.nxp.com
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: fsl_asrc: fix m2m_init error path to use goto instead of bare return
Date: Wed, 15 Jul 2026 10:47:57 +0800
Message-Id: <20260715024758.1252801-2-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715024758.1252801-1-shengjiu.wang@oss.nxp.com>
References: <20260715024758.1252801-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::8) To PAXPR04MB9351.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::17)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|DU2PR04MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 672bdae6-6c62-49a1-088f-08dee21adda4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|1800799024|366016|921020|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qZbXADpGeBDjn7c1lyCL7h9x4vMwYcOUzbm90kopOV73O8UfEXSlDvxa7qMdrc91q0z58zleCYZYy9zAABlZmIw4HX0Jv0DSMQUZEmXXrTQoFbJwNXJH9PqyHgYQtXsjHetb1orhvsPmafJrw0Oq/FIo7+2G1OnkSdk6mQSXBl8YE1fyl/IJZLpAjEnsXoRbiv+bAsF3DcJ9+3yYG9pB/weGQsfsDnKuA1wvajAyWV522TrhkkujLLbTCldR7+1NC1muRZFLnJLLMOTUQV6ldyi2PeodOgySkTt+Il3BzqagVx3zlhRiwtvVjxyVdK10/UzreAnSQhREj3A1uoIgmJPc3nRnD89VYL9UYtlW7AdHa62pYY0KuRyI0XF7ukiSCA5eGAGo+jHpa4Ko2STYAzrCbVgJlajTYNkBf9PyJVqx++rKhy2HNA5QeWgQ0y/6vfJnZare14vKJSYx7JDicX1DY8b1RGhbjPScbCE1cXuPB1syM40DNjGMIPVmDMaCyAToMXy1CMFChi8U4G/dx9eG5GnofF2/LY36YpMcFUuvGQI6E7Ig4HMXDV1PANlAlyCHh0ah1NRYWqMolOyVzJKJsnAH16Vmkw2joxmKao66iRm3wB2XR1NE1ZTcPDySU1KXuABcOBphBHn2Y90VyYYtRkPBNbvg23jMZ8DSQMRtDp41Y1TYm7LkoUaYpoKMTYg8AKd8u9nWykJrSE7syQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(1800799024)(366016)(921020)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gofL0aDPoRkCsfrBUbaZEsC6diuZmL1CtjOiGVmwQ81+P5dTdSSg5miz7zjS?=
 =?us-ascii?Q?+BHFpUOvjhrZXA+CYlrLhuaIvIJX+QaTCz615BxO0FDJqsIIddubGBcSVfb8?=
 =?us-ascii?Q?tgI96trYxddLhOLAvTqLvOVd1hveH9QkabBlVqyQghum24aD3HHc+u0btkXe?=
 =?us-ascii?Q?FsoCHBNovTMDkcWJN2I5b/DJ+Omq8yjG0g9KYfJvSYAOhEU9maJpcL5I30g7?=
 =?us-ascii?Q?+k1yCD8kZ5lexmxq4O1VrTG04t6Xiw/ttKntY5iMHC6IXHAFwl+2O6BBU2nb?=
 =?us-ascii?Q?Vwu2vxpTOARCI4QRafM2eFrvGCCjQUVOell60nGZNqovwI6bajovNjKWaIay?=
 =?us-ascii?Q?Jjr1FbxZHPUH+SPr+v9jNBy9JfZhcR+cga9SK83L/X+SmjgjJQje1vMOLeKi?=
 =?us-ascii?Q?+9aMOTkf5PMNeSiBC/xo3rM6FESLfayE1VKvEzv0wu/M8ScmxDRfyIEy4zD3?=
 =?us-ascii?Q?StlufzmgHzcZIIZkfr+yv6X7gGZNYS83kYRSg4tXDItxLKoYd9EHXXlDQWoR?=
 =?us-ascii?Q?SbAwBp8UlBcfCfVJt+T8vEwXLWbSaKdoQ7OXjGcObSWs6VLfYDUumOcxBXp2?=
 =?us-ascii?Q?48p1nGEQ4DmmrXxeGZ5xx3/877+4AMDN53P6jKDCUjWCd39anr7V4d7H9/qB?=
 =?us-ascii?Q?dfsXf4VzakXRErz0KnJpW+7xdf3UYFj7m9uLfydS3gl0naXWkksJvkR29N5F?=
 =?us-ascii?Q?RD1RXrLPwuuX6wHFwiu8H7O7UAAbCT8eywYWcuKgXoEgARYNht4Om6Gfh5c/?=
 =?us-ascii?Q?GesOwAbbrS7baZ1z58Dt7WzOS6VpAnlr3ObNm9iS9PFwOVRFXvxASTOPyinG?=
 =?us-ascii?Q?Cp+V/zLvZLo4/16h55lewyVg126ncSoCGdkHxS2UR6aP8G/b+GLq4m7KI0N9?=
 =?us-ascii?Q?OplxT3T0m6FT7pzxeUZ73170UYeatDVes6egXfPp3hYwip677uC6QoRVXPkh?=
 =?us-ascii?Q?dYB+r8zDw5Tg7+g2lZocOD2L1AmpZsBx49lmAXYXwYI+99yQzxxtnxz4jHfM?=
 =?us-ascii?Q?d6VC/aePdOtrLV5r5UlB63UITmOnQKex18FVxFEi1wmhwCB12D/I+05USSHQ?=
 =?us-ascii?Q?8I+K7iDis9ypwRBXOLDdLPMTEuzQZNeTzXvG3Dx+UmqmDP6Ojzeqe7Y0gQr+?=
 =?us-ascii?Q?Opdf8sE1kQGCG/7StQwBsGLEy2gLOqFbO0L7Q7hafYjiLhDWBTaGuoRZHB+C?=
 =?us-ascii?Q?T1NVdfMI1CUsBmiDHjvP7W60gq3u72ZUWMbQ+SPuuumPLFiHKruW4/pFEtmY?=
 =?us-ascii?Q?9bKIEgV+DIOwAwDBbBCVBOBCyGH1rD6GspvgJ2tsNYWcVgN/sJdH/eI0uFH1?=
 =?us-ascii?Q?9KdtKF40AgyxJlHIgBl/yIxU2oarVYrYHWmXtlXYNMXde6zicJ7ZJlWwXN+y?=
 =?us-ascii?Q?030Yz+a1Q372Xxr7bjtVDXSMe8PO10KLvY20wqXj1rGtwbo50h5YdNbs9c4B?=
 =?us-ascii?Q?Q560QXhwWiH9lflPoBHfifYRLlBpAZdcQPrlYggMZMJ0IXfzSvVs+lPEda6k?=
 =?us-ascii?Q?ND/Tj0HrJrNU1U+IIBq4u0jJEphcgdznJZS4jtB5dPTrXf8Wf0JAtOPpbJh4?=
 =?us-ascii?Q?Vg9po/aSt6KagkhbuGPZTTdcvehon6i+YH2MIKy+80B9BpCQKp7cO2qeHDKr?=
 =?us-ascii?Q?/pilG9jgSwyBI8W813Pitr33fbK1qIlUVm6iLP5HJI0/fvMUYkOA3T3J91Wh?=
 =?us-ascii?Q?Tt8NCAnJrtOnCTVYnP1Vqc1E6Z8eo1btH5XGmI+vyskE5coTrLH2cOYQotWV?=
 =?us-ascii?Q?pSmb3nTEVe/V6aLmPgzZ4ab8/OP3BOSSvM/9g6LOfQNXv43m33ba?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672bdae6-6c62-49a1-088f-08dee21adda4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 02:43:34.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOTKXjC9sQSVaelB9jEnQCdz94iVJKP0j32uZEYrWwcxMBdRbLuPm+OYqwK6EZV85JOeIIv3poYV2+VUhTRTLqjXQTJ0hQEYod4oVH3NTz9hUFf0uqfzmfeamKJWtjM0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583

From: Shengjiu Wang <shengjiu.wang@nxp.com>

When fsl_asrc_m2m_init() fails in fsl_asrc_probe(), the code did a
bare return ret, bypassing pm_runtime_disable() in err_pm_get_sync.
Use goto err_pm_get_sync to ensure proper cleanup on failure.

Fixes: 286d658477a4 ("ASoC: fsl_asrc: register m2m platform device")
Cc: stable@vger.kernel.org
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 0b28bcfa47fe..df4817ae91b1 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1413,7 +1413,7 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	ret = fsl_asrc_m2m_init(asrc);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to init m2m device %d\n", ret);
-		return ret;
+		goto err_pm_get_sync;
 	}
 
 	return 0;
-- 
2.34.1


