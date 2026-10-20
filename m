Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A468606A31D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gB//N2k8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j847K1qnbz2yqw;
	Tue, 20 Oct 2026 18:39:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792481981;
	cv=pass; b=YW/K8sL5VLpD2+PLkZW277ehFkF3eLiXzghiym4vzVhmG/6l/VcQpsxkfh7yjbtxp1SaMeGMDUfZGcKRGzplla8IonKdV9DkAm0ANn4s0ODp0vjLqTOVERhLcVVv+STvNLrgM+V4KG0FXIvjnubwMCP9t7xFzQOW7c+UUVUlOnJESlxYY1Ckku3AiZohQpkAZUZR7icnrk+WDI3SiSmubEtpPM/bmupE7NGWToSVereOnQQ/NoBAfbKFG+uS1SwolfWFq0Ds3HazeYMKfXOej8siyKs5OtaQGe3RGZsqgeugYcZcMDAzMcIpObEdXIpBYP7Z/pSTEahO9zg/7QSBRA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792481981; c=relaxed/relaxed;
	bh=oo2WG/Jdeh7C6r6K5PQhTWaEpUQ5yHII5BdHjllc0rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SOtlMHNCXNgmfTGc7Wq19Fsmuo1qJK4K701BbTtzDnrxJ9cF9GMD9rdX88cftN3yLTy9waNOoicm8ZnorVRik2/LQkaNlQG+22Whp3SSqM3EwzsGqEaQtzAngkKmeJ5Yp3HwveiQelpk1/YAyQuAu1kzQ0VeXTJZw1cUfAWJ+eUK+BJSucFJvdb57rSarr0iKHbWJeq0SHCKFVSOh092+r3FbYgMpDghRh9FsdkIFzNwSgVxVUzIehJd6Fe8F3EoBBVa1u0v9ay7Xf7qJZ+UctKD4yRNL0pLqrARYK4GKQYXtd5f4jS+UCmQ5CEZZyq9bckR+AsA54AqeGEnnpPZxQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gB//N2k8; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=peng.fan@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=gB//N2k8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=peng.fan@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j847J0bl7z2yql
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 18:39:39 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H57ckMrP5PpsX5U6Ftvt2Vm515heWRANQdZeWKnEJBQLqOa/Teg7t58yMHCXnO0aEoYoe6A0E+X5csuNUYeAHAsplnPLkB08uWblOIff5UnhqsWGukxy2yqRbwP7Ttxm+Ux6AbJGEcl0JUyFEGUtI6/bA+3ThEpyYtSugQvXHPIoMXkuhMKR0z+p6hcMoyKRw/KZuSO0BF9UrKCNp7nBpGi1Da8heSfidjiMK4C8ItLflbhpDoNlniGV8YGYhRqY7fuMtr47hJdAog6Fn8M88lEmXRJ0vl2BoCj3WuN4RQ+yiwviwVw6CLhvqPRujLyrEbD7l58TuiJ+6SO9LAgenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo2WG/Jdeh7C6r6K5PQhTWaEpUQ5yHII5BdHjllc0rg=;
 b=tpeZ2+otCYyGf7aEAuM/0xuPeLdSsHwHOjO5jOIFecOXRqNoBbUgXnxSRYgTqGWTERvpwN5ejXLtWARfrAxmWpX5qdcb7W5k0elwIqppgNbI4E7JDlGImO0FrCgf9xYK1a1iFyUuw8tM5TOBvzbIl1G7+rytltdEL8DPZRfjYnRCNU0m7zkYAUYnPvXyphvO0qSmCYb60CZR5AkoPr2iAbxnKFhsGhBxhiffOO1xI49+VBmrVrlCvn4qSfNBHM1WKAvVRbIzw9wO/iuBrZnceKnpeoUSeLVvK0dHVbmW2iJWx3EN8ePYcRRDFGBwQM/0oQkNEU3xXECXe8bwIGSs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oo2WG/Jdeh7C6r6K5PQhTWaEpUQ5yHII5BdHjllc0rg=;
 b=gB//N2k8dyHUTA5BsAh72ZLrxL2QUkZ7qMzmChEUWDMeZTl9Aholsfe9/GM0SeA20wCmbrUsSsVShF1mi2Nx1j4VpBg/jtkAlFZ2QJEorIypnow435Vse0AbUQed+K3/GmJAP2PUmSC0Dm834/PqjTXt3Co99rh20M3TpGU5DDM0sdqD3x0UYyxLrCCWefDqZ8Vl5qSpeHFWX7ulMNHam9OszHsqJp/QjpyTpEAiOREEaICBJ5YvNlvD1Eii1sOaPLjEEIWaZt3YEGiifSQO2WJVLzc7piF2hxy55yyQaoMEYXg1hfdi0uHmcYKDgjLOx+j7DIgSxWboch3MASjd7Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV1PR04MB9516.eurprd04.prod.outlook.com (2603:10a6:150:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 07:39:09 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:39:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>,
	Frank Li <Frank.Li@kernel.org>,
	Zhang Wei <zw@zh-kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Ryan Mallon <rmallon@gmail.com>,
	Mika Westerberg <mika.westerberg@iki.fi>,
	Ebony Zhu <ebony.zhu@freescale.com>,
	Kumar Gala <galak@gate.crashing.org>,
	Dan Williams <djbw@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zhangfei Gao <zhangfei.gao@marvell.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Qiao Zhou <zhouqiao@marvell.com>,
	Leo Yan <leoy@marvell.com>,
	Lennert Buytenhek <buytenh@marvell.com>,
	Nicolas Pitre <nico@marvell.com>,
	Saeed Bishara <saeed@marvell.com>,
	Maciej Sosnowski <maciej.sosnowski@intel.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Srinidh Kasagar <srinidhi.kasagar@stericsson.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] dmaengine: drain completion tasklets during teardown
Date: Tue, 20 Oct 2026 15:36:19 +0800
Message-ID: <20261020073620.224795-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261018040724.534641-1-yaojiale02@163.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
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
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV1PR04MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: cac5f685-d554-4b2a-a2c4-08df2e7d39e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|23010399003|366016|6133799003|22082099003|10067099003|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+ossXf+Y2kiYD7mTLNYtM6fRbxeyVDT5/PuJWJZGraBQgFs1yGU8d//s9UbnCxm9G2pOpaQ1Yo4WfQHEdwpdWuT77XqFwjDmbAVTYrA+UhzquZkk2qcO/axUm+f4h8mhOsrX+Y4CDYgU/mtiu7rBD+S1QPHbkSh50jqi6xfI11TpvpIvwxxYvRFZJrvJu0yWBvHSECK0eJZRj6wlrFPwWdHawxnJJF/CpJlAbgPcBRcvlTf0zTrew2DwT5sWTHwTwuts4HKB/xsWgCeyiXoYK3cARauRkoJi1fkDLeEyvEfa5W9nSjlB83ew8RAiAF6/bSnA4vyJzrIIq9rmlM8rfBt/dpjabeJrw+gEneUhKvr7sD25R/e39FjJJkGRvqQBusGSNzA6dSmtIdsZ2o0BLOHFEyf9KPUJ8x2MaA1ijXGDv99tQDpeWdupMNy65U3B72MVsUiCCElfOq4mZzFM5kTYlcviHHZ+faBXXYJUH1lfeWoAyfvm81m4+igrUeReUWbKuoP4LIwTicunj+Okj49UGiUFILU0qsWpZEXrmMhnPDlXdlT3hj8qZKsQMSS1QrTnLd6NWRfkEOhnYIYH0H90KECicdjr8hE78nBrBfG3eY9AJssV+Y9765k6NO8AIS0s8RTppjVVxc63c/ijatuSpgsXFLxYxLtRFJ24YI4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P/Xj7xUNIS8uA5iGNdsfLkxIQLQcmVDliPDrntalfWgQ4hWe4X4WQ1r6ngkd?=
 =?us-ascii?Q?SDmtqalT7KoWwaHLdMBwjNJAhgxrhdshPpwOEDIQfr2AA6FSOQNyrI9pokSO?=
 =?us-ascii?Q?1H8MOBk+JogVFRI8Ddm5r4+di8+dhLj0/4dUYcZZqehpaZzqIOuWtEH4w05u?=
 =?us-ascii?Q?3dZTrn+yUJpnWeKV8osrezm9G7S9qE+fybwo3fUsAMp6uAkDdRfGqRa/NKbV?=
 =?us-ascii?Q?L6pf9k0yHLAh9pjyedOnQI/CgWmGiKIxeNv6A8MFUxPapOVW7TmwB4GXUse1?=
 =?us-ascii?Q?mxbrJVk/Yr916S2sgygfhdxIkxH/Kv5agiFLkeFsT2WH4COhRRjIK5NMgMZW?=
 =?us-ascii?Q?LtB/v6MaZ/VHuyb5cCrTn1EmB7sPKzIQPwKLWZGyq2W24Lz0ponIOQHb+F8q?=
 =?us-ascii?Q?4b+/dCd43B8difGjMsen7s56eTlm+VW22xmJ5Zah9seklrPfteRt8QMCpykN?=
 =?us-ascii?Q?o+Wd4RfQ5Ugkgyj57gaeU/VXb4FfPlYuODNolRou4HSLzb34bZFiOf2FZaea?=
 =?us-ascii?Q?IxrWC7f4hA+yojSo4GYFbwYNIShQlfcIJx6TsKVG0Z0QdK+/ySDGJDlhox59?=
 =?us-ascii?Q?NoUtX3sLvKDoBJ5zNoO7MUvdG5E9jCw17oLnQHxE93so92da9h3F3mHCYONa?=
 =?us-ascii?Q?Z9DpAwupghGmnh2uV1c6nWLmqKzh8ooHjFfq54LzT0S40DPk1BHxytm1LxGC?=
 =?us-ascii?Q?wuOwvjS39bVqahjaxVz5MOjmoRtAtpp7vcbZCdCzg+QHfg/VmtHoLdWAnehU?=
 =?us-ascii?Q?Pg97jC6wa9UD4QTPs78hLjlQ9ZnfVoKePw6FGeoMhrYJZBSMY+gr6UHYKRE5?=
 =?us-ascii?Q?0ywK6a+wMo1ToqJ0qavIfoE5mq/Cj/ZwfR10+ivXIICRY7ry1+i53T5+q47X?=
 =?us-ascii?Q?cT7vJSAH1aoTv34rd7dvbY0HzZ2PO87NsuecB25SqFPxWOoSDoWELRz1XA5M?=
 =?us-ascii?Q?hUfBHxJNlfGkHEZgejy5zVnW7PfyA/SHs/W3ssTuQbpumHGHP7PZUPKCykDX?=
 =?us-ascii?Q?lsfd0R3hNyLiEIfBE3b5Uq5F5HwEGS/iRYN0VWFHZJfkSBxdTyxa68bDGD6Y?=
 =?us-ascii?Q?H/CMKUlW/+4dadbqmSUVszXNPUSLF2dpx6lSz2Ro4HFFIXLYW9lRA8yShHhf?=
 =?us-ascii?Q?qko8CCmxJmcf1BEtyFM3JR9K0k4ObljbuiUFuSNWKFMH78FzwPFHIeQd/9mp?=
 =?us-ascii?Q?NWEtaS2AXYrcUKSch2bOwJINAoEiRWs5lKGQjTCXG5t43oeG6FwN3IUjHfrv?=
 =?us-ascii?Q?iTN47tYjKh0cH9wle+vqtISeFqM5FNMbBWFL3jJUWV/lJ/nES22jf/3ZLizb?=
 =?us-ascii?Q?2maKyKurstDBCLiIQrwQxZATu5dFU1Zai9OndtgB7Klu83OIW+Noae9Oa4gR?=
 =?us-ascii?Q?/DAjur50rn3ZcX3SW034r/s2W8ohKsRP9gbMpTfw5usMvF2kcyzBPq/tzD8A?=
 =?us-ascii?Q?/ym1BH7V2MnJC/q5V07YlQjqcybfBId/iewKEGjR2hW3ZGbg1mk9F+D+kJt6?=
 =?us-ascii?Q?+Z5+jBQgJ8F95uvRarNz5wNvYbhbV64LfeYwm2DNbHuLcVxGyfxX5+ntJQTX?=
 =?us-ascii?Q?QYQbRrY+gdj3b4pB63gWsskyMgU3NSBKZj+wCXQ2hepnfU+xCj6mACUIBuMY?=
 =?us-ascii?Q?pvF7RZGwYjTjkcACnZootwB/NfSrYx+LHQ/+/KSHdDCcwAIj3F327psFtdHD?=
 =?us-ascii?Q?euM9SD0NQj6FxrRjwnKtdnlrH1KoCufX47DqPDpWVJmn3uIxbc9aPxmECpla?=
 =?us-ascii?Q?KORT122iSjKJk59ln1jPTOnKqoAx+Ddiz8wNo3qA7GDzVDG7QzPS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac5f685-d554-4b2a-a2c4-08df2e7d39e6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:39:09.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJI5KmrAZe7DUw0/YxATrEBniO+t33nlnw5wWPllNNJOA6SA3JSZoxtsCgVxJt/oOcNpyWmG2q59sBjLtbKyNET5lK6uACQZQlhZnm/TVNybZcvg5VdB5ivOpDY/mlC+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9516
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 18 Oct 2026 12:07:16 +0800 Jiale Yao <yaojiale02@163.com> wrote:

> Several DMAengine drivers defer interrupt completion processing to
> tasklets, but release channel resources without draining tasklets that
> were already queued. Stopping or releasing an IRQ prevents new hard IRQ
> handlers, but does not synchronize the deferred tasklet.
> 
> Depending on the driver, a late tasklet can access freed descriptor
> storage or invoke a completion callback after its client data has been
> released. Ensure each producer is stopped before killing the tasklet and
> freeing the resources it can access.
> 
> Each patch is independent and keeps the synchronization local to one
> driver's channel or device teardown path.
> 
> Jiale Yao (7):
>   dmaengine: ep93xx: drain tasklet before freeing channel resources
>   dmaengine: fsldma: drain channel tasklet during removal
>   dmaengine: mmp_pdma: drain channel tasklets during removal
>   dmaengine: mmp_tdma: synchronize tasklet when freeing a channel
>   dmaengine: mv_xor: drain IRQ tasklet before freeing channel memory
>   dmaengine: mxs-dma: synchronize tasklet when freeing a channel
>   dmaengine: ste_dma40: synchronize tasklet when releasing a channel
> 
>  drivers/dma/ep93xx_dma.c | 4 +++-
>  drivers/dma/fsldma.c     | 1 +
>  drivers/dma/mmp_pdma.c   | 4 ++++
>  drivers/dma/mmp_tdma.c   | 2 ++
>  drivers/dma/mv_xor.c     | 6 ++++--
>  drivers/dma/mxs-dma.c    | 1 +
>  drivers/dma/ste_dma40.c  | 2 ++

You might need to add a bit more context on the issues.

Taking mxs-dma for example, it is non-SMP processor.

The normal completion path is:
1. DMA hardirq fires -> mxs_dma_int_handler() -> tasklet_schedule() -> raises TASKLET_SOFTIRQ
2. irq_exit() -> softirq processing -> tasklet_action() -> mxs_dma_tasklet() runs
3. Return to process context

The tasklet almost always completes before process context resumes.
The only way to hit the race on UP is if softirq processing gets deferred
to ksoftirqd, and then:
In PREEMPT_RT case: Tasklets become threaded and can interleave.
Is there a chance that in non-RT case, could we hit issues on UP processor?

Or I may understand wrong?

Regards
Peng

>  7 files changed, 17 insertions(+), 3 deletions(-)
> 
> -- 
> 2.34.1

Sent using hkml (https://github.com/sjp38/hackermail)

