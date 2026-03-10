Return-Path: <linuxppc-dev+bounces-17959-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B06EEB104A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 10:41:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVVms0x40z3cF8;
	Tue, 10 Mar 2026 21:41:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773139309;
	cv=pass; b=gBfALvlIJlZYhDPFTjpv5vw48ZAc4lbndN7ACH8vvPSA9oQbr7cAlMgd8bMC3M3ila+tcqi33dHNszdHxFBXfotchcFVOVvPNC2eTgdqLcflRhPyM50I7JFfERRo/Ob0/tB+u/YcDV8mIh1kYWQN+/kpvn81iQ4SfQemf607Xsn1rdO7E7H4XZ2poAo20xBaPj7xRUduCjB7rgALcLRReFxJcBBkkfiAdDVrkay5p2nwTsFZmrn0DBYl7s4AwX3yXsjVclue1PlyVY+l6Q0hCU2UhqNmhlGLIl/IYsz+Dh08yz0P091KbGyAZxQGD52oGNXy/2Xjvm3N4+RAafzp6Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773139309; c=relaxed/relaxed;
	bh=cDlDabGl6nl3C5GaKNJ4DyQBhEmaCtae7mOJ3W/o3PY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c91t7ZEiAiMq5o65HYM5mapr+8UjUDuGR6p8fHEp9mh2aIG2soHK8Ah12l7+Cmp0FtKnrAPiOFAXAww2q/RwSn33uJ1OWhhLphfzExhB+eRgJDdzHDXZwyHd06TobAfZ2ftRyjPsxWQJ1/MHcs3fZfMPb+6zbw2HSJlnU4kQwKPlpq+ZI7P/Kd2ymCmQIzkGC02zAKtMAJKh8gNFLzHonkLy7+2i7CA4RCCWMCJ++PCw+AntUwTLPCyjakf77/EwSo41JkBjsn9i2YtTiyNoePOK1m/2i/hfDeSMZTtCt5OFTBPl0ugcU8ijAlQzcFmRAj5vxyIeP9y/HStaYRFO6w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EEGli6jV; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=EEGli6jV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVVmr1jZQz3cBP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 21:41:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsy+qwJQ9PgbyQ9ut71tig0hzryyvfobt44h49iVMd2ccYZvZ/KXekKl/r/mZ6KKSBeyRh5j4BU1I28uVRJdda/c/imDF30x4xrdJ/cxwParhDKFNOblrGpjUkdD3vB6PDaYDA3cg3v6hLhAH/k1YHoaXsHoNc0+JMeJXVX4LsNyZlXkWkBvMRUh68oakm7qKmuK2aBSVRF27/pys49A+eo47JtZbGVw0ZLl2FKZ3BvgNl77ACjrIqrcH2dySItvVizk5v+OAXxSPzEgIJMY+MlCaszHSNkEBKWXsbf3QIfZwIoakSHBAfuFgkIlCb5z43G7bmZKguNfwGeVgt2UvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDlDabGl6nl3C5GaKNJ4DyQBhEmaCtae7mOJ3W/o3PY=;
 b=x+C8j6xEqv6a0LQZY6kl+IfSsvWHHC61hfW+nutU/ui4wHzbaPSsBpnbujw3KuASCZfUjQ5yrEDbYAw6+GREH1mlD1KjdiseYavVJZ4L+hVgV0Cv9f9dq20nLHhVsQRbjWHOjovNR6h+DIeKxd9Xd80NCi+ZyLhHqdU4uZ3cgJ9kyYKul/bM0YGE+AFowbGjs2YBX0CqtHYPsGx90vm31mJHI8pjxyDGF6wf10peajqNrTdAI7NWo0RRDn8Xn4L0KemJm1BtVn5cBJ3z/+OTRyf6C0pEOdURN0yf759+XhVNFVe1BagPeJEu5rz1nM+CfPzQTdQcB4iWILaiRyotVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDlDabGl6nl3C5GaKNJ4DyQBhEmaCtae7mOJ3W/o3PY=;
 b=EEGli6jVmvhGb8pbL+VDwZ8bY+/vqh552V/YILM4OnXfVkQL0EWnkjAsqy9zXmTcMw7ha5fvl3aMoXiTokmjBQo9RTx5SF//fL+wX0fzso9SH3uytBKJL7LGqR4iQnk7KTenO+xzSbxtc5NHjAH3w2vpjus5otI7g6W/o5bjhb527muI09tz5eboCR2P3YJZ91jy+V4eMlJOYQNS8YZiFZ1j+f1fpc9zAUOPdgbKZ7bf9+BVb2YljlKCYHyi3BP62GrA7t7HhEMFCuRKjLCo7ltkaMPjKTl2Xl8e1JCbEaDfkSUj0g5PEag4e7IANzr/U5EpR/N8kj3/v5frb2K7kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by GV2PR04MB11833.eurprd04.prod.outlook.com (2603:10a6:150:2fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 10:41:24 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%3]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 10:41:24 +0000
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
Subject: [PATCH v6 2/3] ASoC: fsl_sai: add bitcount and timestamp controls
Date: Tue, 10 Mar 2026 18:42:34 +0800
Message-Id: <20260310104235.1234569-3-shengjiu.wang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3fa5ea65-abdf-4b66-9898-08de7e919354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	wtzUx+ekpkG6xFkuXIxVMJCVGwLa36My1YTHMgjjtuugCkaLl3iC1gj70Bv/93IbdOlE9OWCqMKnNbRI8lcSMn6GQwD220Uw79am4TCizPrKk2AXZ5Lkcc4t+OD9xpwHJNGFHwOZ/S/zL1p1ZITJXE8THR2Ibu4oRxAchd/r+7p8vxpgXasVQpUzoLYMF5swpWvoq1zTDpjeflwRuXKQPGtt2lNII2PHUFlUVZrkAXDYJTsd98QPGS7y1W4cz8PCuzCJG1tDUfjWtFBZ8vWPE2yL6N5s6GVMjUWGtVrqtZgP5+tLJathmZV7f9dscZFkrtDkPqs3oRCS4aJ07kcTLezFvROLw0e4Z1ui3SEWv3/m5wZYyTjbjPH9m4QFE9mPDN5YeoA6B0Uj/zkzuPI8DQpKWkkxB4MSNkM5CzAs/n2JKwEp8FA8C0XoaeCU0bPKzLs8b1BM8TvUwlpEwfXK4LK8dTV9nIvioSxht47iroGNySrN7pzMhiKwbYMLsR1a6Foat2oeQN+p0JxWAkB3iM15GEvR82iPctgU+yP9zPx1Nzb9JFojnce3Re2/MjLcYeaKxCFd8dfi3+hm5AzBjCUfqnSRPfkgCLr6ONrgYUEFt4SVtOWlzKwOsVEFdMV3LZEor9XfGz6SJsSNOUwffkLTHQQs8L2v8unjQT88jakvExzLF3OMueLqyu742OZuAz2vXk83iNbdIGJOf2/+kXDuhvstGVRPqOpaYq1fqt2RlPBASmMGkpdviBx+y66GzAJnoSxIKThItBqOnseVsaaflmGU1ODC0RzKP5oosexy1fffcs+nwqlbBzcc24PI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?956lanA41kpjR/QDe7/KHEHCFi0TjS/gPO7ArFSJ5QTM8y88PLBISeWqW5rd?=
 =?us-ascii?Q?KEkfv1YSSLMd0ryNL0baK6vqO9Uj+S20OrM9M5/LOxkso1TQnG8E5K7ncuSP?=
 =?us-ascii?Q?Pt5MBWmUTKUvJXOgTE8dYSlhO9tE1SpOTI0aHm2hQSN1L59SLKptcFZJtO3b?=
 =?us-ascii?Q?VNwTd/cRjqHI0K44adZuDJ5f1NC9lK4mLj/j5gaEEwMpE2yHE5I7r1ya2S+M?=
 =?us-ascii?Q?i++q77P7xH4kiJNCQDg0AbeNtq18ajxQDnkgocWsg4o4tQcbn0DpAOU3bhvD?=
 =?us-ascii?Q?WgG7SJxQDvZPkTjfsqaOo4KRBPpJRLXoXQV8Boy4E377X2P2fthM7g7tskV8?=
 =?us-ascii?Q?mczm1IleNL3LdcLG/d6cQ9+yHaGgfcbKRLycm+Ym9CHMP+xqxY0rP0s2O9ag?=
 =?us-ascii?Q?H2IAPyUOOb6qwLT1mtn3meIf484d4FDcxD/bxNJn9OHSCXvZCjrdVSr9fAhZ?=
 =?us-ascii?Q?ew5omWFNwSKQU6/Zdz5Rac3AS7V7Q8DDr6x9IB+Bu0HMbL4Jq48dhrAQ0eYF?=
 =?us-ascii?Q?+FEF3iWPbE15NadZIPvtMmydWpPI2eJtB7qWMqS1DPXdPDrR4CCy0tAnFgoP?=
 =?us-ascii?Q?/EzpsvC/UWMHuFWvPiSK4T0Qfyzk52JGW+M7Qwl1S9qvoIXuH06EbHEYSOS4?=
 =?us-ascii?Q?pfrrfiPkYG32IUkDiHlK835DC7rTM0f3m9XJfsjLNcVDc4xhryy0CVIOe7lq?=
 =?us-ascii?Q?mNMVE6NPVLbHBSk7DnkRDwPsSU6BBUNJ69EKMWm6K0XbH4lTs/U4ERS6Au5x?=
 =?us-ascii?Q?j+Q5su9aHfxYe2bdoGH1GqQ+F7UAZGijplJ6CxKTkjX5wqj3RYc1XlSpXfP2?=
 =?us-ascii?Q?zy922A+8p67AKCplSQYbw5G9oTzWB/BRo2liYzspkBb9oKhfKeYswaJHv/IX?=
 =?us-ascii?Q?tb77tQKFfkFbRBPtoLhdKLtsg9bBggv86bleHXbIkHvRr2Tfb0v/F3MHOoWr?=
 =?us-ascii?Q?C/LYAMnUisT83ZDhdCzBqEmw/PX6VPx1cDZdqdOf/SwcOGZvQHZ6QRloQEE2?=
 =?us-ascii?Q?tmMuFapIzodGCkrNoefDA9BmqSNc1v7Mz0e6Gnda7DJ6a6Zd9y42/BMFNm1Z?=
 =?us-ascii?Q?v6iwLTrd8q7fj/8q2Gj3DlOfVIgGgIh9BpqS26bCTPdOpmgJ3MwhBqlL7rPz?=
 =?us-ascii?Q?EtpbGZ6TNakpwDHO9NCjc8kuD0liBZHIfMx5zlDXOpP5k8ZBgR+TCnABHRom?=
 =?us-ascii?Q?EHZohaiiNPF29gx4092k4/RsBwQsTJqa1pxbQa/tfxh7yDYm1GqeMWmoQyug?=
 =?us-ascii?Q?Hy66I/g1TmuuC/lhOr4BIYyT4eLfJ4xbNirKUh5LTpmb5vhutSORb2V6KUDp?=
 =?us-ascii?Q?fHaPoOZCrBJ0JUggP1ME9sWpS+l4Qh9Bn2f8EdScVBadCrb51EK21ynNuQb4?=
 =?us-ascii?Q?t/69yjPUy+ltFF1wtbSocsuSHTYMgzEBoBD1IuTDD3P50s9zV9kNtNSDRhao?=
 =?us-ascii?Q?IViT9iabT3feBAKbt2AuxwcHrHwzzubKMv71Di+LDIcYQyMWxG5klo2eWe28?=
 =?us-ascii?Q?xAusTl1432akb5Pl2rWklNyuxKdb+Q1vR6bbDEylYm1tkvrHYHEhpv06npi+?=
 =?us-ascii?Q?wVVSF5k5UF/lHFHW1apS+sNCzHyXv4N6OmzZ1Ttmx/Sn8bEOD5eeHISRgTLH?=
 =?us-ascii?Q?o5UJZ/vwTsboD+uh7go51IVFOZDr7h8W6Fw8OFzQZKviMdFQzEt9XLEk+x0B?=
 =?us-ascii?Q?lTGUCShvQ/cg2KY42Xv98CTMmSKnfHf4TY1F1Ah67twIQI3AIm/aLKT0WCF3?=
 =?us-ascii?Q?2swOvIc1aA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa5ea65-abdf-4b66-9898-08de7e919354
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:41:24.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTPbsnAOe/ezEeoVo9ja0ZGkiCpZRXanX/0ef33486KHrHu0bD5hruX9kQb/uOQshmARTODsIaHJCV0O67ohFA==
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

These bitcount and timestamp registers are volatile, and supported when
the module has timestamp features.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 66 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_sai.h |  4 +++
 2 files changed, 70 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 148e09e58dfa..bd336d2e4cb3 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -41,6 +41,52 @@ static const struct snd_pcm_hw_constraint_list fsl_sai_rate_constraints = {
 	.list = fsl_sai_rates,
 };
 
+static const char * const inc_mode[] = {
+	"On enabled and bitcount increment", "On enabled"
+};
+
+static SOC_ENUM_SINGLE_DECL(transmit_tstmp_enum,
+			    FSL_SAI_TTCTL, FSL_SAI_xTCTL_TSINC_SHIFT, inc_mode);
+static SOC_ENUM_SINGLE_DECL(receive_tstmp_enum,
+			    FSL_SAI_RTCTL, FSL_SAI_xTCTL_TSINC_SHIFT, inc_mode);
+
+static const struct snd_kcontrol_new fsl_sai_timestamp_ctrls[] = {
+	FSL_ASOC_SINGLE_EXT("Transmit Timestamp Control Switch", FSL_SAI_TTCTL,
+			    FSL_SAI_xTCTL_TSEN_SHIFT, 1, 0,
+			    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
+	FSL_ASOC_ENUM_EXT("Transmit Timestamp Increment", transmit_tstmp_enum,
+			  fsl_asoc_get_enum_double, fsl_asoc_put_enum_double),
+	FSL_ASOC_SINGLE_EXT("Transmit Timestamp Reset Switch", FSL_SAI_TTCTL,
+			    FSL_SAI_xTCTL_RTSC_SHIFT, 1, 0,
+			    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
+	FSL_ASOC_SINGLE_EXT("Transmit Bit Counter Reset Switch", FSL_SAI_TTCTL,
+			    FSL_SAI_xTCTL_RBC_SHIFT, 1, 0,
+			    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Transmit Timestamp Counter", FSL_SAI_TTCTN,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Transmit Bit Counter", FSL_SAI_TBCTN,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Transmit Latched Timestamp Counter", FSL_SAI_TTCAP,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+	FSL_ASOC_SINGLE_EXT("Receive Timestamp Control Switch", FSL_SAI_RTCTL,
+			    FSL_SAI_xTCTL_TSEN_SHIFT, 1, 0,
+			    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
+	FSL_ASOC_ENUM_EXT("Receive Timestamp Increment", receive_tstmp_enum,
+			  fsl_asoc_get_enum_double, fsl_asoc_put_enum_double),
+	FSL_ASOC_SINGLE_EXT("Receive Timestamp Reset Switch", FSL_SAI_RTCTL,
+			    FSL_SAI_xTCTL_RTSC_SHIFT, 1, 0,
+			    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
+	FSL_ASOC_SINGLE_EXT("Receive Bit Counter Reset Switch", FSL_SAI_RTCTL,
+			    FSL_SAI_xTCTL_RBC_SHIFT, 1, 0,
+			    fsl_asoc_get_volsw, fsl_asoc_put_volsw),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Receive Timestamp Counter", FSL_SAI_RTCTN,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Receive Bit Counter", FSL_SAI_RBCTN,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+	FSL_ASOC_SINGLE_XR_SX_EXT_RO("Receive Latched Timestamp Counter", FSL_SAI_RTCAP,
+				     1, 32, 0, 0xffffffff, 0, fsl_asoc_get_xr_sx),
+};
+
 /**
  * fsl_sai_dir_is_synced - Check if stream is synced by the opposite stream
  *
@@ -1010,6 +1056,17 @@ static int fsl_sai_dai_resume(struct snd_soc_component *component)
 	return 0;
 }
 
+static int fsl_sai_component_probe(struct snd_soc_component *component)
+{
+	struct fsl_sai *sai = snd_soc_component_get_drvdata(component);
+
+	if (sai->verid.feature & FSL_SAI_VERID_TSTMP_EN)
+		snd_soc_add_component_controls(component, fsl_sai_timestamp_ctrls,
+					       ARRAY_SIZE(fsl_sai_timestamp_ctrls));
+
+	return 0;
+}
+
 static struct snd_soc_dai_driver fsl_sai_dai_template[] = {
 	{
 		.name = "sai-tx-rx",
@@ -1063,6 +1120,7 @@ static struct snd_soc_dai_driver fsl_sai_dai_template[] = {
 
 static const struct snd_soc_component_driver fsl_component = {
 	.name			= "fsl-sai",
+	.probe			= fsl_sai_component_probe,
 	.resume			= fsl_sai_dai_resume,
 	.legacy_dai_naming	= 1,
 };
@@ -1211,6 +1269,14 @@ static bool fsl_sai_volatile_reg(struct device *dev, unsigned int reg)
 	case FSL_SAI_RDR5:
 	case FSL_SAI_RDR6:
 	case FSL_SAI_RDR7:
+	case FSL_SAI_TTCTN:
+	case FSL_SAI_RTCTN:
+	case FSL_SAI_TTCTL:
+	case FSL_SAI_TBCTN:
+	case FSL_SAI_TTCAP:
+	case FSL_SAI_RTCTL:
+	case FSL_SAI_RBCTN:
+	case FSL_SAI_RTCAP:
 		return true;
 	default:
 		return false;
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 7605cbaca3d8..af967833b6ed 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -196,9 +196,13 @@
 #define FSL_SAI_MDIV_MASK	    0xFFFFF
 
 /* SAI timestamp and bitcounter */
+#define FSL_SAI_xTCTL_TSEN_SHIFT   0
 #define FSL_SAI_xTCTL_TSEN         BIT(0)
+#define FSL_SAI_xTCTL_TSINC_SHIFT  1
 #define FSL_SAI_xTCTL_TSINC        BIT(1)
+#define FSL_SAI_xTCTL_RTSC_SHIFT   8
 #define FSL_SAI_xTCTL_RTSC         BIT(8)
+#define FSL_SAI_xTCTL_RBC_SHIFT    9
 #define FSL_SAI_xTCTL_RBC          BIT(9)
 
 /* SAI type */
-- 
2.34.1


