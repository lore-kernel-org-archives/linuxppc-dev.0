Return-Path: <linuxppc-dev+bounces-20264-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E76FF8877
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:58:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5CSF1G8fz2yrT;
	Wed, 29 Apr 2026 19:58:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777456733;
	cv=pass; b=nsneWS4bM41kYgwQUu1r/25Ii8SJx/5rHgxJVWPsFdFvWHAxkBcwjd8bFRgMWioHpFMZvr7xKCnSI5fW/S6XUDa0lJWbp7Re4ALFcKtBmaFFLs7xutFByORXQiYE0S5IFdCfYyuxuae9BmeMSRfpvtwMmtAs/MAPL1Dt7DPmnGzdYNat3SGmXBS+9aK1lPI9HHyQpR9S6+nFLHwW4pRfTBp8v30/xsPUHwouC0k6TCI7Vn3843yeAMk+G1OC2hvcgzfYaBCYSjiPfMvat9u6/JwA2O69HtMPqHFuVqRaPU6Zp/EY6h8ipDJVMD3Ri6Xu+Cch88bea76A/tru1hDJ1A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777456733; c=relaxed/relaxed;
	bh=WGjcGfh6rZFSyH+EJF3nu7I+miScj+Z0EKlyoHzPofg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZhDcOzhqCZ0W61f7gni/802mY/JUY5SYobwSVMdlRYzYXSE5ccoRhD3X+JkqGAW5CST4D3wnZGkKpUcOVQGDLQmv9REARJV3D+GWk6dfccXtMvGViVuyEVsIFl7lqk7eVRIcc9LRkkMiUWNspX2f/gn7EfLDjHwyF5WhiCiBWwMf8/E56IU4QUsYnCvAWhQyBElHstrHcTAen6QEZJBAMqHlnT5Vt9eJ13NRtbGnGYpcLCyAv77f6cX1WIVHGwYVm/D9xz94WGWxjMzMEwVYInVzGLsmEW0jFqYsV9ehakdmMjad2RtsuNstL2cLVJAhHXEN04b27mKE54TK7tBjyw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=DgJrFsPP; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=DgJrFsPP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5CSD3B9vz2ypw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 19:58:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6sVdoKp1kBrmG+5YrCohw78RxwLnaCNMp/kxY2G49PCxFgso7TFSgYJiRSPR8OQq16/mCQvvEFGrMTRq9XbkUy28+fGnTYaEGI6PFN2nPX/iwyZ8l9At60DnXhswP4gNWFEFKqe35rMHBWLFDRn7IIszFsjk1YiSoe2tXGvGCGEvw33k3JZhbdceiJrjJ2LSOA42hyzMse1LRUjMVoXzPips8LXsmQqW5bmMV9rI1pnREvtb9LI1K68pKETTdVx0SfB7k+Ylk4Wh3mS7aeiET4PQhIIUMLlJd4owvc6O4FMZdX4sw7PlVMDPcstP2uRDhF3CtEM7r7ms4hw1oQDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGjcGfh6rZFSyH+EJF3nu7I+miScj+Z0EKlyoHzPofg=;
 b=VMDk6Giw7lsyxHiXimGSNVoNK4w4+NeLWKo1bikYd1H4UPm27Or17chr15nBHB7hNM2XW7MjKtNA3GKHvbtl3W3rcusQLzHNqRVOVUzq61BRZTcHJNhVTXOc4GDl2mSF0mLPGMDWkeV3FhSU8/lDbjf54DljH/VmNl9FO3FNqe+cqJi2JdsTajnqV7UEygwi10zl59q8RUIk9YBU73OAhffcD9LpqjBxuLNPhckcEivnVdlytr0GVnA3id7+zxwtKSbiSJ3eu3bi3OlPIK6OBdW+J3cZdZ0jEnlXffpG0OovIq2PjMLJPCyP/3VDqDKsu4H/sCnao4WfDTGDP/gy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGjcGfh6rZFSyH+EJF3nu7I+miScj+Z0EKlyoHzPofg=;
 b=DgJrFsPP9XQtumMr32YzuMoA5BzfbIs/oOl/9mzZ0CXz7YOa2Ycfc4juwzsmG4pEnUhU0j3D9SfimlERFYC6Fp1D4Vco50uCrmL1fvDaUtLELGWmtPDx9cX97/W1Fq3KSVSKoOJV0srMbGXK8HJ6xIissBt5aTyMcwYM1r0Hk0E8mETKNTCwvhD+nvyhAT7PxNpgRzU43mL6POSYviimR8plGT0f6+ENV7pJuADbkxyHx0GuGiBYcXQjXRdd8R+eLAW4zdS+YD/U40MZzyhnytyluP/kqYx071gN881Z9tA12vMHlkN5uXW0jfwP6T7f2YlvILVNOSUbDPjXLWkLqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 09:58:31 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 09:58:31 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
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
Subject: [PATCH v2 1/5] ASoC: fsl-asoc-card: enable dpcm_merged_chan flag for ASRC frontend
Date: Wed, 29 Apr 2026 18:00:23 +0800
Message-Id: <20260429100028.2739711-2-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260429100028.2739711-1-shengjiu.wang@nxp.com>
References: <20260429100028.2739711-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeafa71-6736-46e1-e57a-08dea5d5de56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|56012099003|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	cHZKiy70SggED1R8ER2QfUhfKhlXYKv9UukyOBprTQWLQPln8q1o0aJAhu/nQOXR1juuNhP9B95MTDBWVcRDqZPT0HpiABtXMJwJG+idnabi7bNRwIT267hO2SL2kW3FklAoV18wFEujAQmxjiZDYtlkIV2MVnxLvy3W+VJZDwu2s2acvI2NwbAMWTYpqcEOQIjnhWZzfDqdmcjl/4EkooiBiwmAog17GJQo0alpQPga8dsw5Yx55frQ1gcEH+d4z5ur3H4l8J4PTpWsnaWJgt8joJmPzY7WHZ/GB/NjQM9kt5nkrtNVYqCRtTQd8CmKb1x7cJRIRtG3QJyCZ4MOS/o/YAujzuwI/70kZZ3iAiSY+rYnvujdByppPT+XaF+K3b31vcl/HlcjWImTejraO0WnNunyKgSagA98Dl4ip7m4b15Dswxh/jORLILRivKtRfVDEcZqwXGk5nJ6Zrr5DIKJCElME4ILTBN+6MFJVsy6PyS0fgtnxpjCSlKcizPqMG2RgtYNQJCrdHhcH3bGN2cgbIjecZ2Y5Kw+q587aJz6oEO3bKDFVsxPST54BcfJkhB3Z+Zm4iR/1cqL2WXzj3pWBOxVMe9pjQwn4zjdln7X4WdtSrJKlcQZUX/W4kMz8gDH3HOnGZ59Cly8R45v+vxOhL2xw4v9bWwd5OMy7iS6Sz2unQsKk2d/sCJekTfznfkRzjrW2cKcHEahVy312h4iBPX/x71j77peG1jrKOipQFUDxstie7HfNAjEuGR/5/lNVBBWfASSfwAt/QZ79wOhEku6yLeYo+oEFHGAHRt1Tceb3rLNhKE69KKiCMMT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f93bvOomBmLCgogWcULhuGM0rcjXYIYt+eFaYiKeVP2/ZEzUL0XhDhIZvk4b?=
 =?us-ascii?Q?8zlj/euWN83Dm5EFX/jieZGJQXvvY5VwpFzp2veaMq1Y+TEoUNWiexJu24D/?=
 =?us-ascii?Q?CXuSENSkFtYgR3m8CqPcRyTJYskUxF9MO1uGbQFM2FDBsep2MIOTefZnb31F?=
 =?us-ascii?Q?rWI4sfEFKLtfRZmEqZYuwbXj0XGCIFUERPZLRz5fzB4afs7x5RDrm9v8cr6J?=
 =?us-ascii?Q?ACE/oSrr4qiK2BucdAEjIhZ7EkcuU0XZePepEyM9NTNRzcJ8oJQ/0DE6PDV7?=
 =?us-ascii?Q?RsVSQfB2wUiUufNNyIfbCwlKPFyVFd/CTA87T1dqPTVK8q6eFLxfNzVgjUX6?=
 =?us-ascii?Q?pGgDs/9zmmzQW/Dxlgv4Mg95w4H9FVq/U3vfs4H2gvlInLojz5TUSQnUqly5?=
 =?us-ascii?Q?4vuTH7ldVl7XfiZZ5i8nCs9n/d5DqKRVk3PabSHP9st4v9948gr7b5B89BB8?=
 =?us-ascii?Q?NHzi2I/jCLK5oDFUwaIRceHBpYc3QMZpIOC2Pjq8whfjOLmyWpkUNsSxHxb8?=
 =?us-ascii?Q?odDP5mcPB5TkIYU1Za1o7tH88Z+o86kh6bk0Uop1BTgq+r+12bMZ/M4T8REr?=
 =?us-ascii?Q?1dcdnW2sktc65+ggm5Dq/mWOU7vx6y15M9iCN1cHpZC5AswXWaTzW0ICeCsS?=
 =?us-ascii?Q?l4e4jCn7aBDKStjgNna92GHYOHb8NwKhnOda4jfdVopWe1IzF4y15bJpcUc4?=
 =?us-ascii?Q?MI0lR7tgrEZ/LEzIl9VARUF/rbNOWu1V8WsOjWRP6cEhVqQBugQPsg1y3YPw?=
 =?us-ascii?Q?SqIhasS5BBczCfs8yNLy1529a1ciSlzTAfPa2yIBFoAy79Xy5PDftjG6WRf5?=
 =?us-ascii?Q?t0vGd0xPQqzMQxS2mapomDL/Dv/SG26FtpDcXA6Vg0nVOILbSVMLTms1ulBX?=
 =?us-ascii?Q?/V0c5egfeeAgtjzdiRHJ+cggOKRkzcyzfRyZymNx4UIRCBqdPxVnir7C5MTf?=
 =?us-ascii?Q?bfUfrCAJsYcVjmPpWbkKhb6YUp3RFk0rsBBAzP5ZtGs+4mNKhLQK9xH+ufAQ?=
 =?us-ascii?Q?eCmjgNc4Pkdb69epvJgjfBQM+p86HD4srlTdCbho5LmIWHRcOeNDuNzEZgbh?=
 =?us-ascii?Q?PZupeHJkhOcdQyyoeGCQtADot+ioZLlXawKMTGsTlIMojN/UxVt0xx+su4zO?=
 =?us-ascii?Q?EZP7zEVdNzRPshXaxXINRSFIRaRXGZr+XfHg3Kib7E5uKrlvfB2UmVDdzuDa?=
 =?us-ascii?Q?/JMIHSiUoLtVoyBraVgd22LMuA3//e4XZRUQOZcj4yOUVNrBXUZushECtcSi?=
 =?us-ascii?Q?l6/GC+k97kZafdd6lKS2KD+ahoK0MrdZQYdT/C07TwMmaSLOIEmkwekw8mNr?=
 =?us-ascii?Q?N1CiHtIqiVuUFLTy7cmidFDiXIgNvvLyNEaaGEl+ZpG4rCGIPWHI/ZDty1U8?=
 =?us-ascii?Q?5T4c293ghLxpHSx/ezWfsjw+2ZwNrZY91To9U0J1kY2mieZkIRsUE6PGnmay?=
 =?us-ascii?Q?knFUA4Zft8NnvYPgfWj6jot3oeOdPZWFSEHN359Y9k4Kc0FregTO7ol3/LJT?=
 =?us-ascii?Q?KZb6AL+kZLRXdtqOON+V4xykQ9qTZYaLfHM7Fb1PArxbJWF8gzbKJUc67Axm?=
 =?us-ascii?Q?PLFcQROcnkjLMrHgogs7C11tkaU8302ScfJnX8coLCLtuGTfCFjAljxfox7t?=
 =?us-ascii?Q?0MaJ9fg8dnFkAbKET70gONfjAPNshqUlyvEqBKXW7KpjkdU5LNa5kaiP6/RA?=
 =?us-ascii?Q?UyCpq35BupC/s4H27fy10Ea6lgaysFFGbd7VaqxNNNZbO+JTsfdjqAO4uRVN?=
 =?us-ascii?Q?9kh16DBLCA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeafa71-6736-46e1-e57a-08dea5d5de56
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 09:58:31.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLP2JmDmKOp4K+HjdNXSMFeI1lsc0Er9SllMFjvh+Xqt9nf4CNjm9nWQRHg6SmiCENkd6cuqLA+OvrwDprCY+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

When using ASRC in DPCM mode, the backend DAI (codec) may have channel
constraints that differ from the frontend. For example, the ASRC can
support 1-8 channels, but the codec might only support stereo (2 channels).

Without dpcm_merged_chan, userspace can open the frontend with unsupported
channel counts, leading to errors when the backend is configured.

Enable dpcm_merged_chan to merge backend channel constraints to the
frontend, ensuring userspace only sees valid channel configurations.

This fixes issues where applications attempt to use channel counts
that the backend codec doesn't support.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 70a6159430ed..41cd2fc2ea56 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -989,6 +989,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 
 	if (asrc_pdev) {
 		/* DPCM DAI Links only if ASRC exists */
+		priv->dai_link[1].dpcm_merged_chan = 1;
 		priv->dai_link[1].cpus->of_node = asrc_np;
 		priv->dai_link[1].platforms->of_node = asrc_np;
 		for_each_link_codecs((&(priv->dai_link[2])), codec_idx, codec_comp) {
-- 
2.34.1


