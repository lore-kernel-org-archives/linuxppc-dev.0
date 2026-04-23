Return-Path: <linuxppc-dev+bounces-19989-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A0FFAD3F0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 03:12:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1LjV73v3z2ygh;
	Thu, 23 Apr 2026 13:11:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776913918;
	cv=pass; b=n7Zfgyz2NVkgTYZZ6cFu1AJHg4bOm1rSMf2IussSKZLFdsSPPSMJ0HsOGN8f9p6hoZOPEExgdaBUTucl7c2rpjeN5gRgrqZPSZKHTevpHPbJMv+ebZVkeQropVGckDTQetGJ430oqptmnBvWEdcPxibAP6If0WeQCfb0EGA5v6O1qQATjcziWsyLLJgDLqpACX2Hbi2VlnwPW9jFWySmgnZtNt8l6V4fFKaoHEwGMo0pXat2mxHjEzWrvJ1hn2Ux+3z+m5oDfWaUzz+JFLIc4LB3dUALkKGeqI3YPWRjhw4IFmLZsTDigvv2wcP2XBPWI5Lk5CUB324Z+1/rnyRD2Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776913918; c=relaxed/relaxed;
	bh=9sPVC6Ulgcau4llAZqfR2Sp/7r15bDPknWCHYF5nnRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XTN1pw1PFeHHwBjzPM4n/krCX3/j+MGIqFVUvRn9uy/i9hJy+lMNS+YNXSxnL7DAbeaQi6+fliPhOGvwOmXxQqp++FiHKB1F70o5VImCj7aXJSRJIYphQhLS8xZv44yJRVgB7d0iA4ndFSM5anGczAY9E9C/b0+D1FAmwNnbOi53ZIuYlpItXHQtvAzX3BIpWOxYUi7TiFv/Dmd0Y2NO/08Icinp2npWSSWu3HY9kRgK04nJbjsjllzEsiClxM2YeyyTW88bP7EGeioX2URZO5ofryAZ/Cvpk7xnbR8fBt4D4T0xbvtFv75GsfcR7bluge7/WjHehjrYGGlmLwS5ZA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=mIw7x8B1; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=mIw7x8B1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1LjT5KZvz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 13:11:57 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlxPlpeRUvPr1re1jGG12+BFKHngkKNCrF4rRIzUZsaiCSI2mxYTCm6IfOoYACCo2mv3utJCm6W3gX/XpdwBdhoQDjcO0+fVA7rJ8vRPpOARtgIp6atjowbiGZRuJDiE5TtXTtt1VbS5fJXmz3N3kRUEi0aVqBOx199gwI94hsBNlT/vRrmeuHqNUGUfmL+NhTT08jpDGWYDhPgnd00/dIZ8GAxg04jGXYZechgwXqqQGSRyOqb9vTeqim8KpoJs2ilteqz1Z1CdvHZVKvtGbgBKPIazb6wsoLx55hHgTraWny7Fwuz3ydSARcSNXWyjS5vlT3hASe6TmnvRsaKICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sPVC6Ulgcau4llAZqfR2Sp/7r15bDPknWCHYF5nnRQ=;
 b=c29wGfnp4FO5kKv2xLqHXjhVLHoWZJqmkFMBcXF8S/nxJIRp1LZnpwU/DZpWLB43+sim/+lOAxm8Xj53CwuGBWi/st5KTKPJtV/dmikZ9JIS2SmfpYIG7xmcgb3yeehxlEeX7ELVFnNs8Q31DDSiA6/sPeVOI80XCM0+e+JqRQ8LnHhOsLRePoigDJeVbjhdbjhrORiYqbM7ta4cI9ncc0/Cjo2JmC69lkeX90VA7pyRXwqgL1UN5aIBn3a9kMKIP+GkPTQiwe+acT55RQh78DbEh9dGXb3E3T7p8iGdFz9AZj41mF6NMkYEtZQ1vL3wVeiZwUWseYWX8VqcsC2eSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sPVC6Ulgcau4llAZqfR2Sp/7r15bDPknWCHYF5nnRQ=;
 b=mIw7x8B1/YOAsgaX8cdo9OekLOc7qGUY7uwjzkCzEoNEZAHfyzs9b4IeUdCLfc9yVkVLCUEPWkwjx8rEF50h3XBAzXPYXaaGo61HFflYcMdVZd53zvhclCzuDRhmAlEjy9pVC5z+0Xw238p5rXIxnngphHxOgcEOwvj9gB5r2gbxzBtzS0mI4uuINH/baAI6qfShM+qzWm3IhKYZLfjh6/RbV88+rBE9AZ2VVFhcHvqtzJkycWPK2tp0LdCSrzL0VvU8rlR8wy5GL6x9dH3gM6Q6UfA5Q1h3zc6yxNW6PqdahY82gi3o3I33KGxUPNbAI32Uyfo7kQYDoxDl7jEsaw==
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by DU2PR04MB8727.eurprd04.prod.outlook.com (2603:10a6:10:2de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 03:11:33 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9769.016; Thu, 23 Apr 2026
 03:11:33 +0000
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
Subject: RE: [PATCH v2 2/3] ASoC: soc-core: Add core support for ignoring
 suspend on selected DAPM widgets
Thread-Topic: [PATCH v2 2/3] ASoC: soc-core: Add core support for ignoring
 suspend on selected DAPM widgets
Thread-Index: AQHczLC+o20CnrdogkO3yBoGqHpAVbXjHXMAgAjk3IA=
Date: Thu, 23 Apr 2026 03:11:33 +0000
Message-ID:
 <AM9PR04MB83534D1A4B7EB5A7F6A9C9F9E32A2@AM9PR04MB8353.eurprd04.prod.outlook.com>
References: <20260415081942.4183108-1-chancel.liu@nxp.com>
 <20260415081942.4183108-3-chancel.liu@nxp.com>
 <aeIWLvMWKv6OmX4h@lizhi-Precision-Tower-5810>
In-Reply-To: <aeIWLvMWKv6OmX4h@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8353:EE_|DU2PR04MB8727:EE_
x-ms-office365-filtering-correlation-id: f3502653-4700-44e9-a71d-08dea0e605cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|18002099003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info:
 x2uqEIB78Y4epubf8QGiCG0tnC0FExtnr5y4dCwt/ss5YVmB4DNC+Eo1RKYU1GCtNdkQmUQT7uss80aXzNRnE/BOke8zbG3Vk1MMiLUcZxzNjTXqQIQNxV4XO49yFzS8fq/5gMOvwTmIqJuMTV4Wnb6zHHlSK95HEY4Q9AB9qwcQJV07Xo0vzvU39TD18tQZNPKsMDvwgejfPcPRLOtD42JbkDwa63uwxWj1fy8qu/UMHDTYMSliMNGYp4KuXkNiOdXWsHsglX8VU3Snbd+033c/oRejKfa1fOlmQYuWJVh8KkWrY42MG+sgc2Te3GAO9Wwf7MhhRPhnAz8EbNFOuuVdC/qkxZrZSvCrGxP7M5WSqe0a3mJj4SJmhoPjoDNg2rsvZnQQh4aOsdzoZRfEB+dp9ZBvv0mz8Aimaz8IofwbMd5urIoDGOElHaWQppYoSB5qssuJASM57fbcraFeKWTbqnKeoOXGCHK/SPO3zOSKrhpX3OyuZxoZquqIc7rgm3nVfB1kvlLdY9JWyjryUgfeRT5JYDnUMKxh/3luxWbfMOoM0T1scPs6lkGuDxICWmrwcxnRQORQtfNuCnq7r1DQvqqZyMhAn1v1trnDolknzDBSdo2UuWD/gjvZxonGS4EYMObTCIMItL6eAnB536l4z45w1DFjnk6TRdHGyLMUirvd2pKYCjxOAsBLlKl+wFFHh1Pd8+LTvVzHkaR28A+UylDOokGBPH4pRxuVO9ipgBukOW3dKl2FRSBEkfAAQHdyx9M9ebbnLei7jUF9Z1T/S94xd0orOn/22jXOiPg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(18002099003)(38070700021)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODhUV0p0Z0tWeFlDME9pZHRpb3hpMzZCS1MwWlBJVjJPRlB5OTRIYjFFVzJH?=
 =?utf-8?B?MURVZThTUkNaTDcxcVE5c2xnU3NIbnRqcWl1S3BqUXI5STRmN0FTVThiTFoz?=
 =?utf-8?B?RDNBM3ZhdDFSc1pFWjhXZ2FlQ01nbkdGVFdSTTRzOFlVVDd0WEp0aEdMd0Fn?=
 =?utf-8?B?SC94Y3ZsQlg1QmtHbWJkcWlmMmpMS3pubjhTcDk2eUV0R0twWGZWTjcxL2VU?=
 =?utf-8?B?WVNVRXBrT3NiTGJ1OFlZenhYb2NTNDdTQmg0eFVhZnBISG5pOFlZWFgwZzRu?=
 =?utf-8?B?QlVWWGZDK1llbnIrRjRPVDlERDQ4eDZwenkwUlZqT3ZoaG5acFd5Y290Zksr?=
 =?utf-8?B?Q1B0V0FuNmNTS0JySkxvSVc3YXdJNGpPVFVMdGp3QlVaTVdhY2NxMkc1TEpH?=
 =?utf-8?B?MWZmcHpQY1g4Mnp0QW5TM2xJT2hSdmRjTTMwek93Z3E0NFpsNkhuaWo3TTNo?=
 =?utf-8?B?V0hBR3ptOEEyNmdqTlRIMkc3L3lLSXdNYzgrU3hQWkdhazdnQkJzZ0oxK3py?=
 =?utf-8?B?MWZtcXdES3gzOFMyUENyOFo2MXJnc0o4eTlHN21yR3EreCtOZ29TTG5NSDVU?=
 =?utf-8?B?NlN3WGFWSS9lZVE1N0MraG1CTXpvZlhhL1Z5RFZEQmtOOGxXWUdUaU9VS1hL?=
 =?utf-8?B?Mi83eEVaV0V3aldTQnVxUm9BUjROdUlIcEFFeU9zeTV2RG1HcWk1Y1pWc0ha?=
 =?utf-8?B?NnRVeWJxU0YyMVdXZWVxTExZdmdCWUFMTHlpOURzcHFWa1ZURGFlWitDRXVw?=
 =?utf-8?B?WHJucGw0MHVSbVJhTkUzOTlSUEVxeUljVmJCK3RYWGZlemdFcVdQUkpaREJs?=
 =?utf-8?B?M2l0YlAvSmFqTEJsV1pGUkJyQ1VkTlhGZTgwekkxSysyUHpaTXZJUTMyMGFF?=
 =?utf-8?B?RkhlbHREdlVoMW1SUEx1VlBBZnZWRzNPV1p4ZWtiaHdQWjdnL1g4ZUNQbEIx?=
 =?utf-8?B?NDZ5TmZBWmh3RUYzZFhVeExGdWxQMDdRc242QTQrOXptRTV0K3V5NFltd2FW?=
 =?utf-8?B?SXZVZ3huMDRvSzFSNnFpblB0aDZBV0Z4REJPaExQRGdBUGp6a1h5VzJkTXdL?=
 =?utf-8?B?dGVHZFNBS0VhWkYwSkozOUNCKzdLS24rd0JtOElXSk5PNDNtdmZBNHJ1Q2Iy?=
 =?utf-8?B?dlpvTERQSDJHNDZTUng2N0dJUWRDTjRpTWJudkN2R0VVaVlxNi9pVTNETS81?=
 =?utf-8?B?c1BHSHNWQlpCU2QrSXVSRldPTG9tUnY4SHE3UW1KclZPQWFHWEhhZWdvb1hK?=
 =?utf-8?B?R2NYQ1RlZ0dRNDlNTjdueW0wR28vU0I3MGVwM1BueVhuYVR0VkpFMzhKSmJK?=
 =?utf-8?B?NWU5N0xNT2tuYnQxMVQ2R3FDODVHa3pqbFNndkRhYkR2UzNoVm1nT0JZRVpR?=
 =?utf-8?B?d1pDcVRsL2Y5d0IzMFRIKzcrc2ZVbzB3OFJyYkZaMDFPa3krYUFaK0p6VEY5?=
 =?utf-8?B?L2M4SEdKQUpXWWdsM095WUU0ZG5pTGgxUjlydnI3c2dXZ2pGMis1SUlvNUpk?=
 =?utf-8?B?M2tQMUxiOTZMd2EwN2VvY0xvVnNWUnU1c2NwUDNTYUpZaXc0T09XOGRvdFRC?=
 =?utf-8?B?b005VHpOa2tLTlR1N1NMV2VJQ3dCangzMXdGVWFyVy9RTUtmcW1nT2tFVTcy?=
 =?utf-8?B?VTRLMFE2cUh4U1hGT0ZCRGpldXZUUWdtcmZZRGFQOWFsbHFJeGlERng3TlFT?=
 =?utf-8?B?TDJqTXIrYUVOZlJCcjBETlBsUFhnd1VFNCtkV0R3b01XQTBzd2d0VldXcTJw?=
 =?utf-8?B?cjAxYi8wUW5JK1pkYUl0ZE1QcFd3dERXVllSTkVWZVJiLzdYK2QvemZQck1L?=
 =?utf-8?B?ZU5QQlRxSmFnMmRDSU9KVzEvUDZDZlc4L0dCTEtSZXRtRlhGdFdPdmFpby9O?=
 =?utf-8?B?OWpZSFNCbUlFVldwZ1l1Z292ZW95WDNDMTJnOHJtZG5XMXB5cmZ0VkRPOG5a?=
 =?utf-8?B?clVCZ0dTZU9VOHdJS1dOc3ovQmFiODlKNHJkSkZ4TG5sKzZVV0cxUW9ZWDJi?=
 =?utf-8?B?SVdiSEJKZXdzd2RVc21BcDgrZEdsb2E4RTNtcWdLb2djY095UFNWVlJqZFFi?=
 =?utf-8?B?SGJ4ck9hckRqK2g0cGlDWEN5VmJyb3lFUlo4V2g1a0JGLzZRamtZblIrcXJH?=
 =?utf-8?B?NDdNTXIyVzhTUm9rN05ZQUhOWHAzc055eUh3K0tDV3FXNXhqY2M2SStIVmNo?=
 =?utf-8?B?YlZITDdNT3FkaTdyYkZSZGJONkN6ZmVxK2VRcGlDa0pVbitIZHVJN3N2emFR?=
 =?utf-8?B?cFdrRllERGVEYi9mZHp5ZWduRU9xZHN4VDA5dkR3WlZzS3Zic3dZZnVxZTh5?=
 =?utf-8?Q?Vy1LqhQA/Id7doOI8H?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3502653-4700-44e9-a71d-08dea0e605cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 03:11:33.3135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /datRp3kJEum5PjRdRSY6nGkCPy3+12nC9sneG5EIQrqtpQmBRqODarWxrlEIlFc4DbgkaCsDC4uZeVJojcu+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8727

PiA+IFNvbWUgYXVkaW8gc3lzdGVtcyByZXF1aXJlIHNwZWNpZmljIERBUE0gd2lkZ2V0cyB0byBy
ZW1haW4gcG93ZXJlZA0KPiA+IGR1cmluZyBzeXN0ZW0gc3VzcGVuZC4gSW50cm9kdWNlIGEgZ2Vu
ZXJpYyBhbmQgcmV1c2FibGUgbWVjaGFuaXNtIGluDQo+ID4gdGhlIEFTb0MgY29yZSB0byBtYXJr
IHNlbGVjdGVkIERBUE0gd2lkZ2V0cyBhcyBpZ25vcmVfc3VzcGVuZC4NCj4gPg0KPiA+IFRoZSB1
bmlmaWVkIG1lY2hhbmlzbSBjb25zaXN0cyBvZiB0d28gcGFydHM6DQo+ID4gMS4gUGFyc2UgYW5k
IHN0b3JlIHRoZSBuYW1lIGxpc3Qgb2Ygd2lkZ2V0cyB0byBpZ25vcmUgc3VzcGVuZCBpbg0KPiA+
IHN0cnVjdCBzbmRfc29jX2NhcmQNCj4gPg0KPiA+IFRoZSBsaXN0IG9mIHdpZGdldHMgY2FuIGJl
IHByb3ZpZGVkIGVpdGhlciBieSB0aGUgbWFjaGluZSBkcml2ZXIgb3INCj4gPiBwYXJzZWQgZnJv
bSBEZXZpY2UgVHJlZS4gRGlmZmVyZW50IG1hY2hpbmVzIGhhdmUgZGlmZmVyZW50IHJvdXRpbmcg
YW5kDQo+ID4gcG93ZXIgcmVxdWlyZW1lbnRzLiBFYWNoIG1hY2hpbmUgY2FuIHNwZWNpZnkgaXRz
IG93biB3aWRnZXRzIHRvIGlnbm9yZQ0KPiA+IHN1c3BlbmQgdGhyb3VnaCBEVCBwcm9wZXJ0eS4g
SXQgZW5hYmxlcyBmbGV4aWJsZSBwb2xpY3kgd2l0aG91dCBoYXJkDQo+ID4gY29kZS4gQSBuZXcg
aGVscGVyLCBzbmRfc29jX29mX3BhcnNlX2lnbm9yZV9zdXNwZW5kX3dpZGdldHMoKSBpcyBhZGRl
ZA0KPiA+IGZvciB0aGlzIHB1cnBvc2UuDQo+ID4NCj4gPiAyLiBBcHBseSBpZ25vcmVfc3VzcGVu
ZCBmbGFncyBkdXJpbmcgc25kX3NvY19iaW5kX2NhcmQoKQ0KPiA+DQo+ID4gQWZ0ZXIgYWxsIGNv
bXBvbmVudHMgaGF2ZSBiZWVuIHByb2JlZCBhbmQgYWxsIERBUE0gd2lkZ2V0cyBoYXZlIGJlZW4N
Cj4gPiByZWdpc3RlcmVkLCBzbmRfc29jX2JpbmRfY2FyZCgpIHBlcmZvcm1zIGEgdW5pZmllZCBs
b29rdXAgb2YgdGhlDQo+ID4gY29uZmlndXJlZCB3aWRnZXQgbmFtZXMgYWNyb3NzIGFsbCBEQVBN
IGNvbnRleHRzIG9mIHRoZSBjYXJkIGFuZCBtYXJrcw0KPiA+IHRoZSBtYXRjaGluZyB3aWRnZXRz
IHdpdGggaWdub3JlX3N1c3BlbmQgPSAxLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hhbmNl
bCBMaXUgPGNoYW5jZWwubGl1QG54cC5jb20+DQo+ID4gLS0tDQo+IC4uLg0KPiA+IEBAIC0zMjk0
LDYgKzMyOTgsNDUgQEAgaW50IHNuZF9zb2Nfb2ZfcGFyc2VfYXV4X2RldnMoc3RydWN0DQo+ID4g
c25kX3NvY19jYXJkICpjYXJkLCBjb25zdCBjaGFyICpwcm9wbmFtZSkgIH0NCj4gPiBFWFBPUlRf
U1lNQk9MX0dQTChzbmRfc29jX29mX3BhcnNlX2F1eF9kZXZzKTsNCj4gPg0KPiA+ICtpbnQgc25k
X3NvY19vZl9wYXJzZV9pZ25vcmVfc3VzcGVuZF93aWRnZXRzKHN0cnVjdCBzbmRfc29jX2NhcmQg
KmNhcmQsDQo+ID4gKwkJCQkJICAgIGNvbnN0IGNoYXIgKnByb3BuYW1lKQ0KPiANCj4gcHJvcG5h
bWUgaXMgZml4ZWQgdmFsdWUgImlnbm9yZS1zdXNwZW5kLXdpZGdldHMi77yMbmVlZG4ndCB0aGlz
IGFndW1lbnQuDQo+IHlvdSBmdW5jaXRvbiBpbmNsdWRlICJpZ25vcmVfc3VzcGVuZF93aWRnZXRz
Iiwgc3VwcG9zZSBvbmx5IHBhcnNlIHByb3BlcnR5Lg0KPiBpZ25vcmVfc3VzcGVuZF93aWRnZXRz
DQo+IA0KPiBGcmFuaw0KDQpUaGUgbW90aXZhdGlvbiBmb3Iga2VlcGluZyB0aGUgcHJvcG5hbWUg
YXJndW1lbnQgaXMgdG8gYWxpZ24gd2l0aA0KZXhpc3Rpbmcgc25kX3NvY19vZl9wYXJzZV8qKCkg
aGVscGVyIHByb3RvdHlwZXMsIHdoaWNoIGFsd2F5cyB0YWtlDQooc3RydWN0IHNuZF9zb2NfY2Fy
ZCAqY2FyZCwgY29uc3QgY2hhciAqcHJvcG5hbWUpLg0KDQpJIGFncmVlIHRoYXQgaW4gdGhpcyBj
YXNlIHRoZSBwcm9wZXJ0eSBuYW1lIGlzIGZpeGVkIHRvDQoiaWdub3JlLXN1c3BlbmQtd2lkZ2V0
cyIuIFdlIGNhbiBzaW1wbGlmeSB0aGUgaGVscGVyIGJ5IHJlbW92aW5nIGl0IGlmDQpwcmVmZXJy
ZWQuDQoNClJlZ2FyZHMsIA0KQ2hhbmNlbCBMaXUNCg0K

