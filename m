Return-Path: <linuxppc-dev+bounces-19988-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45251FAD3E7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:04:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1LXq6z0xz2yjs;
	Thu, 23 Apr 2026 13:04:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776913467;
	cv=pass; b=DTJ84MLuTpTga8dSa8gRMLtBPkgZ0WV4wdRl8scdrbhWZJhcmbgBDo1PtQOHT8TkfTNMh5MAq8Di2MNj8trtuxnrHeLvW8c7qqIwnChxXmj4D8S+uU4Q895voWgLQephSnjyIFKlqgk7q2lN2YZWQcscQOWXGUnHiwgAKeNbIJRR1l/hj1Jm67wS6AzWaJ8zCZzl/pSBpFMqrGzJIgW10jX1fv4ZiwYEoQKPn0omU5v/2mlWPXpj/N3MdE5DPOWJMGJr1Z+1UzpSLO6Gr1/NP6dWV3328n09Ur6HR+lg6PYcCkZ/OMTQOo4GvnpsOpXqtWxVkAQurLJpFr1SUv3zHA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776913467; c=relaxed/relaxed;
	bh=vlAmYP7r9qxca+e0yhfzO5YH1CKnRng0LfJO4BxlUSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DJ/yY1EcCA0y16OtDjVOo5Kjyf5OicJuAX1p5HZwK4H01dQ2p9jqU2cvyaYu6hoCJ+9sJyqshAuE2yWASPe/irurMNF1P/UBJBd4fuoI18FiFqoyMW3CbSvarN8KS/+LuZv1UV7cuR1oeKBXt0+V2bnCL0rFlyC8CLNGMaLvs3Jm6ktVSU4NVsW6pTZT3VexWn9wcJWzCIzZVVt1jeKqPouRVgiVJJkVWFJpzKz92cX+5R0jQ5SauBVg/arQFEv+FVjzzVd5QZNg2I0SxKv2oIv6Azpe80TEMuiNKlhNhLSC/sdZsnDrdBdhWUenarei0ym03Zd+vtjZOX2fj1xqig==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=fo6hDbt1; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=fo6hDbt1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1LXp1j5nz2ygh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 13:04:25 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmxkpDkGmRi3WP6H8RoRQR5cMFpzM1FJIrPcuFFflDNwjQfnLddWHx7oc9xFxVl76Fpbmx6hRqU6HRGXiBV6bEBI8PQxHgdgqX7JwFE77N+hOOZSbU4xP3zddcLYR3NFuwd2rDqVtL79ED7/wH9/RRvO/41xkq8Z6OWKlFuEjEcnaw6I3FHiZbWzPPhgbCipTrB9lNxcXTmv7Pf2SjyGUvYVNKTgpvHMLluaRm0BoTqG8xMtHtnSSdq0xpRElqtj+NhyeZsfcO33ja9vKIWBGyJMSrJHrppl8jkzxScwnhqoMT1MlySte0LDCxb/OuT8MJOqqc1FZbgqz9vGG0U+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlAmYP7r9qxca+e0yhfzO5YH1CKnRng0LfJO4BxlUSQ=;
 b=UNWouhGOk1ZsnMcCd5kQS2lhRP3Zt6iRHyRB1qIzgcd+/N/uq1N2N4Z1LuQMGolVOuY8Kaafilmpooa9IGSQLi8tjbsSCkLfTvz1hJd8KiyNURpIBWN1Js7MNktqsLY1MadOu9YRM/krEtnQAX8RohqTJkk7cOkslfmErJih99TKQmZN3IDV+fyHqo3s+N8tx+AKWu5+L8EYGGFslS4jp1yH/HT8qDLcMtG6Pmxp0AW7Kw6/l4DX/cIt+TjLuO2AocMpl1+5euwo8b9XpaZkMkFZDlG53dhOraaV9BxXTs3iKa8QVTETtkm7QXeEjL5rpAPfksd0TzgkWjgNeuJ+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlAmYP7r9qxca+e0yhfzO5YH1CKnRng0LfJO4BxlUSQ=;
 b=fo6hDbt1eobEaxc31c1rm0mw1jY1eXKG5Kt0yvmYMZgMVlG5xmVKZFqhdlwtHR2XLCKdJY7AuwPYsWszChsJEsAyhy9ML/bBxvD89YO5LjSibp00EdXuuu6VtgEIS6oXQwTBlqNOEU7mDZQoCFMuhqy6Rf/wFUCIL4BZR3Wq/tdtIuaxlu9+v2Iq3xVKHOX6kxQ+v7g6Gz63J1B8n+7jgEoFhwEVvcAf4Fci7ONoCtFzNNCxky8Nx4pZXyr+PhguID0xsZWhdYzLH3iVoEydLZIJBmXIsKscsuCht8TqYjpq2dfk2mOKpWjdmcflnRxEJVWW14bztMZeWMS6qagt8w==
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by DU2PR04MB8727.eurprd04.prod.outlook.com (2603:10a6:10:2de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 03:04:00 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9769.016; Thu, 23 Apr 2026
 03:04:00 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com"
	<tiwai@suse.com>, "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
	"Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com"
	<festevam@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "shumingf@realtek.com" <shumingf@realtek.com>,
	"rander.wang@linux.intel.com" <rander.wang@linux.intel.com>,
	"pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 1/3] ASoC: dapm: Fix widget lookup with prefixed names
 across DAPM contexts
Thread-Topic: [PATCH v2 1/3] ASoC: dapm: Fix widget lookup with prefixed names
 across DAPM contexts
Thread-Index: AQHczLC6HSvTOgrhqUqPN7hDL63+dLXjGmaAgAjnRgA=
Date: Thu, 23 Apr 2026 03:03:59 +0000
Message-ID:
 <AM9PR04MB8353E5A39BA0DB3CF230C7B5E32A2@AM9PR04MB8353.eurprd04.prod.outlook.com>
References: <20260415081942.4183108-1-chancel.liu@nxp.com>
 <20260415081942.4183108-2-chancel.liu@nxp.com>
 <aeITn0SXl-wqgAyA@lizhi-Precision-Tower-5810>
In-Reply-To: <aeITn0SXl-wqgAyA@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8353:EE_|DU2PR04MB8727:EE_
x-ms-office365-filtering-correlation-id: 8723887b-8ed4-4247-5baf-08dea0e4f7a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info:
 orHE+Np6XlHlX/F9TfdbgTSkS23QzXQcAxIPrcFX8jgZCLgWzXlHNNLClXZ9hnpOjZ182MobfWL6TvGyA4nU42LpEYKe9RESer83Ji/OkOpJBiH2c/d/Qj2CVe5EqoLJe3CsHsB2FubhfJ6vj697hvWKdxPHugilha5e78zhDgx0GgbUN18s8Q9rYHJ9QjNOE2bKlTaONNENFe1V0cUIXvZZZL6fQPMs6PxtpvDJrDYhuIRcmrP5EXhkRvxX9v2bihnwSEjScEbuThuFvDJ/YNREc4NOGgRG6DCnt4BbOsmIEhb0OBPklR6fBZyp9IgFY1R5Q/fUTf2oycOxNntvJg3xxuYbeVDG9HXJfF457h7XCMl4JEn22LNhG2b8ni+cxlelWu04fji1v5EK9HAy+SKA+RCR/6ACO8/AHdIZLPuxF9gGWRDHMBfW8NWgnGDLP1oDpU7V2w+ziOKzkMW3EcyoZYYGbzgrpTrM9kpk/i8Th462aeFSXyr1NGBUuZwnH5b5CuWdgoCgIxZRqGnck0NrUwkkedBEbfz78084m27eEeGEmokb9H8/Bj1+Xhbaq4VhxLmbaBHgRLWkyoSMQKN9tZ8X/PSDjr14qMA/GXE4WUnMcn3kWy/E8OaF7igJgqNOH+TbWkIWAz6xqtxtx0TxcFhkjuuloCSkrBrM2wjoU4GKjecZQgkMlHR953XZ+TjTe174fqKrb4yxCfCVxKdPcJD012Ak7+xIxAbZgbFVbSCd4S0L8egN/MwNLx4oKDOLCS+BvLXtuQTAGBrLm3Dm+LvcXK+QqosSsWa0xiQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gkN5Sj4agTbo4m0xo5DiaqqrEYIL5vZlslsBhRaX6qmUmBHlJUuWFaDaDuwn?=
 =?us-ascii?Q?hOWDbAIT5fFG1EtybW3FfjZoVLYa7QbF1BghoIvEl27yueSt8ckjV7WKOdh3?=
 =?us-ascii?Q?otArUEKsEj+eRqgNDlyI/fwX6dqUC8gB+Y1+W+rtxrlG76CXHxLqDldjasiS?=
 =?us-ascii?Q?CzZMrhvceonJ5Rw8vDKhC5IK42a9pQPvfMt+zUSQGQR2VnQA9sZQgmWvAV5X?=
 =?us-ascii?Q?MLU5s7fFP91e3PDrGhxMhTuTvg5YbucDNGfkjyNencORZCp6rZME8Qg8sc6d?=
 =?us-ascii?Q?68qahDj2kj1q52CmlA93yrxSma/0WIy5/zx5nQZY9PufPggDLMTa8ITS2xeI?=
 =?us-ascii?Q?8Drej+cj2CLNaKzvHspMPMgIXP3HNv+y4tfjEDLIEYYuhhXRXVZAHQ4Z9+j7?=
 =?us-ascii?Q?qtrZuGhBW0Su8q7UYwHMCPXXreYRBVE7UFj4xaRXJcQIyV2psO15NmvvNiLB?=
 =?us-ascii?Q?kZd/zw1sBjiQ5PmcHWrHjfwM9XDzQCbiUfVI1CqPGwoKk9xjZLY8tFBVHY8j?=
 =?us-ascii?Q?yNd1BVTl0i7BjWvm4FLgVVywc/vl18T8GP5xexF0s8WpMT32MTaWSyY8mVX2?=
 =?us-ascii?Q?P214n2eQRqB2WJXT2CNQ+3BQOBX/lBweZDeneuC6qJZMv2+7+DGrVJKqBhiw?=
 =?us-ascii?Q?S0/Dfn7Nn7zFEVNAmkDedzrCwbqnGnPMeMwxLQIWf3FTDriJoUoTv9ArzLNR?=
 =?us-ascii?Q?GuW9dJ5qCX/a0M1orh64msfZIrhADAIndCATB4HeMzbEu6q945hNQuyOp9B9?=
 =?us-ascii?Q?bX6POXS8chpFSZ3uxhcxXNF3bCmfYq3/7OK9hc0AQWSfsm/VoDT3RbLd+A+m?=
 =?us-ascii?Q?zwGtnTgIunhPfHyyRt33AY0+oQSXzChH0XyLTw0eQ04duU0hve6Ry6xrTmv1?=
 =?us-ascii?Q?0LahfB3DmtVvcMPqyqpGaIpVE+RWkRvIcqz+OTuOIEq88gE/YX7pZ/WJvUU0?=
 =?us-ascii?Q?Knbs6dgonqxU/TIhH9NrUuxiIgLeAS2tXWy9ew+EAFk4cXWU1PJyunKZh9gm?=
 =?us-ascii?Q?Qy+UMir/qsgBmtQAZ2dSgAQqOjWYzmdWU2WGmIX/mpU7NoHuz2HyuEdK0spN?=
 =?us-ascii?Q?8OyVEnUH5OlRvBiYdw4Kvp/nLacG1Xk5YZgx8DZqE837MCXkGetzUdsrmYyB?=
 =?us-ascii?Q?E/0QFtcxWfPFk+aaC80sRt3RsOQ3NHwQAI6Gi6U9i3S0kRuVaZnCowxTL2ho?=
 =?us-ascii?Q?xeq+SOQSoBJe+KYu9Pkc9b+5irCa7eWmzOXFBTEWLG8LV+eW5mygesJjAOkE?=
 =?us-ascii?Q?ljSKGpsbl7BR1Sbo5wUc9wYAy+gGze6tZhmmaT6y6Z6hqfqkcqbTz85Aze7Q?=
 =?us-ascii?Q?EZXVwSMT/0XOPAEasi8fJzJkX2j03T96e3ALFspp3z62KsEE2bywUyXd/rot?=
 =?us-ascii?Q?hp74FJyD6NUill1FNBTPGwlvisKE8+0zS/2kYMbcl5JIFRNg7qHcEu8GxPHp?=
 =?us-ascii?Q?Sbuu3epNwq5NE0LQS6kLgJP7BSksFEb4dWG1lQ0ir0sfpSSVud8rgMjxxi8x?=
 =?us-ascii?Q?IUP7Kp7+9JjOcMsJAFdanPN4KCpbTCSuWT3hvxZN/xW6OBzomzbEZ1/xoZBX?=
 =?us-ascii?Q?ImGUYEadk5Baklqol/wRieYZ4kk3K2lRZaqbEmkbTSJU5a4lxiGdOLq/LV/F?=
 =?us-ascii?Q?xrskugd1PMi5iv4qrSTIV0v5wvU0DcEAq2hMxubcGGhKc3NqOvYZVGNlCjpZ?=
 =?us-ascii?Q?p2j/gZkmrh8bZX2xuZpNxjqFHAKDjqkgDefdCg9Vc1sQ4YTp?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8723887b-8ed4-4247-5baf-08dea0e4f7a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 03:04:00.0310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiiS/ADdpqLv/xGTzpnGOU0prttoW9g6u+eT1D6j/XRfBKyf3Mj3iM23PvRsYZY7X5QtxOyT1EM33yV6nMBMaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8727

> subject suggest change to
>=20
> ASoC: dapm: Use snd_soc_dapm_widget_name_cmp() to fix widget lookup
> failures
>=20
> Frank

OK, this looks more simplified and clearer.

Regards,=20
Chancel Liu

> > Currently dapm_find_widget() manually constructs a prefixed widget name
> > based on the provided DAPM context and compares it using strcmp(). This
> > happens to work in most cases because callers usually know which DAPM
> > context the target widget belongs to and pass in the matching DAPM
> > context.
> >
> > However, this assumption breaks when search_other_contexts is enabled.
> > In such cases, callers may intentionally pass a different DAPM context,
> > while searching for a widget that actually belongs to another DAPM
> > context.
> >
> > For example, when searching for a "DAC" widget, the widget belongs to
> > the codec DAPM and be registered with a codec prefix, while the caller
> > passes card->dapm and intends to search across all DAPM contexts. The
> > current implementation incorrectly applies the caller card DAPM causing
> > the lookup to fail even though the widget exists on the card.
> >
> > Use snd_soc_dapm_widget_name_cmp() instead, which compares widget
> names
> > using the widget's own DAPM context and prefix. It fixes widget lookup
> > failures when searching across different DAPM contexts on the card.
> >
> > Fixes: ae4fc532244b ("ASoC: dapm: use component prefix when checking
> widget names")
> > Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> > Assisted-by: Cody:Claude-3.5-Sonnet
> > ---
> >  sound/soc/soc-dapm.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >
> > diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> > index d6192204e613..c5b80d9ed64b 100644
> > --- a/sound/soc/soc-dapm.c
> > +++ b/sound/soc/soc-dapm.c
> > @@ -2906,20 +2906,9 @@ static struct snd_soc_dapm_widget
> *dapm_find_widget(
> >  {
> >  	struct snd_soc_dapm_widget *w;
> >  	struct snd_soc_dapm_widget *fallback =3D NULL;
> > -	char prefixed_pin[80];
> > -	const char *pin_name;
> > -	const char *prefix =3D dapm_prefix(dapm);
> > -
> > -	if (prefix) {
> > -		snprintf(prefixed_pin, sizeof(prefixed_pin), "%s %s",
> > -			 prefix, pin);
> > -		pin_name =3D prefixed_pin;
> > -	} else {
> > -		pin_name =3D pin;
> > -	}
> >
> >  	for_each_card_widgets(dapm->card, w) {
> > -		if (!strcmp(w->name, pin_name)) {
> > +		if (!snd_soc_dapm_widget_name_cmp(w, pin)) {
> >  			if (w->dapm =3D=3D dapm)
> >  				return w;
> >  			else
> > --
> > 2.50.1
> >

