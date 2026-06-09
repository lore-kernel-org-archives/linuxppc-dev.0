Return-Path: <linuxppc-dev+bounces-22298-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FEDCD6E79
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 03:27:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZDqZ1ylLz3brl;
	Tue, 09 Jun 2026 13:27:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780975642;
	cv=pass; b=FLb0vVPZdq03uZQNN3FvnsqfxYtR1tN8V/OQM0GrJ7RctCn0CzeopWrOuXRXUiYCRQ8lMHfMvLfUIGbwGCbmKnbGKedZ+0IRSLz/mK+lzxVd/6xxMyIcHsO4oaLoW1uyfoysgbINk5p6VnUh1a3F6Ac6lrq8eWPHtacv69dL2azvHIgPZYMn+6A7qHjBcWRm3ScNUMvm/5TF/Yw2spFsrf7X/tiuNhVudgY/3erRVtGvxJbjD/zMZ+r3T979IV+rKLG2E1Vi58UypHZKczoI/I/G14ZC+2eB5s0CRGZQn7VK7fykyE4+qg1QT6P8VRCrYWhs8ovPlduGvnORNvqJgg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780975642; c=relaxed/relaxed;
	bh=xPIjIj8PCZdtQNvztWwE+3hzAZNMvxpMCkaazKnjtLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHNO/IZqR4FCNHWtwsvbSBLRRSjsCjAjmlHKTaGj4oFjgaFHkbUt+Y0CFpKlcxZ2/qmIw4FR6ryM5uuXWC0DqueeU+XujvFmBtMR9vyvedXinT5R8w+9LkMYxQTHd6cuyMkSKzZTL7x34ZVvTRTphUSr8HZsSxLsWjQ/DFLilarlqk2AEvurCc8oZGFtM2xbHIH5+JYieJK015Lcee+EWuFJtiKcI9KR8lUoR9TYgMaSktaHcfrV8mOT0T4K60Mghoom3l4pug4n4QFHBGIH+vDWP87HaZtomYYgf/jYiBxN7SNqoTk2h7G81NE7URbGwWYhWsNWdR0qs2mYNRGeEw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PJvP9Rm7; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PJvP9Rm7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZDqY0YR5z3brC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 13:27:21 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E79SObhUzc2CnsXgEYtgrDZsBIs/zLZUHqQfYwiLEgiuLI/Wyh4CtOf9aC5k15SONW+gnZlTwrPfsIJxIkeo/7cVQSGS/0KlCyi8QZFXyup2HdgZKCbr+tBet6hhhXyz1TDS/hn3/cvzcOhbvWllPSYqD23/Nx1hsn9JAi2Hpx7xBH3EeawZHECay7Fty26TJAOyEk8encMUEaONhIyY9XlU7iGOjcDGSAH3oPH+4GOA/CCNMlfuRkSwJcwLCtVe/mxFKkto5nJ8HbRnkP6iQipqYkI6LbY9Lzgu+T4g0IaCYvt+9A8WAsyWSJpVetYnn6sDyGxUvZKzEqBys6pmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPIjIj8PCZdtQNvztWwE+3hzAZNMvxpMCkaazKnjtLw=;
 b=DmBDUtF05/tK89LIqRwi188wtIPywNYmtA+JoogPXLbUQqYc1a1R6+QlIe73MXsjjJp/XSK2K07mrThL3DU5pw77ZFrPLo1JRLRpmxGibZ5gZuHfCe9hy9itKvH/LwC2NbJ+pA/mwsk9C07RtaOLxrPpM0rOJLQWaxL+1H5LwHc6OXZNmupvKvskx2ILJ49VUz0+suB1BNNmU0gTaKwhCK1fbtr5tg15RDw6PoPW7xvMVdZxwBVoYgW48F6b7bL0DKbXaJdGFO5wUhtJCwGwoCQV5zYw01gUGoU1+UUR0llGgGG3zWdDjQvQSLt13jDD4zXtol7H7TPAtjVvythrFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPIjIj8PCZdtQNvztWwE+3hzAZNMvxpMCkaazKnjtLw=;
 b=PJvP9Rm79xhoLcefPrVLAZrW2vHIjGMtyXEkMTUiUYZmIQEtxU//G+4sdpe4ZOmqrwQBhZhNRIt3/fED9N8hxqgl2v/BCO4VVYfU+8hRMEFf84n89dTyflNxJNxtSm1VWzMYAl46f2gS8AzDfz0quuUyPCYNe9Hqzf5IThW5Az88ufm89FGg0iuARdPpSU9Y37H5CGxdggE9P/IYyyNjFvdHbOURroDZC+mksVUVz+LmVRPd1ywFpyTSEQVxrFiH0rmLD0+qgMb493/riJqAIF0OHAQs8VSYLE9DFNm3GwGVDyx2VncD05HhbmwfzK7dXgbR6z0U+/dhz9xgcGSt6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 9 Jun
 2026 03:27:10 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 03:27:10 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	chleroy@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	linux@armlinux.org.uk
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 net-next 2/9] net: enetc: add "Update" and "Delete" operations to VLAN filter table
Date: Tue,  9 Jun 2026 11:29:48 +0800
Message-Id: <20260609032955.2066089-3-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
References: <20260609032955.2066089-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0192.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::12) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cc2112-7b0a-4adc-0cfc-08dec5d6fd51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|22082099003|18002099003|921020|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	C17NRNs7MZoASjpE4BssWkZUArITBcMM83b8Gc0duJHvXZYHU+0gVw5zFScdVmgDM0yKG+qvZuUP4RCFPTCsqNB8ljXyj6njR/D+AyZvdXGVferLRQDicEba/g4by+8mQSburwGRgshyS7ke5q0WFypG53j7yCMMWUElPRLjcA4rE+RpgZBtzZbhjOtFWC8LLVsSSEbN0OPRlyNwtWskJIbZGR2Izic5bOlpSxVy3J3T6eTld1boVAyLQECtTeaGEZ1cx/NFaBIGH3BF9ko15R9MkM0jLkEI/giNZuoBNFo+CAHs2WvF736ffpA0bMyzgB7G2TgDpnEJOhE7TC74Zkk/MG4ER4to1z1lzU0tbqEWH0BaTzzhNE68A0HCgLNr2M9N25S2hFafvfNpsU+RsqKGxS2an5WiR/WCmE3UNmWy4c7kCKzYXMOC8OcfIurIDxcdbE0BstVk4VJr59tHMA16VAhO8PUKW6nzv1bwg6nbr/2ca770+wBFvfv0GrMANl03JJjZtFGX7JU/Ek/rGXUxqwLPnMUOiSoca3EFDAIZZBPNnHL6TySIgyUvs82ktdKcBgTo4uGQE5bVOr5G/a8GyNw4VjRWx0Htkv7fofrLLkR5hdSD2yYaceuMTnDGjWQSmo5PcwqXQDQoH6mv7t/SVUfWzMVYbxnRBuv/YW3ze/eXNtEnlAEyk0zwaxKMLEnT0pf2cbOFdr5pvDK+DQf9zcQqcJ354Y4NJYtcrl4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?scpHxQ9EPRddI4ZQKtzjaJxUKBTSHCmFG13/GKIB/r25E0anVgfK30PtzVT4?=
 =?us-ascii?Q?iHewzWNh4sBntvSBGIbRc2czZkU4Ht7TLJEda732QPLSLESM8dBPa8xEjTjq?=
 =?us-ascii?Q?imXKAOpiDhCXXb0fCmN/rXP4D/cOlZDOdcr9rmSdOTZGbzRVR/IxlZhV3jBe?=
 =?us-ascii?Q?bgsN6njiUNqSmIhdEADV5RciSRNv7uDYmwEhm9JWWCcOqALPUZTGqJA6w3LB?=
 =?us-ascii?Q?dZlBL+jlNeLg6F6wBJtpGh3zRDLfNwfFIQoWHZtIw6+twn8uqEAzCQxa88Qw?=
 =?us-ascii?Q?0Gy4qcxYq+W75ZFaT3b1aBGHdFGEu1pXpZbkvDnvzzc70iWGiohpg2/VqVun?=
 =?us-ascii?Q?WJ1v4naSg1qY61v7bBMV9cWKFZTAK7Cj7WgEkxS6i4RdY4Rghv0ohs/DX6eb?=
 =?us-ascii?Q?vbUqucX/3M/bPk6hcCI0xDKepXs0MKlKwPT7fCWCksyk5I8q10bY3HtEq8G8?=
 =?us-ascii?Q?AFAz2oUsNVujnTYBuAASGCImBcsFElg2nnIIHbG3l1AvXuslHR0vd0E1Bih4?=
 =?us-ascii?Q?j/nA44P9f+t/Y4T8tDd8WNuD8D33IQh+kXEt5yFpbG4tA53lDvDC3c8wRECn?=
 =?us-ascii?Q?o19+N8BPaLpsCVfMqaimDTFv0NmV7f/IbLHmBfzg6i4/ankzKZxRbAaBotCV?=
 =?us-ascii?Q?X1czCydjhx8HObMuo4jQDJG5vV2+PJJlue3Mn5dO9nL2cPzbCGuKD7yWjqS2?=
 =?us-ascii?Q?RiO6C40tYEC16vTuBwe/rgRkpZpxd3hByc/8oaLjpzm5jfn4sSNGVQm6G7Zr?=
 =?us-ascii?Q?/mG0u7Xbu9WLuasxdFOGZ7+45SwjByYtP6RaRBUzTNB/AuvAYsLne2LdPqF1?=
 =?us-ascii?Q?787qXX6LLcDPOKJs4BsUbZlEWAmqMJX/7VEpOqKrtA4YbM0SqGPo/enwYiYP?=
 =?us-ascii?Q?4RDszBCauAsIq++OLNlrWuP1fCW6mlYBtR2fW5csrycueLUMQqAcQ6Tp0Mxn?=
 =?us-ascii?Q?MH0EKlRtFIzFLww4ut9YBUfuF5yU3+g1PlZntCi6e1Dc/PN/hguBO1w3b4vO?=
 =?us-ascii?Q?fSPqi1I3kpGxs6px9NpVG5QADse8IrBSkObmoGTu2lF09O2z5Bfesl49LcmK?=
 =?us-ascii?Q?YaPqdsWOALh8FUikBpknonDC7SlObSF2x8WZGXTe/PyUrJDRKb4A2BS1tH8r?=
 =?us-ascii?Q?Wf4ReC7cs3SA5KXOGQMyWt9C156rBvXViCjhcDjoRHyZNdW3TgzfAjXrfQ4G?=
 =?us-ascii?Q?vOAaJ2HBWUh/vZqrJg340D/0d6NWCEeu4mAHMi6TW7bo3f+/KT+QetcdQFfd?=
 =?us-ascii?Q?RGm0/ff4vkAtnm1xlDs7v93mCb//oGN68RF1eEEJu4EazcyECnKsc4OkOyFC?=
 =?us-ascii?Q?c9hcInsnBjTidchpUW0cR3mHI1Abju63nJpDzndhEuLDPp2B7sr2jjlF0QrM?=
 =?us-ascii?Q?fN6paU7rJufxwRRINBdk95XwxC6ez6PW+EBtwdXOfpulnb+tBQJ1DD+b93rn?=
 =?us-ascii?Q?O455oXnc2/1b8hszBGVeQea5VrHmgEb/zYEEdmCcBhbHf0lSMTVMY4aEdri4?=
 =?us-ascii?Q?Xcfr4Oxc6ihdjoCWcmvANF45XF2r5GgQIcXvMvDRg5xnjCQRU8yS0F3NoTrv?=
 =?us-ascii?Q?quYxvAAoAncQdNOGAdPhp6woNmz58CW90nEB5lLxB4RJx9LV81vUmIdCT99N?=
 =?us-ascii?Q?Cy8NZZ2X3ghc+gLjqgyhSBLnLDXIUHBNKDJQcQ1ZWJ900Pzn0xc4ccGFrFfz?=
 =?us-ascii?Q?peio3VtYlRv3vuxTb1kI1ha48QDY9zOZaZ7mP6vrdHcLBV0odllpc1BL86dy?=
 =?us-ascii?Q?5AR5XQhqKUnpSK4N1lHMotxngto3gcB2MbPkDaRujQPTB8Xs08C8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cc2112-7b0a-4adc-0cfc-08dec5d6fd51
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 03:27:10.0555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4MHj+CAJ/drX5MeKDZ2/+IND//HNSoX1fs9UlusTaC3OxMBtwO8yEFX8Ybh/TaQuen0tdD/ZXH5bbmPo5pNKm2IiYPqW6hvtdumWXQe+EGpOVcftPeLdHRTB0h4YgA8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946

From: Wei Fang <wei.fang@nxp.com>

Add two interfaces to manage entries in the VLAN filter table:

ntmp_vft_update_entry(): Update the configuration element data of the
specified VLAN filter entry based on the given VLAN ID. It uses the
exact key access method to locate the entry.

ntmp_vft_delete_entry(): Delete the VLAN filter entry corresponding to
the specified VLAN ID. It also uses the exact key access method to
identify the target entry.

In addition, introduce struct vft_req_qd to describe the request data
buffer format for Query and Delete actions of the VLAN filter table,
which contains a common request data header and a VLAN access key.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 103 ++++++++++++++++--
 .../ethernet/freescale/enetc/ntmp_private.h   |   6 +
 include/linux/fsl/ntmp.h                      |   3 +
 3 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index bda26fe93b8d..4e60bbc38cfa 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -956,15 +956,17 @@ int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port)
 EXPORT_SYMBOL_GPL(ntmp_fdbt_delete_port_dynamic_entries);
 
 /**
- * ntmp_vft_add_entry - add an entry into the VLAN filter table
+ * ntmp_vft_set_entry - add an entry into the VLAN filter table or update
+ * the configuration element data of the specified VLAN filter entry
  * @user: target ntmp_user struct
  * @vid: VLAN ID
+ * @cmd: command type, NTMP_CMD_ADD or NTMP_CMD_UPDATE
  * @cfge: configuration element data
  *
  * Return: 0 on success, otherwise a negative error code
  */
-int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
-		       const struct vft_cfge_data *cfge)
+static int ntmp_vft_set_entry(struct ntmp_user *user, u16 vid, int cmd,
+			      const struct vft_cfge_data *cfge)
 {
 	struct netc_swcbd swcbd;
 	struct vft_req_ua *req;
@@ -973,34 +975,121 @@ int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 	u32 len;
 	int err;
 
+	if (cmd != NTMP_CMD_ADD && cmd != NTMP_CMD_UPDATE)
+		return -EINVAL;
+
 	swcbd.size = sizeof(*req);
 	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
 	if (err)
 		return err;
 
 	/* Request data */
-	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0,
-		      NTMP_GEN_UA_CFGEU);
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0, NTMP_GEN_UA_CFGEU);
 	req->ak.exact.vid = cpu_to_le16(vid);
 	req->cfge = *cfge;
 
 	/* Request header */
 	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
 	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_VFT_ID,
-			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
+			      cmd, NTMP_AM_EXACT_KEY);
 
 	ntmp_select_and_lock_cbdr(user, &cbdr);
 	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+
+/**
+ * ntmp_vft_add_entry - add an entry into the VLAN filter table
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_vft_set_entry(user, vid, NTMP_CMD_ADD, cfge);
 	if (err)
 		dev_err(user->dev,
 			"Failed to add %s entry, vid: %u, err: %pe\n",
 			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
 
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+
+/**
+ * ntmp_vft_update_entry - update the configuration element data of the
+ * specified VLAN filter entry
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_update_entry(struct ntmp_user *user, u16 vid,
+			  const struct vft_cfge_data *cfge)
+{
+	int err;
+
+	err = ntmp_vft_set_entry(user, vid, NTMP_CMD_UPDATE, cfge);
+	if (err)
+		dev_err(user->dev,
+			"Failed to update %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_update_entry);
+
+/**
+ * ntmp_vft_delete_entry - delete the VLAN filter entry based on the
+ * specified VLAN ID
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid)
+{
+	struct netc_swcbd swcbd;
+	struct vft_req_qd *req;
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
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0, 0);
+	req->ak.exact.vid = cpu_to_le16(vid);
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_VFT_ID,
+			      NTMP_CMD_DELETE, NTMP_AM_EXACT_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to delete %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
 	ntmp_unlock_cbdr(cbdr);
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+EXPORT_SYMBOL_GPL(ntmp_vft_delete_entry);
 
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge)
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index ad532b059ba8..9d30f128849a 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -211,6 +211,12 @@ struct vft_req_ua {
 	struct vft_cfge_data cfge;
 };
 
+/* VLAN Filter Table Request Data Buffer Format of Query and Delete actions */
+struct vft_req_qd {
+	struct ntmp_cmn_req_data crd;
+	union vft_access_key ak;
+};
+
 /* Buffer Pool Table Request Data Buffer Format of Update action */
 struct bpt_req_update {
 	struct ntmp_req_by_eid rbe;
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 5db078e1caa0..36a9089526ad 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -268,6 +268,9 @@ int ntmp_fdbt_delete_ageing_entries(struct ntmp_user *user, u8 act_cnt);
 int ntmp_fdbt_delete_port_dynamic_entries(struct ntmp_user *user, int port);
 int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
 		       const struct vft_cfge_data *cfge);
+int ntmp_vft_update_entry(struct ntmp_user *user, u16 vid,
+			  const struct vft_cfge_data *cfge);
+int ntmp_vft_delete_entry(struct ntmp_user *user, u16 vid);
 int ntmp_bpt_update_entry(struct ntmp_user *user, u32 entry_id,
 			  const struct bpt_cfge_data *cfge);
 #else
-- 
2.34.1


