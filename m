Return-Path: <linuxppc-dev+bounces-19133-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188ECD35164
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 09:42:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm0PB71GRz2yv6;
	Wed, 01 Apr 2026 20:41:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775036494;
	cv=pass; b=TBu4QcTPPuKS+VGKlDeD3dnZWYwBsHwmtIEwBGuB7nHoN/g9O2g/5C0Z0dfzT+psouM3IYpe7YEhPS0jp7ebxdn4SRCsTGM16ShYrQC7OVJ7MXicl90G/rBe3B+xGvfNSU6ktC12UcjV9RzEkE9eB7khSO1i+RBmZl5DZ3coqXK0Xopsf3ZsMLYW+h8ZRb/MyEIWnW3mAowxra4IEwOion7tiZcVGEd9Lj4YrALpoIuS6oqZhDMgGdQGP/0vt5z1cvUEhNZA+j5mRTMYTq+IbFGqru80fIHrVRHSpJV/x2vQ6+r7L/aL+nhi1A6Isqz0CG172fOwm5IxlUE4VDQrZg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775036494; c=relaxed/relaxed;
	bh=9Oi/2KTsaG7nxKIQclwlTR7Vxue18R5nbgO2D18qPW4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wn13Eb1mbZybq5DUGsngDzwZO89WUVJlE/j6K8mm/CwYrDQy+MgWZr9ezOMZJZaFHBg6oakcVqOrbWkJriD5TWGXcHZvF9NxIqIOxUa65mtIxgBpwngZWruB6bpZsQWnK4gvcb7ADmKi+JPL9rzl1sk3VcEXwkWbf0GGRRwydIKuy7blJjE43IzViyfvNz9se1ZawlP5wlZIEHMykClQWQ4DycC15nFnhyn4vUMdbTSDr1lX3np09vZ2+/XpYYWAhwv3UrImd0tohE9jU7QQHit3lU/S8ycI1wc4sCc3DofpgK/Iu3m23MsNddDU2h96JiKuYpxTqKH4ZzrqoNeQHg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=E8w/SDHg; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=E8w/SDHg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm0PB1Mdbz2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 20:41:34 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOhUx1qD018s5ALMjfGup/KPG1CBoFqXAOxTcBNpwwY/Of0he0rbjiSf3Y3DeulC3TgKxT/HUZryaQ91ItsD71DgC7XVH9Xs60OHoSli0UcP35JyFK5e9DRq73Kz+c/3Ggrk242YT4KiU1M5g11vPEwgrtUuZw0hjK4r9LTMmEGK/dc/8poKW2h5kJUC/t3qUsHS3Eeep0g+EUVL138CRixAeg/DgEB8P2nLKHoLKWAnzz6I+9e9dQWZCsbpZBzcgD6Kr2W4WGbbMMguS4eeK8+b8OWC9ZmbL8chB9NfIVAesRA0hV8AclzWce0Y9IIi7vcugYHjEDNsp0LAxenPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Oi/2KTsaG7nxKIQclwlTR7Vxue18R5nbgO2D18qPW4=;
 b=ZQbEIs1RWm+BoQPpx8vvHY6E/JGYZpXqvh7J4eTeUDexQUt9/33P2Co78eurx/vavG+YeK4GWI5Dk+wmdKexXFpxX7dqXCi2YNDa3NFAxBHhUT7KmBV0td9+uqQfTH7yrXAgUU4j5NSI2udmpLzwFWIxT0GIQzaIt7JU10WE5wkEvi7UH0RJzylgFuissQef81iyUG0tLLcSVgOmqq9c6nQ4o8BGWzFmW1PtrgKsVoLKAwkLays8Q2FnkxOSKvfOdw2B4g8l3lVphPg7Onu91xZIy+0O3Ocs73vn0T6G2S1uVuQioQKxzAvD/qaXk1d1Q+UgSKRODn6TjUZlGYzzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Oi/2KTsaG7nxKIQclwlTR7Vxue18R5nbgO2D18qPW4=;
 b=E8w/SDHgHotgAfWZlXqLOOCdSBeZxkbsy/c0R/01bF7nNSWWmAuML1+/l+KPJfJcsdq5h/M6+5bQtC620uv9qifddq27/WdmHIwlYtXRj6NERQFwXt4D0fVulI8fL1mLOlgYvuCK2ega+/dm5PqH0yEVqZNZH/c9wZk/qWzdMSCZQxs1MbTbHwuaQeIFHNHwI33sa3NnJycIZmcUlZfMDQnNfmPi6VTzCnEkK2Id7WBdruxoPenSEnOaZWwEPrxf6LErNveEvHE0dAFstOOq+7U0/7B4qimp5jTvUegTLwfivIXxUOYmVPgFf+5XLHJww68f/2vFJBT9npq5z7y+tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AM9PR04MB8241.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 09:41:27 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 09:41:27 +0000
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
Subject: [PATCH v2 06/11] ASoC: fsl_micfil: Fix event generation in micfil_quality_set()
Date: Wed,  1 Apr 2026 17:42:21 +0800
Message-Id: <20260401094226.2900532-7-shengjiu.wang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AM9PR04MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: 49822465-9f1c-4d01-b101-08de8fd2d8ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|366016|1800799024|18002099003|56012099003|22082099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	8GR1takhoBIam+kT+HaooapJ5FOlhQE89vaeKmQUhPTnnL+Hvoj2U4Kxn2n60PG/mJf+xYInksXi/73SeOGuvs3aTf1fbohcuA9+LNyvf7ltF+SdDAPHpHFogb1VpYvHNU42DwtHuVkz7wvAqSIutzGIvjMcwboljdBnbepcnToA+8z/lpJ9M9AtQLMzyCUluGPjDZfV0AVTt56sI2H6UEKIB+qrHe114lS2PmRK48dsiB+UjbDngf1teRZBuICgj+bzwiskMISLAfLAB8nlHnGZ8nNyfNe+Scn/+Ac9WBRJtAc6LrJkj6SbV0+I5gegtUYTouh+XQPF4DPpCy4SD0xX2f4JkVh3R8X29uR5Gu+9ZGACPinyae6Nh681o2+iVYGXHScsh5xNM8OhiW3Fpm3NGodP4s+hWSj0eQ/AbEnKJLKrrWFUyi2RQhGXnTwmPZ5Xt7RAiKHaPUMwBbLZg3xbODeQFxKjsezbKiDoZznRViejs+CM63blVWoB1gEI5Q7cRKIVDntZ2BfpYPc5omr1A979FvdVhYo9Is+Y6RnQNGIXCQdcuMICgBvl7s8Wp3/1vum+kQvezsFPMOPYdwdS0/bgLl6t2W5jeO3K38JRCaC43DUApuTJkfMKmBFLeh4VK/5P5jC3ovjeRlutT7KROY4fOhMmJWMvd4rX+YcD93NmyXIGBn2BB29ZwJzrgP1k83PvWyrXRUCbQd1sio27raWWiIbB63V40ugWHIn5LQ+TMX9uuYMLx0EFppMjmDo8piW0bHbj9oUhClEKfG0TvwubF4h2EZXFiZG/JdBQa4qxMS2zHHNHYLKDl7lr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h9Jsjik8QTKGgLNrYO4EQoQU3ServwyJoUFToZiK6qYkDfNVU1XcKnf5ks/6?=
 =?us-ascii?Q?E/gLIMtpWdvC0AqIfnFVxNrqZkThAGX7cyD6cUyopQQdBXxEjx2llbhXqCab?=
 =?us-ascii?Q?2wd1SocoNBJMyppiqUymjRY3Bl5NGIg8m7muaZ8l9TnQlErVCjzXIdIxbtwR?=
 =?us-ascii?Q?hNGvoFD+axsP8n9oxs8aXWh6PjFbAB8TdlnXa9fZO4LFt6f8meEBdliwPR/U?=
 =?us-ascii?Q?HH+dO8uLXshE4sfkZNrcn0VuYNT2LbXn/o5ecPAenuoIP7ulrtN26G847OrX?=
 =?us-ascii?Q?2df0F8QzWyBRYr5QG0fethC7D/k3MMSlcBlAYGcHg0jXY39ESDK3q4QSfFik?=
 =?us-ascii?Q?qTjabzSImwDUzdhzv2rxKB1bHARcOHjGhfs/tOe/qgnvBFqyjuHxj1oLrMwT?=
 =?us-ascii?Q?x+ZqPN+BTe47IO23+c23mIIuYHStxHNHLmnuYWdmmwte8zU/SNrRdV5gGjT3?=
 =?us-ascii?Q?Iap675in64FwhbeQOsuP7423w+RBKSS5/8rKTAXP3BWnZgQfxgtudtlYgBaN?=
 =?us-ascii?Q?vxXoqtln/GCGnucCF5sNs90b+Lb6DL/EqbaPHdftrZ2qaJgr4fbemnyOYffL?=
 =?us-ascii?Q?X49KmmwUZViIA/bir5YSe8SvNHH+TrmmNa/xlSNhs6VPUZiFm6DbFZQ4fyVd?=
 =?us-ascii?Q?bj8nRiENWCZPJPD0w5x7cWqgqL38BirEAU2twvfoKGZokmNxxQ8XQO3AaeSk?=
 =?us-ascii?Q?MV+apkGkGCNE+5FdgG7TLIyIfEt7NVUTmaLKcH06SAZwXCXeuPPaEQ3GeutU?=
 =?us-ascii?Q?ERwT+vrWjWmtozJ9iJgCCLK1FYJ/V67pUSv6VTR11+G2ox/r1/JZM/+6TWNM?=
 =?us-ascii?Q?wrlIequNlt6hQgsFB3Mxo8k9nZjCX/ytWYmycTr7ItUGbXI5KjRnmydd84EZ?=
 =?us-ascii?Q?nKyVGeyDbZk/yMFqQdReEdZLXP14PS/JkByIx1dxrCZdkcuXsqaRaSLR3/SS?=
 =?us-ascii?Q?fXj+iNuNoGzgwjm9f/viATZ1mWJDL+7HDWE3xxg3IaBUfqYsybTmhaGXZkMb?=
 =?us-ascii?Q?GrSwMaVje/p6OxSQ/zSfeTP6Byc5dMyEqSZ9vCr3TqzvXqe+SJ0Ho8v7Ifno?=
 =?us-ascii?Q?rmf+jxnxbOehqHQfuelX2tJvV0RmKK/jyThr2RdFVJo3v96I2PUAQ+JDqEcm?=
 =?us-ascii?Q?1hdOeAeQ+VvYypjpdzZwWrPWOHx9nuyZNWxfOAG9Z6+co+UmW3ODzrcdRzyG?=
 =?us-ascii?Q?RgPhnLwBJGJPmwe1jzukrSUIX+4zOOzGRyt+V3RLk3ayU/UHA0p3S6mnMTMc?=
 =?us-ascii?Q?nV8LuJCW+JS1SDp44vACxeihhjydWgJsNfY16aFoJZyfqCtyD1Vf6I+FpFm2?=
 =?us-ascii?Q?BCb5TIQt9O54R+aYqtSxwSTgkpvq3B4kQeXWe9av68y0dtUqdQHSQKhVWmaT?=
 =?us-ascii?Q?iLhR36GLZ87DXWMV3TaFINiXAGMzvk9KQ7eJ6fZtpp9zwqqpF9mLsmg6T3m4?=
 =?us-ascii?Q?NnraQyqHYcaqlvP6CE2n4DBrHZmG45ESpT46iezSwlhdXc3vNi37gaFun9Bu?=
 =?us-ascii?Q?9+Vv0FAAgHdzoNhIXPtF+uEOS/iXLDVGa3eULUxCjfWKIIPi1QSH9zgM73Hz?=
 =?us-ascii?Q?C0RPgQ1FuVNsbw9wYfy9OOQ8qRe7614yYqKpy0eLNqkc7vq3nBVUiYmiF1AH?=
 =?us-ascii?Q?Rs8GUY89KtGYqtkFA0nBwoO+fohoVM2uHtkrycVDoFPUxOORVm1IHN7LQeyc?=
 =?us-ascii?Q?GBNRQSU0FB6XT/s4pzndyA+O/uqK4+jUJXfoQ2vWMh3+FKa5XQBNXtu48ajS?=
 =?us-ascii?Q?ALd4Av9wag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49822465-9f1c-4d01-b101-08de8fd2d8ab
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:41:27.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xCz7IhW5CijWIDRfboZ7LwXdAYduHN5ORsXmEaQmjQbe0uMh6VZWsKWkZqzqqsOilKraUa+DwK652d4cJj7Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8241

ALSA controls should return 1 if the value in the control changed but the
control put operation micfil_quality_set() only returns 0 or a negative
error code, causing ALSA to not generate any change events.

Add a suitable check in the function before updating the quality variable.

Also enable pm runtime before calling the function micfil_set_quality()
to make the regmap cache data align with the value in hardware.

Fixes: bea1d61d5892 ("ASoC: fsl_micfil: rework quality setting")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 983805bbaae2..2e887f1f1f36 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -289,10 +289,34 @@ static int micfil_quality_set(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *cmpnt = snd_kcontrol_chip(kcontrol);
 	struct fsl_micfil *micfil = snd_soc_component_get_drvdata(cmpnt);
+	int val = ucontrol->value.integer.value[0];
+	bool change = false;
+	int old_val;
+	int ret;
+
+	if (val < QUALITY_HIGH || val > QUALITY_VLOW2)
+		return -EINVAL;
+
+	if (micfil->quality != val) {
+		ret = pm_runtime_resume_and_get(cmpnt->dev);
+		if (ret)
+			return ret;
+
+		old_val = micfil->quality;
+		micfil->quality = val;
+		ret = micfil_set_quality(micfil);
 
-	micfil->quality = ucontrol->value.integer.value[0];
+		pm_runtime_put_autosuspend(cmpnt->dev);
 
-	return micfil_set_quality(micfil);
+		if (ret) {
+			micfil->quality = old_val;
+			return ret;
+		}
+
+		change = true;
+	}
+
+	return change;
 }
 
 static const char * const micfil_hwvad_enable[] = {
-- 
2.34.1


