Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388D2C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 12:32:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9EFC2089C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 12:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gDEoi/8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EFC2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42P1r94zLwzF342
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:32:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gDEoi/8J";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.4.53; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=vabhav.sharma@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="gDEoi/8J"; 
 dkim-atps=neutral
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40053.outbound.protection.outlook.com [40.107.4.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42P1jY0m2czF35X
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 22:26:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYUUuWyuiKKkMu/iZvJXCK6OWYB9QwKus1nE5N7vBMQ=;
 b=gDEoi/8JzrVsD1SDHHywNukFuWaBoEicIdgYgnxFxMGU69xAblUr7CO6uCquhdA0m5HLpTZBAEsqejSPe0gF1+rylu6K9zC7F2tm0+VmM83/+ITok83QTDqO9ULLafkL5y62SfxZ5yj3Ra0i5nHMlDOCnSSOrHQVpVIuQviZarI=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB4575.eurprd04.prod.outlook.com (20.177.55.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.22; Mon, 1 Oct 2018 12:26:18 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::111d:ad01:20b5:c57d]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::111d:ad01:20b5:c57d%2]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 12:26:18 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH v3 6/6] arm64: dts: add LX2160ARDB board support
Thread-Topic: [PATCH v3 6/6] arm64: dts: add LX2160ARDB board support
Thread-Index: AQHUVAAtFAT2gn5ndkevnoKbCG0aMqUGHVGAgAQ+GPA=
Date: Mon, 1 Oct 2018 12:26:18 +0000
Message-ID: <VI1PR04MB4800B14CE54CD5F45C4B3687F3EF0@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
 <1537747741-6245-7-git-send-email-vabhav.sharma@nxp.com>
 <CADRPPNS1Zj=47M-yOBAJ=X=sjjxmh0k7tNcj1A8uY=cPM398tQ@mail.gmail.com>
In-Reply-To: <CADRPPNS1Zj=47M-yOBAJ=X=sjjxmh0k7tNcj1A8uY=cPM398tQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [139.167.16.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB4575;
 6:fTbFT2aoHjkNdiQOXWXvabq5BYLXPjTJnKojZAdu8QIjweM2HkzUpcPqDeLqdWjQbRF5Qd9C1ipFWH51ChnBy1XGoehdzu02Ht1+FYBcMKkjz2b0aTP878dIgnbSx1y6xfF/H79TxskY43BD/Pj0SaerKYmaguucJbMyIvKFS6Q1VpGcny2dbPtF+MRMBNmC9FZ9V+qWdcXvoAKlAQMro2nDvLn1TtOaxAuuOK+l8fd99tVkE4Ruts7PUE8oRniE2hgOJMh+2I6u4ohp55KoXmliBxVrYn1JpTzntHdOrtpRnMhNpzS1enB20vAebVTra04MqAVrkTsNoCN+Td8a1RBUlaXtvdYHRe26w1NloR3pfVlAbU3aN5gXrvM2kHX14vzb2gueDkSD7UqY/bW+918GvczN6QEXp0NzyfiQVYlq96H70V8nH0Lh5tX5uRe2FiQZaOjMwPnlCeWWe/5jlg==;
 5:pcZytp+f2CkSvx7fUtpNRYGa0n8pKlmR7nvkd/67AQ7+qnED1eZRy1XL8WQTlRWM3Xn/RZSCf+Rpf0wW4bl8Pvzywe7LWfKNAWamXAQcEAT1M69LnTZHdDPN+4pwVEECBB1SurjvTWuKoNbv1YJALpVxwnMQ2n5LMh10LIfiGE8=;
 7:OLoPk305hpRwbnBfot68hRCHMYvsrYPIeq9jUrE12dPQDzprF8LVWhH7DKeMI1UhqdXyLSpnfwrZ57LOJov6K+DfvGutjc0071+vBc+LcHgLTzGYPPCVncN3X+2DQeIzwgCFzI3cTPQyF20SwlaILDJEw3AvG8s0b2O27OAXALGw/B5Nt2+QBPgUzYF97d6mvCnkPpnuHQd3xblnwSMhuQi5QwLEJ49PCO+CHrx3ko5HCKxhyjk8ZG/MPvqADuyZ
x-ms-office365-filtering-correlation-id: d30b082f-5812-4080-160d-08d6279916a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB4575; 
x-ms-traffictypediagnostic: VI1PR04MB4575:
x-microsoft-antispam-prvs: <VI1PR04MB4575C514585A98259AAA643DF3EF0@VI1PR04MB4575.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(180628864354917)(65623756079841)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051);
 SRVR:VI1PR04MB4575; BCL:0; PCL:0; RULEID:; SRVR:VI1PR04MB4575; 
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(39860400002)(346002)(396003)(376002)(189003)(13464003)(199004)(9686003)(5660300001)(3846002)(2906002)(6436002)(55016002)(53936002)(229853002)(6116002)(44832011)(71200400001)(71190400001)(33656002)(316002)(6636002)(2900100001)(256004)(446003)(476003)(11346002)(34290500001)(81166006)(81156014)(8676002)(7416002)(7696005)(106356001)(8936002)(486006)(105586002)(5250100002)(53546011)(99286004)(86362001)(54906003)(68736007)(76176011)(6506007)(478600001)(6246003)(25786009)(6862004)(66066001)(74316002)(26005)(97736004)(14454004)(4326008)(7736002)(102836004)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB4575;
 H:VI1PR04MB4800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XzhkFQgxF3gYge8EBBPrylsKRLl4im2TfkFKOT7y02Y6a8kJ1RLYhVdteKivrPN6NSRgPlrV8coT4a4QK8TO7SsI73oFZXhQgyoxdCGoNKXoNdY4tOBne30a1tb21WNB/7Y6A9pFVQSJuY2bgx0wgHwSRowOFQwPDZg0CsCScD8hnawJqHOwu1a0WMgnEoxtmSFsnRgaYDrrCI9njrMFHPt81Aj/IrjekGJ4l3TUxfrH5pwoDfvMCplqCx+bGvC8Y3dCa1ONXCZFHV6UF31q72GWt9+qJy5afJ5TJmbsrDU33wXajZCff86J2U6oVjgLyVJKEKcb2Rmq/iMaH2xp+FGkt+88EE+FgNSlF8osVnQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30b082f-5812-4080-160d-08d6279916a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 12:26:18.1913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4575
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 "linux-kernel-owner@vger.kernel.org" <linux-kernel-owner@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Michael Turquette <mturquette@baylibre.com>, Will Deacon <will.deacon@arm.com>,
 "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
 Sriram Dash <sriram.dash@nxp.com>, linux-clk <linux-clk@vger.kernel.org>,
 Udit Kumar <udit.kumar@nxp.com>, Russell King <linux@armlinux.org.uk>,
 Priyanka Jain <priyanka.jain@nxp.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Scott Wood <oss@buserror.net>, Rob Herring <robh+dt@kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZGV2aWNldHJlZS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgPGRldmljZXRyZWUtb3duZXJAdmdlci5rZXJuZWwub3JnPg0KPiBP
biBCZWhhbGYgT2YgTGkgWWFuZw0KPiBTZW50OiBTYXR1cmRheSwgU2VwdGVtYmVyIDI5LCAyMDE4
IDE6MDcgQU0NCj4gVG86IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhwLmNvbT4NCj4g
Q2M6IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxhQGFybS5jb20+OyBTY290dCBXb29kIDxvc3NA
YnVzZXJyb3IubmV0PjsNCj4gbGttbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IG9w
ZW4gbGlzdDpPUEVOIEZJUk1XQVJFIEFORA0KPiBGTEFUVEVORUQgREVWSUNFIFRSRUUgQklORElO
R1MgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRA
a2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBsaW51eHBw
Yy1kZXYNCj4gPGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPjsgbW9kZXJhdGVkIGxpc3Q6
QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMNCj4gQVJNIEFSQ0hJVEVDVFVSRSA8bGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgTWljaGFlbCBUdXJxdWV0dGUNCj4gPG10dXJxdWV0
dGVAYmF5bGlicmUuY29tPjsgc2JveWRAa2VybmVsLm9yZzsgUmFmYWVsIEouIFd5c29ja2kNCj4g
PHJqd0Byand5c29ja2kubmV0PjsgVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9y
Zz47IGxpbnV4LWNsayA8bGludXgtDQo+IGNsa0B2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1wbUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbC0NCj4gb3duZXJAdmdlci5rZXJuZWwub3JnOyBD
YXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPjsgV2lsbA0KPiBEZWFjb24g
PHdpbGwuZGVhY29uQGFybS5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPjsgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IEthdGUNCj4g
U3Rld2FydCA8a3N0ZXdhcnRAbGludXhmb3VuZGF0aW9uLm9yZz47IHlhbWFkYS5tYXNhaGlyb0Bz
b2Npb25leHQuY29tOw0KPiBVZGl0IEt1bWFyIDx1ZGl0Lmt1bWFyQG54cC5jb20+OyBQcml5YW5r
YSBKYWluIDxwcml5YW5rYS5qYWluQG54cC5jb20+Ow0KPiBSdXNzZWxsIEtpbmcgPGxpbnV4QGFy
bWxpbnV4Lm9yZy51az47IFZhcnVuIFNldGhpIDxWLlNldGhpQG54cC5jb20+OyBTcmlyYW0NCj4g
RGFzaCA8c3JpcmFtLmRhc2hAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyA2LzZd
IGFybTY0OiBkdHM6IGFkZCBMWDIxNjBBUkRCIGJvYXJkIHN1cHBvcnQNCj4gDQo+IE9uIE1vbiwg
U2VwIDI0LCAyMDE4IGF0IDc6NTEgQU0gVmFiaGF2IFNoYXJtYSA8dmFiaGF2LnNoYXJtYUBueHAu
Y29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IExYMjE2MEEgcmVmZXJlbmNlIGRlc2lnbiBib2FyZCAo
UkRCKSBpcyBhIGhpZ2gtcGVyZm9ybWFuY2UgY29tcHV0aW5nLA0KPiA+IGV2YWx1YXRpb24sIGFu
ZCBkZXZlbG9wbWVudCBwbGF0Zm9ybSB3aXRoIExYMjE2MEEgU29DLg0KPiANCj4gUGxlYXNlIHNl
bmQgbmV4dCB2ZXJzaW9uIHdpdGggU2hhd24gR3VvIGFuZCBtZSBpbiB0aGUgInRvIiByZWNpcGll
bnQgc28gdGhhdCBpdHMNCj4gbGVzcyBsaWtlbHkgd2Ugd2lsbCBtaXNzIGl0Lg0KTXkgbWlzdGFr
ZSwgTm90IFN1cmUgaG93IGl0J3MgbWlzc2VkLg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFByaXlhbmthIEphaW4gPHByaXlhbmthLmphaW5AbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTcmlyYW0gRGFzaCA8c3JpcmFtLmRhc2hAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBW
YWJoYXYgU2hhcm1hIDx2YWJoYXYuc2hhcm1hQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlICAgICAgICAgICAgfCAgMSArDQo+ID4g
IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMgfCA4OA0K
PiA+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgODkgaW5z
ZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWx4MjE2MGEtcmRiLmR0cw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZQ0KPiA+IGluZGV4IDg2ZTE4YWQuLjQ0NWI3MmIgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvTWFrZWZpbGUNCj4gPiAr
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZQ0KPiA+IEBAIC0xMywz
ICsxMyw0IEBAIGR0Yi0kKENPTkZJR19BUkNIX0xBWUVSU0NBUEUpICs9IGZzbC1sczIwODBhLQ0K
PiByZGIuZHRiDQo+ID4gIGR0Yi0kKENPTkZJR19BUkNIX0xBWUVSU0NBUEUpICs9IGZzbC1sczIw
ODBhLXNpbXUuZHRiDQo+ID4gIGR0Yi0kKENPTkZJR19BUkNIX0xBWUVSU0NBUEUpICs9IGZzbC1s
czIwODhhLXFkcy5kdGINCj4gPiAgZHRiLSQoQ09ORklHX0FSQ0hfTEFZRVJTQ0FQRSkgKz0gZnNs
LWxzMjA4OGEtcmRiLmR0Yg0KPiA+ICtkdGItJChDT05GSUdfQVJDSF9MQVlFUlNDQVBFKSArPSBm
c2wtbHgyMTYwYS1yZGIuZHRiDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAuLjFiYmU2NjMNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtcmRiLmR0cw0KPiA+IEBA
IC0wLDAgKzEsODggQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4w
IE9SIE1JVCkgLy8gLy8gRGV2aWNlIFRyZWUgZmlsZQ0KPiA+ICtmb3IgTFgyMTYwQVJEQiAvLyAv
LyBDb3B5cmlnaHQgMjAxOCBOWFANCj4gPiArDQo+ID4gKy9kdHMtdjEvOw0KPiA+ICsNCj4gPiAr
I2luY2x1ZGUgImZzbC1seDIxNjBhLmR0c2kiDQo+ID4gKw0KPiA+ICsvIHsNCj4gPiArICAgICAg
IG1vZGVsID0gIk5YUCBMYXllcnNjYXBlIExYMjE2MEFSREIiOw0KPiA+ICsgICAgICAgY29tcGF0
aWJsZSA9ICJmc2wsbHgyMTYwYS1yZGIiLCAiZnNsLGx4MjE2MGEiOw0KPiA+ICsNCj4gPiArICAg
ICAgIGNob3NlbiB7DQo+ID4gKyAgICAgICAgICAgICAgIHN0ZG91dC1wYXRoID0gInNlcmlhbDA6
MTE1MjAwbjgiOw0KPiA+ICsgICAgICAgfTsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyZ1YXJ0MCB7
DQo+ID4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmdWFy
dDEgew0KPiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAr
JmkyYzAgew0KPiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICsgICAgICAgaTJjLW11
eEA3NyB7DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibnhwLHBjYTk1NDciOw0K
PiA+ICsgICAgICAgICAgICAgICByZWcgPSA8MHg3Nz47DQo+ID4gKyAgICAgICAgICAgICAgICNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDww
PjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGkyY0AyIHsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZWcg
PSA8MHgyPjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcG93ZXItbW9uaXRv
ckA0MCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
InRpLGluYTIyMCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8
MHg0MD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaHVudC1yZXNpc3Rv
ciA9IDwxMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiA+ICsgICAgICAg
ICAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgaTJjQDMgew0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHJlZyA9IDwweDM+Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB0ZW1w
ZXJhdHVyZS1zZW5zb3JANGMgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJueHAsc2E1NjAwNCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZWcgPSA8MHg0Yz47DQo+IA0KPiBOZWVkIGEgdmNjLXN1cHBseSBwcm9wZXJ0eSBh
Y2NvcmRpbmcgdG8gdGhlIGJpbmRpbmcuDQpPaw0KPiANCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB0ZW1wZXJhdHVyZS1z
ZW5zb3JANGQgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJueHAsc2E1NjAwNCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZWcgPSA8MHg0ZD47DQo+IA0KPiBEaXR0by4NCk9rDQo+IA0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIH07DQo+ID4gKyAgICAgICAgICAgICAgIH07DQo+ID4gKyAgICAgICB9Ow0KPiA+ICt9
Ow0KPiA+ICsNCj4gPiArJmkyYzQgew0KPiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+
ICsNCj4gPiArICAgICAgIHJ0Y0A1MSB7DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAibnhwLHBjZjIxMjkiOw0KPiA+ICsgICAgICAgICAgICAgICByZWcgPSA8MHg1MT47DQo+ID4g
KyAgICAgICAgICAgICAgIC8vIElSUTEwX0INCj4gPiArICAgICAgICAgICAgICAgaW50ZXJydXB0
cyA9IDwwIDE1MCAweDQ+Ow0KPiA+ICsgICAgICAgICAgICAgICB9Ow0KPiA+ICsNCj4gPiArfTsN
Cj4gPiArDQo+ID4gKyZ1c2IwIHsNCj4gPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiAr
fTsNCj4gPiArDQo+ID4gKyZ1c2IxIHsNCj4gPiArICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4g
PiArfTsNCj4gPiArDQo+ID4gKyZjcnlwdG8gew0KPiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXki
Ow0KPiA+ICt9Ow0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0K
