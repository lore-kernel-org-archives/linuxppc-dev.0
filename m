Return-Path: <linuxppc-dev+bounces-20637-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E11CD37B5
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 10:28:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCMdw4mWSz2xvH;
	Sat, 09 May 2026 20:28:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778322516;
	cv=pass; b=EUPXjvK8rrsHOvZNzeGF/+YqMAO5iqB2tR2aoTox1RhuIB41ADPmvP3jCEtwr4wppJwqSwBP50gk9Ep06LCpi45DzK2SqSnzAH61qMB6y6Hb/RKH3w0g9EMOkdtOM0jTvKwC9y5ttg6HCfD7xlYy69aYrFlWr9yRy35sqbl5vK1B0o+J5p6Q+wA5kiUjZ/5GvnkJRmVKCL/17EfIS0xGBBdiFJe4nFQJdNiFZx4XrOrGDGTNEAEdKGf3Ub8Ct2uTDIA1EccJ1VM+loATg7mLhPJf4+r/MKA6Dqr8fvdMGDJ+otlJYbPndeWtONBfoFcQuISiG4Y34wb6jmE7BQJg/g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778322516; c=relaxed/relaxed;
	bh=kSc8Q48CjHF7K1oPYUnmKGERCq0WRSdQS9aH8eNEY8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J6KAvBXQbB3coLWFe9d6iq1C/7FzG+hA3EbEh3RTvqNkJ3jpP1vLETRtwLbOYXM4ellGxttvxBnmfeYCMyapdco3E8y2eNEXQG/+Bl8FS9Vi/ODgJ8R/Y075Fzaa1QHl9gTaBZGaOFcQrJ5PtEHrjjv0x8V9jYk6xXgVnu4zvvmBgkdF99jOcjm3Dzo+rEV3uusfX8VYAtFHzD0ZozWVZJ1bqffzyyDmuomS0QxW9O2r5XiQAmJpooIUHfmG3zlKr4BqGlBM3ljwFijJj9eVwjsbW43MJSZiNxh6JC+TzOeCRgyrcFEGKohnTGu6+AkNhGF1p7OjrYiZ0QhYvniHHg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ez1oQAcA; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=ez1oQAcA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCMdt6NRFz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 20:28:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXW5AtQiqEZgEmO0xgMwYtl+j2edXQGjVTmy9QhQ6BRAvbd0v2r8Usa1FN3sS9+O+pSRuO1kTJPKZVjZoF50HihhqD1aqMPGpWXgM/+fSktKt6i2FX8wqrzewi3iIUMhntt77PtgROMwZjfzELikcrjYlFSwzWWBU0vjo5wIFGmctT+hxk1O7TmocD+DMfXWVnTXlTyrvaUbHaoC8xx2p0md9CsfUWeO8eJALb8U/2Vez/NqPVuRFtJS6xiEJG2S6ERHnTGfUlWYAztFKk3Xr04kOxMWNJ1FYO447EDBwrm/2TP8Hkzloy2MK022vMScL1o+xhiISdg36xOats/jjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSc8Q48CjHF7K1oPYUnmKGERCq0WRSdQS9aH8eNEY8A=;
 b=YKmdksNSN1CQFMlnFsG5J84Bk6C1vaLj2bW0/ZU1tLIAZs1BkENGglXeBLe1z7GfLf1CDi9wqd4MmK6F3zKC0shL91nrEueBJtLRNRf5GuXK7uljmzdmsoS7YJUxlRo5D8Q6c2F5gpX1xfMd2/U6yRSVfGlB5mqHepc0H1qEdkE8gijao8vGMdVRc42nB3O1FcFZO60By/CfuZsgRK5zhUUDbqxvMOGjMF2zRNU66v/fjheRsOS6k27uQX5s0RWbDEDo2ZdltV5PIkc1TWt91kLS2Ty8kOyaVpfnzePzh6iW+V5XaVNb05Kv8st7f7VGiYM4fBFaQMaKEDIng+6CkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSc8Q48CjHF7K1oPYUnmKGERCq0WRSdQS9aH8eNEY8A=;
 b=ez1oQAcAFRxvB7JU7WDI63GRr+jxPFlV8Jbr4IVVchdyHBYyEcYXVLE2Q7PqcPMUyvYthe2MszMo1tbwq5lGVWzXX+AqRn/O/6nNFiCMmrsAxcf9f8LsHTjigY/BUbDfGdEGbh+TxKLckUEeOpPz8JcYGBnGKVivPQG44IGjbIZNtClcYt14N9Zq6Zrj8BIFhnPbdllJQLN9MHKfeBPLYvv+wCHmFMqNo3FxH2cO1K40dZrT9VmEkwmf4UyE/r+64d0fQCMaLmJi9gN5H/ndFiwjXQ5ySOGojBbQx31aHsGkqd/ZFr96U2n69Jg6paW5pgOlpzrH9vYoGYUvLcdMgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by VI1PR04MB6909.eurprd04.prod.outlook.com (2603:10a6:803:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 10:28:09 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 10:28:09 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 04/15] net: enetc: add basic operations to the FDB table
Date: Sat,  9 May 2026 18:29:43 +0800
Message-Id: <20260509102954.4116624-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509102954.4116624-1-wei.fang@nxp.com>
References: <20260509102954.4116624-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|VI1PR04MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 221df11f-339b-4488-1514-08deadb5aa2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5StDrOs/tXuxdfgb9J6kLrGD6L+mPqCedWa4wR6DEeCdVn3sNTuYIWCG+/3Rxj7sBKeH9AvOCPlcyAlhnFzpEh0rG79xINpDlbJY9ZoFE/h7YTwB1l2gGN3pSpIFFlnXONeiU0EPoQgeqDPXqQfSa/MEN3kRs+hTz3WFNgiZ/7eFP6E2yvuUDPhRY984I6v/16YCIsKulNltuOwu6MteU5cPTM5k5BtjI0nrpstpx2tlVntmiaLyZzHM/UXDwp6TLQFqsNtTG9+MEExZHumB8kx1s0lhuTOjVxBAZdDmOdEPGIRkwa11wK9qDvgF4rCLIb0EWWpOkQSCczLm/WSg3eKiRsYyjjmWL/nLBOQFXyxJCasuPAkX26tAyR0s3DCswVxys3XxraR92pZeYCaJ1uxFVzqJHHvj/vZ7+S76VShGNngQOFOnXIthcQ/UXS1BVhNQP1tZnR4M1eQXGJTVEdntJGClTiBHEBFt762lVfh8tV/eEE79ZRTwpEGsdf8K81soDIkOsVmwEi459POzJBVw/s9nzETyJYxKRvIJmps6/cLxxWadEsZySdYvmmmq8oFuZGWabAmsxIDdWohoTic27cmRBWCNpJxL3lVBAErDV8gK3KBe6+tM6q88vsCQdBkhBaMpqFfwgh+MUKMFwJwJbgflURuF7w9Zt6PMgelKJ6DN6+VXg9taFw8Hhf+sicRbzJFtaGC2rzj9NGieW2iAizKEf0AeRaXPrlbcstmg9DZpp9O4jo7zx9eihe5cddWInaxBqHnhZYIHj66ORA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vSAeBRvoYpZ8XNwu1DyrYhdTi0M0DaDeQJCMUeCfaeMLJrCjfuyyHzy5/vJt?=
 =?us-ascii?Q?ma0ds7yxV54OyMICnwL9PiqziOYcWLUpAIN2Z5nEo+8SYN98O9HC/PlciZ5e?=
 =?us-ascii?Q?2aELQXo3+EHYgGDxJ7sm5Fndby4i3/gIELRkaxbtjy3g1yqear/8mxrBMZP8?=
 =?us-ascii?Q?C3HflZ7iuuTKT0izuN2hPnhpW2OPIqpfUxGCGjR2N0bqndvIf67jHR6avtxc?=
 =?us-ascii?Q?YzXXqzJYd+NI1QDh+tYERNXPcRfgkRdHhVGrjHzAEERICJbabDCfILBA2EUV?=
 =?us-ascii?Q?BTmB32nEryAAyaLqZ12fBdakqKN3e7nTvBd/VL7i4xKxWMWA7bYE2xHfTMqZ?=
 =?us-ascii?Q?VjVDPykEMsPhnJv4/EGDaorOt96mNEXNzCM1+66D6MmW58BnBopKULTuKkG3?=
 =?us-ascii?Q?6YID2eV0JJwDHyBtiFwzM4zvLQYVT0tamR6WcrWII2mFvG0/mn9ky1+bnuD5?=
 =?us-ascii?Q?1oxX1us/Dfy2db5uamzoZQLTp95nzPfDkmawEQO/iIk9mhvZ3ebGCMVXtPA9?=
 =?us-ascii?Q?teBFm7Mot1P4wciJKXgr1iGk4WSMrn/MuWPqKtTj45Y77gkgrC4cUXfunEPC?=
 =?us-ascii?Q?vH2cPcPRlXvFeIzahkIqv2gdRdd7u8FDF5ncAE4Ap9+yYyyF6+SnCw4tsxyt?=
 =?us-ascii?Q?zXW3NNS25T7pjoXIE9AJsjaiHgo0tA33zvi/V69WinuSXUebBIowWdFTSQCd?=
 =?us-ascii?Q?Trlk2OA2xVfrpyaYD0d+lVcKcVdzW0+eqIOmeFbvfKQcgg+3gxnWbYhUG3H0?=
 =?us-ascii?Q?CdTE9sGvbuRh3CEXg7ulUvE8DCyhZ77h3K2o2eSW6oCRfFGvI2LFsH28L+X/?=
 =?us-ascii?Q?fsEgVyMigS8B1mgwCCbfFH3YNLnVRoQ1+Ioe5c3G7oY6BbzneT86HlaUun0G?=
 =?us-ascii?Q?D9ulF480uKjJW3eOBru0J1wQ053uRl6OeKgb+0wHaWtx72J+ht2LorIScx9L?=
 =?us-ascii?Q?oF6ifX/YXMzUWBhuVgQk1fbVKSOkbG5/2ddhI9Pm24rTq9awuzvjQpgf707Z?=
 =?us-ascii?Q?ZFkkTSAhC1mO9/JA8Ox1/KcKqXbU7171qpBDNKGAF0IdX43OkdNN8F/dCfN2?=
 =?us-ascii?Q?5hLRJQ09G2MSkrHj8wYn4Iym/fL89ut7L8+nI6qz66T8ULpNUyLc0BfzRu52?=
 =?us-ascii?Q?ODsqHZ8pcj/UdgzaYAPqNTaEnbu+mciGfxhdeSskb1j44KY1KPmE6yGi5gbU?=
 =?us-ascii?Q?jz1v7LHJwXXVywHdLvk1Isf1j1nfrXsZpJWdIyTKS6sudJvwzNH5QAry2DAA?=
 =?us-ascii?Q?fmIu4w1NDp0bWsmwNUOp0GLrtgo/FXD5w3RcajeCqUO3MXYft5+ZTaycdkeW?=
 =?us-ascii?Q?4RFUSgjt3uYuGywhtqGS3bgZVBmdTFsY8wyp9uxb+zclPZpdoYN84rLYupZY?=
 =?us-ascii?Q?tqeBjbm4QAas1vykRqPzEEUliZJJtCRiZk5plZvyrgdcnpowoxCRdIC+UwVG?=
 =?us-ascii?Q?b9TvlfvFriQrg56CHCv1i8FBBN4ujjR2m3Ui26wMIc4guudQ1bC0237+qRWZ?=
 =?us-ascii?Q?z29/J9zSordiF7PGqefr19tUP6EMNPIblwTJvTy1MqO+D/mCyEvvTSQj/HLR?=
 =?us-ascii?Q?P7PawarMMyxzwts3ndjP2ZnlwGU8aisixzZP3aY4qvrcCCiItZF4wEpVv3mf?=
 =?us-ascii?Q?eUNpEOXLXhUPKlYiivxHlqkkf1/B/xadkcYZJTjYLJO1+kvGgz233+Hn9uuc?=
 =?us-ascii?Q?Yp4jHyddjoDRwQDiaaMljh1yrymJMBbWHT1gVbWj5ew+Jec0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221df11f-339b-4488-1514-08deadb5aa2f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 10:28:09.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1aulV7AGD1jYnLNwe1VlmpkeDDSk5Zgzu7d+R3WvM6FRwCQ8dOUE/zt8xcfyO+fEexrrr8IdbWPoIaQfF+hxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6909

The FDB table is used for MAC learning lookups and MAC forwarding lookups.
Each table entry includes information such as a FID and MAC address that
may be unicast or multicast and a forwarding destination field containing
a port bitmap identifying the associated port(s) with the MAC address.
FDB table entries can be static or dynamic. Static entries are added from
software whereby dynamic entries are added either by software or by the
hardware as MAC addresses are learned in the datapath.

The FDB table can only be managed by the command BD ring using table
management protocol version 2.0. Table management command operations Add,
Delete, Update and Query are supported. And the FDB table supports three
access methods: Entry ID, Exact Match Key Element and Search. This patch
adds the following basic supports to the FDB table.

ntmp_fdbt_update_entry() - update the configuration element data of a
specified FDB entry

ntmp_fdbt_delete_entry() - delete a specified FDB entry

ntmp_fdbt_add_entry() - add an entry into the FDB table

ntmp_fdbt_search_port_entry() - Search the FDB entry on the specified
port based on RESUME_ENTRY_ID.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 205 +++++++++++++++++-
 .../ethernet/freescale/enetc/ntmp_private.h   |  61 +++++-
 include/linux/fsl/ntmp.h                      |  44 +++-
 3 files changed, 307 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index c94a928622fd..6074eeafd5a2 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * NETC NTMP (NETC Table Management Protocol) 2.0 Library
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #include <linux/dma-mapping.h>
@@ -21,11 +21,17 @@
 /* Define NTMP Table ID */
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
+#define NTMP_FDBT_ID			15
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
 #define NTMP_GEN_UA_STSEU		BIT(1)
 
+/* Query Action: 0: Full query. 1: Query entry ID, the fields after entry
+ * ID are not returned.
+ */
+#define NTMP_QA_ENTRY_ID		1
+
 #define NTMP_ENTRY_ID_SIZE		4
 #define RSST_ENTRY_NUM			64
 #define RSST_STSE_DATA_SIZE(n)		((n) * 8)
@@ -260,6 +266,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "MAC Address Filter Table";
 	case NTMP_RSST_ID:
 		return "RSS Table";
+	case NTMP_FDBT_ID:
+		return "FDB Table";
 	default:
 		return "Unknown Table";
 	}
@@ -496,5 +504,200 @@ int ntmp_rsst_query_entry(struct ntmp_user *user, u32 *table, int count)
 }
 EXPORT_SYMBOL_GPL(ntmp_rsst_query_entry);
 
+/**
+ * ntmp_fdbt_add_entry - add an entry into the FDB table
+ * @user: target ntmp_user struct
+ * @entry_id: returned value, the entry ID of the new added entry
+ * @keye: key element data
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge)
+{
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, NTMP_QA_ENTRY_ID,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.keye = *keye;
+	req->cfge = *cfge;
+
+	len = NTMP_LEN(swcbd.size, sizeof(*resp));
+	/* The entry ID is allotted by hardware, so we need to perform
+	 * a query action after the add action to get the entry ID from
+	 * hardware.
+	 */
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_AQ, NTMP_AM_EXACT_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err) {
+		dev_err(user->dev, "Failed to add %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+		goto unlock_cbdr;
+	}
+
+	if (entry_id) {
+		resp = (struct fdbt_resp_query *)req;
+		*entry_id = le32_to_cpu(resp->entry_id);
+	}
+
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_add_entry);
+
+/**
+ * ntmp_fdbt_update_entry - update the configuration element data of the
+ * specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified entry ID of the FDB table
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge)
+{
+	struct fdbt_req_ua *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, NTMP_GEN_UA_CFGEU);
+	req->ak.eid.entry_id = cpu_to_le32(entry_id);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_UPDATE, NTMP_AM_ENTRY_ID);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev, "Failed to update %s entry, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_update_entry);
+
+/**
+ * ntmp_fdbt_delete_entry - delete the specified FDB entry
+ * @user: target ntmp_user struct
+ * @entry_id: the specified ID of the FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id)
+{
+	u32 req_len = sizeof(struct fdbt_req_qd);
+
+	return ntmp_delete_entry_by_id(user, NTMP_FDBT_ID,
+				       user->tbl.fdbt_ver,
+				       entry_id, req_len,
+				       NTMP_STATUS_RESP_LEN);
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_entry);
+
+/**
+ * ntmp_fdbt_search_port_entry - Search the FDB entry on the specified
+ * port based on RESUME_ENTRY_ID
+ * @user: target ntmp_user struct
+ * @port: the specified switch port ID
+ * @resume_entry_id: it is both an input and an output. As an input, it
+ * represents the FDB entry ID to be searched. If it is a NULL entry ID,
+ * it indicates that the first FDB entry for that port is being searched.
+ * As an output, it represents the next FDB entry ID to be searched.
+ * @entry: returned value, the response data of the searched FDB entry
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry)
+{
+	struct fdbt_resp_query *resp;
+	struct fdbt_req_qd *req;
+	struct netc_swcbd swcbd;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.fdbt_ver, 0, 0);
+	req->ak.search.resume_eid = cpu_to_le32(*resume_entry_id);
+	req->ak.search.cfge.port_bitmap = cpu_to_le32(BIT(port));
+	/* Match CFGE_DATA[PORT_BITMAP] field */
+	req->ak.search.cfge_mc = FDBT_CFGE_MC_PORT_BITMAP;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, sizeof(*resp));
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_FDBT_ID,
+			      NTMP_CMD_QUERY, NTMP_AM_SEARCH);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err) {
+		dev_err(user->dev,
+			"Failed to search %s entry on port %d, err: %pe\n",
+			ntmp_table_name(NTMP_FDBT_ID), port, ERR_PTR(err));
+		goto unlock_cbdr;
+	}
+
+	if (!cbd.resp_hdr.num_matched) {
+		entry->entry_id = NTMP_NULL_ENTRY_ID;
+		*resume_entry_id = NTMP_NULL_ENTRY_ID;
+		goto unlock_cbdr;
+	}
+
+	resp = (struct fdbt_resp_query *)req;
+	*resume_entry_id = le32_to_cpu(resp->status);
+	entry->entry_id = le32_to_cpu(resp->entry_id);
+	entry->keye = resp->keye;
+	entry->cfge = resp->cfge;
+	entry->acte = resp->acte;
+
+unlock_cbdr:
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index f8dff3ba2c28..b0b5805ac4f6 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  * NTMP table request and response data buffer formats
- * Copyright 2025 NXP
+ * Copyright 2025-2026 NXP
  */
 
 #ifndef __NTMP_PRIVATE_H
@@ -11,6 +11,7 @@
 #include <linux/fsl/ntmp.h>
 
 #define NTMP_EID_REQ_LEN	8
+#define NTMP_STATUS_RESP_LEN	4
 #define NETC_CBDR_BD_NUM	256
 #define NETC_CBDRCIR_INDEX	GENMASK(9, 0)
 #define NETC_CBDRCIR_SBE	BIT(31)
@@ -30,6 +31,7 @@ union netc_cbd {
 #define NTMP_CMD_QUERY		BIT(2)
 #define NTMP_CMD_ADD		BIT(3)
 #define NTMP_CMD_QU		(NTMP_CMD_QUERY | NTMP_CMD_UPDATE)
+#define NTMP_CMD_AQ		(NTMP_CMD_ADD | NTMP_CMD_QUERY)
 		u8 access_method;
 #define NTMP_ACCESS_METHOD	GENMASK(7, 4)
 #define NTMP_AM_ENTRY_ID	0
@@ -97,4 +99,61 @@ struct rsst_req_update {
 	u8 groups[];
 };
 
+/* Access Key Format of FDB Table */
+struct fdbt_ak_eid {
+	__le32 entry_id;
+	__le32 resv[7];
+};
+
+struct fdbt_ak_exact {
+	struct fdbt_keye_data keye;
+	__le32 resv[5];
+};
+
+struct fdbt_ak_search {
+	__le32 resume_eid;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 keye_mc;
+#define FDBT_KEYE_MAC		GENMASK(1, 0)
+	u8 cfge_mc;
+#define FDBT_CFGE_MC		GENMASK(2, 0)
+#define FDBT_CFGE_MC_ANY		0
+#define FDBT_CFGE_MC_DYNAMIC		1
+#define FDBT_CFGE_MC_PORT_BITMAP	2
+#define FDBT_CFGE_MC_DYNAMIC_AND_PORT_BITMAP	3
+	u8 acte_mc;
+#define FDBT_ACTE_MC		BIT(0)
+};
+
+union fdbt_access_key {
+	struct fdbt_ak_eid eid;
+	struct fdbt_ak_exact exact;
+	struct fdbt_ak_search search;
+};
+
+/* FDB Table Request Data Buffer Format of Update and Add actions */
+struct fdbt_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+	struct fdbt_cfge_data cfge;
+};
+
+/* FDB Table Request Data Buffer Format of Query and Delete actions */
+struct fdbt_req_qd {
+	struct ntmp_cmn_req_data crd;
+	union fdbt_access_key ak;
+};
+
+/* FDB Table Response Data Buffer Format of Query action */
+struct fdbt_resp_query {
+	__le32 status;
+	__le32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+	u8 resv[3];
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 83a449b4d6ec..4cfff835954e 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -1,11 +1,13 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2025 NXP */
+/* Copyright 2025-2026 NXP */
 #ifndef __NETC_NTMP_H
 #define __NETC_NTMP_H
 
 #include <linux/bitops.h>
 #include <linux/if_ether.h>
 
+#define NTMP_NULL_ENTRY_ID		0xffffffffU
+
 struct maft_keye_data {
 	u8 mac_addr[ETH_ALEN];
 	__le16 resv;
@@ -29,6 +31,7 @@ struct netc_cbdr_regs {
 struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
+	u8 fdbt_ver;
 };
 
 struct netc_swcbd {
@@ -68,6 +71,36 @@ struct maft_entry_data {
 	struct maft_cfge_data cfge;
 };
 
+struct fdbt_keye_data {
+	u8 mac_addr[ETH_ALEN]; /* big-endian */
+	__le16 resv0;
+	__le16 fid;
+#define FDBT_FID		GENMASK(11, 0)
+	__le16 resv1;
+};
+
+struct fdbt_cfge_data {
+	__le32 port_bitmap;
+#define FDBT_PORT_BITMAP	GENMASK(23, 0)
+	__le32 cfg;
+#define FDBT_OETEID		GENMASK(1, 0)
+#define FDBT_EPORT		GENMASK(6, 2)
+#define FDBT_IMIRE		BIT(7)
+#define FDBT_CTD		GENMASK(10, 9)
+#define FDBT_DYNAMIC		BIT(11)
+#define FDBT_TIMECAPE		BIT(12)
+	__le32 et_eid;
+};
+
+struct fdbt_entry_data {
+	u32 entry_id;
+	struct fdbt_keye_data keye;
+	struct fdbt_cfge_data cfge;
+	u8 acte;
+#define FDBT_ACT_CNT		GENMASK(6, 0)
+#define FDBT_ACT_FLAG		BIT(7)
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -83,6 +116,15 @@ int ntmp_rsst_update_entry(struct ntmp_user *user, const u32 *table,
 			   int count);
 int ntmp_rsst_query_entry(struct ntmp_user *user,
 			  u32 *table, int count);
+int ntmp_fdbt_add_entry(struct ntmp_user *user, u32 *entry_id,
+			const struct fdbt_keye_data *keye,
+			const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_update_entry(struct ntmp_user *user, u32 entry_id,
+			   const struct fdbt_cfge_data *cfge);
+int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
+int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
+				u32 *resume_entry_id,
+				struct fdbt_entry_data *entry);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
-- 
2.34.1


