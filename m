Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A6BECDE44
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 07:45:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BF520665
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 07:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NN/V0Z8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BF520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hGHn3lWnzF3HK
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 18:45:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NN/V0Z8w";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=104.47.1.88; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="NN/V0Z8w"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0088.outbound.protection.outlook.com [104.47.1.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hGDK6WPnzF3G7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Oct 2018 18:42:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRF1F1LONWvMLzIL3IA6scFUttA4gJjek/1HRoKGc9k=;
 b=NN/V0Z8wvTv11lMMKfH9KafxEwTbve7d81dxdgzxs8fZv4guNsmVRB42VqBNaT547IeDt0daeludh0oEb5HM74frDo3357eZwGHG7hNrY8gxnG5HdT/ErFdpbxFgkj26aQYogYLKyzZ0zWFQQs3PgSVjl3uCtPBhS3BNbu3gUcs=
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com (10.163.176.23) by
 HE1PR04MB1290.eurprd04.prod.outlook.com (10.162.249.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Fri, 26 Oct 2018 07:42:12 +0000
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::70d8:2ebf:92cf:5aae]) by HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::70d8:2ebf:92cf:5aae%2]) with mapi id 15.20.1250.032; Fri, 26 Oct 2018
 07:42:11 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH 3/6] PCI: layerscape: Add the EP mode support
Thread-Topic: [PATCH 3/6] PCI: layerscape: Add the EP mode support
Thread-Index: AQHUbFO/sDtxRLGmJUqv9XRnx7sCWaUwgXkAgABfTVCAADn2gIAABkeQ
Date: Fri, 26 Oct 2018 07:42:11 +0000
Message-ID: <HE1PR04MB14972C9176E68EEDBD3AD64BF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-3-xiaowei.bao@nxp.com> <20181025215246.GA14861@bogus>
 <HE1PR04MB149735C7EF2A23AEE982BB9FF5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <CAK8P3a3Ty4bRuHiVHY6dh55b1ms8z7RpG2sALM0Dn_8Yd39-xQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3Ty4bRuHiVHY6dh55b1ms8z7RpG2sALM0Dn_8Yd39-xQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR04MB1290;
 6:lpH4+aDKLmlgBPeaFhmBB7kbDXhr8f0huOMZYI4DH7q3DZXru2Wcxl17CVhCIQQC+rHnU3DksErci6HsHY4Y8QrUT6N3CviMSmrHeYlDApMtab84pBCGn4uwXXJI/E2064FoWLHwJYNSBpIXong9D04F1Po1YcPWQ0zIF21v1xt7AsxvlxYQBMJjlwpzo23dMDmJQQMJsUNNTsYWN39Rri65paDskiyK5VCzf1KALSXBEnJgCIrDo0AxtT6P4pI/LK3mcPY4mnFOSHgOimsYK7g6/6OToij3H7GaZgwhB0DWfdJw7DxVyFh4mQLr7UUV8euVoAPF5GYX2eNFsSBKx/2UNz53CB+TQ2tOwOk8GGfQ4Gg2pRrmpJH232hV3fLt+xbkV13PBA2+A5dhQID6mXzS+SBUFd6AIuuQqf1v/q1MWOdaISp6Nkho+d/W9VCt77DUUagLr9l3SUbRgsxstA==;
 5:iX3N9OWOzwQRyceKc32U5zfLoas896vgu4FF/FlPB3rXJboS4sEJtYKew0Zc1trgEr8u/GX8iZ97UNIKTHxRByaCwJLUWbtX25I3Wnz0eJD7B2/90FR4DyrCsaA9YXyBBoJQBTXNGofbkleOu27ITa1pz88PqAj/lGEnuZnxleI=;
 7:JOacOVu7MZWCzijTi7EjbNU2cj8lxVc1ViglILVKxm1L1XokCj1cdawS3QVJEVi87D/mHOMHWfeLEqvFRLSG9ASW9cPSt0wtUInkT8kCQYpU+/coVcyytPjTFTZjfIRsZywJLAk7PCXaCbUN40mhXT6HF952N4SOn73kcCmdlKtvNUsEeew2XpamkCsffo0aYrOW6f0TsoQyYbbpPsDcIHrobKYQH70f6THCbLhY2JXCn4BraucTIWgBfCSlql+J
x-ms-office365-filtering-correlation-id: 041057ca-c9cd-46ee-e9b2-08d63b168a92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB1290; 
x-ms-traffictypediagnostic: HE1PR04MB1290:
x-microsoft-antispam-prvs: <HE1PR04MB1290D394B15D269A9F578B41F5F00@HE1PR04MB1290.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(211936372134217)(180628864354917)(31051911155226)(58145275503218)(9452136761055)(258649278758335)(65623756079841)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR04MB1290; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB1290; 
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(136003)(396003)(376002)(346002)(13464003)(189003)(199004)(6436002)(68736007)(5660300001)(81166006)(8676002)(6916009)(81156014)(93886005)(5250100002)(8936002)(33656002)(97736004)(74316002)(478600001)(7736002)(2900100001)(102836004)(6116002)(53546011)(26005)(6506007)(55016002)(3846002)(2906002)(305945005)(11346002)(99286004)(71190400001)(476003)(186003)(76176011)(71200400001)(14444005)(7696005)(316002)(446003)(54906003)(86362001)(14454004)(7416002)(44832011)(486006)(53936002)(6246003)(25786009)(66066001)(256004)(4326008)(9686003)(105586002)(106356001)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB1290;
 H:HE1PR04MB1497.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CpifUTA1nPLI9hvUsZ+dy4r8pLx/2ClH9PpLvXWaKi2cLMZyJFaM7EvUfEN4LWbvz4esN9siS6VVakZfxI6ZE8NRA+wkpInek2yTkIttC1eNCXnqdSFRcf/f/n2Vteb4+SxC+yI7XnEfYmn5JMgMHfs4Ct0iSskU1UDVhTfRoGDmW4nHOXGyHgPwU9DN4QNMJhRaPTIZWDxF7zagtdimK25AJDXcq5IGb2/E/JIirDvsyMQyRzPLsb9OPxN9NynRkGNOG82B1+E7BhuhPy+OQsk4iD2/RO++2BjrqPhcxf9CKmYshle6BqbpyGh1vAOnOE2vo9qADSMDMyV8Tk8C8oTJfD77+KjCa4g9rrBrQ/A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041057ca-c9cd-46ee-e9b2-08d63b168a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 07:42:11.7335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1290
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
 Rob Herring <robh@kernel.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 Roy Zang <roy.zang@nxp.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kishon@ti.com" <kishon@ti.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBhcm5kYmVyZ21hbm5AZ21haWwu
Y29tIDxhcm5kYmVyZ21hbm5AZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgQXJuZCBCZXJnbWFubg0K
U2VudDogMjAxOOW5tDEw5pyIMjbml6UgMTU6MDENClRvOiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5i
YW9AbnhwLmNvbT4NCkNjOiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgYmhlbGdhYXNA
Z29vZ2xlLmNvbTsgbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExl
byBMaSA8bGVveWFuZy5saUBueHAuY29tPjsga2lzaG9uQHRpLmNvbTsgbG9yZW56by5waWVyYWxp
c2lAYXJtLmNvbTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IE0uaC4gTGlhbiA8bWluZ2h1
YW4ubGlhbkBueHAuY29tPjsgTWluZ2thaSBIdSA8bWluZ2thaS5odUBueHAuY29tPjsgUm95IFph
bmcgPHJveS56YW5nQG54cC5jb20+OyBrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyBjeXJp
bGxlLnBpdGNoZW5AZnJlZS1lbGVjdHJvbnMuY29tOyBwb21icmVkYW5uZUBuZXhiLmNvbTsgc2hh
d24ubGluQHJvY2stY2hpcHMuY29tOyBuaWtsYXMuY2Fzc2VsQGF4aXMuY29tOyBsaW51eC1wY2lA
dmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCAzLzZdIFBD
STogbGF5ZXJzY2FwZTogQWRkIHRoZSBFUCBtb2RlIHN1cHBvcnQNCg0KT24gMTAvMjYvMTgsIFhp
YW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPiB3cm90ZToNCj4gRnJvbTogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4NCj4+IE9uIFRodSwgT2N0IDI1LCAyMDE4IGF0IDA3OjA4OjU4
UE0gKzA4MDAsIFhpYW93ZWkgQmFvIHdyb3RlOg0KPj4+ICAgICAgICAgICJmc2wsbHMyMDgwYS1w
Y2llIiwgImZzbCxsczIwODVhLXBjaWUiLCAic25wcyxkdy1wY2llIg0KPj4+ICAgICAgICAgICJm
c2wsbHMyMDg4YS1wY2llIg0KPj4+ICAgICAgICAgICJmc2wsbHMxMDg4YS1wY2llIg0KPj4+ICAg
ICAgICAgICJmc2wsbHMxMDQ2YS1wY2llIg0KPj4+ICAgICAgICAgICJmc2wsbHMxMDEyYS1wY2ll
DQo+Pj4gKyAgRVAgbW9kZToNCj4+PiArICAgICAgICAiZnNsLGxzLXBjaWUtZXAiDQo+Pg0KPiA+
IFlvdSBuZWVkIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlcyBmb3IgdGhlIHNhbWUgcmVhc29ucyBh
cyB0aGUgUkMuDQo+DQo+IFtYaWFvd2VpIEJhb10gSSB3YW50IHRvIGNvbnRhaW5zIGFsbCBsYXll
cnNjYXBlIHBsYXRmb3JtIHVzZSBvbmUgDQo+IGNvbXBhdGlibGUgaWYgdGhlIFBDSWUgY29udHJv
bGxlciB3b3JrIGluIEVQIG1vZGUuDQoNCkRvIHlvdSBtZWFuIG9ubHkgb25lIG9mIHRoZSBTb0Nz
IHRoYXQgc3VwcG9ydCBSQyBtb2RlIGhhcyBFUCBtb2RlPw0KSSB0aGluayB5b3Ugc3RpbGwgbmVl
ZCBhIFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlIGFzIFJvYiBleHBsYWluZWQsIGluIGNhc2UgdGhl
cmUgd2lsbCBiZSBhIHNlY29uZCBvbmUgaW4gdGhlIGZ1dHVyZS4NCg0KSWYgeW91IHdhbnQgdG8g
ZW5zdXJlIHRoYXQgeW91IGRvbid0IGhhdmUgdG8gdXBkYXRlIHRoZSBkZXZpY2UgZHJpdmVyIGZv
ciBlYWNoIG5ldyBjaGlwIHRoYXQgY29tZXMgaW4gd2hlbiB0aGUgRVAgbW9kZSBpcyBjb21wYXRp
YmxlLCB0aGUgd2F5IHRoaXMgaXMgaGFuZGxlZCBpcyB0byBsaXN0IG11bHRpcGxlIHZhbHVlcyBp
biB0aGUgY29tcGF0aWJsZSBwcm9wZXJ0eSwgbGlzdGluZyB0aGUgZmlyc3QgU29DIHRoYXQgaW50
cm9kdWNlZCB0aGUgc3BlY2lmaWMgdmVyc2lvbiBvZiB0aGF0IElQIGJsb2NrIGFzIHRoZSBtb3N0
IGdlbmVyaWMgdHlwZSwgZS5nLg0KDQogIGNvcGF0aWJsZSA9ICJmc2wsbHMyMDg4YS1wY2llLWVw
IiwgImZzbCxsczEwMTJhLXBjaWUtZXAiLCAic25wcyxkdy1wY2llLWVwIjsNCg0KRm9yIGNvbnNp
c3RlbmN5LCBpdCBwcm9iYWJseSBpcyBiZXN0IHRvIG1hdGNoIGVhY2ggUkMgbW9kZSB2YWx1ZSB3
aXRoIHRoZSBjb3JyZXNwb25kaW5nIEVQIG1vZGUgc3RyaW5nIGZvciBlYWNoIGRldmljZSB0aGF0
IGNhbiBzdXBwb3J0IGJvdGggKGlmIHRoZXJlIGlzIG1vcmUgdGhhbiBvbmUpLg0KDQogICAgICBB
cm5kDQpbWGlhb3dlaSBCYW9dIE15IG1lYW4gaXMgdGhhdCB0aGUgbHMtcGNpZS1lcCBjb21wYXRp
YmxlcyB3aWxsIGNvbnRhaW4gYWxsIGxheWVyc2NhcGUgU09DcyBvZiBOWFAsIGUuZzogbHMxMDQ2
YS1wY2llLWVwLCBmc2wsbHMyMDg4YS1wY2llLWVwLCBsczIwODhhLXBjaWUtZXAgYW5kIHNvIG9u
LCBvdGhlciBsYXllcnNjYXBlIFNPQ3MgaGF2ZSBub3QgdGVzdCBleGNlcHQgdGhlIGxzMTA0NmEs
IEkgdGhpbmsgaXQgaXMgY29tcGF0aWJsZSBpZiB0aGUgbmV3IGNoaXAgb3Igb3RoZXIgU09DcyB1
c2UgdGhlIERXIGNvcmUsIE9LLCBJIHdpbGwgZGlzY3VzcyB0aGlzIGlzc3VlIGludGVybmFsbHks
IGFuZCByZXBseSB0byB5b3UgbGF0ZXIuDQo=
