Return-Path: <linuxppc-dev+bounces-25046-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B03C53200
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 01:31:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9Wrm5V89z2yFg;
	Thu, 30 Jul 2026 11:31:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785375112;
	cv=pass; b=GxP5YWIFDgO9WmX+O0Hx68yUkHVBWbf6daS9oKZOby3fmz+HHr18p0ar9OpJgF/JzjYHBuMKRc3XXho+o01utQYW9HizpdzL6ha8MW1gQd5juXW75xu/UTtT36fQP1Bb0feGf6mkctkPzUMPoNQgtg39nmSqzJ4OhBQK7nlacO/SxuUv5MZPrTBqQmePDDjaQX3wcQFk8nUpEUsbaI0F8N8Ed6Kk7n47BzHUn08q6/MQGe4DOjy0qFO46gsHMw+f7W70ZLmKlXWZuJkf/UhLsqMV1T7Exc17qINFzxZMPiesqDdFtBE/1WBRFsuEpuI2D7lsOFOBhRzmI4T6wuR9HA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785375112; c=relaxed/relaxed;
	bh=eOIU1cGy+SUZjrCYE5aRvcFynOBTD8Zx3O91TkgEGIg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TEC9Ef0DAbb4/YbR19Tg20YMp6TiZp/R/4g8AuHhRimvBDfdKr1thVvItnPh8yaMCSXtvnjRKtmsig4Bbi2XQmOi7Q+Fsf8NTINBO1QFKwZ0pNZifDgLpxIRZbrxBWR2m/Ye+5jWdZP+1uQ/3r4EYzrk+WzgH7PQJqzDdhYJRt5CyIBPE/Lo212Sa2aVBMxTIbySjZq2DTmpqrcSdBmtPbBmfTE+8CNeUidA3u4aFB/1B9UUL/MXL7to1/uzeF7JCCU6fEWD2Dkv1HjcceMr+a4dOFIpP3r56pma4pFTInVTn9LFu1cjYTtkV+6oPzlQ5duk5lrX75r92jcjWJueRA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=BsyRIQOE; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=BsyRIQOE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9Wrk48qHz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 11:31:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmREe+2mXwnupEYG6r/yQgLM795i1xki2TqDF9FrGtZRYp7r6P1pzizqo37AzWyJ2249fmbzaleBixDM0gdDCM3Z+HJjcVYOQNzVbaEK7S5b6ZC3KCB4dnTVJpzZeJCKgIseSuup4zRM86HgeXArVaov+PH+Tbc93Hoo1YgX9CaAiraPOTbGB4RLbUvpXfqcZdqOjGytcgdGoUBW61373LHUfUUqxHjhF1a0FsaSx3Njv9CVBwLKT6JQFT/9+shy6UzgvcSHIza1LbqeFRLsZpYrJKWoIBryuFiM9CNISAbm/pz7dUNOcYVgPzjm/SAonydXbB0MZpzE2g2aw498bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOIU1cGy+SUZjrCYE5aRvcFynOBTD8Zx3O91TkgEGIg=;
 b=OJY+fTudp30V0MOeC/D7/98xX4cPFueKw3d+y1jE/nMlX0ng5xozr3q2Ut3anL/1EHIn6EzP91APGsVJMN4QngpIOIg/FWk+w5ZoEIfA/MET0+sYQY/eFy3doAOWTPvXLA05kwHUD/Da42HcnxPMX186L0rjxjGHH1fAIgJah6nm49IzuVD71k6cuvGKZwwK9y8u3HdBmF0SobRtQnNcPvSSRQpWW+aB58z3o8B6MbqkK7E8M5/rRsvWzfFtwnogXrzJ7pcuCViIZ8foego/RXhIfnQ00y/Vv49hTWaEsRJI+r6WqYwQ67B0Yo/RhiLntFRmGOAJH9MMey9kvvfFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOIU1cGy+SUZjrCYE5aRvcFynOBTD8Zx3O91TkgEGIg=;
 b=BsyRIQOElo5WIlRhSdliYNr8rrtckVTeSRLqXRwFrk7FBn00hZqdtsPWgzq4xTy3lu/gkgC9bYbbSlakRBvDGkjfukKQO/RVwSRTJJ3MtOPjZKLl/WSK15Yvc2jkX04qDaKF/fIa/94SRs6bsmlfg6eY4zj5pisxknmQjza9pvrR7l/k4FEV13+uO+JcVLgRZyjyUOYY4AaoZ+M6/f1ZTly3nM03qhG47/4xUuFyh3nmZO0RhKfvQDqDV70Y7cOe9GuUawSWz9kc4RDNN5d+E0emYwQcYJCnYAcaYCbbfJKRSZR0SW3JK0neGyzTjcFjfNOTd05mjtU5xYzlbjuiUA==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by DB9PR04MB8347.eurprd04.prod.outlook.com
 (2603:10a6:10:245::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 01:31:23 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 01:31:22 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "Wei Fang (OSS)"
	<wei.fang@oss.nxp.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>
CC: "chleroy@kernel.org" <chleroy@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH net-next 6/7] net: dsa: netc: add PTP two-step
 timestamping support
Thread-Topic: [PATCH net-next 6/7] net: dsa: netc: add PTP two-step
 timestamping support
Thread-Index: AQHdHn3QkpUr6cDt4EqYdfYE1i+p9raEgvcAgADEjZA=
Date: Thu, 30 Jul 2026 01:31:22 +0000
Message-ID:
 <GV2PR04MB11739A4EDB782AB83B60968D988C92@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260728104548.3301214-1-wei.fang@oss.nxp.com>
 <20260728104548.3301214-7-wei.fang@oss.nxp.com>
 <59ecaa4e-f111-4dd4-914a-7704990ac58e@linux.dev>
In-Reply-To: <59ecaa4e-f111-4dd4-914a-7704990ac58e@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|DB9PR04MB8347:EE_
x-ms-office365-filtering-correlation-id: 89b7e7c8-d1f3-414b-133f-08deedda43a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|38070700021|921020|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 d6RCkeFUNmHx9q0v9/SyPOZtIMm9cuklkfR4NnZxtgpG76Rc3XQAyShTZ91YLrDhFYeU21Fx+QW3sZK2gILXvktNQjp+qRiZWELttV1Y8PN3byHgkczBkdPOtFiDi252QkwmIp3rc/Szkle9JFRDfeLx0AMRdc0p0YwfZk3EfsHOdX92IxkRAbRiKfe5sm/Ra2ujWPfgzEzTm3ksfavKYKAsYjt7q/UAi9LzfV2kCkLkWJtgBabb9nADa1r5pv0n4s9BP3IFTxBPOcwajRsv/WG3lViSqTXhcdPlSVR+zhUDOQR9UNoyKP7JQDxTI9iPl0hjTtI/yf6kEpXwUtNI7jSq9U1qmWG2mVpeeQ/pKEgYygoEt4D+pmbvSSvhihVwieYCRN+AArwDrv2/NcfjjLziXdAC7U+9akrDJdSjQrZWZGyPuU8BzoGiEJBac/auPYeVFfRpCI4HewFCoRM5+WiszIx5rf8gWArppwJQhGxdROFTl2c3hjKURRA9c35qTp/I6ynG66UpID0YGIbDAhun9T3wwh0THgl0kj6BNlSw0Jtrkzll0xmGE22iXIWQQBEZux0lvR1x/0aV6MUzHZ0tBoC1m/xzoDeyRGClBTXwqjKNmbrNyoBADdhZhX/swGEzA3fHXVhYD8MIAF8OMPiRZlKBGshoF7PivN9+zhIo44XghiDSe7YY8WQtajv2JJf3dbtLvLrn7zo2foVKGs9HlJHBus1q2HtmW2HW4evFNv/ijDTl0GR/Nb/zzm9+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(38070700021)(921020)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDI4OXJhbHNkNEp2Vm9ITUNpdDdnb2UrdmphdW9PRkszNCsyV0g4TStVb3cr?=
 =?utf-8?B?dk8wK3NQd3UvK2xNU3plMzk4U1hiV3gwVnFBMUpxR3hiU2k0Zllhdms0YXhK?=
 =?utf-8?B?YWFYU0Z2eXA2K0JMSUxkcE4xQTZuRHRZdG5TbGJyQmE3NklGUm1CUmF1bDRa?=
 =?utf-8?B?TzhFL1VybllDbXFIVzJnRTNJU2xyQ2dya3ZWNi92VUlpV2hOMVVRL3ZJMzZD?=
 =?utf-8?B?U0tqZkJ1dVh5STVkQ3ZrMktjOWhiU3cvMXVkK2tYQWMyQmRobGY3WW8wRGY2?=
 =?utf-8?B?aGQ4UmZSNWFBVGVuYjlmNC84bXQyNThnVzNlY0VQLzBRbndQSUxWMFBmdW85?=
 =?utf-8?B?a0phc3lGbS9majlGVlYvSk1KdHlxdlJ1L0d5anBZa1lQdEtoMVBlbHlZa0dV?=
 =?utf-8?B?UHY5Q1B2S3cwY2kvYlNPcmViZ0x5aWxnQXZYNlpacUtqK2NXRE5heUhXUlBk?=
 =?utf-8?B?ZmJ4ZmhWNElKRG5tdnVoUDJQQUtaM0M2anZBQnFlSWtEVnhTZm9KbURONG5N?=
 =?utf-8?B?N29MeC8wZkFuV3ROTmo0eW1rVXpzM2g5bzlZdzhDUzUydFN1cW93b3E2aDNJ?=
 =?utf-8?B?b3FHWXVmVTNHRVhPcUdoTy94QXVYOVg0T01aUDdnU0NzbGhsSHU1MzFLSVpx?=
 =?utf-8?B?ME8zOVIyTGxkN0dPN3BvZG4zUnM4ZU1nV1RScER6QmtyeXZuTlBNa0xrS1ZD?=
 =?utf-8?B?S0JKMVV5djRiOER0a1dLOStSaE1OY0toNU5wazhuQTZ2WWFESSs1cUU0R3ZK?=
 =?utf-8?B?dlJHMnFOMUROR1VYbkRlQ2xZR3pkWUFMd1lCREIzNzRsM0wvRWZPV3dhUm03?=
 =?utf-8?B?ZVdvT3ZmZXBmbEZ5YlMzOUx0Umc0ZnY3a0FxbVRWMldlcWZuQkw2bGJFUCsy?=
 =?utf-8?B?dnJkQ2Z4WXdUY2pVM1NZbThwOTNKOGZqNWtlRGl3bnlFb2xRdzdPREdSMVNT?=
 =?utf-8?B?M0J6MlZmN0hURTJ4R1Nua0dxS0JnbGJVQ200QmFEVFp4aHJRNnlreXZsSnY0?=
 =?utf-8?B?VVBGbDZKcW9SVGxhRnVQd05NUE9hSEdTZTdLN0w0RWYwRlIzU2w2YXo4TXhs?=
 =?utf-8?B?cEdXTG9ldmhhd3BDcWFCamJ6SjBjN2hGNWJsV3VHbUNMc2VtVjBETWZpZFpY?=
 =?utf-8?B?WUtqVHZoREpFanIydFNkWGpYQklEM1ltZ0RyemhBZkhUM1h6aHN6MXd1UFNU?=
 =?utf-8?B?b2lxaXRLeUIxejBCV09WWGFlbVUvWGZQRzZzOGx6K1k0M2djQTV1TGVka3NV?=
 =?utf-8?B?cU9TejkrQ0JGeVMxc1lDMzlVb1hvY0xNQk4vbElaUmZyVk5NakRUd1ZZZmow?=
 =?utf-8?B?VEY1bGFKTlFSdThMN1Jwa0lKdEhJQWswUHA1OTZCbFh4b25POFFUdEl4Wlcz?=
 =?utf-8?B?cHErZmNCV05Ya3UvclMwdWdrSlg2ZStBcC9Rb29PK3pJNmd2QmRUd0JyYzlE?=
 =?utf-8?B?M21MTWtndU5lZCsxZ3RwVkJGcm9Gem1uaUoxdFEyMUs0cUR2ZlJNYnh3NXVa?=
 =?utf-8?B?aDd6V3ZEbkF3aEtNSytadzBJTk1yLzhvdm5YNzQwOWN0WlFyT0ZndkhYN1Ja?=
 =?utf-8?B?ME1DWHJIaXhUbUJvQWc5MmRXS0NwOVlEbWQzbFFTQmIyL3ZHbmg5b3ZYdjZD?=
 =?utf-8?B?aFc5VDJyUk9XOGY2MGRwRlEwckJRL2F6VzRNQmdHbDI1VytYTDhpK1pHS3Vx?=
 =?utf-8?B?UWZwN3BwTVBtSGxjaWE3V21HY2N1eEMvNkl6ZGdVeFlmYzQzL0x4eUNHMFFV?=
 =?utf-8?B?a3hJUGtQRUYyeXBIa0NYMllKNUhLL29uOEFzcXhmSHJ4N2sxL3pONUFmdVdz?=
 =?utf-8?B?cDNuM3RBTzFzbXJIK0RtQXRwN240aC85eFQ1aU1KYjR4Um5helBFWnNucmV3?=
 =?utf-8?B?VjFHdmN1amxacFVwR2ozVU1TYXZFWjJGc2J1OUJFeWV5a2puT2lyNGJDUktV?=
 =?utf-8?B?MC9mNzZoL3RaY3h5NlBqRmkycjVNRzZNdHFJUFZsdHpJekR4RnkxYXNibzBB?=
 =?utf-8?B?RUMyTkNkZklCL1dWQ0lnZEtPcytHNjd5NTl6cDNja2NYd3dKUm5LZUcvamJD?=
 =?utf-8?B?aWd1Zk9Ta2dBdTZsMUl3UmxaSXM3TmtSRUdjRVpsU0x1RFQ4Y0VOT3dnN0sy?=
 =?utf-8?B?cG9MZzZRUkU5NE0yV1cvdnNmaWJ5MzZrQlRhQXQ2UVc4Nkl5bTBCK1NkdzNa?=
 =?utf-8?B?OFppSEI3OHJ4cDloQWxmUDl6NS9iVXFpWitFYlpNSlFVVUNMMk05WjJjQjdV?=
 =?utf-8?B?WWhTbjZVdzVEcW9JOEpieXMwbDZ0djRPTWw2OUh4Y0dNSUVDOGRZMjd0NVNi?=
 =?utf-8?Q?FeWVSDZYlPo10H4OZZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b7e7c8-d1f3-414b-133f-08deedda43a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 01:31:22.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wh7A0PngS6HlSIJVBgroh2XpJ7jb9oamWHsPCPBYR1IE7Hym7ilOgz2LZKNNthfNf4ck5U6i8eebR2WeOZYq0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347

PiA+ICtpbnQgbmV0Y19nZXRfdHNfaW5mbyhzdHJ1Y3QgZHNhX3N3aXRjaCAqZHMsIGludCBwb3J0
LA0KPiA+ICsJCSAgICAgc3RydWN0IGtlcm5lbF9ldGh0b29sX3RzX2luZm8gKmluZm8pDQo+ID4g
K3sNCj4gPiArCXN0cnVjdCBuZXRjX3N3aXRjaCAqcHJpdiA9IGRzLT5wcml2Ow0KPiA+ICsNCj4g
PiArCWluZm8tPnNvX3RpbWVzdGFtcGluZyA9IFNPRl9USU1FU1RBTVBJTkdfVFhfU09GVFdBUkUg
fA0KPiA+ICsJCQkJU09GX1RJTUVTVEFNUElOR19SWF9TT0ZUV0FSRSB8DQo+ID4gKwkJCQlTT0Zf
VElNRVNUQU1QSU5HX1NPRlRXQVJFOw0KPiANCj4gU09GX1RJTUVTVEFNUElOR19SWF9TT0ZUV0FS
RSBhbmQgU09GX1RJTUVTVEFNUElOR19TT0ZUV0FSRQ0KPiBhcmUgYXZhaWxhYmxlDQo+IGJ5IGRl
ZmF1bHQsIG5vIG5lZWQgdG8gYWRkIHRoZW0uDQoNClllcywgeW91IGFyZSByaWdodCwgSSB3aWxs
IHJlbW92ZSB0aGVtLg0KDQo+IA0KPiB0aGUgY29kZSBkb2Vzbid0IGhhdmUgc2tiX3R4X3RpbWVz
dGFtcCgpIGNhbGxzLCBJIHdvbmRlciBob3cgaXMNCj4gU09GX1RJTUVTVEFNUElOR19UWF9TT0ZU
V0FSRSBpbXBsZW1lbnRlZD8NCg0KVGhlIHN3aXRjaCBhbmQgdGhlIGNvbmR1aXQgcG9ydCAoRU5F
VEMpIGFyZSBpbnRlZ3JhdGVkIGludG8gdGhlIE5FVEMgSVAsDQpzbyB0aGUgc3dpdGNoIGNhbiBv
bmx5IGNvbm5lY3QgdG8gdGhlIEVORVRDIE1BQy4gQW5kIHRoZSBFTkVUQyBkcml2ZXINCmNhbGxz
IHNrYl90eF90aW1lc3RhbXAoKSB1bmNvbmRpdGlvbmFsbHksIHNvIEkgdGhvdWdodA0KU09GX1RJ
TUVTVEFNUElOR19UWF9TT0ZUV0FSRSBjYW4gYmUgYWRkZWQuIEkgY2hlY2tlZCB0aGUgZXhpc3Rp
bmcNCkRTQSBkcml2ZXJzIGFuZCBmb3VuZCBubyBkcml2ZXJzIHNldCB0aGlzIGZsYWcsIG1heWJl
IEkgc2hvdWxkIHJlbW92ZSB0aGlzDQpmbGFnIGFzIHdlbGwuIFRoYW5rcy4NCg0KPiANCj4gPiAr
DQo+ID4gKwlpbmZvLT5waGNfaW5kZXggPSBuZXRjX2dldF9waGNfaW5kZXgocHJpdik7DQo+ID4g
KwlpZiAoaW5mby0+cGhjX2luZGV4IDwgMCkNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArDQo+ID4g
KwlpbmZvLT5zb190aW1lc3RhbXBpbmcgfD0gU09GX1RJTUVTVEFNUElOR19UWF9IQVJEV0FSRSB8
DQo+ID4gKwkJCQkgU09GX1RJTUVTVEFNUElOR19SWF9IQVJEV0FSRSB8DQo+ID4gKwkJCQkgU09G
X1RJTUVTVEFNUElOR19SQVdfSEFSRFdBUkU7DQo+ID4gKw0KPiA+ICsJaW5mby0+dHhfdHlwZXMg
PSBCSVQoSFdUU1RBTVBfVFhfT0ZGKSB8IEJJVChIV1RTVEFNUF9UWF9PTik7DQo+ID4gKw0KPiA+
ICsJaW5mby0+cnhfZmlsdGVycyA9IEJJVChIV1RTVEFNUF9GSUxURVJfTk9ORSkgfA0KPiA+ICsJ
CQkgICBCSVQoSFdUU1RBTVBfRklMVEVSX1BUUF9WMl9FVkVOVCkgfA0KPiA+ICsJCQkgICBCSVQo
SFdUU1RBTVBfRklMVEVSX1BUUF9WMl9MMl9FVkVOVCkgfA0KPiA+ICsJCQkgICBCSVQoSFdUU1RB
TVBfRklMVEVSX1BUUF9WMl9MNF9FVkVOVCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4g
K30NCj4gDQoNCg==

