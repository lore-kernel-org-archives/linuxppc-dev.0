Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128A8ECDE46
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 02:44:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA682082E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 02:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LWnHY2KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA682082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gWgM586rzDrTk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 13:44:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="LWnHY2KX";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe09::616;
 helo=eur03-ve1-obe.outbound.protection.outlook.com;
 envelope-from=andy.tang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="LWnHY2KX"; 
 dkim-atps=neutral
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03on0616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe09::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gWbF73dNzDrSg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 13:41:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kk2lotEIWq7oeYwndfb1mhYXEhvqy2TiGAIdhDRyqJM=;
 b=LWnHY2KXKfuFPYefY81hhpetAgIAit6wJ1u2nJu15dXH6wBZgtXJHQaV5cDKJf/7HFJYe098N3GxuvNtWasiXHCvF+rV8+wUqUia1/+shtJuUNM4SshbceFudoQD2gGg5B7Pj1Way9zJbZWEsFG32hA7h/EDnh1ZCSTaJm3d7HM=
Received: from DB5PR0401MB2213.eurprd04.prod.outlook.com (10.166.173.8) by
 DB5PR0401MB1974.eurprd04.prod.outlook.com (10.166.11.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Thu, 25 Oct 2018 02:41:08 +0000
Received: from DB5PR0401MB2213.eurprd04.prod.outlook.com
 ([fe80::24b9:d390:896d:12f7]) by DB5PR0401MB2213.eurprd04.prod.outlook.com
 ([fe80::24b9:d390:896d:12f7%3]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 02:41:08 +0000
From: Andy Tang <andy.tang@nxp.com>
To: Rob Herring <robh@kernel.org>
Subject: RE: [PATCH 2/3 v2] clk: qoriq: remove legacy bindings and add more
 compatibles
Thread-Topic: [PATCH 2/3 v2] clk: qoriq: remove legacy bindings and add more
 compatibles
Thread-Index: AQHUaz9zfmIqfB/QlU6ZOKoagJZjgKUu9kSAgABLZ0A=
Date: Thu, 25 Oct 2018 02:41:07 +0000
Message-ID: <DB5PR0401MB2213F740D94F937BB9470396F3F70@DB5PR0401MB2213.eurprd04.prod.outlook.com>
References: <20181024021122.3942-1-andy.tang@nxp.com>
 <20181024021122.3942-2-andy.tang@nxp.com> <20181024221033.GA5876@bogus>
In-Reply-To: <20181024221033.GA5876@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB5PR0401MB1974;
 6:7bVqFF80XbwV9W7Sdhl87twwbiVNq9QCbtIMk+YMRI01v1vR4vOM7NTGAOIzwKvxV6ZtZIbw/1GaKIWAVnXzc/zfb0RQ2GTULrrey/G+z2wgXxXdhtyoZORw22d2SsVRkjgZIpkBXwB8Qa1jOgfYuu5yLCMBJy5y9eISyNEBUOTIypgQxaqr61cK/p0L2wdZEdamz/z4nrhEk4b3LISPYCIewy6KQDLSXhCfjBWqBdan/OSWqhDI+KLNjruldAYONDa5XxqFPBN411z5xhTstGtIweObV+aFkHwSCgxuSNBC4NGgpQBAU9xgaxVUOiNWZkc0A5g8AVOw7S1W1C69HYCfhuj5CHzeadr/JfUnyVknJ9Gl9PZ/J5p9T7CFs8yWwio3x0eysXCyzVEbDoCBAaeCxUO9Z8xf+SepLa48rQuKbdVe0qnai/pgfLzOOdC9qOWzJwI9J9Gl0unDiympVg==;
 5:mNpgOhw6uD9qxdf8S2i5hTtT98AKkUtB1VbA1T/bEAl/1pjDG6dly4wIz1r5sGQW9OaM4E7SjoELZFEnShAwLiBWcdYhYe6VfUayfh0QeJoh5D8J2JnJ4BwAr9yRHqNpVh1aGo/D7WvtnWz2owD0xSk6KCa6p0XVDHeZAIvDjgo=;
 7:g5wmuPIImxJOcHi8lGYE9LFlx5V48X+2uTt83WOwHM1VZtin3p5zBuzy7P2x5NuKiGKzk2DAmeUzMeZiKcuiHK5Ptn9LA+m/sDP7wnNbYkf+l84YnhTp20Itq3rsjJYWilw+kLIOZWEiTPTqRdJoKg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 11906024-f733-41eb-6ebd-08d63a235132
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:DB5PR0401MB1974; 
x-ms-traffictypediagnostic: DB5PR0401MB1974:
x-microsoft-antispam-prvs: <DB5PR0401MB197402A7AC5AF97343ED278FF3F70@DB5PR0401MB1974.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(65623756079841)(185117386973197); 
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:DB5PR0401MB1974; BCL:0; PCL:0; RULEID:; SRVR:DB5PR0401MB1974; 
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(376002)(136003)(366004)(346002)(396003)(189003)(199004)(13464003)(14444005)(66066001)(7416002)(74316002)(2906002)(71200400001)(305945005)(256004)(478600001)(7736002)(71190400001)(229853002)(6116002)(3846002)(54906003)(316002)(106356001)(44832011)(7696005)(4326008)(81166006)(8936002)(99286004)(81156014)(76176011)(446003)(11346002)(68736007)(5660300001)(2900100001)(476003)(486006)(25786009)(33656002)(97736004)(186003)(86362001)(102836004)(53546011)(8676002)(105586002)(6506007)(6436002)(26005)(6246003)(5250100002)(55016002)(53936002)(9686003)(6916009)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB5PR0401MB1974;
 H:DB5PR0401MB2213.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9GHbbo8Qg03cWiytoCzFHdmx6MrDgFVcCXNk8csJWsnWr7D54xCFZH7cSXWw80sRM+fVo/ClmqlXbFMbnzFlmDh8TwjfRON4ibOwwxE0p6WGrVBS0K2+q8DWSVyMsUtcPes+t0n4ouJh5Q4SwG6xv8H0WXSAU9XTPeF+DfCPa5nE2IDi1e7jZUPqNV0xUGdqygXXc+C78cxD7QoTt9NV41Sfa18bL7WFBn6TMTLf3+yiMvaEpob/LJRa6KVRKkwlDMrFg9aNJDjtVg6aOS7eojfkfmfZFEHGIBkRONxLb4vgzkeKy0bCpLmSt6A3fJ6HKO3F4Xzy45wlKrbsDpRIy7zNbIxH+vCF3LJhHXk4vck=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11906024-f733-41eb-6ebd-08d63a235132
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 02:41:07.9092 (UTC)
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
 "sboyd@kernel.org" <sboyd@kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "oss@buserror.net" <oss@buserror.net>, "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDE4xOoxMNTCMjXI1SA2OjExDQo+IFRvOiBBbmR5IFRhbmcg
PGFuZHkudGFuZ0BueHAuY29tPg0KPiBDYzogc2JveWRAa2VybmVsLm9yZzsgbXR1cnF1ZXR0ZUBi
YXlsaWJyZS5jb207IG9zc0BidXNlcnJvci5uZXQ7DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBi
ZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc7IHBhdWx1c0BzYW1iYS5vcmc7DQo+IG1wZUBlbGxlcm1h
bi5pZC5hdTsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4cHBjLWRldkBs
aXN0cy5vemxhYnMub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zIHYyXSBjbGs6IHFvcmlx
OiByZW1vdmUgbGVnYWN5IGJpbmRpbmdzIGFuZCBhZGQNCj4gbW9yZSBjb21wYXRpYmxlcw0KPiAN
Cj4gT24gV2VkLCBPY3QgMjQsIDIwMTggYXQgMTA6MTE6MjFBTSArMDgwMCwgYW5keS50YW5nQG54
cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogWXVhbnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+
DQo+ID4NCj4gPiBUaGUgbmV3IGJpbmRpbmdzIHdpbGwgYmUgdXNlZCwgc28gZGVsZXRlIHRoZSBv
bGQgYmluZGluZ3MuDQo+ID4gQWRkIG1vcmUgU09DIGNvbXBhdGlibGVzIGFzIG5lZWRlZCBhcyB3
ZWxsLg0KPiANCj4gSSdtIGEgYml0IGNvbmZ1c2VkIGJ5IHRoaXMgc2VyaWVzLiBOb3JtYWxseSB5
b3Ugd2FudCB0byB1cGRhdGUgdGhlIGR0cyBmaWxlcw0KPiBmaXJzdCBhbmQgd2FpdCBzb21lIHBl
cmlvZCBvZiB0aW1lIGJlZm9yZSByZW1vdmluZyBkcml2ZXIgc3VwcG9ydCAoYW5kDQo+IGJpbmRp
bmdzKS4NClRoYW5rcywgZ290IHlvdXIgcG9pbnRzLg0KDQpCUiwNCkFuZHkNCj4gDQo+IFJvYg0K
PiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRhbmcgWXVhbnRpYW4gPGFuZHkudGFuZ0BueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+IHYyOg0KPiA+ICAgLSBpbnZvbHZlIG1vcmUgY2hpcHMNCj4gPg0K
PiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9xb3JpcS1jbG9jay50eHQgICAgICB8
ICAxMTINCj4gKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGVzIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgMTA2IGRlbGV0aW9ucygtKQ0K
