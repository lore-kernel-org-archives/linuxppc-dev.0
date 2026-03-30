Return-Path: <linuxppc-dev+bounces-19019-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A8310D14A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 11:26:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkpnt0GLfz308l;
	Mon, 30 Mar 2026 22:25:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774869921;
	cv=pass; b=UIPqtpQzJHPJGlJSq5Mg77obRSMpsKrbFtPwbc+BLT5APOixa+2+G5QHU0+6IGtrmS1auGoPNAQbg9tI0jcvvatUSH/4/o0x+pnL+4oT3iiN3oowFCVCjj2paGo1oJJBi57MH2DanMgOhJvL2jkYqxvubIAk5SFmzRb9fEUF60uuyV0YCrGAXgfnS9BzolXgukjAkBON0D8jaBOspUZZPv8geBbGXSDInp88/yocAETOlYgMc308O4hLBhXsonl5yeiwcl3tDxVZlcchFJ1DX0IYS9CvzZ6rwkX+j1KZyeeMEtyCE0+hiKSpYxGrX88QGox9biy/VWYdurJCiyONYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774869921; c=relaxed/relaxed;
	bh=pWGdX/mjOth4JlJfJRauxMX+NXWz6kf5QtU1iCyARiI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XrZiAnuBc02SwoBJk4x+vw4S44ZomgEdUFP3n9tWCLMr1wFa2tpkjpFgP42WAMfi5shpj1uYKeqUskRhqU3LpgGpa0kyLmsqC/mnDJGgHzyvU5bB4mYy4aFyEplUJLSNPojza68KtWTO6FGmYqnk9c/nIDtUvz3aoJwkI1WbDZDNsmn4fna4SOm70tvNNjqBFtdrQKHB5/ITLPqepMlkKPe8u7vmfz+lqyLgUDHfpZPNK81flk+PFRCsWYBh85cCfqN/5gLPN7AKcgjJwuFWylOCKw4rt/hx5td0LxZGHfRwivC0ZibmnCwyjBfDn+O5wHPOtdn18Z1W9CvTx5RIYA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=UicXeAYL; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=UicXeAYL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkpns1NcWz304h
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 22:25:21 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H80javA9rVy1DkPImFAI7PBQTa9o8H1l/HSH+eHR7PSdP4UmjkPOiGVXy2S5n+6C7gKqCMtjbV32Zj0z7VpCjTrUBaaJore6TSxI91lrfIc2R9z+iRYUZfcno1LTvEa+h8qqB5pNroCDZ0lyXY4ycI3v+dXIs4r6sDI8Xk0/oDS4HAGnraW++FjGTvWHpgUlFa1JjB4NQCt7d7ogAauK9lgBSzyt0e0aeW6mVeTHBTNZcbWMhzNKaGktqMbk6Xyhmrv7KDROJCL8m7/RnGkoMqfhxHqhfNqTSdUwoFMQS+dn8PRiQjJeGD1HacaZdbcw3hJB1b05E0hOnYG1oczFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWGdX/mjOth4JlJfJRauxMX+NXWz6kf5QtU1iCyARiI=;
 b=S59Y2jw8+TpMU4xsHFyp6askv18OshsQhIizFlgzkn3HCGA3eebT+tZfU2fSlndo2i71F4STgcoxIyJVLOlX71sko3OIucqcjAWBw7sl7rJqGEd3N/rJHiF4pVhTT8GFfj0mStNS7JHs8to+Cuj3yNgISIvXNjYHy7OPgWQga94FxLaZNumtdWajvY3ZIkSCEmf8ioVa8DkfP2CLkCJaxtuz7q4ASZzGq9SHP/j3AETRIJEosgAHcaSEAF7xf89oruncZiXZzMIDvYhUZfEV6UlwBX2AD2pwi62uPV1j035WaHjxZ0ZI4JGV0ORllJ/WdU9RDO/x5iiLslCSDNRhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWGdX/mjOth4JlJfJRauxMX+NXWz6kf5QtU1iCyARiI=;
 b=UicXeAYLUzrahvulK0eqenJUbrY3vbhY/mljhKw4o59u1eBdm+e78Yd9tyjjY8Zea+fXI2KYYqYLmXCDMPnydmD729niXRKiyOyFjFqvkheG//BwRTaj68DgmO7Ksh1d36b1AAaBaS363KfG+tLA7t2ONg8w6+9wDNbH+AQ2WAUBWKDiQlVgJM7oGcqAmf7SLJYPnP5iSOTBmns35CnyurIdiaKVwCX8/ZYonJpYgYM10kpLGIuzdcP2Ly/3KuTKEMmkLpoa3DJg/aw5LmBF63RH0y7LUR9M0KTeE09gVw95LIFngkw0B2OlbZZA6X1tqYmn23Ju1ifWvmJ9f/Z+bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by VI0PR04MB11481.eurprd04.prod.outlook.com (2603:10a6:800:2c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:25:12 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 11:25:12 +0000
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
Subject: [PATCH 11/11] ASoC: fsl_easrc: Change the type for iec958 channel status controls
Date: Mon, 30 Mar 2026 19:25:55 +0800
Message-Id: <20260330112555.3637002-12-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260330112555.3637002-1-shengjiu.wang@nxp.com>
References: <20260330112555.3637002-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To AM0PR04MB7044.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|VI0PR04MB11481:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a1d37a-25d7-4c83-5035-08de8e4f01ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|19092799006|22082099003|56012099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	SAKjoyanb03d5KJgki+aDAetQ0ZWXL+OERN17vPq1JRMBEvD6shEEdI80vmcC4cpSoWuYmp0AQ5C0TNewk1VrTNoWRNZ1n3z+iRP0GfycZXwjWGNLSZYeJftp17lc7jZSCSo4sMiMXobk/vbQiTbPLVNpsb2o8cl2gSnwzBUHAPmT1CEKqJl6ZCiCsVJLYrT5LIo5dbhbVV464Kli5W8OjXAJAcINFrKyKUpdJGemqc5388t2TKrGay450JZXxRjDCEdYQfYpyjejCGkTay7K0O1dzIQZ8RB33ipGF1DzNf0M+pn9QEDcCcuWJ8UO/oFzaVZS2eCDS7Pry+GEYHSHkwmCM/QI6EADg4Xpc+oYeyBjENwUo4kLkvhS31u1nDIFu3kQi5QgvOj3d0bdxyING3KHq19qHihuII635wUGgGvlc3eh+nr76tWfazp06X6OpspImfoT4c9Vf/lzWffeBHnhcHSQro1fCKRKvVVrPQMj8PpEjgxY5A+MNjiibAg9S/VOK/npGCd0gjkRo7QsuOvZzpmsI3Y94WAWnkDVmCzY+tgLAoDHE9TovO9gUEgmmowKdhHR5aTq9XlgH1kdZLo/JGDffVnAZdGXqgpWNGwMNk6TNr7Kq70+ePHk/qDTmh5/7MFnZiymAAlpYtZ0x/wzi6WXt/fDMxHASVJAasXkP77L/zGFzzXZ0DP+sAfrj/U5oe+LyQlcnXbw1vyd4nf79A0oRAU2DE1qfdycKQ+tkMsdA96Y8aV7yoGjTm62myci9FP5XatyyhVhEuhptbNp0zuhwNwQeRaMWq1gL7cpvnVISTAp+6p14OLayI2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6xZylJSQt6GuBXSgH7e6MIZGYNJZ5LK423NCbnu746yvNoNCBxnX6NtXL6ND?=
 =?us-ascii?Q?rjtIZf/ZnN8L16m5FdeaXrYUcemsZdp3Ab6hGPIkH3wyUblSJ3nFf21BJFXZ?=
 =?us-ascii?Q?qxTXOvI+u9UgaCtf6Km3sTVw2JXXySNVEQMSryKVkTMh6WhcPEn8DiNCD8hI?=
 =?us-ascii?Q?r1uPMtwqDPxrVosdXUaXTabDGv4ejvf/Am/ZjIiPTnu6mLIm66ul+3UpGPW1?=
 =?us-ascii?Q?juPNTmlW8RJv4lnKc+T1arvYJIUOCXLRAfeLYAgbz9RxsrrM4lPh6bxfQBAZ?=
 =?us-ascii?Q?zzBPFEv8maKWG9zy68p5wj5/vMFaaAtqVwtMDt/y6omO/9TnJ1XuabYNPXBp?=
 =?us-ascii?Q?g7oI0SfEgu3zQ4Rl/nAn9Iq1PRB1vqzg8fw8BzlQCe9DO6XzFss/iq+SEIg5?=
 =?us-ascii?Q?dltHvaSJ1isSOnilBzVTrdH40wcmq0RsDov65yKcyfI96B3aXmPXqXJKqoqX?=
 =?us-ascii?Q?Vuk+9NiHLq2mo6QYxmY6HsPo5Lv1dxibYAECqKgqYt18LCGsqA4//HpG+m+l?=
 =?us-ascii?Q?nFGui2pIq/glp5pREJxTdfQ1652iTzcvfNbZ5uD9iQGfMOBkcCHVASwkmzbz?=
 =?us-ascii?Q?Vp1JLSpzjSpB0C8KmkP370/c5+ONyd11u5BkZkAjGEPZKhMZjym4oxjxCacw?=
 =?us-ascii?Q?ljoYGkrWhA47LU7piZIGaqU9x5bpVsMazOh4DX7bgdHZEKDKQtnNZOKnA4om?=
 =?us-ascii?Q?BLUeapTDIaQ+tVCQuDEtZ9J7p0HXvt8a4UhEdeu8PMMvF07U5NuhUYVJa1IX?=
 =?us-ascii?Q?T56CigCpkJ0gXqyqxecfEbxdULTvTBAhHrRYcaNZdhsbUZUH9JQh2YDd45vh?=
 =?us-ascii?Q?l+RNgjMWeSSAWndu82WsAeLMFnzbhx3kLogYC8mRpwdfsOD8Gk+U3jEnxfn+?=
 =?us-ascii?Q?D9oxeZkKW1L4KsYrLXRXlXfTlg/dv+fFt1OZDD0GIJtLwEHRIuPHErDoOUcT?=
 =?us-ascii?Q?Ugz/A9uoj1sIjd3Xb7FzTzN8KDxkzKIngyaNNEG6TfBPoCXCXIAoZyAs4ESy?=
 =?us-ascii?Q?xWDSGDfy69PG8eWR5de3HHhxN33j3WI3gxZ6MqGY/k3rUNLhASb1no01XM59?=
 =?us-ascii?Q?JL9Sv5mObBBmId/0APZgtzJaX5MvKu3ZeGqnLBFtC9Xcr2B1ScYGqIBF3dmc?=
 =?us-ascii?Q?QOIkwTfPUg5uJyY+wbriHqt3iBb8NuGVOzlnAsiNuMZw2CI0YfxbMYwXDg79?=
 =?us-ascii?Q?f4RYtrPu0LGoaos0LHETiTlu4mIlVPWn4UfpOCfAAtWY017pch1zzyKS8ary?=
 =?us-ascii?Q?t/yPuqzRSwXqyU/3TZhwgbnYu5wfW9BP4ayP+Oxs+SNIZ2+lAW0+GEmSgZN/?=
 =?us-ascii?Q?dfED11sof94F8EQMq5K5m2CT73RuxJdyuRObDlz4PQTSo3x9jymA6oQ/Ba8J?=
 =?us-ascii?Q?cFEDyFyEQHjlsWLKtueFK09r80862U5dUVKrQrpU0eanIp652oeLM0iTxoCm?=
 =?us-ascii?Q?dil1jXPYdRaX26mf/YrFRu+7Ju84OTIRtDY9dbe6S0yYOo8X3r6TYR/CYoYN?=
 =?us-ascii?Q?W3My1pFnYOJNz+wYmDOHyJIMAEVTBgXHw64TdAhByh/B9UwCXe4WjtrD5+od?=
 =?us-ascii?Q?N/vAICjKHQPOWzQfoCElUbSGfSMYOXpiRBGSQqPXFm24WVJV6wApVXfxaKif?=
 =?us-ascii?Q?KNO7vxQmWAYuJKt9ViW0JF4TUw4iWkGX/seQiTGClBZgyGL5Ph7ZPp07v7hb?=
 =?us-ascii?Q?Wg1Edb43F3466hg5h7uhF7YTSJ+jN7YtObHAeLBBMaWdJyCEQLmbYgJVVil2?=
 =?us-ascii?Q?XuhYAzu2MA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a1d37a-25d7-4c83-5035-08de8e4f01ca
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:25:12.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M419CAQHWOBag8hq7l8blQxo85J8INBI+1sl00Z5hGtJ6cl3geHIafN5pdQDoGT0jfEjL/O9g+65lc5QqyExXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11481

Use the type SNDRV_CTL_ELEM_TYPE_IEC958 for iec958 channel status
controls, the original type will cause mixer-test to iterate all 32bit
values, which costs a lot of time. And using IEC958 type can reduce the
control numbers.

Also enable pm runtime before updating registers to make the regmap cache
data align with the value in hardware.

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 108 ++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 34 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 3086cb758beb..a6c643a4d51e 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -78,17 +78,47 @@ static int fsl_easrc_iec958_get_bits(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int fsl_easrc_iec958_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
 static int fsl_easrc_get_reg(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct soc_mreg_control *mc =
 		(struct soc_mreg_control *)kcontrol->private_value;
-	unsigned int regval;
+	struct fsl_asrc *easrc = snd_soc_component_get_drvdata(component);
+	unsigned int *regval = (unsigned int *)ucontrol->value.iec958.status;
+	int ret;
 
-	regval = snd_soc_component_read(component, mc->regbase);
+	ret = regmap_read(easrc->regmap, REG_EASRC_CS0(mc->regbase), &regval[0]);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(easrc->regmap, REG_EASRC_CS1(mc->regbase), &regval[1]);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(easrc->regmap, REG_EASRC_CS2(mc->regbase), &regval[2]);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(easrc->regmap, REG_EASRC_CS3(mc->regbase), &regval[3]);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(easrc->regmap, REG_EASRC_CS4(mc->regbase), &regval[4]);
+	if (ret)
+		return ret;
 
-	ucontrol->value.integer.value[0] = regval;
+	ret = regmap_read(easrc->regmap, REG_EASRC_CS5(mc->regbase), &regval[5]);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -100,22 +130,52 @@ static int fsl_easrc_set_reg(struct snd_kcontrol *kcontrol,
 	struct soc_mreg_control *mc =
 		(struct soc_mreg_control *)kcontrol->private_value;
 	struct fsl_asrc *easrc = snd_soc_component_get_drvdata(component);
-	unsigned int regval = ucontrol->value.integer.value[0];
-	bool changed;
+	unsigned int *regval = (unsigned int *)ucontrol->value.iec958.status;
 	int ret;
 
-	ret = regmap_update_bits_check(easrc->regmap, mc->regbase,
-				       GENMASK(31, 0), regval, &changed);
-	if (ret != 0)
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret)
 		return ret;
 
-	return changed;
+	ret = regmap_update_bits(easrc->regmap, REG_EASRC_CS0(mc->regbase),
+				 GENMASK(31, 0), regval[0]);
+	if (ret != 0)
+		goto err;
+
+	ret = regmap_update_bits(easrc->regmap, REG_EASRC_CS1(mc->regbase),
+				 GENMASK(31, 0), regval[1]);
+	if (ret != 0)
+		goto err;
+
+	ret = regmap_update_bits(easrc->regmap, REG_EASRC_CS2(mc->regbase),
+				 GENMASK(31, 0), regval[2]);
+	if (ret != 0)
+		goto err;
+
+	ret = regmap_update_bits(easrc->regmap, REG_EASRC_CS3(mc->regbase),
+				 GENMASK(31, 0), regval[3]);
+	if (ret != 0)
+		goto err;
+
+	ret = regmap_update_bits(easrc->regmap, REG_EASRC_CS4(mc->regbase),
+				 GENMASK(31, 0), regval[4]);
+	if (ret != 0)
+		goto err;
+
+	ret = regmap_update_bits(easrc->regmap, REG_EASRC_CS5(mc->regbase),
+				 GENMASK(31, 0), regval[5]);
+	if (ret != 0)
+		goto err;
+err:
+	pm_runtime_put_autosuspend(component->dev);
+
+	return ret;
 }
 
 #define SOC_SINGLE_REG_RW(xname, xreg) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_PCM, .name = (xname), \
 	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
-	.info = snd_soc_info_xr_sx, .get = fsl_easrc_get_reg, \
+	.info = fsl_easrc_iec958_info, .get = fsl_easrc_get_reg, \
 	.put = fsl_easrc_set_reg, \
 	.private_value = (unsigned long)&(struct soc_mreg_control) \
 		{ .regbase = xreg, .regcount = 1, .nbits = 32, \
@@ -146,30 +206,10 @@ static const struct snd_kcontrol_new fsl_easrc_snd_controls[] = {
 	SOC_SINGLE_VAL_RW("Context 2 IEC958 Bits Per Sample", 2),
 	SOC_SINGLE_VAL_RW("Context 3 IEC958 Bits Per Sample", 3),
 
-	SOC_SINGLE_REG_RW("Context 0 IEC958 CS0", REG_EASRC_CS0(0)),
-	SOC_SINGLE_REG_RW("Context 1 IEC958 CS0", REG_EASRC_CS0(1)),
-	SOC_SINGLE_REG_RW("Context 2 IEC958 CS0", REG_EASRC_CS0(2)),
-	SOC_SINGLE_REG_RW("Context 3 IEC958 CS0", REG_EASRC_CS0(3)),
-	SOC_SINGLE_REG_RW("Context 0 IEC958 CS1", REG_EASRC_CS1(0)),
-	SOC_SINGLE_REG_RW("Context 1 IEC958 CS1", REG_EASRC_CS1(1)),
-	SOC_SINGLE_REG_RW("Context 2 IEC958 CS1", REG_EASRC_CS1(2)),
-	SOC_SINGLE_REG_RW("Context 3 IEC958 CS1", REG_EASRC_CS1(3)),
-	SOC_SINGLE_REG_RW("Context 0 IEC958 CS2", REG_EASRC_CS2(0)),
-	SOC_SINGLE_REG_RW("Context 1 IEC958 CS2", REG_EASRC_CS2(1)),
-	SOC_SINGLE_REG_RW("Context 2 IEC958 CS2", REG_EASRC_CS2(2)),
-	SOC_SINGLE_REG_RW("Context 3 IEC958 CS2", REG_EASRC_CS2(3)),
-	SOC_SINGLE_REG_RW("Context 0 IEC958 CS3", REG_EASRC_CS3(0)),
-	SOC_SINGLE_REG_RW("Context 1 IEC958 CS3", REG_EASRC_CS3(1)),
-	SOC_SINGLE_REG_RW("Context 2 IEC958 CS3", REG_EASRC_CS3(2)),
-	SOC_SINGLE_REG_RW("Context 3 IEC958 CS3", REG_EASRC_CS3(3)),
-	SOC_SINGLE_REG_RW("Context 0 IEC958 CS4", REG_EASRC_CS4(0)),
-	SOC_SINGLE_REG_RW("Context 1 IEC958 CS4", REG_EASRC_CS4(1)),
-	SOC_SINGLE_REG_RW("Context 2 IEC958 CS4", REG_EASRC_CS4(2)),
-	SOC_SINGLE_REG_RW("Context 3 IEC958 CS4", REG_EASRC_CS4(3)),
-	SOC_SINGLE_REG_RW("Context 0 IEC958 CS5", REG_EASRC_CS5(0)),
-	SOC_SINGLE_REG_RW("Context 1 IEC958 CS5", REG_EASRC_CS5(1)),
-	SOC_SINGLE_REG_RW("Context 2 IEC958 CS5", REG_EASRC_CS5(2)),
-	SOC_SINGLE_REG_RW("Context 3 IEC958 CS5", REG_EASRC_CS5(3)),
+	SOC_SINGLE_REG_RW("Context 0 IEC958 CS", 0),
+	SOC_SINGLE_REG_RW("Context 1 IEC958 CS", 1),
+	SOC_SINGLE_REG_RW("Context 2 IEC958 CS", 2),
+	SOC_SINGLE_REG_RW("Context 3 IEC958 CS", 3),
 };
 
 /*
-- 
2.34.1


