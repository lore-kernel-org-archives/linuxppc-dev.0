Return-Path: <linuxppc-dev+bounces-23794-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297DDC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 09:34:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwCc45K2cz2xKh;
	Wed, 08 Jul 2026 19:34:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783503284;
	cv=pass; b=gC2atLZYfyl5wkbWR7ra2khpNtZz11F5d4LymIiqvMId2M86N5A3Vp028OY5kJSxlUpASfFgfgvuGOW9nF7LpKRwnB5rCkckBW+Ua+/DN/3GWLNYByXDhciPR+xMHP0Sf3ALseuDw4DYwM7B02kWZuk9dmk3kqopZ8Izqn84dxJhd2qK4YX0BJytfdZQwt7cqZCBwZygL2VeBES5f6P9n14CiWBnI981OM6enr9fAkK/p0z5UNvVJXneYg9GPNsyjul935G1vd/UgdRiztYoONh+279hi1emDM33VA+GJ2RRG9F74D19kz+h1lLDtATFrtnRuY5XvLyBLlgAbBIa4A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783503284; c=relaxed/relaxed;
	bh=54WDgqe3ae36LpZZte03DrenYsmy6+tu4F/ifEpF6To=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TzOE3Kpc8LF8Uv7NAD78soxsow8NFUWs7KR6ASm1tcOY6Hobs3EfhmHKCULqC6EaViobdu2DOxa7Oo36EBVVGZJwCKyiBg9isB3HkCD72b5zKOz0f3XG552NGxXEsLOe3eUBDz9UG5GNVYTTHJjDHcmUxDIGefuCtahfMPObW8XxmW0Csl7X+vCaUPBG31cMcL0r4CqL+Nr9BOv0nF1Zgs42Fu2YeuZ6t50m/hS2NXBatijc4BWiWoCTE/6TJXvfqYPg+IiiRP+tAyNpbf/FPNu8sXd22Qxfl27zXo3GNuULePs6qdFUM/JndyfDgDKhGvnNSf+viZ9VJpsAbudeOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Shn1Isj1; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Shn1Isj1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=chancel.liu@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwCc23tRHz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 19:34:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E29WsWVzaseIGDmRnBwtCqvWbVKt378TCT8ILFOWhfP/JERA2S2636x3AGCZxbVXomGSurd+NAg8GBUknFlreJ4Av/sQGSh/SQurDkbFiHC0G3Y8U8WN+sQIUkfxCx38eWcGOZflPpZhNh6XL+ALJKYCHfaxWo5iqpg3n1McOBF9cMlHijISPJ0pjZzIMut+VqhFWaLxddtLTQcs9g1J4k6vKKWfbsmbVG4SPUUGhno9P8L1cdSBq9HZDhJ+ckz+p0RL9/mcSUMftxWMgIflmhqC6vPa2KnuRi95/oLPfot9Hk2DBAksUNDM9qr0AoE+eB+6JFBGNzavXyP832BtLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54WDgqe3ae36LpZZte03DrenYsmy6+tu4F/ifEpF6To=;
 b=ts/2OX/eoE3cnKsv+b0yLe1ajN6vUpcYN06Wr1qn3JjoVQpgks1Fwqd18tjbQRKJliGOHj+P4EJ6dIaN+ouhMHuycjcl8uufsBYJUEb/LAN9b35mElKCwJdDYjD0vJR20V4015AGWIbda+RGh6j+kONaoOH4f0fHPRwBEam2awBEe1VPedd5VbuSsII3ff90vRrqA9C11xYV5nPw5C2eKWFhqrqQ4MX7Wok0cCu6Mp4Q61yws98jYW/X47+XdzSMlUyXNt+xtV/ENI9bc5qfFqaS8vhajst5npXq/A1DNYYRT6B03WwPAXvIxPKjrhdVElHSeTEs9Rl55lcoGotSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54WDgqe3ae36LpZZte03DrenYsmy6+tu4F/ifEpF6To=;
 b=Shn1Isj1nzkpANNz0LOYdUUZRclOEYCjSdjU/AcC+yaIdAg3zqTYxBK6nnm7JwFEXyzMpfPXnfbMhmh3+8uZp5ugCoEsHIId0/erEBQy+0ICs1csX5Eahmmqvlh5vwUTjZFd5isAXv+9NOSUQY/k2iZaX+Ie0bS0Qy5VidCFQ8PkQ0VuGnE9xS2UvJnuC18guGy7ds2ZlzZSkmcUxFK5L2y6TKlTR6L8qcn47cfCvUTjjL/mvSMcBXGr4Ne6liKvnyu373LK/FVIaUfuPTr2biPSZBn9CPrwAsgmVunOvVNqr51qo1FeAgJp/FOk0f29cpG6QY0CjldIemCt7Y3Ysw==
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by DB5PR04MB12178.eurprd04.prod.outlook.com (2603:10a6:10:647::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 09:34:17 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 09:34:17 +0000
From: "Chancel Liu (OSS)" <chancel.liu@oss.nxp.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, "Chancel Liu (OSS)"
	<chancel.liu@oss.nxp.com>
CC: "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com"
	<festevam@gmail.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com"
	<tiwai@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject: RE: [PATCH] ASoC: fsl_sai: Fix spurious BCLK on resume by clearing
 BYP
Thread-Topic: [PATCH] ASoC: fsl_sai: Fix spurious BCLK on resume by clearing
 BYP
Thread-Index: AQHdDe0qWyt8EtEa1EKdhZKtqerxarZjJNuAgAA4GlA=
Date: Wed, 8 Jul 2026 09:34:17 +0000
Message-ID:
 <AM9PR04MB8353C60393B0A756B4C78D30E3FF2@AM9PR04MB8353.eurprd04.prod.outlook.com>
References: <20260707084648.475743-1-chancel.liu@oss.nxp.com>
 <CAA+D8AOoO98Zi2+GP4He2zhSLaM=aKZC5F0PBu70QTFGJnp2Pw@mail.gmail.com>
In-Reply-To:
 <CAA+D8AOoO98Zi2+GP4He2zhSLaM=aKZC5F0PBu70QTFGJnp2Pw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8353:EE_|DB5PR04MB12178:EE_
x-ms-office365-filtering-correlation-id: 6c95f919-1f0f-49af-c87f-08dedcd414da
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|23010399003|7416014|38070700021|18002099003|56012099006|11063799006|5023799004|4143699003|3023799007|22082099003;
x-microsoft-antispam-message-info:
 av97VlxLGLiWtp1soC23pLbUiGFWKWfV+j41iwMoiNOXS8n+dS7QzpJti6DQkv3Lt0SG0G79k0/ZdJbE81oNMv1iA1x6dsdWuFjBLWRrUE5tN7AiHWtHsDWdvAE+6ZLvYAUCTkQHwccSQxPHxHIm7zDw0nC794tBn/dhYGeLxx/j8xpFf+QXAhf03LM8jFYPcvqB0xe6e8qOOdMnHn3jprS5X0pa/tssqGI4aySn/GvCMR3b9ATpHHdAGknsGMA66xKNzouTiUAEWhB50DV3sf19hmfSWKtBtJSnYdC6GGiw22OCc4vdvNOnmInisnrpbeSLo+7oBG+ewpvkcJojH9EwntCBJF8dNRhs9Pr5StRbPYbGr8u8LOsLYdXiiqMssoY3dwP4Qm7FwblfWE2VUkjUBnYpBea8yE6dkp91LBtp1mONzHRhZIAXGZ6PMSIxoY24rkRZVuj4wkTGxYHD4rZ9CT1INN/vWAvgRsv9OmQnREMK6s2ITQRkr8WXtpU71//zG5QdOetjiRq9fSEKr20ThN5mg723h2WroHbOl9xuqVyVjUB1VxBlHHQdmJjVvFfUrPXpsnPZ4R8yvz/WTmYQoW03B2TxwgJTjOF1yq/Gd7gNjgp5zL4tYf5wWSpac1C4/Gc59ZQ8jHesorxLqzhYOucmw+DMzMHcRNj2VDGgYMa28sDWwvvw6HDgNo2aw7wcm/XVpICOOE4wk4rVAx2TUqbq+05x0rEOAhOAHLQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(23010399003)(7416014)(38070700021)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RzRIdmlJcDJGMVRtVlloRkVFc3BweXJkaGtmUjBFNkQxSldzbFZDbTcvUmlS?=
 =?utf-8?B?bmRCSGhTY1NpdHZlSzRQS1V3REN0d3F5RUZpK2U1MVF3MGI1VWQ2Vkw4MXFR?=
 =?utf-8?B?R2VXU1ZyS2t2aGZ2Ly9GL0thaVg3VjlQV0Y5WloyOC8wbnRVSGFnaHlaeXZC?=
 =?utf-8?B?clJjaWtDNm5kNUxqOThDTnlRSkQ5cUJQS3ZSMStnVC9lUy9zMHZYMkkvenJY?=
 =?utf-8?B?NEwveDVEaUJWeUM0UmpTS2xYQ2xHOGZycTlmM1ZZNlVjbitvT01VWWkzeW5W?=
 =?utf-8?B?NURMa0lDd3VrMmFUL2VONUlJS3UzbWltR2tVd2RBNW54YXBhUnhTZmFiSHVq?=
 =?utf-8?B?ZEx6UnBkWFpVN1lGSUJ4dDI2NDFscHZqZ2djakJXNVc3L2dMK2NWaXVjeEVm?=
 =?utf-8?B?LzUrbkh4d0V4OEtFN3JTcjE4UjdaczNDS3paQy9ZcVJkbHRwTkFBbDV0cEpn?=
 =?utf-8?B?ZmRUTXhQUWZKc2huUVhGdGxXeERkemprODNrOTlqRGxLNzg2cnEranQ0cVZW?=
 =?utf-8?B?Sng2QWNReGNud1B3RDdqVFkyVlhWSktCcEJVeXRtS1JLcWNBY0grL2NOc1pU?=
 =?utf-8?B?bG5KejZ3M2swZk1wODdTRVlCbXdwUjBkSnc2UytwNVlsbXhaTlFaRlBJK3dG?=
 =?utf-8?B?VFYzNXdDc1pLQWUwWFQvNnJnQ2ZueXA2RmpSL0hqM2Uyb0c0a080QTI0YitQ?=
 =?utf-8?B?L2lPSkQvcG16eFlKdGpRSkxlUGNrQm9MaW5DbmJhUG1TUUdoZU5Xcmo4Yndu?=
 =?utf-8?B?QitBdFpWWjlSSUV1S2pObGF4d0RJREhHSlhVY1Jxc25Rd01pazBsampWeFY1?=
 =?utf-8?B?MVREZ0liYjl3djUrS2VEZXRVNzFtMm4zeWRFYVBFMVd0UmozanhSSDdiNlNw?=
 =?utf-8?B?ZFRRaXpHODNybFhxeWpaWWp0SnpTZGZXdzRJOHJyaWJ5VTRVeGl3UUY5VXQ2?=
 =?utf-8?B?cyt1QVJwOFJMSXdYNVpob3FScDlWVnZmZ2czQW5iVWZwL09wRDBUWi82NW5U?=
 =?utf-8?B?Smd6UVU2TlRMMndpK3ppOEgyUUFsVnp4Uk5VN3Zaa3RoYVAzYjBPK0VwaEI5?=
 =?utf-8?B?VmlvNXJZalpGODkxZ2ZQTTVyM0QwR3ZYK01PV0VUS2F4VHJyWXdjbWV0ME4x?=
 =?utf-8?B?NnhzNmh5UGp4S0tMTnh5cUNwd1pZRisycmRlZHdlQmlGWDl3MTdUT2ZLdkRm?=
 =?utf-8?B?bkIxRGdEMlArYytaNkZTWWJ3TjgzbTRkNjI4SzRiR2xLZGRXZHRGV3VXaUtS?=
 =?utf-8?B?aDlsTDkrWDZaTHNaMUJMamRDVmREcmg2UGsrTGdEQ3Jlbk1LZW1XNGhob0lu?=
 =?utf-8?B?NGNCOEFiSk1WVUQ5QlZTY1RxOFN6ZTg2QS9qdDNKMFdWL0dCQ0s0a2sxMDN0?=
 =?utf-8?B?cGVoZ3ZzYzBOVWF4V1lSaHlDSElZSVB4ZUV5MDBEdkxwNVM2M0c0Y3JKT3pR?=
 =?utf-8?B?S0VTM1FkTkh1VThZcVFMREp4NzcyZEV4a2dHeGk1cFlnK3FzS2dWRStmRXhB?=
 =?utf-8?B?a3lWcnpTYmZhc0hkMHJaYnYxczNpZzNmVVRFRkN4L25nQXR0c0QreEZmV0FP?=
 =?utf-8?B?amx0dUNaVTZ0TDZUalFIQVJtZmltYXF1MzNmQ1IzeEdpNmdoM09iMXMwVk9y?=
 =?utf-8?B?ZXF0MEx5WjdHeER6Wms4UVE2eXd4VHV2bk4rc3R0RjhZc2dPUnNoeTcwN3Z6?=
 =?utf-8?B?RlBPWEQraDlvUWVRZHFZSGJqMVZNaklmMWJmbytpTVlxSHAxejhvUCtaenBK?=
 =?utf-8?B?MFdZd1ZMV3o1UjdqSjd5bXNiZzQwNGtrcW83VnJPZ2hxSGNOaEg4SW5hOTh3?=
 =?utf-8?B?RUl1TlVvNklQZmNVMnVTc3ZhZlF4M2xmaHNwaDh6WVRCU3RlV3ptR2hwMVdZ?=
 =?utf-8?B?enVmRGNBTGtMMXBlZFRLNVZQTys0amlhKzlZSno5OUhSSGpMNGV3UGQvNm0v?=
 =?utf-8?B?a0orai91SjdmT0VIVmMycVBaNXFwR1l1NEpyTUhCdXp2eUtNOWd3cVIrWjZr?=
 =?utf-8?B?eDVJOWZTVHJGbEZRaVk3M2xRMHZoMGpPZFNrclhwNmlnRWlRcldCd1dEVDVL?=
 =?utf-8?B?V3Y3YnVTemE0eWo2cVlZVjhZUlJneTlBTC9HajhrMDRXdWV2aEF1VXVjKzIx?=
 =?utf-8?B?dXNvaVFjZ1BldU1ianZWRlplZzdXVlRtdGxoSXRWQVdZV1FGdGszNlJpSE9p?=
 =?utf-8?B?YTVoeEhyS09FWjV6dFU5NkJlQ0hVb3lCWENVSVdwanBvZlR6WmZodStCbHdX?=
 =?utf-8?B?YWJzUnpjenlROHZKQjNCVjZOU01DUE1WVStmcFErQW82NWVNZmlDVDJqK3l2?=
 =?utf-8?B?TWpvSzFOdDdqQjdaYXJ6eDllcGJIZVJLVy80T3pCaXhrK3pCbEo5dz09?=
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
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c95f919-1f0f-49af-c87f-08dedcd414da
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:34:17.4151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x45nmRn481OpDz3Umno0ahqjUd73vUm0GZQnAnHWiVQa6cTDATeHPlLbnPJ6G9sPU2HES2ea1RTK1TRpt++Cwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB12178

PiA+IEZyb206IENoYW5jZWwgTGl1IDxjaGFuY2VsLmxpdUBueHAuY29tPg0KPiA+DQo+ID4gV2hl
biB0aGUgQkNMSyBkaXZpZGVyIHJhdGlvIGlzIDE6MSwgZnNsX3NhaV9zZXRfYmNsaygpIGVuYWJs
ZXMgYnlwYXNzDQo+ID4gbW9kZSBieSBzZXR0aW5nIEJZUCwgYnV0IG5ldmVyIGNsZWFycyB0aGUg
Yml0LiBUaGUgQllQPTEgdmFsdWUgcmVtYWlucw0KPiA+IGluIHRoZSByZWdjYWNoZSwgYW5kIGlz
IHJlc3RvcmVkIGJ5IHJlZ2NhY2hlX3N5bmMoKSBvbiB0aGUgbmV4dA0KPiA+IHJ1bnRpbWUgcmVz
dW1lLg0KPiA+DQo+ID4gU2luY2UgQllQPTEgY29tYmluZWQgd2l0aCBCQ0Q9MSBpbW1lZGlhdGVs
eSBvdXRwdXRzIHRoZSB1bmdhdGVkIE1DTEsNCj4gPiBhcyBCQ0xLIHdpdGhvdXQgd2FpdGluZyBm
b3IgQkNFL1RFL1JFIHRvIGJlIGVuYWJsZWQsIHRoZSBjbG9jayBpcw0KPiA+IGRyaXZlbiBwcmVt
YXR1cmVseSBiZWZvcmUgdGhlIHN0cmVhbSBpcyBmdWxseSBjb25maWd1cmVkLCBjYXVzaW5nDQo+
ID4gbm9pc2Ugb24gc29tZSBjb2RlY3MuDQo+ID4NCj4gPiBGaXggdGhpcyBieSBjbGVhcmluZyBC
WVAgYW5kIEJDSSB0b2dldGhlciBpbiBmc2xfc2FpX2NvbmZpZ19kaXNhYmxlKCkuDQo+ID4gQWxz
byBjbGVhciBCQ0ksIHdoaWNoIGlzIHByb2dyYW1tZWQgdG9nZXRoZXIgd2l0aCB0aGUgYnlwYXNz
IGNhc2UgaW4NCj4gPiBzeW5jaHJvbm91cyBtb2RlLCBzbyB0aGUgY2FjaGVkIENSMiBzdGF0ZSBp
cyBjbGVhbiBhbmQgcmVnY2FjaGVfc3luYygpDQo+ID4gd2lsbCBub3QgcmVzdG9yZSBieXBhc3Mg
bW9kZSBwcmVtYXR1cmVseSBvbiB0aGUgbmV4dCByZXN1bWUuDQo+ID4NCj4gPiBGaXhlczogYTUw
Yjc5MjZkMDE1ICgiQVNvQzogZnNsX3NhaTogaW1wbGVtZW50IDE6MSBiY2xrOm1jbGsgcmF0aW8N
Cj4gPiBzdXBwb3J0IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGFuY2VsIExpdSA8Y2hhbmNlbC5s
aXVAbnhwLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBTaGVuZ2ppdSBXYW5nIDxzaGVuZ2ppdS53
YW5nQGdtYWlsLmNvbT4NCj4gDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuIEFzIHNhc2hpa28g
cmVwb3J0ZWQgdGhpcyBwYXRjaCBoYXMgcG90ZW50aWFsDQpyZWdyZXNzaW9uLiBJIGhhdmUgdG8g
cmV3b3JrIG9uIGl0Lg0KDQpSZWdhcmRzLCANCkNoYW5jZWwgTGl1DQoNCj4gQmVzdCByZWdhcmRz
DQo+IFNoZW5naml1IFdhbmcNCj4gPiAtLS0NCj4gPiAgc291bmQvc29jL2ZzbC9mc2xfc2FpLmMg
fCAzICsrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvc291bmQvc29jL2ZzbC9mc2xfc2FpLmMgYi9zb3VuZC9zb2MvZnNsL2ZzbF9z
YWkuYyBpbmRleA0KPiA+IDk2NjE2MDJiNTNjNS4uNGMwNjI2ZDU3MmE1IDEwMDY0NA0KPiA+IC0t
LSBhL3NvdW5kL3NvYy9mc2wvZnNsX3NhaS5jDQo+ID4gKysrIGIvc291bmQvc29jL2ZzbC9mc2xf
c2FpLmMNCj4gPiBAQCAtODQ3LDYgKzg0Nyw5IEBAIHN0YXRpYyB2b2lkIGZzbF9zYWlfY29uZmln
X2Rpc2FibGUoc3RydWN0IGZzbF9zYWkNCj4gKnNhaSwgaW50IGRpcikNCj4gPiAgICAgICAgIHJl
Z21hcF91cGRhdGVfYml0cyhzYWktPnJlZ21hcCwgRlNMX1NBSV94Q1NSKHR4LCBvZnMpLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZTTF9TQUlfQ1NSX0ZSLCBGU0xfU0FJX0NTUl9G
Uik7DQo+ID4NCj4gPiArICAgICAgIHJlZ21hcF91cGRhdGVfYml0cyhzYWktPnJlZ21hcCwgRlNM
X1NBSV94Q1IyKHR4LCBvZnMpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIEZTTF9T
QUlfQ1IyX0JDSSB8IEZTTF9TQUlfQ1IyX0JZUCwgMCk7DQo+ID4gKw0KPiA+ICAgICAgICAgLyoN
Cj4gPiAgICAgICAgICAqIEZvciBzYWkgbWFzdGVyIG1vZGUsIGFmdGVyIHNldmVyYWwgb3Blbi9j
bG9zZSBzYWksDQo+ID4gICAgICAgICAgKiB0aGVyZSB3aWxsIGJlIG5vIGZyYW1lIGNsb2NrLCBh
bmQgY2FuJ3QgcmVjb3Zlcg0KPiA+IC0tDQo+ID4gMi41MC4xDQo+ID4NCg==

