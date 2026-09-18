Return-Path: <linuxppc-dev+bounces-27677-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D9AC982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:25:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmPL210Ltz2yqx;
	Fri, 18 Sep 2026 17:25:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789716346;
	cv=pass; b=l1q8Hp6BGMPuEKcxy+5n4d2esT01mZT3vWM4bTIr/z2xd9PxZ7ptWc4Is7p0WB+CDdS3XKJc7ZoWNijCXA9DKo+8L3YlkJ7bl1vJ9653wdtj1Wu0CWg4mGtTKCMTtpxQFfCgnZkOy9gYtrmF7vSRZq+q/w8LXAOOLmurDYULOjy7AnMjB3MnB6SZIZak/rp6yD354P7nW2e0voqU6ClYXueTRm0GevzgYJat+qlIxemV11Yt+uWOD+C9v+HIZlQZxTA3mjFWVciCVdxJmreCW8NiOu8bgIfXWTBPQ4aKlZJkZkGCFYQ+aUgegOieYQnUlfdviTI6ybjH6LCAcAHbtw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789716346; c=relaxed/relaxed;
	bh=0XSrdEwNFICcjMzRn2imRUNuG3r2khLp+ZBIuMm1+dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O/tfdJxd+pIyJ0G09OELBzZejcU4W41pXcRlPDnyU1802M5Inr6McnE6iAH7/Lur9w9ecBWaZzi4oczHYB5rXUJy4mhvKxI80GrUpOF9m+htUdjh8AtUpm1rg0afit4XDW4YOvXFvoBZgT0bNlQHsPohUhd6DU2gtNKfhUx07uXaCLYNRkHggOGQVlyuEkO5vH0zioiU9ptZYQ2tRkQoc6SqobsZudeEAzgAscJBEnOqE5orXjCou/HRpF5UEmgzjTkT4xyGlp2CbQwFIg1EKxtsnFdf3or8YatXo+bguKmJMcpPSrLXWBQ1TZB+i6oijv5iaBbikSNgfO+YBUKC+A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AWbWkzqW; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AWbWkzqW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmPL130Xsz30dn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:25:45 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RacaZgFNVxzDonsJzaCY4/Ohnabv868bdMz9p907g+3lKvvyrx/aseU9onJgGcyuCC4Ukd2iat9nAEccmt87Mf6AaZs6EMT3O7NqZhiraxE5s4SaE7ZNXficdKHtOzCpvKXXKiprbcHHs6oI0ea5DR28dzaUFutdqgOj3BOhCvELcJtTKQVk1JX7FRmSqUAXxNucw6vSNpz41GBaU4/6kiV5DrVPbCwgE8j7dL/YESkXMSzVYMhlUyjcdeHNtnkmBal9whKrfdh4Upc37RjcTySDJy2m7m2P/8X1MwWlxZtxfRzph2f9whLxaWGgdGORC9Q3sxpQpBKaiFZYPFBSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XSrdEwNFICcjMzRn2imRUNuG3r2khLp+ZBIuMm1+dc=;
 b=aiRdcLqS/78BSkQPiOau1Fq77q97cQtXw+b9G156Pq49Q8s829glar2dwNGJSG+E6gGTZzakkND/VmvCAqj6CruIk9b9LLUN86meOOMwPuDk6vdqbFxD4hk+HHlVzUvlWqNqrnbHooxgb6vFr5Sh0vFo8AzY/bVwLWEg8fvYB8gFK5uTP8hUSlRA4kJ4qzjo/8nMeL0nbNQTwSvMhR/9UiurSVFPSm79q99wfpDla6Emjxg9FnIzOHgtSw9GiI0oA7X8dljQ2DkrK/Wq9eqwubEFxbDZrjCGuyuu9M02Q+bMNCmrDDwviKaXH90HwQgOCD3JgPwoFaeHZfWokWO6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XSrdEwNFICcjMzRn2imRUNuG3r2khLp+ZBIuMm1+dc=;
 b=AWbWkzqWx3K9OPOXy4yvSyoCo9HS6jhP4Tlf0LCU29C5eN3Ctd0yqR7zcpQroLXR3zq2u3v0tw6JRB2qRqWH6+Alq9RPkOjhXeiUrjzw2HT5GgjkMrRksn55z4lCrARtYkte1xkD5OGi6g5YVRFh1HeFrv70ep81WyAg4/CT0XPH62ssCWC4eWGqwNP15oGFR1breOIsUCja51YDVytiNlTCm3ROWBA5djWAz45I9/JXGSEj/pmWK29RTO7RuBtZCZwB0iIaTIl9Fv/G4i3u3kWzbom4QZ8f/in6+M69L3qUc8SWGXBsdl+nUgJ6vvgd4BlNSjMxeXTo0OoDUoZqWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by AS8PR04MB7541.eurprd04.prod.outlook.com (2603:10a6:20b:29a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 07:25:21 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 07:25:21 +0000
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
Subject: [PATCH v4 net-next 6/8] net: dsa: netc: enable ingress port filtering lookup by default
Date: Fri, 18 Sep 2026 15:28:50 +0800
Message-Id: <20260918072852.501420-7-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918072852.501420-1-wei.fang@oss.nxp.com>
References: <20260918072852.501420-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0175.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::6) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|AS8PR04MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 63123632-523f-416c-2731-08df1555ff86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|921020|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4SkSpPE/IrpU9Vn7dHaTAPZHOubCUYobntvSUqOvsywL+38FxKF401swx0+MPVbZA7JV6FVF1Bp/36L+qza0rXm4TkDpKFJ3RW+mTvtamWlMHgLHBgK87UVsuBEwcdCQ/P/Bl9IROyzeyDYDp+8fkNAedjfsyCRNRyi78NeWFpfoajqIBNXcjx/kwiNCZ283UsiEOMmBuMFlIoSvnpfJA+vwIzsOCWbjXCvaHj/1c06xm7gOICZrhplv+Ri1/8NDaqwyN7+rzrObVvObk3llrjpXJBATilf8wzxjVLCrefOtO2w9Fkp8I5L37yZZT/YRFEMyzfsQ0Ky7M2fDDpFuiaOhbiUvfKPGKUmF8y7i3jI4+Wuylmdm2A9lOhJT3AeO1qObuAZWwqswMXrnyZSuK3Xilae1hmTn51eDapV7EY1q6a21LSxPkRnlQ0q5YeWmwX1hkk7XSa/Rhc220zQQPvXC83yFvtvi2Jp2UvWROf9e9W2u+OqiZ6qK/sIJDS0hgRrIJK57dvnvd5nzoF7WpoCNjFIo7ku5hC5LZp+m1O4CxEiPrhxXnr69Wdk9/y3rBeHdiStRj/vKvmUdk5xrFu9dwopETU67JM4wU9lGKWO6bbNvLdjxOguPO8hFT1G02yy3pSUewQZrCx6BRRBh/GICi64jFMYGFidt6Zf6kztKr2VY8WpVtoJJb1finx/jW/nB+v3YNEAkSe038CJM9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kRlfW+L/MqWJYNWBE6ZcbUnbZqRiB/OibXpcqqAXdvWY4PxXmJqLPJSPOXxa?=
 =?us-ascii?Q?b78udxbIsfzq91W+n/uiQPuHozW57rDCHYP7mDZHgqH4Jt3s8vLINdP0JjQA?=
 =?us-ascii?Q?a/Is/mni5ovLdJ2cYVP6poA4bhYnKvqdbofYRluHLbrCbsn/LSHXgq+NqQ0P?=
 =?us-ascii?Q?TV3fP92oSjtkCXzH3YKTpE61n1ugr4+Dn7IFE4Xw4AAapEFU60Bm8QjC2a+Z?=
 =?us-ascii?Q?G/mNqu5JHhTxjf8tW2goLDUaBhUjJcxsN9fOtheIMjbkuQs6IeCu74l+7z2v?=
 =?us-ascii?Q?5a/miiTYccubkGwhE3Y5nW1I2DHfNtBIErcDzWVOqu6eDWCJ4g55DXh4PXAe?=
 =?us-ascii?Q?2FS8H0DhFpijpTntbzRzQ0fipaA5i7k/mqimmWQaZZEg1k5MJ8AjMrATzT53?=
 =?us-ascii?Q?IS9kXwzSO28ij57MRwjnn/lVcraPv2crOpB6o3+lyD49ErtrW45UGbMkTQdh?=
 =?us-ascii?Q?tOk23anttsQw4i4yptHC/kOKdsD63/LU/OQ1IAnqSaj5FsipLgS2FRfni0xP?=
 =?us-ascii?Q?b7n8S28ue8fn7T11G0JXYtz5pgCYJKXiPDYPbHraG5CjdyZ3S7LcWmZW7qyu?=
 =?us-ascii?Q?OAEAVsW+7ECIGcOfjKQC4GCAGpZpJxM3O87yPlF3Y5bSb1LgY/9/7hJGO5v5?=
 =?us-ascii?Q?lpBKyv+2uMBBMfxegalRU6VHlTlu0isFpyEAnok1a+SbR1vEo1E+ZTkoOP+v?=
 =?us-ascii?Q?09EekQh6ecTjaDQDTLj9I1fpkQ/KG+tEeVOg8fCuUw3NGQ8e3CtrAYjrWSGg?=
 =?us-ascii?Q?pOr9ZnhtuLiikvHTARhK+2/nm0zSC188PMPFo//wvW/5KMnxI+0/T6/R6H3y?=
 =?us-ascii?Q?BHzWeQ3Jfbxe1f/IynTfBtBWD1PjgON90LMWLRed0b2KyIe1/LsS5MUVve2I?=
 =?us-ascii?Q?n4zaqebp+M3jnoM10iWD3Lg1LO0fTTrB4/61GkTQZEefTmF+25OVDONywCLe?=
 =?us-ascii?Q?jo9xKlIt/Iq9VuTkGJOezS2AVQb8hb3H+NTbtpt57dQ5VLt/VsT6MxPCRt5r?=
 =?us-ascii?Q?cVoIUOiosxp/IoJ2I7AkF69aifxHJ36tZ7C/IGrXVtvyWOhXGsyg133mA3Mv?=
 =?us-ascii?Q?YdmLDS+21s6XjaI8PhHMG48CxtyjoxP2ApWKs6JQFN3bIDNXUDh+RHP9W9ah?=
 =?us-ascii?Q?gbAkb0FOn5BH0w9po6Du619CRDuQt0cKaTRMMIEOEW0oXbheoqh0cVXEkvSy?=
 =?us-ascii?Q?dRBQbUvj1ESKtXQDgB9IqZoh3cmWwp+PsYbxgxMpDn96o5gMNseSSGjpTSQx?=
 =?us-ascii?Q?2B4t341gtcmrHjFHTANaWUvi1TvocotDsK2Zxou9lAFH9YCXd4SLfrAXxktF?=
 =?us-ascii?Q?372lmPeytUGRV+doq0NS47quv3iJdvVfcHoyBCm6FAt23W8kOZYo9KxozU+Y?=
 =?us-ascii?Q?WpK3l+8xgXjPXsj4Y5rpTDkQOf9dlKUQ1xBSc2Ekq7aJeTBqSgbHCR7f4s0G?=
 =?us-ascii?Q?h6qOiTPcHktpIxphjHTU5vlcdPg7bxYeAN5KPPzoEBksJPJhW4oxlIf9yLXB?=
 =?us-ascii?Q?7t3r+MjUdgtTwJ25cCyTPFIoGZNuDAD4ElurJfG7YWPgMGfrgRlSFP/SeJ9P?=
 =?us-ascii?Q?cAWNsQzmjVUhrxqN2GhsxnezDcJgG0n4BSlxyLmJ/+b6X/fyKInOhO8DBF6E?=
 =?us-ascii?Q?mLkfEwYzTtpsRYay/i9f50SbJnaG6LjvGUY90ElPBO2elC0t2HV9lvFKVB6f?=
 =?us-ascii?Q?B9rgEOVVooerxac5UAcuI2P6NPWQGc5TcmmIEdbt+GCmMrrFue/ZUGYdPjL/?=
 =?us-ascii?Q?F7KHXyt1XYVQyqNRqoDuXS2dZR65smUu+y+Pe9fatyt5/tHZKVKE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63123632-523f-416c-2731-08df1555ff86
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:25:21.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oOTmFGh/iThgXba4IlarVgSI431qPf1SRpMFh6y5QmTDF1VaoZ/aZqqagcWE13jkiJDm38kbux3SdB4qXpwiHmeHR6Rwng47DtyCg0P702Q0rJF8HPeO9kapMUl1L8Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7541

From: Wei Fang <wei.fang@nxp.com>

The ingress port filtering lookup function involves performing a lookup
against the ingress port filter table (IPFT). If the frame matches an
entry, subsequent frame processing functions will perform corresponding
operations based on the parameters specified in that entry. If no entry
matches the frame, the frame is allowed in, and passed to the next frame
processing function.

In the future, the IPFT will be used to filter PTP frames and support tc
flower. Tracking in software whether any IPFT entry exists for a port in
order to decide whether to enable the ingress port filtering lookup would
increase code complexity unnecessarily. Since enabling the lookup when
the IPFT is empty has no effect on RX frames, enable the ingress port
filtering lookup unconditionally during driver initialization to simplify
code logic.

The only concern is that when deleting an IPFT entry fails, the hardware
will continue filtering RX frames based on that entry. However, we have
no choice. We cannot disable ingress port filter lookup because this
would deactivate other IPFT entries, which is obviously not what we want.
Moreover, deletion failures are almost impossible under normal
circumstances, and we don't need to be bothered by this minor issue.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 082ed9405868..336f5a4633e9 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -554,6 +554,12 @@ static void netc_port_fixed_config(struct netc_port *np)
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
 
+	/* Enable ingress port filter table lookup, if no match is found,
+	 * the frame is allowed and passed to the next frame processing
+	 * function.
+	 */
+	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
+
 	/* Set the quanta value of TX PAUSE frame */
 	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), NETC_PAUSE_QUANTA);
 
@@ -1746,8 +1752,6 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	np->uc = uc;
 	np->mc = mc;
 	np->ipft_hf_eid = host_flood->entry_id;
-	/* Enable ingress port filter table lookup */
-	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
 
 free_host_flood:
 	kfree(host_flood);
@@ -1771,7 +1775,6 @@ static int netc_port_remove_host_flood(struct netc_port *np)
 	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 	np->uc = false;
 	np->mc = false;
-	netc_port_wr(np, NETC_PIPFCR, 0);
 
 	return 0;
 }
-- 
2.34.1


