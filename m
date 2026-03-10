Return-Path: <linuxppc-dev+bounces-17960-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3EAEB104A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:42:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVVmt24n3z3cBP;
	Tue, 10 Mar 2026 21:41:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773139310;
	cv=pass; b=oE78hyxrDYPrktQXw+qZnyH7uB7GgaK7elaRhLBTiq0k/TI3B/zV7SxeiEzEtrfbRtbTob8jpAhPSN6u+veft2DDZq/eDTA1GoNoeU/EBubqXF3ufrH2ueb+I9KTmzTfR4/GnZiauTpjtGAvjGvAHNAIAYbpx4kU/rCplG93tDwxav/ItRtCZyMJbyBajyfOPfFmDZT470ppESVAbNgWm/vWVs/91a/B3nGn5siwYhYyN1f1nogH22iO/xvi19dfqO3yBJvyBV/0cjkNIFZWsAAb1W/cW7Jnn5PCNzcP1E5FdFs1N6aHND1ny5jshnmiG119tbw67uxJy5aKVAERQQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773139310; c=relaxed/relaxed;
	bh=AG9wPmsqkKZQm02G9znqGFG+cPu8AxMXrwPcXWeJQR0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8/yVdO2wXrqRZ+0PIwJPnqDoDusDdu7cq4NSZygU7xFWCPYVwvAzF01vxeTikHCoZjDbPQ15pGgCGjYlZ3s3OzaouWaqLHc9gIzxX2sBx7JhSvUW+q+OsrFm63oMEhurIxv5DJSOBuQmtDXLjui6e5DqVW/leaYNk+uj7A5c3TlWZo9PyMd/yVjIhYJgbXPGfj9A6D6Pw1MRz3SIYakQqKLw14QXk7wykcuO5vbBrnRK0jLtdKaLI65XUDqrtHEKUlqV7Bw3abGXTuRLV7oX4ch/eUZrSL5XES1hLK6mlJyU6QXrYCtpndkit9yeRdYN7gq61ARfwlTIMqFvZgBdw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SjA1cFjN; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=SjA1cFjN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVVms39x6z3cFw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:41:49 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCcVYXMuY8XseXRlJKIpliFGYixkSYN+5x6oDfX0t/kGwRnDH0qpKL4pCKPCxkKaAd2K0cX4KLobe1+laDMbEWBGPVK4pjeJ4sXBuagLUyxJlXmmg9lQlNKhFbx+AlVjPvmt+8iwfvVLM7qErNUYP5gr9jHSlJnmMIEi5GjNZuPG6UwUKLz54kiMU1hhVNBMDb7H8G+ANBoAtLPhgFX+dysw5eHS9lAQBRq7tNycunlQWHiMC/nQuTPE/lCddP1W3sscmuYte48V2BEYpEXIJwHVY74rD81u/Y97eRI9Qv4DbLbjj7p5sQoWMuI/YW3lfd9aevDWBYIt40WwqNXxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AG9wPmsqkKZQm02G9znqGFG+cPu8AxMXrwPcXWeJQR0=;
 b=i/nGtCktIpyQBfmogK10zmnJP9jtvYAy0MnNPduSk7vZrK0epCd/+yAl/Ha7o47ufR15JHZrerFSakM66ylpYey/G+O55FSrMm6RwbIEEDtj90qmLf5HRuAjgO8HI1BH3rXAcq/X/cdyUzYRd//BRPOJFr5x0vHApV/nBFHip1AXPcCZ6OK2yxYhQzORpPBOHHAV6KCrjMV/mHK4rctKk4RRtlHboxpP0jQ3tudo8J5V0EleTLQ264FRATVrOjoEDabDAu8edlyq5CeMjb6D3ouatvUgzbw0+ziU11kEKgo0F0dbd1JnT7l7jNn8w4Vt7L0dL2pz+PhUVykwW5vSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG9wPmsqkKZQm02G9znqGFG+cPu8AxMXrwPcXWeJQR0=;
 b=SjA1cFjNXbhYl92GiViMk0OQodNrv4qMh4lNbvpENbRNrhbkEXM778LU3NJe6WYAi1iL8iH8rmIWX/pEaBdfdlAc0H3eIh9rKqmCicB9z49w5jr7asymDxOb4+/O7/AXtF/ZPqzOxeVQlGHUaImSk1ZpCJ+YSrlEUiTdCIB6J0RrrBPVRbRD0o+1JSyLd9r2PeIWzuf1543usRYwh3MBKYOlZNghOUh3o7Z6L0wH/yJkFyxy8ivpmhwYomDQ0+ksb/eJkSueUKMiiQKMqwVHtzfSdFRuW9T1TXrJkfONQL+O/S82GdtTgm2RjWogb5d/PVYxCS68pIGAKdR726EE4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by GV2PR04MB11833.eurprd04.prod.outlook.com (2603:10a6:150:2fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 10:41:27 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 10:41:27 +0000
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
Subject: [PATCH v6 3/3] ASoC: fsl_xcvr: add bitcount and timestamp controls
Date: Tue, 10 Mar 2026 18:42:35 +0800
Message-Id: <20260310104235.1234569-4-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260310104235.1234569-1-shengjiu.wang@nxp.com>
References: <20260310104235.1234569-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To AM0PR04MB7044.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|GV2PR04MB11833:EE_
X-MS-Office365-Filtering-Correlation-Id: 81127696-b234-444b-3bf5-08de7e919590
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	emsuR85IUB20jDMfji1XNhrIsB1V+kD+6EX7Xw+VdlCS45bao0paDcMvo6DODBcj8WsQV2PPn+CLqqVhMqcr/p+dfXC+t98omDFVYMKFqBgQQygdFLqqHzSTIWyFyMe9oSfz75mkPYVJ31YmImEzM/mEULKqIUH+FcPdVJvT/gmI1uMYKPDpDY9/1ouHr3cY9dcox4A7gTOIZnBConzxUDeccXIvu9sXcMvYBvwSdwJmWOLtrcDp/xvFhGJaI+iiUyFnZMNAPP+M1gytp8wpJfRisUR//s4rMJVGMKgEDbEQA+BqMgS1KmiV8ZuqFeYxv7WqSKylMtkWfOHB7xivDMU3ln0VIBr7IKp2Sa/WlgJK7euR9AQdp4ophwG9aUR1RRM34pbYIVbLdeymYTOgStucLNpaETonVMC1AVdqVfn72b8gpULAtgC611slfSwRDe/VnlOdR/DD5GM2n+VIHncT+CLf8kWM2lylEf8hKhDbC9HdaUbeYD3zXR7cDWUbuhcmUmfiYAzwpSalAWhp+7X25noP+A2adWJmWMrx1a8Zs/hVweJVk6rZqBi4RMQABU5Gc6Uoj/m5HdVZEFwXbtgLRBkx43RAGVRU577afrnLZrY/T+ynB0vhAIlDW33Y8HkbdhOzpY7qraHTQARjansUl4KQSicn7TtRr8qLddI6pM8JmiI53L+E28elhbmt/C56uq7LUhbYHgLtC15YNzIJ/ncvGnOorYzzRM6V6I9Gv2Gr8R3lmyDZnvUvqTa4ahB1MgWyoHsvs7FYyO4sKkzs2DOeHzk39U2wcczI2ASvrU8RzBFc+z3BwOTVj3Kg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L/jtcmbFWkA9Xx0YL1O+WUOMvI8ulDq51R2aTA8p3w10pW5m5X6rCWUpyxmY?=
 =?us-ascii?Q?31csKKfYWxSwdvJFi9vxS+e5gMbK6v0B9PwHRVJ7Sw+FpUHnE0971DXHC2XL?=
 =?us-ascii?Q?4ZtAYZx8x1mtBZLvdBZ+Y+Pal3mNRjmPuGWZCCoq0cu/X9RQ11RBEWCb7H8p?=
 =?us-ascii?Q?aoZZUjzY6MgE7hrccTl0Bww0SavbxbFCQmp3hO5wCKBoIOJRGsuE/lBtd+Rz?=
 =?us-ascii?Q?lYRFB2uUboyhstVPrA5yp1bv94esLa6KL1vHHRG58AiPK66oxuEqk8POTh0/?=
 =?us-ascii?Q?zEaaZNAnNOfgNNkindE06NFUkqlCVZEB2D9OdaTxFIk6Aw2ogVbgHgOA1sse?=
 =?us-ascii?Q?OSSS3YbWObZ9IdSrnDHDeJrSITOzJhHD4oeCGdTTXo1jLL2V9UCITxOY2JJK?=
 =?us-ascii?Q?HhhSA/JIkjw8u3DSjO7F//7CE77VISHiR0rU0UyyQFf3zUDtstUj/ZT6FUb7?=
 =?us-ascii?Q?oLe8csUrRwVqnvIc/+8MLiI/Xq3CJCua6YAWhBK9dE2xvyNU4S3KSXi5O0pt?=
 =?us-ascii?Q?0DfSQUufAPXcOtEo+fOMcJMDnshvz3vnH9qvBAeOeRTcX1JbXf+NQbuDgUjN?=
 =?us-ascii?Q?90nxTbtzNhhSQfncimTr3w9UtvOV78QqDBxkF/l8NWAN9Q0GUBdZkgh/OK0I?=
 =?us-ascii?Q?yPjNLZ5L0arR+S76SYe6mgMhY05mww40gdxijziaDouoKt6HDbc+fAAQMGaJ?=
 =?us-ascii?Q?EEWbWnlOqq6LqnCLS1oWbO/tbt8IQm+NAKyMqUydRJxm7lomZCzrNv4wUMBH?=
 =?us-ascii?Q?58kIFL8Y4fXsBUlSDW7+Ymt16buhwE1gcmtwqrQ+LLvn2Zp6coGeP0T5LvsG?=
 =?us-ascii?Q?XW0cpKC7g1bya8bqDY8jvZr5GhBdZ0uvsaTqUcWVLuFIeq3SV1ylFwz/KYf2?=
 =?us-ascii?Q?MQpY45BEhyjQyakykOzzbaHDWEixLfCIr57AE2FKzP23lSRSJlW5fKAIbtWQ?=
 =?us-ascii?Q?BzgT69w0T510xPrxDo2xcrOMFGLC05N4tURy5BBTYbQWb7dstUPkSkZysfCx?=
 =?us-ascii?Q?I+FhQYe5/q50LJUCkGnsTXrsDG4VcvJM5rYXJ6OLk21Ft4FuLpt8q8bG6toI?=
 =?us-ascii?Q?LwFQr6vtCTUaCtV2he/IXyJEABsluHYdBqNafySu64m/vwQzCoieLorofwoZ?=
 =?us-ascii?Q?BcsABaHWe3cYD1nXoINHkNKViNr0/GxrMWlb2r1cg0uF2zqbKnCcKw02xBaU?=
 =?us-ascii?Q?eKbVFjtTgmxHOnCOTzrmkhnVJ7vcwlvQz2HZcXF+gzrta55KiRKWY50wz9YJ?=
 =?us-ascii?Q?3f+qocsf9o0MxWq02DvyQLHNpkEsck/B1qgqqfAG5/ejftPf507CVp8rQx/7?=
 =?us-ascii?Q?WNz50rrrovvQP99bAAEaqBjHls5Nl3ArlcwvBiXBCjCRpH1Ynp+pebImjUCZ?=
 =?us-ascii?Q?el1eCzVOSvqMAwTMHO1SD/sBEVlqs7vVcmp4JImH4GcbSblZryWcl4TAMat0?=
 =?us-ascii?Q?mpP7RgNUSPsfUbh9puDcJkbBaFgLU/KDeRmp+xm4Ac1w2KvmyZG+zjeOQPaJ?=
 =?us-ascii?Q?HoxRpTpwES/YJHXal0C+myR+fiTC+n639WToF2afj/IkvnuOZL21cRP4L+O6?=
 =?us-ascii?Q?roqru6NG4bw3YmmDZRUYUICNbsns3IaUtnNJmmzwH9cfsyW/1W0HrSvtPGk3?=
 =?us-ascii?Q?c7mbLHnDLyn1Mta05+wHgXP3kSHBrD/zYosC6kAQya08oNMqTMD9GF+sHxhL?=
 =?us-ascii?Q?KlmEc9DWt+wihSHPUXQPiJu1aW9Bo5aQeHkvnDROkjF4OhT2x+texcO7jH68?=
 =?us-ascii?Q?R9jpTZeg9Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81127696-b234-444b-3bf5-08de7e919590
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:41:27.8694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGaDv3JAC6ueQQHN0OBpKfUrRPoPYwEYswB70EpGtUSzwQz9/jw3D7bu26HrL4cz2dkmayws6MfgsylNIVQ6yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11833

The transmitter and receiver implement separate timestamp counters and
bit counters. The bit counter increments at the end of each bit in a
frame whenever the transmitter or receiver is enabled. The bit counter
can be reset by software. The timestamp counter increments on the bus
interface clock whenever it is enabled. The current value of the
timestamp counter is latched whenever the bit counter increments.
Reading the bit counter register will cause the latched timestamp
value to be saved in the bit counter timestamp register. The timestamp
counter can be reset by software, this also resets the latched timestamp
value and the bit counter timestamp register.

The timestamp counter and bit counter can be used by software to track
the progress of the transmitter and receiver. It can also be used to
calculate the relative frequency of the bit clock against the bus
interface clock.

As there are three regmap handlers defined in this driver, explicitly
call the snd_soc_component_init_regmap() to init regmap handler for the
component.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 64 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_xcvr.h | 18 +++++++++++
 2 files changed, 82 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index a268fb81a2f8..de25d9e667ee 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -62,6 +62,58 @@ struct fsl_xcvr {
 	u32 spdif_constr_rates_list[SPDIF_NUM_RATES];
 };
 
+static const char * const inc_mode[] = {
+	"On enabled and bitcount increment", "On enabled"
+};
+
+static SOC_ENUM_SINGLE_DECL(transmit_tstmp_enum,
+			    FSL_XCVR_TX_DPTH_CNTR_CTRL,
+			    FSL_XCVR_TX_DPTH_CNTR_CTRL_TSINC_SHIFT, inc_mode);
+static SOC_ENUM_SINGLE_DECL(receive_tstmp_enum,
+			    FSL_XCVR_RX_DPTH_CNTR_CTRL,
+			    FSL_XCVR_RX_DPTH_CNTR_CTRL_TSINC_SHIFT, inc_mode);
+
+static const struct snd_kcontrol_new fsl_xcvr_timestamp_ctrls[] = {
+	FSL_ASOC_SINGLE_EXT("Transmit Timestamp Control Switch", FSL_XCVR_TX_DPTH_CNTR_CTRL,
+			    FSL_XCVR_TX_DPTH_CNTR_CTRL_TSEN_SHIFT, 1, 0,
+			    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
+	FSL_ASOC_ENUM_EXT("Transmit Timestamp Increment", transmit_tstmp_enum,
+			  fsl_asoc_get_enum_double, fsl_asoc_put_enum_double),
+	FSL_ASOC_SINGLE_EXT("Transmit Timestamp Reset Switch", FSL_XCVR_TX_DPTH_CNTR_CTRL,
+			    FSL_XCVR_TX_DPTH_CNTR_CTRL_RTSC_SHIFT, 1, 0,
+			    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
+	FSL_ASOC_SINGLE_EXT("Transmit Bit Counter Reset Switch", FSL_XCVR_TX_DPTH_CNTR_CTRL,
+			    FSL_XCVR_TX_DPTH_CNTR_CTRL_RBC_SHIFT, 1, 0,
+			    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Transmit Timestamp Counter", FSL_XCVR_TX_DPTH_TSCR,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Transmit Bit Counter", FSL_XCVR_TX_DPTH_BCR,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Transmit Bit Count Timestamp", FSL_XCVR_TX_DPTH_BCTR,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Transmit Latched Timestamp Counter", FSL_XCVR_TX_DPTH_BCRR,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+	FSL_ASOC_SINGLE_EXT("Receive Timestamp Control Switch", FSL_XCVR_RX_DPTH_CNTR_CTRL,
+			    FSL_XCVR_RX_DPTH_CNTR_CTRL_TSEN_SHIFT, 1, 0,
+			    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
+	FSL_ASOC_ENUM_EXT("Receive Timestamp Increment", receive_tstmp_enum,
+			  fsl_asoc_get_enum_double, fsl_asoc_put_enum_double),
+	FSL_ASOC_SINGLE_EXT("Receive Timestamp Reset Switch", FSL_XCVR_RX_DPTH_CNTR_CTRL,
+			    FSL_XCVR_RX_DPTH_CNTR_CTRL_RTSC_SHIFT, 1, 0,
+			    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
+	FSL_ASOC_SINGLE_EXT("Receive Bit Counter Reset Switch", FSL_XCVR_RX_DPTH_CNTR_CTRL,
+			    FSL_XCVR_RX_DPTH_CNTR_CTRL_RBC_SHIFT, 1, 0,
+			    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Receive Timestamp Counter", FSL_XCVR_RX_DPTH_TSCR,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Receive Bit Counter", FSL_XCVR_RX_DPTH_BCR,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Receive Bit Count Timestamp", FSL_XCVR_RX_DPTH_BCTR,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Receive Latched Timestamp Counter", FSL_XCVR_RX_DPTH_BCRR,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+};
+
 static const struct fsl_xcvr_pll_conf {
 	u8 mfi;   /* min=0x18, max=0x38 */
 	u32 mfn;  /* signed int, 2's compl., min=0x3FFF0000, max=0x00010000 */
@@ -1070,8 +1122,20 @@ static struct snd_soc_dai_driver fsl_xcvr_dai = {
 	},
 };
 
+static int fsl_xcvr_component_probe(struct snd_soc_component *component)
+{
+	struct fsl_xcvr *xcvr = snd_soc_component_get_drvdata(component);
+
+	snd_soc_component_init_regmap(component, xcvr->regmap);
+
+	return 0;
+}
+
 static const struct snd_soc_component_driver fsl_xcvr_comp = {
 	.name			= "fsl-xcvr-dai",
+	.probe			= fsl_xcvr_component_probe,
+	.controls		= fsl_xcvr_timestamp_ctrls,
+	.num_controls		= ARRAY_SIZE(fsl_xcvr_timestamp_ctrls),
 	.legacy_dai_naming	= 1,
 };
 
diff --git a/sound/soc/fsl/fsl_xcvr.h b/sound/soc/fsl/fsl_xcvr.h
index dade3945cc0c..0cc7945b1d9f 100644
--- a/sound/soc/fsl/fsl_xcvr.h
+++ b/sound/soc/fsl/fsl_xcvr.h
@@ -233,6 +233,24 @@
 #define FSL_XCVR_TX_DPTH_CTRL_CLK_RATIO		BIT(29)
 #define FSL_XCVR_TX_DPTH_CTRL_TM_NO_PRE_BME	GENMASK(31, 30)
 
+#define FSL_XCVR_RX_DPTH_CNTR_CTRL_TSEN_SHIFT	0
+#define FSL_XCVR_RX_DPTH_CNTR_CTRL_TSEN		BIT(0)
+#define FSL_XCVR_RX_DPTH_CNTR_CTRL_TSINC_SHIFT	1
+#define FSL_XCVR_RX_DPTH_CNTR_CTRL_TSINC	BIT(1)
+#define FSL_XCVR_RX_DPTH_CNTR_CTRL_RBC_SHIFT	8
+#define FSL_XCVR_RX_DPTH_CNTR_CTRL_RBC		BIT(8)
+#define FSL_XCVR_RX_DPTH_CNTR_CTRL_RTSC_SHIFT	9
+#define FSL_XCVR_RX_DPTH_CNTR_CTRL_RTSC		BIT(9)
+
+#define FSL_XCVR_TX_DPTH_CNTR_CTRL_TSEN_SHIFT	0
+#define FSL_XCVR_TX_DPTH_CNTR_CTRL_TSEN		BIT(0)
+#define FSL_XCVR_TX_DPTH_CNTR_CTRL_TSINC_SHIFT	1
+#define FSL_XCVR_TX_DPTH_CNTR_CTRL_TSINC	BIT(1)
+#define FSL_XCVR_TX_DPTH_CNTR_CTRL_RBC_SHIFT	8
+#define FSL_XCVR_TX_DPTH_CNTR_CTRL_RBC		BIT(8)
+#define FSL_XCVR_TX_DPTH_CNTR_CTRL_RTSC_SHIFT	9
+#define FSL_XCVR_TX_DPTH_CNTR_CTRL_RTSC		BIT(9)
+
 #define FSL_XCVR_PHY_AI_CTRL_AI_RESETN		BIT(15)
 #define FSL_XCVR_PHY_AI_CTRL_AI_RWB		BIT(31)
 
-- 
2.34.1


