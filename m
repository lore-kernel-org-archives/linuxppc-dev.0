Return-Path: <linuxppc-dev+bounces-29616-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD434CCA46C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 02:25:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j65J206spz2yqx;
	Sat, 17 Oct 2026 13:25:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792203921;
	cv=pass; b=UYFMVoE0Ktbotd0CTPbJ1kipcAIkaQcPGeXOi3OFLd6mmQ5tQOlS2KhIZWBA0H9+LJqWJBzsPVW7mKzsl3kj/GI5M2HpukTA6zPpf4qCmXeXNkk3/z3vPUhyTLE6czKCrSSPQ/JtICPt4jhNHyJPsK39HSrMRWrxgIunaY+2ACIyxy+HN0VEswOU7pHs8lCSM2nKtamOfoe7Ry4z9eHXCTLDsaxl5WkK6ingRdks9vQBtiUSlYNlEubQ8Ta/TUuJe2zbxTuc32TsvdODKBUHJaEvTi/Qep2SJ3N/o/oAWf5aburAN7+gZngmGNKA8T76gI1SZmMQZOIGLxf7c+TJDQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792203921; c=relaxed/relaxed;
	bh=RlmdC/ZrC2wE8s5bUwcx60nsjLZEKFAjdQUiwuhb7TU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W59sag00m7724MyxLquveh//13BhxxWfT4cCsRnw54OSpUiKkf0z3VLhTIJfVG6C8UTQUAo0TRRnLVudNTmigK9BPWY7OB/ad0K0Qhw2v/mJpA+Smnaax8SIHpO5rwBhdBscNbk5CxGT+2rte7dOPm12Nk/8Ny3G75QQJOql3glKKigBd+3tcYPk4l2qtdGzSNyJpweP03QCfGFm0oe60JqwIoUt6t0rUdgDbH3Aui/nWygp2BJZj6Njd7RRGWuukiUmAg1VzuojRJyI2uiWzTAHc04x7Awi9FfD3P4AFzsA6n5SlBW8SghYIzr7mzhNtZqx2hjuaWp+GVy9h40+Ug==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=jSMcoIF7; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=jSMcoIF7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j65Hz4Qn5z2yfs
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 13:25:18 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGRSqtPrGB1UWsIMBLXKAIEibVODe0iFB2TSq3/iRpqLPjDZeA46wmE6FnzE3PFr0Wlwqbz8mAZXogsvLSkIod5k4aMrcg1/QKfheqwWY8aKSbx7Hu3difETiVrfwQCWY6L4l4TSjjvF86gpN/m90GVCFdSsVWvYaihk9yFqTW4dkg9bKb4FSzlJJLobXI3Y932Vi5gi33ifZAvuCwHqKgb+4Gjbz9/ip1zEYICKCMbZ1lHHvgGZzQx/8P43Y11O/58+m+y6pzKbN8QAFaeaE0+69JeZ24ymQet3PaN+g6Pq4CI+5SQoT486vOaX4syoblp56hPBWLKY1rcCf0XwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlmdC/ZrC2wE8s5bUwcx60nsjLZEKFAjdQUiwuhb7TU=;
 b=EnnTZ7efK97Oa86yOnDGb5DG5W9SRY1gv5xlsJgA8mcqhw+HJXs26zGQce9vT+9X60SGAdl8GPYzwtT8LEZ6g3GX2FDoP4uvSPqrCuPqOZnlpwSmoRMBK1lDuLV22Y3vw+mrbREfX7ga6SLSLEhaO1jZA2WHXBVawIaJGe4uBea62fv7L9m/bJhvUBiGkizw15Y+l7zpGmUAFKbsfVK3lmsgJYOXnPMAsp2U+oRlvb0oeaJ82oNrmTu57Z3ASlsiGXajGUTgjuCjboeKEbfziYIQjYoUUSqT9xmNqcfT4WGZvlgZ/oPpaYfsdBZGd7bCZRPDUFvddPpjr20tTsb/XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlmdC/ZrC2wE8s5bUwcx60nsjLZEKFAjdQUiwuhb7TU=;
 b=jSMcoIF7eu67kLk7m2ZS/jG5rrVVp45RenXa+oaKDmpAWZP3g+nb5vT3UImcPB6xHorkDGedLnHZrpsrLM8afg0N8v/IeAxVOLWf8TJasj0UMwPEcTzOqcHoOHmKaC3gwP+M1hIK0dxtu4wT28I9L1uZpfPV8fsrykgC/7MQlWjHxEfZjbJ44cclBy9fdwBQMi3qeJDQ4SFaRXtnHRfHk/098FWwpB7qxRbNBJmYWVxghc2TVmhwgLlw5XkHJKmoc5HWOwrIrBQq+7QTsIEwizLn1REMl3cV8VFp4SZyPmH3LUEi5i9wqMnO6XyrihV3L//YttyAwR1D12wGtd4MBg==
Received: from DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6)
 by GVXPR04MB10754.eurprd04.prod.outlook.com (2603:10a6:150:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Sat, 17 Oct
 2026 02:24:50 +0000
Received: from DB9PR04MB9332.eurprd04.prod.outlook.com
 ([fe80::75d8:3bd9:28df:cfdb]) by DB9PR04MB9332.eurprd04.prod.outlook.com
 ([fe80::75d8:3bd9:28df:cfdb%2]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 02:24:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "Frank Li (OSS)" <frank.li@oss.nxp.com>, Marek Vasut <marex@nabladev.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>, Eric Dumazet
	<edumazet@kernel.org>, Frank Li <frank.li@nxp.com>, Jakub Kicinski
	<kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Subject: RE: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable from
 DT
Thread-Topic: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable
 from DT
Thread-Index: AQHdXaVPTB8CJdKLoUewahs8NUD/ZLcAl7OAgABoBfA=
Date: Sat, 17 Oct 2026 02:24:50 +0000
Message-ID:
 <DB9PR04MB933217F7ADCB6223A44DACA7889A2@DB9PR04MB9332.eurprd04.prod.outlook.com>
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com> <atKDNdxl0w65s8yQ@SMW015318>
In-Reply-To: <atKDNdxl0w65s8yQ@SMW015318>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9332:EE_|GVXPR04MB10754:EE_
x-ms-office365-filtering-correlation-id: 886d8eae-da9c-4722-6146-08df2bf5d273
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|376014|1800799024|7416014|366016|261009223027099003|6133799003|18002099003|10067099003|22082099003|4143699003|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info:
 giYjXPglTBeQWDBLuEXOHODYW3VeC/AddZnYh2zykdTi3fxSKePv3mMOyUJCVq5onkFATkW4Gs79DDYPVOBL2FSZQqa7MnB9aCKf7ss8CNlmUZxExm/UouCGxRhTNDXXniGsRhHsSE5Kt9KK4UPvaSR+pjwEW6R66MAxgiKGm0bLHRyYMWQBJk+o43Zr5NJIvxb+tyoj8Kcg1C4GgeslSAE5uw+GMJjD0Bet03EGUcpEecz/KrivWkOIBqwHS4EC6Hm/74C8OenK10f8O5P9HijiPOka8AVrUDAhic2Ddhcc90kUHzlNfeBM4FJFXcPlxF1SVpbTwMvPHeybx+e5S679HSj8xRsAAZJO197OwxySixUbqqMdI37s/5afipTlAUVC8I5m5YIC2gHXF2C/UK5Dy3jejIvF+l7Toa9d30Fm9kM+rnvvxCwbMbNs61rZBTAzXKvUG/tGjQLVl7hMJ9Ut/HO5We1rNBSKoL/5mAoK+BXfJSgnKkA2+g/XwO3LwWZV4BH0i4tKzvSIT3WWWi5A1dNgAVL63aha7Dw0YIpoou89MTwfvhZMOJ5Hr2GlYfKMXO69RlBAAXVM8/LMMDAWVY3OJPAiOLpevdmTqmYVkGONX3gnH3vnRJ04ffmo+w+DOEaF55iaMEx5pMh//enOasg9W6ERI4dOaRJ/M8bpXCeQ+LPlSjMpfhiRimXJ6kH0gBrgHq65ZWwWcQL78w9siplbhWw+mfBq4gDRmiQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9332.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(1800799024)(7416014)(366016)(261009223027099003)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TXoMRRWqcoF2V1IhUfs6nIOWYB5jWNG3KyaQjCVanuqwItF2ZeP5wFsTWTUc?=
 =?us-ascii?Q?52OxOxyx7RzCJeiHre4PqgpaUByfFmvq+hwi1o3gPdu7UsaoyoDbXFJGUQuo?=
 =?us-ascii?Q?JxXyondc5H3yDc4lZ9y7SMnuPQdksxpZVfrMlyfffoSedK4KtiM3VjDifiuJ?=
 =?us-ascii?Q?XPdPMRSkpGN+vRx0vtb+VtjyhJM5/AgNHEoEQzrV1+Un3F0B0IEBlAJ1mks3?=
 =?us-ascii?Q?bDLDlVKrHNTJEF0BJ+dpcXdIT8jluRhZqSn/uGqw7vh1MkOPiIkrA2nDfIOo?=
 =?us-ascii?Q?5WGWE5Sx5W0A5OQxcFBcXG6rC2sWb27N+6W3SI/0QMtogF3psCq4qniDJj4H?=
 =?us-ascii?Q?Ze+vBB9GZn5kORTPuGlYJL5WXW1+0R/qaj4731SLjg7s0oodQEDZuCRdM7Z8?=
 =?us-ascii?Q?EzUpExAp577SLvEvG+iYrShLJ7IVdT5W33Tx8GuzVEUhWqnz2J/c7qrKraVO?=
 =?us-ascii?Q?R20mNkMpCyUnoXnc4G0PGda0oyfUGKyou5rk+JyjaawHvLQZMPQYZzUL/kY7?=
 =?us-ascii?Q?Ay9BMraypVRIt7PMGNSj639h4kzHOiFn34+JuL74H+5wmjyofE203fvpdq2M?=
 =?us-ascii?Q?tiviGpwT9HVDwv7SEdRboNTREBopkROWPMjGgypn+TZsvPuA27kZyLcLL/li?=
 =?us-ascii?Q?whbPCn5rjV+RZM0sVsVeB+vFNu+ccvencAOXKc+3nVPPuVOuHPfFmOiCdO9a?=
 =?us-ascii?Q?KveOujJZ//LGsBVmrYRqFW0nBdwsQvJTuqubS8zZVeaiUzlIufz++a2rgYSG?=
 =?us-ascii?Q?pI9/QTSV7a9g9xFC+eJbVue/JCCT4UmLQpBfG/LXKVHFDov6GZ8mi70vlf4n?=
 =?us-ascii?Q?pM152kYMJfMr/Lz273GDSddJK3UsjIr/3mpH9TdACaVfl17HW7EFFwp/wmEg?=
 =?us-ascii?Q?H2KMPcheE0/lZFOFNfrD7Ny7sW0WPoHFPrCOXcZiRgVBlHrqBeFc+A/m7ZVy?=
 =?us-ascii?Q?QDZ9kpRPPJgrcI5YAOt87i5+A1/OEAgzFoisQoBRhFPzbdzuh0AxnO5/Pyx+?=
 =?us-ascii?Q?a9atvfLp3v0zxF5y2iBWcac1y5J+vtz9+a+x8/pLx+iNPUKhnMs/sDOu2vRm?=
 =?us-ascii?Q?aARCkEV8eQCMxg5tGE1CpAYfWIQI4fSmO1untf0Apua0ulfEWVVSLPa1B8lZ?=
 =?us-ascii?Q?JV8LxrR1tbV9tAZNCxFPLQNvNZ7cPZD5UIslrn4/2cElxdqfPnexRadAMkoY?=
 =?us-ascii?Q?DvO4vPyeIFWl64N5ONzN+oVI2XAF4ArRnrf4vnyQLMdM8YquYyfVRUb96UNO?=
 =?us-ascii?Q?415xX/yIPXX8y8XKtOzPQ8x6GOF3pQ+yTcWkps5jK9LHkcvYYVMBU2cGZBZN?=
 =?us-ascii?Q?+J+J0/SC0xN+TqKnEC9dLPkStE1Xy1jshNgKhMtDAMlltIc4H5ZI/1rImAUE?=
 =?us-ascii?Q?6IZRhrwKV8r2RTW2na8Ainth1J/V4ZTt8FGF8bliXMrY2ohia1PsMUNVBJ1/?=
 =?us-ascii?Q?iOaS1T79dX2bM2u0YpKHL4Bu+JM/4jZMYQFqZMo9PJvzoDoH4SQBebtLScor?=
 =?us-ascii?Q?PvGVBGOn++6UvEsHK2iVhVBHD6Py9hneWPBsBBdUJswPOADc9xqACboEPaoQ?=
 =?us-ascii?Q?G8sSe9uZiDAKus/GtIbbb7UAyWx8vlQ+FtXQnhZqMKuageU0FvA7CDgBJFCW?=
 =?us-ascii?Q?zHf83kj6Np4TYsZAjNwL4soqroybt8IP/q3Z7SSa6jPLfALLdzTCpDdjd3qO?=
 =?us-ascii?Q?HJZ+vw4Nq+ZXQWqinSKliXlW6k4WEjWAX3Yc3YDQNBg8h6dF?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9332.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 886d8eae-da9c-4722-6146-08df2bf5d273
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2026 02:24:50.7335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXpGZIatfbKKxUfTK3B59AUPDBD0FwoN+GRKqtDpf2qrirz8/lF6UOhxjFDOevHjG71kBL/Oq32ps08iehIp7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10754

> On Fri, Oct 16, 2026 at 09:32:01PM +0200, Marek Vasut wrote:
> > The current eMDIO MDC rate is hard-coded in the drivers which use the
> > eMDIO MDC, this is not flexible for various deployments of SoCs which
> > use the eMDIO interface, for example i.MX95 B0 MDC clock is currently
> > set to 644 kHz.
> >
> > Introduce enetc_mdio_priv .mdc_div field which contains the divider
> > used for MDC clock and pass it around, including into functions which
> > configure the MDC clock. This way, drivers which use the eMDIO can set
> > the divider as needed. Introduce enetc_mdio_update_mdc_div() function
> > which calculates the divider from upstream clock and clock-frequency
> > DT property, both of which are optional to retain compatibility with
> > older DTs. This is modeled according to xgmac_mdio_set_mdc_freq().
> >
> > Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Signed-off-by: Marek Vasut <marex@nabladev.com>
> > ---
> > Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> > Cc: Clark Wang <xiaoning.wang@nxp.com>
> > Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: Eric Dumazet <edumazet@kernel.org>
> > Cc: Frank Li <Frank.Li@nxp.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: UNGLinuxDriver@microchip.com
> > Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Cc: Wei Fang <wei.fang@nxp.com>
> > Cc: devicetree@vger.kernel.org
> > Cc: imx@lists.linux.dev
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: netdev@vger.kernel.org
> > ---
> > NOTE: I could only test i.MX95 , I could not test LS or Felix
> > ---
> >  drivers/net/dsa/ocelot/felix_vsc9959.c        |  5 +++
> >  .../net/ethernet/freescale/enetc/enetc_mdio.c | 39 ++++++++++++++++---
> >  .../ethernet/freescale/enetc/enetc_pci_mdio.c |  5 +++
> >  .../freescale/enetc/enetc_pf_common.c         | 10 +++++
> >  include/linux/fsl/enetc_mdio.h                |  6 +++
> >  5 files changed, 59 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c
> b/drivers/net/dsa/ocelot/felix_vsc9959.c
> > index 8387dd208adb9..dbeec1b229325 100644
> > --- a/drivers/net/dsa/ocelot/felix_vsc9959.c
> > +++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
> > @@ -1008,8 +1008,13 @@ static int vsc9959_mdio_bus_alloc(struct ocelot
> *ocelot)
> >  	 * starting with the proper offset.
> >  	 */
> >  	mdio_priv->mdio_base =3D 0;
> > +	mdio_priv->mdc_div =3D ENETC_MDIO_DEFAULT_DIVIDER;
> >  	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
> >
> > +	rc =3D enetc_mdio_update_mdc_div(bus);
> > +	if (rc)
> > +		return rc;
> > +
> >  	/* Needed in order to initialize the bus mutex lock */
> >  	rc =3D mdiobus_register(bus);
> >  	if (rc < 0) {
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> > index 998aaa394e9c4..93d61c2f1464f 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >  /* Copyright 2019 NXP */
> >
> > +#include <linux/clk.h>
> >  #include <linux/fsl/enetc_mdio.h>
> >  #include <linux/mdio.h>
> >  #include <linux/of_mdio.h>
> > @@ -22,9 +23,9 @@
> >   /* external MDIO only - driven on neg MDC edge */
> >  #define MDIO_CFG_NEG		BIT(23)
> >
> > -#define ENETC_EMDIO_CFG \
> > +#define ENETC_EMDIO_CFG(mdc_div) \
> >  	(MDIO_CFG_HOLD(2) | \
> > -	 MDIO_CFG_CLKDIV(258) | \
> > +	 MDIO_CFG_CLKDIV(mdc_div) | \
> >  	 MDIO_CFG_NEG)
> >
> >  #define MDIO_CTL_DEV_ADDR(x)	((x) & 0x1f)
> > @@ -63,7 +64,7 @@ int enetc_mdio_write_c22(struct mii_bus *bus, int
> phy_id, int regnum,
> >  	u16 dev_addr;
> >  	int ret;
> >
> > -	mdio_cfg =3D ENETC_EMDIO_CFG;
> > +	mdio_cfg =3D ENETC_EMDIO_CFG(mdio_priv->mdc_div);
> >  	dev_addr =3D regnum & 0x1f;
> >  	mdio_cfg &=3D ~MDIO_CFG_ENC45;
> >
> > @@ -95,7 +96,7 @@ int enetc_mdio_write_c45(struct mii_bus *bus, int
> phy_id, int dev_addr,
> >  	u32 mdio_ctl, mdio_cfg;
> >  	int ret;
> >
> > -	mdio_cfg =3D ENETC_EMDIO_CFG;
> > +	mdio_cfg =3D ENETC_EMDIO_CFG(mdio_priv->mdc_div);
> >  	mdio_cfg |=3D MDIO_CFG_ENC45;
> >
> >  	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);
> > @@ -133,7 +134,7 @@ int enetc_mdio_read_c22(struct mii_bus *bus, int
> phy_id, int regnum)
> >  	u16 dev_addr, value;
> >  	int ret;
> >
> > -	mdio_cfg =3D ENETC_EMDIO_CFG;
> > +	mdio_cfg =3D ENETC_EMDIO_CFG(mdio_priv->mdc_div);
> >  	dev_addr =3D regnum & 0x1f;
> >  	mdio_cfg &=3D ~MDIO_CFG_ENC45;
> >
> > @@ -176,7 +177,7 @@ int enetc_mdio_read_c45(struct mii_bus *bus, int
> phy_id, int dev_addr,
> >  	u16 value;
> >  	int ret;
> >
> > -	mdio_cfg =3D ENETC_EMDIO_CFG;
> > +	mdio_cfg =3D ENETC_EMDIO_CFG(mdio_priv->mdc_div);
> >  	mdio_cfg |=3D MDIO_CFG_ENC45;
> >
> >  	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);
> > @@ -231,6 +232,32 @@ struct enetc_hw *enetc_hw_alloc(struct device
> *dev, void __iomem *port_regs)
> >  }
> >  EXPORT_SYMBOL_GPL(enetc_hw_alloc);
> >
> > +int enetc_mdio_update_mdc_div(struct mii_bus *bus)
> > +{
> > +	struct enetc_mdio_priv *mdio_priv =3D bus->priv;
> > +	struct device *dev =3D bus->parent;
> > +	struct clk *enet_clk;
> > +	u32 div, mdc_freq;
> > +
> > +	if (device_property_read_u32(dev, "clock-frequency", &mdc_freq))
> > +		return 0;
> > +
> > +	enet_clk =3D devm_clk_get(dev, NULL);
> > +	if (IS_ERR(enet_clk))
> > +		return dev_err_probe(dev, PTR_ERR(enet_clk),
> > +				     "Input clock unknown, not changing MDC
> frequency\n");
>=20
> binding said clock is optional. If return failure here, it will block
> existing dts, which have not clock property.
>=20

For EMDIO device, the clocks property is not added to
fsl,enetc-mdio.yaml, I suppose this property should be added to the
dt-binding doc if the clock is really needed here.

For ENETC device, we already have a 'ref' clock in the enetc node,
so devm_clk_get(dev, NULL) may get the 'ref' clock rather than the
system clock of NETC.


