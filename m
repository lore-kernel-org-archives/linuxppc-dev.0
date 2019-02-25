Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6800BC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 02:34:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A6720645
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 02:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sQghx9qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A6720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4475cT0ySvzDqQj
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 13:34:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe1f::61e;
 helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="sQghx9qe"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4475Zf0VtKzDqNt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 13:32:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyzKbJ6/NlUxqb3quZ4ypEEwWa3e9cAEvTX0XVDU0vA=;
 b=sQghx9qeEd7QXiMH1tPIUeBbeRd7aweQb5EoqJrDg4SE3uN14khftuWcViULdLPGnIAGRCb+eM3WVRjC5306PUOLmf7oaXMLe371ZnKN1siilhAgtMPiS2w6XbyBhiIi2cUhsrgL9v6dK+2crtXkugzKHLdsYrfSG/Wy905oR8w=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3709.eurprd04.prod.outlook.com (52.134.15.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 02:31:32 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 02:31:32 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Subject: RE: [PATCH] ASoC: fsl_esai: fix channel swap issue when stream starts
Thread-Topic: [PATCH] ASoC: fsl_esai: fix channel swap issue when stream starts
Thread-Index: AQHUycs9fdqkcg+Cg0iNVs6jgStKdqXqDPOAgAXDviA=
Date: Mon, 25 Feb 2019 02:31:32 +0000
Message-ID: <VI1PR0402MB33920A616FCA34D15C502574E37A0@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <1550742787-3268-1-git-send-email-shengjiu.wang@nxp.com>
 <CAOMZO5A-XCxtNmO5+JM+9R34oh-dYUD8ZHynCUE_p_Q-kjvR0w@mail.gmail.com>
In-Reply-To: <CAOMZO5A-XCxtNmO5+JM+9R34oh-dYUD8ZHynCUE_p_Q-kjvR0w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4dbf140-4fef-4af0-0a7b-08d69ac95b3d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3709; 
x-ms-traffictypediagnostic: VI1PR0402MB3709:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0MDJNQjM3MDk7MjM6ZXdRWldxUkNsNlRsMkMrVWIrWjE5ZTNl?=
 =?utf-8?B?Wmp4V2kxMmdPenhZaVRuY3o0N0h2SVRGUUNhck8xaExEeXJsRzhESk1wREx2?=
 =?utf-8?B?aThKd0J6NnFOOTBJZHlSOWZrM251cDZJTUxYdkhrNnFCTHZrNkhRbzloeWRt?=
 =?utf-8?B?S25OMGZwNlMrdTVlMk8rV0U3Rmw2MVllSEhPY1lFaWlBZHJ6b1FNVkxtQWdN?=
 =?utf-8?B?SmxGVXlTYm1EREtuRjdZVG5waGw0SUtCYnpVUmJyRWRuZUNMeGp5RUkwM1RI?=
 =?utf-8?B?cnlVL0dUeXBEbzJaWm5YNm13TzgzaDBmMzg5ODMyMmlya0tBYW1GVVpjMkdw?=
 =?utf-8?B?RnBibk5sRW1ZeENJM1hmd25zaGRSek50ZU5TL3hRbk5ydGo5b3BSWlF1dlJD?=
 =?utf-8?B?SklVK3pxZUNDYTFOQzNTekhMRVB2RmQwUHJqZHFnTEFOVEZ2dkxmVHBucHNl?=
 =?utf-8?B?ZHRja1JobG5UOXVLaDdkaGtDOG4vbE51TkQ5OWQraUREWERRWnpVV3dnbGgw?=
 =?utf-8?B?S0RNZlkwSzdBclRDZ0JVZEJkdkdJRnFMOGkxMDBvT29wczBxanBwTVZkSzYz?=
 =?utf-8?B?UDBLMVlVa3JETnVhT3dxSk1ub1NvcHVrWGpIVWRSVnoyWENFZHJVVTRnaTNG?=
 =?utf-8?B?R1Budno2c1krUjk3cTRHTy90R05qRjRTNTVlUnF5MTg1TWtkeHNjbUFZbnYy?=
 =?utf-8?B?WEMrcTJiU1hSYXNqd0ZPa0ZhZXJzc2E5UnRXaTFQVDIrZWVhOGMvak5FVGx1?=
 =?utf-8?B?SnFrdkFGbjR3b3Z2NDBRYkoxOUlJSlowOVNEYU03MTRZWHBVTmttQWJkdHRI?=
 =?utf-8?B?UHBUbitBeHFGM0s0YjhYWnpuYWxob01xTSsrLzBWaUlFN1c2QWRPMUhELzBk?=
 =?utf-8?B?NmU2bjhXZ0x0dmtncDFpRFNNdTBVdjArTmFRano5YjlOSW9lY2RnNncvMUxC?=
 =?utf-8?B?cm5LV285OVlYdXlJb3A1ZGhIUlAraDFMZVVWRjdKd0lrZzFIc2cwUUszVkVt?=
 =?utf-8?B?Qm1zTm5MTFcweFdsK2RORDJOT1d1aTNjcnQ2RU5nZjVTWGI2MXRCZmRzL05J?=
 =?utf-8?B?a2JybDBnRktmcGdtVTdWRFNaR1RmZXdWZ3ZDODJycVhYS0FMbmJKL3h0Q1lp?=
 =?utf-8?B?b0NCem04NUsvcENOOGs2TDloWUl1MUtoWm9kTEJYa3lGSmFLRHZPTkpKd2cv?=
 =?utf-8?B?WnlTd2haRFdLSHFnUy9MdTUwbVBwbUZCcDNKMU1WcEdRODY1SFY3bWR0THlI?=
 =?utf-8?B?RHBmeFpIYnVFdjlDZng5c1owdkRFNEtia3NtMm9vYVY1eFJxc21lL3hPWE83?=
 =?utf-8?B?aGg2TENMQzAyNnB3eGJkSmhkbTN1am1LcWpXNVM3V2hGV2R1Qmo4R2dLUVVF?=
 =?utf-8?B?ZFBTTExkdVFEVDc4RC9OaFBFODJVSThWalRTNW9MZ3B3M2JlL0ttaTNWazIv?=
 =?utf-8?B?cUw2bTUxTGJMYloydjdLMWkrb2lxUnh4WUphcW9pNGpVTVpLeU9oZXh5ZStL?=
 =?utf-8?B?UzZaR2RSc1dBNWJlQk0zS051d25TWGJvWFM0bWVDMmRRK211NUdSQm5hK1l2?=
 =?utf-8?B?MEJxanJmQ1hHUCtWOC9Db2F6dTRRVDU0enQvc3I5QlZIcWEwVStVYlhBTlJQ?=
 =?utf-8?B?MGppYkV1QXFjZmhNSGh6c0JNNnMwS3lCUlVCc1RISzRLY3cwQTh4Vmt3T3Vt?=
 =?utf-8?Q?IndIUHAiKFMz0t0SEw90=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3709D7F85708FC0D3336BCFAE37A0@VI1PR0402MB3709.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(366004)(346002)(136003)(39860400002)(199004)(189003)(33656002)(66066001)(71190400001)(71200400001)(8936002)(97736004)(55016002)(478600001)(2906002)(9686003)(52536013)(54906003)(102836004)(53546011)(5660300002)(76176011)(99286004)(6506007)(53936002)(7696005)(6436002)(316002)(1411001)(86362001)(68736007)(486006)(305945005)(7736002)(476003)(186003)(11346002)(229853002)(8676002)(81156014)(3846002)(6116002)(446003)(81166006)(4326008)(6246003)(256004)(25786009)(6916009)(106356001)(74316002)(105586002)(26005)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3709;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Qya4QCLmOh7e3LPK2gICVWhzNAZsNjupQCmPRP8UsZSXD+TKtgLJXVCRLTsm3uekqbppcitOSBB+qUihTDlx5IIBDRW/ViKFuyZVtfRbD/ahVpSskzr+dkcfUTZzceXj3/+LvkTibvV2DJSxml2KBMmtmDdpJiNqebFgM2T+k5AmZiyApeJ5inbYCl5kjW1/f3JhLjq675FXJeOXd4gExmrmxhxYcbT2ESofT+q4fmpLve3ZcF/LKALFnb3/VScz6ixbkDGyDYlI2rkPX2rz7aY5bEiR9H05so+bRbG/eZKvJQO2IwNrR7UEek7/xxwYtsVjgReKmDCv9qMkd8835vnDJvgVQD5HOopx2POsXt7XZ2q8Z7TwXc5FCTEcQHUPYot4xNknTmgNU6yTR0WXFTYyUfhZfHvzScjxR3uBoaA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dbf140-4fef-4af0-0a7b-08d69ac95b3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 02:31:32.7753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3709
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

VGhhbmtzLCB3aWxsIHNlbmQgdjIuDQoNCkJlc3QgcmVnYXJkcw0KV2FuZyBzaGVuZ2ppdQ0KPiAN
Cj4gSGkgU2hlbmdqaXUuDQo+IA0KPiBPbiBUaHUsIEZlYiAyMSwgMjAxOSBhdCA2OjUzIEFNIFMu
ai4gV2FuZyA8c2hlbmdqaXUud2FuZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEZyb206
IFNoZW5naml1IFdhbmcgPHNoZW5naml1LndhbmdAZnJlZXNjYWxlLmNvbT4NCj4gDQo+IEJldHRl
ciB1c2UgeW91ciBueHAuY29tIGFkZHJlc3MgYXMgdGhlIGZyZWVzY2FsZS5jb20gZG9tYWluIGlz
IGdvbmUgZm9yIGENCj4gbG9uZyB0aW1lLg0KPiANCj4gPiBUaGVyZSBpcyB2ZXJ5IGxvdyBwb3Nz
aWJpbGl0eSAoIDwgMC4xJSApIHRoYXQgY2hhbm5lbCBzd2FwIGhhcHBlbmVkIGluDQo+ID4gYmVn
aW5uaW5nIHdoZW4gbXVsdGkgb3V0cHV0L2lucHV0IHBpbiBpcyBlbmFibGVkLiBUaGUgaXNzdWUg
aXMgdGhhdA0KPiA+IGhhcmR3YXJlIGNhbid0IHNlbmQgZGF0YSB0byBjb3JyZWN0IHBpbiBpbiB0
aGUgYmVnZ2lubmluZyB3aXRoDQo+IA0KPiBzL2JlZ2dpbm5pbmcvYmVnaW5uaW5nDQo+IA0KPiA+
IHRoZSBub3JtYWwgZW5hYmxlIGZsb3cuDQo+ID4NCj4gPiBUaGlzIGlzIGhhcmR3YXJlIGlzc3Vl
LCB0aGUgd29ya2Fyb3VuZCBmbG93IGlzIHRoYXQ6IEVhY2ggdGltZQ0KPiANCj4gSXMgdGhlcmUg
YW4gZXJyYXR1bSByZWZlcmVuY2UgZm9yIHRoaXMgaXNzdWU/IElmIHNvLCBwbGVhc2UgYWRkIGl0
IGhlcmUuDQo+IA0KPiA+IHBsYXliYWNrL3JlY29yZGluZywgZmlyc3RseSBjbGVhciB0aGUgeFNN
QS94U01CLCB0aGVuIGVuYWJsZSBURS9SRSwNCj4gPiB0aGVuIGVuYWJsZSB4U01CIGFuZCB4U01B
ICh4U01CIG11c3QgYmUgZW5hYmxlZCBiZWZvcmUgeFNNQSkuDQo+ID4gV2hpY2ggaXMgdG8gdXNl
IHRoZSB4U01BIGFzIHRoZSB0cmlnZ2VyIHN0YXJ0IHJlZ2lzdGVyLCBwcmV2aW91c2x5IHRoZQ0K
PiA+IHhDUl9URSBvciB4Q1JfUkUgaXMgdGhlIGJpdCBmb3Igc3RhcnRpbmcNCj4gDQo+IFBsZWFz
ZSBhZGQgYSBGaXhlcyB0YWcgYW5kIENjIHN0YWJsZS4NCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
U2hlbmdqaXUgV2FuZyA8c2hlbmdqaXUud2FuZ0BmcmVlc2NhbGUuY29tPg0KPiANCj4gUmV2aWV3
ZWQtYnk6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gDQo+IFRoYW5rcw0K
