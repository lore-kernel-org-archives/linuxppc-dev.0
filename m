Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7184FC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 08:09:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E4420818
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 08:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q9BbNwJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E4420818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445PBS2p7SzDqTm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 19:09:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe05::62c;
 helo=eur02-he1-obe.outbound.protection.outlook.com;
 envelope-from=yangbo.lu@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="Q9BbNwJC"; 
 dkim-atps=neutral
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02on062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe05::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445P8Y5c4KzDqSq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 19:07:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vCoxBiJRZW/Vzbt1iQjQ9uMPen5D1Y5XVk6F/2eFW0=;
 b=Q9BbNwJCS3oB9cPPp2eS6SwTGeUv2eoUasKHqj97ILggwuEOs6n9TrBocVZRkwqVGhdnl9Smb+kcJfUMS/R0JLrAcyN8MFtbnD8avKAGlXvB2v4CeJKpRn90gIw+YjxOZRl7dXkpBoQ8KYMIRdH2PH0pHPS4yP5djnPIWF99xqI=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.133.18) by
 VI1PR0401MB2367.eurprd04.prod.outlook.com (10.169.134.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 22 Feb 2019 08:07:33 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::c118:ba51:b223:4b33]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::c118:ba51:b223:4b33%2]) with mapi id 15.20.1643.018; Fri, 22 Feb 2019
 08:07:33 +0000
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Horia Geanta <horia.geanta@nxp.com>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH] soc: fsl: guts: make fsl_guts_get_svr() static
Thread-Topic: [PATCH] soc: fsl: guts: make fsl_guts_get_svr() static
Thread-Index: AQHUydF6yQcno2cjn0+Orrk4Fz15FqXrduMQ
Date: Fri, 22 Feb 2019 08:07:32 +0000
Message-ID: <VI1PR0401MB2237C56CD38D546E83218C8FF87F0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20190221103731.28978-1-horia.geanta@nxp.com>
In-Reply-To: <20190221103731.28978-1-horia.geanta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8dd9d39-d80a-42da-6ae5-08d6989ccc69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0401MB2367; 
x-ms-traffictypediagnostic: VI1PR0401MB2367:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0MDFNQjIzNjc7MjM6aHlaUHhZTUJQRzA5QWZ0a2R5TmEwbFdv?=
 =?utf-8?B?ck8zQjk1VHFoVm40YUNTQVNYeTR2NmU0OWRqakp4c3JpbU5vUUtIYWgybkFH?=
 =?utf-8?B?Nmo2UjVTUWQvUjF2cmtLUGFQNDlqT09rajNuS1hLZVkrNCs2Sm52Nyt5OU5D?=
 =?utf-8?B?bXpLTnJkUFh2UDljZ1gwUnVJYTFTcENzRTRTbDkzaWc3dHpHdFRxdG1Dc0ha?=
 =?utf-8?B?ZWZqQjlySTlFQmxiNFppVnYxOSs3bWd4bUpORitrUHZ5WXd0MDVOS2pYUHBn?=
 =?utf-8?B?U2Y1UkRHZ2s3cnA0cDlBdGpzeEJuZjR6MnJJc1BCMzAxN3NvQ1RyN2F4MlNa?=
 =?utf-8?B?aVM1cGVqMm9FN3FtbzZLUUNHWmZ1S1FhYUdUNVorWjN0c0dGQTdqVHhyWXRx?=
 =?utf-8?B?eUFPQmZKQ3MxNXdXOVhWVjloU3laTWtKd0hOVVNlbjEwWkIrQmFSS21SalAz?=
 =?utf-8?B?NXZET044akFGcGVRWDR2NnFoQVQ4UTFrU0RlRW9WNlY3ZUVybDZkdC85d0ZC?=
 =?utf-8?B?bmpJbER6c3oyTmd4dEFrd1lLN3k2WThPVzdrVW9INUR5TDd4cnNwQmpEVmhX?=
 =?utf-8?B?N2txWkU0YUNMbGoyaVBtdzYydVZlcFUwSVhWb2lER2hwQXBMcUJvcmVOM1kx?=
 =?utf-8?B?NGRGeWhYUHZyWFA5VkdheUxPUzVJT3lQR2ppL1hJdlhLcjNQR1pBWXB2dTIr?=
 =?utf-8?B?UCtrYy9GV0tIYndQZjEzUFVxa01iQytIZjF1Vm1mS0JzNVRhcHZrMmExWmt3?=
 =?utf-8?B?U2RHS2lCUlZwNmxZY1kwcklWTkdtQzJNWGNlQjFueGpaTzgycldsRHdUY3Aw?=
 =?utf-8?B?Q1ZzWVQ2Nkh5cWNpSEl0Zy9scThBbW9pY2ptRWkxeWRKMHJjeTZRbkc5Ymsr?=
 =?utf-8?B?WGdFZnR6Qis4dURCUVNpQm85ZTFNVEVzUjVuUGtha2QreEhPekV3OVoxZ01O?=
 =?utf-8?B?QkN4K21mQmlESUdVRXJKZzNjSGx1c1lBVHZnRzkrRUtsTDZnTHZtemkzM1o3?=
 =?utf-8?B?RXhBM2hZcTJORFB6TG1UZ21QZnJINnVLQXNIdXZkTEQwejRIeUo5OXh2Q1dk?=
 =?utf-8?B?TGxyREFDekwvdWQ5ZUc0VlZGZ25UZ25Rb3oyeTBpZ2RtSEh6czI3bktwc0V0?=
 =?utf-8?B?Vk05UHprdzVPR21iOGppcGU3alI1YysxN3ROTDBGNmV1YzZPZUQxMVZicWJD?=
 =?utf-8?B?V0dZUEpxN244WVBKREV4SkdhSHdrb3F2R3JOYVJFeW1XQTZBbExwMHIyZHVD?=
 =?utf-8?B?dkNWcWxKUXdGYVZUZHB2d21oWWdCUjFqbVNMQ2VTdUVmL0EvWDRkS2FDYmZ2?=
 =?utf-8?B?Nks1cFhjdTlDVFVCUXhneG9aSGxvQlp6aWRWM3V2RkVld1NxcTJ6MnZmM1Ju?=
 =?utf-8?B?aS9DOFBsRzBrQ3RScStaRFhUanYrOHZGSkptNEM0Q0dmMCtia1ZSYjYyZktw?=
 =?utf-8?B?MysrOFR3SXd2UU0reWkreHFWZTh0MWZpOTRCby9PcnFjSW1MU2QxbmhSb05s?=
 =?utf-8?B?ZmNoUUlOVjZzbjJlTUJHWTNBajdsbmR5K1RwVHNRNmZNNE55RzRWb0NHckdr?=
 =?utf-8?B?WE1ENXdZZ2dXdW5WVFRSN3RFaXdwQzVuaWJjS3NNUDZwbkM0NXZraEkvZy9T?=
 =?utf-8?B?WXZGWU1EUnZkQmJ3NDNDb0wvaEFXREZTbjdLY2tBWndyYkVtcTBaSWlEazFV?=
 =?utf-8?Q?02bdo7wBgvWxY63dhoOY=3D?=
x-microsoft-antispam-prvs: <VI1PR0401MB236786AE58EBDA6352E57147F87F0@VI1PR0401MB2367.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(396003)(39860400002)(366004)(376002)(189003)(199004)(13464003)(305945005)(3846002)(6246003)(14454004)(26005)(4326008)(6116002)(7736002)(8936002)(74316002)(478600001)(256004)(316002)(54906003)(476003)(68736007)(486006)(110136005)(446003)(11346002)(71190400001)(71200400001)(2906002)(81156014)(186003)(5660300002)(81166006)(8676002)(106356001)(53936002)(105586002)(6506007)(9686003)(6436002)(55016002)(25786009)(76176011)(6636002)(99286004)(86362001)(97736004)(66066001)(102836004)(53546011)(7696005)(229853002)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2367;
 H:VI1PR0401MB2237.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PN7OeoWq8eJfh0dxohK1OzDWGryEsF3562mBxNU9yKcGww1CIryT5ztq8ezczLV9w9pfLW7eXDOvkfh9Dp/Iv9Q7kyBtJLpXVJaUaYlOrjeG+aJg+rsrYpwuqGf9HkYWn67BR29+ZguCkBU5B6KoyuIl5cJmzSMyB08pFHrz/5ifME1uO1cmZK9ZkS/AIh1+/nxirhmcyqJFDoLfMRtYDzg72robvQgRtn8UU1H09H5CS/ixgM4YujnqIxIlo+gzjix5mfARAoRPLf8cQ3HpeVD3R9jivHUw+0rBRy03hb8oIuz0iFARjtm4D9TnqryE6eLjbHaAwZ9bJNXaveLujZyPKgGvpD7EOEGk7grKdaPBxYpkCbstXCDiNRR9RZMoBDYtnBC72pxgKQHbfEynX4jVK1DM52+Qz39sF2imvX8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dd9d39-d80a-42da-6ae5-08d6989ccc69
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 08:07:33.0213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2367
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSG9yaWEgR2VhbnTEgyA8
aG9yaWEuZ2VhbnRhQG54cC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAyMSwgMjAx
OSA2OjM4IFBNDQo+IFRvOiBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gQ2M6IFkuYi4g
THUgPHlhbmdiby5sdUBueHAuY29tPjsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7DQo+
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbUEFUQ0hdIHNvYzogZnNsOiBndXRzOiBtYWtlIGZzbF9n
dXRzX2dldF9zdnIoKSBzdGF0aWMNCj4gDQo+IFRoZSBleHBvcnQgb2YgZnNsX2d1dHNfZ2V0X3N2
cigpIGlzIGEgbGVmdC1vdmVyLCBpdCdzIGN1cnJlbnRseSB1c2VkIG9ubHkgaW50ZXJuYWxseQ0K
PiBhbmQgdXNlcnMgbmVlZGluZyBTb0MgaW5mb3JtYXRpb24gc2hvdWxkIHVzZSB0aGUgZ2VuZXJp
YyBzb2NfZGV2aWNlDQo+IGluZnJhc3RydWN0dXJlLg0KPiANCg0KW1kuYi4gTHVdIEFja2VkLWJ5
OiBZYW5nYm8gTHUgPHlhbmdiby5sdUBueHAuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IEhvcmlh
IEdlYW50xIMgPGhvcmlhLmdlYW50YUBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL2Zz
bC9ndXRzLmMgICB8IDMgKy0tDQo+ICBpbmNsdWRlL2xpbnV4L2ZzbC9ndXRzLmggfCAyIC0tDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2ZzbC9ndXRzLmMgYi9kcml2ZXJzL3NvYy9mc2wvZ3V0
cy5jIGluZGV4DQo+IDRmOTY1NTA4N2JkNy4uNjNmNmRmODZmOWU1IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3NvYy9mc2wvZ3V0cy5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL2ZzbC9ndXRzLmMNCj4g
QEAgLTExNSw3ICsxMTUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZzbF9zb2NfZGllX2F0dHIN
Cj4gKmZzbF9zb2NfZGllX21hdGNoKA0KPiAgCXJldHVybiBOVUxMOw0KPiAgfQ0KPiANCj4gLXUz
MiBmc2xfZ3V0c19nZXRfc3ZyKHZvaWQpDQo+ICtzdGF0aWMgdTMyIGZzbF9ndXRzX2dldF9zdnIo
dm9pZCkNCj4gIHsNCj4gIAl1MzIgc3ZyID0gMDsNCj4gDQo+IEBAIC0xMjksNyArMTI5LDYgQEAg
dTMyIGZzbF9ndXRzX2dldF9zdnIodm9pZCkNCj4gDQo+ICAJcmV0dXJuIHN2cjsNCj4gIH0NCj4g
LUVYUE9SVF9TWU1CT0woZnNsX2d1dHNfZ2V0X3N2cik7DQo+IA0KPiAgc3RhdGljIGludCBmc2xf
Z3V0c19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSAgeyBkaWZmIC0tZ2l0DQo+
IGEvaW5jbHVkZS9saW51eC9mc2wvZ3V0cy5oIGIvaW5jbHVkZS9saW51eC9mc2wvZ3V0cy5oIGlu
ZGV4DQo+IDk0MWIxMTgxMWY4NS4uMWZjMGVkZDcxYzUyIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L2ZzbC9ndXRzLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9mc2wvZ3V0cy5oDQo+IEBA
IC0xMzUsOCArMTM1LDYgQEAgc3RydWN0IGNjc3JfZ3V0cyB7DQo+ICAJdTMyCXNyZHMyY3IxOwkv
KiAweC4wZjQ0IC0gU2VyRGVzMiBDb250cm9sIFJlZ2lzdGVyIDAgKi8NCj4gIH0gX19hdHRyaWJ1
dGVfXyAoKHBhY2tlZCkpOw0KPiANCj4gLXUzMiBmc2xfZ3V0c19nZXRfc3ZyKHZvaWQpOw0KPiAt
DQo+ICAvKiBBbHRlcm5hdGUgZnVuY3Rpb24gc2lnbmFsIG11bHRpcGxleCBjb250cm9sICovICAj
ZGVmaW5lDQo+IE1QQzg1eHhfUE1VWENSX1FFKHgpICgweDgwMDAgPj4gKHgpKQ0KPiANCj4gLS0N
Cj4gMi4xNi4yDQoNCg==
