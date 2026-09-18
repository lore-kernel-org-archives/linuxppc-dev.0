Return-Path: <linuxppc-dev+bounces-27671-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4197C88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:25:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmPKK4XTWz2y7r;
	Fri, 18 Sep 2026 17:25:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789716309;
	cv=pass; b=DSXhnZ0Mqhwo1NptzouIabdBzXnmY0m2NZLN0j3ouYXyIXAmBwg16wzBUX0icteT934ooinlXVJhMa6TFWzjFSt0KaEuJLLWB12ez2QBCvsfv6jjRJcC5Dxmp5q6BQ07vyQc272i9VhLhH7C1yB/BwJHRXvyBlFXsA0ouM31Cgn4o+xlo/SGvWO1VJdNfp2W/B0B6zcmXM429gRhpxDUYRn4hdt9jZ2arIgIQTzPXPceWuJF05nSoTuAr7RAXKxpAnOAtxxlYDc5Tt18QWJytMKISEAP+pwlGkrUJzm2NogieYYsDKtRLz7FohDCo6GpgmqnOrfn6G5jFDgMdu1Mvw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789716309; c=relaxed/relaxed;
	bh=8Ecu4EJjHFCxonSu4eJAz70syYBGylSzs3FP9bv3q7k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VlqdmIcZEZ2h/ClU+ucALDBzC+XjFC1wJiL5YTUMf0zP/7X3WVfRVHlKjC2tAu97KUKC1/ADC1KojzhVTJY7rRbwoZNaQBuHyJJk2ZMXeu9jnqZ/ra/x175mrD6eMHjoRlOqW+huMiLkeM25tYuMYq0FTNh+fKP4pg74gr2ndMOkDy+iNa08HUR3Ik9lrjay7D4iaw/deVxgIzyPnjBQLwXDY5bUqpaDl4l9tqaRpZtKWKQvbMWOkxt+Txl/G/Jw3mzCmxeeJYqzYzU2Y+zKR/2LuzeV3uJPlRcE+TjJtrKFojs541k0artoXVcdxztJ7T0Pgl1z8mHBGhnN7+C92w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ch0BPnSZ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Ch0BPnSZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmPKH5HBvz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:25:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4i+hBTGCMhvKnALyCok3PJQr2cHzKt1gWO54rqniZbclPywSXHHuzrAE8yVcz+wRGt7fjU2UMRdnoS2fCsS6rFUmWZgC+AWuaUO08XezUZbAjsEANjV9zC7FQvcRCBX+QK5dDxui93cx/hli9mkMaOeoIyljkrWdF0sp8h5fL+BrxNoKHT1wrd9onnd+M/1oqngZ9w0uO8fJyO8WPJiI67bjXEVCjjayWaToc4RpzQx1euItfF9KVlMpJVfYA2w0js+O/GgazHjUWKsJw+szyHg+YcXaabV4G+SZrYLpOCKmQa4TNLQWU2rFopQdQIzNuc9KgdKfYGyGiHyHjeOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Ecu4EJjHFCxonSu4eJAz70syYBGylSzs3FP9bv3q7k=;
 b=h3YdDLxuI3lpBIlx6q0FM1myfqYLQ8XiQjuE8lz1QqrgKjy1RXSqRjCCJp/oAlTbyh3sbhl5/wzOVfWkZvXBtpVy7/KausY5YX0GAcaPf3LHeJInW+Pb1qZdKa7p34qNZ2OqYkcdjnlZi1PsR2w7eLqF72SjKMpa9I2/dFo7MVaPq58Cr3iwegSs6stRIVFsHWjYWUQN5rFkzp4n9zkin27PIvo8MyvxWBB3LClqtkoQTyVe4gQRLtDn1QQP5HlEM91f8dnLZOMAXsTeW7k/r+BMZlt20ZI3RRE/ZB9t21sf/zAposXc1mMC0rsdpINwGNecc1NAiC227CWwyGi1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Ecu4EJjHFCxonSu4eJAz70syYBGylSzs3FP9bv3q7k=;
 b=Ch0BPnSZhlkcXVj5SMy5pJ3tcfj3WGGKydZzjzcdB21wABNaj7JF6AngH+OIuny3GwxaLfZUFavYV0ArSR1F6iiYcuicSwDI5JMabR5oRriNLRcDKNsAS746o5Qo94+sYK5brzJwCvreF+CvlNk2G9qrKpx63u0tAzv3GHYZw9GM+SA2V0KerhyNIVwlGWj4vYuH3JTafvXJlPozl8jJOsUOIEn9dbdUvBpCTr38/S7JHIPzmHJHZVOqVnGYpADZODxdCEOxm0vmh+9LaE8/OSebLsBP7TkscIqIr5CNQB0LDmFAWKfavDJ1juppiedk7oAUi8jf4Xqa0A4CgDhJYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 07:24:42 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:24:42 +0000
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
Subject: [PATCH v4 net-next 0/8] net: dsa: netc: add PTP support for NETC switch
Date: Fri, 18 Sep 2026 15:28:44 +0800
Message-Id: <20260918072852.501420-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::19) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: ff6ad185-ee70-4911-9ac2-08df1555e7d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|10067099003|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	YekhbAqBkS4Glfx0AXmUotkay77KAJk8+/5hfDJR0MPEWM06VSbkQQQNMovY47CpbsaqbXcLM9CH7oN/5v3fgxhll5afyVNpDz1Rqau9SqFccvjAXluNKgyTZZs9WeNNCFX+AnWWTHCj1/+3zFR0HRnY9wEH3mjjgzn2Royh/Buw1eHMCoJBy32yMAJ4IK/NLu4T8GKJ0Urwq7nGs9kOqsPUBTWbvTyP+28n/eUIndvQbPM8mC8baMbYVa/S5/6KlCFBRIWIC2heWnzvoBs2HDp3IF3yZ85WZ3+/YUq9uxpcabiJsJudjec8bgBUCWN+L/V8a5zQh44+mkfOgw2H37sjkQBjclU2VRVavb6vbhhlXwcmBOV3WLLE8jr0YToff7AahA+ZJLXKjaKpZW3AyynKZIkAp/gj47bopX+ctN6peHeGWtLXuATcYl1fZfwsJMKxlQx03wu3RuaMBdJjozq47RT3weLUuVMk+kif+D0pPPKDkmExbuNoISF+RuTg6+GoHHhsPVSSNEMLth+3m5e0UmG4VDg4/IJ7kr+xPwunIGawiLTZ+J9uNzhc9Q3Yg0orlGo1/0Vo94WRRHBtRc6fu15GrGz2ERNYATL26P1q76LBUbrBOM3S9NPGCEEZUZGh1TNLi9pLHomNaVhyMx1OsPPSvIEJBuC2iHGsNG/kc809F4NR6hgCMB7B55MJmNinZs2O7naVHj0Z///N4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(10067099003)(56012099006)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GEUr6c5A1Wclw5WATLpuIOVs7Pr3+6rN1E6HFmyyK36dwG1YjsM1MxeU6n6U?=
 =?us-ascii?Q?3q9wjNkSx4BcaOZrbIzzL+X0cZycayo9tMKbs+fbzNKm9BF4bTDkly59///c?=
 =?us-ascii?Q?NTY/zfGd+NPGiSVjIjt31wVYQzVYOQfYSmB0GiIzrX3+b+MSO3alCfU7M9CO?=
 =?us-ascii?Q?y2J88wBVz1+cS08gzfwgva4AGGE/c2hvI+nh0/DLeX/YBSOgUsGzF8Uagbs9?=
 =?us-ascii?Q?PYiBsAL2qctpaycMFl9sQZ+C7reMTXUP4FA70WbnZmwTT6/fQHJb2n1SzYSB?=
 =?us-ascii?Q?CW92o93N45YQlt9sg12AC5JVT0VhXVzvxPbG0D8a0N7ic2VJ0Zzri1gGQaG8?=
 =?us-ascii?Q?puaqj74s20NRQpTdd+ySqcteAmGBtJiaBdyzfv73IYjmc+AjHkSzCmkI2JXp?=
 =?us-ascii?Q?kOCwDGJJzcg9ykRKtDU9NLnzgQlEOPWWdj7iws4a+wNlitODuwPZ3KbBoo9+?=
 =?us-ascii?Q?oQ84sn7DNSUb7ukbdFwfpitOjcSpvYxbQ6fjF9swIFFuaRZH3ZDEgVK5TWZO?=
 =?us-ascii?Q?Drl0KkWCyyxyHccB54SWTN3szRgoT1wOy958CDIK9cZqMHeU/L82CQfwPqwL?=
 =?us-ascii?Q?ZZfx2q+zGt+lFGnbzDLjsnZwuw6DXtTwfZ/DYEV2BoHmf9ILyYZTNFvuhGSd?=
 =?us-ascii?Q?vlE2f3y66wLAeizOgkuLFaYZJrnTUmf7+/btaivt8cWxeG5QEpqIP7312qVY?=
 =?us-ascii?Q?9u04Kqj3u3ipnXpT+7QSwrN1zSQosZ6somPH+FIzqh2hPx+dfM64IvfCXNgq?=
 =?us-ascii?Q?sElwG7Zh5zE4KecNHcN4aEH/KQUYhDp26onB9XoDGN/Jub+/cqX1nov5ekRD?=
 =?us-ascii?Q?JP5ltQyk/02E2C/Pr4obIXg3j0rbhZvrTiU9s05Cn7f+oyjsaQOS0KQluXuV?=
 =?us-ascii?Q?tSD/XEx27q9b6vnEDMxub82/UV5TB84Z9SM0SwjB1C3GJO5owJMB4vvXoaGz?=
 =?us-ascii?Q?HheUQLNrdlNIhpGI6FwUJbYQNm8pgnVINc6ugmtuXc7dVC0UFGhWLHmhyZAN?=
 =?us-ascii?Q?bQboyS/m0s9InqM7poXk5ySFMmy3Wil9TLU5o/JrbFrGbdzIbGypHF5Z4VRd?=
 =?us-ascii?Q?0qagQ9tCAuNui6PTk/0MShGiOblSzgWqoSRyjlGpd4Azuc/fGYwI1wxBZXeJ?=
 =?us-ascii?Q?9WVrg9KMzRe/OdLUxZCedGbB7mcdq6KqfK5Os+SpsCBy6cEXfV/3vV92WFve?=
 =?us-ascii?Q?wdKPHBo2srA8RSEbbGf3gf9bTgjXoQaUgdK+/WPkIq7ckdx/NptCy53op33v?=
 =?us-ascii?Q?o4TDstnlGnA/6QqaW0a06cJntwmY47mwM5Lm6OtSq7btem5iN3CUi51L6ESo?=
 =?us-ascii?Q?UAcBYABYQyGf6kKowNu/wKk9BqbT18xQFUzoeu5mLlbJpwff2cnqWG+4xbN/?=
 =?us-ascii?Q?bdX+LIV08UH5SmbwCBiXSdhSfkQfNeZ/MjLX1GMXHTCydMTWcRq8oVaiikRX?=
 =?us-ascii?Q?EX6RiZ5l7tGGk1kSOOdKYPPO5mLOmWwa63GaRc85MqvAl8jU71PtszxagjQo?=
 =?us-ascii?Q?UzsLdIlRwx91ojMf/z23bGw+H244eZzl2zi276ZjNOALrYwCBOx4ksMfM0/k?=
 =?us-ascii?Q?sm0XG/3Jd0ilnAuF8VqF8KhLqzUT3g4SOC7e51vDspgB5bU3QT1BsgBGMcDw?=
 =?us-ascii?Q?Nef6+Ta0dJtl6F2gKQ7m0cWG+pNoo4fgTuOLWDfohhNnGdC4AkgHh4ZXiOD5?=
 =?us-ascii?Q?67lTqlkyvPnuKfWFlUI64b9gQOXGrEl+CkYDOONNmG0S660mQri5xO29l+6W?=
 =?us-ascii?Q?Z6tni66DzwrGFaFLGUwVBZyBesO4kErSCqB5kFYA/mdj83Hl3g2y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6ad185-ee70-4911-9ac2-08df1555e7d4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:24:41.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DGVCy0/0Xg9nDiwHFknPBO5m6+I3qYs4LRz35+yMJCNtkRRzZ3NrU9CNH61c5MR0J8ygUen12IimZIjg8ghMKV4X/3xL+83NX95HYfHsq2qQxEQ7msXBUX8MDsbleMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541

From: Wei Fang <wei.fang@nxp.com>

This patch set adds PTP timestamping support to the NETC switch, so that
the switch ports can be used for IEEE 1588 PTP synchronization.

The NETC switch has no time registers of its own and instead shares the
PTP time of the NETC Timer, which is a separate PCIe function driven by
its own driver. The first 3 patches prepare the Timer driver for this
role: tidy up its 64-bit register access, drop an ineffective reset, and
export netc_timer_get_current_time() so the switch driver can read the
current PTP time across the driver boundary in a race-free way.

The switch redirects PTP frames to the CPU through the ingress port
filter table (IPFT). A few patches harden and simplify the existing IPFT
and host flood handling first, then enable the ingress port filtering
lookup by default so PTP filter rules take effect without extra software
tracking.

On top of that groundwork, the switch driver gains RX timestamping and
both flavours of TX timestamping. Timestamps are carried between the
hardware and the driver through dedicated switch tags: the ingress and
transmit timestamps ride in To_Host tags, and per-frame requests ride in
To_Port tags. Two-step TX matches a queued skb clone against the
timestamp response echoed back by the hardware. One-step TX defers the
Sync frame to a per-port work, where the driver reads a fresh PTP time
and writes it into the Sync frame's timestamp field, then programs the
single-step register and transmits the frame so the hardware can add the
residence time to the correction field on the wire.

Together these changes let standard user-space PTP stacks drive hardware
timestamping on the NETC switch ports.

---
v4 changes:
1. Patch 3: read the PTP time under a module-private timer list guarded
   by a spinlock instead of the per-device lock, so the getter is
   softirq-safe and races against Timer unbind are avoided.
2. Patch 4: initialize ipft_hf_eid in the common per-port init path and
   shorten the related comment.
3. Patch 5: drops the rollback. netc_port_set_host_flood() returns void,
   so the upper layer can't act on failure anyway; just deletes the old
   entry first, then adds the new one, logging an error if it fails.
   Commit message expanded to explain why the leak was harmless today
   but matters for future IPFT users (PTP trap, flow policing).
4. Patch 7: rename the tstamp handler/queue/helpers consistently, use
   64-bit jiffies for the timeout, track RX timestamp validity with an
   explicit flag, reject PTP v1 on TX, and check the tag type before
   dispatching the two-step response.
5. Patch 8: rework one-step Sync. Replace the reference-counted onestep
   context and its skb-destructor scheme with simple per-port state, and
   drive frame completion from the hardware response frame (To_Port
   subtype 3) that echoes the request ID, reusing the two-step ID
   allocator and timeout work.
6. Improve some commit messages.
v3 link: https://lore.kernel.org/imx/20260831082335.1184605-1-wei.fang@oss.nxp.com/
v2 link: https://lore.kernel.org/imx/20260808032146.2335723-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260728104548.3301214-1-wei.fang@oss.nxp.com/
---

Wei Fang (8):
  ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register
    access
  ptp: netc: remove unnecessary pcie_flr() call in probe
  ptp: netc: export netc_timer_get_current_time() for cross-driver use
  net: dsa: netc: use entry ID instead of pointer to track host flood
    rule
  net: dsa: netc: check return value of ntmp_ipft_delete_entry()
  net: dsa: netc: enable ingress port filtering lookup by default
  net: dsa: netc: add PTP two-step timestamping support
  net: dsa: netc: add PTP one-step timestamping support

 drivers/net/dsa/netc/Kconfig          |   2 +
 drivers/net/dsa/netc/Makefile         |   3 +-
 drivers/net/dsa/netc/netc_main.c      | 187 ++++--
 drivers/net/dsa/netc/netc_platform.c  |   1 +
 drivers/net/dsa/netc/netc_ptp.c       | 849 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |  67 +-
 drivers/net/dsa/netc/netc_switch_hw.h |   5 +
 drivers/ptp/ptp_netc.c                | 136 +++--
 include/linux/dsa/tag_netc.h          |  38 ++
 include/linux/fsl/netc_global.h       |  10 +
 net/dsa/tag_netc.c                    | 228 ++++++-
 11 files changed, 1402 insertions(+), 124 deletions(-)
 create mode 100644 drivers/net/dsa/netc/netc_ptp.c

-- 
2.34.1


