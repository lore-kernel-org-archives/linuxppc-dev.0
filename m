Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F46BECDE44
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 02:42:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99DAD2082E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 02:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CJoVYZa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99DAD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gWcq3FQmzDrSM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 13:42:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CJoVYZa1";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.5.40; helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=andy.tang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="CJoVYZa1"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50040.outbound.protection.outlook.com [40.107.5.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gWZ23drYzDrQ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 13:40:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAF7/n0RI2icJQfCrd0fz5IdWiB0LN4fGZ6Bs/NzDpk=;
 b=CJoVYZa1o+z66pWGjl5u1gEokXwVcNTxoGQ2JlsXKnZV138tNDx5S8/2ZS4uIP/55FFcGrXJUwgnfxrvxQz5/E+zdp4hy/kjuOsfJ0Ug5k7FfoKY3GbhA7Kpa4+/ShUZ9WFYEC7njMINyW96albflaL5xUsONy96XxzuFgFDROw=
Received: from DB5PR0401MB2213.eurprd04.prod.outlook.com (10.166.173.8) by
 DB5PR0401MB1974.eurprd04.prod.outlook.com (10.166.11.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Thu, 25 Oct 2018 02:40:03 +0000
Received: from DB5PR0401MB2213.eurprd04.prod.outlook.com
 ([fe80::24b9:d390:896d:12f7]) by DB5PR0401MB2213.eurprd04.prod.outlook.com
 ([fe80::24b9:d390:896d:12f7%3]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 02:40:03 +0000
From: Andy Tang <andy.tang@nxp.com>
To: Scott Wood <oss@buserror.net>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: RE: [PATCH 3/3 v2] clk: qoriq: update clock driver
Thread-Topic: [PATCH 3/3 v2] clk: qoriq: update clock driver
Thread-Index: AQHUaz91rAvZ3hIhuUadd0OG4Kor6KUuurwAgACGasA=
Date: Thu, 25 Oct 2018 02:40:03 +0000
Message-ID: <DB5PR0401MB22130B915A5690E9BC56CCE5F3F70@DB5PR0401MB2213.eurprd04.prod.outlook.com>
References: <20181024021122.3942-1-andy.tang@nxp.com>
 <20181024021122.3942-2-andy.tang@nxp.com>
 <20181024021122.3942-3-andy.tang@nxp.com>
 <d4598171243a37516faae71095eb3126d77fa723.camel@buserror.net>
In-Reply-To: <d4598171243a37516faae71095eb3126d77fa723.camel@buserror.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB5PR0401MB1974;
 6:uLfYMWxpXlz7BZyGide5NsNiK6dkxabIOfM3ZD8EzGVe9blunHZ1s5Y5T7gHkEK2gjTPfTGgYLFkxcFlOZsgr6jXUGyWGcoDm9JgVnOgDrmPrBQq2rkMzUTO4HMzFvZGrGRR6mUBUhL4274zWDL9x/oBL5QLArrItcxZyGUr08RUO3VGlU3UoE0UbdCymHy26duHj88vM4O8QctAxzTJvo9NuGprS7l8E13DKXjln1t0B1m+KwGcf6yansxA6LlJafmIMpwoHNrr/EPOcqRaCf8T3Lbp5F/ELUi5alZcx5UgUM9FB2sAS8l6jo5PL0FXolX1h+/qYL1TNni8nt/QWWMHAj8JYuck6hyG+5lNj6CDuXfhT9+i19AeznlNlVncnxwBALMryAeSBdLRqfUnvueWNCeRgzGbCHrsBlffKmGRBiRS60r+j2oNF7FrolGQE+qmvXHatf8PDEJE97ecHw==;
 5:veIlzEYsaIDP9tG0zcHVvTqbkOA5UoD7h3K5rHW3C5Yr/BKm7MKL/vSd62nJs7AHQ0DFkXkbhY9m6MUe112Ewr8vE0uTBJIHFVXNt20ZKvinM3rVI8PyB0gl6tobE33xJl0azo1y4reV7m+q8UNZigDHy9fAQJxXuoeuWluVR2s=;
 7:DClgI8R/cHryi58XSDwUR9cBbKUmLYG1/hQE/9XMNHNn4CIOTufLxD9pBW0Po09x5Dn7TPSX8bJr8gLXYfXrHXAdXloh9mACyt6uoq71slsldC7tYWikf4UxjotiKxjPdbGGF2Bql6dkFxr4TCqYHg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 093ebe22-032d-44c0-2885-08d63a232aad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB5PR0401MB1974; 
x-ms-traffictypediagnostic: DB5PR0401MB1974:
x-microsoft-antispam-prvs: <DB5PR0401MB19744DF3A03FAFB825133A77F3F70@DB5PR0401MB1974.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:DB5PR0401MB1974; BCL:0; PCL:0; RULEID:; SRVR:DB5PR0401MB1974; 
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(136003)(366004)(346002)(396003)(189003)(199004)(13464003)(14444005)(2501003)(66066001)(7416002)(74316002)(2906002)(71200400001)(305945005)(256004)(478600001)(7736002)(71190400001)(229853002)(6116002)(3846002)(110136005)(54906003)(316002)(93886005)(106356001)(44832011)(7696005)(4326008)(81166006)(8936002)(99286004)(81156014)(76176011)(446003)(11346002)(68736007)(5660300001)(2900100001)(476003)(486006)(25786009)(33656002)(97736004)(4001150100001)(15650500001)(186003)(2201001)(86362001)(102836004)(53546011)(8676002)(105586002)(6506007)(6436002)(26005)(6246003)(5250100002)(55016002)(53936002)(9686003)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB5PR0401MB1974;
 H:DB5PR0401MB2213.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g9rwvZFtoN2m5sl5l/6I7Eh2BXMT8g+SjsQdcHlqyjj1+ykWAkF1XNZuVIzC8199tAuN0fl2utdP7uXtzIiu6C5NDHGEjbTHuC2UGip70nsFkl5fUoGCIPD1Q6xO7UZEcaNswxbfHj+HWlInVTEK4jd+i4WFZ9DkGBkJKjLwXVz+4yijdqyDZktoWo6sQESAFu1tR/7lRo/cIAy4PgGIS+/m2e9RGlbBMo3yFQDXYXMGTJSs+NNJiPT0t8Its0tP2lMxaw7xQAtgvZRW84u9HrXjra3+2BR7KkXF2c0WmQ8uEfSad9dau8eRxzK42Fz20qk/LdfbmVOmCzGrR1ZQopKeguwJ/YEhXMfDRsq6p+k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093ebe22-032d-44c0-2885-08d63a232aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 02:40:03.3290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR0401MB1974
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNjb3R0IFdvb2QgPG9zc0Bi
dXNlcnJvci5uZXQ+DQo+IFNlbnQ6IDIwMTjlubQxMOaciDI15pelIDI6MzcNCj4gVG86IEFuZHkg
VGFuZyA8YW5keS50YW5nQG54cC5jb20+OyBzYm95ZEBrZXJuZWwub3JnOw0KPiBtdHVycXVldHRl
QGJheWxpYnJlLmNvbQ0KPiBDYzogcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJt
LmNvbTsNCj4gYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBwYXVsdXNAc2FtYmEub3JnOyBtcGVA
ZWxsZXJtYW4uaWQuYXU7DQo+IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eHBw
Yy1kZXZAbGlzdHMub3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvMyB2Ml0gY2xr
OiBxb3JpcTogdXBkYXRlIGNsb2NrIGRyaXZlcg0KPiANCj4gT24gV2VkLCAyMDE4LTEwLTI0IGF0
IDEwOjExICswODAwLCBhbmR5LnRhbmdAbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBZdWFudGlh
biBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4gPg0KPiA+IExlZ2FjeSBiaW5kaW5ncyBhcmUg
ZGVsZXRlZC4gU28gdGhlIGxlZ2FjeSBzdXBwb3J0IGluIGRyaXZlciBjYW4gYmUNCj4gPiBkZWxl
dGVkIHNhZmVseS4NCj4gDQo+IE5BQ0sgKGJvdGggdGhpcyBhbmQgMi8zKS4gIFRoZSBsZWdhY3kg
c3VwcG9ydCBpcyBpbnRlbmRlZCB0byBwcmVzZXJ2ZQ0KPiBjb21wYXRpYmlsaXR5LCByZWdhcmRs
ZXNzIG9mIHdoYXQgdGhlIGR0cyBmaWxlcyBpbiB0aGUgY3VycmVudCBrZXJuZWwgdHJlZSBkby4N
Cj4gIElmIHllYXJzIGxhdGVyIHdlIGZpbmQgaXQncyBiZWVuIGJyb2tlbiBmb3IgYSB3aGlsZSBh
bmQgbm9ib2R5IGNvbXBsYWluZWQsDQo+IHRoZW4gbWF5YmUgaXQnbGwgYmUgdGltZSB0byByZW1v
dmUgaXQsIGJ1dCB3aHkgZGVsaWJlcmF0ZWx5IHRocm93IGF3YXkNCj4gY29tcGF0aWJpbGl0eSB0
aGUgaW5zdGFudCB0aGUgdXNlcnMgaGF2ZSBiZWVuIHJlbW92ZWQgZnJvbSByZWZlcmVuY2UNCj4g
RFRzIHRoYXQgbWlnaHQgYmUgY29waWVkIGJ5IGJvYXJkIHZlbmRvcnMsIGV0Yz8NCj4gDQo+IE5v
dGUgdGhhdCBldmVuIGlmIHdlIGRpZG4ndCBjYXJlIGFib3V0IGxvbmctdGVybSBjb21wYXRpYmls
aXR5IGF0IGFsbCwNCj4gcmVtb3ZpbmcgdGhlIHN1cHBvcnQgaW4gdGhlIHNhbWUgcGF0Y2hzZXQg
YXMgdGhlIGNoYW5nZSB0byB0aGUgZHRzIGZpbGVzDQo+IG1lYW5zIHRoYXQgdGhlIHBhdGNoZXMg
Y2FuJ3QgZ28gaW4gdmlhIHNlcGFyYXRlIHRyZWVzICh0aG91Z2ggaWYgdGhhdCdzIHN0aWxsDQo+
IHRoZSBpbnRlbnQsIHlvdSBzaG91bGQgbWFrZSBpdCBjbGVhciB3aG8geW91J3JlIGFza2luZyB0
byB0YWtlIHdoYXQgYnkNCj4gcHV0dGluZyB0aGVtIGluIHNlcGFyYXRlIHBhdGNoc2V0cykuDQoN
ClBvaW50cyBhcmUgdGFrZW4uIFdpbGwgdXBkYXRlIHRoaXMgcGF0Y2ggc2V0LiBUaGFua3MgYSBs
b3QuDQoNCkJSLA0KQW5keQ0KPiANCj4gLVNjb3R0DQoNCg==
