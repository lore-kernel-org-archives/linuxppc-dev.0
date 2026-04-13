Return-Path: <linuxppc-dev+bounces-19660-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0C4E93805
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 03:14:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvCDx6VJ6z2yqf;
	Mon, 13 Apr 2026 13:14:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776050065;
	cv=pass; b=Up0YwsmvJkpzz//NHiavJdJ5reUcb86I5g5Y9Xeiqb34LYZXCtkAeHVpXWI3dml3ljYs5uNpTj4gkhb74F+JABvZ4bq5cvXUJEzNG8jQ90SMfHwhT4qfrohp8m791h4wn8lWKsAZs4rx4kt2kYHIYx3pUWAk9g6hXx8cNvWwv1hhDP/kdi8xya09fTSeA4zq9VaLnEmcgzYuI9fYTksQA9PvXnOVAEi/ceRNaCBoNQ+WfHPpChimGUtHY81wVNzlV9rTLo6M4Ryt5MxXTtw104driz6rPl+8hc2Al1LIw7z0hM1oDXZjEO5Bt1Umf1JJmIct3leTV71DSfaqIAZscA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776050065; c=relaxed/relaxed;
	bh=edIQbSlHvtQiZRjB8K8JZ8dPeDXaBpKOUVXVEfHS9WY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BkPqC99IaN71lqpmvhoR3tmHhgOLNIu07bX5oSnV19+ObnhDN/TTcbQyzj2CxkbMR1xbs4jCttVyyaZFjTwjsaH971S5KVzIMct4eMQEonm3Qa5lN29BOdeAih6OEYKnw/tNnh129PDLakZjLjJJZoFB558u6JQKRMhbwxRWAQiZ5yztHnijReDrryMY0905MRaZkTKAIvinV1U2xgq6tTGOJmBT3nz7zyPe2J3zbDl1Aw8hh4gUAJck51Jb69LBb6dTZJsN2wuBanCKfk2/eIT6VbqFyQQnR//G+t42bSkce74RHbZDIxGrBrcu0qu5296TjLbHpjFMuronzEcIMA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Z6wtvLLt; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Z6wtvLLt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvCDv2391z2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 13:14:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgxa4F1lK/25hFt0ZQu5zJ19s0Aq0z64bxn+kQZEcVZKd11x74EPvM1pxzNjBDxoubXZ1O5/vCWDp8FECqPjhvl8lEWBj7wxdxMp44VPEAvdc4IHIi0r7T2x5N24rzAIVc1vgYpWEhcUbG/TJ/2Zwad8O5M5ncEFDTUPMgpSRfjW9U67zCNR3s1Zzv/ekyiyBkOCCrtWyHDTveUmh9JBl2X/C/EyGlvn/CMf/kwfJX8up+4Pk1b/zQvpDKxnmziVdMGb9K6pwZklr96iq8xDWGeMuatoff4fdwM8aUU9KeCsYdwka8fFMr5pFds5z3xIMHeVQkm1FTdjxikoJ66ccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edIQbSlHvtQiZRjB8K8JZ8dPeDXaBpKOUVXVEfHS9WY=;
 b=E+nnBCQ0oV4+FSaCoC0w3plqUIlkdaxOjXsMnOSCKCmC2+0fjTqnG693q9PoKWqW/RET7C3awoKNXSIMhZTuzAEioynfC0Iwmeo456qTEfNXIpnq9r8lYeUtXSC8xalthzbk79aSwrGznMslXDQVivjaCeExs4e7VQyHRjG/PRWZWHzq1ES43ctpgEn0x7X5zdfOE/a+WJeWAbNqbFA4RjPCXJyW25bCjjpzPWa536ydzMeD8uNo6h9BIHfzXzgj/eO9HZQknIvdi6k4t2gXfgn9pmi4cAZxIUJMg1FdJYMvoXilxhMyvQ0GBktHh0mp4y7L9TPMvsta3Gc6FtUeZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edIQbSlHvtQiZRjB8K8JZ8dPeDXaBpKOUVXVEfHS9WY=;
 b=Z6wtvLLtKSEtLuLrikjuz3ZXSeqEdbzkWWPUkAeWK55I/GCUoGIlW+tDbS9zAwZRBWG4Nx9H+H5dF0BV/2yS5TQlCGMxYN/lb3qxx/nlPG0hJ+yjGq4OVLyZfubMvcTCgWxsGZiRIFhrcvxO9mQooMIlBz52WKvMmBkG1FrmZAFZBMyKi8+Co/63sgrHwo9pQ26yAd7VrMj5DP0AV0XzKvg8pE4XP88bcCofaq3sYbl8m2jH7/M2V+kdvv8wnn/PqkSm1DYcu/jritViOd8Ol9PTDrvmaGJbZY5Kswd/Qb2R4RNtxG730xOfWGoJ+dcvo8/H61VJFJvwVyA0b3k8Dw==
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by GV1PR04MB10893.eurprd04.prod.outlook.com (2603:10a6:150:209::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.46; Mon, 13 Apr
 2026 03:13:51 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9769.016; Mon, 13 Apr 2026
 03:13:51 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: Mark Brown <broonie@kernel.org>
CC: "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>, "Xiubo.Lee@gmail.com"
	<Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>,
	"nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com"
	<tiwai@suse.com>, Frank Li <frank.li@nxp.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH] ASoC: imx-rpmsg: Fix ignore-suspend-widgets only
 applied to codec DAPM
Thread-Topic: Re: [PATCH] ASoC: imx-rpmsg: Fix ignore-suspend-widgets only
 applied to codec DAPM
Thread-Index: AQHcyvON1DuEVYrSukO3yvADglKxow==
Date: Mon, 13 Apr 2026 03:13:51 +0000
Message-ID:
 <AM9PR04MB83539BD1328151697DA85859E3242@AM9PR04MB8353.eurprd04.prod.outlook.com>
References: <20260411072439.1125664-1-chancel.liu@nxp.com>
 <adolKj26DFqZ-XTi@sirena.co.uk>
In-Reply-To: <adolKj26DFqZ-XTi@sirena.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8353:EE_|GV1PR04MB10893:EE_
x-ms-office365-filtering-correlation-id: 4d1cff2d-fdde-49b5-03bd-08de990ab018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 8TWX3lqrGTcf5GKHSoLcdTP+fGh0VB0C7ts/VZGimu6E0W2ZdbpW7UyDm7WT+4NjGUHvjyDWrUJY/1dSCONmUkYYh0XwDfbyO/nZ3/gazyTvA1YYRD43nGC4Ixa2Qu7aIUhf7bhJ7ff31i8hUL0KL22kVF2sjDprNE4/y/UaSW+OAhC3z9LSP7pKVg1hf6RAUj5hpuzryU3vxYEwoDW9On+9yug2hbPQdRAmmu/WpQAJYnqPL59rNkDM4W5lsUNeC0HLEaEN3jER6eUyeOss23OWDrW0gt6lD9ATwMYv501PImt49GNJ8MpTMAlUCkMphsTYMOIK3Pi2E9zF5oQsv0gtk6NHEk38ANuP8CFryoC9NKCs88z4KYnpystmenJEmI7dsrhdslt7OIxe16d/+plQS6MR2TS/qV8Ow7Q+kVJw3KaNjgXx0DgsLsuVZu5HBQpgxKN1WfTuvsAfV4Nv+9Dv16hW1HIzVbE/Sivaft3rKpC1endpbvKq2Xka+sDIF6GmDBljbNb/ohOvcIj7aPlGYHGT1bnnNLo9MxU2zSUuBX+ymU8W58TnrsD67iq/au4yLIho8NLL9Bdh7eCj/aG8J56qAhYKmBb2k4VsNbdtpXTARiKqjkqCa6qQw1S24bj6w5g+n5NgZEvLc3Fte6AIKRW+mz8vTjpi9ITGq3k/ucvTvyUzPMdjyBJbwPmjqmFGXtgzdDorBYHbCzHzNpHe5zszdDzFaLZwtGfa6T+mp9grJHho/GSlJvlFBYmhFiDlKUsgQ6ii5TvCE4rk8bJJovcudpimjMbU3ff2HcE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGNmaWdRNnUvOURMUHEwenZKUDBLM3JRK0ZYd1ZFQ2djcHFhRXIwWjFqKzJS?=
 =?utf-8?B?Q0FXekVsbnBhOE4wcUtBVlR6Vm42NThyR3FCOWN1dkl4V2hjS09ibnVsMWRL?=
 =?utf-8?B?R1NjWHVPcnFkRkZmeGs0cGpZd2llbWx2eDh1elZSMVAwZE0wRHQxdWRZN05S?=
 =?utf-8?B?elBaZDJLM0FsMkJVd0dSOGZGSjd6MWZhYzJNcmtoVEs2dzVvVjhiM3U1RDY5?=
 =?utf-8?B?V3k3eWJMVTNaRzdmeXZnaWpYNmhhY0owbS85ZGdlaS9QUHIwRm4zb3VoU1Vs?=
 =?utf-8?B?YzR0Y0NlTHZzU0prbXB5MGZxYTJIeTREdFRBYVBaZnUxRnhROTBMUmNkdldk?=
 =?utf-8?B?RUVCdU5ROUVLMVhzVDJMdFhjQUltWXYyUER2NGExRHFWUnliV29CY0pHQmVs?=
 =?utf-8?B?TDdRZnY3QndhMGNvUGVjT1FUSVB3eEVxYXM5TDJqUGNNVUNaZDJucFJWUzJQ?=
 =?utf-8?B?SlFMRUwxYTNjQ3o3V0prRm52ZnpuQ3NyOEVvcnVtbG54UWdlYUpZdUNjVkVm?=
 =?utf-8?B?Q1ZCQjgzS3Vxekl6KzBRaGl4NG1rZ0hQL3RWSEhFVlFycmlCN3FTVkZqOWw5?=
 =?utf-8?B?eFhua3hIRlFMRkw4R2JOdzUxOHZhK3ZBaXhsVnd1R2grMGtLc0NoYUgrdmNl?=
 =?utf-8?B?MkFEZFVUeGkrQ2U3TmJzQm5CNlZTNTh6SmFhTlJqUjVTcGRMS2N2MkdkWU5P?=
 =?utf-8?B?MGZQN2VoR1hyU0xBN05TMzdHek8wZkw5OTMrTVJSbER2Y2ZCS1E4aE9uT1hk?=
 =?utf-8?B?MnE1VU4wZ3dYYURRZ2prOVcxZGtaYk9Kd3ZsZHRteUtvZTJwMEJ5RXlrM3Qr?=
 =?utf-8?B?UWl1TTJNRERPQzVTN2FaSlRuaVJzUWc2UDlxK295amFoU2NINk9CbVhQV0N4?=
 =?utf-8?B?VUVONFNjQnlMODV6MzU3cVZ3RnpEc2szZnh6TS9vVHZRYmh5KzdpMVVoTHIr?=
 =?utf-8?B?Mjg5OVN5QXBZSWcrS29GMzNqSmJweHlaVW9wdzBSN3kxd2JRQ25obW13UW41?=
 =?utf-8?B?eFJXVXl0b3FvcWFiN1p0R0hZaHZqNGplU0grZlRnb05LMEJZOUVRa2NGQTMz?=
 =?utf-8?B?ZzVoV3llK3Vlam15dGZZUHFhdm5FN21TaFo4SkRzZDRsRmhsRWw0ZmZURjZx?=
 =?utf-8?B?eWk3OEJ4OFZ4K0J6ckx0WHEzODNOdUl5WHJxc1lKaEVZbnFxRXBKbjlmeTRz?=
 =?utf-8?B?aGNWbko3Y055ZGpXcHo1TUZ5dVhZbG1xSDA2SmRtSkszV3dmeXJpTmRMcUpT?=
 =?utf-8?B?RTdPZ002QTd4TzJIeG9iQjRwMDU4bVlxVnkyUy9hWWYwcXpYVk50ZDJSblk5?=
 =?utf-8?B?L1orUFFYZVVHNmJ0Y3RnVVliWUJHeGd3NmZ0WllaTS8yNlhUemFMQ1BLTTdz?=
 =?utf-8?B?TFhmSzU2c0VqRUdxR1cxME0wOGdZRTVMRjRtd0tXUU1lcHNkUHN6WDhocWZD?=
 =?utf-8?B?Y2lIaFB2Unk1dC9tdWVPa0QxejV6ZFlYcHoxREFkREFSUUJTUFB5K1NXRGhl?=
 =?utf-8?B?UzVkY1JtRUF1U1NsejBVV2VyY3RqcDBxS3p2MTJ5MERDQWMrVnB1SDAyaTMy?=
 =?utf-8?B?U2VITEVwdWJUdDUwZ1hMZFFMMW1lWEhCZG1ybVhIeHd3eWdYUy9YeElHR1VU?=
 =?utf-8?B?Z0VSbGFGWHFudTFNenoxYTZhNHhmZEE1cDdRd2k4a0RmZWNDWGkzWVFFcVFI?=
 =?utf-8?B?dzBSSjJvZmdsMnZEYmpNS1N4V1pBOXRJZ1ZvME5FY2xxbUx5dHY1R1p4am94?=
 =?utf-8?B?ZEZnWUVCM01KT2dlVmNPREpEM2NIV1BaanRNRUhybjk4S0xkNSswT2hOMGVM?=
 =?utf-8?B?Q1dka3JGOEZiVkxTYXFXa2NHOXZZLzBhSzhHZGFJRjE0SjRtcVFXYTZORXNr?=
 =?utf-8?B?OTNHMnpNR0wwWW1hOEMrVHk5YkhvMmRNNVVBaFZzTGlTcmR6b2UxOE03K2Uw?=
 =?utf-8?B?NVk2Y2Jnam1QZzBPRmliSkxOa0o2RGdmNXAyNUdOMmZEQzc2a2ExVmZ3QzJv?=
 =?utf-8?B?RUhvZzRFdDE4R0hqTG5uMHdkUkgrd1d4Mkk4TStKeEVaS0c1d01aVjdkYzJj?=
 =?utf-8?B?TnlUaW5tczBsOGJhL3VwcmthY21BR0JNRFI1RGQ3T3FIMXZJcE5MdlpFMzFj?=
 =?utf-8?B?NWtZNnYwTlRkOWdsQ3BJZ2pQYXdlZHlMdVpPYjNwUnU4Ylp3eitUeFdudVlZ?=
 =?utf-8?B?NHIrQ2NRUmo0bDdYd1k2cFJiSUM3UUpUVlBya3RTV29KSnhpRjUvVlJWek5j?=
 =?utf-8?B?T1RMK1ZBcG9JcEtYTTdDYlFLdlhyRU50SUtRbk1XMUlpQjVRMmEwR3hhczdR?=
 =?utf-8?Q?xkrgVQDtQMwy9vMK3b?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1cff2d-fdde-49b5-03bd-08de990ab018
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 03:13:51.6189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAlH192lLYWT1tRVR6JLniicX+W3K24UPbLC1MREi0bAIHM5brA1c2Pikx0qH7RG1sACXI/yh3+OQVFWwTSF+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10893

SGkgTWFyaywNCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IGFuZCBmZWVkYmFjay4NCg0KPiA+
IEN1cnJlbnRseSB0aGUgcHJvcGVydHkgImlnbm9yZS1zdXNwZW5kLXdpZGdldHMiIGFyZSBhcHBs
aWVkIG9ubHkgdG8gdGhlDQo+ID4gY29kZWMncyBEQVBNIGNvbnRleHQuIEhvd2V2ZXIsIHNvbWUg
d2lkZ2V0cyBsaXN0ZWQgaW4gdGhlIHByb3BlcnR5DQo+ID4gKGUuZy4gIkhlYWRwaG9uZSBKYWNr
IikgYmVsb25nIHRvIGNhcmQgb3IgQ1BVIERBSSBEQVBNIGNvbnRleHQuDQo+IA0KPiA+IEV4dGVu
ZCB0aGUgaGFuZGxpbmcgc28gdGhhdCB3aWRnZXRzIHdoaWNoIGFyZSBtYXJrZWQgaWdub3Jpbmcg
c3VzcGVuZA0KPiA+IGFyZSBsb29rZWQgdXAgYWNyb3NzIGFsbCB3aWRnZXRzIGluIHRoZSBjYXJk
Lg0KPiANCj4gPiAtLS0gYS9zb3VuZC9zb2MvZnNsL2lteC1ycG1zZy5jDQo+ID4gKysrIGIvc291
bmQvc29jL2ZzbC9pbXgtcnBtc2cuYw0KPiANCj4gPiArCQludW1fd2lkZ2V0cyA9IG9mX3Byb3Bl
cnR5X2NvdW50X3N0cmluZ3MoZGF0YS0+Y2FyZC5kZXYtDQo+ID5vZl9ub2RlLA0KPiA+ICsJCQkJ
CQkJImlnbm9yZS1zdXNwZW5kLQ0KPiB3aWRnZXRzIik7DQo+IA0KPiBEb24ndCB3ZSBnZXQgYW4g
ZXJyb3IgY29kZSBiYWNrIGlmIHRoZSBwcm9wZXJ0eSBkb2Vzbid0IGV4aXN0IGF0IGFsbD8NCj4g
DQoNCkl0J3MgYSBtaXN0YWtlIGhlcmUuIEkgd2lsbCBmaXggaXQuDQoNCj4gPiArCQlmb3JfZWFj
aF9jYXJkX3dpZGdldHMoY2FyZCwgdykgew0KPiA+ICsJCQlmb3IgKGkgPSAwOyBpIDwgbnVtX3dp
ZGdldHM7IGkrKykgew0KPiA+ICsJCQkJb2ZfcHJvcGVydHlfcmVhZF9zdHJpbmdfaW5kZXgoZGF0
YS0NCj4gPmNhcmQuZGV2LT5vZl9ub2RlLA0KPiA+ICsJCQkJCQkJICAgICAgImlnbm9yZS1zdXNw
ZW5kLQ0KPiB3aWRnZXRzIiwNCj4gPiArCQkJCQkJCSAgICAgIGksICZ3aWRnZXRzKTsNCj4gPiAr
CQkJCWlmICghc3RyY21wKHctPm5hbWUsIHdpZGdldHMpKSB7DQo+ID4gKwkJCQkJcmV0ID0NCj4g
c25kX3NvY19kYXBtX2lnbm9yZV9zdXNwZW5kKHctPmRhcG0sIHdpZGdldHMpOw0KPiA+ICsJCQkJ
CWlmIChyZXQpIHsNCj4gPiArCQkJCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZmluZA0KPiBp
Z25vcmUgc3VzcGVuZCB3aWRnZXRzXG4iKTsNCj4gPiArCQkJCQkJcmV0dXJuIHJldDsNCj4gPiAr
CQkJCQl9DQo+ID4gKwkJCQl9DQo+ID4gKwkJCX0NCj4gPiArCQl9DQo+IA0KPiBUaGlzIHNlZW1z
IGxpa2UgdGhlIHdyb25nIGxldmVsIHRvIGltcGxlbWVudCB0aGlzIHNlYXJjaCwgaXQgc2hvdWxk
IGJlDQo+IGluIHRoZSBjb3JlLiAgSSdtIGFsc28gbm90IHNlZWluZyBhbnkgcHJlZml4IGhhbmRs
aW5nLCB0aGUgd2lkZ2V0IG5hbWUNCj4gbWlnaHQndmUgYmVlbiBwcmVmaXhlZCBhdCBydW50aW1l
Lg0KDQpUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0LiBJIHJlYWxseSBhcHByZWNpYXRlIHlv
dXIgc3VnZ2VzdGlvbiB0bw0KbW92ZSB0aGlzIGZ1bmN0aW9uYWxpdHkgaW50byBjb3JlLWxldmVs
LiBTZXZlcmFsIG1hY2hpbmUgZHJpdmVycyBjb3VsZA0KYmVuZWZpdCBpZiB0aGVyZSdzIGFuIHVu
aWZpZWQgaWdub3Jl4oCRc3VzcGVuZCBtZWNoYW5pc20uDQoNCkkgaGF2ZSBhbiBpZGVhIHRvIG1h
a2UgaXQgc3VwcG9ydCBhIGdlbmVyaWMgYW5kIHJldXNhYmxlIG1lY2hhbmlzbSBpbg0KdGhlIGNv
cmUgcmF0aGVyIHRoYW4gc29tZXRoaW5nIGVhY2ggbWFjaGluZSBkcml2ZXIgaGFzIHRvIHJl4oCR
aW1wbGVtZW50Lg0KVGhlIGRlc2lnbiBmb2xsb3dzIGEgc2ltcGxlIHN0cnVjdHVyZToNCg0KMS4g
UGFyc2UgYW5kIHN0b3JlIHRoZSBuYW1lIG9mIHdpZGdldHMgdG8gaWdub3JlIHN1c3BlbmQgaW4g
DQpzdHJ1Y3Qgc25kX3NvY19jYXJkDQoNClRoZSBuYW1lIGxpc3Qgb2Ygd2lkZ2V0cyB0byBpZ25v
cmUgc3VzcGVuZCBjYW4gY29tZSBlaXRoZXIgZnJvbSBEVCBvcg0KZnJvbSB0aGUgbWFjaGluZSBk
cml2ZXIuIERpZmZlcmVudCBib2FyZHMvbWFjaGluZXMgaGF2ZSBkaWZmZXJlbnQNCnJvdXRpbmcg
YW5kIHBvd2VyIHJlcXVpcmVtZW50cy4gU28gYWxsb3dpbmcgRFQgdG8gc3BlY2lmeQ0KImlnbm9y
ZS1zdXNwZW5kLXdpZGdldHMiIGlzIGltcG9ydGFudC4gSXQgZW5hYmxlcyBlYWNoIGRldmljZSB0
byBkZWZpbmUNCml0cyBvd24gcG9saWN5IHJhdGhlciB0aGFuIGZvcmNpbmcgaGFyZOKAkWNvZGVk
IHJ1bGVzLiBUbyBzdXBwb3J0IHRoaXMsIGENCmhlbHBlciBzdWNoIGFzIHNuZF9zb2Nfb2ZfcGFy
c2VfaWdub3JlX3N1c3BlbmRfd2lkZ2V0cygpIGNhbiBiZSBkZWZpbmVkDQppbiBjb3JlIGFuZCBw
cm92aWRlZC4NCg0KMi4gQXBwbHkgaWdub3JlX3N1c3BlbmQgZmxhZ3MgZHVyaW5nIHNuZF9zb2Nf
YmluZF9jYXJkKCkNCg0KQWZ0ZXIgYWxsIGNvbXBvbmVudHMgaGF2ZSBiZWVuIHByb2JlZCBhbmQg
YWxsIERBUE0gd2lkZ2V0cyBhcmUNCnJlZ2lzdGVyZWQgaW4gc25kX3NvY19iaW5kX2NhcmQoKSwg
cGVyZm9ybSBhIHVuaWZpZWQgc2VhcmNoIHRocm91Z2gNCnRoZSBjYXJk4oCZcyB3aWRnZXQgbGlz
dCBhbmQgbWFyayBtYXRjaGluZyB3aWRnZXRzIHdpdGgNCmlnbm9yZV9zdXNwZW5kID0gMS4gQW55
IHJ1bnRpbWUgcHJlZml4aW5nIGFwcGxpZWQgZHVyaW5nIHdpZGdldA0KY3JlYXRpb24gc2hvdWxk
IGJlIGhhbmRsZWQgd2VsbCBieSB0aGUgbG9va3VwLg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYg
dGhlIGFwcHJvYWNoIG1ha2VzIHNlbnNlIG9yIGlmIHRoZXJlIGFyZSBhbnkNCmNvbmNlcm5zIEkg
c2hvdWxkIGFkZHJlc3MgYmVmb3JlIHBvc3RpbmcgdGhlIG5leHQgcmV2aXNpb24uDQoNClJlZ2Fy
ZHMsIA0KQ2hhbmNlbCBMaXUNCg==

