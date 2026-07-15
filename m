Return-Path: <linuxppc-dev+bounces-24291-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F33C4450A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 02:43:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0L8q0m6yz2xjN;
	Wed, 15 Jul 2026 12:43:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784083435;
	cv=pass; b=S5fDjI3qcFXiK1aTvUDpecCdMDmwJg7hH2KU09mCTUrt+DF0FCZCzS6+e1nz++zD+puzB402t3p/cI7V12WJ7mIdMKrIfbnFTM5EVlt27YegTnd8QK+tlyvxS7mXl8lU9bml26BX1V+/c1TVg3jHVQ2dBZCh601CpJ61FUcqstS144HFEEQV6i1ZM2rmlAJQ3556I3XQJKnix7vd99Z1bI9rUiGjZS3QmBBtANMt6RKFgOPRg/xd+T4Yf9c1rTQkfTC32F+7nfZIMma3Lq/DWzPfVHD+8XhTbLbEwEVGfyGt9+/zJhjSq/A7/xFrSQdNecTh56aam7O0FHWEZVv85w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784083435; c=relaxed/relaxed;
	bh=hjX6GRmRxl8mVlHQBoXrp11nuj8B+Qm+pMU0GfQhpEI=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Lup/FAAHFqFtg/qIKi3aJuyuK6RUOv91Pvo/lSTfw+DduLCQtlw8DZ5fi7X6iMN+TczEEqVNJL4436EfOUHh5xGfl8Fb8TsVet7FPc6e7CQhjps974zqzRHCqplhA6c5Eh2bPNbh4lqdZH4lou+AsGk7HB/kiY/UQVUEzL4Qfx8brw+igm82IPTUjlsXRHg6e+OeGbXVlRcwgJhcGqvJcYKxBZw8yqn2A+VpiQwsn0KRBX0WplodW2beTdpMsrjDHzHkgk9Lboek6fwy6DZJY8N5LO1S3B1XLiCvLRDBt3qVH6dkDJE39yPspo5LLiH5AATuXnTwdd42x2vr6UtSuQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DsGPU6jK; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DsGPU6jK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0L8n6dLsz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 12:43:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp2fS8r300t9TJuRWDCvbaBfbVfX4CxFkXvC4DjihydD3mSeFSmFVj8v/CbmY905jX3sBbiKFSVsaz24ylncq0+V9ns4tbsm+yfFFJkZ2afIhn8ELF8/E9ZepZhzPm6HMyIx7O2funn7xGBI3ekRbnDmOFP8N72H8+pgzMICRMTjs/X3WSo4zuePDPxnQzWKBf2h/5PbPixyMyeU0ahGP2PuSwoMoz/N9tkyBd2gGpgYHycanbat4juphVLk7Jp4KfjopeBeSVycR4xbBfXd/Ze5qG/yGQSA9nPW7FWFiYzd48RMRewX6hF2cQM0Rd7NU8dDc9Gjxt0hv2cfgaJXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjX6GRmRxl8mVlHQBoXrp11nuj8B+Qm+pMU0GfQhpEI=;
 b=ygLLsf25OD92iLLhWubg1ezrZ3O4vdLwlMuCVvtF7+2TfN5VGbSmQS7MlGaPLkKomTjTM/rVy8qPIUTA0tzoo6dAtuK3bHdjxUX43dKeOhcmykT1NbH5KNxWHCi6z7qrka7N0tcYtqODsu+NFGo7ARRha90kD9W4sZXvRw0e4PdlQyxs6YGC+DIDFIAyXfeErvXWX2q0SvQAh3OBF7FhKBJXxVe4//ajNO0G6kvl58rG0TnshR/ZvraTjDie+2cnrxWe7qwwL472yeeJLCvdQtXF9XeZzV3IHxlz7T8hDQFGMSEZHnUfb+EdedX+7H/+9M+iIm5+aCIIe2MGomqoTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjX6GRmRxl8mVlHQBoXrp11nuj8B+Qm+pMU0GfQhpEI=;
 b=DsGPU6jK5IB8+P7zbgwc3tbcAWvKx5ZoJDWqpNVW0Zj015BOpLkrsM5mgOaT4XhQSHHbWTBQlxQqXNwzi7rbQYmS1k84UfAk8T1uTuX/X51VQ0YXATrDqWWpGMrdqP+Z/xgxAxsyGaUSqx8xZd6OZ7c4xZCYRDdk2weozWoK/eOXvYJO/Oy5E+NXvgVos5IKEboPZLRX08woCsy4wsZ/uwt1ieMnMgg4hOKKODWymFQLKP+8RiRMjFey51W5xmJti1pPUKX1mk6BZVkhQEuKZL86dvA7VOW0poD3gSWgDJy6ScmL7jGqj29Xq943kIxNNEqmT81e8uoGmeMEnNhrkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 02:43:27 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 02:43:27 +0000
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
Subject: [PATCH 0/2] ASoC: fsl: fix m2m_init error path cleanup in fsl_asrc and fsl_easrc
Date: Wed, 15 Jul 2026 10:47:56 +0800
Message-Id: <20260715024758.1252801-1-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0068.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::16) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 7d75b635-c228-4a1d-e2de-08dee21ad932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|19092799006|1800799024|366016|921020|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	mUmYQZHv+UA3IcKxcbroJU/3e92CsgjWgrBjqLz1m41SVv8RRecb384PYu37/Tnum8jizLz9b8L2k4kicL32R5qos9ZHvQ41yG1tKjnMW+bJabZmGeG918XW2oVE+7iN7gHlgHNulnDhk3TrUDeC4Q1TpubJMdjDrGMq54ysQ6m52jv+qDn+fGnHWVYwwkAde+BCJ75D8as/CsWxnmc5+N7EX6jZFWZVkdwUNDDjOSS8ytmqpERRbLdc9HBIxJTfRo6hB1Os1tdbQaf3N0tukmnqiFOA+qXJ5lC/1HHChgwhetKha1m6yoxsTjiVg0G08vmfEKTNVM8ws29tC7CJn/dC6ykdTnssdY3ythz56LmnUB6HFPCGzAQRRX86r/PGd9TWEkK8IOQaOQ045//LMaJTtY09Uv8EnfWkxpNL44xlCsTmdhuyRFTP4+BA379P8jYRvixH9hzsMb5WxXoq1DJ9vxmFAevLCEJwi0D9MgsEMW08w8KDIeFHABp6MpV4jFXgNOBwZVW+Y28p/G0fKmV1nlDvBkk8cbJolAQiGLGrCcuKzGxDnJ81zzZOzAOICuJp/msM7tabG6dUnxDejRv2/FCAPwk1fhU/OMAdj+B+ehrEmjHjfpGbbjuxRsQbl9KXOGipKO7snzGZ0gZ+lWt+mSeSy4mNuHygArfiiyj8nYjjQTw6KMJOyn9Nhj+8Qn9Oe/uLaPQhgmQ3xk6SuA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(19092799006)(1800799024)(366016)(921020)(6133799003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Tso05no2fs7BQuAWNPWdE5I1vSzdcfOANa4gtAu9x9pMUrZI0Sf4PYSsJGd?=
 =?us-ascii?Q?RFv2MxS63kmB74es2LXbR3jyLzG1DeUzK+KDDkHOUIgQcXXFoT+ubUIyGePJ?=
 =?us-ascii?Q?9UK8lq/Cpew/rHYAC9U8v6OyTq2lS9Yg8BmGj6OlF7iG7PLJklghptQtxohz?=
 =?us-ascii?Q?oQ9nbY3Y0dznIvBasTyo5sa7W5V/tXrSvp1IE5CDvrkUPwwjmMr98stlvSrO?=
 =?us-ascii?Q?R3PbBGr4VfdVlmoK9j0MiJ15t5rYOQD3qEYBjeLnzsDqL+NV/8imCZbnQNTS?=
 =?us-ascii?Q?HLL3YLATcC3uMVpxcotu3grQgHq8eJXoagmwxY6ldvVn8NBCKIckYkTfa9fW?=
 =?us-ascii?Q?fVOtw79O8r5yaex+UyYEqj87JF8o2gtsAfeKUf+k/Sny4GR12Arjpx6z4SJN?=
 =?us-ascii?Q?irVP5hL1W+eO8+HjPdPDWES1TcXaEMfQvPwwND8ifKFL/reNgmOx8d2pTqeJ?=
 =?us-ascii?Q?FtHbeSC17TmyxXVrcfcKCLseu5erCcsv9y86Xt17loUDzDVF1rKQGMBGNQUE?=
 =?us-ascii?Q?hzBSE2uRtTys7rApWsrKmo5fG+GWTx/4TgO11/r0E3Gcb1IaGXf+nFzEHg+n?=
 =?us-ascii?Q?IzNXXUMf+BULoWLzMBqMe1XgeHSS+n4oS/tZI/uT6RkdSipiTxYiHZhM9ZyC?=
 =?us-ascii?Q?rd0pNPsqDnL9NHA6TvqpYiV1zjxIJlAi18LHZ2RTjMc56OBW4NWgIX2YpSrh?=
 =?us-ascii?Q?iagOw4HrOajbXyQ+2uEVvKrQoJRPZrG8UmGwNQVpzvQmkFWJMdi4kvRaonwx?=
 =?us-ascii?Q?HrMcUdV7m67H9QTyBbveOq2MY0vj9boNEe+TsjfiHUxu0GfSvq0EouQnKdy/?=
 =?us-ascii?Q?CqU8jotHqctfG5C+Lj33NHTCqkNLSN5bI/J0ptQSDRyHjPJgx5RN8XcLoIpP?=
 =?us-ascii?Q?Ox0Vq5PxoxphoO6/NGyPBywk1t5AnUlcRQPYEYkTUa+auYnlQZMt8Gl+R/Ga?=
 =?us-ascii?Q?4FGJecLzfJw87xMToMHDlRxAhHbrZGJnZzLU54mjam1nKhb6ajjI8aGzrNH2?=
 =?us-ascii?Q?mk1ZA4ovxFKIVjnLrlEI/p0e4kCpDcQR0r/UQYqEt7PcJOz370xKBm/7AaGv?=
 =?us-ascii?Q?Jj4jP0ToKgCd63MyBeTHmRYNBUxtiLddhzzYLLX/RNARCB7RkNESr1t4tbip?=
 =?us-ascii?Q?7BWo5mzJQ18QAacI32bdw9/r3PuxZ5bcyT/SYxttggsAWbn7EKub2wlQwdBz?=
 =?us-ascii?Q?1f3qhk0VlCDLlXvGJQCleTFTIyFD7ETWYu7Z4EyqwT7HjcfDI+T2FjrtzWq5?=
 =?us-ascii?Q?bgQzVPZC8YuWEkxdJCNVBN7YO9OZHrTlBw/peizPfLB8VByru6Vh6Cd+G22b?=
 =?us-ascii?Q?fmOnP5iNM+ElY61bYVYP3jExch38MZDbguJIiz0nyrBKgMDP0djb+s90oyNo?=
 =?us-ascii?Q?8bCBkpD6A9o3vK7fX3gOwjRWdMxBHi1vHz/g+j180rMadgXpRoORum5aeerU?=
 =?us-ascii?Q?4HWHj8P4s6E9h858rSfE/L2WHlltmai1/atdbhAY2cGxZQdN0a6Hjj/XkyDw?=
 =?us-ascii?Q?nMpMiU49kyhHZmbKYXQ/NIowYFWLGrWB9eE9E4efkrdPD/qvN3kdfWZP+Gd9?=
 =?us-ascii?Q?JZHdtuXd4w1lOmPPaN1W3clUZPrV1qvt3huUm8H/5ME36X/Uh2nDoiYtx2Cz?=
 =?us-ascii?Q?CXH9zPeroPd3+a3gv3L1zpfH0SWSnFh9EVXCfyy4ddSz1WkpGjY7k2ZCjwoS?=
 =?us-ascii?Q?V2oGM5XNuOf3aulD4zkwZ/zhSk//Z+KJedScvuIKpkRXArf+pYOwbEAz+XX7?=
 =?us-ascii?Q?BI/BEJV5ERPQX/3mQrK16ZIchAO/OWhcOoA4uG54MPFHhPGw8js1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d75b635-c228-4a1d-e2de-08dee21ad932
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 02:43:27.7245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVVwApnX/YS8MinsYBdlaShqo/54KHmzksojeffDJAQTvaxCVTc5TWCYOs78JtersfGNtoBKjL94+8IFd7AvoFBYl7bEIwPon6c0Pg7TzppLp6bM3oiD2geMN16exBoV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583

From: Shengjiu Wang <shengjiu.wang@nxp.com>=0D

Both fsl_asrc_probe() and fsl_easrc_probe() call fsl_asrc_m2m_init()=0D
near the end of their probe functions. On failure, the original code=0D
did a bare return ret, bypassing the existing error labels that call=0D
pm_runtime_disable(). This leaves runtime PM enabled and the device=0D
in an inconsistent state after a failed probe.=0D
=0D
Fix both drivers by replacing the bare return with a goto to the=0D
appropriate cleanup label (err_pm_get_sync for fsl_asrc and=0D
err_pm_disable for fsl_easrc), ensuring pm_runtime_disable() is=0D
always called on the probe error path.=0D
=0D
Shengjiu Wang (2):=0D
  ASoC: fsl_asrc: fix m2m_init error path to use goto instead of bare=0D
    return=0D
  ASoC: fsl_easrc: fix m2m_init error path to use goto instead of bare=0D
    return=0D
=0D
 sound/soc/fsl/fsl_asrc.c  | 2 +-=0D
 sound/soc/fsl/fsl_easrc.c | 2 +-=0D
 2 files changed, 2 insertions(+), 2 deletions(-)=0D
=0D
--=0D
2.34.1=0D

