Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B23606A327
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MSqfs+89
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPYPf0BDpz2y8p;
	Wed, 11 Nov 2026 17:23:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794378229;
	cv=pass; b=D0kGNePhyc+h0VkkTv4Q3Eu16U+hoc2axe8EbcX0FM68g1M8gPJhdmFkOfVRgsaV5qu7SW67GgyZIISR8k3w1WX7deaBQAdAMPELf/Z/QbY2qeIrVoE+RfXnd/dsNH9RugKUhIRuCz78iemI0TYSi6qpiMRcILSYUpWHkaTedIElSYzj2BxxNlTUyoB0M4bq90AgOwA+pPdPZujiPx8lbuC7WbVCckwFdcAC3QFwFEZIk0xKtJXol5LcGR6LGP92CkVBGpG1/n5Dh3c/e9qt1HzqE9zD2VjDD/+VxcO5HGuxHgjlf1wCoi7A6PSmKxmkDjQvOZOGLasc4HnEjF3iVQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794378229; c=relaxed/relaxed;
	bh=t0o81/NzfNK/tZHSqExOQI0sLbtjurpIbYOSdTV68tU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bHA5ezCwifCzUwxGOGmQH16p5QnMhhAatXyzZdgip+zdEzaenfXZlfD9WC0PkpeJLK9nv3T2ZSxlfxRGAF3i6AlcMDdLU9cnhml2c2zPhgmzljecM6Jb4rt3WxV9AMqlL3DjIo5GGo0iDAUFX77ThZUN3UhyD6uiHxXcWnbbIGzVEck9PQvWRjTOkXEQdSXKj6yYht3Yoe+40QrqfdnK6sXhtXMQ4axq6sg3vCsW9ZRpcBwsVaZuBZ5+o3m80fkOa6gopPp/4DWB4RqkKnH22mYPmTAgyZkPPQ+AsSYQ7s/qTTrmMxQjtHPB6wzfL7VVm3t1GuTIguLpBvJTEdJJ6Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MSqfs+89; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=MSqfs+89;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPYPc5Mxkz2y2h
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 17:23:48 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lja+m/fuTLjmFbLUtRz9R45NwWaxSSjjBqP2/3b78LXyY2KwLnAWe1fc4sm6k2IUZQj+W5DWEz7/tb2EC71rlPnMa2L/0jwd3cTKR+PpDEZhpHu5xW++S2bXQRGz3uN2ErttSrIUgH11sTziS2yWYHv1Y/0ba5vX3hZ9rvYjlwjHZGeDD0GwC1TxwrGTtEA+sZJt5vow2ZHX9Pj5Fg/B7K9FxzNLLiXiO5pw/LyWmSBp/jugy2KJdMJa1eIN8oDy6r/0qICubVQpQqz41xikahELZ+Pd4xHXE+55qcHiTrF6u8r/gQnhQPeQzFJEqHBcenx1fKG771Nna7qqw4hGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0o81/NzfNK/tZHSqExOQI0sLbtjurpIbYOSdTV68tU=;
 b=gzojnTrWepD71wKeexcc26hPMZfw8442EoOxdwe/ZPhG1/LZuaHCCsldIPU2/QXLcfZMoA6ae0z3Ow/KyGic2Wi2kDN9qFky8WSYIdkcwJUykDAwjPTcCC2hKX5uGw6cXHffmLCvpCzLFwYBjWp91jy1sdX9FJdkR64yZQPs6ZAMl9jT97WQhI73J1HGiQcR77weSKE1jzsd+mDnVDk3fB2oLPnXkfGtNoYlvp8zDnEcylvOjrjzPRunjVQQcaWXMZ8y+pwt8NqSxb3lft2mQStj7V/2t+p9A4gGVD9wAvB2UEf2Rt9qfmZT+5QblbPO0Jt/hrpLKnLqNVUNvJwHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0o81/NzfNK/tZHSqExOQI0sLbtjurpIbYOSdTV68tU=;
 b=MSqfs+89UB6NE6XpzHQc2lSGrcq1is721uG8EHU+n0nyd2jUdTB/FZeQPZXumQgNTa5XFJzo+OI3Ipyd34g1Ws7Tln7sv3O9+2U2x96wpUateBWpGSo0X3ADxjvKKl3NmeaA+Gwbs7/qk2XGKqV/pbSRotxp9/g/h+NwyE5TvyUpu+0BfcMtOo2T3nQLzeGTc/ZgDYLxwauBe7K/ADIXrNuKmU3I4jFQXZ4ALSeGKfG2uTwP/p9arxdD7N6lcI1cZPmSbYROvB0oXtGrqtMDJVzyNvbaGJRaRCvxozM8yPUIqwwnj8IwafpMWCjkFvRIcfMFpgoZKrF0JFGOK7Gt+A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VI0PR04MB10543.eurprd04.prod.outlook.com (2603:10a6:800:25a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 06:23:25 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 06:23:25 +0000
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
Subject: [PATCH v7 net-next 4/9] net: dsa: netc: tie setup resources and reset to DSA setup/teardown
Date: Wed, 11 Nov 2026 14:27:48 +0800
Message-Id: <20261111062753.1397582-5-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
References: <20261111062753.1397582-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VI0PR04MB10543:EE_
X-MS-Office365-Filtering-Correlation-Id: 4104453f-1166-4f79-41aa-08df3fbc4ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|19092799006|921020|261026121527099003|261022113327099003|11063799006|261026140227099003|261102123227099003|261021123027099003|261009223027099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	dQskgfaOu7eFRUVeGfTw2EDY5DrvWH5Y6XwokFjv293WgRpeR0OEBsjCMUmCXaJptk/th5c1hkgTz7xkkWW7bcRqS96UfTaI2qryG8PvRiHBipwof988VsiZBcyRdF6VbFem0v8nJRAeQAObmKCR10PIg98uZ4KVl+/eWxuHGVNqpJk8ey5/8zZnsycE5fl1QFnohbnCIAHcII6s+rPVZJJr2OVggOY51i8oK0b3Vwt957EZhBpQrL7HpwmDSTuMTwNSaodz9zg0bdQPTVzAG4z9fEM9OIrueDJeCqmOHs4DYik/hqRL7Nv1S6r5FpW4rh3nhtf6mWBvv/LcsSqeR3djWuGbnHHbxQfM1F1eYh0bCmNoIfUtGcTnH7kouaipIIbstP6LBwo9+s79nFfn0lsPLYY1sCvWjreGH2z0bO7jMAoDFAl7BWIPyMfJZhKAmyAnT0UtpsFDt3SZsc3GiG/orsyqDDT3n4EQTGMt1CmVhbUhbs5OMHdngd7jpkmgnXSx57N6UEnb/d1xwlWFtIwK7g7G+93hiOafE9NBL1Y83dBnyPw3D2B3KDb61p3N4YQEwr/EWs9NJsqcoh9vVX4S0qnKzdmx4xV2IkKl6t9xEkTw4bJLoMqZdv9K/q+M1nKt+qAovJapEwmW4bue6PxvQobc0gPFhEy+md8eW1/lsdWZuj8VS0dteZx+q4JQWFTXcAOD86TQJHwgWAQa0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(19092799006)(921020)(261026121527099003)(261022113327099003)(11063799006)(261026140227099003)(261102123227099003)(261021123027099003)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N6Zare4vtX6Rbs4nziayRfGGEh9F9ywb0vh1ansN5mF7m653S5De5Issjk27?=
 =?us-ascii?Q?LJH5vH4GUo7tggSAkSBW+pcJSQHV/dElbJOucS+Hlp7ymzR583Q7uk30p6Pg?=
 =?us-ascii?Q?FdMRwuAZ9KLZp/Oo427BhB+yx2qebMvOoesnas7GTrvCLQlT0RKEJDWYpd72?=
 =?us-ascii?Q?C/cjRVVNBc1955i5wVCBTwntRlEuNW1wgczz5TPP0QSNra44agKPipFX3m0F?=
 =?us-ascii?Q?rdlxwxBHno0uMz/ANFrJcROapKvvu5I25TSt0D4aWf9QreYhG3Tg2LcxFqO0?=
 =?us-ascii?Q?6fPdXIbtAvNW0d/5Enqd3jGhh3qSmy5xGZ8g/33lxYrzYESeTmx0Vvm+WxZ/?=
 =?us-ascii?Q?L/lWLkjWfgf9v4OitiOei9dIGJgJIgg4+VybXhzUo/jVBn02OJqb1tfhBKvy?=
 =?us-ascii?Q?GsDN5LlvIlRxmoO+iSnWN6eza8IXeyM8a+jVhZvYF8gNrMSsXw8o0AM2CG4C?=
 =?us-ascii?Q?5szzV55iuDh3uuYMcnCEYMITDo1z+gzT9Sd0GbtbGoMOtOkJKOhuhOd27boq?=
 =?us-ascii?Q?VYToiIvhQQsborJ1McHEr116UAbvjrHYJQl8PkDONM1gfH9Bq2XnRUn9s+PP?=
 =?us-ascii?Q?NnZPXvHam0jmSO9fGK0HNZ7vEti69SUVBMtYNvSJgQDOhxzx5K/ANOfXTZjv?=
 =?us-ascii?Q?BgxBqTB8o84SSx7jhmb4GJRV+eb7E9odKY/KtkrmCMNbrWcNzNYFiF3QtD2/?=
 =?us-ascii?Q?Kkw6V+p6D91yHt5qs7wm9HUDqeaqTFd8No89sdMhuFmAsaa55XayRHWJygUq?=
 =?us-ascii?Q?FlE+je5EfcsQnKycLa2JPZjIPBe7E7zclemRuPVU96bY1ujYvh9gx885EyjV?=
 =?us-ascii?Q?YCDBHIaHbe8+1vDlN3DTVuGgqnrbclNkI7ubfmAFmRMObLgHBC4Gu/iIOxjF?=
 =?us-ascii?Q?Lyz20Y5eHvSLjJpzOuNiEJjDHmJ8Jf2W/sRjFgVKwqldn5fBG+adR839V6Gg?=
 =?us-ascii?Q?Qd1pZ2aUvcfUXEu4ec77crmubp9/5SPYkT0Xan3TpcJHMh8tGHs/UHSC9dqK?=
 =?us-ascii?Q?rWNmPDrQO+RfVCKCV5E6ieA98UB1QZNIHaW2fg7yoXGwkuy7sYg6fkhoCdXp?=
 =?us-ascii?Q?A7nO8nS8qql6K7XN+g6qAzdbOnoiftwQeieVXnsBqb5c99p+VMz3zgZdb87r?=
 =?us-ascii?Q?TRjgsca0J5F+fBVV4FS3yXs5xjybU2cKAYpJ0sdOAZQlgbIxSPaZv6CZq4KH?=
 =?us-ascii?Q?tSrMtWZ9zrPOktxINt3nc7VczXFCBRnQKU979OUO0cvK35ZoGPJvdMLItEMJ?=
 =?us-ascii?Q?yFqd+3ofmWHhUIvTRE9OzucoG3o+LGh6ZY0z14a6YOn4m53xQHeCvA4WCK1j?=
 =?us-ascii?Q?jhOrUorgOA38NKM8pfgR8yF8rCELeaAMM1+ykAp7oC0GETJgI++vpLpcqe9B?=
 =?us-ascii?Q?ngwjQ97StYAnzutLQkSe3GhM4/gnYoEz/t0egrqATBFhMadgIXXYAjE6ECrC?=
 =?us-ascii?Q?dwViwdbWgaLEFeR3g/SxP8vWRNAvKA8gUR4MmSeJzvJoP7uhCV6Y16M+XHFS?=
 =?us-ascii?Q?zkNG14xSd4qm8+WB42ZTkfwhACT1EsIAy6AZPdGc9G10qn3ypYp2qIBTWwb6?=
 =?us-ascii?Q?Y0KmiNB2tjHxsmWAB23DlXKHrwPyOkb8fd+zf3gVwPMgG6WHZ19zthSeuCJn?=
 =?us-ascii?Q?I7pQSgyNf5puDN2mCmPqj574thJG3+2AbMGllqVe0A/l10n/sEfVM3t6Vok8?=
 =?us-ascii?Q?dTWjlfvZSKnknQ8a31ghaIttDRrRjUg8YAuO0F2BvUG2BoiUHCgVESGKO9HL?=
 =?us-ascii?Q?j2vdfQAjQmQpFgzJcVMld3egnY2pspJP1rJuPU87Kb1oATH1xAs4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4104453f-1166-4f79-41aa-08df3fbc4ac7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:23:25.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KGN/ydb+QFEVNcBenahA3tCcQA9K/VQ5Ey+XEvzc+3tfVXF6t6O7Dgq1xb7SRdaIaQYwRISP2HqgJ/yZ6gCGvOs7uQw4um+yQMdG4/Nm3Rfc/b0+YeWeRqFd+MYGT3E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10543
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
performs a FLR in netc_switch_pci_init(), so the first setup will skip
the reset because the priv->configured flag is not set. Any later setup
is driven by a sibling switch completing the tree, under dsa2_mutex, and
resets the switch with pcie_flr(). Save and restore the config space
around the FLR, and hold pci_cfg_access_lock() so that user space config
access and other PCI resets cannot run concurrently. Do not take the
device lock, because an unbinding NETC switch holds it while waiting for
dsa2_mutex in dsa_unregister_switch().

Convert the setup-path devm_ allocations to explicit alloc and free,
and release them in netc_teardown() and on the error paths, so their
lifetime matches the DSA setup and teardown.

The NETC switch does not support multi-switch yet, so there is no
functional problem today. This only reworks the driver so that
multi-switch can be added later without hitting these issues.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c   | 184 +++++++++++++++++++++++------
 drivers/net/dsa/netc/netc_switch.h |   1 +
 2 files changed, 151 insertions(+), 34 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 77077352c1a5..c291123f5317 100644
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
@@ -842,31 +906,74 @@ static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
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
+	if (!priv->configured) {
+		/* The hardware will be configured after netc_switch_reset()
+		 * is called, so set priv->configured to true.
+		 */
+		priv->configured = true;
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
@@ -875,6 +982,10 @@ static int netc_setup(struct dsa_switch *ds)
 	struct dsa_port *dp;
 	int err;
 
+	err = netc_switch_reset(priv);
+	if (err)
+		return err;
+
 	err = netc_init_switch_id(priv);
 	if (err)
 		return err;
@@ -887,7 +998,7 @@ static int netc_setup(struct dsa_switch *ds)
 
 	err = netc_init_ntmp_user(priv);
 	if (err)
-		return err;
+		goto free_all_ports;
 
 	INIT_HLIST_HEAD(&priv->fdb_list);
 	mutex_init(&priv->fdbt_lock);
@@ -910,22 +1021,25 @@ static int netc_setup(struct dsa_switch *ds)
 
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
@@ -945,10 +1059,10 @@ static void netc_free_host_flood_rules(struct netc_switch *priv)
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
@@ -963,6 +1077,8 @@ static void netc_teardown(struct dsa_switch *ds)
 	netc_destroy_all_lists(priv);
 	netc_free_host_flood_rules(priv);
 	netc_free_ntmp_user(priv);
+	netc_switch_free_bpt_list(priv);
+	netc_free_all_ports(priv);
 }
 
 static bool netc_port_is_emdio_consumer(struct device_node *node)
diff --git a/drivers/net/dsa/netc/netc_switch.h b/drivers/net/dsa/netc/netc_switch.h
index 305f2a92e2f9..de2af536c594 100644
--- a/drivers/net/dsa/netc/netc_switch.h
+++ b/drivers/net/dsa/netc/netc_switch.h
@@ -118,6 +118,7 @@ struct netc_switch {
 	struct device *dev;
 	struct dsa_switch *ds;
 	u16 revision;
+	bool configured;
 
 	const struct netc_switch_info *info;
 	struct netc_switch_regs regs;
-- 
2.34.1


