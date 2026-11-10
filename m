Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF3C606A325
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lKjoRVfZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPLrr2gTZz2yD8;
	Wed, 11 Nov 2026 09:28:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794312500;
	cv=pass; b=eIM0MoBCwHt5MYlAr0kcJy/pn6QkO8d/6gXXcMHoosKxbAS55I0s+Lc3h+VKL7LQVJPpgsBTr3Y40CJf4H2VbkrSXJJUxcwOzbLWfkL7KYW2trvNGHUKfEZ1Uj2RQJDRS2YElj8i8HmMYnyYBPpj8HNv+7xHUjLC4HxA15RHYS+WjcdhmGDIMKxbrdOyNR+U8CYjWV+6FzLKwE0CPQkYnqeQRChQan48yHr9WKM4tq/uzysQfblJ6Ng7+HSiSxguctdFGlVyusMjR3JxwOYMaGDdEoRlWmDiQTHTEEvOCylS7gsArNkshNHR5nWiq80BSQyvNShiSiGvL5x8PAQSJw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794312500; c=relaxed/relaxed;
	bh=1p4Nw1sunRb8ttSMBWqNtRGqe9rUhE/XBa0xE2BwA98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y8pTAaSMftxmR4dAso4159kO4yodCImID5AtAodydkmeI5NsVIVDlbQmXEESaqhCblHs/eVgh3UMJtD4AiegZXKLqG81IIGjqRGl40LavBSjqb6ZENOW/5ZEYNRVJCSnmEn4FBx611cjwOUBNYaMiphHXnkDZUO1nv4Gi9AtBRP8V3ax9+mgcZISTY/0sDsrYo6o2L8LuWP0+A97nvmQaZX9jw1qj+vvvxUF+0KoXjJekKGP10wmjsLqHCh9fMn+qEFTq6ohXxtCXOIjBlJZHHNZvyTtoGWcM8qb9FY97sXBeQmXuGu6gqmOVvsABFJv8PYAKDVTz+M2CTzrdOjtHg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lKjoRVfZ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=stefan.ghetu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lKjoRVfZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=stefan.ghetu@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP55b4mLXz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 23:08:19 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItTRSVR8njnZkBVoWFP7LwUGx/b4N/EgQQs8CdRyAcAKRhOCJTJoAM6JAy9cSERq6kGV1HycBKqaOyaoLMkWIXP555TCXTYTWuhmoFX6b4Ex6HSarttIvvUuhBgCRQ+EkiCPh14NieKJPEBcCIwnDb3MBr2z3bxuoz9/8k8q0aTJdWtsBU8Zg1q0n3WcOzg7RkIMa1ckAcA4yZM/znlm63VyKSoG4S1bq5pj+/4APfN23D/CB/IfB1jefTxoWUhb1QI9y66F2yR7e9IDYI5vnfnDVEse8H3uz4Zt+/iFAZMVgfvOsOzHdlJe97AJiaHEUOImqoQCE0LupfCSKD5Xtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p4Nw1sunRb8ttSMBWqNtRGqe9rUhE/XBa0xE2BwA98=;
 b=jl20BbBgdywNGZ396nsSn9WE4UaT7wL+9PEwD6QfuszUU/kYV2F6mnmFDh25qjgQuhIEcmhh4fa0jKpIOp8HCsKnbokyiB8Mp8/Q8hQZ+X4sTEeTMRQ6FL2MEnykJ7BS+Yb83Vs5p5l5MIwYz79NKD7tOAZo9LsRjm38T1FMDWWsfdQWLRSRB/kunfmWywuGHaIc8yBlFiehPVs3wPS7/LWCNRa0wPVW6MPxAaz03/vEIO7peLKmtG0RTWmAGyzjOwwN2XYcTztUOzAMVAXfT+z7cazgtVMxcw0q98eBTKyCfGubcXvaSR9FtmYNdY0A53i92d6D4S0KIicUVLlojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p4Nw1sunRb8ttSMBWqNtRGqe9rUhE/XBa0xE2BwA98=;
 b=lKjoRVfZ7HIFJOP2klMrDUJDJWnIK2i87scaWqkexsEadT/4Lr0ea7csN1PfebtBo+ZQamrmyCW5TPq9mzRCUKI2sPyl0wkBPXJ2eiDEcvt9Rc1Jt6lbnyvMFNjz5EkOH88vUHOTuF8J/UMDS2Fb6Jr1lS/T4KkBjue1P6pj+fhNDo+Xrqp+S8GxH9U7SFRkTmd+tRruZMpz7U9ouTaZ5fwuMLSL7CPETTM+nMbOJgIGZ69u9rO+mWW+83gSPR7jgKDPfT9Hh1pQoojlKvlMZ5rdnWsYpm2Xxil66UZk1GxYpk8RQ6Zu4b7+kI/jZbCDLEGZ1iHFD9HuztMb5M+CKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by PA6PR04MB11832.eurprd04.prod.outlook.com (2603:10a6:102:520::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 12:08:10 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 12:08:10 +0000
From: Stefan Ghetu <stefan.ghetu@nxp.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org
Cc: daniel.baluta@nxp.com,
	Stefan Ghetu <stefan.ghetu@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ASoC: fsl_asrc_m2m: allow only one task at a time per
Date: Tue, 10 Nov 2026 14:07:43 +0200
Message-Id: <20261110120743.6301-6-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110120743.6301-1-stefan.ghetu@nxp.com>
References: <20261110120743.6301-1-stefan.ghetu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0030.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::11) To AM6PR04MB4472.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::20)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_|PA6PR04MB11832:EE_
X-MS-Office365-Filtering-Correlation-Id: e33c5e56-1cf0-45b8-4800-08df3f2349af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003|261009223027099003|261028144727099003|261102123227099003|261021121427099003|261026140227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	FVYc3DA7X7V+mX6PhuCJ6OO8Q4SkDeKE3doyHcx7dgtv4HJ2AA1FFHvup1gjbTy5Pp7LFXMtYGqgALzaPTImwr+SsViwDrmtRcHZDlg1k09QTiTVxdNIZyg3mPu8NQbaNE/hcUZGSgrdo9OWiOx2YorTR5n+P8/x2ioTV2XlFn5/lhIDWjSifGz1eHqsZo5XmiTJIhsT7o/cxqzIWq+m15A+mA9ajGE5rnHL+NaLx2ljz8EHL8wBkVjbVCQawN83H5D4LA0SbOuwkiQGBagNM+AhQkopqulTT7kZn/oh7Mmh6ChKh+m5k37hTcXg+SGCT35ca5k5HsU47wzMv+z9gxwcTzH+G86q+mXlArTG9rrdjP1SQZGzps0s/Q2QtLYzrs+oUTxhPHr+nGv1vL8No/gq+PCCKv3F13b4AiN2OTb83zZFJVyAYz1oHEu2e020l/vH5viT93g4Sx+ezS6T3HFgyIYP4qW7dftWwrUuzhBDhCBBsLCdT0B3kfmRQY0CSl1Xq6a8k6g0IA03B6A/nCTx318DINsH85xvj3qk3wr3F8dNhODgNnEs6NOHRkw+e4sY6GXVZbYuHLYiTHyLbzlv4jynbTkNoRZWzZhG9Z+0anWuBCrU6gis1nNgnxzyot8jPgJ/HlL77GQNDOn1m1rYQ0cC4kh63qeI/lAh8Kc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4472.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(261009223027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261026140227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ywK8ELGCAf3xBqwOU2AqQh/7Yr6Rvi8vK6wddd3XXoJmNDZ/3SLP/QErKoqu?=
 =?us-ascii?Q?QViryrbJwAOeMXOFqSLtsSJtjXfD+NFllnNan4NZAEF3rrt97fc3J1cmj81e?=
 =?us-ascii?Q?rIxDoGuA3Scrqk2JFHN/ZOgKEyYlcVDh82ZKJyjpX0qcoPLSg5lPyR1AQi4E?=
 =?us-ascii?Q?2GwkWWqjFTvfaoROm2CsVM7X36/o4gcNnzoilfWk623QfKZvUewJStTBhVNn?=
 =?us-ascii?Q?uvD8x3KEUuVxTS3pIeeSVXf1wWlcFo47Gq+5gSFfBgBpl8PP8fqO/sBenHVB?=
 =?us-ascii?Q?Ukg13QxQHddHaKDRpF8UmL1NUDFFVagtA4yZouOLjJEZWwwhEF3SBu4S8WQ9?=
 =?us-ascii?Q?wUvYatAfTdgylcNLcwPm3FGWfFp6AgaS4Kk5zK1uK9rrRpcqR/JTfKVK7q5t?=
 =?us-ascii?Q?JvDMwBEgtQ3lwPDOhjPjWsn0lrJU1xkqp0ljNVjD7VjttT6JUB5h5skAzOij?=
 =?us-ascii?Q?4/ZbT+8lcybjnBGESEWrWnds9cqZuWrSr62ZR4lIWSGdbAXXRn+9tdB95vzU?=
 =?us-ascii?Q?Qeyv2HW0M/RKDYB4m5cYxdz3i1HJcwuqskXYsOs7dl3Gj+7MsuYHcKtHjxd0?=
 =?us-ascii?Q?ldrbrs+cgA7PmNo599Cc/QY/7NQ7LZvvrwJs+u4Z/9pEXEH/2sT0Z4ulKT14?=
 =?us-ascii?Q?IkDoMEQj2fpL+rGQ6Eqco6z530/vp1cfFe6ZfSEdK2aHHXdPsWTqxp/3y5cU?=
 =?us-ascii?Q?vhbW+CWNyLR5qLbnxcUjCE/Y/hvG93BLsQFpPGJQJMcmUb+tff19vxItLJkn?=
 =?us-ascii?Q?U2fpD2W9tmCEojZuWKk6/VRyLJCEwuDGR/PxFRgAQl72xu+b/iWo1h/6s/lM?=
 =?us-ascii?Q?P80f70d3sR3DE+FWg/+Ffm5TxHLfQsgnm13V4yQ3wu/KHLUpqa1WQFUlHX42?=
 =?us-ascii?Q?Ud07G2TdMS1dwpGzdkdUjkstP6s44R7OW+2fnRupgduTJ6UqgcJXT8o/RjMO?=
 =?us-ascii?Q?S2kEfi5ujcWiN9ExGaW+6GiZol+JJ5XPp5kg2dzFhbjGkoZGp3VRmk3YrHFh?=
 =?us-ascii?Q?hb+5CdC8ZuBd8DJImqbG8AsIpPEICSW90ItcEfdSD2JbLvonrZ+nYBZHJ5oD?=
 =?us-ascii?Q?WVB/Y6SJY0zGldigwrYY4Ydp4DDYuB7uEq4u6s/DVn09esXwMQn+zL5nw5/z?=
 =?us-ascii?Q?HFVp5nn74IgKW31kGdV4F3SGT4/o3Hd3xysoEzbbX+lX1EeCyRCLPhKx48xP?=
 =?us-ascii?Q?zMEyYUpNUJz0vXehSoUBMFPEiUCoXI1LLERTrr19yTNAVjMq5NzUkyYNo9oh?=
 =?us-ascii?Q?MHAgaez59JayhCmTFeJKkawssX34Z/EDw+h67vyJDXjZnjrZY2xjsHpVDwzU?=
 =?us-ascii?Q?0IlD2KBx+3H5fi3q4P4jVyQNUlm1ffv/rBnh76WNC8PnOPv79fJ9lOohabBt?=
 =?us-ascii?Q?Fmlo3En6xvXIRjYqeQ5WIOCXQByI16ETWMcV4eCXYj5YpWa4NluHEBa6gLCo?=
 =?us-ascii?Q?kUoHiKO74pnFvxREy0iWqQ1gG699xFoBpzI47JHiOsOFAP9RwmuEojT4CyH8?=
 =?us-ascii?Q?i+HJcmgqswhMxamtKdSoyHUb1DxcrTutQ7LU4JIvDA5G8a5/+vfV3aE8OHV0?=
 =?us-ascii?Q?D9Jyi5Tpi/U+KP4otE7bExPRVzg3uXgs/LY2cJJDcDaLADXI4PogBJ8e6nYF?=
 =?us-ascii?Q?sROV0wU/NzXOleOy+K9g9pyqBeB8eCUPb3lJzOsbtFcv1vqLSv49dpdXQviA?=
 =?us-ascii?Q?2PJlbSrtE7d/qJxb6z6k0NR53nakS6470kkATpPVwMmY0V9DbzTUQ0hGCH80?=
 =?us-ascii?Q?l9ucY/rEOg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33c5e56-1cf0-45b8-4800-08df3f2349af
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 12:08:10.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KS3XHPzQE5xWogUWoMxxwHs/NfZ+0wmTEMTR8FK63aQB2cWT9tTG4KdvPdQuFCTnyrQzi5SAMRKJOE1pLaoiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11832
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

All tasks of a stream share one pair and one set of DMA channels, and
get_caps() advertises a single fragment, but the compress core allows
up to 64 tasks. A second task requests the pair again and overwrites the
DMA channels. Freeing both tasks then releases the same channels twice
and leaves a stale asrc->pair[] entry after close.

Return -EBUSY from task_create() while a task exists, and clear the DMA
channel pointers once they are released.

Fixes: 24a01710f627 ("ASoC: fsl_asrc_m2m: Add memory to memory function")
Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
---
 sound/soc/fsl/fsl_asrc_m2m.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/fsl/fsl_asrc_m2m.c b/sound/soc/fsl/fsl_asrc_m2m.c
index cadfebb12e7c..2e91073f14f9 100644
--- a/sound/soc/fsl/fsl_asrc_m2m.c
+++ b/sound/soc/fsl/fsl_asrc_m2m.c
@@ -471,6 +471,10 @@ static int fsl_asrc_m2m_comp_task_create(struct snd_compr_stream *stream,
 	struct dma_chan *tmp_chan;
 	int ret;
 
+	/* All tasks share the pair and DMA channels: one task at a time */
+	if (pair->dma_chan[IN])
+		return -EBUSY;
+
 	exp_info_in.ops = &fsl_asrc_m2m_dma_buf_ops;
 	exp_info_in.size = ASRC_M2M_BUFFER_SIZE;
 	exp_info_in.flags = O_RDWR;
@@ -527,6 +531,7 @@ static int fsl_asrc_m2m_comp_task_create(struct snd_compr_stream *stream,
 
 err_dma_channel_out:
 	dma_release_channel(pair->dma_chan[IN]);
+	pair->dma_chan[IN] = NULL;
 err_dma_channel_in:
 	if (asrc->m2m_unprepare)
 		asrc->m2m_unprepare(pair);
@@ -571,6 +576,8 @@ static int fsl_asrc_m2m_comp_task_free(struct snd_compr_stream *stream,
 		dma_release_channel(pair->dma_chan[IN]);
 	if (pair->dma_chan[OUT])
 		dma_release_channel(pair->dma_chan[OUT]);
+	pair->dma_chan[IN] = NULL;
+	pair->dma_chan[OUT] = NULL;
 
 	return 0;
 }
-- 
2.53.0


