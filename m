Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C3FC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 20:58:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE152086D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 20:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bz+zCpw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE152086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443tPb06rDzDqL4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 07:58:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.4.63; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=leoyang.li@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="Bz+zCpw6"; 
 dkim-atps=neutral
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40063.outbound.protection.outlook.com [40.107.4.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443tMh4nq7zDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 07:57:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJvXE1OAldgE/q05edyO+x86sKSIOeHiiflBlLPr7m0=;
 b=Bz+zCpw6xcyTDeHosSh+e26ULxwtcEzvjOCHEb6ykCxx6aJRnabWSuXbAbe7tNEstzi0Mtx2l2zx0mXMPVJFTg52aPufAFw9AH3cwqdSxbSuJT9L0dsWr+78w7NRaL4RUfoaV1qg9av88LMgTdCbcErrg4Wdbvx95fmrGegjtgk=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB4133.eurprd04.prod.outlook.com (52.135.166.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Tue, 19 Feb 2019 20:56:56 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::6c22:d122:2edf:d948%5]) with mapi id 15.20.1643.014; Tue, 19 Feb 2019
 20:56:56 +0000
From: Leo Li <leoyang.li@nxp.com>
To: Colin King <colin.king@canonical.com>, Roy Pledge <roy.pledge@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH][next] soc: fsl: dpio: fix memory leak of a struct qbman
 on error exit path
Thread-Topic: [PATCH][next] soc: fsl: dpio: fix memory leak of a struct qbman
 on error exit path
Thread-Index: AQHUyFwq50clv2b/DU6TNIT7uzPh/aXnmm0Q
Date: Tue, 19 Feb 2019 20:56:56 +0000
Message-ID: <AM6PR04MB586338893C089939732092468F7C0@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20190219140517.10709-1-colin.king@canonical.com>
In-Reply-To: <20190219140517.10709-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14c6c7e8-1dbd-4fe4-1a9b-08d696acc89d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR04MB4133; 
x-ms-traffictypediagnostic: AM6PR04MB4133:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0MTMzOzIzOnM1QUxXK2h3SERwQmQxRXVwMCtrOFgycTFD?=
 =?utf-8?B?VnZnbVc0aWQ2QkhvQWl1cldmWHN3TTByNnZwNWd6aThYODRzS1UrT2lnUHFy?=
 =?utf-8?B?NDRLNjJTV3o5cytTWElsblBMT3k4UWNieXU3ZlV1b1lPWGxDTXROdWlHaFVv?=
 =?utf-8?B?M0NYdldBRm04cmdwMWVjRDB4QVY3WU1FVHBRK1ZrYWVTZzNScU8rL2pvT1pE?=
 =?utf-8?B?VVFKWWJWdlMydWtUWjZZcE96cnhibkRmRU90Z3psS0dXSFdLOHoxelFMMXF2?=
 =?utf-8?B?QXh2WVpLamJocGdrcVRrRlAvNXB3YkZUdmRrdXNXUU5wUXdDVVk2YjAxZWQz?=
 =?utf-8?B?VzNHZ3VucUZmMlVUVVFqSFVKMWRaNUtQMk9JbTF1QmJYNndlV3crY3Fsa0RQ?=
 =?utf-8?B?RnhjYUEwTDNQNS94WjhTaUpEcGNrc0RQR1hPMzVIV2xyV1NQRVIzZE4rSEJ5?=
 =?utf-8?B?eHhzUkpjd1B3OHY5VVNqT09ldisxd3NadmFnZ3NtcUpxQjYwQTdGczREd3lo?=
 =?utf-8?B?QXlmdmFDTEgwZEdCUTBibEFBdkxDY0R6VCtGcGFpWFRpZ1FUVXhXcXBRRFF5?=
 =?utf-8?B?ZmFBSWRRTjdvR1dUZSt3VjJFT0tUQVNid2RoR3ZwT0trb0FtYXk2U2wxU3B1?=
 =?utf-8?B?WXdsNGNrVWJOOWhjTjJISy90L2pzRVkwQjVVNk9XQmZXMVZTZkE1U0dXbHhx?=
 =?utf-8?B?azc4ZnFOYm9oZTJxZVJYeHdDUk81QTZSV0pSQlJpOW11c0JaUnNjQnlDWmdp?=
 =?utf-8?B?eUVuYVBIaUZwVlhGQlpqRGMyWHp5Z0E3RmlReHhQTG5IemY2ejJYQmRXRjRR?=
 =?utf-8?B?amg2QlpKbjRGRlFzWHVIWFlOWDNUbnVLbjQ5WVRGalNPMFR4T2JHYUhyczFX?=
 =?utf-8?B?Y1RiZ1F6Q3ZsOU1WWEl6Zk1vbGdWMXR5bEswSVR5NG1QRkFTcVBqVUprTW9v?=
 =?utf-8?B?Vm04bGtMbjJ1ejdjREJhQnhoZUdLcGw2WXVXV1BFSTVPWEhSaEZBQ1p6SVB1?=
 =?utf-8?B?TjVQTXYrcEFSbkxRYjBuSzFrSGlSWTBKMmNZdVpxenl0NE9kMXlkeU1JRWx4?=
 =?utf-8?B?bFdtbDRLMWRCZER2czA5M042YVV3ejc0dGo2K1BheTNsaHVVQXV4eWQwTng1?=
 =?utf-8?B?TXM1VGNLUVkyc1cwbG9FM0dZRlphOVJQdHVkYVJxMUpwMVRjaWpudnc4T01a?=
 =?utf-8?B?SnJwOVlGN29YZlE0U0VjcDJ6NHVEbWN3Qy8wS01vQ3J4VnN0VDV4VEhnbi9T?=
 =?utf-8?B?cFNacU5hRU5zOGFHOUNWSmVSNWVpNzZKWmlVZlV6VDQ3Vmp4NmhFbUw1L2xs?=
 =?utf-8?B?RFFBczRjUUpwTEdBeHZXTHVDcDJuMHFCTjA0dE15b2FPQ1I4MU92M1Y2dnZh?=
 =?utf-8?B?TENCcy9tUk1QdHdFaWJxTGNmaGFUVXZ6MThnK2t4a3NIdlczVnNYSncvWmNm?=
 =?utf-8?B?Mm05WW9XdEQ5Q21GVTJDQ0w1RVhhTWRZM1pqVEF3cmNhZjhkVmtNU1VyblZY?=
 =?utf-8?B?SFJjSnFzbGJXSkpmNHNkTUpOTm01UThnTldiSzZkSlIyUTZmbklOS09jbGlT?=
 =?utf-8?B?UVBOUXJQRFlPUGhJRkZSUjBueDJKWVdYQUg2UnY4NVFQakRSWjAyQWNwdjFT?=
 =?utf-8?B?aE41dnd1ZnVpZUQxTkJZSFRpSS9vRWVCdllBSXhMZ1lOSXBJRW1yTHRlNUhW?=
 =?utf-8?Q?gPT6EOXsvyQE0SBxJEu+p27mj6ZWAILyl5/MWhO?=
x-microsoft-antispam-prvs: <AM6PR04MB413334EA38A138B88F28ABD08F7C0@AM6PR04MB4133.eurprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(346002)(396003)(39860400002)(136003)(376002)(13464003)(199004)(189003)(86362001)(2201001)(68736007)(186003)(102836004)(3846002)(76176011)(26005)(305945005)(55016002)(97736004)(6246003)(53936002)(5660300002)(8676002)(66066001)(229853002)(7736002)(81166006)(81156014)(74316002)(4326008)(14454004)(99286004)(256004)(6436002)(33656002)(110136005)(316002)(8936002)(54906003)(2906002)(7696005)(476003)(9686003)(478600001)(25786009)(106356001)(11346002)(105586002)(446003)(2501003)(6506007)(6116002)(53546011)(71200400001)(486006)(71190400001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB4133;
 H:AM6PR04MB5863.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jVzGEMKau2jiKD0q8TS3S7SCavfV2yhr+Gkx0sT4SsC6TeWX1SG3lNZn8MSS0vZcPICM4Yh1a+K7QU54lfKKAGCn6KB3QbBbwxxkUKj92OtRSuvQoV/8VpxmPmHg8+JR7lGbZ50PWF76yNkciKFKdeTsOAra7IDGqca+2G+p+v3pYVwitdpBSjOY2H+BVtVHZVDF9zNFW/i1w2eeYxAUEZWmdLSgZvtGeNfCZbRRuI5A5iz3rELhAB+M1RIrEE/pIuXJHy5wgCqvQ0C1mY2WGKcU6UqY9E/Kr//eaIWo6Aj6ybm5oxst9XV9B7/pDuRtS8lwUzxBBflNkSCxIlLL/ImdiyAdcr54TwvkP7/gbYMkqT5buPt6allrV7E4hTT17qk3gGgNd2sR1bDF4PB2SThPThUOhe7eTCK23OA329k=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c6c7e8-1dbd-4fe4-1a9b-08d696acc89d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 20:56:56.2823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4133
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
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29saW4gS2luZyA8Y29s
aW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAxOSwgMjAx
OSA4OjA1IEFNDQo+IFRvOiBSb3kgUGxlZGdlIDxyb3kucGxlZGdlQG54cC5jb20+OyBMZW8gTGkg
PGxlb3lhbmcubGlAbnhwLmNvbT47DQo+IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGtlcm5lbC1qYW5pdG9y
c0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogW1BBVENIXVtuZXh0XSBzb2M6IGZzbDogZHBpbzogZml4IG1lbW9yeSBsZWFrIG9mIGEgc3Ry
dWN0IHFibWFuIG9uDQo+IGVycm9yIGV4aXQgcGF0aA0KPiANCj4gRnJvbTogQ29saW4gSWFuIEtp
bmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4gDQo+IEN1cnJlbnRseSB0aGUgZXJyb3Ig
Y2hlY2sgZm9yIGEgbnVsbCByZWcgbGVha3MgYSBzdHJ1Y3QgcWJtYW4gdGhhdCB3YXMNCj4gYWxs
b2NhdGVkIGVhcmxpZXIuIEZpeCB0aGlzIGJ5IGtmcmVlJ2luZyBwIG9uIHRoZSBlcnJvciBleGl0
IHBhdGguDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0Bj
YW5vbmljYWwuY29tPg0KDQpBcHBsaWVkIGZvciBuZXh0LiAgVGhhbmtzLg0KDQo+IC0tLQ0KPiAg
ZHJpdmVycy9zb2MvZnNsL2RwaW8vcWJtYW4tcG9ydGFsLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2ZzbC9k
cGlvL3FibWFuLXBvcnRhbC5jDQo+IGIvZHJpdmVycy9zb2MvZnNsL2RwaW8vcWJtYW4tcG9ydGFs
LmMNCj4gaW5kZXggMGJkZGI4NWMwYWU1Li41YTczMzk3YWU3OWUgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvc29jL2ZzbC9kcGlvL3FibWFuLXBvcnRhbC5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL2Zz
bC9kcGlvL3FibWFuLXBvcnRhbC5jDQo+IEBAIC0xODAsNiArMTgwLDcgQEAgc3RydWN0IHFibWFu
X3N3cCAqcWJtYW5fc3dwX2luaXQoY29uc3Qgc3RydWN0DQo+IHFibWFuX3N3cF9kZXNjICpkKQ0K
PiAgCXJlZyA9IHFibWFuX3JlYWRfcmVnaXN0ZXIocCwgUUJNQU5fQ0lOSF9TV1BfQ0ZHKTsNCj4g
IAlpZiAoIXJlZykgew0KPiAgCQlwcl9lcnIoInFibWFuOiB0aGUgcG9ydGFsIGlzIG5vdCBlbmFi
bGVkIVxuIik7DQo+ICsJCWtmcmVlKHApOw0KPiAgCQlyZXR1cm4gTlVMTDsNCj4gIAl9DQo+IA0K
PiAtLQ0KPiAyLjIwLjENCg0K
