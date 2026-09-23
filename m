Return-Path: <linuxppc-dev+bounces-27952-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4C9C98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 02:43:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqLrK2W3bz2yMm;
	Wed, 23 Sep 2026 12:43:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790131425;
	cv=pass; b=nyN+NrbtJ5oS0iB5QMZwRcyGhOv98bG88DBECmxMXPzL72tte+TN9dDihXfz6sD+vqCBxqTd1/sx39fCIYckO0x5EQcAEK/encJn9oZHubwuX9CJPQtO5f65iytIv9Gsss8Jh9kVxZC43vMd5hPFwLQBeVLg3YT27PcHSHZjykrsP2VNAq6kqpqvRdJRjAxGg2bFOC762cilCWm2NakvXMjB/nQNzuYYxMVLR00Qo3LJLCTq2k+9wTsfVH17+HGsKSPvw19B6XqiSCpy93RqRsHFrolL4tn6puYGbXT0xyPE3DOfub2kO3Yu6CeTxNXLUbwyHsVyd+ceC6tmDFKI6A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790131425; c=relaxed/relaxed;
	bh=mxX/2rN7oHmp4mlUlnZwiKnO8RqLOQCGipyGS2Mju6U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G+URiqmEn49bfaZtlJTyau9NtmrgDo6iWFYimDku9Czu9u1FK/nmVzH5l6JMGRdcjHUY4KmLaaw4ekNBiALr54iZJMW2u5KYahwFxkXPhpJg9HiU4scfAj8xqJxZikTkIypruyYtaEgABEphntgIiGQ5ZGSUk1qgUtdWILOX6EVm+mp2iw1cjNsgwFB79uJthmMtXGzRaZUm+0XB122mphA3ovZzN9cGgVnNcDyfLuyLWjZrQBL/508tdJ2/E/w/8hnsFw3up/ZULETdz3Ajogzey5UMHT9qRXDJeTzBPKkBa0hbl2wTHd7OZlctoV5CSSOApdFvGSgoumsG2G7iig==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=V0Rzf3KZ; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=V0Rzf3KZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqLrH3gMyz2y2L
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 12:43:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+yDQ2nTXV91ic69m6Go7f4r2MwvKyuAaDAYGCw2glV9Pef9PcTzbp/S+h4Uk3SZyk5FdW04Ti6dVLMQ/6nkYkfnaDinlABJ+mUDinUY7z26zWoNg23mf7SVZ1GDnHmnDhREmjFvSHW0PNaCcN6feFKCKICdVj26HgiL1szGEQXIeHhNFpPIH28YT2PoDE2tqLXAClP1CwOljIj9z/Q6CCDro4ZeHfGkPdN801nTBVPQuLP8Np5Eada/ygtjE2o8mgXKedH/EON7YuXSElQrlw2Z9I7GOqSdbeBxehPY2g9lZCf0v4mRuwLI9Q4oN2/1Dgt0CbcJCuX8mZDhB19zAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxX/2rN7oHmp4mlUlnZwiKnO8RqLOQCGipyGS2Mju6U=;
 b=fZp6jHNUBjJdJnAw0dHmWBMpgBnBPSH+jv7m48G/FR+tom/+Y95Ln71aYvkz4rfYeB2Ayd0nQOGrlnb316h1ZZvFvbqMSohX25zBRu1O0gS0Ca97wZx9CmrdbzjkMLh5ZXHxrBMtB29xgqiH/0dVbq0GS5GpoEe5AzQIkP36modZfJgOsfBD7UJKxibpktGOi+o8rkuaijcsAGW6r2AahUmYsm9gkWBmAW4zXhkwbLhZQA+YJ8hJYxIqrPLbljvtQ/Way5CUSRczf7OzQA92bfvZjHQjYfhQ23EsqnbMASV/bhFlzE+QIkQXiArur62jO6/kNblh3T1J0Ht4krcvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxX/2rN7oHmp4mlUlnZwiKnO8RqLOQCGipyGS2Mju6U=;
 b=V0Rzf3KZbhC/ZM1XN5PB1TrZdhllHImPqentZfBgTWTTmis8vTKACDGoM4PFKMc9wyWEvhsvi4gvOM4bKiq+pgIj21oRNF7rLVSmywjZ8tfHDHewzhSZj/eGd5AU6q2mS6TQppVoZM6TdZTfbtUNcmx+Tjzj+TkKswd67jhftd0wS8uKy5MIZH+QTjtCkPrJR/8TOethF/dV8a+E2zacBf6hTdHTMslZe1xcCCpOJ/f5sU9SxNbn6BBRqVL4w1SOWje6SkiJvwFoPrThULDsEkD3GYjTJUcAXTTwl80PxWlfivQJpWgMYs0ybHTp1xZjSVQ+q9gFIKj8QIOip0tFdg==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by VI2PR04MB10221.eurprd04.prod.outlook.com (2603:10a6:800:22b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 23 Sep
 2026 02:43:15 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 02:43:15 +0000
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
Subject: RE: [PATCH v4 net-next 7/8] net: dsa: netc: add PTP two-step
 timestamping support
Thread-Topic: [PATCH v4 net-next 7/8] net: dsa: netc: add PTP two-step
 timestamping support
Thread-Index: AQHdRz7hNjcsvXMGFkGGbZOtLIyEYbbaSX4AgAAksAA=
Date: Wed, 23 Sep 2026 02:43:15 +0000
Message-ID:
 <AS4PR04MB9338B9FFF1490C9D3BF9F1AF88822@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20260918072852.501420-8-wei.fang@oss.nxp.com>
 <179006555805.2160803.10349234944420509540@kernel.org>
In-Reply-To: <179006555805.2160803.10349234944420509540@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|VI2PR04MB10221:EE_
x-ms-office365-filtering-correlation-id: 2f023501-89a0-4d95-19b3-08df191c6b30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|23010399003|38070700021|5023799004|3023799007|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 3cGMcUseB9RVtJ4wcP63bZqljU+eC7qUGAMK4n/Yiua5XOD9tJMktQAXbQru4OYwnyl0J21m7uxfOgyu2UoqflO7Y95AXXJGK5QQR5Dh2CoQANWvXFuujmuVWhsOI+Ud4ZPXVgiK7a/kDtFf4fnxKXnDlD1Q4jS5N5oZ8gOqDmPx2hq5iT1Wl7rBGexSktWjY98PdLZDlq3WytBHqnd+ZpVY5fwiqQFM/3rz4QaYNR8CrrWmX1OWus95SMPZjDIQl4VWag+Dp+JS54MmrpL6pd0yuHe07tz4VWvLLkYcGxtWcwG/SWGsA+4lRcXzyPYLKkUz6xFCxYRJaP0//42Q53dI22HsGW8WcTOto+2yMGxQQ7Mv+bdpiNgP3GsQyOY03GNUm0arPelTDrgMEY4L+6437lUErH5D8XfeYUi+ds8w+DniTVrfKd4TAkY7hEVlDFzv5IddGWAVKi4lx6ZotrJZc6//bV64z55Pp5jD092V53Up7KLyhbppDZewlNQu5Y5Ki076bdsmlfsA7O223pkePJydsWYykrwRFtMHxP558tuegVOGLGnPwvd4lXdWKF/7iYUsG4l1iYgFOPzeU7QKa0ziVyjtgvvUS8yxv/AyAM19CXmeSg67Jc5VoculYUeg410T2pFwKIHAK+0/t3yZBkbyGLZGi0iuqRub2hAVQN+w5GGK3jOfl+2CxQPayEsKRGiAWvge4RqZDw3sIvqWb0qtQ3H6eZHhe7mW8kk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(23010399003)(38070700021)(5023799004)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?72dM5UE6iBhpv3K0q6SO1sGxBwofp8m5YXBIFzO2Gh+ElqHXtEZ8wWRwAi4T?=
 =?us-ascii?Q?Z1QhM5XZnKJwWTG10XSjqOjPWJikf0aLjCZaopcNr2MkoywTq+CcwHDtXF+r?=
 =?us-ascii?Q?uEuM2Sh8WFxPpt3hpVjTGPHmE2hLHumL3SSAph8rofg1aJKLb9c5Xs9125V8?=
 =?us-ascii?Q?ATsEKuUgyhwDqYuZVgjMTZ3rzPuDggywzF/QNY15o9nq3AhGX0lw5MxtIjwb?=
 =?us-ascii?Q?qvJaEyp6QNDZb7zBLl4JgMLuhfYpEArJyK2htxcSDthoWZCFxOteF6gKk7j3?=
 =?us-ascii?Q?MIH+GHVVTpgvX5BvVfJ3TMGRodvPBh+mqjtFNJL1aWTwmwZBvMZLBNWqkfdu?=
 =?us-ascii?Q?DlEJUCeJt8ysfrZwXD8z73jBGAUWvPx5d8vfE4ZrSa3c/BLbbllAbr0dEiou?=
 =?us-ascii?Q?oJsOXKKIA024XYqF5hgwftSh5JY0OxQX/qILHhBHdI0MA8MwLIZ81ly00i3L?=
 =?us-ascii?Q?WtppNKl3yVjxA9u+lMr4HPJf3XH1cUcBq5wTshKixHRU/EQSy1tThI82Njkw?=
 =?us-ascii?Q?V0vKN9a8u0sNxqhytHUkutn+fOEPxmmBVjI62qPrXYGIfztyF/Zhu/xaDmil?=
 =?us-ascii?Q?0lGh5EcvddSDwG3n/7Dd4S4Y+HTp6deSHReSnTQxxiWgS0E/USi+lx/YWTCN?=
 =?us-ascii?Q?2FwnYvPeO2a+nCmxCMFDvz2qI4DeGZYvoC/bUPIjq4vOu3y/qp8tdetISYfP?=
 =?us-ascii?Q?YCmtpiox9vflP/2qcYMHLBloVS/3RxDij7OyUffUJpx5jzzhJy8lfzIKDkZw?=
 =?us-ascii?Q?dOw9kMlV9+2xamFnphQ1xzT2/oe7qM1P4CGLBv30nX6oaK+lehPaZpeYFAp0?=
 =?us-ascii?Q?hIa1r0NMCbMiVOE+sW4QEokS2llC8E8h+6f4UxtwRLGcnXU2cCZbTL0r0M+n?=
 =?us-ascii?Q?9AXEAy9KTHgiY1f3VLpXecbtJEvQgh3aejnJFnX0TdO3M8GyRGXSKRhcaIFH?=
 =?us-ascii?Q?DIg5aamaUHrSKoM+0OHf8dMM4NWGj8BfXYE0/Cz5sGuWGGE38DCJ5BCKXwNX?=
 =?us-ascii?Q?W2OKdLU5zJIk7nKj4CVAdjWwrp4vsyTaytq/+3ELlHgHxlTmkQPLYwrNN8JG?=
 =?us-ascii?Q?Snv2Z4241TtnOxyuKtr/b08OhIww8Jf5icv33TN1teWJwZ0zgfQXnAVnFxkR?=
 =?us-ascii?Q?plcWZzpbDvD89BP88U00nKuJBJOtAqZfzFrxdHr5H+pET7TftxaWhAxSQeV0?=
 =?us-ascii?Q?khQXbg8oFPe23j23gMlJq++28euZCKJnuRJE3scZ9a/xsuhNfG0yvgWB6XvD?=
 =?us-ascii?Q?95oRDlFfghOwggjEX/gWTFh3kBcegBiRzLCMOeBpppw8YCw9C3IP3xAHC4+q?=
 =?us-ascii?Q?eDU4K4JaFXgHyxj6UFU/CErDPPI//wW+Hqi8k8RwqIzwlDjE0IV0dH9a1xSo?=
 =?us-ascii?Q?b3SPttTijaz0zWn4uGjfGWMbe1M1itHDBzrRP4Bh0BUDW80n9slxE7+Rtgwk?=
 =?us-ascii?Q?tLnLezQuTPwtGadDRbGR8kZxL1mbdBgi1UzeBVyhRru7drV+0oTB1ktC595t?=
 =?us-ascii?Q?oKfrULiXKEi7WOtYO/Z/dw625U8jEszDAOdVm0qqy0WvsplbhZvm/YU87TPN?=
 =?us-ascii?Q?pgGsncZ9T0kq4dMvlEXcrfJG3UKW+198Vv3JixOLp1XGdd3V58ecK2ycR9mn?=
 =?us-ascii?Q?H+1++iWDoOkgqFeLx4Yk8dk6Vox98Bs71DTz2ZrZHkvWd8/4YFcmpukMljvX?=
 =?us-ascii?Q?pBcduElvD0eqiquScBrcaM54d6dn2uvWfEXn2oI0dI65X0pf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f023501-89a0-4d95-19b3-08df191c6b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 02:43:15.7603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eC//0tL7pvTfgFi2+IdqNx6VHetSop3eZ9yRj/pkt8z7qBoN+3aJxN3o37uRAR29ZVPKNLKFRctRpevDlDoelA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10221

> This adds RX timestamping via IPFT rules that trap PTP frames to the CPU
> port, and two-step TX timestamping by cloning the skb, assigning a 4-bit
> per-port request ID and matching the hardware response frame back to the
> queued clone.  It also adds the per-switch netc_tagger_data and grabs the
> PTP timer's pci_dev so get_ts_info() can report the PHC index.
>=20
> [Severity: Low]
> The changelog says:
>=20
> > The tagger dispatches both to the driver through the
> > twostep_tstamp_handler callback in netc_tagger_data, which matches the
> > ID to the queued clone and completes it via skb_complete_tx_timestamp()=
.
>=20
> Is that the right member name?  The struct added by this patch in
> include/linux/dsa/tag_netc.h is:

Sorry, this is an error, I will fix it.

>=20
> struct netc_tagger_data {
> 	void (*txtstamp_handler)(struct dsa_switch *ds, int port,
> 				 u8 ts_req_id, u64 ts);
> };
>=20
> and net/dsa/tag_netc.c:netc_twostep_tstamp_process() calls
> tagger_data->txtstamp_handler(), so grepping for twostep_tstamp_handler
> finds nothing.
>=20
> The same paragraph mentions netc_connect()/netc_disconnect() on the tagge=
r
> side, but not the new .connect_tag_protocol op
> netc_connect_tag_protocol(), which is what actually installs the handler.
> Could that be mentioned as well so the dispatch path is followable from
> the changelog?
>=20
> > diff --git a/drivers/net/dsa/netc/netc_main.c
> b/drivers/net/dsa/netc/netc_main.c
> > index 336f5a4633e9..03200fc63a09 100644
> > --- a/drivers/net/dsa/netc/netc_main.c
> > +++ b/drivers/net/dsa/netc/netc_main.c
>=20
> [ ... ]
>=20
> > @@ -949,6 +993,21 @@ static void netc_destroy_all_lists(struct
> netc_switch *priv)
> >  	mutex_destroy(&priv->vft_lock);
> >  }
> >
> > +static void netc_free_ports_resources(struct netc_switch *priv)
> > +{
> > +	struct dsa_port *dp;
> > +
> > +	dsa_switch_for_each_available_port(dp, priv->ds) {
> > +		struct netc_port *np =3D priv->ports[dp->index];
> > +
> > +		if (!dsa_port_is_user(dp))
> > +			continue;
> > +
> > +		disable_delayed_work_sync(&np->tstamp_timeout_work);
> > +		netc_port_purge_tstamp_queue(np);
> > +	}
> > +}
> > +
> >  static void netc_teardown(struct dsa_switch *ds)
> >  {
> >  	struct netc_switch *priv =3D ds->priv;
> > @@ -956,6 +1015,8 @@ static void netc_teardown(struct dsa_switch *ds)
> >  	disable_delayed_work_sync(&priv->fdbt_ageing_work);
> >  	netc_destroy_all_lists(priv);
> >  	netc_free_ntmp_user(priv);
> > +	netc_free_ports_resources(priv);
> > +	pci_dev_put(priv->tmr_dev);
> >  }
>=20
> [Severity: Medium]
> Do the PTP IPFT entries survive teardown here?
>=20
> netc_free_ports_resources() cancels the timeout work and purges the clone
> queue, but nothing calls netc_port_del_ptp_filter(), which is the only
> release path for np->ptp_ipft_eid[].  It is static in netc_ptp.c and
> reachable only from netc_port_set_ptp_filter(), i.e. only from a user-spa=
ce
> hwtstamp request.
>=20
> So after unbind, up to five entries per user port are still live in the
> IPFT with FLTFA=3DREDIRECT, host reason NETC_HR_PTP_TRAP and
> IPFT_TIMECAPE,
> while struct netc_port (holding the entry IDs) is devm-freed.
>=20
> There is also an ordering question: netc_teardown() calls
> netc_free_ntmp_user() before netc_free_ports_resources():
>=20
> 	netc_free_ntmp_user(priv);	/* destroys the command BD rings */
> 	netc_free_ports_resources(priv);
>=20
> Since ntmp_ipft_delete_entry() needs those rings, can the table cleanup b=
e
> added at the natural place with this ordering, or should
> netc_free_ports_resources() move before netc_free_ntmp_user()?
>=20
> In a multi-switch tree this looks observable without a PCI re-probe:
> unbinding one switch runs dsa_tree_teardown() (hence netc_teardown() for
> the sibling), and re-binding runs netc_setup() again on the surviving pri=
v,
> where netc_port_ptp_init() resets ptp_ipft_eid[] to NTMP_NULL_ENTRY_ID
> while the old entries are still programmed.  Would PTP frames then keep
> being trapped and time-captured with HWTSTAMP_FILTER_NONE, with no way
> to
> delete the stale entries?  For the single-switch case the pcie_flr() in
> netc_switch_pci_init() at probe seems to hide it.

Currently we do not support multi-switch, so this is not an issue in curren=
t
stage, but this is a good point, I will improve the setup/teardown logic to
facilitate future expansion to support a multi-switch tree.

>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/dsa/netc/netc_ptp.c
> b/drivers/net/dsa/netc/netc_ptp.c
> > new file mode 100644
> > index 000000000000..2e743443ca03
> > --- /dev/null
> > +++ b/drivers/net/dsa/netc/netc_ptp.c
> > @@ -0,0 +1,492 @@
>=20
> [ ... ]
>=20
> > +static void netc_port_tstamp_timeout_work(struct work_struct *work)
> > +{
> > +	struct netc_port *np =3D container_of(work, struct netc_port,
> > +					    tstamp_timeout_work.work);
> > +	struct sk_buff_head free_list;
> > +	struct sk_buff *skb, *skb_tmp;
> > +
> > +	__skb_queue_head_init(&free_list);
> > +
> > +	spin_lock_bh(&np->tstamp_lock);
> > +	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp) {
> > +		if (time_before64(jiffies_64, NETC_SKB_CB(skb)->ptp_tx_time +
> > +				  NETC_TSTAMP_TIMEOUT))
> > +			continue;
>=20
> [Severity: Low]
> Should this use get_jiffies_64() rather than reading jiffies_64 directly?

i.MX94 and future SoCs are all arm64 architecture, and we have added
"depends on ARM64" dependency to the Kconfig. So this is not an issue.

> The same raw read is used in netc_port_prepare_twostep():
>=20
> 	NETC_SKB_CB(clone)->ptp_tx_time =3D jiffies_64;
>=20
> include/linux/jiffies.h says:
>=20
>  * The 64-bit value is not atomic on 32-bit systems - you MUST NOT read i=
t
>  * without sampling the sequence number in jiffies_lock.
>  * get_jiffies_64() will do this for you as appropriate.
>=20
> Since this comparison is the only exit criterion for a queued clone, a to=
rn
> read on a 32-bit build could either purge it immediately or never purge i=
t
> (retaining the clone, its socket reference from skb_clone_sk() and its
> ts_req_id).  The Kconfig is "depends on ARM64 || COMPILE_TEST", so only
> 32-bit COMPILE_TEST builds compile the racy read today.  ocelot uses plai=
n
> jiffies with time_is_before_jiffies() for the same pattern.
>=20
> > +
> > +		dev_dbg_ratelimited(np->switch_priv->dev,
> > +				    "Port %d ts_req_id %u which seems lost\n",
> > +				    np->dp->index, NETC_SKB_CB(skb)->ts_req_id);
> > +
> > +		__skb_unlink(skb, &np->tstamp_queue);
> > +		__skb_queue_tail(&free_list, skb);
> > +	}
>=20
> [ ... ]
>=20
> > +static int netc_get_ts_req_id(struct netc_port *np)
> > +{
> > +	DECLARE_BITMAP(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
> > +	struct sk_buff *skb, *skb_tmp;
> > +	unsigned long ts_req_id;
> > +
> > +	bitmap_zero(ts_req_id_bitmap, NETC_NUM_TS_REQ_ID);
> > +
> > +	skb_queue_walk_safe(&np->tstamp_queue, skb, skb_tmp)
> > +		__set_bit(NETC_SKB_CB(skb)->ts_req_id, ts_req_id_bitmap);
> > +
> > +	ts_req_id =3D find_first_zero_bit(ts_req_id_bitmap, NETC_NUM_TS_REQ_I=
D);
>=20
> [Severity: Medium]
> Can a timed-out request ID be handed out again while the hardware respons=
e
> for it is still in flight?
>=20
> Availability here is derived purely from the clones currently queued, and
> netc_port_tstamp_timeout_work() frees an ID by unlinking the clone withou=
t
> knowing whether the frame has even been transmitted.  The timeout clock
> starts before the frame reaches the conduit:
>=20
> netc_port_prepare_twostep()
> 	NETC_SKB_CB(clone)->ptp_tx_time =3D jiffies_64;
> 	__skb_queue_tail(&np->tstamp_queue, clone);
>=20
> so egress queueing delay (link down/flapping, or sustained PAUSE from the
> link partner) counts against the 5 second budget.  If that delay exceeds
> NETC_TSTAMP_TIMEOUT:
>=20
> netc_port_tstamp_timeout_work()	-> drops clone, frees ID
> netc_get_ts_req_id()		-> hands the same ID to a new transmit
> netc_port_txtstamp_handler()	-> late response matches the new clone
>=20
> and netc_port_txtstamp_handler() matches on nothing but port and the 4-bi=
t
> ID:
>=20
> 	if (NETC_SKB_CB(skb)->ts_req_id !=3D ts_req_id)
> 		continue;
>=20
> 	__skb_unlink(skb, &np->tstamp_queue);
>=20
> Would that report the old frame's transmit time for the new frame, and th=
en
> discard the correct response as lost?  ocelot_port_dequeue_ptp_tx_skb()
> additionally compares the PTP sequenceId before completing a queued clone=
;
> since the NETC response tag only carries the 4-bit ID, would a generation
> counter or an ID quarantine be needed here?

This is an unavoidable problem and a limitation of the current hardware; th=
e
response frame returned by the hardware only contains ts_req_id and timesta=
mp.
We can only match the skb in the queue based on ts_req_id. However, this pr=
oblem
doesn't have much impact because timeouts only occur in extreme cases. In s=
uch
cases, PTP synchronization itself will be affected, but once the extreme si=
tuation
disappears, subsequent PTP synchronization will return to normal.

> > +void netc_port_txtstamp(struct dsa_switch *ds, int port, struct sk_buf=
f *skb)
> > +{
> > +	struct netc_port *np =3D NETC_PORT(ds, port);
> > +	u32 ptp_class;
> > +	int tx_type;
> > +
> > +	NETC_SKB_CB(skb)->ptp_flag =3D 0;
> > +	ptp_class =3D ptp_classify_raw(skb);
> > +	if (ptp_class =3D=3D PTP_CLASS_NONE)
> > +		return;
> > +
> > +	/* The rx_filters in netc_get_ts_info() has already declared that
> > +	 * it only supports PTP v2, so TX only supports v2 as well.
> > +	 */
> > +	if (unlikely(ptp_class & PTP_CLASS_V1))
> > +		return;
>=20
> [Severity: Low]
> This isn't a bug for real PTP stacks, but is the comment's reasoning righ=
t?
> The advertised rx_filters describe what the ingress filter can match; the
> uapi definition of the TX mode makes no protocol statement:
>=20
> include/uapi/linux/net_tstamp.h
> 	/*
> 	 * Enables hardware time stamping for outgoing packets;
> 	 * the sender of the packet decides which are to be
> 	 * time stamped ...
> 	 */
> 	HWTSTAMP_TX_ON,
>=20
> netc_get_ts_info() advertises HWTSTAMP_TX_ON unconditionally and
> netc_port_hwtstamp_set() accepts it even with HWTSTAMP_FILTER_NONE, yet
> a
> socket asking for SOF_TIMESTAMPING_TX_HARDWARE on a non-PTP or PTPv1
> frame
> silently gets no timestamp here.  Could the comment be reworded to state
> the hardware/driver TX restriction directly instead of deriving it from t=
he
> RX filters?
>=20

PTP is bidirectional, not unidirectional; there is no situation where TX us=
es v1
and RX uses v2.


