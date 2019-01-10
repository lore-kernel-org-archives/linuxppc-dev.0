Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B46FC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 11:48:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A328214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 11:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="Ra4r1egj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A328214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b44l3TWnzDqdx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 22:48:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ysoft.com
 (client-ip=40.107.8.44; helo=eur04-vi1-obe.outbound.protection.outlook.com;
 envelope-from=michal.vokac@ysoft.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ysoft.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=ysoft.com header.i=@ysoft.com header.b="Ra4r1egj"; 
 dkim-atps=neutral
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80044.outbound.protection.outlook.com [40.107.8.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b2fz4H9GzDqVv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 21:44:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaSVGLE/JEm33+ceTG4lJkGrod4b70u9Y+0chgFfqgE=;
 b=Ra4r1egj3jIMTCzyd/icTcuKhKZZVnHsyJReLciJtYFjayydigW7UzHhwmg07o4eTcyxJf5x1ApvKssNYcR+ZUTRj9Pz74oJAnJS8ChaOSRqjxGAO6X9vCCs+8g3eVyuHgpW6cQgsNUWljIourA68bicmL2xlzKJ3NfPh4uuovg=
Received: from DB7PR04MB4810.eurprd04.prod.outlook.com (20.176.233.96) by
 DB7PR04MB4764.eurprd04.prod.outlook.com (20.176.233.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 10:44:03 +0000
Received: from DB7PR04MB4810.eurprd04.prod.outlook.com
 ([fe80::951:9643:746c:47d7]) by DB7PR04MB4810.eurprd04.prod.outlook.com
 ([fe80::951:9643:746c:47d7%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 10:44:03 +0000
From: =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc bindings
 to json-schema
Thread-Topic: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc
 bindings to json-schema
Thread-Index: AQHUi1ACOhyxeXH+pEqKY9pDZzILPqVxAQUAgAFgd4CAAbr0gIA0LGGAgABDWoA=
Date: Thu, 10 Jan 2019 10:44:03 +0000
Message-ID: <dc0ef959-78a0-2a32-c0f9-e8da11e035e6@ysoft.com>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-19-robh@kernel.org> <20181206023140.GZ3987@dragon>
 <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
 <20181208015835.GM3987@dragon> <20190110064256.GA25218@dragon>
In-Reply-To: <20190110064256.GA25218@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::20) To DB7PR04MB4810.eurprd04.prod.outlook.com
 (2603:10a6:10:15::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DB7PR04MB4764;
 6:DQrkdUXjtzB/MH5+dT+7Q2C6DMe5fBK77CYe3PknZzraagW86dJLIeQfM8T1mSHL8L2ks+v5C/I38aUrjkxFNBNJFzS/pgTdh3A+Pic/eDEIf2yvgAVfhYv3DKnIGMMXErgN+u3xSiKMimLBN2Nc6RIdI0/bJGNrkhbkn6q696uLIs/bEUvZ/+3YwTC7LXBZVxzXWX2Wvla6cSSN+J+1emye2+yfpSCay/UUGwa1X/nvNdP0rUG+pZkk2+MsIWAm5mL6GzKdYOC8SJ0LZZjkbpCS6ZNFUIAcxX2d9VGIE9JiEvBdmMeEP4ZM52e8QVpYJOIc7qQVHNSaDh2lX6PD57YMeZ9bBiYB6WonsUeSB2YzYyJOlj23l2w+f11J5U4JIoXejZvLjtU4BM/SmRa3JqlcEKp3twVlZ+Fma4bVy0cU/0hnUlU2sLaKlkvie0eJY4DobVVRg7HxEqGCpuNFPA==;
 5:3kItR3wJZqd33pZDPkjoZV+Xg6h9i2zfP2Bo0N5NOU502QMaQMBo1U85tmpoFVsi4ceHfbAhwoJuJJcMTzdmixlULv7/v6JhCziAeWPIjiocJ/LoBbnuvEyld5SDjf6vCLcUf+UGVXRDi0G7rIRhHDNLLTMWc/2M+sKPi672jy0wzyjq24qrqI7EFyqhupRaqzPjlK3Fv66CM/KaEBS3qQ==;
 7:A0Yo+gXhwJuDMwJhDWxV8KT5A/Vacc8n31YzK4XDd8Q2Rqy65Ch4zxsn2B4gNhzK5w87cPATZFvQcMIzsBerRzjv9C8nieyMH7AFUFzRBNoHnORHuZqzl8Tv3hK8j+TAoB8mqWi6urP/cZrBnTzmkA==
x-ms-office365-filtering-correlation-id: de532e13-c868-4640-cfa7-08d676e889a7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
 SRVR:DB7PR04MB4764; 
x-ms-traffictypediagnostic: DB7PR04MB4764:
x-microsoft-antispam-prvs: <DB7PR04MB476483A0145B3B7DC8589C249E840@DB7PR04MB4764.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:DB7PR04MB4764; BCL:0; PCL:0; RULEID:; SRVR:DB7PR04MB4764; 
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39850400004)(136003)(376002)(366004)(346002)(396003)(189003)(199004)(7736002)(72206003)(478600001)(102836004)(6246003)(316002)(54906003)(76176011)(36756003)(966005)(386003)(6506007)(53546011)(305945005)(31686004)(52116002)(8676002)(97736004)(39060400002)(81156014)(110136005)(81166006)(486006)(14454004)(4326008)(8936002)(93886005)(229853002)(106356001)(105586002)(6116002)(3846002)(25786009)(256004)(14444005)(6436002)(6486002)(66066001)(26005)(446003)(186003)(11346002)(2616005)(2906002)(68736007)(6306002)(85182001)(31696002)(6512007)(53936002)(7416002)(71200400001)(86362001)(71190400001)(5660300001)(99286004)(476003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB7PR04MB4764;
 H:DB7PR04MB4810.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mbzcZW4/KV1gV/swy44if9VU3LHGpNUmL5h0S3Ba9Mndeg5hm9rheD8qPfHlyk5RBX8lZGYJeDif0RD0M2Nk/2qEz9bZdQPJ2BPgX7KV4rEZtLtfFspAfscZzHY396Vx3goXGYXqmQZQveQmpwCjuTvSX4paBXZdv6mL4df11/rLrzDLc16twKALI0V6QTzUFw/nD8yeZezRgU+5n798xUbyYRBuhbk9kv16o5XS0PVg55w6gtobONXrRwO/0M3hDuCcuVDbKv+e6i7UvhWe3oZttxrMcbQlmfS5VUgpef7BORqzg2c9NDH4n3G49Pzg
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4878A9ED35BB0147A72BC90477A0A926@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de532e13-c868-4640-cfa7-08d676e889a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 10:44:02.7326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4764
X-Mailman-Approved-At: Thu, 10 Jan 2019 22:46:29 +1100
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 ARM-SoC Maintainers <arm@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE
 IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gMTAuMS4yMDE5IDA3OjQyLCBTaGF3biBHdW8gd3JvdGU6DQo+IE9uIFNhdCwgRGVjIDA4LCAy
MDE4IGF0IDA5OjU4OjM3QU0gKzA4MDAsIFNoYXduIEd1byB3cm90ZToNCj4+IE9uIFRodSwgRGVj
IDA2LCAyMDE4IGF0IDA1OjMzOjEzUE0gLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPj4+IE9u
IFdlZCwgRGVjIDUsIDIwMTggYXQgODozMiBQTSBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+IHdyb3RlOg0KPj4+Pg0KPj4+PiBPbiBNb24sIERlYyAwMywgMjAxOCBhdCAwMzozMjowN1BN
IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4+Pj4+IENvbnZlcnQgRnJlZXNjYWxlIFNvQyBi
aW5kaW5ncyB0byBEVCBzY2hlbWEgZm9ybWF0IHVzaW5nIGpzb24tc2NoZW1hLg0KPj4+Pj4NCj4+
Pj4+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+Pj4+PiBDYzogTWFyayBS
dXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT4NCj4+Pj4+IENjOiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZw0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVs
Lm9yZz4NCj4+Pj4+IC0tLQ0KPj4+Pj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYXJt
YWRldXMudHh0ICAgICAgfCAgIDYgLQ0KPj4+Pj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL2JoZi50eHQgfCAgIDYgLQ0KPj4+Pj4gICAuLi4vYmluZGluZ3MvYXJtL2Nv
bXB1bGFiLWJvYXJkcy50eHQgICAgICAgICAgfCAgMjUgLS0NCj4+Pj4+ICAgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wudHh0IHwgMjI5IC0tLS0tLS0tLS0tLS0tLS0t
LQ0KPj4+Pj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwgICAgICAgICAg
fCAyMTQgKysrKysrKysrKysrKysrKw0KPj4+Pg0KPj4+PiBSb2IsDQo+Pj4+DQo+Pj4+IEkgZG8g
aGF2ZSBhbnkgY2hhbmdlcyBvbiBiaW5kaW5ncy9hcm0vZnNsLnR4dCBxdWV1ZWQgZm9yIDQuMjEg
b24gbXkNCj4+Pj4gdHJlZSwgc28gcGxlYXNlIHNlbmQgaXQgdmlhIHlvdXIgdHJlZS4NCj4+Pg0K
Pj4+IFdoYXQgYWJvdXQ6DQo+Pj4NCj4+PiBjMzg2ZjM2Mjk1N2IgZHQtYmluZGluZ3M6IEFkZCBj
b21wYXRpYmxlIHN0cmluZyBmb3IgTFMxMDI4QS1RRFMNCj4+PiAzNjcxY2Q1N2RlMDYgZHQtYmlu
ZGluZ3M6IGxzMTAxMmE6IEFkZCBGUldZLUxTMTAxMkEgZGV2aWNlIHRyZWUgYmluZGluZw0KPj4N
Cj4+IEFoLCBzb3JyeSwgSSBvbmx5IGNoZWNrZWQgb24gaW14L2R0IGJyYW5jaCBhbmQgZm9yZ290
IGlteC9kdDY0LiAgSSB3aWxsDQo+PiBkcm9wIHRoZSBjaGFuZ2VzIG9uIGZzbC50eHQgYW5kIHVw
ZGF0ZSBmc2wueWFtbCBhZnRlciBpdCBoaXRzIG1haW5saW5lLg0KPiANCj4gV2hhdCBoYXBwZW5l
ZCB0byB0aGlzPyAgSXQgc2VlbXMgdGhlIHBhdGNoIGRpZCBub3QgaGl0IHY1LjAtcmMxLg0KDQpI
aSBTaGF3biwNClJvYiBhY3R1YWxseSBhc2tlZCB5b3UgYSBzaW1pbGFyIHF1ZXN0aW9uIHR3byBk
YXlzIGFnby4uDQoNCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzEvOC83NTQNCg==
