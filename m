Return-Path: <linuxppc-dev+bounces-20441-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946BCCD342F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 08:15:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8rsh4rjDz2xSF;
	Tue, 05 May 2026 18:15:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777968904;
	cv=pass; b=HhNWJqu3GO662Ke3rseGg5ftSiJ+WSn6Ax7zX2aDzvXPC4tMZmv4eWdVJJLbnG2XfbYPiVJ7gDpaycSiVQ+Gis9RHTUiamZkf1H2g7zEzXxEeUUEWrrwjgpJ9UfFsjPoRlS64M8/gSBoyMtw/92yQpz6WOft6i9Af6TatcIWFbCKwOadYDTCiJ70DB1MZ65Ze9Rjn0cjjxLO0iALk2MCNOUmDS9/90kYl8b5GIqOU5bd8/cuFLx3OOboNVyq0aYHwLIb6JWWjuDNcUxuMGnnyAIE/hpfZMPpS8IVueDsV7WlQn8e9Q8j+/qMNrN87GuNao0uFEZDS6BV3fJ6LIFGWw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777968904; c=relaxed/relaxed;
	bh=Cw3rN2gispdeF4C1+MpRbkcDI0WOsyyW2IHHUQccPqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eTdl7Spe+Q92N0XXeUFlzpJfAp3E9XJH7f3kQVCgQ5vZzj4nhgo2Oujvg9/6u/S7//j3bB/MId+RbV+VxDmph1hJf4g77ST9FyP3peIuzgBFS9iGCNw3MDGd/v6A4HKejwcc4EEGBlLhhqC5/FYvUmaKw8ATFqXr8R1pr59oPsdTns0sdc2U7Q0bmslu5SEMn4ba7exOM+DXRDpfiiOM0YmdbWAyNy/sd8zs1YywnH2LBouRiUG+X5pDd7gNIUgDa6wAdRuLakNogF4zlunTHIaAhteaKJjD1u6MJXfU6l3yOpQGF/kunyUcfvmyVSVlTdK/mvphOUqGYROYMnFj4A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=aXIiDLvx; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=aXIiDLvx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8rsf4b7qz2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 18:15:01 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBnnC3DhtGfZKC2mwbB4qYkrIJMs6xFcOBq+V1c6me4Vi+bC2Av/sojs11RNZuUFTJBrltbeI+wlpH+18wTAkCaKxUdAIFl26W/poNeFqi7aClf/4oiivyAP9wuwZeCsUjJmOmken7tA3kqYH5Ot40NaGcdYRh29AVCF0vCybrYj0HnWJzAI6YdTr6u+vlHI7qPdO2Oz5Tw8vthv4aHPYBAP/2t5kkdhbAOsS40xBTB2bXz0+kwmNJPNv4ShuDn2ArKdWMGOcn+LDhYRMSpJEHuPnTdEcQbxhdD5bPET+mIyjOsGVPV0QJr6QiON7aCni+CQM0/5mNPAkZ8JRuvTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cw3rN2gispdeF4C1+MpRbkcDI0WOsyyW2IHHUQccPqY=;
 b=GCoZw/NdOVrX/y+9K2IdWhoOxMpy4S98G6QwXILJweZvw4takr6LGGSLuA9GP4oWKVlXIhsSJ9eUlDMKr2ZSxZk/9xMuD718sfL4Aatlpz1gLc4UhZ/zG+a+6rClfxaU38K937/MCAw0gKQxoDpym4GMIKJqhnjL3I83jwNchj1xFivKyDifKawWWMj5nK3i4jT9gEkqwRcwTDZ5/qfdV1vUa29uevCvyqea4UHFvg9LDmNle0Ae/cUEKxdcXThhNvX1skQGtzXO1bNRXemRNveaUVaeedzd+H/JVPU4G7NP461gF5fn+Q0p9IFZV5VSxgmG+Sav3c6vsPzhBpFJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cw3rN2gispdeF4C1+MpRbkcDI0WOsyyW2IHHUQccPqY=;
 b=aXIiDLvxD4sIINsSd3FdVL3ShQq2ite1zYqMs81it4CbHRJVtXq/hZTYTZj9/7EUH1mqLwTFQArlRlo0ShxyvTsd6cpfcaJlmQMu1ycUm8vWH0kgUu0u4Xi5fRr0GogbwnrdCMEKWODSFRF4q8HTyUnoATlm3H+W09zH2hk0YF0GGf36k/Mvhh+qyaM7/gmpkyr6UGkBRmV2+L3Pq5mRnhCKIrNWmOD4ijlVuM+qBlD5BgJbt8aTqmCm/K6gPdn0tq55EC7c41WyFG2+BLuoAYQWRVruAXqiS3yw2DD7tGzAAhtJ8TLG8Pa3PD00c7ePe48zKxMArCplw0a3oYKeLg==
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com (2603:10a6:20b:6fd::9)
 by AM8PR06MB7361.eurprd06.prod.outlook.com (2603:10a6:20b:367::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:14:32 +0000
Received: from AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f]) by AM0PR06MB10396.eurprd06.prod.outlook.com
 ([fe80::f64e:6a20:6d85:183f%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 08:14:31 +0000
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "qiang.zhao@nxp.com"
	<qiang.zhao@nxp.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH net] net: wan: fsl_uhdlc_hdlc: fix dma_rmb usage in
 hdlc_rx_done
Thread-Topic: [PATCH net] net: wan: fsl_uhdlc_hdlc: fix dma_rmb usage in
 hdlc_rx_done
Thread-Index: AQHc2960xmhVPMAKekKnNexcW8lvMrX+6IyAgAAqBeA=
Date: Tue, 5 May 2026 08:14:31 +0000
Message-ID:
 <AM0PR06MB10396920527D0B69CC9D9BDFEF73E2@AM0PR06MB10396.eurprd06.prod.outlook.com>
References: <20260504155642.2216040-1-holger.brunck@hitachienergy.com>
 <d6957853-9d24-4f35-8ea7-ef4376de991e@kernel.org>
In-Reply-To: <d6957853-9d24-4f35-8ea7-ef4376de991e@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR06MB10396:EE_|AM8PR06MB7361:EE_
x-ms-office365-filtering-correlation-id: 8a0af3ed-483a-4dcf-f0bf-08deaa7e55fe
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 YHuSbEcX2/56iaARJyywZYTR+N2aT5bb3oNA1e12ssQ3kVe7HBgL9c2guBXdIiQxaLs+rG9Cq4mJ0k2doP8behpakSi9X+GjKzwrAbGdflPQ/5dxzSOSjyfjfpNRSu9APtic7abRR+p1EVTVNdMk6SAXc1Q2d2G+vBV5M0e0qpkWBzE8N96oZRtClDB1MDhboctKvFQqX1dMWeQETxpRD7reKtRqrRn3y8VUncyrFGpb0I+53d0JwbYZuhUD1u+OO09UHjSrc/iExCNA6fa7TkEYQFqiaBxu/TGbRCVm1asyrs/XCBR8hvPUVyp6JgBwej2D+4XS1n8V4t0UVsEKUefgKVyDhY7n5vH+bN9qdRLslt2Wf+6JeKf6xXGBC+pw2YcPB48pq34CbFdbuyAMENBTAIU6ql7jMuOlYF9qfVeTS4IHlZG11+gnsyZAke8mmijpPGPueR4GuFoPLkJgVUqDsHzfH0AqY8Rl87BC17ZvrHMhVzRmdo5u+pgwh3/YT3JuuPVYTXx0azs+PSt83UBIaPRs1FZp+CwREqs8m0ITVEoXE/bIwRm3Y4KfHBkBGnBdgOQ0x588FJDE6xNVW0XO+EsqI/dZTkQX0q1F4kiI8AVAO3CVErzF8cI62toQiBpI75L8Iceis1H6KPVDPVjRKIMm5SPMCgjnVc3U9TXGIyeFjWye+Rz7ejdEK8NwgBqSm2epiI1pjDD5O7el+zeBhKLTyEFFqEtQSENVIekzvS19EsRMxsl4EnOwV7JH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR06MB10396.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZSt5K0IyTm5VMng3cjhiS0t5dDVmc1dNRHluc1NrWGt6SFhWYUJoV1RXM3ZI?=
 =?utf-8?B?dTc4dUlscWZNWkJGcVhYYy9pU0YzeDVwbFFMWFVJQ2xUTE9oTmpWRGc3M01I?=
 =?utf-8?B?SXE1bW10RnlpbWJQejQ1MkV4TGF6TnhMRVo3Q0tlNkJJVFdRZWVLMWpUc1hy?=
 =?utf-8?B?aHhZamlaclBmR2djS0hYYUc4ZXRNcC9ldS9mY2pyakJ2N3lHenpTS0thRTdk?=
 =?utf-8?B?SGlOU2RpZlZvb3BicS9zWm1RSGtUSnRYYWVCNWR3b0JIdXBGSXJjUnNwSHFK?=
 =?utf-8?B?c0JvbVV0ekh6ZDJZTVRLM3NwSVk4TFhIUUg1UC83c2xtZHBiMHV3MU1GVnZF?=
 =?utf-8?B?ZGhPbFlyRStwa0wzOVZhR3RDMDM3Y0NvdURuTFUrQmozNzJZSWwwUXkxS3Nz?=
 =?utf-8?B?RENYVVVaOHpGVlFxaldWZE45TE4vekxXTzJ1U2FWQWNTd211ckkvSDZjeUor?=
 =?utf-8?B?MzJhMHlOaGN2aU0zMno5MGN2UFNmTUh6eFpVOHB5ZWIyOGVQL2hlanFOcG81?=
 =?utf-8?B?eWJ2THFPSjVCSGtSc0pnekg2WXhlOGlOSnd1UFNtZmF3RkR3ZWN2cTFSeXJU?=
 =?utf-8?B?OTQ1TE1Ha2dic204WVBhSnNjMHowbDVmVTFUZDcxc2NsYXE5Yk5CcWlVeGpj?=
 =?utf-8?B?dUVvaldkbUdYUm0yakZwQW1WQUVkNk52cjZ1TjYyU3JaWElxSzVsZ2VqeHR5?=
 =?utf-8?B?RWN1OWovYXUxUGpNbVU4WUlnNnZudHNxQ0ZoQnJ5MTdVZHA1enZBNDBVaCt2?=
 =?utf-8?B?NjlJWTVsQ285YmQ0Mnp3YXlwd0ZpZUwwekR5YXhTMWRjYncvdXBwT1dVRFhY?=
 =?utf-8?B?b0dTU3hnM1ZDMnR2Uk14aFh4S0kyU2FMZ0M1TFdvclo4L2FoRHJxOTJ0clBK?=
 =?utf-8?B?V3BzRjU1M1NmRTNXekVDclBXbXJ3SlNPOVlHS3h1c0RDcjhrNSt6YS9PTzNO?=
 =?utf-8?B?QWt5Z2RySDJSKzBFbWs1bGxZMkxWeUlJSmNzV0xHRk56eS9zTWppa3pHNkw4?=
 =?utf-8?B?aWdTWm1aR1pnWnRObldhZ3RCbVBSS2V5QldrV3RaOU15NlRRTitkUlRiRlp5?=
 =?utf-8?B?d2dOS0pYeWo1SnF3LzdwK0lXMzQySHRQOWtiRUtrd0VqZlNSM01CM29IR2dC?=
 =?utf-8?B?OGFHMW5xaGNpbHdzOFRjTzdwUlVzUVF2RkUrRm5RVkFmK1FGWXJ3WHZKWXgx?=
 =?utf-8?B?MlNnUjhPL0xnTkVVWm9uR3phaStsSEFjNjFMeXdlZUExcGpSTWNDa3kxQ3RQ?=
 =?utf-8?B?NjRlc0xudmRtZk9CeERmSTFCMkNVeEhmSjFHVGZCTWE4NlpzWThXcU9MZ0tP?=
 =?utf-8?B?THRsMlRVblV2VXN0WXZCQ3Nxb2d0UkVidk9zME0rczk0ZkRsa2tqQzRDbEQx?=
 =?utf-8?B?N3k5aTFHTnZCNzBWeWZZSFhCVXNHcWRmRnR5ZzNheUpiMkZLTjdzd0hsNWIv?=
 =?utf-8?B?Yi83UHVpdFJWL1JrZGwvU1lNM2krbnQzNXRYcFkrRVR6cTZXd1VnditxM0d6?=
 =?utf-8?B?NHczSUZ1Y2wzcW5xMHBaRHBkaE1vcGN0N0NlQnYvTUF3aWpmQkkwMDNsbzlD?=
 =?utf-8?B?SEhPeTZ2d2Q0RXhLVlA0VHZIVmFXZ1J4cUhjWjVxLzVTSDFWREp4Zm40d0RN?=
 =?utf-8?B?R2F6QjlyK1I0ZnBzc3hmejB6MlRiRkFTTHZ1K3BUbkR5eTQwMGNhclJObXI2?=
 =?utf-8?B?SG5YZW9wQ1hpT0NCa2h5RU9FTWlPQmNqMk1lUDliWWFtaWRPQXFkTm1ZeWsw?=
 =?utf-8?B?aVZvcHFnMWpGYStmcjFIdTBheFZkM3dHY1lXWFlXZ0xZWU1uNEM4SzZPZmo4?=
 =?utf-8?B?TVR2dVF0S0JBckJPMHZKeFBsMkFWTEltZUhjaktDNjZ3OTYweTZQa0swUlhR?=
 =?utf-8?B?UENDL05xS2dOVDdPaHhGdGhyVUVBTzVGWFloMWtCbmdBdVp5bkNWUkpOSjlK?=
 =?utf-8?B?ZGVmUDhYTXYyN2lBM3RUVWJ2Ym9Hd2k2Zzc3dEF3SDlpRUZYZVk1QmZvZ3NC?=
 =?utf-8?B?VW10Z3JvOGEvMmkzN1laTjRMZm5QeXFvcW5pNG5mcy9Kd205eTBkZEw4Yy9x?=
 =?utf-8?B?NGJBN2xnYnJoQmllZHlNVnFHWlMyOHN2MGc1VzYrWlh5bjZsUFl3bEhMTDAz?=
 =?utf-8?B?OGUwVDQ5UVRqNTFXVTJSRENoVDZTT01NQ1JYNVduQnNkY2NIckEwazFsV1Ft?=
 =?utf-8?B?STFBNFhpZENwTmxGNSsyRDdtaHExQXFqcXNlcFQ5aktwTUZXOHhGbFJLd1hJ?=
 =?utf-8?B?d1h2QVAwc0lBMVhYTiswME5WTklMYU5LdmFqOEE1VGE3WmhOUmkrMm1EcVdn?=
 =?utf-8?B?bmoyNE1Vcjl4M1o0WktLQSt1ek1IMy84Zk16cjl5V2FtaFp6b3V2R1FlMWg3?=
 =?utf-8?Q?qPOcjutOL4gdWBzA=3D?=
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
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR06MB10396.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0af3ed-483a-4dcf-f0bf-08deaa7e55fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 08:14:31.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OutrD3hbJ4+TfQETj8hzZ5e+Sl0q0r90MHq1X2m7NAYhSdhraxP8V33bcJoALlVEK6R0Gs+i22lAM/faqmJ5EWWzzLRRRCgyxSq1iA01WAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR06MB7361

PiANCj4gTGUgMDQvMDUvMjAyNiDDoCAxNzo1NiwgSG9sZ2VyIEJydW5jayBhIMOpY3JpdCA6DQo+
ID4gSWYgZG1hX3JtYiBpcyB1c2VkIGl0IGhhcyB0byBiZSBkb25lIGFmdGVyIHJlYWRpbmcgYmRf
c3RhdHVzIGFuZA0KPiA+IGNoZWNraW5nIGlmIFJfRV9TIGlzIHplcm8uIFRoZXJlZm9yZSB3ZSBu
ZWVkIHRvIG1vdmUgaXQgaW50byB0aGUgd2hpbGUgbG9vcC4NCj4gDQo+IENhbiB5b3UgZ2l2ZSBt
b3JlIGRldGFpbHMgPyBXaHkgZG9lcyBkbWFfcm1iKCkgaGFzIHRvIGJlIGRvbmUgYWZ0ZXIgcmVh
ZGluZw0KPiBiZF9zdGF0dXMgYW5kIGNoZWNraW5nIGlmIFJfRV9TIGlzIHplcm8gPw0KPiANCg0K
d2hlbiBSX0VfUyBpcyB6ZXJvIGluIHRoZSBzdGF0dXMgb2YgdGhlIGJ1ZmZlciBkZXNjcmlwdG9y
IGl0IG1lYW5zIHRoZSBidWZmZXIgaXMNCmZpbGxlZCB3aXRoIGRhdGEgZnJvbSB0aGUgZGV2aWNl
LiAgTm93IHRoZSBDUFUgb3ducyB0aGUgZGVzY3JpcHRvci4gTm93IHdlDQpzaG91bGQgZXhlY3V0
ZSB0aGUgZG1hX3JtYiB0byBiZSBzdXJlIHRoYXQgd2UgcmVhZCB0aGUgZGF0YSBjb3JyZWN0bHku
IA0KQW5kIHRoaXMgd2UgbmVlZCB0byByZWRvIGZvciBlYWNoIGJ1ZmZlciBkZXNjcmlwdG9yIHdo
aWNoIGlzIGZpbGxlZCB3aXRoIGRhdGEsDQp0aGF04oCZcyB3aHkgaXQgbXVzdCBiZSBkb25lIHdp
dGhpbiB0aGUgZm9yIGxvb3AgYW5kIG5vdCBiZWZvcmUgYW5kIGFmdGVyLg0KDQpUaGlzIGlzIGFs
c28gY29uc2lzdGVudCB3aXRoIHRoZSBleGFtcGxlIGluIERvY3VtZW50YXRpb24vbWVtb3J5LWJh
cnJpZXJzLnR4dA0KDQpCZXN0IHJlZ2FyZHMNCkhvbGdlcg0K

