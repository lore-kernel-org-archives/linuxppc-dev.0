Return-Path: <linuxppc-dev+bounces-25627-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05B3C5AD4D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 03:19:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hH5nw0vZfz2yr2;
	Sat, 08 Aug 2026 13:18:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786159124;
	cv=pass; b=mySj7LvowChTz2r5SZIaJ6UAdmUvNPt7os07vwYnp1kw1SMRrgCeFVujkhh4pG6Pkck32XdzSlRCULkEMwzE79MMUQkCAuO541NLbkTlB9JIdBEbUm0gOeAWk32+WeEONi4tj8sgk1UApLftmZ/a/gyFpGBn8gXorUL/4GUKxpUkD2NPwFMWurd7EVn1cyD5dle+jk6Mb1ht0cPymXIylwgqLkvRKaQ7dBaXXnXnlyITAE0LUhQWPe18NrAw/3CFNgxyKQTpYEiZ/b4L0ICYgopOY1k6FtS9DykelKBRAX+7BT8a8zwnJdThjcLyD3J/AchMWuneM9AVQacDnZcvLA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786159124; c=relaxed/relaxed;
	bh=9kxxyWyZ2TbSmQVT727XeqMG+hh3upmoj8EI2/K2B2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AY/7hPoCeWT81cY7Rhk3ndDMHVg/1o4/q5zgRSvrA2MSwTvjWjf75qRjyExfm8p2+labE+s3SYRsIr5qCoJeGYzKjH0UhE4bETkXKPGulDWkQ5saZUcd2HO+4x+6JSY2eHBHR9BlI4huc2sTpMOBhqy3MnAidlIgumrNC8n/MNZyKvYi2rbkFwrZIvQbN0q3tq6xcVwUF+tDz63SNZfAyYfB0y1SNmwfXNuAvFgA0CeigbqtMh0SVyzhLO30P2CdMwpAlh1uRqiJtzRt2E7uQVdIY7x969LRT3lVOeJUqEpYApEClU1i5Kzm3NxZfHCbYcuLSOR04s90PCWCcHiX7A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CShIAovc; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CShIAovc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hH5nv3xMMz2yqf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 13:18:43 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/Up1i4uWJWGJ9rqZzVZiRRrpsSmiGu1jdQ4zv2JQhv5fipAGNLNEHQKZVqXkwJR2dH+TICoOrmMi8h+mdzzRx8DxJmk0UDHvNKymPJKfJNausQ31aLqP0Y2QjlX5YjPIYKf2yIAdrHuXL/4cqbDewTYJ8qZUpPTT8KpZYg/xatn3iFBSvwcpHzoOGBVRRkALKG49vTigTGiOXC3up0WDSuqSbw/c/LlWXEIi9ksYHBe/gjnOdvhsFlvkSTgpDw/Oo/4YEHkmcIhC5/hXUSob6vxoxDb4LZf7PfBVUpfqLaDx3nRXOPEADpxbUyT0TG6AtkJSoOx9jgGiosOvgjESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kxxyWyZ2TbSmQVT727XeqMG+hh3upmoj8EI2/K2B2U=;
 b=uKRpEbXzVyFv/jVeQEekYTMNqYmJsbGzVKeEyFmr7+jfXyIXpfbSTfEZUeSL3qD34nM0cIY5EuQG4Qn+PG6sd2FewJeZEDGeqFMjAi7iaSnyTOVQxA4mvT6eHXYtCCfDrWk/1t3rogLUkKxVluf2GPydHwVzpRPkwtlfPnMONg/YjkWYaeXnhz7qeCgzyoKodx5RCN1IpU3eb4+MjrDMYI7F9GYSaMDOexf109lwQi1XDqvV/1E3RPzDxuUAf3PG9XFqbj/CM2kht4QbOuvAWTNarj6d0KUh3X9TVccgvi257flNWHcuR7jADCRky4L64L9oZO3wvPAsSjzfKQYi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kxxyWyZ2TbSmQVT727XeqMG+hh3upmoj8EI2/K2B2U=;
 b=CShIAovcGRvAcWbRR96H4rCyJR3+T7mpZ2ckpyYDmIahPH8Ldj3tXfA8ElwAfZUXJDvkgMcdfg9i4RlprKLMLCYcT+dJf92gKX4u4pyVRhaVWxDzTxXNACC/71YBbCSOIe3/3xyaBrywt+qww38PD2Y8/XClAF08UkTVf3EzPrpwhKY1vEeZ/IouSDrintrp/hNWWsbcgtYB0EWoOUQuA9hXz9S/nGYaUSxvYIdhNwXx3t5WoImc08vM7hQjUjq1UENqkY7WPtYAz6ZKiLku6urKDvRW0lY59P4/TCgHms14B6NkwMLA70AkiP1ugWz+cNy7N8P0rZ29IB9okK5XcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DU2PR04MB8936.eurprd04.prod.outlook.com (2603:10a6:10:2e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Sat, 8 Aug
 2026 03:18:27 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0292.022; Sat, 8 Aug 2026
 03:18:27 +0000
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
	richardcochran@gmail.com
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 net-next 2/7] ptp: netc: remove unnecessary pcie_flr() call in probe
Date: Sat,  8 Aug 2026 11:21:41 +0800
Message-Id: <20260808032146.2335723-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
References: <20260808032146.2335723-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DU2PR04MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f51abe1-9e56-4856-bc5a-08def4fbb690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|366016|19092799006|18002099003|22082099003|56012099006|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	9hB8g0mmocruLSgPFpsgiazBRbX9DhBJAufryGydGzxxPek6cTgQcDCE1oj4uq/Y1R+TZhPYQKNnbRdRZlRQFShCsDD7hS1FsxUB+EMmyhwA0OUhKv2oTMZsrsHsxuqS7GoNa7EK+sD+Ol3JqDt9eAvGYol8NGdGhmirIoJcyzJHwyjFTht9NioJQh+xE+HGdrpLe//f/B6NyvKuGNgWq5SRnWj0+fo7orGOj1St21Ll9z4gVTrW7uNJCof/S15kNVG99HBNN1eV+PdoPXV2t+rt+hts8enkYcO4jilz0d79TVovaqjYbsuWlrShbGvwu8A5oFRVtdk1TwQzOfbZAIOzs6+I0l17Ismq0vguMU7SDghc6Imklxkf4BPNTpUWLXL+a/pmGUvUopjfvPpJbjvhQcG7SCulPOLdqSL6UCsCCs/syVS1fkWViWG7ik2xcRioDKdzuUF67zIBGG1M8GYa7WCcqFozizHUJSbb8G0BeLeeD3jwb8Q7bU71D9Zbl1zYX5TBwK/wjyBfdyCeaEZ29HIT5QtLLKpXinkZGqrr88t9i/xPO+VZmkKCm8KlVb93uRBf9/o8ds0BtSr37Hw/yoaiHxUuxAu20j9K17WmSudwLhQLX4NDYjq/QnAUBaE80dqce4u7xr9nbDeLgjZBzg/6akV9d1JVv4To0StQDY5jVk17UVwl9i9ewjqohJQX7QlnYOHD0FTnDzSxUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(366016)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BY7eo8/Biwri6pkLuUwZYvXUEpgMcOfxFk+SYJbkHohcKtJbanLIlaK0CsB+?=
 =?us-ascii?Q?iesnkkBiGnRKg+QiZ9/4ZgNKmXCvh01b+sVH3zjEmPZrVGqa5+lLp/AISRrl?=
 =?us-ascii?Q?1K+9NeIwD6nJN98QIswrApurv7Iwn9hznS+wssajdaIK2z92qHuSO4urLWYY?=
 =?us-ascii?Q?4d9b96M4XW22/Y2BbqRxaUXiOk59D7CprZgG5zAy0hBPm9pK9jF2CBU0CHVM?=
 =?us-ascii?Q?qCru05tcF+2fcAGAP7ZzDDPNJLbelir4N4/yoXkz3H/bINYoGv0EvhY4bdU8?=
 =?us-ascii?Q?W+mJPUCdGFTLignL5VKJhvWsM6Ubm4FDnUcYfTK9QgtLN6/huN5EXkBDLAh/?=
 =?us-ascii?Q?hb/aaemLPtJX2lU8nT3sqT26VysLxuIjtsF7A5aNli1o3jImmyiJ/Uy64wX5?=
 =?us-ascii?Q?8wuhdP1ZMdO1c09dqUqTgpPO6xDv88neCst3i+cE2NuHS9Ghi/1YoHt1c1vu?=
 =?us-ascii?Q?IlLqLNooP158dR3YfP6vaPl+PhwFSp4lZC4iHUp4zW8Sjra6s4dgk6HOuz6v?=
 =?us-ascii?Q?dJIPNTBXtRIy2Geeut4CNslgFgDCCMUo0Ka3nbWAblQs0FaZN3iIJOhVcsnt?=
 =?us-ascii?Q?FaFm2Kah9dml8mMxOtzTxK4QQNRLEdbCmet7ZmWG4j7X78oTryiqYiSWmo6k?=
 =?us-ascii?Q?zwKE9O7Lp/JlQpfQRyMPin2ZpKpOZgMlu62skgrZAk2xlOcJPcnGcyAMmDtz?=
 =?us-ascii?Q?olkgmMlhgnXkMR2D6nMMmXh5e9BxI8tPjKXbxcOcqhw7GJqS81nBMO1WvHzT?=
 =?us-ascii?Q?WkkaKC8RSzN49L9pDjWR08ANEi6f7uN1jto+ismV43cHvxynIJlohOGhrRvO?=
 =?us-ascii?Q?HdMdice4JP9yFa4+XuIhdTAqDOo0xv3y4kAwUOxPpKQVc+aPTLWSYEftnn3M?=
 =?us-ascii?Q?dS2o+Myj3/nF6g3mwmV1bxzvEPn+7nwX+lEyvfYvZerFxTkl9/rtz6z5Tms2?=
 =?us-ascii?Q?ZxVJhS0polYHZ29/NRr9DoNbhDZZgQOHCdWkL3AzyWi6+2IOBwbx69+VVOlY?=
 =?us-ascii?Q?iplI4rHrjNIZRZXQOAhFGqb0gwjMYlN3GiB3EZT85Y3WGtbq17LtiKYL6PdC?=
 =?us-ascii?Q?xxhKvrER7DbTaxZ+1iqn8gzavBCrbnYoxbyxqbU1W9+v7BGHhGIBoO+G10SQ?=
 =?us-ascii?Q?uujv618GvzEVxytR8yXwFKHZ+xrtvJBuVcM72IyRA1F2cwyWr3U3OhpJUGJg?=
 =?us-ascii?Q?5naHvZvHlb+BKB8TyBJk2wW6sGAVud6DHTjmwvxJ+DOoqiQtA+FX51cvRK9G?=
 =?us-ascii?Q?YuJsdNFnmw/cHhm4a/oMZDvIhpMgqnoR7aCNkEh8poJOCQHPzDb/IQzD6IVs?=
 =?us-ascii?Q?oK0YzkdqVm1kAktkvdpLVhgu/9hgDVPhVPshXrpeL+jb5TnLN546XG9j99Y6?=
 =?us-ascii?Q?368nEiirDIlBzkeRTPjePucxhzbGKICzUmwHD9McqCusSgVK2gXvNoclKtTU?=
 =?us-ascii?Q?ShsJ8bS+FASxsv2H3BeGolcMASanZ/aiaONudQJNkIblhQRLUYlzDPbJgTiH?=
 =?us-ascii?Q?G/sWNfP2c16KsDLOy+jnxbDFZFVBVUCgoDf2I3xFrOnGcMelOl3J5iotYwgR?=
 =?us-ascii?Q?rBTjBsoQbjFQQClyzqTOOuBn3DvTEvPHi2wGPyJpIqmbdfeGO+s8AAADJ19X?=
 =?us-ascii?Q?8d8U0XRdRI1rIqvDgYw9xaSayfkS2CBt3l4HAZmhr74TNi2P9hUYKJExyok9?=
 =?us-ascii?Q?uJN37EpoZPWS8aRvh8PyCDX98/KN3Tfp/erc3N0xrceGktfZeZwgqRsj2aNE?=
 =?us-ascii?Q?8+9CWbWMZAtPTxcmK3JDLbSL5kU2VJ4Y3Z59bIrrbiQ7XkzG1KtI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f51abe1-9e56-4856-bc5a-08def4fbb690
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2026 03:18:27.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1EmaG6HdgGhT53s5+8ST0Dy6uuueTzYErWTrn3EcOvKPDW8dB14wLTJ3Z+ZItAUJrFNIYQvgewFq3hoKPgpGPWF5gWMC9YyJYu18tYlzu6i+UC6S5nolejs2+XhmwsuS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8936

From: Wei Fang <wei.fang@nxp.com>

According to the NETC reference manual, function level reset is not
applicable to the timer as a supporting function. Remove the pcie_flr()
call from netc_timer_pci_probe() as it has no effect.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 0e0972596d88..d33c49c86ac4 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -774,7 +774,6 @@ static int netc_timer_pci_probe(struct pci_dev *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	pcie_flr(pdev);
 	err = pci_enable_device_mem(pdev);
 	if (err)
 		return dev_err_probe(dev, err, "Failed to enable device\n");
-- 
2.34.1


