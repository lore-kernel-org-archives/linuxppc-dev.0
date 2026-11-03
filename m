Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28EF606D832
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 02:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wXnw8FEJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJX4G0TlGz3c9c;
	Tue, 03 Nov 2026 13:06:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793671582;
	cv=pass; b=SOlJF9ezBiXk2ZQ0M0DOfdOybzs1WNLWRrGZa4xe0hRWFBoNuul3suXflXLWyBVhLnQXblipXim1IBXVRnjc0Kr5b/mMcbeq//6P9MFFZ4tl64l51m6e1SYtgwgsd2AJFyVvSgtH+7QNEXSUQ36gvRqKt7Q2pGGyK45JQVnoHzQKHQ7Sb0oCG80NygFfeFwbdg1DQiIH5TLw5pCKXqtDsOhqpmfgPKw8RxMUIWMZ8e2aRS88qYBv/C7R8RAcHCN+KnnPkektBVL7OJ9SrpKfe6dQP0ym2HFDyvNz9M+meQe0gKvvDUCbOHWfEzfSxZvAgXhP1+Xkb5oMhlqhiw2B5w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793671582; c=relaxed/relaxed;
	bh=gP9R7rQ0HkQ0AZ5IOdZB5ipr6/sCzqK29BoiZqpmp1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cpc3FEFpj0wJZkMLZfk/xTjeflICHXLnp8Vd023JHno0RSAn8w0AvPEKOaeCuDDt4V2e5YJCxnsWtDcqbHRzMhp61g2+CDCGwiAHB3+qRU6fmZV6T9+sOy9M0ccgLvLmZ1df2V+n0Lz16WZ1WjXsX2cTdKJTFwO2YhBkKDsWPRLo5nboDkH0XwppvqJoZHPHlv34GIVrbrOI7ap6lxjbk1Mj9WqD5T4rwHV2xkU5sG4KzcSfHJ1CeAbic2x8Rg+XnUaE8OTjYVQyBFVDnRTCpdCN2scHfxDXdgvqQx7g+8FfnWRJjX8Mzc6biOSn3zNntFh0TqmDlH3VJCjkJmjguQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wXnw8FEJ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=wXnw8FEJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJX4D6KfPz3cDV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 13:06:20 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHXBntdsxwDLgf4XoR61jaeweSRHivFXHQ0GY1GjrMZveZRQn1AKUQYPN+OO6CfpSA+XuvQGq97wIdnQud4BINMe5vntcBYpktXXFMU4jHqclcdHVkzJDC+vDRHjE0/c6fJGbxc51V/RIOS5/nQF6lXJj36TnBmVh9P5ujUq9s78qkozcsPCMjqg3hcEbt9hRREPKPqygFAHF+0lpMv2wZD9jj6yi3lbTVV0bdSEdy9aWLRPFXmR00YhJMJxx8zuxNEyLKtLeX9y0s64vAHThccKhuH5bPTIToaPttm5Mg6bSMCCh1Samz5KE9oU4EB9nCJBz9ITfedix239eDReGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP9R7rQ0HkQ0AZ5IOdZB5ipr6/sCzqK29BoiZqpmp1A=;
 b=YCf3tFK/U4gpVHyOpijnCq52RjAw4C7cLhYno1n+mAuqpg0NyPDQEbh+AI5Gn80EoEoaeG/RC4uV4mZWIdfNF+8IPfubPG/bgUumrc9sVBvgyLLL2vMYOZHW1KobTJM3cr5T53RvSg0qNAQ9h9DjodCg9JBeK7ULX6p/vSx4LBcvVE6tTBzJeF1Mjd7tGeM2Gd1jnZtSsX+sIQioj/8naOKp0+oB7dcTV/iP+3Mc0schgrMv32Ca3dcz1z/XtIcKig4cm9xN29PNz4AgmlqJka0/MxswO+rzHRb85XuMPKfCeIpoAfVy0Fd2Uo8Tz+D/TclZ+T0iV2o+Gxsz/3EvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP9R7rQ0HkQ0AZ5IOdZB5ipr6/sCzqK29BoiZqpmp1A=;
 b=wXnw8FEJpkg7yVVcvZ1sYAziFa2rS7yD0r2BD57AwuuVszES4cy6D8E0dDdTxKXmi15Ag2hCG1Ar+IMZ6oMkx7/W5qMEi26UWxA+oTHZoTkG4W/571coX0DWyy4Pk7HrhXdPYmcvTP1uhufWiYbgQyB3GQHASV/xyqWYTzUHxx8FCM8Fpr02GD2HAL8x4JagFudC+4jf6TepP4odIuvQ148PQo3MA8YHWCYj4MIAVCPc54RYEiF6dOb/eMNAfiaSK1Je3jVCgX5tecx+63NV2hX/0G8nN7rSaAZEXEP50H9ElVVx4T96jxqcVGoupVqV0ecESrtS8GE2lOYKIlp9IA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AM7PR04MB7094.eurprd04.prod.outlook.com (2603:10a6:20b:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:06:15 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:06:15 +0000
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
Subject: [PATCH v6 net-next 4/9] net: dsa: netc: tie setup resources and reset to DSA setup/teardown
Date: Tue,  3 Nov 2026 10:10:19 +0800
Message-Id: <20261103021024.3121936-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
References: <20261103021024.3121936-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 758e4094-898c-4931-3570-08df394f0aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|19092799006|921020|261021123027099003|11063799006|56012099006|261009223027099003|261028144727099003|261026140227099003|261022075727099003|261026121527099003|261021121427099003|261022105027099003|261022113327099003|10067099003|18002099003|22082099003|261102123227099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	y+/5XGzBeqSyvJjbydU1l6hTZX868QTpcA0z3+DvbKv46o2cnC+QDNcd47U9xlhps6PH3qZPz8h8HKmaVOb9svcvxJSW9OXBA+iMipJL5OlcxN0qFohzM/u2K62VGlNcVnQ7/tNbuYIJKqNMuMAzYe7li98+OgqV9UDx/9Nvj1SIkzwGw0XMhVyL+sqUxHzH31sCEfeNdWKT44NIBBwzZf8NwZvs77Gw35ezoFt2jA2gqqUvGl/BDOOvX9rBnPPOC0XHnM+XKlbL8mwnzHYQRq8wTXsZXVajPzfH6/r0GjIQkqGcMTgblad1yRj6nbp2Qf6X93ymtYdu4dcnR8Qa1h0eF9k/LbfCSQp/M2spsJxLeX3odnI/Sdjrbj54e69PEG6ltsjstKgImoMAQFvJymsOdocfx91G6pW9RI9F/LHaenW+kFbwu6VfFvWmplCLHSoDPFHZVBjPPw4ZfY1L3FxIOaRvMq9XyVoWOFdmP3dByI1qfpMvPcO76ov65cIA9NsFwmtnktYx9edXI+PE43hZaGVaF5qfiDKFunbYs7VSMrtlGP49dVS1b66eIe1Ab72aJ+UfU9vyzEVDfHa+kvFuRZvCn4leunhNhFI1jpsgcFyesJe2GCu4HniRv+HD/zeR1P45R2LIgq0Lts7FYVYILmtkvhLPwISv8PbcNO6VzCOrRf3a79mLqblMgiTTEwc1+wpGXzqhcJb94/BSFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(19092799006)(921020)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022113327099003)(10067099003)(18002099003)(22082099003)(261102123227099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x9gmrNXqDJdyuu9eMVoeEZMy8emf6MiSvrZmdFn4g0AnKJaPd/3U0+w3IyJV?=
 =?us-ascii?Q?EHyt3ozWPQrb8FSVnIAtk2IH5655LibwUflkT+nd6PuVnx1/hflBOhcQ1H5/?=
 =?us-ascii?Q?ue/QvSf0F+7H4baN2xw1SDrht+w89b+n2kipcvFwkyTKO7b4bHHd5AWtn/oK?=
 =?us-ascii?Q?Tl104ERyjr9RbdDjWoUKB8GxODK7QEsui84jIAVHASSrdAyqcSAaQvax/Mqt?=
 =?us-ascii?Q?TDWzkqzB7u0z9C8ddIyt1wHWNupvZ+oAfrGJjQdMvo4Xe0b5zYpzEoGRHgAG?=
 =?us-ascii?Q?2CBZNkiAPwP1QSplQCG4d7QwThJGhmtnzy+oZoX2NKXh7RtZKCGLHUahEjf1?=
 =?us-ascii?Q?AcVYDB2jgYjSj9fTpa82wGfBZW9lUcQ+Ato1R1aJZDQ4sp8xk1Rv8OuISgQF?=
 =?us-ascii?Q?JIc5xYgn56caxOkXS6aYeHr96kv2+Zoynz7yqc7Yjz69+kgBDrVRwXFaGNgZ?=
 =?us-ascii?Q?32Ri21R2tf2O68L+CY6o5Zc//qCqA9HtLPqcAko0hdcTIxqmNJqR6RQYgyTc?=
 =?us-ascii?Q?bDWGPwRa7ySa90TdJ9mOuiUxV1vAySCnv93k9c0sTwkUqyr4fynQrq0d5GBH?=
 =?us-ascii?Q?8F9jDakZXnSipa4YZMhcp+kB0nJ5gU6z5DlmNXG+GTNucQJeT+fNy4lqdVw9?=
 =?us-ascii?Q?TTtc2po+3eBbRHKMsb4Vhz3AriuTnErMWIZvwtC/WWLCY+afv/mdlmAQ3mBJ?=
 =?us-ascii?Q?uOjZlJOsitRQCpIs4cJ09VZ8CQyP8fxAbZhVtrVDsNvh8IknnFnC2BrU6/DB?=
 =?us-ascii?Q?KfooT6FBtELKRri7ickvy/Y5SQ0Kc4mxm3S+eSZ6p/DRzYI1hKM0gSAq/nIa?=
 =?us-ascii?Q?aFibKCPuOFMAVBZ2DW4ATztCcBTamV2o8OUotjH2dXimvwfyaHi49tV80YY3?=
 =?us-ascii?Q?91DK0F98hRZlhg/PxyooP5oF4QNZKU6j90n7DBiSK26xO73hq//Sz5h6MUfz?=
 =?us-ascii?Q?PWEJG/H2iFJI+3HUw8R2WjxUv9cmdUJKZUnEGoOAnDaY7qnTApKJaa66DpRA?=
 =?us-ascii?Q?JzJx83XMS/EjuiWEHz6F2g+1R9/A1CSU/sgnLjnZbPKSk2itrZVlyAm0HZPl?=
 =?us-ascii?Q?LTK1fJddaMQm/v457ZiEKoEowo4j27GG/Y6jOlLnjTLftx8zS3FoCrjA4Kkq?=
 =?us-ascii?Q?VFsN4Cq0hdkbIhQTJLsDEHW9yv6dD1CYPiiw8/98uUu0MRt0V0mO2gviPqOp?=
 =?us-ascii?Q?gX2juh1Iks4xPYEsrjN8C+M+cgQdUG5xI9FkdOp1q73dWjoNVPet/I6Gd7/f?=
 =?us-ascii?Q?f1jRF53T3L+EAWVfSooGAY+Tz0ivoFKQCxZPOcr9W0nE2FbDgmm744tvIKnl?=
 =?us-ascii?Q?u9iirSvR0OQIKNPK5Ot7RA/GmzpkwQl/pv0Oj5dtWy/fprJuAN9ZkYF8kGzE?=
 =?us-ascii?Q?X+ZWh0pcW7m5iOtSkdthwNTCxG18w2WHJDtn2XHgE3O6rl9lP6A7kJjo/C0f?=
 =?us-ascii?Q?x6a1kQjFzX4hzzP7nB5H79jQteVvwT6Wun/19IYiDq2FYxYBCbzbzfcQWW6g?=
 =?us-ascii?Q?zP3kkDp5PL9pQsK3wMau+jFXWlWiKx7/0Kl6CaYOWcP3+UINCxNHFWJl+27s?=
 =?us-ascii?Q?GXDkuazyluoCvqC052FGgFoqtfiKpGvilhszSAaPWDzcSI5lZHMdo/piT2sh?=
 =?us-ascii?Q?3vSZHr08psM7sqOHXnEQj5fpG4H/4TymPPIj2hiAXL6kcg123E9V/Xh82KpX?=
 =?us-ascii?Q?JQaAnBqAhQ0t6lp56tKTeybH6zKOz/bdc/bBXaJI66BULKke+XWwAV0t1LzE?=
 =?us-ascii?Q?KfGqje/hlNK+sjcS8q6elk52EgkemtYt63VhBa0nKCc7ptIaTkQA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758e4094-898c-4931-3570-08df394f0aa8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:06:15.5931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qve8Izy4a1FG5x3AOqsWbsoQ7DFBT/lAvl1WN2bcJDqd33muC5WCcjcuENe+pgjU7WWibkSq1ikoNkWyNq97DgB2wnYk3dmqfG+7SzT7Na5+h4rX3PTv3d6C7KBCpH7n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Wei Fang <wei.fang@nxp.com>

The NETC switch reached a known hardware state via a one-time PCIe
FLR in probe(), and used devm_ allocations in netc_setup() for its
ports, EMDIO buses, reference clocks, command BD rings and buffer
pool table. Both are tied to the PCI device lifetime, not to the
DSA netc_setup()/netc_teardown() lifetime.

In a multi-switch DSA tree, unbinding any switch tears down the whole
tree, so netc_teardown() runs on every NETC switch in it. When a switch
is bound again and completes the tree, dsa_register_switch() sets up
the whole tree, so netc_setup() also runs on the switches that stayed
bound. Thus netc_teardown() and netc_setup() can run again without a
PCI re-probe of the NETC switch. Two problems then appear:

- No fresh FLR occurs, so the hardware tables keep their stale
  entries while netc_setup() builds empty software state. Hardware
  and software drift out of sync.

- The devm_ resources are not released by netc_teardown(), so each
  re-setup leaks memory and re-registers the same EMDIO bus, which
  fails.

Add netc_switch_reset() and call it at the start of netc_setup() so
every setup begins from a clean hardware state. The probe path already
performs a FLR in netc_switch_pci_init(), so the first setup that runs
synchronously from probe() skips the reset via the in_probe token. Any
later setup is driven by a sibling switch completing the tree, under
dsa2_mutex, and resets the switch with pcie_flr(). Save and restore the
config space around the FLR, and hold pci_cfg_access_lock() so that
user space config access and other PCI resets cannot run concurrently.
Do not take the device lock, because an unbinding NETC switch holds it
while waiting for dsa2_mutex in dsa_unregister_switch().

Convert the setup-path devm_ allocations to explicit alloc and free,
and release them in netc_teardown() and on the error paths, so their
lifetime matches the DSA setup and teardown.

The NETC switch does not support multi-switch yet, so there is no
functional problem today. This only reworks the driver so that
multi-switch can be added later without hitting these issues.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 182 +++++++++++++++++++++++------
 drivers/net/dsa/netc/netc_switch.h |   1 +
 2 files changed, 149 insertions(+), 34 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 77077352c1a5..ec0b5a731b28 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -135,7 +135,7 @@ static int netc_port_get_info_from_dt(struct netc_port *np,
 				      struct device *dev)
 {
 	if (of_find_property(node, "clock-names", NULL)) {
-		np->ref_clk = devm_get_clk_from_child(dev, node, "ref");
+		np->ref_clk = of_clk_get_by_name(node, "ref");
 		if (IS_ERR(np->ref_clk)) {
 			dev_err(dev, "Port %d cannot get reference clock\n",
 				np->dp->index);
@@ -146,6 +146,24 @@ static int netc_port_get_info_from_dt(struct netc_port *np,
 	return 0;
 }
 
+static void netc_port_free_emdio_bus(struct netc_port *np)
+{
+	struct device *dev = np->switch_priv->dev;
+	struct enetc_mdio_priv *mdio_priv;
+	struct enetc_hw *hw;
+
+	if (!np->emdio)
+		return;
+
+	mdio_priv = np->emdio->priv;
+	hw = mdio_priv->hw;
+
+	mdiobus_unregister(np->emdio);
+	mdiobus_free(np->emdio);
+	devm_kfree(dev, hw);
+	np->emdio = NULL;
+}
+
 static int netc_port_create_emdio_bus(struct netc_port *np,
 				      struct device_node *node)
 {
@@ -161,9 +179,11 @@ static int netc_port_create_emdio_bus(struct netc_port *np,
 		return dev_err_probe(dev, PTR_ERR(hw),
 				     "Failed to allocate enetc_hw\n");
 
-	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
-	if (!bus)
-		return -ENOMEM;
+	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
+	if (!bus) {
+		err = -ENOMEM;
+		goto free_enetc_hw;
+	}
 
 	bus->name = "NXP NETC switch external MDIO Bus";
 	bus->read = enetc_mdio_read_c22;
@@ -177,14 +197,22 @@ static int netc_port_create_emdio_bus(struct netc_port *np,
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-p%d-emdio",
 		 dev_name(dev), np->dp->index);
 
-	err = devm_of_mdiobus_register(dev, bus, node);
-	if (err)
-		return dev_err_probe(dev, err,
-				     "Cannot register EMDIO bus\n");
+	err = of_mdiobus_register(bus, node);
+	if (err) {
+		dev_err_probe(dev, err, "Cannot register EMDIO bus\n");
+		goto free_mdiobus;
+	}
 
 	np->emdio = bus;
 
 	return 0;
+
+free_mdiobus:
+	mdiobus_free(bus);
+free_enetc_hw:
+	devm_kfree(dev, hw);
+
+	return err;
 }
 
 static int netc_port_create_mdio_bus(struct netc_port *np,
@@ -238,6 +266,33 @@ static void netc_get_switch_capabilities(struct netc_switch *priv)
 	priv->num_bp = FIELD_GET(BPCAPR_NUM_BP, val);
 }
 
+static void netc_free_all_ports(struct netc_switch *priv)
+{
+	if (!priv->ports)
+		return;
+
+	for (int i = 0; i < priv->info->num_ports; i++) {
+		struct netc_port *np = priv->ports[i];
+
+		if (!np)
+			continue;
+
+		netc_port_free_emdio_bus(np);
+
+		if (!IS_ERR_OR_NULL(np->ref_clk)) {
+			clk_put(np->ref_clk);
+			np->ref_clk = NULL;
+		}
+
+		kfree(np);
+		priv->ports[i] = NULL;
+	}
+
+	kfree(priv->ports);
+	priv->ports = NULL;
+	priv->port_bitmap = 0;
+}
+
 static int netc_init_all_ports(struct netc_switch *priv)
 {
 	struct device *dev = priv->dev;
@@ -246,9 +301,7 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	int ett_offset = 0;
 	int err;
 
-	priv->ports = devm_kcalloc(dev, priv->info->num_ports,
-				   sizeof(struct netc_port *),
-				   GFP_KERNEL);
+	priv->ports = kzalloc_objs(*priv->ports, priv->info->num_ports);
 	if (!priv->ports)
 		return -ENOMEM;
 
@@ -260,9 +313,11 @@ static int netc_init_all_ports(struct netc_switch *priv)
 	 * difficult for us to cover.
 	 */
 	for (int i = 0; i < priv->info->num_ports; i++) {
-		np = devm_kzalloc(dev, sizeof(*np), GFP_KERNEL);
-		if (!np)
-			return -ENOMEM;
+		np = kzalloc_obj(*np);
+		if (!np) {
+			err = -ENOMEM;
+			goto free_all_ports;
+		}
 
 		np->switch_priv = priv;
 		np->iobase = priv->regs.port + PORT_IOBASE(i);
@@ -278,18 +333,23 @@ static int netc_init_all_ports(struct netc_switch *priv)
 
 		err = netc_port_get_info_from_dt(np, dp->dn, dev);
 		if (err)
-			return err;
+			goto free_all_ports;
 
 		if (dsa_port_is_user(dp)) {
 			err = netc_port_create_mdio_bus(np, dp->dn);
 			if (err) {
 				dev_err(dev, "Failed to create MDIO bus\n");
-				return err;
+				goto free_all_ports;
 			}
 		}
 	}
 
 	return 0;
+
+free_all_ports:
+	netc_free_all_ports(priv);
+
+	return err;
 }
 
 static void netc_init_ntmp_tbl_versions(struct netc_switch *priv)
@@ -308,9 +368,7 @@ static int netc_init_all_cbdrs(struct netc_switch *priv)
 
 	ntmp->cbdr_num = NETC_CBDR_NUM;
 	ntmp->dev = priv->dev;
-	ntmp->ring = devm_kcalloc(ntmp->dev, ntmp->cbdr_num,
-				  sizeof(struct netc_cbdr),
-				  GFP_KERNEL);
+	ntmp->ring = kzalloc_objs(*ntmp->ring, ntmp->cbdr_num);
 	if (!ntmp->ring)
 		return -ENOMEM;
 
@@ -336,6 +394,9 @@ static int netc_init_all_cbdrs(struct netc_switch *priv)
 	for (i--; i >= 0; i--)
 		ntmp_free_cbdr(&ntmp->ring[i]);
 
+	kfree(ntmp->ring);
+	ntmp->ring = NULL;
+
 	return err;
 }
 
@@ -345,6 +406,9 @@ static void netc_remove_all_cbdrs(struct netc_switch *priv)
 
 	for (int i = 0; i < NETC_CBDR_NUM; i++)
 		ntmp_free_cbdr(&ntmp->ring[i]);
+
+	kfree(ntmp->ring);
+	ntmp->ring = NULL;
 }
 
 static u32 netc_num_available_ports(struct netc_switch *priv)
@@ -842,31 +906,71 @@ static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
 	}
 }
 
+static void netc_switch_free_bpt_list(struct netc_switch *priv)
+{
+	kfree(priv->bpt_list);
+	priv->bpt_list = NULL;
+}
+
 static int netc_switch_bpt_default_config(struct netc_switch *priv)
 {
+	int err;
+
 	if (priv->num_bp < priv->info->num_ports)
 		return -EINVAL;
 
-	priv->bpt_list = devm_kcalloc(priv->dev, priv->num_bp,
-				      sizeof(struct bpt_cfge_data),
-				      GFP_KERNEL);
+	priv->bpt_list = kzalloc_objs(*priv->bpt_list, priv->num_bp);
 	if (!priv->bpt_list)
 		return -ENOMEM;
 
 	/* Initialize the maximum threshold of each buffer pool entry */
 	for (int i = 0; i < priv->num_bp; i++) {
 		struct bpt_cfge_data *cfge = &priv->bpt_list[i];
-		int err;
 
 		cfge->max_thresh = cpu_to_le16(NETC_BP_THRESH);
 		err = ntmp_bpt_update_entry(&priv->ntmp, i, cfge);
 		if (err)
-			return err;
+			goto free_bpt_list;
 	}
 
 	netc_ipv_to_buffer_pool_mapping(priv);
 
 	return 0;
+
+free_bpt_list:
+	netc_switch_free_bpt_list(priv);
+
+	return err;
+}
+
+static int netc_switch_reset(struct netc_switch *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+	int err;
+
+	if (priv->in_probe) {
+		priv->in_probe = false;
+		return 0;
+	}
+
+	/* Block user space config access and other PCI resets, which take
+	 * pci_cfg_access_lock() via pci_dev_lock(), during the FLR.
+	 */
+	pci_cfg_access_lock(pdev);
+	err = pci_save_state(pdev);
+	if (err)
+		goto unlock_cfg_access;
+
+	err = pcie_flr(pdev);
+	if (err)
+		dev_err(priv->dev, "FLR failed: %pe\n", ERR_PTR(err));
+
+	pci_restore_state(pdev);
+
+unlock_cfg_access:
+	pci_cfg_access_unlock(pdev);
+
+	return err;
 }
 
 static int netc_setup(struct dsa_switch *ds)
@@ -875,6 +979,10 @@ static int netc_setup(struct dsa_switch *ds)
 	struct dsa_port *dp;
 	int err;
 
+	err = netc_switch_reset(priv);
+	if (err)
+		return err;
+
 	err = netc_init_switch_id(priv);
 	if (err)
 		return err;
@@ -887,7 +995,7 @@ static int netc_setup(struct dsa_switch *ds)
 
 	err = netc_init_ntmp_user(priv);
 	if (err)
-		return err;
+		goto free_all_ports;
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
@@ -910,22 +1018,25 @@ static int netc_setup(struct dsa_switch *ds)
 
 	err = netc_add_standalone_vlan_entry(priv);
 	if (err)
-		goto free_lock_and_ntmp_user;
+		goto free_bpt_list;
 
 	err = netc_add_standalone_fdb_bcast_entry(priv);
 	if (err)
-		goto free_lock_and_ntmp_user;
+		goto free_bpt_list;
 
 	return 0;
 
+free_bpt_list:
+	netc_switch_free_bpt_list(priv);
 free_lock_and_ntmp_user:
-	/* No need to clear the hardware state, netc_setup() is only called
-	 * when the driver is bound, and FLR will be performed to reset the
-	 * hardware state.
+	/* No need to clear the hardware state. netc_setup() resets the
+	 * hardware via FLR, so the next setup starts from a clean state.
 	 */
 	mutex_destroy(&priv->fdbt_lock);
 	mutex_destroy(&priv->vft_lock);
 	netc_free_ntmp_user(priv);
+free_all_ports:
+	netc_free_all_ports(priv);
 
 	return err;
 }
@@ -945,10 +1056,10 @@ static void netc_free_host_flood_rules(struct netc_switch *priv)
 	dsa_switch_for_each_user_port(dp, priv->ds) {
 		struct netc_port *np = priv->ports[dp->index];
 
-		/* No need to clear the hardware IPFT entry. Because PCIe
-		 * FLR will be performed when the switch is re-registered,
-		 * it will reset hardware state. So only need to free the
-		 * memory to avoid memory leak.
+		/* No need to clear the hardware IPFT entry. netc_setup()
+		 * resets the hardware via FLR, so the next setup starts
+		 * from a clean state. Only free the memory here to avoid
+		 * a leak.
 		 */
 		kfree(np->host_flood);
 		np->host_flood = NULL;
@@ -963,6 +1074,8 @@ static void netc_teardown(struct dsa_switch *ds)
 	netc_destroy_all_lists(priv);
 	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
+	netc_switch_free_bpt_list(priv);
+	netc_free_all_ports(priv);
 }
 
 static bool netc_port_is_emdio_consumer(struct device_node *node)
@@ -1077,6 +1190,7 @@ static int netc_switch_pci_init(struct pci_dev *pdev)
 
 	priv->pdev = pdev;
 	priv->dev = dev;
+	priv->in_probe = true;
 
 	regs = &priv->regs;
 	regs->base = base;
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 305f2a92e2f9..4a8c5f9cde38 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -118,6 +118,7 @@ struct netc_switch {
 	struct device *dev;
 	struct dsa_switch *ds;
 	u16 revision;
+	bool in_probe;
 
 	const struct netc_switch_info *info;
 	struct netc_switch_regs regs;
-- 
2.34.1


