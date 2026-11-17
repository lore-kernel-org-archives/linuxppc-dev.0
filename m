Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BD5606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=JuTIQyz5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTcck3ptJz2xNC;
	Wed, 18 Nov 2026 08:02:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794949350;
	cv=pass; b=Czb0x5Q1B5PmmWbiQ2WE57m5au9+8Iuxml6QxKZuORH4We5o4cHqrN9JbMSUm/EITQznUfFaYLtxOKZMNgWIuRvjAaEmu+R1C8+hVDV5zN3QdfQcuGW5qdg87O4E2VFCIfCUAOKb4+hKj0zXdLNQjtlbFSLiub/VaQTcNY0DqE0hgDQ6ENL/yG5EK1kxMdywIe0Or2qK2CbLmS1IAYW7Ntp/A+Jl7Ac52JdYltA+xb7/D/+J/lE5358uDCwyY0cnF3NJsh3uM4+MXP0vHLbIHz3nFb/zIEmpbHX52ypARBntToAmRs4dle/fvo2mipzD2ECgstHYHqx2Hm2rCfUrAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794949350; c=relaxed/relaxed;
	bh=PLNi9oq0QeGtGGDAHeG+GKXV/DgerA0rBDv8AS22WoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WOjrjqitmmmWvrBynzYeqHrKDjkqgF7Sno1j1GWizMVKs8y40nKFhTPFjZoD/Aek1I/42+pJa3Se8oRqSM4wv3/GXj0C7y+ZeYP4y5L8lAC0t/Q/MImYAdWyepEBAiDlC9SfcTs+5NppAEVepriWRMBaXpK57I800BaltmL2a5mdx/ocvkCxIBmG3rTTtfGqlhouQXMD7XatdtlktfnX6o/VNZHq64YcsO4ucapE9u+HxSAXlzlx3bvQGBQf4RoNNJmzxpiSxPH2IMRwmU6ABSsP7f/sgACYKOMVscCDONy1iv2DXuXcVkOz9vmi51ysLBlrNcwntMdYfm76cFnHsQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=JuTIQyz5; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=JuTIQyz5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTcch4tqSz2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 08:02:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYJqYdVA2y1adQ4AlaR7qDsVDVkEpsITPx5DQRbr8TynCjs37PShQ7kakqhumQEb7xL7yzxKaGkRY2iVs1iV5O0PEZ9tdG+tGNoR/8CjlolyDPM+BWHiZAn1TcoMsx35Va4P5fX+uL1UAlGASrRUNd3WAhymimb4sKJLV4xxRGmoHvU9oxGXDcecABnbECCGiZhBwlRQ8O3ot1woM10M1L+J1KF86+b5u/rnEBTp8VQKGbgRklmKnMwTxI3lSn7Kyh49CXtMMq+Jz141YEw+ESrXRUGCuv/m0CSlAxeefWHkVEIWJbWVmp4J5FSYgiJhCQCXA1XBNUzLfujkrUW+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLNi9oq0QeGtGGDAHeG+GKXV/DgerA0rBDv8AS22WoE=;
 b=CcxuGMGEJDZwvrHs3nrlnmlNXZcQ4eDf01pxsEX3LqLkSCLNPzapmbdpw7XUg+qh/2o30JcM7xDaWNXwD6n4T8ZKLd8PV4LKNZ55h1MFBv81rPJt55ZkmrmBRFPAt5pjQBLYXroTCjapn8SbqgXhUmRBAMcJKrZ9SveRk2lkYJOLzFpGITPu98wFAf+5XaaqB5sbvVG/VNp6r+T1mXmBgUv4XS9uoMoygxuIn+X+FkYLrRSMwrSMyRk5HYlZDjx5G8sQsbA46xPCt4r1MdGhY4KujI+dt1sJp0u2b1dDmJVlHHUvM3FTzdlCneGE8Hlpdf1yiBeKTT3GSOdUPDDXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLNi9oq0QeGtGGDAHeG+GKXV/DgerA0rBDv8AS22WoE=;
 b=JuTIQyz5sMNxKIQBrRL09RDpl22QJUL0Wm6gO6S/NtX9lWFP8gVyYF7CETWpL1Pe1bb9rhzKqTyShIEs5fPyOczYWvXoL/UcaUsOFcJyQ7NbYSLo8vHrsfp5ZZi/8F0zYvNH6zxHcRhMp7/hogdCTT3PEAQBnCwwLRXJJl0T59keN8XlcZrkr31Kqnr/9LWSOXyFsoTtL984tXR7G4NyiAYK3qBCfrxXH3/q88NDzG4AHqVKnfAlzVW0sW7IvUDNJ3Xxt8R39kcl8UWOG+zUvR3ad2uWWeC6bAmIPvHaPx16DQEYUoXinC8TbD4glvKwUaDTOzoX/yp7aCCog/iLHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GV2PR04MB707735.eurprd04.prod.outlook.com (2603:10a6:150:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:02:11 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 21:02:11 +0000
Date: Tue, 17 Nov 2026 23:02:07 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v6 4/5] pinctrl: freescale: add the Layerscape RCW
 pad-mux driver
Message-ID: <avykU0WMTq24_xkR@lxl00025.wbi.nxp.com>
References: <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-0-fbdce4565a5c@free.fr>
 <20261115-for-upstream-lx2160a-rcw-pinmux-v1-v6-4-fbdce4565a5c@free.fr>
 <avtsY-7-I7_pdyD0@lxl00025.wbi.nxp.com>
 <avyEUKJBiDwxpLt7@L23803.iliad.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avyEUKJBiDwxpLt7@L23803.iliad.fr>
X-ClientProxiedBy: AM8P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::35) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GV2PR04MB707735:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cf72af-2832-47ed-d0da-08df44ee0c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|19092799006|366016|1800799024|7416014|376014|18002099003|22082099003|6133799003|261009223027099003|4143699003|5023799004|11063799006|56012099006|261028144727099003|261102123227099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|10067099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	YuvPCkwf0ePw5N7pefW3VCHeMbhAh63RDCFbXam4Y89uj4BZ1ecuj0CtXHAkP9SAPpaL5qSZXBrHcsoPLfhDyWDMS4Sl4S9xGEENB2l6R6IYaEUKYp2WUw1hMs3t+T99HM3gMpPL2RXH7jKQnCXkVRjKEzVg6jlilMj8FgmgFUoq96P/5HGaVrpYqGOranW1ovPOM5R2jwirMx2GFLBSDPrZlFc0Az7+dC3PHmapqBkGBaZDKfoiKtPCA4BtskI07OWNIjZPYXNAwEuDogHwmEbzRYJTN9MBsCdlYOvaeBHoPLdyNOmlrEXurSSFLZpO9tOM1IjUMhVb9nuSU92JvMzFpqjEQxSq+JS+5lUo8Etg2HUXvskow8Hm6OCU5btQzMg7RYoRzAT7wAgEz/MRQS+mCo4FTkGz6zyE4sWR6Tk1og6J87aBJRSlPgFSMTwu7rMrdypedqnTIi7lomhK1nWoMcP7OHr5mnuYXOnhItvvTp5gdOziAgdo+8NsCBzWWDjHZQqKFvMzCRv/JamVKNVqZj7m/eyidh3DGxTzcWMnnAKEHyFzX4zRdlNaSLLgh+0K9rKjoSqZmrmatnTwz9eJmKwE0cNPy1NkZMdBV8ciHhf+kjBmuaaFyV6rd/Qoq4HXbgMFrK3jvk3qVJf9t1yA3WfhsMjMX5IWaf1FmQ8vM7Y4sorn/O9ea6BqncuV1vcsWzF1Zdd2oJuoWSBdyw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(19092799006)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(4143699003)(5023799004)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h0Qr+9YgehzjjTkmx1LRarIpuk5tINEye91pFs72h+BrxReteVu7gK+Tfw8N?=
 =?us-ascii?Q?IsSrNTIdbAOls62duZwbtPj1OxjTLn4ZoBXSqLJn1++4EfueG2vSUiLqIyG5?=
 =?us-ascii?Q?NwLKNjQTHd6iELeadlRnlhnPe7PyuCxbAeagU3wh/m9nUPGGh7WVOrxz6YVM?=
 =?us-ascii?Q?JHu17y+lp44PUk/8VbqkNH+irTXByha3BSkIHpGP/yD/q+vDJzNriBylUDgX?=
 =?us-ascii?Q?nSMy4GN5hGgMrCKOAO1LgussB7LQFuD2amRHurRiZttXPPoXW4xbshpNpKrp?=
 =?us-ascii?Q?N+qoDw+hLwc8zBL1WYk0w+UYDDQN+eVmwRxjPZ8jyLCx26GfWEGLP/M9tsBX?=
 =?us-ascii?Q?a5aWFdaS6kx0E5TKU8XuzvIEMxtHsQAhFnuA+msAC0j3FpDlkWXKBG2EIaHu?=
 =?us-ascii?Q?rmYvSG7XnHfHbOm0lP8juEvQJOnq6Eorry4acz4qWIa60SwyJlTd/DEtWram?=
 =?us-ascii?Q?uRpsjKSZboxyQ4T63p6N+93GiHOg/G/CkHW6OMIg1VQ8nk+OTrRE8NOj0Wtn?=
 =?us-ascii?Q?7aK88AT6I8m7uNXIf/bliGvNCc/9BiqW7D6MOECf2szjdqJoNiNw468ipKRh?=
 =?us-ascii?Q?XbgOo0lvPOYxX1KN5ubDRmjc1hN9ZF4+a3S3miyvZxvT22qQ1O58vaPOJ7cR?=
 =?us-ascii?Q?rpkDoUBraloiWwAzjzb37+v0D1L0mDYKmL+MAhqmR13Jk7pokjWz6GZ8YtVL?=
 =?us-ascii?Q?+KAEgOeaDCaMSpRHJMYmAWFqlJkvtATY2bomIvgUbhkc10/hLKJcbJioXwg1?=
 =?us-ascii?Q?fZvJY0H4HbiPL5omgdGrbqnRCilxaaet84M19JhsyP0ms4sx9TY9MyWElWQt?=
 =?us-ascii?Q?Who8LjI2wX4TP9RiAcZOZMYB0adi2vQ9FfN4tj/QCKZtOOiZfo/FyGAvLpW8?=
 =?us-ascii?Q?6OdKOikD5JuT6rigOs4yclRYTR7ZQfivMx5UmMa/pBHbQBz0kyg6ZRcaHSMW?=
 =?us-ascii?Q?JF72YEV5amQzvf9SvV6o9YqgW1ilaGOe2kZR/ELwuGkGeUu9Q5Bb9xguLNUD?=
 =?us-ascii?Q?NuHRIgvWy87aHcmGYa2hoBzQjzFh2QZO58bawXrNUE5H8TKONkabvcBUo2KM?=
 =?us-ascii?Q?V8Lpm+5mfLGXJNsVLoUdkwkKvPZCDV1XVUL/SBFndnlAIY6FIbsUFSub8DjW?=
 =?us-ascii?Q?/dO+cQIWlIHFSZolNAbJRW7f8KY0c643wffY14i7RdkKRsVKdSp0DAS3/rAf?=
 =?us-ascii?Q?veL8qhYL34BmtdeeaR3uUjyBo4lr92oP5WyEOyjN/V1IkoEMtWfagfyihryR?=
 =?us-ascii?Q?6Y11Tvp7JysiqndgWHlK+opyqG28Qp/N4HUbc3FV6WaoM6y36tiPfD2cPZH8?=
 =?us-ascii?Q?XUlrurN95BPwKd3M3rPz0tZqHU8OOVddKfMAST/5oTPGywJY7NJR3xtijEAf?=
 =?us-ascii?Q?Z3Lxa3Q5w1aC9mINl5eaZzkY+uwxZHJ96eIKXNsBtBUpfzDo9Q4d4oEjCf91?=
 =?us-ascii?Q?D1QJGzv0qBzd9OCAaqPG7cTozcrfl442kl3Kerny+WNenDBRf4oTw3kaTgHf?=
 =?us-ascii?Q?l+R2Ag4yLWaj4cAKSfPdMWVMD6yiNVt7DbPc7eG/pKZAfI+U6dqSUBN6nDM2?=
 =?us-ascii?Q?3DkJN2aoMjeIRg5CTh9D0ttxu3RoNJHjRCAcCh8bMQt2kH8xCCirSR7hrBAA?=
 =?us-ascii?Q?jgD79BGOr9bH+04SFmHB/NpZCYHcLlgyPdI8GjS0+AFqkFTGhJkN/u+7d26l?=
 =?us-ascii?Q?6lNsaOuCZWeDp1DSUaGcBb/XO2Wf6GxEAREg6+0Q4AXoQvLDuI4UKOSxdRSH?=
 =?us-ascii?Q?hA4DMAvVmaj6YMaks2VdW+rjz9M1fmKpGpae3ygVMUZ7Fuwe0oTUUSU9EyMs?=
X-MS-Exchange-AntiSpam-MessageData-1: T9axJn1UbVFtDA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cf72af-2832-47ed-d0da-08df44ee0c36
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:02:11.0267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGI0DvaKAAL6kSIdsV/d7CNiKkiSalpr/of5hGuURTMiKtbw5S3q+bY9cJ5jwTBcBvnHbNqj/Sah0rxRXDviRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB707735
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 05:44:00PM +0100, Vincent Jardin wrote:
> Hi Vladimir,
> 
> > The "i2c" and "gpio" functions of lx2160a_sdhc2_data74_funcs[] here
> > hides some real unpleasantness. These 4 pins either get all assigned to
> > I2C7_SCL, I2C7_SDA, I2C8_SCL, I2C8_SDA, or they get all assigned to GPIO.
> > But they cannot be assigned in pairs of two (or individually, i.o.w. not
> > in the granularity we need), which makes independent I2C bus recovery
> > practically impossible (i2c6 as I2C while i2c7 is as GPIO).
> 
> yep, the doc is clear about it: SDHC2_DAT74_PMUX is a single field for
> the 4 pads, 0b001 gives GPIO_2[18:15] and 0b010 gives IIC7 and IIC8
> together (RM rev 1, 4.9.8.9). IIC7 and IIC8 are not available on any
> other pad.
> 
> Checking from other angles, the A-010650 workaround uses one write for both
> buses: 0x700100130 = RegA OR 0x031. That mask looks wrong to me though: bits 5:4
> belong to SDHC2_BASE_PMUX, and OR-ing 0x001 onto 0b010 gives the reserved
> 0b011. Could someone at NXP have a look ?
> 
> > The way the code is currently written, the pin_request() call will fail here:
> 
> Yes, in fact, it is not new with this series: both nodes have shared the
> same setting since
>   8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery")
> from Carlos Song (NXP) where the two pinctrl-single states covered the same
> bits, so the second controller would have failed the same way. Wihtin the
> kernel, there is no board that enables i2c6 or i2c7, so nobody did hit it!
> 
> > Due to the fundamental issue of this limitation, I don't think it makes
> > sense to have the pinctrl states described in fsl-lx216x.dtsi for i2c6
> > and i2c7. Perhaps you could remove them in another change (either as a
> > follow-up, or another patch in v7 if you need to resend).
> 
> Done for v7 as an additional patch: the DTS drops pinctrl-names, pinctrl-0/1
> and scl/sda-gpios from i2c6 and i2c7, and the two states nothing else uses.
> A board that needs one of these buses can add its own states, or set the
> field once with a hog on the pad-mux node.

I'm not entirely happy with my own suggestion either, I'll comment more
on v7.

> 
> I tested on my board for regressions, since there those 4 pads carry
> the eMMC DAT[7:4]: the other I2C buses still set up their GPIO recovery,
> and the eMMC still runs in 8-bit HS400.
> 
> I also went through the other fields. 7 more settings mix two
> controllers the same way:
>  - flextimer on iic2, irq3-0, irq7-4, evt4-3 and evt2-0 (FTM1 and FTM2 channels)
>  - sdhc-spi on sdhc1-base (SDHC1 with SPI3_PCS0) and usb on usb-ext (USB1 and USB2)
> No dts claims any of them.
> 
> About your previous comment on clk-out: v7 names encoding 0 "clk-out".
> On my board, with debugfs, it shows now:
> 
>   pin 20 (evt2-0) 0:? evt
>   pin 21 (clk-out) 0:? clk-out
>   pin 22 (asleep) 0:? asleep
> 
> and the U-Boot port of this driver shows "clk-out : clk-out" in
> "pinmux status".
> My take: the reserved marking comes from RM rev 1: its revision history
> says "Updated 0b000 as reserved" and the CLK_OUT configuration section was
> removed, while table 19 still lists 000 (CLK_OUT).
> 
> There is a similar gap on EC1: the signal tables list CLK_OUT2 on
> EC1_TXD0/GPIO4_DAT03, but EC1_PMUX only has 0b00 RGMII and 0b01 GPIO,
> 0b10 and 0b11 being reserved. Would you know which value selects CLK_OUT2 ?

These are good questions. I've opened a ticket internally and I'm hoping
to get some answers regarding the correctness of the documented A-010650
workaround procedure and the CLK_OUT/CLK_OUT2 signals, which are in a weird
superposition of documented and not documented at the same time.

