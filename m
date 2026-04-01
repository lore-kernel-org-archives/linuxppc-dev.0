Return-Path: <linuxppc-dev+bounces-19137-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC08DD35164
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 09:42:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm0PS3TDHz2ygf;
	Wed, 01 Apr 2026 20:41:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775036508;
	cv=pass; b=WxDkGe6rB7tLy2PD5VoiiYzku71iaOVg0ev4R1KSQJekagxYRiRNHCOnbPaKEMNaB0qPvsxlJ7NEbI3eXRL3xZIXn+zAxxdO6J1+35GNy39tprTfL/44IB8udATivhRjsxqkHB13FflPUnmDSBlfnTz0VxTGdoAy8hQlm2TR38Fj7paYfuV7mj1YnKndaXpe/Ag0CgLbPcY4LPKm9J/dCSgC7mNe5Up7IeCIDanEbtxFRhu6VfGsix+9mCIWmMFAOdtO7Oz/rfrywO6M2m1otzWKPhA3D5McbHLBnY6Ibf0+uR5Xeu9NtF/apwgL4nsvbt6a6TS4VEA52djHjmN8EA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775036508; c=relaxed/relaxed;
	bh=haS41qD/fAlt8cHSvubSuj5P3Zr9kdx2zsfBPqlcmMw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WTmzozPtIhPZfJL48UmhTxIuqrIASQfizf7hxywtt0KXCtC/nlyLteZzjlc1jgrSwFK3v7Eut5RIzmGwTxZbX44Gn26VXtu11Zh+CRFJURGMYdrwIZRnBvSnPVCUBbAAK47JfImZfuE9enaY6ssxXQ47WRBuDGs9JU3xjw7h6QNyqfmRAoUGrUTuFpq1R7HnVqe5hmbm6Gkd/Q1lWAr+WuUmttjDPxjPim4yfFdCoSGXRUed4BxWRrpDKBbuZ2YjrZWe1Tqn020o1JgXh0tQoOi9LR0E0du7MbT/6abdAHcZIgEAB4ur9iEeOrbIbCY/To5XkLICXGEp6XG+456Quw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZjzipCzz; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ZjzipCzz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm0PR5xvRz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 20:41:47 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEtvrCRvpZ5ohUFFCBwBkEf6qZRCsTEE72F5qMAib1CSdu2xiXin2RUlZZ8yrNXG6Z86d6ZHpODkfJ6HrZOhI9p1QHSSmPd4mVZUsngKVisE4c923K5jK/pyeABdsuH7YqICZkcJajLb920Qy0WtFuQs0eQL/6GWS5OC72GYBaHtRpwOVKXbIs+kG9MlipdtNHqFvRvvF48Vt3V5QhnCZq9cb20J3jWWCl8XWmtohbA0/eq8wQMwrj3/GmCF+QDFKeQzfBMBob2FByH0VSGxPZoaLnExOGDe/kcdqtcjbCaU0BfBXbfxHZh4IwvUw6GkHMT9yKGNwAwdliw9taSVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haS41qD/fAlt8cHSvubSuj5P3Zr9kdx2zsfBPqlcmMw=;
 b=dkoUMfO5l92tji3arbeO1IwpkglopBqrqP04qBLH6Leqrow+K+SmabbYzQFzd2f4cBZjG9rZF/zK62qfgq18I04aqPW0pHZcuE1JHMllO/mOUq4dEORmgONtPd5aWOlzUvILgp4uhdAppn6DO6lVidzfoFE7B+2dyhSvjvUsb2U6BjvdQEACAvWUvwGAkJ3uy77iu2p0yP7UpZSa2N5CdOb51rQiTfIpNCqbIUo7LYK56+PxrXJw/KRQQOrpBApTgXiwT3ruKQlCDKs1u0IhvSHohwB+Sf/uKTgUYf4gZ2kapPdsh+NxtqIVKcgybOuMLHSSteIjCN3CunUF4ZCBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haS41qD/fAlt8cHSvubSuj5P3Zr9kdx2zsfBPqlcmMw=;
 b=ZjzipCzzryGzdavJHXPlGUUk8lv3KT1Ba+gB5NAuYEGbOTmBVWwP5sOh96FqwrZe9IvjVRnAOYA+5W3fcjV3vf7Q7YuqLBThmbqyUoGIRdaV1r+WHBPPTZ0L3NsdO1wXIfSJXFUQc9QI55+/WQkEOYJwvyW0HEWAQbPo3QuQJkn0jmi8ngAUUoQ9Pyo2L5i/kP5eUMnFEXqVnoDBIHeE6FuH8YWbcj8ObPXxb7XsOjwkNMJVay1OHTd/QFzoEzwb8DzSq4m5OUL5nh2nAT/zElREILZUY04vfOzEwgLS9bdgcT9322d1N++Bw/65vB9BxihclWruWz2/iBzij2x6hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AMDPR04MB11607.eurprd04.prod.outlook.com (2603:10a6:20b:71e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 09:41:24 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:41:23 +0000
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
Subject: [PATCH v2 05/11] ASoC: fsl_micfil: Fix event generation in micfil_put_dc_remover_state()
Date: Wed,  1 Apr 2026 17:42:20 +0800
Message-Id: <20260401094226.2900532-6-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260401094226.2900532-1-shengjiu.wang@nxp.com>
References: <20260401094226.2900532-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To AM0PR04MB7044.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AMDPR04MB11607:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7b284d-2085-444b-e2af-08de8fd2d598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|19092799006|7416014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	g9uxAggcjl3rgP5MvfRJBHWScv+6KUpsGmQoxIeAcb39wk4Xy/8d4SmRb0GudcF2UeN5yxeR+ADNFBvbCDQF5FbB9gdigyRju4fk9Z1slB4UGSAULK9pUU8Wu1x879UmcUxdsZ4C4MBqVIUBdDaDV+yxAg+n1+hUyyicAshUdUWO38doyxftjP7TKiM/ABB1tsymBu7317Ux+UG2QdkBUbqBaUGZ/9x21dV2yCCtJ5LN8rUParBo/5YXItAY5F5kEIkZ00JeR+r5cbnLcTp9zOl0hODOdF7zh17KWeTftc2Pm9vX5f2VuSpz2LLDk7yMmgCDJArubJKra9VB40XnD2B5ONrDKPRyZCQ2B3IXKEKMcqNFxFAVjijH8hNI+zXQta/cBFj2KZZD0I/Nu/hAwjcr94jLOG0iGU3OinGJduxtjSmZIDMYUGsqwHhWt8csYypHztBK7uFDyLD42RMjMBlEQfZc+DnfHeh7SFHXam8I5QntyLu32yZ7KtNGIiWS/0Ez7ONsXYoR8nxCureIJf6hDSdYtS2LVIUs5bID+XULvfT392/odPzJzLdGrT4NivlzJJ87jj5J/HuLVKldqrOn0mmaTyujUKLMjjmY1YZhghvFr5SVIM9WxwEB61hfJMbEnIxZip0SKz3CHorOQRTPzaXc5hMBivyBF95QgnDkgnCZ+1FJ477ehEIoLNqZsYceIQJoEynwwd7jRdgmqOFawhWEz6bL0ecTjBWaKQArdnkRCkP72OIo4SJzQP7c4myJBCY1db6/K47Geuu3XAmnsZjAEuplKejR3SzagOm0aXiJia34rHOnoLixcmpN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(7416014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jyzm+EQQhTnygq0+HxWuoqeJsmD9SBaMMmCWa/EGATebdgJ5+TO+NrqFPkQu?=
 =?us-ascii?Q?GApftQcqgtUeExrGu1S2vNf1ZSaWr3M9fjZBfUz6zQPQyiwvjMYbFyIzBSYV?=
 =?us-ascii?Q?0g3Gx83WyYhCEK4NLs548QdkO6kgEu0+UdhLkh9DEyaj9ClUAJ4HZchUyBA9?=
 =?us-ascii?Q?eUiuFrqpPln26lyhi/NeKm8hfvRtaUbFUaM5SvxOkQ7Me71LFXv9GNPtnja+?=
 =?us-ascii?Q?ajd76jGyZqDjF2GT7hdGjToQSgmxEnV4LRXgEVrdvODw/7z5EdPKFOWazyf+?=
 =?us-ascii?Q?IKqtJM2rI0ebJcrFErI8LRiL3PtMds5ALyIdzh4L0OpddD+EOhYk4Z2hursf?=
 =?us-ascii?Q?0pZ8vZb505o9qX3K8lVYTR0SDnZbPnkpDomIFa/rqd76tEdxZG7OzD9UyhNW?=
 =?us-ascii?Q?bVBTKn8Z9HP6xqf4l5wjovta+iNlKQ4cmjaaGJATWCDqrw9gmWmC4RxKdfqR?=
 =?us-ascii?Q?xi8r8S1rMsELgQyQBx9FrIVya+dR5xN8ACtzz+w3fv0W2IyQ0OpP+4ybttVO?=
 =?us-ascii?Q?L0PF7LShrI6oLE2TF3MKlPtFWiX0fgLYWKzyeSXAv+rBxwYbAcoIKnBj3cfX?=
 =?us-ascii?Q?ysb9vm49Z9T0x9egk/8LNvtwJTpewT549EEC3W18Y/QKMsfXc8apLh1GE4Qf?=
 =?us-ascii?Q?Du3J4nMuVVCO9Vjn3eIKNWmJ6NN2hZf0VEqbX8ORROPevG3jAhmOwffOLjW9?=
 =?us-ascii?Q?91FtYGIO5ckBUh2GUr7j8jspScBIXdjU/FxTb4hLh2WFEkB3wq7dzSGg6xuM?=
 =?us-ascii?Q?32xpbsCWdRAhYU7rnRyL8Q/r+PcSVA5VazGf6IUNIFwQEcHIFFTRe10pzhF2?=
 =?us-ascii?Q?Nz/1llplAkSyeMBxW/95D+aKex/0FcYUiswNKmvwAeB9SS9AFrdecyDnv3fZ?=
 =?us-ascii?Q?cMTacK9LO2FtLrEm391hZiBhsrNUt7xtX0A1Ki0RCtuPfErZTYj7xhg7PSd2?=
 =?us-ascii?Q?pC2Zqvs9i63fuwQ72WHfDdOcnRr5osyq5L9YtXMvcu99jb1acBDnehSuyXRn?=
 =?us-ascii?Q?PjuCxbfPf2lWHSOX+G0lx0eYE0do3P4FnmgwsdTAUPbVek8MszP+6yK9LQNI?=
 =?us-ascii?Q?qBIjS7a4vp/yQQODKSKMCvPNxiprbChrCmBDSubQs3562n8OA7paMG2JZ4Bv?=
 =?us-ascii?Q?DP03f1MoRNgYmPk6cjpisnqFMqpO5l9VoELOmVTKiisom6ZoSfoaaGvxWAQQ?=
 =?us-ascii?Q?qwSEaRWlgSgbHwzm++kkCfGQYGmyDabXZT9NmgP0K2lxg5KaZ4NP3dqCxHsQ?=
 =?us-ascii?Q?LaFOPRsl4GSYqNu4IxOe0gbf8D5Nyt5nMzqkPZfOVSEhbMZU4thDjWOPvZW0?=
 =?us-ascii?Q?Rm0dS8qV8dBEqDwCA2KoReOp40eU5tsnCL5Jb55CDjX3cqh3A7Ef47fCa9No?=
 =?us-ascii?Q?NXFVXfGhyo/zlESjPZwu0XVeSFvK295AYoU8ACgtLJnuJ9psFXROuoH8UgYi?=
 =?us-ascii?Q?729m+dSLdLeXsk091MEdqbwDco3oTlWdfc2WdOJ+/S5+b49wL7sKehJZ8xKH?=
 =?us-ascii?Q?AD8ezARIHPtLmwWcbgkenukbhy6Y3Il4adoroMLk7lJQYScYh3xu3JPJ1+q6?=
 =?us-ascii?Q?1xJLvAOs0afxSq74TGz2b4vyXFZwlIJQMwi/DfuDOQBYjPVRBukbB8HDXwf/?=
 =?us-ascii?Q?SsjTGs/yyfeYjQLDOtZO/s7Bz1rWm7zWMwevtM4Hidz1cNHMdY82+B9lm+xC?=
 =?us-ascii?Q?0kWUSfh+QDPyL9nGWjUSQBqc63rYbzj3MJTn5BjT/1pwk0umcKZtFLKjLlbG?=
 =?us-ascii?Q?E0HGcOIuFg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7b284d-2085-444b-e2af-08de8fd2d598
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:41:23.9148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcoCWndkBGf5X5COTT//O1YnAkj6zeJU28lrblTa3gvSLGTWqofQmGQNnEz4WH4/OlLwwapuPA1xqC8gL++Tug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11607

ALSA controls should return 1 if the value in the control changed but the
control put operation micfil_put_dc_remover_state() only returns 0 or a
negative error code, causing ALSA to not generate any change events.

return the value of snd_soc_component_update_bits() directly, as it has
the capability of return check status of changed or not.

Also enable pm runtime before calling the function
snd_soc_component_update_bits() to make the regmap cache data align with
the value in hardware.

Fixes: 29dbfeecab85 ("ASoC: fsl_micfil: Add Hardware Voice Activity Detector support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 0cfdd6343291..983805bbaae2 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -351,6 +351,10 @@ static int micfil_put_dc_remover_state(struct snd_kcontrol *kcontrol,
 	if (val < 0 || val > 3)
 		return -EINVAL;
 
+	ret = pm_runtime_resume_and_get(comp->dev);
+	if (ret)
+		return ret;
+
 	micfil->dc_remover = val;
 
 	/* Calculate total value for all channels */
@@ -360,10 +364,10 @@ static int micfil_put_dc_remover_state(struct snd_kcontrol *kcontrol,
 	/* Update DC Remover mode for all channels */
 	ret = snd_soc_component_update_bits(comp, REG_MICFIL_DC_CTRL,
 					    MICFIL_DC_CTRL_CONFIG, reg_val);
-	if (ret < 0)
-		return ret;
 
-	return 0;
+	pm_runtime_put_autosuspend(comp->dev);
+
+	return ret;
 }
 
 static int micfil_get_dc_remover_state(struct snd_kcontrol *kcontrol,
-- 
2.34.1


