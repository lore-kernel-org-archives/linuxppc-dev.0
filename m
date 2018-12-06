Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410EAC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 11:07:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C91214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 11:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DIX3nECT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C91214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439Xqc4rqlzDr48
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 22:07:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="DIX3nECT";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.84; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=peng.ma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="DIX3nECT"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50084.outbound.protection.outlook.com [40.107.5.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439XmL4g5dzDqhY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 22:04:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKj6pCujwfPjdwT4NXAh08V/boWQFA6xWT+u2FdYMiw=;
 b=DIX3nECTxSb6NZ2SNalWSE1L5T6Uiyk38rwUhCGtBJ3siffUbq2JsyvhVuKw+cnCBUdQfHjcvQqWDLNPB52OIb//0LluiQzvk3Pv8Yd/ooMFHbk4O0xp77XFrPryPVsne74TuU/unZLzmW2YxdwuhctupABXtZHw0HN4nD73T7Q=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.50.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 6 Dec 2018 11:04:10 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::70d0:cc68:4c85:9bc2]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::70d0:cc68:4c85:9bc2%5]) with mapi id 15.20.1404.021; Thu, 6 Dec 2018
 11:04:10 +0000
From: Peng Ma <peng.ma@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>
Subject: RE: [v11 6/7] arm64: dts: ls1046a: add qdma device tree nodes
Thread-Topic: [v11 6/7] arm64: dts: ls1046a: add qdma device tree nodes
Thread-Index: AQHUb/nsgE58aEVQXk2TH999THja76VxH5+AgACkCQA=
Date: Thu, 6 Dec 2018 11:04:10 +0000
Message-ID: <VI1PR04MB4431982D0AB333C4AC252D08EDA90@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20181030023604.34027-1-peng.ma@nxp.com>
 <20181030023604.34027-6-peng.ma@nxp.com> <20181206010531.GR3987@dragon>
In-Reply-To: <20181206010531.GR3987@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5040;
 6:78LSTrZfOpKt+7IftxSRMi616WRVGZmD8H7p9zGc2N2Wd+17ObiDpHZ1fdUC61QoAiMKyFO36f5KiitYa5TXLl/l+yD+Y+qRXxvYbirH5krO0vuxEjH/mpbBvhCXzkVjzUMihZhHRNqfzkmU8aAAuEizQaXtDf6CUWOnZknpNT3/UavvP6hHLMCLfm8hMnhhtYDiESQ7VWGIDcUSpP0xEfYErCgU9CtYIUAoNDmVY1ajf7A8oTiwDRFsts8Ezxc1LsFWXTljuFlyoQIYpjfj7NOrGEEG//7WtGBD9pvChDEARlXTucpF4XhHul34WoZc+Xqwacv5aWQv5YF2mYcEDqfXGd6raVfhYe84Ld5Ye7UGg/mGoGWc83BMBYZCMGSlj3IyQme4c9Mn0aeGa+UETi58SGyz3UgaiiASwrIWdu1h2BAX6pt27RQKR6yK5fWqEY89pS7JJvdA6L8Vek7jJA==;
 5:HMyGp0AVKF7EoOf0VBlpqhovsBcxkMI3b3xjGBAmFKQWJLfsvlewwlsJA7/EuEQXFVN0mVsj7LvqcgO2ymmZ0ZDENeBxiVu4MP77VJOmZv3xPfUSBN/LS1f0twJg+CTKBOfQbGk57GWK0i2Ed12wz/1MmEj7tcqEBIQlXYIgP70=;
 7:ICjilmD+M090bFTCOsUN3ROliR+5ZA1js9B8BsB7KH3dcmf2pfpBnZoPQsMjtCy3PRZKu+yytlNQE8/beTZeasEc6DJdn6iw8acLrVvnPSBjR+IUemJwFLPfZE/Ewo0lxG8rOjA8uPXOpJLo4ZxAsQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: afdadbd2-b655-4a3e-cd23-08d65b6a8cb4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5040; 
x-ms-traffictypediagnostic: VI1PR04MB5040:
x-microsoft-antispam-prvs: <VI1PR04MB50409624D939C08192ADE98EEDA90@VI1PR04MB5040.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR04MB5040; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB5040; 
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(13464003)(305945005)(7736002)(86362001)(7416002)(74316002)(44832011)(6916009)(105586002)(106356001)(8936002)(6116002)(3846002)(2906002)(66066001)(6436002)(11346002)(476003)(446003)(486006)(229853002)(53936002)(99286004)(68736007)(55016002)(76176011)(54906003)(6506007)(25786009)(7696005)(97736004)(6246003)(4326008)(71190400001)(71200400001)(14454004)(9686003)(256004)(33656002)(8676002)(5660300001)(186003)(26005)(478600001)(81166006)(316002)(81156014)(102836004)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5040;
 H:VI1PR04MB4431.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LTeqfmr/zv1AFT5nre/jsD4w7b0IXGOhl+vQo3UyoQQVruJny2t7duDdegy9p4oIDAZmuMKX+m39o+kio4FiIP1xYUZwcpaoXvm2ZIyXXH+HKdA0QvYmVpP5Np3EbYTiLmsIP1j7g5cnn5I1QCgco7ts+mKnzwSQ8WygMj+YSKP/3nWf4ZbLrCHxY8t3J99o36yU9ZCj0mPJkHVWVHpJQT1HplVz982hK7cpTYCLs5+2TQ+k1cKWcs88oGaFp8b7dZbB5tTdAGcn7SP1KYLkTO30E6mcxPmnOVFybK8shgJG13E+sB2sUVVjYtQqpEvnPFMJQT6koq4Ahz8zvntHbKh1JZ9fXgmI8q3TieYsmsI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afdadbd2-b655-4a3e-cd23-08d65b6a8cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 11:04:10.2972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5040
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
 Wen He <wen.he_1@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leo Li <leoyang.li@nxp.com>, "zw@zh-kernel.org" <zw@zh-kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgU2hhd24sDQoNCglUaGFua3MgZm9yIHlvdXIgcmV2aWV3ICwgSSBoYXZlIHVzZWQgR0lDX1NQ
SSBhbmQgSVJRX1RZUEVfeHh4IHRvIG15IGR0c2ksIHBsZWFzZSBjaGVjayBhbmQgcmV2aWV3Lg0K
DQpCZXN0IFJlZ2FyZCwNCglQZW5nDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZy
b206IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj5TZW50OiAyMDE4xOoxMtTCNsjV
IDk6MDYNCj5UbzogUGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPkNjOiB2a291bEBrZXJuZWwu
b3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBMZW8gTGkNCj48
bGVveWFuZy5saUBueHAuY29tPjsgZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tOyB6d0B6aC1rZXJu
ZWwub3JnOw0KPmRtYWVuZ2luZUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOw0KPmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsNCj5saW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgV2Vu
IEhlIDx3ZW4uaGVfMUBueHAuY29tPg0KPlN1YmplY3Q6IFJlOiBbdjExIDYvN10gYXJtNjQ6IGR0
czogbHMxMDQ2YTogYWRkIHFkbWEgZGV2aWNlIHRyZWUgbm9kZXMNCj4NCj5PbiBUdWUsIE9jdCAz
MCwgMjAxOCBhdCAxMDozNjowM0FNICswODAwLCBQZW5nIE1hIHdyb3RlOg0KPj4gYWRkIHRoZSBx
RE1BIGRldmljZSB0cmVlIG5vZGVzIGZvciBMUzEwNDZBIGRldmljZXMuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogUGVu
ZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPj4gLS0tDQo+PiBjaGFuZ2UgaW4gdjExOg0KPj4gCS0g
bm8NCj4+DQo+PiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEuZHRz
aSB8ICAgMjENCj4rKysrKysrKysrKysrKysrKysrKysNCj4+ICAxIGZpbGVzIGNoYW5nZWQsIDIx
IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLmR0c2kNCj5iL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLmR0c2kNCj4+IGluZGV4IGVmODM3ODYuLmRj
NjUzMTggMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wt
bHMxMDQ2YS5kdHNpDQo+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wt
bHMxMDQ2YS5kdHNpDQo+PiBAQCAtNzA0LDYgKzcwNCwyNyBAQA0KPj4gIAkJCQkJPDAwMDAgMCAw
IDQgJmdpYyBHSUNfU1BJIDE1NA0KPklSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4gIAkJfTsNCj4+
DQo+PiArCQlxZG1hOiBkbWEtY29udHJvbGxlckA4MzgwMDAwIHsNCj4+ICsJCQljb21wYXRpYmxl
ID0gImZzbCxsczEwNDZhLXFkbWEiLCAiZnNsLGxzMTAyMWEtcWRtYSI7DQo+PiArCQkJcmVnID0g
PDB4MCAweDgzODAwMDAgMHgwIDB4MTAwMD4sIC8qIENvbnRyb2xsZXIgcmVncyAqLw0KPj4gKwkJ
CSAgICAgIDwweDAgMHg4MzkwMDAwIDB4MCAweDEwMDAwPiwgLyogU3RhdHVzIHJlZ3MgKi8NCj4+
ICsJCQkgICAgICA8MHgwIDB4ODNhMDAwMCAweDAgMHg0MDAwMD47IC8qIEJsb2NrIHJlZ3MgKi8N
Cj4+ICsJCQlpbnRlcnJ1cHRzID0gPDAgMTUzIDB4ND4sDQo+PiArCQkJCSAgICAgPDAgMzkgMHg0
PiwNCj4+ICsJCQkJICAgICA8MCA0MCAweDQ+LA0KPj4gKwkJCQkgICAgIDwwIDQxIDB4ND4sDQo+
PiArCQkJCSAgICAgPDAgNDIgMHg0PjsNCj4NCj5Vc2UgR0lDX1NQSSBhbmQgSVJRX1RZUEVfeHh4
IGRlZmluZXMuDQo+DQo+U2hhd24NCj4NCj4+ICsJCQlpbnRlcnJ1cHQtbmFtZXMgPSAicWRtYS1l
cnJvciIsICJxZG1hLXF1ZXVlMCIsDQo+PiArCQkJCSJxZG1hLXF1ZXVlMSIsICJxZG1hLXF1ZXVl
MiIsICJxZG1hLXF1ZXVlMyI7DQo+PiArCQkJZG1hLWNoYW5uZWxzID0gPDg+Ow0KPj4gKwkJCWJs
b2NrLW51bWJlciA9IDwxPjsNCj4+ICsJCQlibG9jay1vZmZzZXQgPSA8MHgxMDAwMD47DQo+PiAr
CQkJZnNsLGRtYS1xdWV1ZXMgPSA8Mj47DQo+PiArCQkJc3RhdHVzLXNpemVzID0gPDY0PjsNCj4+
ICsJCQlxdWV1ZS1zaXplcyA9IDw2NCA2ND47DQo+PiArCQkJYmlnLWVuZGlhbjsNCj4+ICsJCX07
DQo+PiArDQo+PiAgCX07DQo+Pg0KPj4gIAlyZXNlcnZlZC1tZW1vcnkgew0KPj4gLS0NCj4+IDEu
Ny4xDQo+Pg0K
