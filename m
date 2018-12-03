Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6ABC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 04:13:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E90206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 04:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U8eUTUaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E90206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437Wns1BK8zDqJQ
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 15:13:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="U8eUTUaa";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.14.41; helo=eur01-ve1-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="U8eUTUaa"; 
 dkim-atps=neutral
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140041.outbound.protection.outlook.com [40.107.14.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437Wk35YFkzDqY0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Dec 2018 15:10:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VF/JJr10I6dCNqztlApa1rHKPuQQ/0zr3cOFx4vrXs=;
 b=U8eUTUaa9CVrnSCgTX25qen3AlbiqxzNjD7JDxWZNmo5y0N8szSn8tFjgPHu0VKHubFFWtjypwSE+uaXMa3ZrbGDPCAZ5NT6mhMOIH5gop0o4mIboIouOh71jQ+cCJS/G06czlV6bcuBtXStuHIVC2mxkJM+VTfEzIrC3VuqDyc=
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com (10.163.176.23) by
 HE1PR04MB2092.eurprd04.prod.outlook.com (10.166.67.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 04:10:12 +0000
Received: from HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::dc32:150f:5344:715]) by HE1PR04MB1497.eurprd04.prod.outlook.com
 ([fe80::dc32:150f:5344:715%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 04:10:12 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCHv2 3/6] PCI: layerscape: Add the EP mode support
Thread-Topic: [PATCHv2 3/6] PCI: layerscape: Add the EP mode support
Thread-Index: AQHUdOS7xREHtKuFEEy03v3yUiY2kaVoTIwAgARFSNA=
Date: Mon, 3 Dec 2018 04:10:12 +0000
Message-ID: <HE1PR04MB1497E4A26E7902E5EAB15D36F5AE0@HE1PR04MB1497.eurprd04.prod.outlook.com>
References: <20181105084653.26597-1-xiaowei.bao@nxp.com>
 <20181105084653.26597-3-xiaowei.bao@nxp.com>
 <20181130105512.GB17598@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181130105512.GB17598@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR04MB2092;
 6:4ieG2ja+zPmg3jfM97MYeH5+jEXF7S1ieBxTyhHvsMP8O+NXawLzZc4vy4UKfkE8RqvKUXqA/JKOXs9VlS91rTGz0pnhKmj2rkks7QShrwSG0w43an0IC3vG2HW8Mgm6YuOoJfGLVgbuhLZO2wp7ZPnwwlDf9d3/+AB76MzYa6VNPEtRDAyX0AOT0erLgjt1aThF2n8Faby0ULQpz2guPAoI0XrwqmTrY5isMaMev3TCNWk9hGqgeSM02TclBcgKCDwquIMzCxqSWw4fQhy5IhnHuvtjWT9M6A0gl35Ki+D+9Qtokx5hhHNmmjTrWm5JBmIjOQNYhIVExQXME/WUwcFgeymBj1rt7M18jLeFia2J2zO4vd1guGJwvTSYpCK9BsXInM3ca7qPzUyFcRFmecOZ/XWACFyIAeba17/HTujLsBnXjvQWnr0zAl9wiqSYtszHn9VrjHo9qbNL3lfIYw==;
 5:Kjpoo2wriJDbt33/EUeA2xl86GpQBjtLke6gUOgipRV40BMRaGHJKZgCntnjGwsrZYpdlOIu0rXzd+Pk5BqBJJaDtsoy0jmQpWbkzOKU6WzYvWT0bN7TlWHuk51JCi1nHr/QmgLeEwqv47FbnP7yU8FG48mUVNBSqZ0E2MbAW4Q=;
 7:65AZYObMIiHN9Uji7IRc9B/0Jgrdzd6MqOfJi2fBtJt5U92hXkGKAUv2dbeKXh17p0SGXDoPgF51chHUa6c1/9VEwSvDL54A6+GTNATiO5hIbSIwL57LVyeWyP2Fr1amM9V+NX9SLvvYo9l58WOMDw==
x-ms-office365-filtering-correlation-id: 6f451ce7-201f-4fd9-a68a-08d658d538f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB2092; 
x-ms-traffictypediagnostic: HE1PR04MB2092:
x-microsoft-antispam-prvs: <HE1PR04MB2092E4B59D879837AC572FA5F5AE0@HE1PR04MB2092.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR04MB2092; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB2092; 
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(136003)(346002)(39860400002)(366004)(376002)(13464003)(199004)(189003)(106356001)(25786009)(6916009)(478600001)(229853002)(68736007)(81166006)(105586002)(81156014)(71200400001)(71190400001)(8936002)(74316002)(2906002)(5660300001)(4326008)(186003)(7416002)(26005)(6506007)(53546011)(102836004)(6116002)(7696005)(6246003)(76176011)(3846002)(33656002)(6436002)(476003)(55016002)(54906003)(446003)(14454004)(11346002)(53936002)(99286004)(97736004)(486006)(256004)(14444005)(316002)(8676002)(305945005)(66066001)(9686003)(7736002)(44832011)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB2092;
 H:HE1PR04MB1497.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 777hPKlyW73gVRvMPkFUesGwGaOd3s81KUR2T1T6OVM+q//ij0pO8H0zEbWEMmv4Yl4EQd9wUEz0wCV6cJdNYkWSjURLbposu4Esw95Q2QDpohvVBqI7+P4IfGwCC+7etvi8Gui/9ebn+edTbwANTUo3+IIO3/+XpQxKHObwBXOgMezHW30kxH7sfGtowVp/WC/jRFs/eWSti12FQNjYHVTJg0ZjtVMnswkrke9m7ob/BKPSah7Mr4RKPWc+Uzp9gSBzKSgtLlJ1cOS1/aQQAR9ZAPMJhkrwMou+WKUbMd75+1RstwFlJMCAk/OHKQ8YbQdwnhkOZsCf5RJEe+QhICNjRWwpYR0/Go1yBVFo/dQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f451ce7-201f-4fd9-a68a-08d658d538f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 04:10:12.3884 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2092
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
 "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kishon@ti.com" <kishon@ti.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "pombredanne@nexb.com" <pombredanne@nexb.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
 Mingkai Hu <mingkai.hu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgTG9yZW56bywNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExvcmVuem8g
UGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPiANClNlbnQ6IDIwMTjE6jEx1MIz
MMjVIDE4OjU1DQpUbzogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQpDYzogYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNv
bTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBraXNo
b25AdGkuY29tOyBhcm5kQGFybmRiLmRlOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgTS5o
LiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5jb20+OyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54
cC5jb20+OyBSb3kgWmFuZyA8cm95LnphbmdAbnhwLmNvbT47IGtzdGV3YXJ0QGxpbnV4Zm91bmRh
dGlvbi5vcmc7IGN5cmlsbGUucGl0Y2hlbkBmcmVlLWVsZWN0cm9ucy5jb207IHBvbWJyZWRhbm5l
QG5leGIuY29tOyBzaGF3bi5saW5Acm9jay1jaGlwcy5jb207IG5pa2xhcy5jYXNzZWxAYXhpcy5j
b207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQpTdWJqZWN0OiBSZTog
W1BBVENIdjIgMy82XSBQQ0k6IGxheWVyc2NhcGU6IEFkZCB0aGUgRVAgbW9kZSBzdXBwb3J0DQoN
Ck9uIE1vbiwgTm92IDA1LCAyMDE4IGF0IDA0OjQ2OjUwUE0gKzA4MDAsIFhpYW93ZWkgQmFvIHdy
b3RlOg0KPiBBZGQgdGhlIEVQIG1vZGUgc3VwcG9ydC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFhp
YW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiAtLS0NCj4gdjI6DQo+ICAtIEFkZCB0
aGUgU29DIHNwZWNpZmljIGNvbXBhdGlibGVzLg0KPiANCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9sYXllcnNjYXBlLXBjaS50eHQgICAgIHwgICAgMyArKysNCj4gIDEgZmlsZXMgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQ0KDQpXcm9uZyBjb21taXQgJFNV
QkpFQ1QsIHRoaXMgaXMgbm90IFBDSSBjb2RlLCBpdCBpcyBhIERUIGJpbmRpbmcgdXBkYXRlLCBJ
IHdpbGwgaGF2ZSBhIGxvb2sgYXQgdGhlIHJlc3Qgb2YgdGhlIHNlcmllcyB0byBzZWUgaWYgSSBj
YW4gdXBkYXRlIHRoaXMgcGF0Y2ggb3IgeW91IHdpbGwgZG8gaXQgd2l0aCB0aGUgbmV4dCByZXNw
aW4uDQoNCkxvcmVuem8NCltYaWFvd2VpIEJhb10gSEkgTG9yZW56bywgdGhhbmtzIGEgbG90LCBJ
IHdpbGwgc2VuZCBWMyBwYXRjaCB0byBtb2RpZnkgdGhlIGNvbW1pdHMuIA0KDQo+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNp
LnR4dCANCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2Nh
cGUtcGNpLnR4dA0KPiBpbmRleCA2NmRmMWU4Li45YzA5MGM3IDEwMDY0NA0KPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpLnR4dA0KPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNp
LnR4dA0KPiBAQCAtMTMsMTIgKzEzLDE1IEBAIGluZm9ybWF0aW9uLg0KPiAgDQo+ICBSZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KPiAgLSBjb21wYXRpYmxlOiBzaG91bGQgY29udGFpbiB0aGUgcGxhdGZv
cm0gaWRlbnRpZmllciBzdWNoIGFzOg0KPiArICBSQyBtb2RlOg0KPiAgICAgICAgICAiZnNsLGxz
MTAyMWEtcGNpZSIsICJzbnBzLGR3LXBjaWUiDQo+ICAgICAgICAgICJmc2wsbHMyMDgwYS1wY2ll
IiwgImZzbCxsczIwODVhLXBjaWUiLCAic25wcyxkdy1wY2llIg0KPiAgICAgICAgICAiZnNsLGxz
MjA4OGEtcGNpZSINCj4gICAgICAgICAgImZzbCxsczEwODhhLXBjaWUiDQo+ICAgICAgICAgICJm
c2wsbHMxMDQ2YS1wY2llIg0KPiAgICAgICAgICAiZnNsLGxzMTAxMmEtcGNpZSINCj4gKyAgRVAg
bW9kZToNCj4gKyAgICAgICAgImZzbCxsczEwNDZhLXBjaWUtZXAiLCAiZnNsLGxzLXBjaWUtZXAi
DQo+ICAtIHJlZzogYmFzZSBhZGRyZXNzZXMgYW5kIGxlbmd0aHMgb2YgdGhlIFBDSWUgY29udHJv
bGxlciByZWdpc3RlciBibG9ja3MuDQo+ICAtIGludGVycnVwdHM6IEEgbGlzdCBvZiBpbnRlcnJ1
cHQgb3V0cHV0cyBvZiB0aGUgY29udHJvbGxlci4gTXVzdCBjb250YWluIGFuDQo+ICAgIGVudHJ5
IGZvciBlYWNoIGVudHJ5IGluIHRoZSBpbnRlcnJ1cHQtbmFtZXMgcHJvcGVydHkuDQo+IC0tDQo+
IDEuNy4xDQo+IA0K
