Return-Path: <linuxppc-dev+bounces-20747-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5724CD4855
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 06:51:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF6gd36Tlz2ySN;
	Tue, 12 May 2026 16:51:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778568669;
	cv=pass; b=kTIDgTuVKsFUKLxKSNaNqkmn2xldJjD4ro/lmtwZlwxwOv/h0Hl7tlYLo+X1nU9mBGPT3mJXJYuArQk/CkHIrfrrcu9B6hSzUz+fsH6L+o4X5zUipwOM83+Pt68nP++7JjKDWPhYPAOgHQDo5uKJ5GuHTsVgOnskxgDy72x2QgiJlNF651Dvx4DxonaZFb20UDsTC9h9laPAIm5Tv9YyQ7agz3lA5syG+QHaHIT35DCAtacDU8gmylUR6EinNND1elC7uQCz/wDvn0HZfwisp7iTJw+hW2flmUnK6JnmIptFCzHQXi0+EVK65bhL6YELUhptmtrwV31XDK/sP94Qwg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778568669; c=relaxed/relaxed;
	bh=sgnxVqw9JqumiHsIuWiiHGWBfD1Z9ySuYZxYKWUtJws=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=UmZkdsnpgYuWwKXUp9QZ4RvFymsMmzGGtvqKOmrY04WIHNunHo6Dfd31/ide9sDBJD43m6iSqZJjutGw5+zAseWUj8qmbBG8dDY9PZX+epA2HBtkW0jIfQ9vjK8QJ5kUyqKbsrdPhiQzM7P1wFNC1Ulq4XTkbqq4DT5olLen+Ya30OMhwoUtrAvwmnXQ1Zin8A82Oe6t/kP9nkKP59NlwYuYrmFBUsz1n+FtMbrOQ2QoelcC9yRtJD4EDmDi0TIknAy4LpIm67s4gSuuRPLDsh5mc8vKht8zKCKNPGn5G3nGyGHPORezF+zuD/hlVtvX5NH9n39uUKdr5y5Mp9kAKA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SSXwc+ql; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SSXwc+ql;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF6gc3Y5Wz2ySD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 16:51:08 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfcVdz7MqYDPjRFA95t55lGRY6ByHDpcFCRs8eoT+FTd9TcuFXKpCSyo5x1O+fwGLLjRG5vpVAhDyawn9Rx0L+wBkUJ2/ONlkllWstpxkCKFyeF3i32Ud45NekkeravzlQioXWPmUeEWUsnm41D1l0zhNqQgNfRgh+UaJNnkz+hzpjbr46sSCQUYn/CsYMVTjGy27kJyrnYu2Xqa6IngSEJhquxmpWTFwDbUGBJHikuk1yN6DIdiUDseo2RKg4WpYzRLbtys2AVBAeR0FAnbvmBdy1LSzX5jRRv090t67YMRv2eshzbSHyPYMs3DFcFfggsVNvFFb+fGP3P5VZlGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgnxVqw9JqumiHsIuWiiHGWBfD1Z9ySuYZxYKWUtJws=;
 b=BhzZs1BRoKEhLiAsmWrIr38i6CXUyde5o7oiYclSQ0UubNQhNI/nEAnbbutXx4zdrmNX86OdgUf4snRw/Zd9YdjITH0lMPAs3eF17XxPF5B+xD41PdOo0A03hmLhKbnV9EVR+BGYMj/9426BzXggzrHT1mbyFyJ/S16AKUoOaUhbYBH4PJJU6msrI2EwObSTCJu0wxfbPie2jktKgUymsDASp8nD6VqztTe02xpttD8vOR4wZJ6wnJ6oNgMuDXapN93bOR41dhaLPXpy6DaT/3gcoTBdvyEY3NVRrgVL24A+xQFpi3Uoczpbj7IwLaOxGjK95iR4PESB0SoCBDFH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgnxVqw9JqumiHsIuWiiHGWBfD1Z9ySuYZxYKWUtJws=;
 b=SSXwc+qlOktl0KUm4YK2Bl/DvAX9tx8sZ1JOjQh4UFG8edvUKw+Kyp9ekPgynbnnQMK2ATHXIwoomZ8aCgjy74tkA7rwhdr+q/gjwWVdPMxwTs2+wMv3XTHiWO9X9E87rzz9qVkIZW5oKUAoIunvJZLGXwrIoWmSJWMXg6TreAN7gngv5CHSwXEOHL5MBP4jU9ZIyngM94SW+9ksf8UWaI23hMfKDtZDRiJrqinsuuRp5Fg2ZwbhTGhONxMQk2VvRS1yhGALiJMS8ifYrnrakfU4SBVFXdL3JTemV/ibxQ/Uys7Vn8WHePlJ9I95ObBNUBdU4hCyXgs2zWdqecLlpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 06:50:43 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 06:50:43 +0000
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
Subject: [PATCH] ASoC: fsl_sai: Eliminate possible interrupt storm during probe
Date: Tue, 12 May 2026 14:52:52 +0800
Message-Id: <20260512065252.75859-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0269.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::7) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AS8PR04MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: a0fc06ba-be01-4699-4f26-08deaff2c955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|18002099003|11063799003|921020|38350700014|3023799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IIrHUJ8CipSqfjqGKi5D5jAmU4GhbywvV6/smuk+MA13mRMHzA4HpsQDIw1FgaGCFbcl//LRKSKq4OvfPIE9xD3NLwtoB5f8YS5aVRv0R4ck3emnViiPtmcmetPYSuABdWqgJcdLTDwGV+f50RxjfVKgAkxIqwU7/r8zkq3Cp0iTPk7AlJB8Q0heJCD8vpYWVfT08mAXYJUq+UWHhrc386bLpJOonJztkPuqUx+2i7pulNOHj4rU6jxgjkmRO1te7WZ5MRxMjf/5jG1ECNrCrg0bpKyTElmMvE6G/uohS+55irHDPZQDstjNXakvs5mQPtq/RKdiSQjU42tk4j6fCXMu9eNp0x7yzWhldLhi1zY1cKWfy5PRmEzptOWMMmxWfWs/ZKH3qfA4Evaa7dw0jMrrZu5SXFdkhtgGKRTq8eAs6vG8D6OnmRIu1GUPaEgBooL9e6MQW1bC/dx9d6I0y0Z/6kZDm5S+BKPGz+KzhI/g3SSK56BzfBE6ZzX2+nRtXMoOv/+3vFgNb60HgVbW+Ce3MYv+Uoe5BTCSFmjc1U1NUUpT3kweHxFptDZVl/AckmZQV2cIaNx5rD+/MyU8gZRWpEn6Y0VK388kkTDy3OZ2DbSct3E0mmpVBF17WHWCPhQK/Y9vSxOKwhV95p/gRDB5HqBjuQ4mxKrqdXiOSwiLrZe8I4VBSgLa/zgw5zoRyPY0ZXuS1tbTSlsBk0qmMWaQv8O8CeNzO3Rzs6XP8VLAwbXfcgrLKE1X0wh64aAkhMGXZkUEJo/h4KUT+XbpLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(18002099003)(11063799003)(921020)(38350700014)(3023799003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O6OEHhyoqhKhZ+TbYmmXdnZdS2DTDdDxP8lTNHwKUuBV/o1CJySLmMLL9UxC?=
 =?us-ascii?Q?ZOUBbjokuFO81FAbl/oXb5TSN+dhGus+fpSfPzqr/tOwxyVii+lrlkGwEndT?=
 =?us-ascii?Q?cTeBfL+XUNEPs/uUR4KpTg9a9E4Usko1O/qC9lqKx8cXMLPM/v+HseiJDzAx?=
 =?us-ascii?Q?83v6wMWI953963gsgLUCK57x3FiadPXeMvQLat+vNEUhaMl5u5x9zyZ6PR7P?=
 =?us-ascii?Q?4GJOjyU8M/3gbw2n1XNDU1PvNgmKwHBxpJQly+0DyRYykdA40V1AGa5pJiei?=
 =?us-ascii?Q?ZNqbuyq4i6iQ+Tdz1VzZv2FTC/XK4L59Jft7itUt9BOb5T/hQLVbCIKPTO9f?=
 =?us-ascii?Q?+x2JxvzfpqlJF8sCpFx1D+8AeMW3E5CoDOPBbCKrE9O+G3J8FNmKx0eCHEb0?=
 =?us-ascii?Q?vhmldS2ABb03EwB9ypHfJGygeIaOV2IXG7wRyp0FAh99XNJ6ZyJSAFHRPPRo?=
 =?us-ascii?Q?9oFok79IexJgG6nQklnw2zol1Yj28ZmxCYNjB3zOp5qtvlW90oYllwA580mv?=
 =?us-ascii?Q?u7SDEdG93ezrHh/5KvCrVWi8mJKfCcrBzqhBdX68TqfnMDJBTOY0VJYdHkHK?=
 =?us-ascii?Q?0+pKhiPJtBT2y4a0rw+8HuuZxGfljHqHNzdSfhNUFX1imJD+cr9SK+Z0huWp?=
 =?us-ascii?Q?zByvmSVzOLmt5/owAUe7zz0D04D84+3KUH/ljEq+PBNxkMluCHZB6h3GHZLW?=
 =?us-ascii?Q?iJC06Tlznot38qUh86qVqkeFpWYRltNhaVET7FIqrW0ClJyMQhIGL2Zqp7de?=
 =?us-ascii?Q?0NoWMbYMQIVJFuXvoTTWKcfSUip1gcabpyhYC+A/O4GgnJywAERmss/1qgau?=
 =?us-ascii?Q?ZbgXZPw/xAz5u2AwZ2TPe8wIDOF0SNc+GH/q1iVQPmSK41DKoGdhWmzDDll8?=
 =?us-ascii?Q?1AoSsIafmEpgHUJS9x//7jnfRsyXRaDdCGNA5Ryet5akpomv+aEeMrDdCReJ?=
 =?us-ascii?Q?fpZ15q4NSVwFi0y+1j91zUaPnw96AOjcjj6SwbxIa1WJ2y9wy7wP0k8co4nn?=
 =?us-ascii?Q?rJG8nfpy50yB9uA9325qsbHNUeJYrx2M5mfhYP+ugBtob/Qo3p/2/vF5AOu7?=
 =?us-ascii?Q?5GJGAxZ7mmz8PDLH1vilcpe0RNbXIfMZitKWRsMgYKylqg9vLIx+7KO2DjQs?=
 =?us-ascii?Q?UM/Vf3omDTalGHJPIfZnYsccqCYMsWkGzPsRtPd9hUGKEGe01qUIqpWGc7lb?=
 =?us-ascii?Q?oRmR7VRe7XpB1xdqudbFqe9nAJg/9/lTQRjWtGAFSyukT9hU0D8vtBYwmo6c?=
 =?us-ascii?Q?J4ruraVxM6DbmwSI03WERSQaPP4TrXWhRhocBtFjMMjErdD+iabBQGPllvgw?=
 =?us-ascii?Q?n6I0xfJ0o146laGhhBrEM7z6zqbJIvmpYLbgdbWczs7ROnGzZSlTRNIov+WX?=
 =?us-ascii?Q?YqTxbt0f58b3DMK8OFgyxZy56sunkfaRsV41kkdumCifbd84CrTJknZtzxCE?=
 =?us-ascii?Q?fqn68MhS1p0n72wt5X8pSraYK9THSIQpJN2LEcdt3QPAKkBn+IO+r0JHfqXo?=
 =?us-ascii?Q?ib8bdz0whEtHCn7mDOMxDKQz6+iG5zcPxswk9dRi/BYgi2+wZpi7k/ehk1Bz?=
 =?us-ascii?Q?NbNcFD6Tuvwwdl8RlGcy4Z0OhFjZvCIyODlSGpIs06lYf3oA/BDjWYAwdlX6?=
 =?us-ascii?Q?gTHPim6N28dpyAotqT0625O/pe/Aagy34SDTFox1EZiT4z7BF3MNuL6pu7vk?=
 =?us-ascii?Q?T0DvNI85lz/UDxtO5vuzShCCRzl0HbgdRS/XMHe8mTUvVgyVmK5OmFTNuPkR?=
 =?us-ascii?Q?xaF4eBgDZQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fc06ba-be01-4699-4f26-08deaff2c955
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:50:43.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1hQdB6oR9/Lb3WLbbe7RpzM9gPOIl7EBjM2x4+Gf9rY10u5usPx6G5DlGm1+QyhtCPPayU5R6MnYDYihvH/NIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9126

When the SAI peripheral is left in a running state by the bootloader,
the driver can experience an interrupt storm during probe that prevents
successful initialization. This occurs because the current code registers
the IRQ handler before resetting the hardware to a known state.

The issue manifests as:
- Continuous interrupts firing immediately after devm_request_irq()
- Driver probe failure or system hang
- Error messages about unhandled interrupts

This is particularly problematic on systems where U-Boot or other
bootloaders enable SAI for boot-time audio feedback or diagnostics
and don't properly disable it before handing control to Linux.

Fix this by reordering the probe sequence:
1. Add fsl_sai_reset_hw() to clear TCSR/RCSR control registers,
   which disables the transmitter/receiver and all interrupt sources
2. Move devm_request_irq() to after hardware initialization

This ensures the SAI is in a clean reset state before the interrupt
handler can be invoked, preventing the storm while maintaining proper
error handling and cleanup paths.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 43 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 87a40e2b9fdf..d6dd95680892 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1374,6 +1374,31 @@ static int fsl_sai_check_version(struct device *dev)
 	return 0;
 }
 
+static int fsl_sai_reset_hw(struct device *dev)
+{
+	struct fsl_sai *sai = dev_get_drvdata(dev);
+	unsigned char ofs = sai->soc_data->reg_offset;
+	int ret;
+
+	/*
+	 * Clear TCSR/RCSR to reset SAI and disable all interrupts.
+	 * Bootloader may leave SAI running causing interrupt storm.
+	 */
+	ret = regmap_write(sai->regmap, FSL_SAI_TCSR(ofs), 0);
+	if (ret) {
+		dev_err(dev, "Failed to clear TCSR: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(sai->regmap, FSL_SAI_RCSR(ofs), 0);
+	if (ret) {
+		dev_err(dev, "Failed to clear RCSR: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * Calculate the offset between first two datalines, don't
  * different offset in one case.
@@ -1580,13 +1605,6 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(dev, irq, fsl_sai_isr, IRQF_SHARED,
-			       np->name, sai);
-	if (ret) {
-		dev_err(dev, "failed to claim irq %u\n", irq);
-		return ret;
-	}
-
 	memcpy(&sai->cpu_dai_drv, fsl_sai_dai_template,
 	       sizeof(*fsl_sai_dai_template) * ARRAY_SIZE(fsl_sai_dai_template));
 
@@ -1661,6 +1679,10 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_warn(dev, "Error reading SAI version: %d\n", ret);
 
+	ret = fsl_sai_reset_hw(dev);
+	if (ret < 0)
+		dev_warn(dev, "Failed to reset hardware: %d\n", ret);
+
 	/* Select MCLK direction */
 	if (sai->mclk_direction_output &&
 	    sai->soc_data->max_register >= FSL_SAI_MCTL) {
@@ -1672,6 +1694,13 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	if (ret < 0 && ret != -ENOSYS)
 		goto err_pm_get_sync;
 
+	ret = devm_request_irq(dev, irq, fsl_sai_isr, IRQF_SHARED,
+			       np->name, sai);
+	if (ret) {
+		dev_err(dev, "failed to claim irq %u\n", irq);
+		goto err_pm_get_sync;
+	}
+
 	if (of_device_is_compatible(np, "fsl,imx952-sai") &&
 	    !of_property_read_string(np, "fsl,sai-amix-mode", &str)) {
 		if (!strcmp(str, "bypass"))
-- 
2.34.1


