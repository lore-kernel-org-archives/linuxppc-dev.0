Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC047C43444
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47AB720873
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 09:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="krDorDaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AB720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KVQN4swmzDqRN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 20:46:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="krDorDaW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.15.48; helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="krDorDaW"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr150048.outbound.protection.outlook.com [40.107.15.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KV400yVPzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 20:30:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma9JNd/rdBpkwyMAxN/UIU0qAGVievhBtLgjR4fyZG4=;
 b=krDorDaW9eyTcC23Uk7FLdCHBvjOvpG3WS5J5RmckUdyuOyuSC9lchTPGJ1VJbpieztgMdAcnytTClb/VV08CA40IxCEdo3ObFqoGzeoY89MSYtoDrxjAX4OAYZxNEXuj/qTo3tK9wgt58RPKLqNqlgTlr/L+otnVgxlH5dI1Lg=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3185.eurprd04.prod.outlook.com (10.173.255.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Wed, 19 Dec 2018 09:30:15 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::adfc:f966:2246:5f53]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::adfc:f966:2246:5f53%3]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 09:30:15 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: RE: [PATCHv3 4/4] misc: pci_endpoint_test: Add the layerscape EP
 device support
Thread-Topic: [PATCHv3 4/4] misc: pci_endpoint_test: Add the layerscape EP
 device support
Thread-Index: AQHUivSP4DiPlnsgskWJBbx3Xt7xF6WF4msAgAAB5FA=
Date: Wed, 19 Dec 2018 09:30:15 +0000
Message-ID: <AM5PR04MB32997D5B5962BE9E21C77638F5BE0@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20181203103505.46885-1-xiaowei.bao@nxp.com>
 <20181203103505.46885-4-xiaowei.bao@nxp.com>
 <20181219092104.GA7356@kroah.com>
In-Reply-To: <20181219092104.GA7356@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM5PR04MB3185;
 6:XYzsxwP1eO2iRCoHdVC7qtH4rjNuJYHm5vud42ks2tk3cNhM/Ny2wi/mXkkLpJyYqLgT18KCDGcf9KCykm+LKFrlyt1z+PbVKCE/OGzNOnrSHplrxqwfGJQwbbe6dPRzhgALe94aIKRdyDGaj+PCSDarSSyRzi/QB5xKTRlBQbsQlqsMe5dBMeZ8E4p4QcFkXECdSPTZXiqUGySRfIrkX2mURnGFdsoaG1OfkGgBmEKKwqK2zo88F/+2BG9PpvlO+DerAlcHDC1Zn3rVCnSv/cwwTgvAkWeDcw9IASw9M4XrzzPc/8MXJGuWFz+T1FOu9p3wST5tqKwuNssxOx9TFSaelw+uwJYpL7xblXf1remnZwG8+Ie7IB6DGVSVJFGHpFJkiVKbCXEkP74OP8h3X2TyQQu/VlxC7Z/z4lMeUIOx2Z8JmYCjvNJEudM9h7JT+Pe9S0Do8ww/myc3nFRQuA==;
 5:mmo4JupIxSDwvJFhN+TLOIpmTrXo+A3rFOu84CL+0E1xR1pRe1n/VzdqL3qlZ7okaW+CtaE6fw+Ynu14cUOLT4fxbjfPFtdzEy4TbyrIc9VISXXdPlMJVY59CL45KHryX0wesDf+N2UTIgkn+qb7HrMvf6ImDoNgLI8xWZmbHvg=;
 7:laOjP9wzTcep0zCnQZLVZghRiR2TVym8Pt4l7FIKv38YtKYTUqdTg/u/UFr44kOeWAMNZfTa1kcCwv0mSRE9F56zuUFqMO3plteVjfMaU+WOjSpMA/d+MmDEWVJpdnwn8nB0G6bE5xes+fyJku0QVg==
x-ms-office365-filtering-correlation-id: 1b3624e9-99ea-4b66-580a-08d665949579
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR04MB3185; 
x-ms-traffictypediagnostic: AM5PR04MB3185:
x-microsoft-antispam-prvs: <AM5PR04MB318539A7713AC62C830B39F6F5BE0@AM5PR04MB3185.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM5PR04MB3185; BCL:0; PCL:0; RULEID:; SRVR:AM5PR04MB3185; 
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(13464003)(68736007)(74316002)(256004)(2906002)(6916009)(14454004)(3846002)(6436002)(25786009)(99286004)(4326008)(26005)(6116002)(66066001)(86362001)(305945005)(33656002)(7696005)(186003)(105586002)(6506007)(5660300001)(106356001)(486006)(44832011)(55016002)(316002)(53546011)(229853002)(7736002)(8936002)(9686003)(97736004)(81156014)(102836004)(11346002)(8676002)(446003)(7416002)(476003)(478600001)(81166006)(53936002)(71190400001)(76176011)(6246003)(71200400001)(54906003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR04MB3185;
 H:AM5PR04MB3299.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aWJiuSYpbcAQlItcc62n5AA7N15AS8tLz5kpD0g3kgNyGmkhfn3mC91y+NeMRuhoDbDl2FRs5qDWe3MZweFHBjDyJWhJlgurHigrh+VlDB2Y8pZ3imK2rqKOZSan1N+LmWULXgaxU9DXr2a/ACWf0pmeJOQeAxy3HfUwROxDcZeqv7MoyalUxmEfDPGoonXHsjnGISxhMKYwis5c5uVrejcS7xGRUFMtgG1SiTJSuO0Y00lTE9rst2I4H5nsP0A5WoxaO4GKmuveA89z7xM5WnElC0WprZgDcJg4UfvEG5QULHTYimGCTu1QBQ1Rl0+k
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3624e9-99ea-4b66-580a-08d665949579
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 09:30:15.5905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3185
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Roy Zang <roy.zang@nxp.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kishon@ti.com" <kishon@ti.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "pombredanne@nexb.com" <pombredanne@nexb.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
 Mingkai Hu <mingkai.hu@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBHcmVnIEtIIDxncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZz4gDQpTZW50OiAyMDE4xOoxMtTCMTnI1SAxNzoyMQ0KVG86IFhpYW93
ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KQ2M6IGJoZWxnYWFzQGdvb2dsZS5jb207IHJv
YmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5v
cmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsga2lzaG9uQHRpLmNvbTsgbG9yZW56by5w
aWVyYWxpc2lAYXJtLmNvbTsgYXJuZEBhcm5kYi5kZTsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFu
QG54cC5jb20+OyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBSb3kgWmFuZyA8cm95
LnphbmdAbnhwLmNvbT47IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGN5cmlsbGUucGl0
Y2hlbkBmcmVlLWVsZWN0cm9ucy5jb207IHBvbWJyZWRhbm5lQG5leGIuY29tOyBzaGF3bi5saW5A
cm9jay1jaGlwcy5jb207IG5pa2xhcy5jYXNzZWxAYXhpcy5jb207IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIdjMgNC80XSBtaXNjOiBw
Y2lfZW5kcG9pbnRfdGVzdDogQWRkIHRoZSBsYXllcnNjYXBlIEVQIGRldmljZSBzdXBwb3J0DQoN
Ck9uIE1vbiwgRGVjIDAzLCAyMDE4IGF0IDA2OjM1OjA1UE0gKzA4MDAsIFhpYW93ZWkgQmFvIHdy
b3RlOg0KPiBBZGQgdGhlIGxheWVyc2NhcGUgRVAgZGV2aWNlIHN1cHBvcnQgaW4gcGNpX2VuZHBv
aW50X3Rlc3QgZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWGlhb3dlaSBCYW8gPHhpYW93
ZWkuYmFvQG54cC5jb20+DQo+IC0tLQ0KPiB2MjoNCj4gIC0gbm8gY2hhbmdlDQo+IHYzOg0KPiAg
LSBubyBjaGFuZ2UNCj4gDQo+ICBkcml2ZXJzL21pc2MvcGNpX2VuZHBvaW50X3Rlc3QuYyB8ICAg
IDIgKysNCj4gIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9wY2lfZW5kcG9pbnRfdGVzdC5jIA0K
PiBiL2RyaXZlcnMvbWlzYy9wY2lfZW5kcG9pbnRfdGVzdC5jDQo+IGluZGV4IDg5NmUyZGYuLjc0
NGQxMGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9wY2lfZW5kcG9pbnRfdGVzdC5jDQo+
ICsrKyBiL2RyaXZlcnMvbWlzYy9wY2lfZW5kcG9pbnRfdGVzdC5jDQo+IEBAIC03ODgsNiArNzg4
LDggQEAgc3RhdGljIHZvaWQgcGNpX2VuZHBvaW50X3Rlc3RfcmVtb3ZlKHN0cnVjdCANCj4gcGNp
X2RldiAqcGRldikgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBwY2lfZW5kcG9p
bnRfdGVzdF90YmxbXSA9IHsNCj4gIAl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9USSwgUENJ
X0RFVklDRV9JRF9USV9EUkE3NHgpIH0sDQo+ICAJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURf
VEksIFBDSV9ERVZJQ0VfSURfVElfRFJBNzJ4KSB9LA0KPiArCS8qIDB4ODFjMDogVGhlIGRldmlj
ZSBpZCBvZiBsczEwNDZhIGluIE5YUC4gKi8NCg0KVGhlcmUgaXMgbm8gbmVlZCBmb3IgYSBjb21t
ZW50LCBqdXN0IHRoaXMgbGluZSBpcyBmaW5lOg0KDQo+ICsJeyBQQ0lfREVWSUNFKFBDSV9WRU5E
T1JfSURfRlJFRVNDQUxFLCAweDgxYzApIH0sDQoNCklmIHlvdSBub3RlLCBubyBvdGhlciBsaW5l
cyBoYXZlIGNvbW1lbnRzLg0KDQpJZiB5b3Ugd2FudCB0byBzYXkgdGhhdCB0aGlzIGlzIGEgc3Bl
Y2lmaWMgZGV2aWNlLCB0aGVuIHVzZSBhICNkZWZpbmUgd2l0aCB0aGF0IGRldmljZSBuYW1lIGFu
ZCB0aGVuIHVzZSB0aGF0IGRlZmluZSBoZXJlLCBsaWtlIHRoZSBQQ0lfREVWSUNFX0lEX1RJX0RS
QTcyeCB3YXMgZG9uZS4NCg0KdGhhbmtzLA0KDQpncmVnIGstaA0KW1hpYW93ZWkgQmFvXSBIaSBH
cmVnLCBPSywgSSBjYW4gcmVtb3ZlIHRoZSBjb21tZW50cyBpbiB0aGUgbmV4dCB2ZXJzaW9uIHBh
dGNoLg0K
