Return-Path: <linuxppc-dev+bounces-27909-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA98C982F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:49:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpwKn4j0qz2yQJ;
	Tue, 22 Sep 2026 19:49:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790070557;
	cv=pass; b=ig6A/hjN9EGfx5tr+5P0KJtRnAA6j6l1GCWgM/8gb5q1brFXpXbhgUQl/H/oMUHuMTNxogW7H7FPcTmjsZvvsgOMMhhOhowTMibI64rXXEj0b+yB+vQUhpiVDG+sLSlBpR/Q9rMMC7J4S3sBm+K+mFKtlALDgBDISIjonhZx599AOfIvErQEdTM+BaqNrqAkRR0Pcd6mfOCAxr88gT3rdZenySWCE7+bu0yMiOoI+Ka5mMMC0ZqHpBNOrsHCJ2jPibD9AKa9JHyooOsF9O4ih85msUdWMQqiwHXU6+P11/xLjApyRM8p0LbaGuVHie65YGBa+X/mVo6htrEq7xEGlg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790070557; c=relaxed/relaxed;
	bh=K0P4oWAXQMf88uI5Q8WmLMtZZD/4YBrWdfLznYrJigE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y3aeeybLQbIOaZvNAeulLEoSZ0ZLUBNqv08YeUTbX+wQF8sFMPKSUqfSq18s7mKt6qR0MbmvzPVRVrSCjorKCxvxinp2I3uTYdFM0YB4MCRNZdCJO5pslFUvXUuymGl7zPyuMjZbrLPKvnebgM7Zd3WoPHZqL1WsQ/aPe6Bg3mwnotHvp/0CB5QuKdf4X2lAHbqynGQHATQsbityDk4+t/B2UxAITykF+Crr47Mcyz9CNxza3uoxlhXMJaXw/gVjVh/F3PKXAWv1sRTcg/xaWCrbHKgPCxT2iw5dOS3msS/rdUJj94eUu3mw6JSlTa/Jl3ojZyGo8Hhuv4SYP3QkmA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iZS060jM; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=iZS060jM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpwKl283Lz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 19:49:14 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xew6tIi/m/DfIjwZM7ab41pTjBok2Jbb7+od1eZeCbWFgP3jdP+N+3kvTNDQB4h7s5KKksjMCzJNUbASKXfjRED7S0QWJ8nLi47JLmSxWoFBTJ17SKn07yP2b+nFY7I+P5ahnSvkToor9CXNLIF0tth17gK9gxLM0XhMWLrfwbWdu6jkPyJCorgmHpnVM2OvET2eB4TetblSmbkbg/36fGwZEi/++wCKzlkCLBA1+UT2myvwNUr+8YQS0mQrwC5iF92L5pM5cM4ArtOMVJau8LJE4sMoBUlwykGFczn/DnyWDyQc/9B6Km9FPkreseZBsSkkXiUCMZjnbdzc8RjY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0P4oWAXQMf88uI5Q8WmLMtZZD/4YBrWdfLznYrJigE=;
 b=grmVmNKkuyMVj9J8eymfAePvkYpT24JOIyIkmxvgu02bvg1UjOYjEa/zyuur2yx3r+O/VLUHcBNSnZkfY7qPXhlH8umMb6VJfv0O35HIecKbyrTsugWc7s6WUjfVlIKtxzygO5zFwLuDckaGpjyJEvOA22u8CiSE7R76P4SLIXO4aIt13/NHUXrJdL+rBmMpYzOaeJpjEp6odiybExwjEQ2E3GiI1p99Dt5weXu7gqwtCZastXM4fYKB0s+nRM0e8IhWf46SCZsKpGO+BlkVcxtVNusZN60alt+6KMfOf++31W11/EUdHoEbdsNfy4HEluCACvLQJXWyQcMsR+yYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0P4oWAXQMf88uI5Q8WmLMtZZD/4YBrWdfLznYrJigE=;
 b=iZS060jMxgqSL9j/5IkocghiC5YOHfnmln6TirNKBtd8U2b9cam2S+dFP3STeNh4qzG2tI8KgYzTdGmYxLlIOnZIVLd9uDiy2b6cT7gQGteZzHa6irlLU4A+ksebIes24htz9ERq8m9xmqE2ocD0zSH9jB0A/U2oN+LKTRcPDZZCmqbGuB1mZ/ay7HABNYBuLIlffeSTb0NZw+qpGPFOIf9lBz6yIG5IvJOWaWK4atosh8OkIBBsXlMWW2bI9v61M12FSJgyNIGmh36GjxG8HZ4+UTvo8RqzSi0+vOyWImd5QzRz+V6NSWVQDy1X7PztmZznwYN7Ad3j4vsFGmST6Q==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by DBBPR04MB8028.eurprd04.prod.outlook.com (2603:10a6:10:1e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:48:46 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:48:46 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>, "Wei Fang
 (OSS)" <wei.fang@oss.nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "linusw@kernel.org" <linusw@kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 net-next 3/8] ptp: netc: export
 netc_timer_get_current_time() for cross-driver use
Thread-Topic: [PATCH v4 net-next 3/8] ptp: netc: export
 netc_timer_get_current_time() for cross-driver use
Thread-Index: AQHdRz7S22iPk+jFYkOuk2Znvrfaz7baSXoAgAANDmA=
Date: Tue, 22 Sep 2026 09:48:46 +0000
Message-ID:
 <AS4PR04MB93381E4945132FDFFDD7E4E088832@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260918072852.501420-4-wei.fang@oss.nxp.com>
 <179006555469.2160803.8873313402765313889@kernel.org>
In-Reply-To: <179006555469.2160803.8873313402765313889@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|DBBPR04MB8028:EE_
x-ms-office365-filtering-correlation-id: 7671edf4-42f0-49a1-03b4-08df188eb262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|38070700021|56012099006|11063799006|5023799004|4143699003|10067099003|3023799007;
x-microsoft-antispam-message-info:
 wdpIkaKaVhXuUFiBDNSf4Yn/rNfHMd7B5PKWKSDQl0aQN6ZkyyYsjgc6EmM1km28ewz7+/P+wBXf7BUfe4tovL33ow7l/rWJ21+Bg1zTxZ84Cw4zEkK8ctKahbpr4HqQtsPwznwcGjHhaKHGcsVc7x+eRo0zrgXjHu3i/jE3rHAD2OuiZ24pBnFO62gx4m883Mu9+XTzROemZh6FuJLLswNUZauoY/qj7zvnxYiy2Gg2jA6G7S23upFdQLgsHbZRkbiKovT9ejvgSKNuky3tYF6FlWLWzumEEm7kD2MQtDSbz6qg2VWbUUqFSH1GCdgrRMRStvDh5bH/mSGK7IBTQL3sxJovF+EiRPF4aaV+Q8sFEUUOAML5vRmvl5HPzPY9LR9OAkU5lBczJAaL7lsdBlYy0GXBGKms7xWII77dlbu7JkV/RnQ+JFBsJD3q9DQXiZEqADRdcDf5tTBcKI27X02R+RVXhJ7zeJPd+oCtr94/NCaufCTb6cBUei3FlxdYzviLHErTePj/YONQa2RI7ElTLC1BOMqL79nn0M7/+0+OjtxHfPSmWKDlI0Gceu8s+4TnaIIr4/0BmfenDlvIUUzUiErqcc8kzdJYNDIh4t7ZS8Amc5bWv9xejGqW1ZE0Bgebj8U4Zwp5skqGjOYaY6tFQwunlDjn0xKqcXN+yN3UCRoNXVh6BzNGDsUck6SLQa4Mq8rZhQnM4nniy/xo5sCHRa+x3WreLDHLCMykkYg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YU78MGgmR9C0hVZylAO60FyHfYLN8VyO1kf+fQV6SdkXShIA8Oa3OdBGNHai?=
 =?us-ascii?Q?3Vwq7MgMrS2wuQfPpNI5W9FIXVp095OhO0i3nYzwx4OrxGVr8bovnKk0fFGo?=
 =?us-ascii?Q?3Rb821BBvuItBeG+lis5F5TWTNFceO6q8zlri4nTXL/UuG534Y5RytJHyaIf?=
 =?us-ascii?Q?DcIf+FPYeBH9cIRR6ee2Hn/AZ+7o0qOlX12Q+HhMcyzCdimyTh0hhSGdcpev?=
 =?us-ascii?Q?OFRxs5CisxVdw48Ic+uYqJha94jMcfRCqQrsycc9XxD4XNuFwhwZDNAu8zLw?=
 =?us-ascii?Q?BOeDYHGj/RpWdOssJkdkHePH1bYim93RLzee18pBxGnauGj2mhbLgxJi/uEl?=
 =?us-ascii?Q?MAm/4MCqAYMB11cgR90Ha86AAaBSaZR9mPkbPLs/9clQ5TCNIOr98mdf44pf?=
 =?us-ascii?Q?tfmFqUPlZQBeIGN8ujj+LVORBshdMeOA86P9CcEv73Na2rLpYRDBrS5nKRYh?=
 =?us-ascii?Q?JJVaBQv9MVNHPWzFMfw5r7iYi3rhuHs3BRtg7JqwxM51+5Cp6r5H2IeQVyp+?=
 =?us-ascii?Q?mNIoVHaMJvdJI5UecyClvGKMVfu9UWI1j8LivvXy0MQ+BtjuRiI1Ea4sOFGS?=
 =?us-ascii?Q?MW3gtEQgMMzYwfuKmjth8tTlE17Lc3a3HTmgJRGf2hNoDbJIyjr6px4fCdDC?=
 =?us-ascii?Q?9n2pBXAFAbjE/HNCEu/oVhn0YypU5sMIqf6AMvD6BS2Jg/QF+r010ybSCzkO?=
 =?us-ascii?Q?Ib/FtFBz1rwwj2rpJ0gLd8zKfh3NuLodhswyktuT2hONyIorsLqc/HHhsq1V?=
 =?us-ascii?Q?VXofshDbvV9Yyut2y7oNKWt4Ku9eG1eOkK/dmbRkcFqDEubfuNEcmqLqIyLs?=
 =?us-ascii?Q?F7RKa8CW9xFz8eaJXRtjDKAv8QHx/3TkD0OGgnUj/Yav5d+frujQ+2BdQ4mK?=
 =?us-ascii?Q?qlOnLE/t5rS/w7CdI6DyJo0JSsfLDfyn8wR+ytZ7UF6Y/gx2jEMqsgB7hyfC?=
 =?us-ascii?Q?87/+tnaMxspsNw4zIqxoJUYvdlod1nTEVbHq9U1r986HjH0vzVUSlxMUVbBu?=
 =?us-ascii?Q?EN6jnrBdD3fIn2HHumPN0B3iVqRQUhXNPJ4o/ttGs9KHv17KRpdbUhfxkEKq?=
 =?us-ascii?Q?50ZNFZPsXq1ZT0fGvaNepM8fzJ/igW1Rv++zu6GNRrDs9T5f00lWaWyOC2g0?=
 =?us-ascii?Q?OKbQovqumcHKx3Eu8t3bZNEOMI5rscvOFVJmWkLD6LsAYqBDGNC7UbS2hUk1?=
 =?us-ascii?Q?VC9FIBcpAzUAYZ6HZrmsLXnMuxhZZKluFeX9wI6y85ZwImwGIiUF4CKnbiVD?=
 =?us-ascii?Q?rbP6gL6PPWZr9DRuE72xicpaQmG4p+dtJIDt9YIDpCDXVjREcv/7IEUAXjdy?=
 =?us-ascii?Q?bGfBMLFUGdzcT1u182YsWfU5Gnuply2+Axb+cjThfkFQlW01SFbMZiXNFHg9?=
 =?us-ascii?Q?JgRJicwXMe1oFM2RP2bKmQ0DwsnUELJhytr7gqWubBFEGBedqEbMVX7z0jNY?=
 =?us-ascii?Q?qa16AdtGO+KtpjG3L4HTrK3NRTYEwMJThlsYQLdaEqRZF655mddovhDjVrIl?=
 =?us-ascii?Q?QSNWxewEpTvRRYNPx7KYVaPzV3YcWO3kPXWe9V7vW5rHmBa5wipb2gksdtIC?=
 =?us-ascii?Q?ATdiFewXz0THmToEsj05PgdN0sEAhTITnxfzkdhbp7Aq5K2pcJwkd3g0a03c?=
 =?us-ascii?Q?NfmwX/+Dl/BcpvShsjbH+/dju95sSmN96XC7vQgo5sZXE9xUQ38jXqq/RCyH?=
 =?us-ascii?Q?K0hIG/W6Z+geYZoGqqgfhzO10U/loK/32akUJ9+LLhCUzg2g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7671edf4-42f0-49a1-03b4-08df188eb262
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:48:46.6581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpAHmlwYLDeBBkL/DfYIS86blRqjuXNTKYkt6dDpHTbBDIOncM8ERtZcloHjpfGD0BIBnYCbKfVln+LISxVhaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8028

> > +int netc_timer_get_current_time(struct pci_dev *pdev, u64 *ns)
> > +{
> > +	struct netc_timer *priv =3D NULL;
> > +	struct netc_timer *tmp;
> > +	unsigned long flags;
> > +	int err =3D 0;
> > +
> > +	/* Serialize against driver unbind, so holding it here ensures that
> > +	 * priv remains valid for the entire duration of the register read.
> > +	 */
> > +	spin_lock_bh(&netc_timer_list_lock);
>=20
> [Severity: Medium]
> Is it necessary to hold the module-global netc_timer_list_lock across the
> MMIO access, rather than only across the lookup?
>=20
> priv->lock is taken from hardirq context with a plain spin_lock() in
> netc_timer_isr(), and that handler can spin in the register drain loop in
> netc_timer_handle_etts_event():
>=20
> drivers/ptp/ptp_netc.c:netc_timer_handle_etts_event() {
> 	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index))
> 		etts =3D netc_timer_rd64(priv, NETC_TMR_ETTS_L(index));
> }
>=20
> So while CPU A sits in netc_timer_get_current_time() waiting on
> spin_lock_irqsave(&priv->lock) with softirqs disabled and the global list=
 lock
> held, CPU B can be inside netc_timer_isr() holding priv->lock for a perio=
d
> bounded only by hardware. During that window every other Timer's probe(),
> remove() and every other time query is serialized behind
> netc_timer_list_lock. The same applies if the target function is unreacha=
ble
> and the non-posted read stalls until the PCIe completion timeout.
>=20
> Would an RCU-protected lookup (with the priv free deferred in remove()), =
or
> taking a reference on the Timer, give the same lifetime guarantee without
> holding a global lock across the register access?
>=20
> Related to that: the BH-only requirement makes the exported symbol illega=
l
> from hardirq or with interrupts disabled, but that constraint appears onl=
y in
> the kerneldoc and is not visible at the prototype in
> include/linux/fsl/netc_global.h, and nothing but an eventual WARN from
> __local_bh_enable_ip() catches a violation. Is there a reason not to drop=
 the
> context restriction by using a lookup scheme that does not disable BH?
>=20

There is effectively no contention on the global lock. NETC has at most 3 T=
imer
instances, and the Switch can only use Timer0. netc_timer_get_current_time(=
)
is used solely by the Switch driver - the ENETC driver never calls it. At r=
untime,
only the Switch driver ever takes netc_timer_list_lock; the other Timer ins=
tances
take it only during their own probe()/remove(). So in practice the lock has=
 no
competing runtime users. On top of that, the drain loop in
netc_timer_handle_etts_event() is bounded - the hardware time-stamp FIFO
holds at most 16 entries, so the ISR holds priv->lock for at most 16 regist=
er reads,
not an unbounded time.

With no real contender for the lock, switching to RCU would only add comple=
xity
without a meaningful gain.

> > +
> > +	list_for_each_entry(tmp, &netc_timer_list, node) {
> > +		if (tmp->pdev =3D=3D pdev) {
> > +			priv =3D tmp;
> > +			break;
> > +		}
> > +	}
>=20
> [Severity: Low]
> This isn't a bug, but the lookup is a bare pointer comparison on a
> caller-supplied struct pci_dev *, so its soundness depends on the caller
> holding a reference on @pdev. The in-tree consumer does hold one
> (netc_get_ptp_timer() obtains it with pci_get_domain_bus_and_slot() and
> drops it with pci_dev_put()), so nothing is broken today.
>=20
> Could the kerneldoc and the exported prototype state that the caller must
> hold a reference on @pdev? Without it, a future caller that caches a raw
> pci_dev pointer has no hint that a freed and recycled pointer could match=
 a
> different Timer's entry.

The only caller is the NETC switch driver, I do not think we need to update=
=20
the kernel-doc.

>=20
> > +
> > +	if (!priv) {
> > +		err =3D -ENODEV;
> > +		goto netc_timer_list_unlock;
> > +	}
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +	*ns =3D netc_timer_cur_time_read(priv);
> > +	spin_unlock_irqrestore(&priv->lock, flags);
>=20
> [Severity: Medium]
> Can this return 0 together with a meaningless timestamp when the Timer
> function is not accessible?
>=20
> List membership only proves the pci_dev is bound to this driver: the entr=
y is
> added at the end of netc_timer_probe() and removed only in
> netc_timer_remove(). netc_timer_driver registers no PM callbacks, so syst=
em
> suspend takes the PCI core default path and the function is disabled and =
put
> into D3 while the list entry stays live, and nothing re-programs
> TMR_CTRL[TE], CK_SEL, TMR_ADD or TMR_CNT on resume. The driver already
> documents the constraint in netc_timer_init():
>=20
> drivers/ptp/ptp_netc.c:netc_timer_init() {
> 	/* Software must enable timer first and the clock selected must be
> 	 * active, otherwise, the registers which are in the timer clock
> 	 * domain are not accessible.
> 	 */
> }
>=20
> The same holds for a surprise-removed function or one contained by DPC/AE=
R,
> where the read returns all-ones. In those cases the helper still reports
> success, and the switch side consumes the value verbatim as the one-step =
Sync
> originTimestamp in netc_port_onestep_work():
>=20
> drivers/net/dsa/netc/netc_ptp.c:netc_port_onestep_work() {
> 	NETC_SKB_CB(skb)->tstamp =3D tstamp;
> }
>=20
> Would it make sense to gate the read on pdev->current_state =3D=3D PCI_D0=
 and
> !pci_channel_offline(pdev), or on TMR_CTRL[TE], and return an error inste=
ad
> of a successful-looking value? The missing PM support is not introduced b=
y
> this patch, but the new export is what turns an inaccessible-device read =
into
> a timestamp handed to another driver.
>=20

NETC is a Root Complex integrated Endpoint (RCiEP). The Switch, ENETC and
Timer are all on-chip integrated functions with no external PCIe link and n=
o
physical connector. So surprise removal and AER/DPC containment simply
cannot occur here.

Suspend/resume is not supported anywhere in the NETC subsystem - the Switch=
,
ENETC and Timer drivers have no PM callbacks. When PM support is added late=
r,
it will guarantee that the Timer suspends after the Switch and resumes befo=
re it,
so the Timer is always programmed and accessible whenever the Switch may
query it.=20


