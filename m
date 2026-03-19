Return-Path: <linuxppc-dev+bounces-18402-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410221088E65
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 02:16:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbq7k45k3z2yZ5;
	Thu, 19 Mar 2026 13:16:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773886594;
	cv=pass; b=HQhLhYWhrx3edBUhKrcUCbt1BkZadawhl571hP4HxmB0Eirc03LEqwNvvIlU9aZ0zJfYWpIFbrNwtGKk3Om/YBr4KCJbPk9OGdYeEyeIW7k0ORjzf4inhvX6on7xXcQebwfjHoIxnyV17znJT//G3+7Kdmwx6kHzmgQcWyL8DYrXZ4XsW2SbvOoNxhG3MsEKb4X/t6kII2xV9ixtEO22r4BJkqqSMXH8prtNB+FPAYR9GaPVEwkgMG1gNHGRoG5AJFdTG+BSCUPTdqz1LIjtGJMp+Gyy7G5imO8OO8GXIagwRwkG2ed6zyQIWYQMAKL6v90CW1nv3nuoO1dgEFXleA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773886594; c=relaxed/relaxed;
	bh=XWdBEHbQPqGHgN1yM1UW/jfSjDjNQW5KeDs5kWhi/lo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IrauZDkcLel0ulTobQloGE3q9EqDp/MjlTXkxcGjmp4R4ptqDuxb9E7o3kZK/kk4rLk6S8h3wyuDTl3lhWVZet1657oiC9Zz6O4QD/f71ZH2dX0bpHbGi63riPcyh0HvC3uz4rdl55YMsYuOwMQa7Fxvgaemfbx50hUWnscP2jJ5iWB8vYfCCnGfG6rJrKcAsVwAIHD9GcvjOfao1z0akKzmzW7cmeLjllfnKFGFryrkQNqHxr53TxA1xfaQaWjNbmrcFbxD3Vc9tshUtDv5Xz4dbKOy84F1D40wGEog2shalVkGc8boGZizr7PBVpYZoEn7cvsmsAkXk2lNRMkRVg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Bol7AghO; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Bol7AghO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbq7j19PQz2xZK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2026 13:16:33 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5lHWo8ZNe0SGZwxh+tFm22w60XzH01M0l9dcgmGnOy0O6mAYwEwz62lFEE+9RbCWQCEk4rp39C+3izq5rnb5ybjRHiWWm/YwuAHQVLr06rhuTF7KwW92q/xqYpjtTJ/jMRbb0rARq9bkNNG8F5aTeHh+q5rprN/UCFGk7vBXHJswbGevq9Y9bqIVNH96Iol34QyoHL9wtNAUWjHPLMVUD/BKjBEofn6MtL9LEAJWT6AFFI9gnMeq9UlaIS0pOzL3dtrGOvz+VS8QgNmXEImvXn0KvR4FOkgXbKA5UOJ5XYwWelienzGIdxJvZbFoKCez9aoI+wJI2npU4HvFxTTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWdBEHbQPqGHgN1yM1UW/jfSjDjNQW5KeDs5kWhi/lo=;
 b=fPGWB06Flm/AbzTEmsyLeMBhvgsBMx0XQCSHqFgIcfuJgw7Jun62CYMZ6nHbE3XFdczrMvaAQOijMPlhZtHEo/u9fDTZRxbZTYie4WrmSM9yCNX+OhnTX8rNh2JYCNWoD3wXX1mrNxU8Pc+tDhJZYa2AGOlDa4gvgMqNlWgrHJJ2sdrHJNS9G9Pyxov28vV9OinD9LBiTS9EPReYiUdUXx0JQfZbcUrenma+99jC5FpQmWbiWTMsPDXy2yWbB30gS2EEvPYb1S+qMj/DsojBK4A+S2nOXnNQmI6w/vUgLMomHB8Ha/UTOlGfjQ9rrET7WRxCFbY3c72HokJIc+6kHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWdBEHbQPqGHgN1yM1UW/jfSjDjNQW5KeDs5kWhi/lo=;
 b=Bol7AghO3CilEFWUdj4JGRnO1V5dw1vCgK4hljKnxW87SR3fXQ4LBQcRiNpO99wr/pKxYs8rMD/yZF8WADTtZH+HSbbnvSyd/LqSJZOre2bqusimK/pLyC1fgusknBFfSQ9frdAtWIeceaif6ZJWlp9mxj+5fxdER1cq3lNgg5hjEKDv7l+GFGeU5JCR36Ii9ZmtmoiueQCc1mNBx0Et5uGA9uqpqXbn4crNLnVyvcnzA+Nh9K4TxUM7nFq7Acz0oOkcxWoKXGPbLqLm48Pu8oaD2sQtMS8G0rlvNhLL+cN7PEe9McKZ0lb7zPFxKZw1kVV+XEATztHRkZAH3LOT2w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10644.eurprd04.prod.outlook.com (2603:10a6:800:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 02:15:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 02:15:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "edumazet@google.com" <edumazet@google.com>, Frank
 Li <frank.li@nxp.com>, "chleroy@kernel.org" <chleroy@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, Clark Wang <xiaoning.wang@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: RE: [net-next,08/14] net: enetc: add multiple command BD rings
 support
Thread-Topic: [net-next,08/14] net: enetc: add multiple command BD rings
 support
Thread-Index: AQHctuQq/FnYaEFoJUetTqMnxRhImLW1HmPg
Date: Thu, 19 Mar 2026 02:15:52 +0000
Message-ID:
 <PAXPR04MB851014EA687977245AD72ADF884FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260316094152.1558671-9-wei.fang@nxp.com>
 <20260318143201.1888252-1-horms@kernel.org>
In-Reply-To: <20260318143201.1888252-1-horms@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10644:EE_
x-ms-office365-filtering-correlation-id: 991da299-084d-4324-2b5b-08de855d724b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|7416014|56012099003|18002099003|22082099003|20052099010|38070700021;
x-microsoft-antispam-message-info:
 Gr99oiY2RQvGw/GPsUcZo7lUg46JQxPuxZWhiTIbHja0IWi7xBe9RIBYq6iG70hPm6NYhl+oP2q6d4z6bqGEeVkyzEj/T5RomWbd5mhBmOCGid/QvaUTUkxrVb+7xgZsDF/QBKXq/m5rhAH7P/GFrv/b7adRpbbUQKV902kNzrQIiMHOiL63rvzKFJhpmCwYTx8+6OabXlsduaQTNT1RCOG1Z+lZJiU/3TGXr4SmXPzaj6qU8nJnKQMI5ZYvnUhtnuz7AwWGEY8ZDaQU31veBRSdalTdFgDrAbxFKEhO80gWIyXspInntoYsCmkvzFMJoSonu5202/MKDjpsVbCqnwz37ZF5zEp+uD0Qr6zuCySMil6EvDa5EMgNb0e95tLufWIuXG6Q3Jw4/KKxurshEcqRHVDrf22d+UhM8Ykrlo/w5sALoDndvYA9QtwTYArvGnfrh/i5nrzt9o2Ih2cXEjvhfzc1IobH7efN+ghneFI/qyRbzwg7fyq43WgqxQlFQY3V1z3ARaP8sPc++pENc+n0AepT4YhKyTPSEsMK9DQFSXny9y3DQdPyX1A0uTDdfshoyupiV5REPtmbMWesTRoAQfVuBf4dT3i6bYFoyTYIiB/+A+zwzum4X9HIu30j1HXSX1hPdAcLcogzNTOZfRtV7by6GiMOAqWGcuCrResfOejRn6/Al4CE8bd0WKN2tX4XB/ChWMTidtD9B3RtafrhaElx2VfWs7dFDO0uvzYOiPakE/YiaAHDwQWjBAT83ccUn68IA4TbiZ08YL7pGiizqVocpXOCQiAGbhwkH7I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(7416014)(56012099003)(18002099003)(22082099003)(20052099010)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Y57iigEpsPWll5nts5mHo5IoMPFBdaa88AH1xXZ972lpu+aGxzoRMDSR9X+f?=
 =?us-ascii?Q?CY/i5EIlzRrcQynjjQHLlKTkC95KcKbifBqkdDdHBsUidFPxHsTrI0lKf85F?=
 =?us-ascii?Q?P5YdBPFDNtRHH0NpZprXbk/B/aUhBT9h2nF5UNyRlaRDVoWiGWEb1SQc6Eqm?=
 =?us-ascii?Q?ig3amEh/qc3CCldqOXT/3wyG6kSqle9D8VdKXTa8Q60mEhWZv7Bld4X+CGZa?=
 =?us-ascii?Q?+SQpd1M/jhTOC2Ah2QfFCtx+zmIgO6qvZFzBSzE+Ylx7WyloGeFObCkecTIg?=
 =?us-ascii?Q?EtOoCFHX46Xa8EVmu5OoVgGJYscic9P6nf1azI6UHBdXR02PV962ELptcPT9?=
 =?us-ascii?Q?0I6gQ/pN5uGeFpuSmn6hFay3eADWq+ljs8j5DoOWHfBgELtdxMJNWBOiqpH+?=
 =?us-ascii?Q?GzwdJPs+mn20B0h6JGjDHQ5YK9VR2wbbVOxsRNP77gP7vWi5AqqWAR/X0sdl?=
 =?us-ascii?Q?XYSAm6jmlXEy7drfgNEC75rr7cwGAd5gUzPf6sgVcjFcUp5g5E7sWj7uZmYy?=
 =?us-ascii?Q?TQ8dXwmp72Fef89F0tDklUCi697F2H87NOtu4zk3vQesur5P1vnDSDYNk9hO?=
 =?us-ascii?Q?pFXa0PrShTrt8TU2IKECJHYb6W67Q3jiKW6bGplGELjfZ/ULk+zZgIOfUfgl?=
 =?us-ascii?Q?d1xFmYn4LuG1CTFiZbwxPvfyfoL6022mxx/Jv1B906YLTdIbdYOIcpjPo4y4?=
 =?us-ascii?Q?+2h442va0e9ePqsmlPCFMK+lAQRsqmiQHhGdYyfavHwD0Be001JUc0owghGZ?=
 =?us-ascii?Q?/5FnRkAe06Au4zQFzGTj/wlTBPZMCIINPMJPlwG2Jjxt6h8yFhlKotkwM9gV?=
 =?us-ascii?Q?wCnpBhAJzzS6LGI2DY1H2xzjcVj+hnmwGQky7Ty+XaswkqXdOBWRL47vI5Tg?=
 =?us-ascii?Q?J/GkjEHJz7WXqgbEy7dQA6p5fklYp6dJV+wJsr9AXJvxu/li1dRkqLD4eMSS?=
 =?us-ascii?Q?o7Ctpl5YWgc81aVEuwf1OfOOAqtU6jvFnjdR5bIzlQ+Bygxf8g+nassFF/JJ?=
 =?us-ascii?Q?KxgGGcxFDIUw6b375sOz6TXZOGDMVtR/adNcrxd/H5M6bY9109cjtR9KrXaw?=
 =?us-ascii?Q?PJjHiIhsMfBAbo5tpXKZnHe+2bod1QODECjUFEaYz03bhJXidNoSUG347YUa?=
 =?us-ascii?Q?RkzFuC/1di8tHUsGSIzt21PsSIHKEjp5REOND/WkOge/OHE9VVBDZCvMI5pJ?=
 =?us-ascii?Q?WNZKnh2EOA9/2blVWyMP0IdWPyxSJPftq/NQI2gdq44twmsbVTchJsxo722X?=
 =?us-ascii?Q?Jmke2oqgqGZQIBBCRPP2RO+o8rlo/YXieeQONFdTYsltbLxFMVZib4Gp0u2t?=
 =?us-ascii?Q?cVf360p16EzprAb4QpThNPyJBntB7CcYnlJFtmcxChEnNQ+yIozBcrz5rhIe?=
 =?us-ascii?Q?a8MTaWSSOTRp2bRbJiRB0u8rBnmt1TM7WgB2iMZYMriQFs6kfhEaugDQLVbg?=
 =?us-ascii?Q?mwc4QI0iRxf+M0HhGpUYf6bRop/A5g3m+Oar3rKJCeMSn+jmS/GwG/fBwrnK?=
 =?us-ascii?Q?dPsyeHw6AzvpyqhzbCVnkB/agW5bsOy8ifKJO3FXGPl2YNoBYwdwvYUwpWZS?=
 =?us-ascii?Q?TwgurttpPO2fLD0YB8macK61rj56hyYmQ6NpIPcHVuNnhhGO/mfJ/ptS98hF?=
 =?us-ascii?Q?pOA/RECT4rYL+XyFLm0rxrMPuWAvT7uCPAFphhvt7BIPua6NmCOlrt1Z0xF4?=
 =?us-ascii?Q?2AwHocvAqahS6eu9n5WoxV7izfOZx45Win40BfDOVMlJElPA?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991da299-084d-4324-2b5b-08de855d724b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 02:15:52.8582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I1D729RZQfCyf7nmg6+HXyKx/1aqxPCM3fbg7rwJhVk+VMVXMfTGE0aiQzZ2SBXBjZouPZ13sjQvat6pWM0jqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10644

> > +static struct netc_cbdr *netc_select_cbdr(struct ntmp_user *user)
> > +{
> > +	int cpu, i;
> > +
> > +	for (i =3D 0; i < user->cbdr_num; i++) {
> > +		if (spin_is_locked(&user->ring[i].ring_lock))
> > +			continue;
> > +
> > +		return &user->ring[i];
> > +	}
> > +
> > +	/* If all the command BDRs are busy now, we select
> > +	 * one of them, but need to wait for a while to use.
> > +	 */
> > +	cpu =3D smp_processor_id();
> > +
> > +	return &user->ring[cpu % user->cbdr_num];
> > +}
> > +
>=20
> Can this trigger a preemption warning? netc_select_cbdr() is called from
> netc_xmit_ntmp_cmd() before spin_lock_bh() is acquired, and the callers
> (ntmp_maft_add_entry, ntmp_fdbt_add_entry, etc.) run in process context
> with preemption enabled.
>=20
> Using smp_processor_id() in preemptible code triggers a
> "BUG: using smp_processor_id() in preemptible code" warning under
> CONFIG_DEBUG_PREEMPT.
>=20
> Since the CPU value here is only used as a hint for ring selection and no=
t
> for correctness, would raw_smp_processor_id() be more appropriate?
>=20

It seems to be a potential issue, raw_smp_processor_id() is more appropriat=
e,
thanks.


