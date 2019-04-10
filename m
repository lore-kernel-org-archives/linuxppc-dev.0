Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76271C282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:36:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F94D20830
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 10:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bpvnJCm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F94D20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fLD44mNkzDqPC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 20:36:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.42; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="bpvnJCm2"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150042.outbound.protection.outlook.com [40.107.15.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fLB01xj1zDqNC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 20:34:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=968bHTAUWeTewOnxCO+THvlh6Bc+frMeIj6MOgH1D8M=;
 b=bpvnJCm2TQRaYgorEfpYElL1seebUK8lN2zKOmcNNL6PieqsXnnBszoVEhe2FvRyhUu7gz3KBxMJR4fiajgomqdZ8xJOpi0cQntOCZWnd0CPtGhOUgcIJ9UKnxbyEymciAXuBsQe2N6LI+Ay5Bj5GyO6o0y8cJOwc+NmmimzRes=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6544.eurprd04.prod.outlook.com (20.179.234.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 10 Apr 2019 10:34:05 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::6c03:86ad:729d:e311%6]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 10:34:05 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the process_option
 table with function
Thread-Topic: [EXT] Re: [PATCH] ASoC: fsl_asrc: replace the process_option
 table with function
Thread-Index: AQHU70ukHNhK1tLZLUSA3IU+ZLcz3qY0zJeAgAAu4YCAAAz6gIAABtzAgAAYDACAAArV0A==
Date: Wed, 10 Apr 2019 10:34:05 +0000
Message-ID: <VE1PR04MB6479A2AA38FB6A27E120A441E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <1554866131-12088-1-git-send-email-shengjiu.wang@nxp.com>
 <20190410042638.GB3032@Asurada>
 <VE1PR04MB64798A5ADF025047AF5B9076E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190410080052.GA5180@Asurada>
 <VE1PR04MB6479C577E9C2C58E624C5611E32E0@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190410095129.GA3468@Asurada>
In-Reply-To: <20190410095129.GA3468@Asurada>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b322945a-cf2b-4605-a542-08d6bda00e84
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VE1PR04MB6544; 
x-ms-traffictypediagnostic: VE1PR04MB6544:
x-microsoft-antispam-prvs: <VE1PR04MB6544F5117BE663727958F700E32E0@VE1PR04MB6544.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(189003)(199004)(51444003)(52314003)(26005)(5660300002)(1411001)(68736007)(81156014)(186003)(6506007)(25786009)(508600001)(81166006)(14454004)(52536014)(33656002)(446003)(74316002)(8676002)(76176011)(11346002)(7696005)(102836004)(476003)(9686003)(97736004)(71200400001)(305945005)(53936002)(71190400001)(6436002)(8936002)(486006)(55016002)(316002)(6116002)(6916009)(6246003)(3846002)(7736002)(105586002)(4326008)(99286004)(66066001)(256004)(86362001)(229853002)(93886005)(14444005)(54906003)(106356001)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VE1PR04MB6544;
 H:VE1PR04MB6479.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9R+N7au45orPG7S+EqgB9tpoBA+uTMGsaVZ5+PsMycfFYQ3YyXdw/Jk68XGfe5rz+DoOuznn7rNuEqwIJFa/ovjn2GdUtbXji8RGVbGZFvuDQCjONKM1yvuEklXlqpaiAyp1DLaxJ+72XepJNukBHilnCMOZt3MCU0ddT67z4y0Oiz8159mLAENeMreb+N8K1dercoe/qrOhECao67OS3LKwFY4YCfI3q0EeKJgDkvVELKWY/3Iy0nzFLm6xMZPZFuopOZ7PuHh3dA3rxdVOvlY80Xgj4sVS0kqSsyQ4lrK0SbK0VUHuQyqfWNJfVVIrf3Kotz0k5DBMVzFD/yQqIuG7irdLyo5AGjd13cHtJ8RfaRk39Qk/aO/YAPyTiXixTtkB1AD608sjwgE/NJN81qBfHm2Dd/77rBW7+oCvAJo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b322945a-cf2b-4605-a542-08d6bda00e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 10:34:05.3923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6544
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
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkNCg0KPiANCj4gDQo+IE9uIFdlZCwgQXByIDEwLCAyMDE5IGF0IDA4OjI2OjU5QU0gKzAwMDAs
IFMuai4gV2FuZyB3cm90ZToNCj4gPiA+IElzIGl0IHBvc3NpYmxlIHRvIHVwZGF0ZSB0aGUgdGFi
bGU/IEl0J2QgYmUgd2F5IHF1aWNrZXIgdG8gdXNlDQo+ID4gPiBsb29rdXAgdGFibGUgdGhhbiBy
ZWFsLXRpbWUgY2FsY3VsYXRpb24gYWxsIHRoZSB0aW1lLiBJIGJlbGlldmUgeW91DQo+ID4gPiBj
YW4gc2ltcGx5IGNhbGN1bGF0ZSBhbGwgdGhlIHZhbHVlcyBvdXQgZm9yIDEyS0h6IGFuZCAyNEtI
eiBzaW5jZQ0KPiA+ID4geW91IGhhdmUgdGhlIGZ1bmN0aW9uLiBJZiB0aGVyZSBhcmUgY2VydGFp
biBjb21iaW5hdGlvbnMgb2YgdGhlc2UNCj4gPiA+IHR3byBub3QgYmVpbmcgc3VwcG9ydGVkLCB0
aGVuIHdlIGNvdWxkIG1hcmsgaXQgd2l0aCBhIHNwZWNpYWwgdmFsdWUgYW5kDQo+IGFkZCBhbiBp
Zi1jaGVjayB0byBlcnJvciBvdXQuDQo+ID4gPg0KPiA+DQo+ID4gWWVzLCAgYnV0IEkgdGhpbmsg
dGhlIGZ1bmN0aW9uIHNob3VsZCBiZSBtb3JlIGZsZXhpYmxlLCBpZiBzb21lZGF5IHdlDQo+ID4g
bmVlZCB0byBzdXBwb3J0IE90aGVyIHNhbXBsZSByYXRlLCBvbmx5IG5lZWQgdG8gdXBkYXRlIHRo
ZSBsaXN0Lg0KPiANCj4gR2l2ZW4gdGhlIGZhY3QgdGhhdCB0aGUgb3duZXIgb2YgdGhlIGZ1bmN0
aW9uIGNhbm5vdCBnaXZlIG1vcmUgY29tbWVudHMsIEkNCj4gZmVlbCB0aGUgZnVuY3Rpb24gd291
bGRuJ3QgYmUgdmVyeSBtYWludGFpbmFibGUgYXMgbm9uZSBvZiB1cyB1bmRlcnN0YW5kcyBpdA0K
PiB3ZWxsLiBPbiB0aGUgb3RoZXIgaGFuZCwgeW91J2xsIG5lZWQgdG8gdXBkYXRlIHRoZSBzdXBw
b3J0ZWQgSS9PIHJhdGUgbGlzdHMNCj4gYW55d2F5LCBzbyB3aHkgbm90IGp1c3QgdXBkYXRlIHRo
ZSB0YWJsZSBhcyB3ZWxsPyBUaGUgc3VwcG9ydGVkIHNhbXBsZQ0KPiByYXRlcyBmcm9tIEFMU0Eg
YXJlIGxpbWl0ZWQgdG9vLiBPdmVyYWxsLCBJIHRoaW5rIHRoYXQgY29udGludWUgdXNpbmcgYSBs
b29rdXANCj4gdGFibGUgd2lucy4NCg0KQWxzYSBzdXBwb3J0IFNORFJWX1BDTV9SQVRFX0tOT1Qs
IHdlIGNhbiBkZWZpbmUgdGhlIHJhdGUgdGhhdCB3ZSB3YW50DQpUbyBzdXBwb3J0LCAgYW5kIHVz
ZSBmdW5jdGlvbiBpcyBtb3JlIGZsZXhpYmxlLCBhbmQgd2UgaGF2ZSB1c2UgdGhlIGZ1bmN0aW9u
DQpJbnRlcm5hbGx5IGZvciBsb25nIHRpbWUsIGl0IGlzIHN0YWJsZfCfmIoNCg0KDQoNCg==
