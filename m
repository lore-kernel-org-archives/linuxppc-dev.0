Return-Path: <linuxppc-dev+bounces-27678-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E751BC982D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:26:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmPL42YWLz30Sx;
	Fri, 18 Sep 2026 17:25:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789716348;
	cv=pass; b=HQDOIV5KY/xdiNUzzkp7+O1f7hyjUJKDBzQvkJr9gFmyYK+yPaQcpk2HUK7hSfBDf8ywz7KKnu3mwZDHYcc8yH0ArM52SAgNW3Mi9Z8JIVkGoeccFODIHN4/ELD5fyXnlFLb3dKEoYrOEoJYzzfErPvy7i++htePTGbKN4KlI+tqm/IXe4RBMFebvZ/UbKR1ujR50/C2NGhnzlBX94UrUUnjOkTSYpF8nAM+pjlxqMU1RS+U9YMIWeiCtX2F+5CqcQb1rdjp48G72B564+YD+7mLcyf9+Zl6LzmaX+1IAX1gL/q1V1zMvuCAOVDSlf1JG8AH6JfbQ8TX3PE3pwxEmA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789716348; c=relaxed/relaxed;
	bh=yboju9lrXkc5PpVJQeHh0S/yHPvfDMh9Sh8fLmDzZEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6xPDSNdCQH091LvvBwfeGbwNmaKhYDfhBJiZcJ5nhLskv5oebE6RvSo+31dkaHHSd+NBUoSX8bZbFhdHvVZBVhJya41G6HLpE9qn65copkel4EHw+uB0TEof1ze+fohZGLj7Nj3UlAsOetsyeTjRjLPcGicM8qaut5UGJdxA6n7FMcwWj1W5nrnR1EgZOBuYMnrGEfd/bT65XkcnPWaBjWMCe+6Oq55sLwvGen5l9q+APw7I49SFC2p74qaZjCguc67Xd5W4eiFb5MKuo1yaGNhgI5JGLZdCBkomTGIMo7uVb1dz0JuDevGP5U2jjzMXhlzwqz6rPKf4oc/KP8YSg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SqYQ6569; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SqYQ6569;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmPL234Swz3bcB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:25:46 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jMSDTOtWWAaBmM/5Agd4vGStfqeuN+evQkoNErlIMvAydqcelntpJX5uOqpTOrzsf14hvFxxsTUFyS3nq0i5ZWOqQC79NZwgAtrlk3O9ZBEH0E+/lYIM5REQqkFN9u5H+nq33HNaZ1sDb6HA8FgBjX1ixFI4Z4stSWE9rhy0mQm7SZG3e0RL+/HwwTueHp2q46MUK+dZjpNl5/84+ZyY7bPDa6qZxAtuoAJpLS3H7uLlje9cj0rB6yy4ZQ+GApvLHP+iksHHKlqG+sq3jMSVfsGFr+89yd8jPUjeEL1aRtDGFIr3tqEIj/6S7jD8hWg/TQIXsh2N1V8jxdgnzzvDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yboju9lrXkc5PpVJQeHh0S/yHPvfDMh9Sh8fLmDzZEk=;
 b=JnX/CLZ9hBFYOO4lhF0J3JS+jgaWU64JZwhpe8MzvxOtQmBkjaBy3dJQVItLTcVeHcqPELz4Js+fQL/n1Tk/zPEqKbMKVjRxpwKdTbaHd/bFSvUeY8WRvCL1/83mQcSN9cl6fUL+IVt53Oq193JBqM5sTUzKvD2ngi9BmnQ411u6u6l0Xds57INANKcagMpp+eB8NAtKwnp7bhJK404LLBROcUJVaVpM8tqjMtt0mr2EPFxQX+E785fomcyypFy7MNnYaKSyldlAHU7RSMlvLC/2xWQ0dyoQhVF3gtdWal/70BWi7GQHH4DlN+dfRH3cvYOVa7B4OXgiuXbuft1cQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yboju9lrXkc5PpVJQeHh0S/yHPvfDMh9Sh8fLmDzZEk=;
 b=SqYQ65690k9H5fUUv8N7xBPxtPcUoYqZTi+PIpRHLscWtaVq9Xvsi52rbwceEvabq8KtGQsLxXB7dXnaz4kpTU6d2dZ3ZJhOEIP31uze3XB8Evq30fne/dg8ytgSpgeRb9p61RXFkB13EOdYwcqnPPAnYSBw6x+NQj0gdX1LdiA4BwWvpu044JNj6s++Nm0pHNAmq69U2Z/K+1XCh4WMQ70LQUPn+zzy8xsey74abE2pBk0wB25O7SCN1fKwPQr7InW98syz4B+96y8GVDVew1tfxQAiNTp02Y80QpoVXAY5fjGbgk/G31FMakeW+HpTmtPQrNUUzmnbdo3l+Wmgug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 07:25:28 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:25:28 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	linusw@kernel.org,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 7/8] net: dsa: netc: add PTP two-step timestamping support
Date: Fri, 18 Sep 2026 15:28:51 +0800
Message-Id: <20260918072852.501420-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918072852.501420-1-wei.fang@oss.nxp.com>
References: <20260918072852.501420-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0156.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: a32e7c45-e4b8-46dd-8cf1-08df1556036a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	6uZy5P+dBjxhviLaEun2FJ0jTlh2HOUzJgj3UA6YJ2jV8zyJZNjkvS6BL2745cS6vlIh9uZq36540UuV7NP/z1BlWbU6rU6kbHdInH8S0wkMJyTQtfq8fdlMQu8kbVEphLlPmkn3mzfGAa2/AjSYk45594H9gnxf/1RaoeHve0f8L2bTIxqcxZpXLYx/D+FFkkhfvjomNvXaGvzb7Wwaf3aE/8DfsBqjJsZtN9LoDYsqzh8IFPpyhl0U8E5pTnBgqrsDrGCJeTp7bM12j0mmvQeFno3Ly7u3PFWNnrWt2CUi/6N74p7WGF1RZVsxcnocHl9N8qsPmLUEnAgqnlBWQqzcZSvLyHn3ely/Ki4YNUZ08dZtsiq2YKPd6d1mRSwQfTEo94Qv5zubvp0PKuDUxSUc1JDZTmw3L2Nx7eDRnenqXrwhMjtPDY3Kyp7LtCaBu4M3WSkMhL+79TS2FkTq6jmC2pHtJJus89QpJOCIzt6tSIhUuRbfi30Q10lHBgN2aRbljYl3P2v/F51QNyxx5BuiVH+RlHbNTm3cPdJClEOTyNuzF7pfPIUhdlFHSHkwtBGBw4axKqJWwj+LijskVZGx7GWk6dZVA23o+WYq8Xm5e/C7xiFSRFGlHKx+vuBzPXpP5K7yvud6WJNB7aXq/1SLmOmzs2f3DU8L2Dw48hSeXrhhNZQhzLOcQ1AmHwwe/3ecevkR07he3uTwVo0W3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0fS/hlyImW1fd/aIKmg4akAvpOgxfsI3mCa3yBOD/U3/CqhRLdd8vW3/acI6?=
 =?us-ascii?Q?QrLMW+bltuICJZedl3tDYFEBByK+vxYHo8oQuSjUJoQXfLLMD7rAYzbNasBL?=
 =?us-ascii?Q?tCOG3ih+73r9XZzD4Z+Z4/G2mzx9O+hOqLGEfYeGdVNu5aG/EkmioXbZ6P4Z?=
 =?us-ascii?Q?oSBO37RmRgFffGgHYNh8gsTmQcLP3mVo0GmvBMYM5cKdm5ihOkgxQxhomBl7?=
 =?us-ascii?Q?U8TFJaZn3r/nZWw1ABELK5L/e8OuCcTvVLEpnd8Lyh168kXNwFM/EEZTWh+U?=
 =?us-ascii?Q?3WzzjNANixMVat0n99Yf0phNoiFDuUhgJt3Ui3MVUG8i613J90XeeOHP5g+W?=
 =?us-ascii?Q?6rasso3DW2OrdRBHFEewcyiu/oE/BquutiQ+cyIZXTZ03DtVcLkCN819n7qX?=
 =?us-ascii?Q?yb/toroeOLBxal6TWbD4bWEU75kVDnxP5GPoDgLdljdDPSDZe+T3VBJujMf2?=
 =?us-ascii?Q?dCsurlb9HxzSNLnisDpU0YDLpmbpXffuuRTivWMfnSzrq3sokPd43icrnHpb?=
 =?us-ascii?Q?mu619kpam4AprkqxZYWc+S5wsq4fZKxkfvsQae8IMeO06C6HfUppydN5LXOX?=
 =?us-ascii?Q?/eibjeECkkqbT0qn7VquLaIcJ2+fbWDbz3r5lwNYN5Mlhm9RalHcxTIRCHYb?=
 =?us-ascii?Q?6fTpSQoM884+O9N2HtJoMVFtstz1TV3FCW4HZ4QhpliwGKKGfKWljtRLnV+U?=
 =?us-ascii?Q?SxrHTgE4gMkunMHNjv2sfH3eKEwOLFckGUtUZgnrtJGPAPNpG23bfdN1ae9E?=
 =?us-ascii?Q?LMgwLWTcF+782c+ZNrzv83zZfqnwwVLaJIL7146KfOOoHfDIl6ohHCtXeIvL?=
 =?us-ascii?Q?arUlzXk1G9oA+111qv2HP1di8jqgBM/UoizRN12uaWQjRy9UW1l7C7DlPhng?=
 =?us-ascii?Q?3SP3Aa4m3ZoXRwoLjEcfeb/la+7LFNbkJQL33g4X0dp6Y7yPqHOZ+rQ/w8Fm?=
 =?us-ascii?Q?ByJ4t5dOjOZzRC82jCCdw/iczYwgyS333i1CU74vN/iLPKhh8ZVFILLhUWKP?=
 =?us-ascii?Q?DLBBmTYr2xfHRfvF+2WEFKSKISU574EH8eeQQ06vLZGY0bpaXn7d/z/Kc37B?=
 =?us-ascii?Q?XjOMCB/eEgASKTEHLWXvbh4x6IBCzw5SQjg0FhU2ztMh6+HgnD3paxv4G0QY?=
 =?us-ascii?Q?7DmCmrGZ7ltSmuQjctmN+xvtlQi5LR5HH3Vy7lbDKzvlZ4Zte6HJZGRYhY3P?=
 =?us-ascii?Q?ti60i0d8WDtLIFER0LlTedDDgTi+hfA7OklcE2G9Qpu4XCFs68yjjsJSeqmO?=
 =?us-ascii?Q?78K2J3UJUSfMGt5SiX1o3NmgELI/VS/+7k4fNhb1AdlQ8lekhyJgqL0/lKTS?=
 =?us-ascii?Q?Icat22m+8dCHx//Yk/Sxqi1YXXrNvWRQJ/GnAP3OT6U2ClTRgxi3ML0TMcHN?=
 =?us-ascii?Q?lF6x2+xpLZpDZAMJyUO+LCvUzkDdCSMYssescYQL/I2XcRsrs49iMLvYsjy7?=
 =?us-ascii?Q?nN9BnkJWm4ZxpwenfCs/5tOiOUdEIxEku9wlxec11HZK3o+J9NLHAFyl3ENO?=
 =?us-ascii?Q?YhQ/7Hd3YiGUsDDoDH/gs0U/iTWVSd9wrt+EXeFsar1sODUMFiaiwKe6BRyN?=
 =?us-ascii?Q?wDoqVY5F59jXFQRrLmGzw6Tx5qKPx6gGgGaqSqpzOJDuKFUCcvCg9wQOFirt?=
 =?us-ascii?Q?zkVvlrX6IZJBKXgavMvjZ7qNWQ8AOVQi2TMkwTo3GOu6NaMEHWDiCy/+o86z?=
 =?us-ascii?Q?LGUL/txq7Izo9N2fDiDVSo6cPJtximM+W384sOH9Evl798jNhpbSKNGiJSnz?=
 =?us-ascii?Q?Jn9mmcqP0IW1QImTAY12++E018Yve3t65UuG4BR3rlUgBboB7040?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32e7c45-e4b8-46dd-8cf1-08df1556036a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:25:28.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0G5qJbmUiRtEXK+zs2V1fyjJO3wtu3E1Xr/xBhl6D7Cee3NeRVdLR1y968WQI/2DnIw2EdTK/CeA06e6qMnk4R8MlD7swQDHbjgdDlAGyK2cw3YGbpbN4bNpocIzPH8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541

From: Wei Fang <wei.fang@nxp.com>

Add two-step TX timestamping and RX timestamping for the NETC switch.

For RX, install ingress port filter table (IPFT) rules that redirect
PTP frames to the CPU port, covering L2, L4 over IPv4 and L4 over IPv6
according to the hwtstamp rx_filter. The hardware inserts a To_Host
subtype 1 tag carrying the ingress timestamp, which the tagger extracts
into the skb control buffer for netc_port_rxtstamp() to report.

For two-step TX, clone the skb, assign a per-port timestamp request ID,
and queue the clone. netc_xmit() carries the same ID in the To_Port
subtype 2 tag of the transmitted frame. The hardware then returns a
To_Host subtype 2 response frame echoing that ID and the transmit
timestamp. The tagger dispatches both to the driver through the
twostep_tstamp_handler callback in netc_tagger_data, which matches the
ID to the queued clone and completes it via skb_complete_tx_timestamp().
Non-PTP frames keep using the To_Port subtype 0 tag on the fast path.

Manage request IDs per port: each transmit takes the first ID not in
flight, and an ID is freed once its clone leaves the queue. A per-port
delayed work drops any clone left unmatched for 5 seconds, far beyond
the hardware's normal response latency.

The response frame carries no payload and is only 26 bytes long. As
eth_type_trans() advances skb->data past the DMAC, SMAC and TPID, the
tag starts at (skb->data - 2), so the pskb_may_pull() check must use
(NETC_TAG_MAX_LEN - 2) to avoid dropping the response frame.

Add the To_Port subtype 2 and To_Host subtype 1/2 tag structures, select
the TX tag from ptp_flag in netc_xmit(), and add netc_connect()/
netc_disconnect() to manage the per-switch netc_tagger_data. Grab the
PTP timer's pci_dev in netc_setup() so get_ts_info() can report its PHC
index, and release it on teardown and error paths.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Kconfig         |   1 +
 drivers/net/dsa/netc/Makefile        |   3 +-
 drivers/net/dsa/netc/netc_main.c     |  71 +++-
 drivers/net/dsa/netc/netc_platform.c |   1 +
 drivers/net/dsa/netc/netc_ptp.c      | 492 +++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h   |  42 +++
 include/linux/dsa/tag_netc.h         |  21 ++
 net/dsa/tag_netc.c                   | 165 ++++++++-
 8 files changed, 781 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/dsa/netc/netc_ptp.c

diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
index 793f7691a24f..8770b65d0f62 100644
--- a/drivers/net/dsa/netc/Kconfig
+++ b/drivers/net/dsa/netc/Kconfig
@@ -4,6 +4,7 @@ config NET_DSA_NETC_SWITCH
 	depends on ARM64 || COMPILE_TEST
 	depends on NET_DSA && PCI
 	depends on NET_VENDOR_FREESCALE
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select NET_DSA_TAG_NETC
 	select FSL_ENETC_MDIO
 	select NXP_NTMP
diff --git a/drivers/net/dsa/netc/Makefile b/drivers/net/dsa/netc/Makefile
index f40b13c702e0..572b833ad80f 100644
--- a/drivers/net/dsa/netc/Makefile
+++ b/drivers/net/dsa/netc/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_NET_DSA_NETC_SWITCH) += nxp-netc-switch.o
-nxp-netc-switch-objs := netc_main.o netc_platform.o netc_ethtool.o
+nxp-netc-switch-objs := netc_main.o netc_platform.o netc_ethtool.o \
+			netc_ptp.o
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 336f5a4633e9..03200fc63a09 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -65,6 +65,20 @@ netc_get_tag_protocol(struct dsa_switch *ds, int port,
 	return DSA_TAG_PROTO_NETC;
 }
 
+static int netc_connect_tag_protocol(struct dsa_switch *ds,
+				     enum dsa_tag_protocol proto)
+{
+	struct netc_tagger_data *tagger_data;
+
+	if (proto != DSA_TAG_PROTO_NETC)
+		return -EPROTONOSUPPORT;
+
+	tagger_data = ds->tagger_data;
+	tagger_data->txtstamp_handler = netc_port_txtstamp_handler;
+
+	return 0;
+}
+
 static void netc_port_rmw(struct netc_port *np, u32 reg,
 			  u32 mask, u32 val)
 {
@@ -291,6 +305,15 @@ static int netc_init_all_ports(struct netc_switch *priv)
 				dev_err(dev, "Failed to create MDIO bus\n");
 				return err;
 			}
+
+			/* Only the user port needs to support PTP feature, so
+			 * PTP-related resources, such as tstamp_queue,
+			 * tstamp_lock, etc., are initialized only for the user
+			 * port.
+			 */
+			err = netc_port_ptp_init(np);
+			if (err)
+				return err;
 		}
 	}
 
@@ -880,6 +903,15 @@ static int netc_switch_bpt_default_config(struct netc_switch *priv)
 	return 0;
 }
 
+static struct pci_dev *netc_get_ptp_timer(struct netc_switch *priv)
+{
+	struct pci_bus *bus = priv->pdev->bus;
+	u32 devfn = priv->info->tmr_devfn;
+
+	return pci_get_domain_bus_and_slot(pci_domain_nr(bus),
+					   bus->number, devfn);
+}
+
 static int netc_setup(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -892,13 +924,23 @@ static int netc_setup(struct dsa_switch *ds)
 
 	netc_get_switch_capabilities(priv);
 
+	/* The PTP timer sits on the same PCI bus as the switch. PCI creates
+	 * every function's pci_dev during bus enumeration, before any driver
+	 * probes, so we can grab the timer's pci_dev here even if the timer
+	 * driver has not probed yet.
+	 */
+	priv->tmr_dev = netc_get_ptp_timer(priv);
+	if (!priv->tmr_dev)
+		dev_info(priv->dev,
+			 "PTP timer PCI device not found\n");
+
 	err = netc_init_all_ports(priv);
 	if (err)
-		return err;
+		goto put_ptp_timer;
 
 	err = netc_init_ntmp_user(priv);
 	if (err)
-		return err;
+		goto put_ptp_timer;
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
@@ -937,6 +979,8 @@ static int netc_setup(struct dsa_switch *ds)
 	mutex_destroy(&priv->fdbt_lock);
 	mutex_destroy(&priv->vft_lock);
 	netc_free_ntmp_user(priv);
+put_ptp_timer:
+	pci_dev_put(priv->tmr_dev);
 
 	return err;
 }
@@ -949,6 +993,21 @@ static void netc_destroy_all_lists(struct netc_switch *priv)
 	mutex_destroy(&priv->vft_lock);
 }
 
+static void netc_free_ports_resources(struct netc_switch *priv)
+{
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_available_port(dp, priv->ds) {
+		struct netc_port *np = priv->ports[dp->index];
+
+		if (!dsa_port_is_user(dp))
+			continue;
+
+		disable_delayed_work_sync(&np->tstamp_timeout_work);
+		netc_port_purge_tstamp_queue(np);
+	}
+}
+
 static void netc_teardown(struct dsa_switch *ds)
 {
 	struct netc_switch *priv = ds->priv;
@@ -956,6 +1015,8 @@ static void netc_teardown(struct dsa_switch *ds)
 	disable_delayed_work_sync(&priv->fdbt_ageing_work);
 	netc_destroy_all_lists(priv);
 	netc_free_ntmp_user(priv);
+	netc_free_ports_resources(priv);
+	pci_dev_put(priv->tmr_dev);
 }
 
 static bool netc_port_is_emdio_consumer(struct device_node *node)
@@ -2403,6 +2464,7 @@ static const struct phylink_mac_ops netc_phylink_mac_ops = {
 
 static const struct dsa_switch_ops netc_switch_ops = {
 	.get_tag_protocol		= netc_get_tag_protocol,
+	.connect_tag_protocol		= netc_connect_tag_protocol,
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
 	.phylink_get_caps		= netc_phylink_get_caps,
@@ -2431,6 +2493,11 @@ static const struct dsa_switch_ops netc_switch_ops = {
 	.get_sset_count			= netc_port_get_sset_count,
 	.get_strings			= netc_port_get_strings,
 	.get_ethtool_stats		= netc_port_get_ethtool_stats,
+	.get_ts_info			= netc_get_ts_info,
+	.port_hwtstamp_set		= netc_port_hwtstamp_set,
+	.port_hwtstamp_get		= netc_port_hwtstamp_get,
+	.port_rxtstamp			= netc_port_rxtstamp,
+	.port_txtstamp			= netc_port_txtstamp,
 };
 
 static int netc_switch_probe(struct pci_dev *pdev,
diff --git a/drivers/net/dsa/netc/netc_platform.c b/drivers/net/dsa/netc/netc_platform.c
index 34aeb6fceb3c..4fd0ce6770c3 100644
--- a/drivers/net/dsa/netc/netc_platform.c
+++ b/drivers/net/dsa/netc/netc_platform.c
@@ -50,6 +50,7 @@ static void imx94_switch_phylink_get_caps(int port,
 
 static const struct netc_switch_info imx94_info = {
 	.num_ports = 4,
+	.tmr_devfn = PCI_DEVFN(0, 1),
 	.phylink_get_caps = imx94_switch_phylink_get_caps,
 };
 
diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
new file mode 100644
index 000000000000..2e743443ca03
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_ptp.c
@@ -0,0 +1,492 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC switch driver
+ * Copyright 2025-2026 NXP
+ */
+
+#include <linux/ptp_classify.h>
+#include <linux/ptp_clock_kernel.h>
+
+#include "netc_switch.h"
+
+#define NETC_NUM_TS_REQ_ID		16
+#define NETC_TSTAMP_TIMEOUT		(5 * HZ)
+
+static void netc_port_tstamp_timeout_work(struct work_struct *work)
+{
+	struct netc_port *np = container_of(work, struct netc_port,
+					    tstamp_timeout_work.work);
+	struct sk_buff_head free_list;
+	struct sk_buff *skb, *skb_tmp;
+
+	__skb_queue_head_init(&free_list);
+
+	spin_lock_bh(&np->tstamp_lock);
+	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
+		if (time_before64(jiffies_64, NETC_SKB_CB(skb)->ptp_tx_time +
+				  NETC_TSTAMP_TIMEOUT))
+			continue;
+
+		dev_dbg_ratelimited(np->switch_priv->dev,
+				    "Port %d ts_req_id %u which seems lost\n",
+				    np->dp->index, NETC_SKB_CB(skb)->ts_req_id);
+
+		__skb_unlink(skb, &np->tstamp_queue);
+		__skb_queue_tail(&free_list, skb);
+	}
+
+	/* Reschedule if there are still pending clones that have not
+	 * timed out yet.
+	 */
+	if (!skb_queue_empty(&np->tstamp_queue))
+		schedule_delayed_work(&np->tstamp_timeout_work,
+				      NETC_TSTAMP_TIMEOUT);
+
+	spin_unlock_bh(&np->tstamp_lock);
+	__skb_queue_purge(&free_list);
+}
+
+static int netc_get_ts_req_id(struct netc_port *np)
+{
+	DECLARE_BITMAP(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
+	struct sk_buff *skb, *skb_tmp;
+	unsigned long ts_req_id;
+
+	bitmap_zero(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
+
+	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp)
+		__set_bit(NETC_SKB_CB(skb)->ts_req_id, ts_req_id_bitmap);
+
+	ts_req_id = find_first_zero_bit(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
+	if (ts_req_id == NETC_NUM_TS_REQ_ID) {
+		dev_dbg_ratelimited(np->switch_priv->dev,
+				    "Port %d has no available ts_req_id\n",
+				    np->dp->index);
+		return -ENOSPC;
+	}
+
+	return ts_req_id;
+}
+
+int netc_port_ptp_init(struct netc_port *np)
+{
+	/* Initialize to invalid entry IDs */
+	for (int i = 0; i < NETC_PTP_MAX; i++)
+		np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
+
+	spin_lock_init(&np->tstamp_lock);
+	__skb_queue_head_init(&np->tstamp_queue);
+	INIT_DELAYED_WORK(&np->tstamp_timeout_work,
+			  netc_port_tstamp_timeout_work);
+
+	return 0;
+}
+
+void netc_port_purge_tstamp_queue(struct netc_port *np)
+{
+	struct sk_buff_head free_list;
+
+	__skb_queue_head_init(&free_list);
+
+	spin_lock_bh(&np->tstamp_lock);
+	skb_queue_splice_init(&np->tstamp_queue, &free_list);
+	spin_unlock_bh(&np->tstamp_lock);
+
+	__skb_queue_purge(&free_list);
+}
+
+static int netc_get_phc_index(struct netc_switch *priv)
+{
+	if (!priv->tmr_dev)
+		return -1;
+
+	return ptp_clock_index_by_dev(&priv->tmr_dev->dev);
+}
+
+int netc_get_ts_info(struct dsa_switch *ds, int port,
+		     struct kernel_ethtool_ts_info *info)
+{
+	struct netc_switch *priv = ds->priv;
+
+	info->phc_index = netc_get_phc_index(priv);
+	if (info->phc_index < 0)
+		return 0;
+
+	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
+				 SOF_TIMESTAMPING_RX_HARDWARE |
+				 SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT);
+
+	return 0;
+}
+
+static int netc_port_del_ptp_filter(struct netc_port *np)
+{
+	struct netc_switch *priv = np->switch_priv;
+	int ret = 0;
+	int err;
+
+	for (int i = 0; i < NETC_PTP_MAX; i++) {
+		if (np->ptp_ipft_eid[i] == NTMP_NULL_ENTRY_ID)
+			continue;
+
+		/* No -ETIMEDOUT here: with the command BD ring enabled, the
+		 * hardware never times out on a command. Any remaining error
+		 * means the entry is still present in the table.
+		 */
+		err = ntmp_ipft_delete_entry(&priv->ntmp,
+					     np->ptp_ipft_eid[i]);
+		if (likely(!err)) {
+			np->ptp_ipft_eid[i] = NTMP_NULL_ENTRY_ID;
+			continue;
+		}
+
+		ret = err;
+		dev_err(priv->dev,
+			"Delete PTP entry 0x%x (type %d) on port %d failed\n",
+			np->ptp_ipft_eid[i], i, np->dp->index);
+	}
+
+	return ret;
+}
+
+static int netc_build_ptp_ipft_keye(struct ipft_keye_data *keye, int port,
+				    enum netc_ptp_type type)
+{
+	u16 src_port, frm_attr_flags;
+
+	keye->precedence = cpu_to_le16(NETC_IPFT_PTP_PRECEDENCE);
+	src_port = FIELD_PREP(IPFT_SRC_PORT, port);
+	src_port |= IPFT_SRC_PORT_MASK;
+	keye->src_port = cpu_to_le16(src_port);
+
+	switch (type) {
+	case NETC_PTP_L2:
+		keye->ethertype = htons(ETH_P_1588);
+		keye->ethertype_mask = htons(0xffff);
+		break;
+	case NETC_PTP_L4_IPV4_EVENT:
+	case NETC_PTP_L4_IPV4_GENERAL:
+	case NETC_PTP_L4_IPV6_EVENT:
+	case NETC_PTP_L4_IPV6_GENERAL:
+		frm_attr_flags = IPFT_FAF_IP_HDR | FIELD_PREP(IPFT_FAF_L4_CODE,
+				 IPFT_FAF_UDP_HDR);
+		if (type == NETC_PTP_L4_IPV6_EVENT ||
+		    type == NETC_PTP_L4_IPV6_GENERAL)
+			frm_attr_flags |= IPFT_FAF_IP_VER6;
+
+		keye->frm_attr_flags = cpu_to_le16(frm_attr_flags);
+
+		/* Set IP version bit in flags_mask to match IPv4 or IPv6
+		 * packets
+		 */
+		frm_attr_flags |= IPFT_FAF_IP_VER6;
+		keye->frm_attr_flags_mask = cpu_to_le16(frm_attr_flags);
+		keye->ip_protocol = IPPROTO_UDP;
+		keye->ip_protocol_mask = 0xff;
+
+		if (type == NETC_PTP_L4_IPV4_EVENT ||
+		    type == NETC_PTP_L4_IPV6_EVENT)
+			keye->l4_dst_port = htons(PTP_EV_PORT);
+		else
+			keye->l4_dst_port = htons(PTP_GEN_PORT);
+
+		keye->l4_dst_port_mask = htons(0xffff);
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+static int netc_port_add_ipft_ptp_entry(struct netc_port *np,
+					enum netc_ptp_type type)
+{
+	struct netc_switch *priv = np->switch_priv;
+	struct ipft_entry_data *entry;
+	struct ipft_keye_data *keye;
+	u32 cfg;
+	int err;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	keye = &entry->keye;
+	err = netc_build_ptp_ipft_keye(keye, np->dp->index, type);
+	if (err)
+		goto free_entry;
+
+	cfg = FIELD_PREP(IPFT_FLTFA, IPFT_FLTFA_REDIRECT);
+	cfg |= FIELD_PREP(IPFT_HR, NETC_HR_PTP_TRAP);
+	cfg |= IPFT_TIMECAPE | IPFT_RRT;
+	entry->cfge.cfg = cpu_to_le32(cfg);
+
+	err = ntmp_ipft_add_entry(&priv->ntmp, entry);
+	if (err)
+		goto free_entry;
+
+	np->ptp_ipft_eid[type] = entry->entry_id;
+
+free_entry:
+	kfree(entry);
+
+	return err;
+}
+
+static int netc_port_add_l2_ptp_filter(struct netc_port *np)
+{
+	return netc_port_add_ipft_ptp_entry(np, NETC_PTP_L2);
+}
+
+static int netc_port_add_l4_ptp_filter(struct netc_port *np)
+{
+	int err;
+
+	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV4_EVENT);
+	if (err)
+		return err;
+
+	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV4_GENERAL);
+	if (err)
+		goto del_ptp_filter;
+
+	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV6_EVENT);
+	if (err)
+		goto del_ptp_filter;
+
+	err = netc_port_add_ipft_ptp_entry(np, NETC_PTP_L4_IPV6_GENERAL);
+	if (err)
+		goto del_ptp_filter;
+
+	return 0;
+
+del_ptp_filter:
+	netc_port_del_ptp_filter(np);
+
+	return err;
+}
+
+static int netc_port_add_l2_l4_ptp_filter(struct netc_port *np)
+{
+	int err;
+
+	err = netc_port_add_l2_ptp_filter(np);
+	if (err)
+		return err;
+
+	err = netc_port_add_l4_ptp_filter(np);
+	if (err)
+		goto del_ptp_filter;
+
+	return 0;
+
+del_ptp_filter:
+	netc_port_del_ptp_filter(np);
+
+	return err;
+}
+
+static int netc_port_set_ptp_filter(struct netc_port *np, int rx_filter)
+{
+	int err;
+
+	err = netc_port_del_ptp_filter(np);
+	if (err)
+		return err;
+
+	np->ptp_rx_filter = HWTSTAMP_FILTER_NONE;
+
+	switch (rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+		err = netc_port_add_l2_ptp_filter(np);
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+		err = netc_port_add_l4_ptp_filter(np);
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+		err = netc_port_add_l2_l4_ptp_filter(np);
+		break;
+	default:
+		err = -ERANGE;
+	}
+
+	if (err)
+		return err;
+
+	np->ptp_rx_filter = rx_filter;
+
+	return 0;
+}
+
+int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_switch *priv = ds->priv;
+	int rx_filter, err;
+
+	if ((config->tx_type != HWTSTAMP_TX_OFF ||
+	     config->rx_filter != HWTSTAMP_FILTER_NONE) &&
+	    netc_get_phc_index(priv) < 0)
+		return -EOPNOTSUPP;
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_ON:
+	case HWTSTAMP_TX_OFF:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		rx_filter = HWTSTAMP_FILTER_NONE;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+		rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+		rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+		rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	err = netc_port_set_ptp_filter(np, rx_filter);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to set PTP filter");
+		return err;
+	}
+
+	WRITE_ONCE(np->ptp_tx_type, config->tx_type);
+	config->rx_filter = rx_filter;
+
+	return 0;
+}
+
+int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	config->tx_type = READ_ONCE(np->ptp_tx_type);
+	config->rx_filter = np->ptp_rx_filter;
+
+	return 0;
+}
+
+static void netc_port_prepare_twostep(struct netc_port *np,
+				      struct sk_buff *nskb)
+{
+	struct sk_buff *clone = skb_clone_sk(nskb);
+	int ts_req_id;
+
+	if (unlikely(!clone))
+		return;
+
+	spin_lock_bh(&np->tstamp_lock);
+
+	ts_req_id = netc_get_ts_req_id(np);
+	if (ts_req_id < 0) {
+		spin_unlock_bh(&np->tstamp_lock);
+		kfree_skb(clone);
+		return;
+	}
+
+	NETC_SKB_CB(nskb)->ptp_flag = NETC_PTP_FLAG_TWOSTEP;
+	NETC_SKB_CB(nskb)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(clone)->ts_req_id = ts_req_id;
+	NETC_SKB_CB(clone)->ptp_tx_time = jiffies_64;
+	NETC_SKB_CB(clone)->ptp_flag = NETC_PTP_FLAG_TWOSTEP;
+	skb_shinfo(clone)->tx_flags |= SKBTX_IN_PROGRESS;
+	__skb_queue_tail(&np->tstamp_queue, clone);
+	if (!delayed_work_pending(&np->tstamp_timeout_work))
+		schedule_delayed_work(&np->tstamp_timeout_work,
+				      NETC_TSTAMP_TIMEOUT);
+
+	spin_unlock_bh(&np->tstamp_lock);
+}
+
+void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
+				u8 ts_req_id, u64 ts)
+{
+	struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct skb_shared_hwtstamps hwtstamps;
+
+	spin_lock_bh(&np->tstamp_lock);
+	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
+		if (NETC_SKB_CB(skb)->ts_req_id != ts_req_id)
+			continue;
+
+		__skb_unlink(skb, &np->tstamp_queue);
+		skb_match = skb;
+		break;
+	}
+	spin_unlock_bh(&np->tstamp_lock);
+
+	if (!skb_match) {
+		dev_dbg_ratelimited(np->switch_priv->dev,
+				    "Port %d ts_req_id %u which seems lost\n",
+				    port, ts_req_id);
+		return;
+	}
+
+	hwtstamps.hwtstamp = ns_to_ktime(ts);
+	skb_complete_tx_timestamp(skb_match, &hwtstamps);
+}
+
+bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
+			unsigned int type)
+{
+	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
+
+	if (!NETC_SKB_CB(skb)->rx_tstamp_valid)
+		return false;
+
+	hwtstamps->hwtstamp = ns_to_ktime(NETC_SKB_CB(skb)->tstamp);
+
+	return false;
+}
+
+void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	u32 ptp_class;
+	int tx_type;
+
+	NETC_SKB_CB(skb)->ptp_flag = 0;
+	ptp_class = ptp_classify_raw(skb);
+	if (ptp_class == PTP_CLASS_NONE)
+		return;
+
+	/* The rx_filters in netc_get_ts_info() has already declared that
+	 * it only supports PTP v2, so TX only supports v2 as well.
+	 */
+	if (unlikely(ptp_class & PTP_CLASS_V1))
+		return;
+
+	tx_type = READ_ONCE(np->ptp_tx_type);
+	if (tx_type == HWTSTAMP_TX_ON)
+		netc_port_prepare_twostep(np, skb);
+}
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index aeb08e6eda09..a1f4b1bc04cb 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -53,10 +53,16 @@
 #define NETC_FDBT_AGEING_DELAY		(3 * HZ)
 #define NETC_FDBT_AGEING_THRESH		100
 
+/* PTP frames have a higher priority, so a higher priority is defined to
+ * prioritize matching (The higher the value, the higher the priority).
+ */
+#define NETC_IPFT_PTP_PRECEDENCE	0xf000
+
 struct netc_switch;
 
 struct netc_switch_info {
 	u32 num_ports;
+	u32 tmr_devfn;
 	void (*phylink_get_caps)(int port, struct phylink_config *config);
 };
 
@@ -66,9 +72,19 @@ struct netc_port_caps {
 	u32 pseudo_link:1;
 };
 
+enum netc_ptp_type {
+	NETC_PTP_L2,
+	NETC_PTP_L4_IPV4_EVENT,
+	NETC_PTP_L4_IPV4_GENERAL,
+	NETC_PTP_L4_IPV6_EVENT,
+	NETC_PTP_L4_IPV6_GENERAL,
+	NETC_PTP_MAX,
+};
+
 enum netc_host_reason {
 	/* Software defined host reasons */
 	NETC_HR_HOST_FLOOD = 8,
+	NETC_HR_PTP_TRAP   = 9,
 };
 
 struct netc_port {
@@ -85,6 +101,15 @@ struct netc_port {
 	u16 mc:1;
 	u16 pvid;
 	u32 ipft_hf_eid; /* Must be initialized to NTMP_NULL_ENTRY_ID */
+
+	/* Serialize access to tstamp_queue */
+	spinlock_t tstamp_lock;
+	/* skb queue for TX timestamp frames */
+	struct sk_buff_head tstamp_queue;
+	struct delayed_work tstamp_timeout_work;
+	int ptp_tx_type;
+	int ptp_rx_filter;
+	u32 ptp_ipft_eid[NETC_PTP_MAX];
 };
 
 struct netc_switch_regs {
@@ -139,6 +164,7 @@ struct netc_switch {
 	u32 num_bp;
 
 	struct bpt_cfge_data *bpt_list;
+	struct pci_dev *tmr_dev; /* The PTP Timer PCI device */
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
@@ -203,4 +229,20 @@ void netc_port_get_strings(struct dsa_switch *ds, int port,
 			   u32 sset, u8 *data);
 void netc_port_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
 
+/* PTP APIs */
+int netc_port_ptp_init(struct netc_port *np);
+int netc_get_ts_info(struct dsa_switch *ds, int port,
+		     struct kernel_ethtool_ts_info *info);
+void netc_port_purge_tstamp_queue(struct netc_port *np);
+int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config,
+			   struct netlink_ext_ack *extack);
+int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config);
+void netc_port_txtstamp_handler(struct dsa_switch *ds, int port,
+				u8 ts_req_id, u64 ts);
+bool netc_port_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb,
+			unsigned int type);
+void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb);
+
 #endif
diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
index fe964722e5b0..5a567af20094 100644
--- a/include/linux/dsa/tag_netc.h
+++ b/include/linux/dsa/tag_netc.h
@@ -10,5 +10,26 @@
 #include <net/dsa.h>
 
 #define NETC_TAG_MAX_LEN			14
+#define NETC_PTP_FLAG_TWOSTEP			BIT(1)
+
+struct netc_skb_cb {
+	u64 ptp_tx_time;
+	u64 tstamp;
+	bool rx_tstamp_valid;
+	u8 ptp_flag;
+	u8 ts_req_id;
+};
+
+#define NETC_SKB_CB(skb)	((struct netc_skb_cb *)((skb)->cb))
+
+/**
+ * struct netc_tagger_data - NETC tagger/switch-driver shared operations
+ * @txtstamp_handler: Called by the tagger when a two-step transmit timestamp
+ *	response is received, to deliver the timestamp to the switch driver.
+ */
+struct netc_tagger_data {
+	void (*txtstamp_handler)(struct dsa_switch *ds, int port,
+				 u8 ts_req_id, u64 ts);
+};
 
 #endif
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
index df72a61796ad..6b492451d092 100644
--- a/net/dsa/tag_netc.c
+++ b/net/dsa/tag_netc.c
@@ -16,6 +16,8 @@
 #define NETC_TAG_TO_PORT		1
 /* SubType0: No request to perform timestamping */
 #define NETC_TAG_TP_SUBTYPE0		0
+/* SubType2: Request to perform two-step timestamping */
+#define NETC_TAG_TP_SUBTYPE2		2
 
 /* To_Host NXP switch tag */
 #define NETC_TAG_TO_HOST		2
@@ -29,6 +31,7 @@
 /* NETC switch tag lengths */
 #define NETC_TAG_FORWARD_LEN		6
 #define NETC_TAG_TP_SUBTYPE0_LEN	6
+#define NETC_TAG_TP_SUBTYPE2_LEN	6
 #define NETC_TAG_TH_SUBTYPE0_LEN	6
 #define NETC_TAG_TH_SUBTYPE1_LEN	14
 #define NETC_TAG_TH_SUBTYPE2_LEN	14
@@ -40,6 +43,7 @@
 #define NETC_TAG_IPV			GENMASK(4, 2)
 #define NETC_TAG_SWITCH			GENMASK(2, 0)
 #define NETC_TAG_PORT			GENMASK(7, 3)
+#define NETC_TAG_TS_REQ_ID		GENMASK(3, 0)
 
 struct netc_tag_cmn {
 	__be16 tpid;
@@ -48,6 +52,23 @@ struct netc_tag_cmn {
 	u8 switch_port;
 } __packed;
 
+struct netc_tag_tp_subtype2 {
+	struct netc_tag_cmn cmn;
+	u8 ts_req_id;
+} __packed;
+
+struct netc_tag_th_subtype1 {
+	struct netc_tag_cmn cmn;
+	u8 host_reason;
+	__be64 timestamp;
+} __packed;
+
+struct netc_tag_th_subtype2 {
+	struct netc_tag_cmn cmn;
+	u8 hr_tsreq_id;
+	__be64 timestamp;
+} __packed;
+
 static void netc_fill_common_tag(struct netc_tag_cmn *tag, u8 type,
 				 u8 subtype, u8 sw_id, u8 port, u8 ipv)
 {
@@ -97,15 +118,57 @@ static void netc_fill_tp_tag_subtype0(struct sk_buff *skb,
 				NETC_TAG_TP_SUBTYPE0_LEN);
 }
 
-/* Currently only support To_Port tag, subtype 0 */
+static void netc_fill_tp_tag_subtype2(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	u8 ts_req_id = NETC_SKB_CB(skb)->ts_req_id;
+	struct netc_tag_tp_subtype2 *tag;
+
+	tag = netc_fill_common_tp_tag(skb, ndev, NETC_TAG_TP_SUBTYPE2,
+				      NETC_TAG_TP_SUBTYPE2_LEN);
+	tag->ts_req_id = FIELD_PREP(NETC_TAG_TS_REQ_ID, ts_req_id);
+}
+
 static struct sk_buff *netc_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
-	netc_fill_tp_tag_subtype0(skb, ndev);
+	u8 ptp_flag = NETC_SKB_CB(skb)->ptp_flag;
+
+	/* Fast path: the overwhelming majority of frames are not PTP frames */
+	if (likely(!ptp_flag))
+		netc_fill_tp_tag_subtype0(skb, ndev);
+	else
+		/* ptp_flag == NETC_PTP_FLAG_TWOSTEP */
+		netc_fill_tp_tag_subtype2(skb, ndev);
 
 	return skb;
 }
 
+static void netc_rx_tstamp_process(struct netc_tag_th_subtype1 *tag,
+				   struct sk_buff *skb)
+{
+	u64 ts = get_unaligned_be64(&tag->timestamp);
+
+	NETC_SKB_CB(skb)->rx_tstamp_valid = true;
+	NETC_SKB_CB(skb)->tstamp = ts;
+}
+
+static void netc_twostep_tstamp_process(struct netc_tag_th_subtype2 *tag,
+					struct sk_buff *skb)
+{
+	u8 ts_req_id = FIELD_GET(NETC_TAG_TS_REQ_ID, tag->hr_tsreq_id);
+	struct dsa_port *dp = dsa_user_to_port(skb->dev);
+	u64 ts = get_unaligned_be64(&tag->timestamp);
+	struct netc_tagger_data *tagger_data;
+	struct dsa_switch *ds = dp->ds;
+
+	tagger_data = ds->tagger_data;
+	if (unlikely(!tagger_data->txtstamp_handler))
+		return;
+
+	tagger_data->txtstamp_handler(ds, dp->index, ts_req_id, ts);
+}
+
 static int netc_get_rx_tag_len(int type, int subtype)
 {
 	/* Only NETC_TAG_TO_HOST and NETC_TAG_FORWARD are expected in RX,
@@ -129,11 +192,22 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb,
 	struct netc_tag_cmn *tag_cmn;
 	int tag_len, sw_id, port;
 	int type, subtype;
+	void *tag;
 
-	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN)))
+	/* eth_type_trans() pulled ETH_HLEN bytes, so skb->data sits 2 bytes
+	 * past the start of the switch tag (past the TPID) and skb->len is
+	 * ETH_HLEN bytes shorter than the original frame length. The longest
+	 * switch tag is NETC_TAG_MAX_LEN (14) bytes, but since 2 of those
+	 * bytes are already behind skb->data, only NETC_TAG_MAX_LEN - 2 bytes
+	 * need to be in the linear buffer. For the To_Host subtype 2 response
+	 * frame, whose total length is only 26 bytes with no payload after the
+	 * tag, this check is the only guard against a too-short frame.
+	 */
+	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN - 2)))
 		goto err_free_skb;
 
-	tag_cmn = dsa_etype_header_pos_rx(skb);
+	tag = dsa_etype_header_pos_rx(skb);
+	tag_cmn = tag;
 	if (ntohs(tag_cmn->tpid) != ETH_P_NXP_NETC) {
 		dev_warn_ratelimited(&ndev->dev, "Unknown TPID 0x%04x\n",
 				     ntohs(tag_cmn->tpid));
@@ -156,17 +230,50 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb,
 	if (!skb->dev)
 		goto err_free_skb;
 
+	/* skb->cb may be used to store hardware RX timestamp, so clear
+	 * rx_tstamp_valid before processing to avoid data pollution from
+	 * the previous layer.
+	 */
+	NETC_SKB_CB(skb)->rx_tstamp_valid = false;
+
 	type = FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
 	subtype = FIELD_GET(NETC_TAG_SUBTYPE, tag_cmn->type);
 	if (type == NETC_TAG_FORWARD) {
 		dsa_default_offload_fwd_mark(skb);
 	} else if (type == NETC_TAG_TO_HOST) {
-		/* Currently only subtype0 supported */
-		if (subtype != NETC_TAG_TH_SUBTYPE0)
+		switch (subtype) {
+		case NETC_TAG_TH_SUBTYPE0:
+			break;
+		case NETC_TAG_TH_SUBTYPE1:
+			/* To_Host Subtype 1 tag is 14 bytes, ensure it and the
+			 * EtherType behind it are fully present in the linear
+			 * area before netc_rcv() calls dsa_strip_etype_header()
+			 * to strip the tag.
+			 */
+			if (unlikely(!pskb_may_pull(skb,
+						    NETC_TAG_TH_SUBTYPE1_LEN)))
+				goto err_free_skb;
+
+			tag = dsa_etype_header_pos_rx(skb);
+			netc_rx_tstamp_process(tag, skb);
+			break;
+		case NETC_TAG_TH_SUBTYPE2:
+			/* This skb is a hardware-generated response to a
+			 * two-step transmit timestamp request. The tag
+			 * driver must free the skb after processing.
+			 */
+			netc_twostep_tstamp_process(tag, skb);
+			consume_skb(skb);
+			return NULL;
+		default:
+			dev_warn_ratelimited(&ndev->dev,
+					     "Unsupported To_Host subtype: %d\n",
+					     subtype);
 			goto err_free_skb;
+		}
 	} else {
 		dev_warn_ratelimited(&ndev->dev,
-				     "Unexpected  tag type %d\n", type);
+				     "Unexpected tag type %d\n", type);
 		goto err_free_skb;
 	}
 
@@ -190,16 +297,48 @@ static void netc_flow_dissect(const struct sk_buff *skb, __be16 *proto,
 	int type = FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
 	int tag_len = netc_get_rx_tag_len(type, subtype);
 
-	/* The RX minimum frame length of the NETC switch port is 64 bytes,
-	 * and the frame is received by the ENETC driver. From the hardware
-	 * perspective, the receive buffer of RX BD is at least 128 bytes,
-	 * so the switch tag header is guaranteed to be in the linear region
-	 * of the skb.
+	/* The CPU port of the switch is connected to the ENETC, so the frame
+	 * is received by the ENETC driver. From the hardware perspective, the
+	 * receive buffer of RX BD is at least 128 bytes, so the switch tag
+	 * header is guaranteed to be in the linear region of the skb.
+	 *
+	 * When the subtype of the frame is NETC_TAG_TH_SUBTYPE2, it indicates
+	 * the frame is a hardware generated timestamp response, which is only
+	 * 26 bytes (DMAC + SMAC + tag), so the frame has no payload after the
+	 * tag. Therefore, there is no need to parse the protocol and offset.
+	 * For other types of the frames, they are all received from the switch
+	 * ports, and the RX minimum frame length of the port is 64 bytes,
+	 * frames shorter than 64 bytes will be discarded by the hardware and
+	 * will not be received by the software.
 	 */
+	if (type == NETC_TAG_TO_HOST && subtype == NETC_TAG_TH_SUBTYPE2)
+		return;
+
 	*offset = tag_len;
 	*proto = ((__be16 *)skb->data)[(tag_len / 2) - 1];
 }
 
+static int netc_connect(struct dsa_switch *ds)
+{
+	struct netc_tagger_data *tagger_data;
+
+	tagger_data = kzalloc_obj(*tagger_data);
+	if (!tagger_data)
+		return -ENOMEM;
+
+	ds->tagger_data = tagger_data;
+
+	return 0;
+}
+
+static void netc_disconnect(struct dsa_switch *ds)
+{
+	struct netc_tagger_data *tagger_data = ds->tagger_data;
+
+	kfree(tagger_data);
+	ds->tagger_data = NULL;
+}
+
 static const struct dsa_device_ops netc_netdev_ops = {
 	.name			= NETC_NAME,
 	.proto			= DSA_TAG_PROTO_NETC,
@@ -207,6 +346,8 @@ static const struct dsa_device_ops netc_netdev_ops = {
 	.rcv			= netc_rcv,
 	.needed_headroom	= NETC_TAG_MAX_LEN,
 	.flow_dissect		= netc_flow_dissect,
+	.connect		= netc_connect,
+	.disconnect		= netc_disconnect,
 };
 
 MODULE_DESCRIPTION("DSA tag driver for NXP NETC switch family");
-- 
2.34.1


