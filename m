Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFADF606A32D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 02:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gooyWXTt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJX486BFwz2yvW;
	Tue, 03 Nov 2026 13:06:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793671576;
	cv=pass; b=XlN39slw/YjGWtToh9oVXDNN9k2ipdZB5QLIYq+ryvp4+9CIuAQDzUWnsKBXX2Qxl3DKXUKRLzylgWqw5it/GB7zfXj5dR3y9mYbzQyK2DAG5xsmWd/1MtLYDxifOcT+pymaF8TaZbur0q19eytwkpJLG7VAoMX7uUNkjucZwxADcQV/++Bhnq2/zjAU7VK4D4cTqxrKrVMWHua1AWyPBg1ocJwdlYNFcDUi+WwUPihZgleHfXIWn7uLdEa7n+HpMdZEf/akD6tbQClDFzNXjeWZU2YLGMeHgnSYPPJmu383OXtKwDHhjbV+swCzWr9XlK4gVRD8srKNsuu0zWtK0w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793671576; c=relaxed/relaxed;
	bh=E3XppRjfL4rtNtpp7rgHnU84uamR3aU6tEhFDwA9Om4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=meyaqxCmVBy/I3SNite74poSMHdJHu6BIXEFdA6oCBhuX4FpAbQU4cGTZylG+rWpzICPIFXBFABRQQEab+CP6apYkb43cYKlVMuDjH/ySAxlCYHeqdK7FlnRSY8y4AeR1BIRIixASB4+lvGtmEx8zgS5K28paI7dWq+eirsV+i4zt+9WNsDig0D3506ZbRaWhIR9NPo0+U4Od8+KntXVKukREx8B2nBhOvuYhSj3BXapeI3+X4znaowbq1HFbJe6rI7+6gz9er6hFdnQjoh5ADNHUBd3TfdB5Pb6aVrW4XNsxEoAmzDbwWV9VwI3ZAYoe/TyQ9leJrYkQkQcjUBblg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gooyWXTt; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gooyWXTt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJX471Kmcz2yqF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 13:06:13 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4luMhtBQDyIjbsXQ6GbwMWkYi/kd03yoL8XZNSLcVAjMXfSXTp7DY2uxsnNATQt7TVsQIZ1t6i6p/ep9CUHFJnIW5fx83Xi+WNTXtgQQ9il+IfHU5bE6m8zi8AMpWGrhFydg9PQnp4OXDPR4ZopuQEAlXh4NYikVLa6aUgWb2NNbzEKTnIHA6XzqQxw59vyo/ZXEZwvv8+IJ0mWBeGraXhN3O8Cc9EBlpQrlNFM4EZt29U3gPeNYPLCGzC2YVpSNh/MdjfLKsQXKPUoINRhcVSAI2WKzKw2em793OzT+reaZ0Kra0dJTlB59Y1v2ZVUJ0mblDyduRuFlDbNXdOLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3XppRjfL4rtNtpp7rgHnU84uamR3aU6tEhFDwA9Om4=;
 b=iiUw3kqrbJwGuhC7q+ftX9SncagudAhbYRU+QhZl0/nsVJbGZQms1GtZFc4jNv6cxwgVMimJvIF0TbsgqbBe9ZU2velXGA0Yo6cay9C0kyCjUCg4FWCBgpI9pIJe1X1fi7lbrZivL0x6ilNz9yVaWVP2JJKnLJAsOp3C6TlJVrCpl7viSkO1UvLllbkVXMPv3/+S+dqAZI643EE2Qxs4m5vpuM1QuQeNIvu3YvtPA59XQOnYKOEtw3Q/LQ7A7AyJnuQ+RtMMQZ1YhEuFhVsAzacjro4bMvZpxDyv2OoBTBJS3keI21iM1rzj4jNO1jdc6JyJEYW3ul3pcZSoswX70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3XppRjfL4rtNtpp7rgHnU84uamR3aU6tEhFDwA9Om4=;
 b=gooyWXTt9n1li9rb/iNxA8p/MzzdbPP5qS/nTKyRNe39SF0h+iIQOQtGFZsucsjjAoC0rXEkVE5k2ITXq8C5ZL3hShkkcFiF0H6ioHtZb0a3uu+3Piy8Ual3+rHTLplTEOpc2hntqwwMxpU+iKisf6kdhJPoTpMnc0jWle29tK5lGBJ7jwL3NVSK7cLh4AjjdoDRMt6+iriAXQ6oh4hnozTFZFCKrUW1D5H30upHCtE/hKG2emvtMk8I/05B60RcVsyip6eqghseBoE1IXU2ihSE+eoH5JQ5dfB4IJMAkhbVB+kZrHv1IOZVEGMJpl7+nOAz/Cwwb0vd3dIxRr7Psg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM7PR04MB7094.eurprd04.prod.outlook.com (2603:10a6:20b:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:05:49 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:05:48 +0000
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
	linusw@kernel.org
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 net-next 0/9] net: dsa: netc: add PTP support for NETC switch
Date: Tue,  3 Nov 2026 10:10:15 +0800
Message-Id: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AM7PR04MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e139151-c48a-45d4-9c0b-08df394efa6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|19092799006|921020|261021123027099003|11063799006|56012099006|261009223027099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|10067099003|18002099003|261102123227099003|6133799003|261102130727099003;
X-Microsoft-Antispam-Message-Info:
	GQGIGRUu831LMCW9Rs/D++PDW9fvgYfRBNfyr9eh5GBFUIgmxq0dn2+kR+H+Mx/gfp+DM0JhBc72H107O8U1qO2bHdkLaK1LNzIBlHe8tz0sbt69FQPQ1ujcbNEtABmdypJrg0grkq8cyahSnGojiBLF4L0R6l+MPd1sJH053+yGxpV36p+xXHftVohpXf0yek2ccQf0cz06koPaA/U0ecZhRa7HnxO/8S/mAoTsyH0dGWIL7XWL5bHs+HpjUnLUhjpaEna74FRtX0qorUGal7BrmnHnjmDD8sDiQMdTSssjQx+N4yB+HZUGxcXUdkk/MJbW7SBNbhtDsFy2l/UgFK66zwWCEP0LNelQmjvSk6TBrsKnQDkb0qoPPXq3pQM8LGPZpkzQ0SdU2tOPGpjVOZ4GZ70GHIewzr+hMtyVqCP8tPFoopcR1tCrKtDEQyJ73l0oA+Zk0gHB93YbCmfIks8KmV6W04kEW6T3NfdK1TYwBDReM7DZUjoE9bwD4syATB5DCeAaNsY+4Ng+fhFurZ4Is3lG6uBdPN2KMWkSs7hFqXyQmTn2stB69A6gafaR5qLeBVeRCmq30Z7+RKfVQ5tlzuUtUy2ch89pjHsQsrLoNkvPSZ40fE4Up2F2Vy9EsP1FljnQmmx4QrWo2+x4XLBSXFXJJnB8NC8DI2LP35k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(19092799006)(921020)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(10067099003)(18002099003)(261102123227099003)(6133799003)(261102130727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AXJcPXqEK1eSHoiTgLMVzhiv2YomLZUNKwddW71yK9lES5T1W8ehxKJ0N01R?=
 =?us-ascii?Q?CB3V3NC3KVJSmfe0BTwOwawtVkYAHnLgPdyAZb8AzAXZFxTfl3uEn7iI6/qY?=
 =?us-ascii?Q?96Shwx+5szjfzj3pSMdYJRsgHcLSVEwjsjHbExlKotk+mTxgE2Gqlmr8MWPJ?=
 =?us-ascii?Q?gS3k8t3ykS4EhNxSn1ZJH/3/91i7ZsvlmeGlOgh4+QqVnorNUl0vhCGA41U0?=
 =?us-ascii?Q?+si3wr275ymLQ0LMOutMh3Dz9NXP1RkO/KkWYOmpMQJQ1Z0iolaKds90N1/e?=
 =?us-ascii?Q?ShgJ+WZxJXE2qasjyzKwuzNmbhOcP7nqznuq/sy5+xiy69iBVK8yeTi4TR34?=
 =?us-ascii?Q?DtHf2HCwacDjxBsbgyFqVEDEwFKrof443t7ycYiCnWpzUGhkIz2yybSM3bBf?=
 =?us-ascii?Q?1Ri6CCa0wIuvXMoJmyWtyABPuX06KZhbzJEAn1BciP2xgdqcwCechhlWNFqV?=
 =?us-ascii?Q?3Kip7mzKADlmP82Welwm0TEIAHgu3tQU5x6ks2WxXEwHjH4Xe84BfcLVbgLZ?=
 =?us-ascii?Q?67rJ8gKANF+LoPOsY6W6UeECfiFA8Dc5v6rq4y/iu4gl6YIBHIYAQ3BSBJbb?=
 =?us-ascii?Q?B0TPKoM/lyijMTeyenVcr5GZPkiuQVb9bTqbkQbg9gRIVwFeFNGTuiuDfeID?=
 =?us-ascii?Q?YEWEMRnCuPIycbz2GDbuObfjClLWHhIMGyDoPoZnWtJx1tmN1SGlLPEblExJ?=
 =?us-ascii?Q?5e6bNT51IQPEZ9oMzTMsqrhUs/WpZATqn9QYnvdzyKlLfufazkuI6jEFD0pB?=
 =?us-ascii?Q?BvRWihigrlkE4lBaiZXawjGw4WZnh9UwlTSIDGl554rERlfKqb1QGpXlUWWv?=
 =?us-ascii?Q?YBOe7IHkVpn1i9hgrNoIrULz4NqNquIofM/eSTIWeH9Ss59vW6r/CK6vhYeT?=
 =?us-ascii?Q?6Xps+48XNAKiBlzn2dR5FnakI+I/TNhmJ1bcLS+K4xssnt/3ow5YBv0eFF3Z?=
 =?us-ascii?Q?LIoRBiJeGoCInPyFLIA2HoI0Gddw9fX5PFYkOUt2dWjJ+NmXpWotQg5z3Czr?=
 =?us-ascii?Q?dvjEZq6h7/6Yxy0EYW4ANdTMlS20WIXm1ScYVXUWDscB89IoqaCwS83o/JGC?=
 =?us-ascii?Q?kfTslQvBEGl92Tigtqk7z+mOEnI8rR+y/s3ScR6Mp9Vp9O8qqhZcq7/lGkUs?=
 =?us-ascii?Q?H12mu3oVeUQWnuY7CjO0yK79dJctCJJjhwVROfHZwZ0j+7efieMj3bZSZaEG?=
 =?us-ascii?Q?Zr+DxxPxTOIi73iNE+cxN+glyRgP6I5wxYdfMxNeD4LmW8jTqD3k1rYujvQL?=
 =?us-ascii?Q?C0q1KUkoOLMQqKA3NE1MvHGyjwIsxkhar6jV6iMoT1N2t217KIrlgi3Q+4zk?=
 =?us-ascii?Q?BA8Oc9kFujJH9B2V5G6JlC1KzWGXgZBMW5HIh6m2by9hESGKEY8IZsK6+lb5?=
 =?us-ascii?Q?kYo4uck84N+QCL/KYO2r1699uYwgkJP2lkbkEd4Yf4y/lzjwv9qGKqwut8cq?=
 =?us-ascii?Q?zOLWT00VELtEcOBknEkrGDc1lWBIrZVIl5EkvwDVsQwP7IiCE36hH9UWeY5v?=
 =?us-ascii?Q?NtE5WNMsodvRgqNNzhbzdSoSa+cRJkLFTUMn4VCFyUps1z6FWKenS7KEFou+?=
 =?us-ascii?Q?tx0v0WbXshh95ZuAARqwcELKzBMgUPRp6fSi7b+MoB3bxRlOOs+NJHLdogwh?=
 =?us-ascii?Q?0aMJSMKtDvwS0jF4xre/wsrf8+gsplxTk0ZU+FQphIzBuLsG04Umqyc3YlYG?=
 =?us-ascii?Q?4Wd9iUhOsSZUZzxgZ8rGlTCzw8HQiLBL3rjs3iT71Gpd5E6p/7oP1tuFQgPQ?=
 =?us-ascii?Q?lpIsxvp5/+UG73U8erfWeRqcua8UWcIZR5gKh72vm1FzXaWJWNlD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e139151-c48a-45d4-9c0b-08df394efa6b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:05:48.7997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRlt7EeQ5nkwJx6Pt7KqgXOnQmyYnkN2+aJML65qrlIiVRD54BTL6VSSHzhMkLGe6VC/EhUiYeHF0mSsxi734x31CoI+XzYSMJel05MmWB8C1M6pluIIlMO0vXTZH4UQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7094
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
v6 changes:
1. Patch 4: keep the FLR in netc_switch_pci_init() and skip the reset
   for the first setup in probe(), use pcie_flr() with config space
   save/restore under pci_cfg_access_lock() for later setups instead of
   pci_reset_function(), to avoid a deadlock with the device lock held
   by an unbinding switch
2. Patch 4: use dev_err_probe() when failing to register the EMDIO bus
3. Patch 4: clarify the multi-switch DSA tree setup/teardown scenario in
   the commit message
4. Patch 6: add a comment explaining why -ETIMEDOUT cannot occur, and
   document the case where adding the new host flood rule fails
5. Patch 8: set np->dp only after the port is fully initialized, so the
   error path does not touch uninitialized PTP resources, and pass dp
   explicitly to the DT/MDIO helpers
6. Patch 8: make netc_port_ptp_init() return void
7. Patch 8: advertise SOF_TIMESTAMPING_TX_SOFTWARE in get_ts_info()
8. Patch 9: use get_jiffies_64() and time_is_before_jiffies64() instead
   of reading jiffies_64 directly
9. Patch 9: reword the NETC_ONESTEP_VALID_WINDOW comment and clarify the
   commit message about the valid window check
v5 link: https://lore.kernel.org/imx/20261012095924.1129312-1-wei.fang@oss.nxp.com/
v4 link: https://lore.kernel.org/imx/20260918072852.501420-1-wei.fang@oss.nxp.com/
v3 link: https://lore.kernel.org/imx/20260831082335.1184605-1-wei.fang@oss.nxp.com/
v2 link: https://lore.kernel.org/imx/20260808032146.2335723-1-wei.fang@oss.nxp.com/
v1 link: https://lore.kernel.org/imx/20260728104548.3301214-1-wei.fang@oss.nxp.com/
---

Wei Fang (9):
  ptp: netc: use ioread64_lo_hi/iowrite64_lo_hi for 64-bit register
    access
  ptp: netc: remove unnecessary pcie_flr() call in probe
  ptp: netc: export netc_timer_get_current_time() for cross-driver use
  net: dsa: netc: tie setup resources and reset to DSA setup/teardown
  net: dsa: netc: use entry ID instead of pointer to track host flood
    rule
  net: dsa: netc: check return value of ntmp_ipft_delete_entry()
  net: dsa: netc: enable ingress port filtering lookup by default
  net: dsa: netc: add PTP two-step timestamping support
  net: dsa: netc: add PTP one-step timestamping support

 drivers/net/dsa/netc/Kconfig          |   2 +
 drivers/net/dsa/netc/Makefile         |   3 +-
 drivers/net/dsa/netc/netc_main.c      | 399 +++++++++---
 drivers/net/dsa/netc/netc_platform.c  |   1 +
 drivers/net/dsa/netc/netc_ptp.c       | 898 ++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h    |  67 +-
 drivers/net/dsa/netc/netc_switch_hw.h |   5 +
 drivers/ptp/ptp_netc.c                | 136 ++--
 include/linux/dsa/tag_netc.h          |  38 ++
 include/linux/fsl/netc_global.h       |  10 +
 net/dsa/tag_netc.c                    | 228 ++++++-
 11 files changed, 1617 insertions(+), 170 deletions(-)
 create mode 100644 drivers/net/dsa/netc/netc_ptp.c

-- 
2.34.1


