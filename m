Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624A606A321
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ISyRSiFb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPLr41ZtCz2yCr;
	Wed, 11 Nov 2026 09:27:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794312496;
	cv=pass; b=lGM1bFsQdaZkOHf0vFBMxiG4FvYEO5v0WvHQpBIetHQln4t5K7sMuiRK6fuQu6JqpOEwsgN8h0SoQZsFzqKA1EmeAnei4gqHStceeaw/O8by8o94KZ+JZ2MfmzoOe+wXL5eedcVObQ9bPv/Ln0nd8CAzF3z2mE0dHvfRlZRdBJINI0WC9DOf5PdtpY0DXoPd69apx531dRiJ2ZEZ3u+XIG507w6t4P+MU3x3wZNqolNBqEPrMmqFfhy0qUQHks4pDe2itiNg3fW35OYEdfMUsOF493kHV/buAyeuhYEz4xrJnXD3ZPCEhzkY46Onj7MeR8D8xEDqY91rmYtX9TJ8Kw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794312496; c=relaxed/relaxed;
	bh=Zydgs8tzJoQhdXVVY+DSLsMyZAl3hgzQcFFRDBzNatc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Axy9a1TH39a5AdqQGGWcCEz1qTXY/CUCXUkwHKNxodI8gv0dHSGaEFi8Cs6tNlNj5PdPG5YdrK8lh5F74Y6pRIWB6zJKuJxX/THbDOaTQCEckgsSw4LNCU0BRAJbPe0wMPZZ2syVHGhMR5skxmp/783eaMO4EzurgVXtMR4+INGo5NPjbQKA+qSskDIHP8GnEa5masg7OSkVen0UfarEjLttEGJ0d5XDW+WJcJ5LuK4xL+wiZnGX38kgfuOPvKvU52ctT5Hsw9Bom+kTV+SNzC2Vf+EvQ1k43RW+4v0HjbiF+WkAk+CVoiyJp1qoT6BQj59AJdYuPSdj/ITQHhEvtw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ISyRSiFb; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=stefan.ghetu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ISyRSiFb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=stefan.ghetu@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP55W1y5jz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 23:08:15 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iODWcMiu2pBcL7bZWDjjHTVUy3X4puDUwV1iKYSjZRK+sYP6uVk56WRrqh9zM9wJqk4PpvWKDLvmIhfdrDHKCGzTfcehJ47842U89xqsB9nv/HSAzXbJ2hELuBw5pcTnpyPOovHMJTwPYF62gM/C1XKXqgs/7KzRM8bvFNY+I8nRIHiqASjNXzfvw1O44qa9+if7W7tvXG7OR7WuFYc6Tv9Aer8A6KL9c5uGRCtxnwpL4ECLWo60tH+PV5OK6RYS5LftMGqqLQKOUzCirsrn3GkFKbYf9OMP+osZNsa0revvFarQHG3ltesZ8AfTMx8r00A4o3Uq+a9x3Ydfrifpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zydgs8tzJoQhdXVVY+DSLsMyZAl3hgzQcFFRDBzNatc=;
 b=I9Er3iI0jv2lx5SNsD4h5ZZDQOoqQyTgn4qtId+V9xpjcaLEOITZX1C+TEYg3Zf/nNO5rl/cP5q+RMMrFqzosm9PqCPGosf8y0pzJiENwMSkEDRK+DrftQ0mjfdhL2likJQJcvrWEBlvHN9DSpXOy82vx9NOCuFEGjJysGoHywwUpoDAuY+Z0ER1RHQpx7DYU08LSNEPFh5aZoEEHe/DWzJsS+77gb4t4sz6tEmTI9E1D0sHkJHivcZ4vtTZOJIYVs0tcIS8qNgNBxkNoBwDycMNdvXLhdtzQgIzSu05yWYRrlHhz8HS5hXEQQmFQm9YWqAdGLNZ+3zokAhAGxfj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zydgs8tzJoQhdXVVY+DSLsMyZAl3hgzQcFFRDBzNatc=;
 b=ISyRSiFbQJPcIvXsjSIQiP+WeHOk3BeaxzOwU6wfE/Hq25irNw1YAA8eOA8k/Fu+ihI6+0BnHbZW0jX8UCmy0/kJeDhyRNbDKF43v38Yzt/IdW9/n8cQGj6yi/0LhLcOZDnz+El1lLYFNwo2EpQVMezE1inoKc2tFaP82gpQ1ENzx1P4sBtld8rI0+rN3LS3af82gWIEvL3MRSr16teAw7Wx4MRZ4k8cl6r6yd8Rb3VVDwT1nFvm/JjLHtoGNFNUYyW6vQH2mKgHeyeISHZcB/+m9G9gFZiXY9N2FDEH4U72OX4d/UE0l0gn3DSKM5hOXdftv5qepcqc2y5qyNXemw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by PA6PR04MB11832.eurprd04.prod.outlook.com (2603:10a6:102:520::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 12:07:50 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 12:07:50 +0000
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
Subject: [PATCH 1/5] ASoC: fsl_asrc_m2m: fix out-of-bounds write when draining
Date: Tue, 10 Nov 2026 14:07:39 +0200
Message-Id: <20261110120743.6301-2-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110120743.6301-1-stefan.ghetu@nxp.com>
References: <20261110120743.6301-1-stefan.ghetu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::6) To AM6PR04MB4472.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: e6c1d387-9adc-4153-ab1b-08df3f233e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003|261009223027099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261026140227099003|261022105027099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jNSoa3FNeZMlCptONXJURUtv1AnLTomDibMkqlEYzQXwuY9/SsBJJWEr4+aIewpdr95p002qRxInEAvaQvvMsMfviHZMrw2bDe5CnKzbIiLtjq0deZLqlz2PDKT+qNLNLle/eDxYMTvpJZWqt7SsefVdCD1neViVa2GlyrRAuST1QSUVwZ8PZKjO45Hu4fy5forkSy9yL9lZJnnq9IsELJTdNa31XbH9rRQP69U+rj9Nr1gRTrdNXhU85qLrq3dJ3aGFrviP1EA4jLlIem4OQK6tQ4n5oV1xevZsV1lAC775LCL1w9sDxgdHSeD2gNdsO6yQBJIzZMjrXX746cE0ejxkldv83ljR/TzORBU1Y8zcoU3PU+QbrlZcZMkoL6jLpVWYrpZWYZdKajUMvk5BkXXLzMaKgX8qbTJp0guAX+Zc9Kas+cHkD4oz75Cge5EeUZ30AWwLhYg1olGak58WG2VHA1I77WgfUnk5p/MZsu50Bua6NcazAQHB+K7WJMP0XPhpSFj9/rig4kOMSu+0VXxuL3IqdovfGhjLX+xqcaMWy68RpZay3EQoo3RSd6X1odDorzROAm4tXyZOpnIw9yOH1kCdvQmGafDvmVmZYD5TdkJtBHk3BAsIf+w/BowhEXardN/dSV0e5rHDfYHDWHIzsGFraqYMURsTlZzaSKg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4472.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(261009223027099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261026140227099003)(261022105027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cw6ze/R/9dtfo56FrV2GTLsxUx7l4laXYHJ24tMbGiM9Ieh4wcqjSsqN/aMO?=
 =?us-ascii?Q?DOBGmUjDjGDYRbnzI31k2TM7rOSEEct61adAkrsSm34aQ7e/delVIoJv8wR2?=
 =?us-ascii?Q?o2VANZ0d2I9yTSsj7rPURVlp8CebGr4fh5fnCCsBVuwdwF4af6TL4+/ppgMs?=
 =?us-ascii?Q?aglZZmUmbInHviaWNJkcJmid9mzQ7GO2FcSQ2jOIzk65cYL23YGJ7PcVJWY3?=
 =?us-ascii?Q?wR7tFvZNqHtuBbZD+p8uSBGybAudkTWdd72MA+y7plVbEi+OPRLdzDWIp8LY?=
 =?us-ascii?Q?xLaXfzrS2OMf6hIy7uSeSiB6itodz/1z1WEDv6Jj7dl+o/UQkLXj+NZU/tAO?=
 =?us-ascii?Q?zscvcm4Sjk3z3e5MwHuagvkKkjXKSJipWmblXH0/zLh20jrnqLDmUnla1usi?=
 =?us-ascii?Q?H+P2c1IbHgU35Ssbr75Yo+vr3uMa9+/I0mIWI5u+xdjSFEEnmI2XIqnLvkVo?=
 =?us-ascii?Q?CWwiu8xMBTFdFkNyAe1Koa8CPNUTG2qDdHaYFHjnLR+FsTw3MHvHS8CP5hw4?=
 =?us-ascii?Q?8pig9Y9PyTxoqHElgkjIgclPdQwvS9zgEqux8WdUIfX2k+dwMoZidFXFkW5F?=
 =?us-ascii?Q?5silnjZLvCtkCkFxvr2d8JgVx00FXCnIhbcvyVPuTVJy8Q6KWv44lscdIOhk?=
 =?us-ascii?Q?zreYvxYm1Jat7ANvOh93DAqqVl0dNNh30afrzjh4HoEgeYUJAHkDyidzX52U?=
 =?us-ascii?Q?IfGYzViDK0jGNVEdcA9K7DYWQomfVenqiEVZB/WNDCmw6ZvK1GZqs9N3BApB?=
 =?us-ascii?Q?Q3fqQPRzv9T55jRsOGFW1RKtq0G7VBS/7aZevfDchlyrBBCgRXaf8FevgNKs?=
 =?us-ascii?Q?ykzamUmMxcn3EcpbDATKgCp2cp4DDfz/Ut6lW6PH3MfkBfmb+pOgJAyMwEFW?=
 =?us-ascii?Q?QBxgBClMX/lpoRZS2lfPt4z+3q47vhFkvg7tYwMl1/r9IESqV+o4Awh5n28s?=
 =?us-ascii?Q?JJxnXK4LTBAn/7BWwwivrCuxxri94UW/xTQ1d+JFMam/jdyvlgblqXv3nrWC?=
 =?us-ascii?Q?YkH9F6DPEc3bDnUvdqcAnkuJFepBXd873agsMnF6TjmzhmXD7yofswJh+YlT?=
 =?us-ascii?Q?048hpFa8m0PcN5sw3aLfuX90aKvmQ73K7X4M9LnLXeuRmk2wHFgzErVdjyqO?=
 =?us-ascii?Q?k1ycCyf5gFkbAHHj6zTEhDuYYqSG/lPB8ddLt/kzp2T1+V9upxs+UBoSC67J?=
 =?us-ascii?Q?YG/gygLEXWJzFygZPT/GgdvsdUhIB5r8FLLk5P229GnKXNUbIBzAPoLEbsDJ?=
 =?us-ascii?Q?iSUVdvD1yhrt6y3btAkbLuhL7JJJSay25okg5/zkwpd/wRajjjSm+sGYWx1N?=
 =?us-ascii?Q?4uEc6h8dJI2ZvXoK6PwwLWeET9P/VZa4oYQbCqGT9JLWLHehqCIH6aWz9g7T?=
 =?us-ascii?Q?de9C9MHEkS2lIc5octe4eX4JDO+661WRA2EYuYvzIWtF2l0t2aZktKNC6mTk?=
 =?us-ascii?Q?YRyRgy2AGEj5TfWAINbXuCGbEHJgH2dWAw/szkjy462bRAFJdx9JWhcTiueI?=
 =?us-ascii?Q?URl2CQcQgqojzTqiSD43M/V0AqvbMtQnjqpq+2HnF/aHBI9FSvWwJH2yFP/S?=
 =?us-ascii?Q?Yxf4693z45zEc8CIoZBLbCMkapwc15D30vvdFv+AbKQmC0tQoPzAqHzk6Rpr?=
 =?us-ascii?Q?ICr4j2JCNHyTZ6v66upPRT1n/VOC2GLHqV7lY4k508IKk1Ij8r/6VPeeC6FB?=
 =?us-ascii?Q?rTs+olRaD54erggR5eW/xt23F5RumYktJZUpWsu8V0L5cjH8bYGNktvT14Ku?=
 =?us-ascii?Q?wd22V0uBEA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c1d387-9adc-4153-ab1b-08df3f233e06
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 12:07:50.8204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xh9jh66l2k36euPrjPCttIXeSIDvfJyMPId99JpvmsqgY7+Mt3/PdaFzlFFiOBCsLKtmHNQD4X4h6cOXyMN0Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11832
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

asrc_read_last_fifo() checks the FIFO fill level, a number of frames,
against a length in bytes, and ignores the frames already drained by
previous iterations of its retry loop. With an output length close to
the 512 KiB buffer size, which userspace controls through the task input
size and formats, the drain writes past the end of the output buffer:
312 bytes for 10 channels of S24_LE with 8 frames left in the FIFO.
8-bit formats are also stored as 3 bytes per sample.

Check the space needed by all drained frames in bytes, and add a 1-byte
path for 8-bit formats.

Fixes: 24a01710f627 ("ASoC: fsl_asrc_m2m: Add memory to memory function")
Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
---
 sound/soc/fsl/fsl_asrc_m2m.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc_m2m.c b/sound/soc/fsl/fsl_asrc_m2m.c
index 58101ce07c9f..cadfebb12e7c 100644
--- a/sound/soc/fsl/fsl_asrc_m2m.c
+++ b/sound/soc/fsl/fsl_asrc_m2m.c
@@ -53,21 +53,26 @@ static void asrc_read_last_fifo(struct fsl_asrc_pair *pair, void *dma_vaddr, u32
 {
 	struct fsl_asrc *asrc = pair->asrc;
 	enum asrc_pair_index index = pair->index;
-	u32 i, reg, size, t_size = 0, width;
+	u32 i, reg, size, t_size = 0, width, frame_bytes;
 	u32 *reg32 = NULL;
 	u16 *reg16 = NULL;
 	u8  *reg24 = NULL;
+	u8  *reg8 = NULL;
 
 	width = snd_pcm_format_physical_width(pair->sample_format[OUT]);
 	if (width == 32)
 		reg32 = dma_vaddr + *length;
 	else if (width == 16)
 		reg16 = dma_vaddr + *length;
+	else if (width == 8)
+		reg8 = dma_vaddr + *length;
 	else
 		reg24 = dma_vaddr + *length;
+
+	frame_bytes = pair->channels * width / 8;
 retry:
 	size = asrc->get_output_fifo_size(pair);
-	if (size + *length > ASRC_M2M_BUFFER_SIZE)
+	if (*length + (t_size + size) * frame_bytes > ASRC_M2M_BUFFER_SIZE)
 		goto end;
 
 	for (i = 0; i < size * pair->channels; i++) {
@@ -76,6 +81,8 @@ static void asrc_read_last_fifo(struct fsl_asrc_pair *pair, void *dma_vaddr, u32
 			*reg32++ = reg;
 		} else if (reg16) {
 			*reg16++ = (u16)reg;
+		} else if (reg8) {
+			*reg8++ = (u8)reg;
 		} else {
 			*reg24++ = (u8)reg;
 			*reg24++ = (u8)(reg >> 8);
@@ -89,12 +96,7 @@ static void asrc_read_last_fifo(struct fsl_asrc_pair *pair, void *dma_vaddr, u32
 		goto retry;
 end:
 	/* Update payload length */
-	if (reg32)
-		*length += t_size * pair->channels * 4;
-	else if (reg16)
-		*length += t_size * pair->channels * 2;
-	else
-		*length += t_size * pair->channels * 3;
+	*length += t_size * frame_bytes;
 }
 
 /* config dma channel */
-- 
2.53.0


