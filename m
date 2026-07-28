Return-Path: <linuxppc-dev+bounces-24933-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9752C531F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 10:43:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8X9j5Ztvz2yvF;
	Tue, 28 Jul 2026 20:43:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785235385;
	cv=pass; b=SBJRgCOu08l70ctdqOR8XW392LBHjaEwwjGWoGumLDrdo27al05GejiiBeppDjq+h8X/4b5Jhquyldm19IQINQy7srl+QxfGYQR3r74Zb4XopRU2dk8LEyzQ9956TCohr3onktqqA16VBfisHnrQvtFOOay6bPQV8mzOX22dJ3f8pjoEullDhH6ZSvsd5ec2zbGLmVRnudFjQcbwElm3JMD9A+ozepMBKHksXPYgGKgKlDVZSp3s9D8G7BUvzqFVsqrql8Wf+1UewgyGdk/AL5g+zUZ33v+YILeYGgrrPhh4n/pqnYYUCXD+PyKpPHBwFms8SPglqypzKt6/VE/xnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785235385; c=relaxed/relaxed;
	bh=+ZZnVmHcY7JwfjKGZaXSWayvkgJtH5AJEC6aymlBb7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iiTDk7xk0MeJsXpJi6Pn7ho88OJLaBse6qbczv4JN6cF2fB8L3X2Op8BKWYs+74jHg5Epl1KF4ra3o3Svtz+5ELp4yaP73G9hPMiHZh5I9gc4tN8fzDjh/vUVLVA1bRuae26pZKs6Q4+l06Ua/RSlvKrk5D7W3Sv5wC5AasFNPbgr0vPBbRaBcVPVef5ScTqTYbxsvlmVzPUPgMfjVrIaXZuBZd4odyj6e65lZHvgiPID/7se0w7ntXDsenRgWE0InTueWRxrzG++rNU0yfwOKkiiPXugYe9fN/ikCQxq3yvV+MjXypFY+CWqZ5KvWJzR0kmDiKSRYP8/7KZF4TlHg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wHQDWOL5; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wHQDWOL5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8X9h1C5Zz2yvb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 20:43:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVWGevGtlPaseDe+3VXHOsQflseNkkYKOdbWbugBPXietVeTcpgW39t9c2b0VIkQ7tgwzU/YRzQ1wtYP2ORU9NfL9jPs9hgBAqnd79MkJV143MdmdVqz68OGjXxrOiKbur/FXmgAkGoF+o+bQRLvDRQAXmZi1/jQUTERMxSyuvsj6oqL8N647ElmcljoktOFS5f89lgn8zaypCUp2Tld0FiRstF8PH99PWxdz34AGEm6MKSut6o8xXM1V9vhlLXlsncUOltj2wItx4H4bLdgDDjGe2wwtQbgOASUN0wl5engbBylYTfnV4jWt6Q2WkY7Pihsl7L5WS3EqPakcDVD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZZnVmHcY7JwfjKGZaXSWayvkgJtH5AJEC6aymlBb7A=;
 b=N6hLIbU8TjTW4XVQ1fcPNVkkr7jX4ZIbWQf0njnw5H1Ac+PaRsVdY+bMRVCmj51amTKqO0mKF1OF6pjGGK4Vk6nNKzWse1shFtY9qDSxhMnENiIkR+/I1IkzmgSg76SdHyiBtJWr9NBAkl6e4tKxNLmXsAdW/oXJ5k82qjShG9IyjMPlnkG7VvCHPiWmXHEBCFL/+lW/cZWb1LJppvUOeyaW75/7+IqkOqlqS9o+60RwoGNiVwIP6WTRkN+aypYrlZZhzHe9rVHukZ5AhhnRmDPofctNFLWQTa+6PC3QGe/FTKCrzA8rqY+rURydxoGm4EHqDYpoCHb5HtKAZ17UvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZZnVmHcY7JwfjKGZaXSWayvkgJtH5AJEC6aymlBb7A=;
 b=wHQDWOL5YdJ7SDpWXAJ6CW7GbyQIzdMEL8B51uNeGciP3zhKyE/R2wHLlqzDjD+mXl6kQcagX4p8EYICCj9yFJ7bHKRIQnmMmJCc+FsvdCOPbNyZ1dJ1U2VADGd9Zjlee3C4DHYfBSxGtZxG+vguJuTgUJaBCP+qpZIdsNXkc72qyJbqztuEi1IXcwXNNiBPhbzmnDRJC5q5rnzo+50Xlj1dhuAUST+6dXpYTGurJWaYH93OVWISJJavcjihHpE4elDs5+e8gKqNW4+kda+eC0byqiWyznIGDEq3WAL2IQUUeN+IEJZzcVX5FNn1ia8iTjksMqnGX/U4Gqzw6ZiWZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17)
 by GV2PR04MB11835.eurprd04.prod.outlook.com (2603:10a6:150:2fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 10:42:44 +0000
Received: from DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14]) by DBAPR04MB7207.eurprd04.prod.outlook.com
 ([fe80::761a:f8dc:80dc:5e14%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 10:42:44 +0000
From: wei.fang@oss.nxp.com
To: richardcochran@gmail.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: wei.fang@nxp.com,
	chleroy@kernel.org,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 7/7] net: dsa: netc: add PTP one-step timestamping support
Date: Tue, 28 Jul 2026 18:45:48 +0800
Message-Id: <20260728104548.3301214-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
References: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:4:297::7) To DBAPR04MB7207.eurprd04.prod.outlook.com
 (2603:10a6:10:1b2::17)
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
X-MS-TrafficTypeDiagnostic: DBAPR04MB7207:EE_|GV2PR04MB11835:EE_
X-MS-Office365-Filtering-Correlation-Id: 79aec250-b90c-4556-e972-08deec94f4d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|5023799004|11063799006|6133799003|18002099003|22082099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	LxIQDJbT4jTaBiVey93WIvVMu4Wdmcpf+ll2/A944Koew/El14B+9g6wMjoDdwlH5Sakacus6Mb8xgaxUUYEBWd8cu46sNtaiBUs5Ct+Q72js+ex1g6k4kva8oIsjNDYrEnS8UscKkrF5aNT4FVYqr71JlWGxbBSPgIWz5YFP31Gf93U07bxfD5iHDk7FstM3Z064lOth4XzwBG36ZGQlbxjXW0r3odxqLKW5/4FL4rvP+xL4IVYA4fyIO6nojEC9xYfT/LrS543p3o6PZb0e8yAaneib0j3/3WVwjvMTRX17bD/JY4w7ncQtehnaGZGKDZBlR14rw3qwFvH9ygaLlBoFuFS1wnwAmq/KSAd7Kjd0Je99ve1yKZuBB4hWq7a2KD2nsciVhAQypi5HcHLGK7IY9E/Uwj2TZoNh5RvG0AKJ192A509KlvMnZXhDeEe3yL0PvvuoQ4aQbT58ePjKyoswApckdGdvNZAwr/rAvw0eUx0nIYyUSUC5YL83fs/5sWsoUg6Gha0/csUHhaIDIK20SpZIPSYiN4Z6daDZvdW622fXbUgf/NTfogpc5EJwfPOwMpLVN4lAHKfz36xNPWyBHqXICws4W+OMzgVsSgS3CkuV4vacHezCwjtfVlhO23SREFAklFB1yw2QTvIDM2A1wiZkPnQ38O2/dXmo8uSEXkLixKV3bRpTaTAr1wx/iKwGXtoKD5SRK66gzUJTQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7207.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LFRun7QIAer7HX+L0Sjw282MXHftix+MONlmutE9+4SzwplSMCBBwMNmvscY?=
 =?us-ascii?Q?wfZY2a5j+wmjTe41EOTP+Jc9QkytmRO6l+0INL8zUT6mCBoLsBQwHip2AxL/?=
 =?us-ascii?Q?bcBOJYhwnTZWsWxuxzY6EOBnxsIh9vcC0Ifd84/qvcVrTPpG5J15SMhHdtS6?=
 =?us-ascii?Q?8YT6CLZRd+a8m8YZ5wNYPYjZM39flyPQzipDRa+BlWJU4+rATO2EbehgLO5j?=
 =?us-ascii?Q?lyDX0lRHjbhC3zyHN2gZfsJ/hjLyv2RtvF6R8+9dVjSvdMZLJy+EE6lvPjfw?=
 =?us-ascii?Q?yzLSY+ktLvpA/mPU/ema8y+jLfmPe+gwZwFvhyLp7fsTLfzLg5gsAlZw0KF/?=
 =?us-ascii?Q?MrepGEVhD6KHvFBjwC7NjA3I8G0sMjIwIy2yG21X+Io0L7D2zHnTW+2T8S+T?=
 =?us-ascii?Q?H7FTEud2xtSAwGLVbUXlNqpZSM2NSOF3JqPJr8ekwcUzc3ibVngUlkGP8C3w?=
 =?us-ascii?Q?Q6WrEXtBuU47lYy3ZcVUCLo9naz+xip6DLu/W28r91062dKZVqZrwQdoDjb+?=
 =?us-ascii?Q?3Hmm+z5Lu+gsMoB3xKKzO0jASseLzqeYJeiLk4d7WGcnol8FFBPYzIyYQsQs?=
 =?us-ascii?Q?W1vDDYR4I1H9K642BUqZzBXG+/NuHzsvK3cD8ygIKyhqP8HhgY81KC98cImm?=
 =?us-ascii?Q?Fdpgg9YSBf+VKLBvNqe+pbmDRhXE2DrZIp0xUfb+e1INE+vjH2QbpuIdlPDf?=
 =?us-ascii?Q?FvQr8IhmSvTzpMCUCs+N/wmDrF3jeLxhh+gsf2MBI4HTtP9ZWHd6Cjga+w+0?=
 =?us-ascii?Q?Z7B1tYMsNsvHPCix7fTH0vGL8y0UVc444Zqmprf9u8iriQqPQ77NOcUpZil2?=
 =?us-ascii?Q?iQVY1/zoXt8UTyGSM1e2fF8HpDqrkPWVZadO8QwAeKlbwj5oEeUUHOplNQqS?=
 =?us-ascii?Q?VUwRtztjA+LW3sXVPC0/QFMCQbgfyBN97drZlNs0Xj8iHYvY5UMrjvZBtbVz?=
 =?us-ascii?Q?HigblF2txlyXWQMQ4W8X9uRR9nGo3brdI2yIbzgHXV6mvj/baFBW5sBlsnES?=
 =?us-ascii?Q?jrHZGSRrC/H7fPJ0kt1HBxX6skznz2WF28sJwhcsXEMLZ+gnrbbB0SHGQtQq?=
 =?us-ascii?Q?wqyO8E7cy2Cq/F3gl0Sf/IJgeFy1g1PF3EHK99zDnlnr5vN130YIwyLkoiGS?=
 =?us-ascii?Q?yozhxFvGgi23LdGLdfndOtf2eATyeQXCoNXjNhIY9anLjZyQk/iZnBTIT55Q?=
 =?us-ascii?Q?4Tu7BhyKP/l8sGXqYkp+q7rUUR/yDk+Rz1EOXFBCjgeWeC6fiTmGu06IyEoD?=
 =?us-ascii?Q?9kbRFvwsdmn5x0TRLzlO8Sk3TThzo5HfeHGWvTdomJBFRCUVmNbJKNpVcGnh?=
 =?us-ascii?Q?pK9s+djBDQsW02nTrMmu8lXmP5yKXOftNf8pIla5iup6Zkr7haYO6gSxpZrV?=
 =?us-ascii?Q?I5D46QByTpuRaYV6Ce1Lu3TEm5QMd/zE3tEg+6HxW+ipKlZg44EPDOlXJMBH?=
 =?us-ascii?Q?SMU9V/HC43liNkXIC3+wIQFmDfJrBXsCbym2Zg09N84OrD3vhm2bzdXTiGWk?=
 =?us-ascii?Q?XxS/rkl2p9cfkSTr1VicSl730hlLZBFc+dvf0KUWTg5jl/H13HfGfEjdehBZ?=
 =?us-ascii?Q?AGcKXrTPfSBdlJxt4twSqk11SpSJV1PuKi1sjaCcrP1wS7k0nWxxJKJ0HVLU?=
 =?us-ascii?Q?cfJ5FTZb6ZRKwbbN7IMipy0bwmbG1B5YiprsFD9TQL0Reg8kn8m5DjjFuc9u?=
 =?us-ascii?Q?7ArBJtFyTDy/xWkCOumOj7EuWOkI3kCQyQgNfSwZQb+JjDsz/dfrrwrPkVGT?=
 =?us-ascii?Q?i/gYICpTEhfNBArIFd/jErJOi+cOYWyHA7wmCBrHypO1TbmhMvHY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79aec250-b90c-4556-e972-08deec94f4d8
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7207.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:42:44.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tvbkPx/NawwAkvrlgEDGOW0uRjEVL+8UuNthZTUeEOsf/cqf0PZR7+gREpxZVzgE4QINH+/Ud+R0qcSefq1Dx3IAt+ZVnf7fNiWafKpjnS9t32nPY+2ugUXv3HIv99y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11835

From: Wei Fang <wei.fang@nxp.com>

The NETC switch supports one-step TX timestamping for PTP Sync frames. On
transmit the MAC captures the time at which it sends the frame SFD, reads
the correction field at the offset given by PM_SINGLE_STEP[OFFSET], adds
the residence time (SFD TX time minus the software timestamp carried with
the packet) to that field, and writes the result back before the frame
leaves the wire.

A one-step request reaches the switch through a To_Port tag with SubType
set to 1, and the software timestamp is the low 30 bits of the PTP Timer
value placed in the tag Timestamp field. PM_SINGLE_STEP[EN] enables
single-step on the port, PM_SINGLE_STEP[OFFSET] locates the correction
field, and PM_SINGLE_STEP[CH] additionally updates the UDP checksum for
PTP-over-UDP.

PM_SINGLE_STEP is a single per-port register that must be programmed
with the correct offset before each one-step Sync is transmitted. If two
one-step Sync frames are handed to the same port concurrently (e.g. from
two CPUs), the second write to PM_SINGLE_STEP overwrites the value
programmed for the first frame before it leaves the MAC, so the hardware
applies the wrong offset and corrupts the PTP correction field.

Serialize one-step Sync transmission per port so that only one frame is
in flight through PM_SINGLE_STEP at a time. A per-port PTP spinlock
(ptp_lock) guards the NETC_FLAG_ONESTEP_IN_PROGRESS in-flight slot and
the deferral queue (skb_onestep_queue) as one atomic critical section:

- netc_port_txtstamp(), from dsa_user_xmit(), classifies the frame. A
  genuine one-step Sync (twoStepFlag cleared) has its correction and
  timestamp offsets and UDP flag cached in the skb control block and is
  marked NETC_PTP_FLAG_ONESTEP; a two-step request or non-Sync falls
  back to the two-step path. Frames that cannot be handled as one-step
  (parse failure, originTimestamp not in the linear area, or a zerocopy
  skb) are sent unchanged as normal frames.

- netc_onestep_sync_handler(), a tagger callback invoked from
  netc_xmit(), does the serialization. If the slot is free it claims it,
  reads the time, programs PM_SINGLE_STEP and installs a TX-completion
  destructor, then returns the skb so netc_xmit() tags it with SubType1
  and sends it through dsa_user_xmit(). If the slot is busy it queues the
  skb and returns NULL, transferring ownership to the queue.

- When the in-flight frame completes TX the conduit frees the skb, the
  destructor fires and schedules onestep_work. onestep_work dequeues the
  next skb while still holding the slot (so a newly arriving Sync cannot
  jump ahead), programs it with a fresh timestamp and sends it via the
  tagger onestep_sync_xmit() callback, which pushes the SubType1 tag and
  calls dsa_enqueue_skb() directly. This bypasses dsa_user_xmit() so the
  TX stats are not counted twice and the deferred frames stay ordered;
  it is safe because the skb already went through
  skb_ensure_writable_head_tail() and eth_skb_pad() and nothing shrank
  its head/tail room since. The slot is released only when the queue
  drains empty.

The one-step path reads the PTP time with netc_timer_get_current_time(),
which is provided by the NETC v4 timer driver, so update the Kconfig
dependency from PTP_1588_CLOCK_OPTIONAL to PTP_NETC_V4_TIMER. The
"|| PTP_NETC_V4_TIMER=n" form still allows the switch driver to build
when the timer is disabled, in which case it links against the inline
stub in <linux/fsl/netc_global.h>.

If the PTP timer is unavailable when a one-step Sync is about to be
programmed, drop the frame with a rate-limited message rather than send
a bogus correction field, and re-kick onestep_work so the queue keeps
draining.

Assisted-by: Wchat:claude-opus-4-8
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Kconfig          |   2 +-
 drivers/net/dsa/netc/netc_main.c      |   7 +-
 drivers/net/dsa/netc/netc_ptp.c       | 256 +++++++++++++++++++++++++-
 drivers/net/dsa/netc/netc_switch.h    |  12 ++
 drivers/net/dsa/netc/netc_switch_hw.h |   5 +
 include/linux/dsa/tag_netc.h          |  19 ++
 net/dsa/tag_netc.c                    |  72 ++++++++
 7 files changed, 369 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
index 8770b65d0f62..55b1f1338a87 100644
--- a/drivers/net/dsa/netc/Kconfig
+++ b/drivers/net/dsa/netc/Kconfig
@@ -4,7 +4,7 @@ config NET_DSA_NETC_SWITCH
 	depends on ARM64 || COMPILE_TEST
 	depends on NET_DSA && PCI
 	depends on NET_VENDOR_FREESCALE
-	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on PTP_NETC_V4_TIMER || PTP_NETC_V4_TIMER=n
 	select NET_DSA_TAG_NETC
 	select FSL_ENETC_MDIO
 	select NXP_NTMP
diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index d98ee40a1af7..9855e02b4726 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -74,6 +74,7 @@ static int netc_connect_tag_protocol(struct dsa_switch *ds,
 		return -EPROTONOSUPPORT;
 
 	tagger_data = ds->tagger_data;
+	tagger_data->onestep_sync_handler = netc_onestep_sync_handler;
 	tagger_data->twostep_tstamp_handler = netc_twostep_tstamp_handler;
 
 	return 0;
@@ -94,7 +95,7 @@ static void netc_port_rmw(struct netc_port *np, u32 reg,
 	netc_port_wr(np, reg, new);
 }
 
-static void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
+void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val)
 {
 	if (is_netc_pseudo_port(np))
 		return;
@@ -318,6 +319,8 @@ static int netc_init_all_ports(struct netc_switch *priv)
 			netc_port_init_ptp_ipft_eid(np);
 			spin_lock_init(&np->ptp_lock);
 			__skb_queue_head_init(&np->skb_txtstamp_queue);
+			__skb_queue_head_init(&np->skb_onestep_queue);
+			INIT_WORK(&np->onestep_work, netc_port_onestep_work);
 		}
 	}
 
@@ -1011,6 +1014,8 @@ static void netc_free_ports_resources(struct netc_switch *priv)
 		 * (sock_efree) while holding a spinlock.
 		 */
 		__skb_queue_purge(&np->skb_txtstamp_queue);
+		cancel_work_sync(&np->onestep_work);
+		__skb_queue_purge(&np->skb_onestep_queue);
 	}
 }
 
diff --git a/drivers/net/dsa/netc/netc_ptp.c b/drivers/net/dsa/netc/netc_ptp.c
index 7288eac11b46..ff7d8e5e68d2 100644
--- a/drivers/net/dsa/netc/netc_ptp.c
+++ b/drivers/net/dsa/netc/netc_ptp.c
@@ -37,7 +37,8 @@ int netc_get_ts_info(struct dsa_switch *ds, int port,
 				 SOF_TIMESTAMPING_RX_HARDWARE |
 				 SOF_TIMESTAMPING_RAW_HARDWARE;
 
-	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON) |
+			 BIT(HWTSTAMP_TX_ONESTEP_SYNC);
 
 	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
 			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
@@ -237,11 +238,18 @@ int netc_port_hwtstamp_set(struct dsa_switch *ds, int port,
 			   struct netlink_ext_ack *extack)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_switch *priv = ds->priv;
 	int rx_filter, err;
 
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_ON:
 	case HWTSTAMP_TX_OFF:
+		np->ptp_tx_type = config->tx_type;
+		break;
+	case HWTSTAMP_TX_ONESTEP_SYNC:
+		if (!priv->tmr_dev)
+			return -ERANGE;
+
 		np->ptp_tx_type = config->tx_type;
 		break;
 	default:
@@ -384,9 +392,89 @@ bool netc_port_rxtstamp(struct dsa_switch *ds, int port,
 	return false;
 }
 
+static void netc_port_prepare_onestep_sync(struct netc_port *np,
+					   struct sk_buff *skb,
+					   u32 ptp_class, bool *twostep)
+{
+	struct netc_switch *priv = np->switch_priv;
+	u16 correction_offset, timestamp_offset;
+	struct ptp_header *ptp_hdr;
+	u8 msg_type, twostep_flag;
+	bool is_udp = false;
+	u32 pkt_type;
+	u8 *pkt_hdr;
+
+	ptp_hdr = ptp_parse_header(skb, ptp_class);
+	if (!ptp_hdr) {
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d failed to parse Sync header\n",
+				    np->dp->index);
+		return;
+	}
+
+	pkt_hdr = skb_mac_header(skb);
+	correction_offset = (u8 *)&ptp_hdr->correction - pkt_hdr;
+	timestamp_offset = (u8 *)ptp_hdr + sizeof(*ptp_hdr) - pkt_hdr;
+
+	/* Ensure that the entire originTimestamp field is present in the
+	 * linear buffer of the skb.
+	 */
+	if (pkt_hdr + timestamp_offset + 10 > skb->data + skb_headlen(skb)) {
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d Sync header not in linear area\n",
+				    np->dp->index);
+		return;
+	}
+
+	msg_type = ptp_get_msgtype(ptp_hdr, ptp_class);
+	twostep_flag = ptp_hdr->flag_field[0] & 0x2;
+
+	/* Only a Sync frame with the twoStepFlag cleared can use one-step
+	 * timestamping. A frame that requests two-step (or is not a Sync)
+	 * carries different on-wire fields, so this is a real classification;
+	 * report it through *twostep so the caller falls back to the two-step
+	 * path.
+	 */
+	if (msg_type != PTP_MSGTYPE_SYNC || twostep_flag != 0) {
+		*twostep = true;
+		return;
+	}
+
+	/* This is a genuine one-step Sync frame. skb_shinfo()->destructor_arg
+	 * is later used to pass the netc_port pointer to
+	 * netc_onestep_skb_destructor() for TX completion notification.
+	 * MSG_ZEROCOPY also uses destructor_arg (via skb_zcopy_init()) to
+	 * track user-space page references. Overwriting it in that case would
+	 * leak the ubuf_info reference and prevent user pages from being
+	 * released. PTP applications do not use MSG_ZEROCOPY, but guard
+	 * against it defensively.
+	 */
+	if (skb_zcopy(skb)) {
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d one-step Sync not supported on zerocopy skb\n",
+				    np->dp->index);
+		return;
+	}
+
+	pkt_type = ptp_class & PTP_CLASS_PMASK;
+	if (pkt_type == PTP_CLASS_IPV4 || pkt_type == PTP_CLASS_IPV6)
+		is_udp = true;
+
+	/* Cache the parsing results so the tagger xmit path and the deferred
+	 * work do not need to re-parse the PTP header, and so that
+	 * netc_port_program_onestep() can derive these parameters from the
+	 * skb.
+	 */
+	NETC_SKB_CB(skb)->correction_offset = correction_offset;
+	NETC_SKB_CB(skb)->timestamp_offset = timestamp_offset;
+	NETC_SKB_CB(skb)->is_udp = is_udp;
+	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+}
+
 void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 {
 	struct netc_port *np = NETC_PORT(ds, port);
+	bool twostep = false;
 	u32 ptp_class;
 
 	NETC_SKB_CB(skb)->ptp_flag = 0;
@@ -394,7 +482,10 @@ void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 	if (ptp_class == PTP_CLASS_NONE)
 		return;
 
-	if (np->ptp_tx_type == HWTSTAMP_TX_ON) {
+	if (np->ptp_tx_type == HWTSTAMP_TX_ONESTEP_SYNC)
+		netc_port_prepare_onestep_sync(np, skb, ptp_class, &twostep);
+
+	if (np->ptp_tx_type == HWTSTAMP_TX_ON || twostep) {
 		struct sk_buff *clone = skb_clone_sk(skb);
 
 		if (unlikely(!clone))
@@ -409,3 +500,164 @@ void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 		NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_TWOSTEP;
 	}
 }
+
+static void netc_port_set_onestep_control(struct netc_port *np, bool udp,
+					  int offset)
+{
+	u32 val;
+
+	val = PM_SINGLE_STEP_EN | FIELD_PREP(PM_SINGLE_STEP_OFFSET, offset);
+	if (udp)
+		val |= PM_SINGLE_STEP_CH;
+	netc_mac_port_wr(np, NETC_PM_SINGLE_STEP(0), val);
+}
+
+static void netc_onestep_skb_destructor(struct sk_buff *skb)
+{
+	struct netc_port *np = skb_shinfo(skb)->destructor_arg;
+
+	/* skb has been transmitted by hardware, schedule work to send
+	 * the next queued one-step Sync packet.
+	 */
+	schedule_work(&np->onestep_work);
+}
+
+static void netc_port_program_onestep(struct netc_port *np,
+				      struct sk_buff *skb,
+				      u64 tstamp)
+{
+	u16 correction_offset = NETC_SKB_CB(skb)->correction_offset;
+	u16 timestamp_offset = NETC_SKB_CB(skb)->timestamp_offset;
+	bool is_udp = NETC_SKB_CB(skb)->is_udp;
+	u8 *pkt_hdr = skb_mac_header(skb);
+	u64 sec;
+	u32 ns;
+
+	NETC_SKB_CB(skb)->tstamp = tstamp;
+	NETC_SKB_CB(skb)->ptp_flag = NETC_PTP_FLAG_ONESTEP;
+
+	/* Update originTimestamp field of Sync packet
+	 * - 48 bits seconds field
+	 * - 32 bits nanoseconds field
+	 */
+	sec = div_u64_rem(tstamp, NSEC_PER_SEC, &ns);
+	put_unaligned_be16((sec >> 32) & 0xffff, pkt_hdr + timestamp_offset);
+	put_unaligned_be32(sec & 0xffffffff, pkt_hdr + timestamp_offset + 2);
+	put_unaligned_be32(ns, pkt_hdr + timestamp_offset + 6);
+
+	netc_port_set_onestep_control(np, is_udp, correction_offset);
+
+	/* Orphan the skb to release the socket send buffer quota immediately.
+	 * This is safe because sock_wfree() only updates sk_wmem_alloc and
+	 * does not touch skb->data. After skb_orphan(), we install our own
+	 * destructor so that when the conduit driver frees the skb after TX
+	 * completion, we get notified to send the next queued Sync packet.
+	 */
+	skb_orphan(skb);
+	skb_shinfo(skb)->destructor_arg = np;
+	skb->destructor = netc_onestep_skb_destructor;
+}
+
+void netc_port_onestep_work(struct work_struct *work)
+{
+	struct netc_port *np = container_of(work, struct netc_port,
+					    onestep_work);
+	struct netc_switch *priv = np->switch_priv;
+	struct netc_tagger_data *tagger_data;
+	struct sk_buff *skb;
+	u64 tstamp;
+
+	/* Dequeue the next pending skb while still holding the in-flight slot,
+	 * so a newly arriving one-step Sync cannot jump ahead of it. Only
+	 * release the slot when the queue is empty. This keeps ordering and
+	 * closes the enqueue/wakeup race.
+	 */
+	spin_lock_bh(&np->ptp_lock);
+	skb = __skb_dequeue(&np->skb_onestep_queue);
+	if (!skb) {
+		__clear_bit(NETC_FLAG_ONESTEP_IN_PROGRESS, &np->flags);
+		spin_unlock_bh(&np->ptp_lock);
+		return;
+	}
+	spin_unlock_bh(&np->ptp_lock);
+
+	tstamp = netc_timer_get_current_time(priv->tmr_dev);
+	if (!tstamp) {
+		/* The PTP timer is not available, so there is no correct
+		 * timestamp to program. Drop this frame and re-kick to
+		 * process the remaining queued frames (or release the slot).
+		 *
+		 * netc_port_program_onestep() has not run for this skb yet, so
+		 * netc_onestep_skb_destructor() is not installed on it. Freeing
+		 * it therefore does not reschedule onestep_work, so the work
+		 * must be rescheduled explicitly to keep draining the queue.
+		 */
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d PTP timer unavailable, drop Sync\n",
+				    np->dp->index);
+		kfree_skb(skb);
+		schedule_work(&np->onestep_work);
+		return;
+	}
+
+	/* Reuse the offsets cached at enqueue time; only the timestamp is
+	 * read fresh so it reflects the actual TX moment.
+	 */
+	netc_port_program_onestep(np, skb, tstamp);
+
+	/* Tag and hand the frame directly to the conduit via the tagger,
+	 * bypassing dsa_user_xmit() so the TX stats are not counted twice.
+	 */
+	tagger_data = priv->ds->tagger_data;
+	tagger_data->onestep_sync_xmit(skb, np->dp->user);
+}
+
+struct sk_buff *netc_onestep_sync_handler(struct dsa_switch *ds, int port,
+					  struct sk_buff *skb)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+	struct netc_switch *priv = ds->priv;
+	u64 tstamp;
+
+	/* Serialize one-step Sync packets: only one can be in-flight at a
+	 * time because the SINGLE_STEP register is shared and must match the
+	 * packet currently being transmitted. Claim the in-flight slot under
+	 * ptp_lock. If another one-step Sync is already in-flight, queue this
+	 * skb and return NULL; ownership is transferred to the queue, so no
+	 * extra reference is needed and netc_xmit() stops processing it.
+	 */
+	spin_lock_bh(&np->ptp_lock);
+	if (test_bit(NETC_FLAG_ONESTEP_IN_PROGRESS, &np->flags)) {
+		__skb_queue_tail(&np->skb_onestep_queue, skb);
+		spin_unlock_bh(&np->ptp_lock);
+
+		return NULL;
+	}
+
+	tstamp = netc_timer_get_current_time(priv->tmr_dev);
+	if (!tstamp) {
+		spin_unlock_bh(&np->ptp_lock);
+
+		/* This is a valid one-step Sync frame, but the PTP timer is
+		 * not available, so there is no correct timestamp to program.
+		 * Drop the frame rather than transmit a Sync with a bogus
+		 * correction field.
+		 */
+		dev_dbg_ratelimited(priv->dev,
+				    "Port %d PTP timer unavailable, drop Sync\n",
+				    np->dp->index);
+		kfree_skb(skb);
+
+		return NULL;
+	}
+
+	__set_bit(NETC_FLAG_ONESTEP_IN_PROGRESS, &np->flags);
+	spin_unlock_bh(&np->ptp_lock);
+
+	/* We own the in-flight slot. Program the register and install the
+	 * destructor.
+	 */
+	netc_port_program_onestep(np, skb, tstamp);
+
+	return skb;
+}
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 61ecd12b5836..296df1d72333 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -82,6 +82,10 @@ enum netc_host_reason {
 	NETC_HR_PTP_TRAP   = 9,
 };
 
+enum netc_port_flags {
+	NETC_FLAG_ONESTEP_IN_PROGRESS = 0,
+};
+
 struct netc_port {
 	void __iomem *iobase;
 	struct netc_switch *switch_priv;
@@ -97,10 +101,14 @@ struct netc_port {
 	u16 pvid;
 	u32 ipft_hf_eid;
 
+	unsigned long flags;
 	/* Serialize PTP operations */
 	spinlock_t ptp_lock;
 	/* skb queue for two-step timestamp frames */
 	struct sk_buff_head skb_txtstamp_queue;
+	/* skb queue for one-step sync frames */
+	struct sk_buff_head skb_onestep_queue;
+	struct work_struct onestep_work;
 	int ptp_tx_type;
 	int ptp_rx_filter;
 	u32 ptp_ipft_eid[NETC_PTP_MAX];
@@ -207,6 +215,7 @@ static inline void netc_del_vlan_entry(struct netc_vlan_entry *entry)
 }
 
 int netc_switch_platform_probe(struct netc_switch *priv);
+void netc_mac_port_wr(struct netc_port *np, u32 reg, u32 val);
 
 /* ethtool APIs */
 void netc_port_get_pause_stats(struct dsa_switch *ds, int port,
@@ -237,5 +246,8 @@ bool netc_port_rxtstamp(struct dsa_switch *ds, int port,
 			struct sk_buff *skb, unsigned int type);
 void netc_port_txtstamp(struct dsa_switch *ds, int port_id,
 			struct sk_buff *skb);
+void netc_port_onestep_work(struct work_struct *work);
+struct sk_buff *netc_onestep_sync_handler(struct dsa_switch *ds, int port,
+					  struct sk_buff *skb);
 
 #endif
diff --git a/drivers/net/dsa/netc/netc_switch_hw.h b/drivers/net/dsa/netc/netc_switch_hw.h
index 1404ae41c7bc..37d1dd7ec2c7 100644
--- a/drivers/net/dsa/netc/netc_switch_hw.h
+++ b/drivers/net/dsa/netc/netc_switch_hw.h
@@ -203,6 +203,11 @@ enum netc_stg_stage {
 #define   SSP_10M			1
 #define   SSP_1G			2
 
+#define NETC_PM_SINGLE_STEP(a)		(0x10c0 + (a) * 0x400)
+#define  PM_SINGLE_STEP_CH		BIT(6)
+#define  PM_SINGLE_STEP_OFFSET		GENMASK(15, 7)
+#define  PM_SINGLE_STEP_EN		BIT(31)
+
 /* Port MAC 0/1 Receive Ethernet Octets Counter */
 #define NETC_PM_REOCT(a)		(0x1100 + (a) * 0x400)
 
diff --git a/include/linux/dsa/tag_netc.h b/include/linux/dsa/tag_netc.h
index f73dca5b5f24..229c70cb7a8a 100644
--- a/include/linux/dsa/tag_netc.h
+++ b/include/linux/dsa/tag_netc.h
@@ -11,6 +11,7 @@
 
 #define NETC_TAG_MAX_LEN			14
 #define NETC_TAG_TS_REQ_ID			GENMASK(3, 0)
+#define NETC_PTP_FLAG_ONESTEP			BIT(0)
 #define NETC_PTP_FLAG_TWOSTEP			BIT(1)
 
 struct netc_skb_cb {
@@ -19,6 +20,14 @@ struct netc_skb_cb {
 	u64 tstamp;
 	u8 ptp_flag;
 	u8 ts_req_id;
+	/* One-step Sync parsing results, computed in netc_port_txtstamp()
+	 * and reused in the tagger xmit path and the deferred work, to avoid
+	 * re-parsing the PTP header. Valid only while
+	 * ptp_flag == NETC_PTP_FLAG_ONESTEP.
+	 */
+	u16 correction_offset;
+	u16 timestamp_offset;
+	bool is_udp;
 };
 
 #define NETC_SKB_CB(skb)	((struct netc_skb_cb *)((skb)->cb))
@@ -28,10 +37,20 @@ struct netc_skb_cb {
  * @twostep_tstamp_handler: Called by the tagger when a two-step transmit
  *	timestamp response is received, to deliver the timestamp to the
  *	switch driver.
+ * @onestep_sync_handler: Called from the tagger xmit path for a one-step Sync
+ *	frame. Returns the skb if it can be transmitted immediately (the
+ *	in-flight slot has been claimed and PM_SINGLE_STEP programmed), or NULL
+ *	if the frame has been queued for deferred transmission or dropped.
+ * @onestep_sync_xmit: Called by the switch driver to transmit a deferred
+ *	one-step Sync frame directly to the conduit, bypassing dsa_user_xmit().
  */
 struct netc_tagger_data {
 	void (*twostep_tstamp_handler)(struct dsa_switch *ds, int port,
 				       u8 ts_req_id, u64 ts);
+	struct sk_buff *(*onestep_sync_handler)(struct dsa_switch *ds,
+						int port, struct sk_buff *skb);
+	netdev_tx_t (*onestep_sync_xmit)(struct sk_buff *skb,
+					 struct net_device *ndev);
 };
 
 #endif
diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
index 33c285c8d1ce..94cca20ffcda 100644
--- a/net/dsa/tag_netc.c
+++ b/net/dsa/tag_netc.c
@@ -16,6 +16,8 @@
 #define NETC_TAG_TO_PORT		1
 /* SubType0: No request to perform timestamping */
 #define NETC_TAG_TP_SUBTYPE0		0
+/* SubType1: Request to perform one-step timestamping */
+#define NETC_TAG_TP_SUBTYPE1		1
 /* SubType2: Request to perform two-step timestamping */
 #define NETC_TAG_TP_SUBTYPE2		2
 
@@ -31,6 +33,7 @@
 /* NETC switch tag lengths */
 #define NETC_TAG_FORWARD_LEN		6
 #define NETC_TAG_TP_SUBTYPE0_LEN	6
+#define NETC_TAG_TP_SUBTYPE1_LEN	10
 #define NETC_TAG_TP_SUBTYPE2_LEN	6
 #define NETC_TAG_TH_SUBTYPE0_LEN	6
 #define NETC_TAG_TH_SUBTYPE1_LEN	14
@@ -43,6 +46,7 @@
 #define NETC_TAG_IPV			GENMASK(4, 2)
 #define NETC_TAG_SWITCH			GENMASK(2, 0)
 #define NETC_TAG_PORT			GENMASK(7, 3)
+#define NETC_TAG_TIMESTAMP		GENMASK(29, 0)
 
 struct netc_tag_cmn {
 	__be16 tpid;
@@ -51,6 +55,12 @@ struct netc_tag_cmn {
 	u8 switch_port;
 } __packed;
 
+struct netc_tag_tp_subtype1 {
+	struct netc_tag_cmn cmn;
+	u8 resv;
+	__be32 timestamp;
+} __packed;
+
 struct netc_tag_tp_subtype2 {
 	struct netc_tag_cmn cmn;
 	u8 ts_req_id;
@@ -117,6 +127,17 @@ static void netc_fill_tp_tag_subtype0(struct sk_buff *skb,
 				NETC_TAG_TP_SUBTYPE0_LEN);
 }
 
+static void netc_fill_tp_tag_subtype1(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	u32 ts = FIELD_PREP(NETC_TAG_TIMESTAMP, NETC_SKB_CB(skb)->tstamp);
+	struct netc_tag_tp_subtype1 *tag;
+
+	tag = netc_fill_common_tp_tag(skb, ndev, NETC_TAG_TP_SUBTYPE1,
+				      NETC_TAG_TP_SUBTYPE1_LEN);
+	tag->timestamp = htonl(ts);
+}
+
 static void netc_fill_tp_tag_subtype2(struct sk_buff *skb,
 				      struct net_device *ndev)
 {
@@ -129,6 +150,49 @@ static void netc_fill_tp_tag_subtype2(struct sk_buff *skb,
 	tag->ts_req_id = FIELD_PREP(NETC_TAG_TS_REQ_ID, ts_req_id);
 }
 
+static netdev_tx_t netc_onestep_sync_xmit(struct sk_buff *skb,
+					  struct net_device *dev)
+{
+	/* This deferred one-step Sync frame already went through
+	 * dsa_user_xmit()'s skb_ensure_writable_head_tail() and eth_skb_pad()
+	 * before it was queued in netc_xmit(), and nothing has cloned it or
+	 * shrunk its head/tail room since. So the head/tail room is still
+	 * guaranteed and the skb is still writable; only the tag needs to be
+	 * pushed before handing it directly to the conduit, bypassing
+	 * dsa_user_xmit() so that dev_sw_netstats_tx_add() is not invoked a
+	 * second time for the same frame.
+	 */
+	netc_fill_tp_tag_subtype1(skb, dev);
+
+	return dsa_enqueue_skb(skb, dev);
+}
+
+static struct sk_buff *netc_onestep_sync_process(struct sk_buff *skb,
+						 struct net_device *ndev)
+{
+	struct dsa_port *dp = dsa_user_to_port(ndev);
+	struct netc_tagger_data *tagger_data;
+	struct sk_buff *nskb;
+
+	tagger_data = dp->ds->tagger_data;
+	if (unlikely(!tagger_data->onestep_sync_handler)) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* Decide, under ptp_lock, whether this one-step Sync can be sent
+	 * now or must be deferred. Returns the skb (with the in-flight
+	 * slot claimed and PM_SINGLE_STEP already programmed) for
+	 * immediate transmission, or NULL if it was queued for deferred
+	 * transmission or dropped.
+	 */
+	nskb = tagger_data->onestep_sync_handler(dp->ds, dp->index, skb);
+	if (unlikely(!nskb))
+		return NULL;
+
+	return nskb;
+}
+
 static struct sk_buff *netc_xmit(struct sk_buff *skb,
 				 struct net_device *ndev)
 {
@@ -138,6 +202,13 @@ static struct sk_buff *netc_xmit(struct sk_buff *skb,
 	if (likely(!ptp_flag)) {
 		netc_fill_tp_tag_subtype0(skb, ndev);
 		return skb;
+	}
+
+	if (ptp_flag == NETC_PTP_FLAG_ONESTEP) {
+		if (!netc_onestep_sync_process(skb, ndev))
+			return NULL;
+
+		netc_fill_tp_tag_subtype1(skb, ndev);
 	} else if (ptp_flag == NETC_PTP_FLAG_TWOSTEP) {
 		netc_fill_tp_tag_subtype2(skb, ndev);
 	} else {
@@ -291,6 +362,7 @@ static int netc_connect(struct dsa_switch *ds)
 	if (!tagger_data)
 		return -ENOMEM;
 
+	tagger_data->onestep_sync_xmit = netc_onestep_sync_xmit;
 	ds->tagger_data = tagger_data;
 
 	return 0;
-- 
2.34.1


