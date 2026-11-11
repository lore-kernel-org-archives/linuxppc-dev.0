Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A99D606A32A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=X2+7+pLW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPYPl3xn1z3bcJ;
	Wed, 11 Nov 2026 17:23:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794378235;
	cv=pass; b=ifdZM6sxkDN2PFhiJPc7yXrd4NGva8ezQKNt+0bSMQO/lkBI/j+tEJIbbfHGAmhcHJQkxQU1lpACjPZhxpERoUiPEyx55Gr89Xo1h4L+spWiEw72r6BrZH+iepZcFIG90XFJzQvH2w6m2YA5U0dJyaypj2CTY4c6yIQcntML7hdDAakcRAMIZtLbwvcY4CIYxmDMQxqi7YewJJksG9tMQCBYS//kwKFDD02m3SiPWazxsIQCgeMMbddBlDljY/AR3nnd90Ct1vTNTkDMNKb6x5QuoQrfwJaYM9VPdAd8XQJzMaln5d/GmG+mzzEDAqnK9R005yb/ataQbRwPIj8GEw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794378235; c=relaxed/relaxed;
	bh=ltsHNA/PBh1Trs0sh7wiHbOaPSiojF0Xtxlyd5p6KQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wn3eCDPHdCVBqs6ZxOsJKquWVyX8jgYORUaoJRslmHoxMusoB9fmB7XkuXv/Q9gvLYxpJPGr2T148YFEUnKUR5jwegV5hO+9aCu/4fc5ZDryrq8owPJtyU13MNyBy/V5eG8lHMqmssFBe9lTZNGLyjBIL/Ks+sEHB+eTQd50m8HUCMx/9REOnSVbjJSRIH3ezsFraLteS50yhJO9z7bNd1SlBtQjvjFbi/0/87r3JrmU03ynQnbownOSw0qvISS06listzkxyG4EkZCnceovIp0Oo5EvjLEXNVvQAfRJnq1IuzzLrUFaYSUHERBCivC98nErVqjHKek99YIX8Ow+VQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=X2+7+pLW; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=X2+7+pLW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPYPj4r1nz3bf8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 17:23:53 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KD5UEk/i+4GypeK64bHszD6bT//PAvRdT65UyOjPB4/+kUu3tFvSsJAorydJJS+Y8tUXcpcqI6ivwMVqD3mq5lXPWC08d8MvaapjXeOpp+VuuPuJRKsaEx3UFACQPaG2zesinhgRlkFM4eX5mJj9N88kz3GnzfeZuramonNyMq7E5gQZlg43Kd5tnyDB3jkfdRnhR0DzYiWcOBCMXYjwBJnNvhJ9DQAX0ie2l6SAjPS6CSrU6mwVp1KC55K8rXP68HxFzeUDK7p0Xr0NILzL3MLmmiYf7InaVOv2PoYdYmHDQKf9IbaT+Mk1EMNTvZbMTNnrSaREi5DQpGdD/BZFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltsHNA/PBh1Trs0sh7wiHbOaPSiojF0Xtxlyd5p6KQ8=;
 b=JDZ2FI4+NmiKndG3OwMAZM5hVJzADD1UYdwTk2zaNRBOLcDp2XkXWl1L9xNQdgcV7HgTrPFtqqZf2yiXAS8Kk6l6XmPSeligVlLTNPthnKLVlXXTUgwXZtYeATRnncvNUZ1jbMjAQDZy4cM8CyoVqMQyIEncMmUkiB7+X3HTGG4MIDnhyVON/K7ceFWG8gH4JkEpcBYLyUHO+KjS+/zDcCAKRuIq5rylQDhQ7Y87Zu6wVvy6U2a6zMb93aP78F9GI+ZK933K6ufJSgxAbFZq117Q8xT3m97lNS7csASQzv/pNvwQhSVb9tFIJ4xpZpOFzw0sofl/X36FFq1j/ugJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltsHNA/PBh1Trs0sh7wiHbOaPSiojF0Xtxlyd5p6KQ8=;
 b=X2+7+pLWan/ZCXdZ0VYZga8TpyeHWcRDNpd/H54zD6vVULbH89rFAy79Ht4SmkRwB4RCwqv/AKJORIXKS147OcX+i1iQDkWKvfpwtmENALks800g9DtT+OI16TgDH9GpkyXOspNhTmmRN0cEEj1Fg3ylOj/YAcYW8Ce+IF7vXnDMXhtZdbyJWlKaYQU9Zf9XeZ3O/yxo6E9ms1WWYdCNCM6B7p97wGWTZgA29x8iezeZrJaeHM0XojhyLycoh8WCPfJxJ/mRbGqXzSoGtb/IuIpXQMgXW7xzn+yA9eO2u8Ol4BUuZGYUitMqAPT2v2ZgPXO66cSlOwJDoyqn8Y91pg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:23:51 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:23:51 +0000
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
Subject: [PATCH v7 net-next 8/9] net: dsa: netc: add PTP two-step timestamping support
Date: Wed, 11 Nov 2026 14:27:52 +0800
Message-Id: <20261111062753.1397582-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
References: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI0PR04MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e51466-5521-4a1e-d860-08df3fbc5a0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|921020|261026130827099003|261026121527099003|261022113327099003|11063799006|261026140227099003|261102123227099003|261021123027099003|261021130227099003|261021135927099003|261009223027099003|261021121427099003|261022115727099003|261022105027099003|261022075727099003|261028144727099003|56012099006|10067099003|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	/qvnnU5TYPFttFgGjczc1kKNsjjCSw2BwYZo62uzGCCUjqnqt2CIbUAb4ry7B4/krKmrt0HmRrgtyIh1K/QDgQ0saUODKsEgrLWllt+8bk9R/PYpyEO9sdLs60ryy2UJDQvy5roOJ8Mqlp4SMa20RK8qzvcrpQoE9mGVZvTALCNbARNGMaR2a6gXBelunD5xlg7kdMP8oJ9yZxVOT3ew690+1z0RjdxpGEkcpYTyeIopM0S8EzOWoc6bRDEgmHZ80+o9vH4OeakzrIx3Ggc+mUJ66dQNBz+RMkO0LsIXwmV32KnInDqAwCynBGqNrX3btSiLUNvafV4puuvm+hh2b/TUGqgzLpuJW5fuCSSpJPvrBbG+7dyQU2tCL9mHSJhrlMwBwJt6CW+mgq3SUYll6uwIspyLSnqnh1TW7LwVhpzImjEpPhqdRMYBbzkkrQkxdxE2iQJZBbOsJHUaZzXztnWkMp/5x6ybSR10xSVkuzcj/FoD4Zbu7C2EisKxlhmdnZuENzgy6p8bYdHGFs2SBTGCtf/TQ8mv4NvGQAxhuNXkxrl0e5ZpnJ2plaDTO8RqXryF4eiNBn7bBCxM3j0t3PAHvqR2Ts7kRg6aIz2llKxnqc+/vokaWWkGYol2Cbr3KWNfqFxL8jTa9edIU9Dr/N00QNuzMt9EYVy7GNuE+1AS9o8DwUaP+jOcIWBd8fBHjNK6N9USq3X7+hNK+0a2lg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(261026130827099003)(261026121527099003)(261022113327099003)(11063799006)(261026140227099003)(261102123227099003)(261021123027099003)(261021130227099003)(261021135927099003)(261009223027099003)(261021121427099003)(261022115727099003)(261022105027099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TAkOfDYDbNdBxElc8DkMlble1iRrLstgFzq4wFp80XGl0j9u58enTkECA+bA?=
 =?us-ascii?Q?ICcSmt61V3VtI/g/MI2AYH2k2KKDSc2FL63fJq6j0SU8coSbBhHW57xyYmV7?=
 =?us-ascii?Q?/ujfyPKmWCeqEyGRHivQPJcEB7y0NjRJyjSJjEmzvJTrsQAqi2lBzSpEPXFZ?=
 =?us-ascii?Q?/qp2fMvgALNkf9O+y0khVvRVEH+UKpZnXhwNgd/ftDLDUucOa9zqgq2iLvO3?=
 =?us-ascii?Q?tHB5dxU8ptKndXBfcp6OTPhDQdb34v/XSkjXR8938g0+SmbZ+JHmsI2vdgOl?=
 =?us-ascii?Q?DrOKmImV5c+12rY/VFxyY/bhZLeXcEhxPYnolULF44TyL5pY49MRhyd1K34S?=
 =?us-ascii?Q?RK2gM2XUYRqrxV7SsKza2TM/uVDhk9/lzSKlCh7du06ij93w3IwIbWY9SD/C?=
 =?us-ascii?Q?xx8AjaeN+UIcS2ZSpk9qN4/NyaJ0/HlmMeGgNl6mN5fzB2Cr71OMDnH94eP3?=
 =?us-ascii?Q?WV36xLw3Y2GcR0PKi+lS9C+J9+hqz/Rf50Wf4E0rVUwu+4p4KCsOymy+0RAf?=
 =?us-ascii?Q?9LJxvmlNdlMFbS6StBf00UQ1QpxTfdj5cS4mBmSmCJ1SAQv8Txc974fkq1Dr?=
 =?us-ascii?Q?JeNtGTAQlKsYEqTFxGlXrTcjmbNDO2bKmhvFpNun7vw1lpBvLHANZ2gY+E05?=
 =?us-ascii?Q?MLl4t4FPFnlX5cqevM9lwMZZaY1dqkFYu1VTkFpk7KnZi/14FTafBUlqvk4t?=
 =?us-ascii?Q?HUauqH0M5+6G6cKEH1hEKcXH3XlHKagIRAckMw1q99Rp0UnbVhelv/zZlhLM?=
 =?us-ascii?Q?LBagU1Z91MYW+YcD/PzErnrnJmDeP+9YqJAmlER8Mp37JI04NLai55k48ZEy?=
 =?us-ascii?Q?08KMqMJ1IS00LQWxSUO37Q163NAdtuHVhUrl8DQXRV4Dcz2XzuDSI6Udbg47?=
 =?us-ascii?Q?xHXpi4F/mMznGGOfLC2n9LBE4daairxdiIGhqLfidhzQ/NkJZkYmdXhifrdY?=
 =?us-ascii?Q?okS8GfxWBcLwyRJn2XF2cRvlWh8Vu2SS728Hjb6DLrVlkSKaPQ2vUvTF/n+5?=
 =?us-ascii?Q?/okmbxz8eYsC200LRijR3tb3eC9V1iZbajdqdXD4fz96MUvPZB45cvD0s1mJ?=
 =?us-ascii?Q?8spI/+S+gc6TOngcPE6pG0KcOcSeOrAm757YQgm+ydL6whaJgTqTZhDktteF?=
 =?us-ascii?Q?Kqrk/6I3Pi30DXMOr+KoHbUwL4WFUrIcQBw1bfhXAJ9wwriBnbbfSJYQla99?=
 =?us-ascii?Q?l0HXg4O1WOsGBV9CJuTAtnne2wOeMSosGP9ZQ954x9o1BBUPt9AwzSqgRyfL?=
 =?us-ascii?Q?b/QIfEkrdWlZ0UjinQrruDc9fuQWxj+GOoY5XkmjxHo0FFWFl5OAN79q2ens?=
 =?us-ascii?Q?k1miGZeUPTHyL9FH2PvPKW9L8xYJc56orVJhNgl7H5Sj0m4vRl3TmFxb1HwH?=
 =?us-ascii?Q?BzoTvRf6TWYKFT6oj2/J7kachpk0qkk6eebCNFFA46X7MIz2F9ZY7ywe3UGc?=
 =?us-ascii?Q?cWWcir5jNP5pXgTxJky+NA6O28gxOUoV38aFsJaYp7NjtekrxgMMLicV6Fb8?=
 =?us-ascii?Q?kj/tNXIcQWSlkXbrK4vzReGXcwnjYdo/zua6tfWEN/vAdxy8B/nIRNnr2Msx?=
 =?us-ascii?Q?dBZNI0Nlt97zVtc+NJQ9pb6bSmZWfql1NIyuzJKH2dNqNjlQS1k/c1E98nux?=
 =?us-ascii?Q?Eqd4i1zUiLJhruAn5TyaoEYFTZDi82970CQD6R887cP1/ScahBvaARc27MAw?=
 =?us-ascii?Q?Vj8Swr9GaDlj64hEBP7XPZ+1E5Py7Kue3QXwdUwog4ONmDF2VhdFrj499pJf?=
 =?us-ascii?Q?tPV1pZS+Me3bw94FQHELQbpVy12u81RkqoZx1r+nfC0FteCOrBXe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e51466-5521-4a1e-d860-08df3fbc5a0c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:23:51.0408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fzc9I8xpHUxK0BBt1KosItKRAwQQnNrcZUGK7XuXjJwHrIWtZmDi3WN1lo8osjW6sNTvUpTXRzhZeDbG4+YkZgYuCr1PCoJBrn0jGB9F+1EXdKNr+E1FiLMWsHzLhO8l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

Add two-step TX timestamping and RX timestamping for the NETC switch.

For RX, install ingress port filter table (IPFT) rules that redirect
PTP frames to the CPU port, covering L2, L4 over IPv4 and L4 over IPv6
according to the hwtstamp rx_filter. The hardware inserts a To_Host
subtype 1 tag carrying the ingress timestamp, which the tagger extracts
into the skb control buffer for netc_port_rxtstamp() to report.

Track the installed rules only through the per-port ptp_ipft_eid[]
handles, and let netc_port_hwtstamp_get() derive the active filter from
them at read time, so a delete or rollback that fails partway does not
leave software reporting a filter that no longer matches the hardware.
The four L4 handles are installed and removed as one unit, so treat any
surviving L4 handle as L4 active to avoid hiding rules that still trap
frames to the CPU.

For two-step TX, clone the skb, assign a per-port timestamp request ID,
and queue the clone. netc_xmit() carries the same ID in the To_Port
subtype 2 tag of the transmitted frame. The hardware then returns a
To_Host subtype 2 response frame echoing that ID and the transmit
timestamp. The tagger dispatches both to the driver through the
txtstamp_handler callback in netc_tagger_data, which matches the ID to
the queued clone and completes it via skb_complete_tx_timestamp().
Non-PTP frames keep using the To_Port subtype 0 tag on the fast path.

The response frame carries no payload and is only 26 bytes long. As
eth_type_trans() advances skb->data past the DMAC, SMAC and TPID, the
tag starts at (skb->data - 2), so the pskb_may_pull() check must use
(NETC_TAG_MAX_LEN - 2) to avoid dropping the response frame.

Manage request IDs per port: each transmit takes the first ID not in
flight, and an ID is freed once its clone leaves the queue. A per-port
delayed work drops unmatched clones that have been queued for at least
5 seconds, far beyond the hardware's normal response latency.

The response tag carries only the 4-bit ID and no PTP sequenceId, so a
clone can be matched by that ID alone. If a frame cannot leave the port
for over 5 seconds, its clone is dropped and the ID is reused while the
response may still be in flight, so a stale response can complete the
wrong clone. This only occurs after the link has been unable to transmit
for that long, when PTP has already lost sync, so the mismatch affects
only the first few frames right after recovery and is absorbed by the
PTP servo. Accept this as a trade-off imposed by the hardware matching
limit.

Select the TX tag from ptp_flag in netc_xmit(), and implement the DSA
connect_tag_protocol() callback to wire netc_port_txtstamp_handler()
into tagger_data->txtstamp_handler, so the tagger can hand the parsed
response ID and timestamp back to the driver. Grab the PTP timer's
pci_dev in netc_setup() so get_ts_info() can report its PHC index, and
release it on teardown and error paths.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/Kconfig         |   1 +
 drivers/net/dsa/netc/Makefile        |   3 +-
 drivers/net/dsa/netc/netc_main.c     |  82 ++++-
 drivers/net/dsa/netc/netc_platform.c |   1 +
 drivers/net/dsa/netc/netc_ptp.c      | 504 +++++++++++++++++++++++++++
 drivers/net/dsa/netc/netc_switch.h   |  41 +++
 include/linux/dsa/tag_netc.h         |  21 ++
 net/dsa/tag_netc.c                   | 165 ++++++++-
 8 files changed, 795 insertions(+), 23 deletions(-)
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
index 430bd4e2a5a8..e93c15f57200 100644
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
@@ -131,14 +145,16 @@ static void netc_port_get_capability(struct netc_port *np)
 }
 
 static int netc_port_get_info_from_dt(struct netc_port *np,
-				      struct device_node *node,
+				      struct dsa_port *dp,
 				      struct device *dev)
 {
+	struct device_node *node = dp->dn;
+
 	if (of_find_property(node, "clock-names", NULL)) {
 		np->ref_clk = of_clk_get_by_name(node, "ref");
 		if (IS_ERR(np->ref_clk)) {
 			dev_err(dev, "Port %d cannot get reference clock\n",
-				np->dp->index);
+				dp->index);
 			return PTR_ERR(np->ref_clk);
 		}
 	}
@@ -164,7 +180,7 @@ static void netc_port_free_emdio_bus(struct netc_port *np)
 	np->emdio = NULL;
 }
 
-static int netc_port_create_emdio_bus(struct netc_port *np,
+static int netc_port_create_emdio_bus(struct netc_port *np, int port,
 				      struct device_node *node)
 {
 	struct netc_switch *priv = np->switch_priv;
@@ -195,7 +211,7 @@ static int netc_port_create_emdio_bus(struct netc_port *np,
 	mdio_priv->hw = hw;
 	mdio_priv->mdio_base = NETC_EMDIO_BASE;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-p%d-emdio",
-		 dev_name(dev), np->dp->index);
+		 dev_name(dev), port);
 
 	err = of_mdiobus_register(bus, node);
 	if (err) {
@@ -216,14 +232,15 @@ static int netc_port_create_emdio_bus(struct netc_port *np,
 }
 
 static int netc_port_create_mdio_bus(struct netc_port *np,
-				     struct device_node *node)
+				     struct dsa_port *dp)
 {
+	struct device_node *node = dp->dn;
 	struct device_node *mdio_node;
 	int err;
 
 	mdio_node = of_get_child_by_name(node, "mdio");
 	if (mdio_node) {
-		err = netc_port_create_emdio_bus(np, mdio_node);
+		err = netc_port_create_emdio_bus(np, dp->index, mdio_node);
 		of_node_put(mdio_node);
 		if (err)
 			return err;
@@ -277,6 +294,11 @@ static void netc_free_all_ports(struct netc_switch *priv)
 		if (!np)
 			continue;
 
+		if (np->dp && dsa_port_is_user(np->dp)) {
+			disable_delayed_work_sync(&np->tstamp_timeout_work);
+			netc_port_purge_tstamp_queue(np);
+		}
+
 		netc_port_free_emdio_bus(np);
 
 		if (!IS_ERR_OR_NULL(np->ref_clk)) {
@@ -326,27 +348,39 @@ static int netc_init_all_ports(struct netc_switch *priv)
 		 * been created.
 		 */
 		np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
+		/* Initialize to invalid entry IDs */
+		for (int j = 0; j < NETC_PTP_MAX; j++)
+			np->ptp_ipft_eid[j] = NTMP_NULL_ENTRY_ID;
+
 		netc_port_get_capability(np);
 		priv->ports[i] = np;
 	}
 
 	dsa_switch_for_each_available_port(dp, priv->ds) {
 		np = priv->ports[dp->index];
-		np->dp = dp;
 		np->ett_offset = ett_offset++;
 		priv->port_bitmap |= BIT(dp->index);
 
-		err = netc_port_get_info_from_dt(np, dp->dn, dev);
+		err = netc_port_get_info_from_dt(np, dp, dev);
 		if (err)
 			goto free_all_ports;
 
 		if (dsa_port_is_user(dp)) {
-			err = netc_port_create_mdio_bus(np, dp->dn);
+			err = netc_port_create_mdio_bus(np, dp);
 			if (err) {
 				dev_err(dev, "Failed to create MDIO bus\n");
 				goto free_all_ports;
 			}
+
+			/* Only the user port needs to support PTP feature, so
+			 * PTP-related resources, such as tstamp_queue,
+			 * tstamp_lock, etc., are initialized only for the user
+			 * port.
+			 */
+			netc_port_ptp_init(np);
 		}
+
+		np->dp = dp;
 	}
 
 	return 0;
@@ -987,6 +1021,15 @@ static int netc_switch_reset(struct netc_switch *priv)
 	return err;
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
@@ -1003,9 +1046,19 @@ static int netc_setup(struct dsa_switch *ds)
 
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
@@ -1051,6 +1104,8 @@ static int netc_setup(struct dsa_switch *ds)
 	netc_free_ntmp_user(priv);
 free_all_ports:
 	netc_free_all_ports(priv);
+put_ptp_timer:
+	pci_dev_put(priv->tmr_dev);
 
 	return err;
 }
@@ -1072,6 +1127,7 @@ static void netc_teardown(struct dsa_switch *ds)
 	netc_free_ntmp_user(priv);
 	netc_switch_free_bpt_list(priv);
 	netc_free_all_ports(priv);
+	pci_dev_put(priv->tmr_dev);
 }
 
 static bool netc_port_is_emdio_consumer(struct device_node *node)
@@ -2534,6 +2590,7 @@ static const struct phylink_mac_ops netc_phylink_mac_ops = {
 
 static const struct dsa_switch_ops netc_switch_ops = {
 	.get_tag_protocol		= netc_get_tag_protocol,
+	.connect_tag_protocol		= netc_connect_tag_protocol,
 	.setup				= netc_setup,
 	.teardown			= netc_teardown,
 	.phylink_get_caps		= netc_phylink_get_caps,
@@ -2562,6 +2619,11 @@ static const struct dsa_switch_ops netc_switch_ops = {
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
index 000000000000..0bcc01ebf01d
--- /dev/null
+++ b/drivers/net/dsa/netc/netc_ptp.c
@@ -0,0 +1,504 @@
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
+		if (time_is_after_jiffies64(NETC_SKB_CB(skb)->ptp_tx_time +
+					    NETC_TSTAMP_TIMEOUT))
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
+void netc_port_ptp_init(struct netc_port *np)
+{
+	spin_lock_init(&np->tstamp_lock);
+	__skb_queue_head_init(&np->tstamp_queue);
+	INIT_DELAYED_WORK(&np->tstamp_timeout_work,
+			  netc_port_tstamp_timeout_work);
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
+	info->so_timestamping |= SOF_TIMESTAMPING_TX_SOFTWARE;
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
+		 * hardware execution time for a command is much less than
+		 * 1ms, so no timeout error will occur. Any remaining error
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
+	return err;
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
+static int netc_port_current_rx_filter(struct netc_port *np)
+{
+	bool l2, l4_v4_ev, l4_v4_gen, l4_v6_ev, l4_v6_gen, l4_any;
+
+	l2 = np->ptp_ipft_eid[NETC_PTP_L2] != NTMP_NULL_ENTRY_ID;
+	l4_v4_ev = np->ptp_ipft_eid[NETC_PTP_L4_IPV4_EVENT] != NTMP_NULL_ENTRY_ID;
+	l4_v4_gen = np->ptp_ipft_eid[NETC_PTP_L4_IPV4_GENERAL] != NTMP_NULL_ENTRY_ID;
+	l4_v6_ev = np->ptp_ipft_eid[NETC_PTP_L4_IPV6_EVENT] != NTMP_NULL_ENTRY_ID;
+	l4_v6_gen = np->ptp_ipft_eid[NETC_PTP_L4_IPV6_GENERAL] != NTMP_NULL_ENTRY_ID;
+
+	l4_any = l4_v4_ev || l4_v4_gen || l4_v6_ev || l4_v6_gen;
+
+	if (l2 && l4_any)
+		return HWTSTAMP_FILTER_PTP_V2_EVENT;
+	if (l4_any)
+		return HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+	if (l2)
+		return HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
+
+	return HWTSTAMP_FILTER_NONE;
+}
+
+int netc_port_hwtstamp_get(struct dsa_switch *ds, int port,
+			   struct kernel_hwtstamp_config *config)
+{
+	struct netc_port *np = NETC_PORT(ds, port);
+
+	if (netc_get_phc_index(ds->priv) < 0)
+		return -EOPNOTSUPP;
+
+	config->tx_type = READ_ONCE(np->ptp_tx_type);
+	config->rx_filter = netc_port_current_rx_filter(np);
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
+	NETC_SKB_CB(clone)->ptp_tx_time = get_jiffies_64();
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
+	/* Only supports PTP v2 */
+	if (unlikely(ptp_class & PTP_CLASS_V1))
+		return;
+
+	tx_type = READ_ONCE(np->ptp_tx_type);
+	if (tx_type == HWTSTAMP_TX_ON)
+		netc_port_prepare_twostep(np, skb);
+}
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index b0e1eb462153..5a8e57b01f35 100644
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
@@ -85,6 +101,14 @@ struct netc_port {
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
+	u32 ptp_ipft_eid[NETC_PTP_MAX];
 };
 
 struct netc_switch_regs {
@@ -140,6 +164,7 @@ struct netc_switch {
 	u32 num_bp;
 
 	struct bpt_cfge_data *bpt_list;
+	struct pci_dev *tmr_dev; /* The PTP Timer PCI device */
 };
 
 #define NETC_PRIV(ds)			((struct netc_switch *)((ds)->priv))
@@ -204,4 +229,20 @@ void netc_port_get_strings(struct dsa_switch *ds, int port,
 			   u32 sset, u8 *data);
 void netc_port_get_ethtool_stats(struct dsa_switch *ds, int port, u64 *data);
 
+/* PTP APIs */
+void netc_port_ptp_init(struct netc_port *np);
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


