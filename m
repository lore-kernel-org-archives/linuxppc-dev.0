Return-Path: <linuxppc-dev+bounces-24439-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80134C44512
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 02:13:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3PFL2bp6z3c86;
	Mon, 20 Jul 2026 12:13:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784513606;
	cv=pass; b=lxrRCA+e2PqGCJYyGvViLE/dQXW2Ztx8FdjDlVrpTs4uOHq72n0JsMVKorlzCW74MAWWtMJSXUXNPwfrclaPhe9kQ2GQLJ1hKnGQg4lEYqhh6e9bJtu6DsieMfD/32s8PD47Nk5bES8R9ocHNOEqDOXGrv2RP3jWYNfNk8OhCUKKlQ3/Vzbj367B3hqcJ9Ufh502BDnezisqfwX5tZEozAZFS8trUruEvM2gUxPtYx0MlC6PDHbrB+pcmoztpPjZQjlzSd95+O1aEkKhnqVzSoRmotVScJ9LSw6nHd8RQwPJC3q7+VX3Y0KlBoPOZDUezMfDmw/skruVoo8L7rgWuQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784513606; c=relaxed/relaxed;
	bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CX12A6Gj0LEYoprYaUNG1a4qU8NuAbk+86cMaJIpWRpNDt62unAuNfxfgJvaZx4sMlyElqSa7ZadGbp4KUdvUX4nP420WOGCTZkW/WxS1cdsdfRR3ngRzJPMkWxWTkGXOEZ2L8AY6UJ96yYZp4eHOpyFsuSLXboKRIzdBbt+zBUEi47EUaRc9R4C2ottPuikrPBhlwg+8nDJqA+hTJRU+kHrjF6e7VOSpP4dC7nCvT8Bjl/KpwUJ/H7MRNbMUc5sIe84W825ygRXGdOFdeIyFliTcPSQpFTgFNp1QkQmnREpMUweWyjU+ItdtgPerQwYsQAZFF0tFWviLP90RtBKKQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uva8wlZI; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uva8wlZI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3PFK4LLdz3c7M
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:13:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMlPoNv17czUem73bcdDIM9yI6OvHjbJuNwzUGF8qIlYmDE/nDDBI82N7WcSJ448pXoUKiUiOr25arC0LN8HADipzc844+knIAIkJK83XWtQe2g1IIF9wg6IQ7eUa4FEtF7G+ggIn/DS6Gy+0HEJms4DXKVuphtjg7gACyPG7j3m1LZz/Zww3dXJdZCEqH5bXrnMVucCOoYPN+K7LfA5ssONhnbAyng8bFqDeV6o6uqqy2fR8JrYelKH3BpA/kJ+CjGxqpCtvkQ6skDOMEzt5PoOUAzvsTnXdETAag0zercNwlZl1fRLL6DtY91zksiMpvWBgTvsk7xQcQ49OPU4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
 b=W54RmA4sUmW7uNKjLDVfjHGvufcNGomAi5fUruoaL380REDSbQ4UJS15VwexQmKl/27Gfub7HV4OGO+aIBRIn8Vjmxu1S9z5KjXew6oPcGoXgyT8TO7GlLEZWPriGESKjBuuS+C1afF0azKXArKhZLz5J+kZ0YindLspI35fvy8GWiE4Z/SBfXBiirW9Vffw9cqUx7O3sq/U/odFJi0P+lY4ECj62yEHQl6ZSiaXQez9d1BWLt0ZAwkGcDyapoK1uNEKB4lUEbGOLLYdGYMxQ4OjQyZJ+qKFH9tWUByfZptLXKqS0MIcbZDDDZckNTtOgvauIkIAgEMe/86weZllpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV8Ikb13ip2x5qNT/bfhYmUDt+DWXX5h4YDEVsNj9z8=;
 b=uva8wlZIenG37netasSWlcMx2l0ZdiGKVq3nnn/OGI7tncfcbY2gz8iaSNC4IN8bnh6LKHIaH73KYEWJ3RJ7zZ5ztv3eZ6+ySrZEPFuB2uWSwUy/Hdr3F2ZIlZAsqLb0Ufjm8GQ1rkiFRfMfKWTw5h3Tq0MuaNJ7gigRw9NO9OSVWUFoBRz6E1vTXPsKGkHlL/yAj4m8JDQT1JwEhKpHuHcRPwu0hQt/KvDvO/PDsLjB98fVDy8HlTjeXy9HTBfl1rjrZmMD0mA45grO3MgnTeBAkfyVXwBGgzZoLr8lPbwBGmY+86oIwnOd4rewbEQEFN1kuZZOCDgCK4BSJ6XS7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 02:13:22 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:13:22 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND v4 net-next 14/14] net: enetc: use kzalloc_flex() for enetc_psfp_gate allocation
Date: Mon, 20 Jul 2026 09:43:16 +0800
Message-Id: <20260720014317.1059359-15-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10872:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad3e2cd-fec9-4728-e092-08dee6047956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|921020|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	fhURm5iB51l/uPObKs0z8mwcjfm6WSDzrhNufnaWAgz6A23DCIiai3tSGchw9KGXLjTtZAW+ce1KtwMiGryIOiW3P+LYwv0S7DJmLMi6WlWWxSlk4t1L1cm3FsX1wE0szWXpGMO2Ru9A6HWtYjm5x4C8/Xf6ZPYlGfhCxseT7T3KGlQ+p/UZTsZeFBOOl4b1V1Xxzz5eiIazELRaf/g4v086b89tNOiAN2RAhQQt3IPDJSzNWG7h9o4bN7BiTMkpVMs0HFWXz1kYo/nSpBzud0zAH4KJkVFoZNpYBOMSXtBPtwM2GHueYjyVxa9czldA6hIZCnrH6srdROTRYZ0aG533PkqJSkAhmiBhpjGXkr4uVYDxe2NVaAYVrWbZNxwlEv6NAk4pA3k2vEhnMglZ2BJN42IzFuP4UlqXpKbqBXM84Ljs3Z4GLMmxGRlJVleI5QHL3KKHMOjMMfwpWdRpfLmxEFcFsF1yuSv384U6MHVT67oAT42lIZBOQr9kmqqCkcNW/Tf9dff7JnPdtzruI9y2471Bs8Jfci3kn0XY+CephfseZKyRZa1pqY6KcSc0CG7WC0CfeZiciZK6+16kmq1V36qehHfr/TIfuiCrPNQROOG4IoKFE4MMxJwbBPAZ2VWhQ0Zl92MyEGWCqkcCJRwSCd6p+H3jk5+ee6J307CllPl6eVQ2daQ41b3IP8/lkY0Bi+0sGtxtE6qhMGfAog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(921020)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uRxVTAuSW5BIADJr2i6Uq6dCKrnIB3fqvipS2p/gTtjISWr5HvkrJsjr//cr?=
 =?us-ascii?Q?SDjnjCPf0GyTSKHzZBVlfAjXRTM8TzWhb4ox1gYx+SsnLRVebSRD06fQpUcx?=
 =?us-ascii?Q?uES2IJ0R/IF08CQ5YbHJKpTe1nuC9TYIr3gUoDYQ4OuVLDBaSOKTayW9edqD?=
 =?us-ascii?Q?XKxlqymPZQ7DCMjUE1boPKmkMobtuT40PpXMi+zFAwjYvox+C96C7C0h8TYz?=
 =?us-ascii?Q?C1YWjBoNte70MmeRhxUCPNaGMrCk4Pt57SXpN8VCUGhK5E5JXYoS8oC2xPU/?=
 =?us-ascii?Q?40X/0Fp6K32LwQVoKRSd2+lVvq7kE/8M5wauzakYY7GOEL7EoyWl4vTRHhrX?=
 =?us-ascii?Q?3xH4APo1GtAnOo/8IU8rgmvmMrsZsYDOK85mNck4CsGAMPXSUALhYFQZ2yGX?=
 =?us-ascii?Q?/FT29kcTYsKqjbZxbIw4Bv2F07uZL2XK1kw8cF6F3XNNax8yBHQl7pePC84Q?=
 =?us-ascii?Q?qX7h/7fEnfqyH0HytQAKy/k7UzI7/Xa63JZhNXu89F2jat7eWgV4tCd9Unii?=
 =?us-ascii?Q?Av/tUEvq+2w7qZG++Tx5ueeV6uFIRq/J3LaqPyk4isS0TWIHoXSgmjC60g/N?=
 =?us-ascii?Q?iBTaD3lcEexmtA+hWDxvU4RAttZMSTnG4Uzi1fvyDxfDcqncwQPOQ1jQN5jS?=
 =?us-ascii?Q?jz+N59wgX6yV64VwhMrcjDeSLadFm0w8gGpDAKP1uBLZbyG6Q3hK0vaIGgL5?=
 =?us-ascii?Q?hyMwHAqtGRYQ0+w+NhJxV7+e6c0dFe5GIo9i5f4CT7Ys7LzhIJ6F7bAq2SW4?=
 =?us-ascii?Q?npQh9XFoAZIElhqSPIT6A7IXOALOthWYANjDUiHKLDxa7VCXNzvU2VbUwt1b?=
 =?us-ascii?Q?N8/gVB07ww3MYuGEyb5EkIPazWIeV0TCUYf1iCSQuDlVefIOf0VnP5exiyGd?=
 =?us-ascii?Q?DOCJDNhNwhrs+pBrbeTFrRK8HoZwE/txV209CUIH9KkCJgoAv8JRusti829s?=
 =?us-ascii?Q?P4wyPGeDFg2t1ztTa/HDuyTly/HjyAnHQ+Nw6774nXKaZRiO6SNbG/8PfIzK?=
 =?us-ascii?Q?821w6R9HqjsKrcygdY/nSI4imbTDu7bS3TZizTC/0CQkbfh1aIb635sw3YsJ?=
 =?us-ascii?Q?bE6lTrJJnX6GbU9z39RYA9hVVSBC7gCqU+nuQkP2yFy/HAa3yGhrmrQ9HtgP?=
 =?us-ascii?Q?cnXneGxsg+PNZwEurFGMJasaO3frHcGvTn6imPj28dxFt4kkcFSkh9fLCqLd?=
 =?us-ascii?Q?zu+f194l9IGMhnAeTyXcwcCbHTkV4PIMAcscabfOERbkl/pprrpdtgkmDlzl?=
 =?us-ascii?Q?KcBfT7ii8GF8SKv7TbDFnumQ3vrJeJZKHoWM+cOQdkj7MDe0fCXAZl768FMm?=
 =?us-ascii?Q?lXTDTVbEC2RLpDvu02aV+CGFSsnOKp4sSiM5ukS58or479N4CyJ6mwMirAWY?=
 =?us-ascii?Q?Col80wus7ycR+o5PuGYCt54Ywl/9LU1ODwDhafNORq9a687ouBkFEnT3/Ktl?=
 =?us-ascii?Q?nAdJuL8hOyethjMPACJuvFS7riqF916JGX7pS/w/f6VyWnrvPoKjno+aDXHQ?=
 =?us-ascii?Q?55bGVo60qb0JIsEumMcUN2VSaCBT+ice9QawDv21+tYuuLe8iKf29389mp7J?=
 =?us-ascii?Q?iBMCp7AMNUbfkjlDz59iwHWExbMLsIufdeFNUL3c0kfkc1NS/evBroFLbC06?=
 =?us-ascii?Q?ThsU1+X1HPTbFRipgyvjJWTRFg7XpidF4ph3Iw+VBsp4PMpegOW3QEb7Nnsu?=
 =?us-ascii?Q?li9saARqNssc9bV8tpclZdwP07VW1w6ZtBEBcxR57fOp1cebVmkUakvPxWIP?=
 =?us-ascii?Q?Turk7RgYrPfCYASIPU1tJ63TP4M1J0TXvpXiAvt4XVf31iGJjc37?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad3e2cd-fec9-4728-e092-08dee6047956
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:13:22.4210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGteordaMbLmkufvgiEjWTlpOLd9aN2Vrou8GNhGUZoi8tscXHfZMwWBO8MoZqbX+ctZUedoIB1O86oGcm4dCm2dAzR5mE8sI3JzD+AvNqyLbBjKGtMkzShN9KaloV/1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872

From: Wei Fang <wei.fang@nxp.com>

Replace the open-coded struct_size() + kzalloc() pattern with the
kzalloc_flex() helper when allocating struct enetc_psfp_gate. This
removes the intermediate entries_size local variable and makes the
allocation site more concise.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_qos.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
index 7b17bca24f26..2aa0fcaafcd2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
@@ -1135,7 +1135,6 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 	struct flow_action_entry *entry;
 	struct action_gate_entry *e;
 	u8 sfi_overwrite = 0;
-	int entries_size;
 	int i, err;
 
 	if (f->common.chain_index >= priv->psfp_cap.max_streamid) {
@@ -1242,8 +1241,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
 		goto free_filter;
 	}
 
-	entries_size = struct_size(sgi, entries, entryg->gate.num_entries);
-	sgi = kzalloc(entries_size, GFP_KERNEL);
+	sgi = kzalloc_flex(*sgi, entries, entryg->gate.num_entries);
 	if (!sgi) {
 		err = -ENOMEM;
 		goto free_filter;
-- 
2.34.1


