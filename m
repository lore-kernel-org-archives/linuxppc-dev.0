Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A90C67839
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 01:59:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FDE92084E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 01:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U2YCQU8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDE92084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43F0PD2SQbzDr0f
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 12:59:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="U2YCQU8V";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.14.52; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=andy.tang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="U2YCQU8V"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140052.outbound.protection.outlook.com [40.107.14.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F0LP13zxzDqsZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 12:57:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aHcde6Dqp6C4aoF2aNJcofINbNxA2vzAxyQzq5NEw8=;
 b=U2YCQU8V+GMETZZeZ9rpCE/oSyl4n7EfzMscAKCDlk6YmGGqzsaUFmSqdRC1HwyrqiZoPC2CPOy/xSJ8BohkShp/XGUCRX5zo9MM0+i7CpvcrFYIbWUKlTVe49ABUeilG+NjVGONNfMNhI9Lz57dBiyGHi4cQg/9EpyUrdOLjWI=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB1600.eurprd04.prod.outlook.com (10.164.84.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Wed, 12 Dec 2018 01:57:10 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::f474:8a44:efb6:769c]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::f474:8a44:efb6:769c%5]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 01:57:10 +0000
From: Andy Tang <andy.tang@nxp.com>
To: Scott Wood <oss@buserror.net>
Subject: RE: [PATCH 1/2 v3] powerpc/fsl: Use new clockgen binding
Thread-Topic: [PATCH 1/2 v3] powerpc/fsl: Use new clockgen binding
Thread-Index: AQHUcOeYAoWjO7RvzU6Dyo+EEyCbvqVhajYAgBkuOxA=
Date: Wed, 12 Dec 2018 01:57:10 +0000
Message-ID: <VI1PR04MB43332FE4914896FCBE8E997FF3A70@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20181031065736.32719-1-andy.tang@nxp.com>
 <09ee2f91765add47e628e0ab03776d468cec0914.camel@buserror.net>
In-Reply-To: <09ee2f91765add47e628e0ab03776d468cec0914.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB1600;
 6:WJDcO33Rp04e3iMNHh252AoOa+x3Q9p/NLcmj5ysMfThe9o/5MZYj8vsstd6d2OrIJs/A4/fuv9b5IhnfnIIqP/iJWhr2oUyKOF+kfA/F/1YmPqWVLm0VbNOqTAQf8qtrnyfKBLhC21I7i9GYyyRpW2lulVvuCuHkpBUuyaFcIKNFjEM2HN+3keQ7U/tkfcVkmgvOiLp68drUPyDlCBtnz8/tYiB4bj+aYfdwkggc/qa+e4mybSFM11t04CrFVpS+zlosDyPCkU2QuHpUtxONQGA72UrwHHS9Vu1JsjLIYqFRgm8pS/Pdj3C+l+rI95jZ2cCHjJljS+NfczTFXikV44an+6HhjpRLt+ECnPGxBMzGhHFYEA/bthIwZMz6tpQ6k754iPwhyoivMXDX70Va2Xum34gia8XU5pKWgKMTeZQRgNNhPPoQCUi1r7ZQRLkv+xhwqlsXglLyVRqAPo8jw==;
 5:Cr5gGZ86iPssa42cibRuaz6bcN1YxI83AET3OrSZ/OekdgAAp1o+2Bwfp8ewxeS3E0XD3R0JVI30Y26/ASdXvGB/sGFw+V/okhHNscufJ4q6HqCdAXp01635J6h4BnG3qFf1QLPgGWZDyNEM/5nlzwTf07bLoWrpEwP1xyohTWs=;
 7:L2zF6ovf1+PsnlBuGpvFS6A/PGW7uU4yCuxwy6uF/frOe9aR6S3BPZYiTl8x2unq/NFHAcdwqjBI5Lh0i94mWrgQDB0gDnWaBN5UUKghtMhs6vjzUheG+zQzYki+4F45/NL2Z4HIVBaxi5Rga3hx/w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2076d2ea-42c5-4b0a-087b-08d65fd520cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB1600; 
x-ms-traffictypediagnostic: VI1PR04MB1600:
x-microsoft-antispam-prvs: <VI1PR04MB1600CB7A0E5F2E93172D12E7F3A70@VI1PR04MB1600.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB1600; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB1600; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(39860400002)(136003)(376002)(396003)(13464003)(189003)(199004)(55016002)(74316002)(4326008)(9686003)(76176011)(2906002)(6916009)(99286004)(14454004)(6246003)(6116002)(53936002)(186003)(6306002)(316002)(105586002)(86362001)(6506007)(97736004)(54906003)(53546011)(5660300001)(7696005)(4001150100001)(102836004)(26005)(8676002)(305945005)(71200400001)(25786009)(3846002)(66066001)(8936002)(478600001)(7416002)(71190400001)(68736007)(486006)(106356001)(81166006)(81156014)(229853002)(11346002)(6436002)(446003)(44832011)(33656002)(476003)(14444005)(256004)(7736002)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB1600;
 H:VI1PR04MB4333.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1RxdtrY2jhMQjL4SPblJXQqmfo/yAKO4ZeKg+/1X+4i9CFoGWXTiEuWaF3gwngzNkgIyPfXQRZ6oNoO5iZTCklnsSeEel1pEOCCDY+slLw0Ck1mYUKNC8nL9Do2eOJQECPDniYK59E7NX5t4bCySozflc27grRwyhvJBl01gf5ufXos5i+AYziC6qLwzVD/AlqjLP4d4xwZNVF0SoZ742MODoedgJphK54eBSmPedE1pvBbLCTHwBR7tJwBsCCFvSicJUF0/Kdjxy3r/+NOIl4Eqmm0oQNPa7UFliBZ1UW6G+sDFc7cVKWgXmc+Rlf9k
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2076d2ea-42c5-4b0a-087b-08d65fd520cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 01:57:10.1068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1600
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCA8b3Nz
QGJ1c2Vycm9yLm5ldD4NCj4gU2VudDogMjAxOOW5tDEx5pyIMjbml6UgOToxOQ0KPiBUbzogQW5k
eSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4gQ2M6IG10dXJxdWV0dGVAYmF5bGlicmUuY29t
OyBzYm95ZEBrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IG1hcmsucnV0bGFuZEBh
cm0uY29tOyBiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc7IHBhdWx1c0BzYW1iYS5vcmc7DQo+IG1w
ZUBlbGxlcm1hbi5pZC5hdTsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4
cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yIHYzXSBw
b3dlcnBjL2ZzbDogVXNlIG5ldyBjbG9ja2dlbiBiaW5kaW5nDQo+IA0KPiBPbiBXZWQsIDIwMTgt
MTAtMzEgYXQgMTQ6NTcgKzA4MDAsIFl1YW50aWFuIFRhbmcgd3JvdGU6DQo+ID4gRnJvbTogU2Nv
dHQgV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD4NCj4gPg0KPiA+IFRoZSBkcml2ZXIgcmV0YWlucyBj
b21wYXRpYmlsaXR5IHdpdGggb2xkIGRldmljZSB0cmVlcywgYnV0IHdlIGRvbid0DQo+ID4gd2Fu
dCB0aGUgb2xkIG5vZGVzIGx5aW5nIGFyb3VuZCB0byBiZSBjb3BpZWQsIG9yIHVzZWQgYXMgYSBy
ZWZlcmVuY2UNCj4gPiAoc29tZSBvZiB0aGUgbXV4IG9wdGlvbnMgYXJlIGluY29ycmVjdCksIG9y
IGV2ZW4ganVzdCBiZWluZyBjbHV0dGVyLg0KPiA+DQo+ID4NCj4gPiArc3lzY2xrOiBzeXNjbGsg
ew0KPiA+ICsJY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+ID4gKwkjY2xvY2stY2VsbHMg
PSA8MD47DQo+ID4gKwljbG9jay1mcmVxdWVuY3kgPSA8MTAwMDAwMDAwPjsNCj4gPiArCWNsb2Nr
LW91dHB1dC1uYW1lcyA9ICJzeXNjbGsiOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgY2xvY2tnZW46
IGdsb2JhbC11dGlsaXRpZXNAZTEwMDAgew0KPiANCj4gVGhlIFUtQm9vdCBmaXh1cCB3b24ndCB3
b3JrIHdpdGggdGhpcy4gIFUtQm9vdCBwYXRjaGVzIHRoZSBmcmVxdWVuY3kNCj4gZGlyZWN0bHkg
aW50byB0aGUgY2xvY2tnZW4gbm9kZSAoQlRXLCB0aGlzIGlzIGFub3RoZXIgcmVhc29uIHRvIHBy
ZXNlcnZlDQo+IHRoZSBnZW5lcmljDQo+IDEuMC8yLjAgY29tcGF0aWJsZSBzdHJpbmcpLiAgVGhl
IG5ldyBiaW5kaW5nIGRvZXMgbm90IHJlcXVpcmUgYW4gaW5wdXQNCj4gY2xvY2sgbm9kZSB3aGVu
IGl0IGlzIHByb3ZpZGVkIGFzIGNsb2NrLWZyZXF1ZW5jeSBkaXJlY3RseSBpbiB0aGUgY2xvY2tn
ZW4NCj4gbm9kZSAtLSBhbmQgdGhlIHN5c2NsayBub2RlIHdhcyBub3QgaW4gbXkgb3JpZ2luYWwg
cGF0Y2ggKG5vciBkaWQgeW91IG5vdGUNCj4gdGhhdCB5b3UgbWFkZSBjaGFuZ2VzIGZyb20gdGhh
dCBvcmlnaW5hbCkuICBXaHkgZGlkIHlvdSBhZGQgaXQ/DQo+IA0KPiBJIHdvdWxkIGp1c3QgcmVt
b3ZlIGl0IHdoZW4gYXBwbHlpbmcsIGJ1dCBJJ20gY29uY2VybmVkIHRoYXQgdGhpcyBpbmRpY2F0
ZXMNCj4gYSBsYWNrIG9mIHRlc3RpbmcgKGFuZCBJIGRvbid0IGhhdmUgdGhlIGhhcmR3YXJlIGFj
Y2VzcyB0byB0ZXN0IGl0IG15c2VsZiwNCj4gZXhjZXB0IG9uIHQ0MjQwKSAtLSB1bmxlc3MgdGhl
IDEwMCBNSHogc3lzY2xrIGp1c3QgaGFwcGVuZWQgdG8gYmUgY29ycmVjdA0KPiBvbiB0aGUgbWFj
aGluZXMgeW91IHRlc3RlZCAod2hpY2ggd291bGQgYWxzbyBiZSBhIHRlc3QgY292ZXJhZ2UNCj4g
cHJvYmxlbSk/DQpbQW5keV0gWW91IGFyZSByaWdodC4gU3lzY2xrIG1heSBub3QgYmUgdXNlZnVs
IGFueW1vcmUuIA0KVWJvb3Qgd2lsbCBmaXh1cCB0aGUgY2xvY2tnZW4gbm9kZSBjb3JyZWN0bHku
IFBsZWFzZSBhcHBseSB0aGlzIHBhdGNoIHdpdGhvdXQgc3lzY2xrLiBXZSB3aWxsDQp0ZXN0IGl0
IGFuZCBjYXRjaCB0aGUgZXJyb3IgaWYgdGhlIGNsb2NrIGlzIG5vdCBmaXhlZCBjb3JyZWN0bHku
DQoNCkJUVywgd2hpY2ggZ2l0IHRyZWUgYXJlIHlvdSBnb2luZyB0byBhcHBseSBpdCBvbj8gVGhp
cyBvbmU/DQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9z
Y290dHdvb2QvbGludXguZ2l0L2xvZy8/aD1uZXh0DQoNCkJSLA0KQW5keQ0KPiANCj4gLVNjb3R0
DQo+IA0KDQo=
