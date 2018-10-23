Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A2CC46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 20:05:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4941820671
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 20:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="J1e4s9Qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4941820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fkrX6fjLzF35p
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 07:05:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="J1e4s9Qo";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=104.47.38.40; helo=nam02-bl2-obe.outbound.protection.outlook.com;
 envelope-from=joakim.tjernlund@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="J1e4s9Qo";
 dkim-atps=neutral
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0040.outbound.protection.outlook.com [104.47.38.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fknj10RczDrcP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 07:02:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9PPLUlUKZrlMHfcyFSUW8v75YFXo3yGoSF7fzGu7JE=;
 b=J1e4s9QoeT/LU8Tci2wHtCWryiUycmwQlXZgp4XF5BCfdSACabORdt2D9+FpiQ3bhsms0kUPopkySkh6dNA55/nNgN67s3XLjkDYh+wMoEmUiwU49XDV6VgsOL/HDMiylEJeFl7W1dipyAZ4LEMfH6GvfMaF9xKq0SjqW5M6+DY=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0543.namprd10.prod.outlook.com (10.163.134.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.22; Tue, 23 Oct 2018 20:02:25 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055%3]) with mapi id 15.20.1273.014; Tue, 23 Oct 2018
 20:02:25 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "f.fainelli@gmail.com"
 <f.fainelli@gmail.com>
Subject: Re: ethernet "bus" number in DTS ?
Thread-Topic: ethernet "bus" number in DTS ?
Thread-Index: AQHUavBvzf0FONUzZkq6koorQ03jUaUtDssAgAAQjQCAAAT2AIAAHHCA
Date: Tue, 23 Oct 2018 20:02:25 +0000
Message-ID: <af78570fc7874ca656ee2d81c3841f789fc7d0eb.camel@infinera.com>
References: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
 <518e0cf1-ef7e-b251-a153-34e01a80267d@gmail.com>
 <694b6f4f6b66eb35176e3eb48bbec474c9647007.camel@infinera.com>
 <8225ba9e-ce8f-b0e0-8f3d-73783693eea4@gmail.com>
In-Reply-To: <8225ba9e-ce8f-b0e0-8f3d-73783693eea4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN1PR10MB0543;
 6:/R5iVoONeRWnhxyonaT9sm/sTKdBdseK7q1euc2Uv+9pEktbxFzMJ+XGnovBGzL/COofCKQAOR3ZTRWkSvTFafho1+/1p8dSVlsFftZ7QyE5ykbBj8UR53xGHFFUYrQfQIIGysGUpZUU+uILvAbxx3jdhsZZ+d/CmRZXi9lGk8t4kaqpbysTomxgrxfQP+g3Ods5B+FLR4PnPzKHS9W+PeauGgxxQG7B9aOtYDvXCx2nIxdKS01JS7wVFBo+n6M7nAtqhF7EFQv2Y9T6qW3BM7HxowUYg/c3aevK2Ploh9+LCqAIh8hyZwaLuTK9slYDTSqgsBRjGLgjSfzV26CfMnS7LnYq/zdJygvnVf2+sNg3LRzCz7MmDV8nPDHxHj0I+5hxTebMn6ngtcOINAqWVSg6pR3DLA50t+JeOSC6eQXiAYvsedksqZcO9YEFuABgk8roKj9DVvBzQzdhbFQbsg==;
 5:ZSKHMmyzGZK+gV9IUOZzqsoAqfVhc8RiE/28G4kAmI7UHdDFygoR1H4qo/6y40RihacB/EqRHs5XGtF0kmw7F7XN0jg473EJMUlGiJ1sK0+UnUun/Jnv5iYCf9U4HsA1qbZjn9yksIcaw+f0RvqwAPJEklx8+n6kxIY7qmibVio=;
 7:hA55mYFsLuvrKYTRVK/WGx2JObF/tdJpLUtnPGOWnZcqOEEd4itMawT0uitScfRHjOlRxlSsACJXIcT597SMpKwuxQtipTXDwpScw5WOFnYFz3tCucVpGYcVf9pISmIlfaMVxV7lOmcU56ii4BoZQPIkTAYuLUDgS4eU7PkJgvFP2RSwO03nVpi1lMjirEqwckVhPIbKlg7848z3YQ7F/Y+hm2SYhxs+QuH8H4fEKkbNIN0N2qnIXPjUUvjeH3LQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f92a96e1-1990-4d16-6ebe-08d63922740a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
 SRVR:SN1PR10MB0543; 
x-ms-traffictypediagnostic: SN1PR10MB0543:
x-microsoft-antispam-prvs: <SN1PR10MB054366031A8A1C6D0D1FD72BF4F50@SN1PR10MB0543.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:SN1PR10MB0543; BCL:0; PCL:0; RULEID:; SRVR:SN1PR10MB0543; 
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(5250100002)(72206003)(2201001)(6486002)(68736007)(86362001)(6246003)(26005)(71190400001)(118296001)(316002)(71200400001)(186003)(14444005)(4326008)(4001150100001)(2501003)(39060400002)(25786009)(966005)(97736004)(3846002)(305945005)(6306002)(66066001)(2900100001)(8676002)(5660300001)(53936002)(478600001)(93886005)(256004)(110136005)(6116002)(53546011)(446003)(105586002)(106356001)(6506007)(476003)(2616005)(8936002)(99286004)(76176011)(486006)(6512007)(229853002)(7736002)(554214002)(11346002)(36756003)(81166006)(14454004)(81156014)(6436002)(102836004)(2906002)(403724002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR10MB0543;
 H:SN1PR10MB0736.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: m9exI/pvFUOj9+PagtP0Pdo0Ipbecc7dqIJYz7NT8D5Ue9HT5ZsJ/wX7WkrbRpsodAbcJLgAlLAEqNSUl5AEbDd68pueAc6SQI9oGu72twaJi/ZyZGR4JF3VrOJaEWG+tc+3fqfdXnHLH2NDJ5AYVuCxGztTdvj4RUkFV2dv+CjnZAVAUWqqY0h0E9k1IlYaXD1LWz4GbFpDQxjqR0nRaUtl+zfG9/Df3pMJyaAT+dCbZnW0vN1TXY7GiphBHfZInUxdBm93BIDWjLQgGoF10IkCOykMrV2fcsd3gG6bbw1dD+z4S4niLc8tauQB9aem9tGppt+VyHD5VzXVbz1U/FGljOO3t2eUfn9cjSDh1o4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B3AF7740813BC4A96E71B1725C4F0C6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92a96e1-1990-4d16-6ebe-08d63922740a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 20:02:25.5828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0543
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
Cc: "andrew@lunn.ch" <andrew@lunn.ch>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gVHVlLCAyMDE4LTEwLTIzIGF0IDExOjIwIC0wNzAwLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3Rl
Og0KPiANCj4gT24gMTAvMjMvMTggMTE6MDIgQU0sIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+
ID4gT24gVHVlLCAyMDE4LTEwLTIzIGF0IDEwOjAzIC0wNzAwLCBGbG9yaWFuIEZhaW5lbGxpIHdy
b3RlOg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IE9uIDEwLzIzLzE4IDk6NDkgQU0sIEpvYWtpbSBU
amVybmx1bmQgd3JvdGU6DQo+ID4gPiA+IFNQSSAoYW5kIG90aGVycykgaGFzIGEgd2F5IHRvIGRl
ZmluZSBidXMgbnVtYmVyIGluIGEgYWxpYXNlczoNCj4gPiA+ID4gICAgICAgYWxpYXNlcyB7DQo+
ID4gPiA+ICAgICAgICAgICAgICAgZXRoZXJuZXQ0ID0gJmVuZXQ0Ow0KPiA+ID4gPiAgICAgICAg
ICAgICAgIGV0aGVybmV0MCA9ICZlbmV0MDsNCj4gPiA+ID4gICAgICAgICAgICAgICBldGhlcm5l
dDEgPSAmZW5ldDE7DQo+ID4gPiA+ICAgICAgICAgICAgICAgZXRoZXJuZXQyID0gJmVuZXQyOw0K
PiA+ID4gPiAgICAgICAgICAgICAgIGV0aGVybmV0MyA9ICZlbmV0MzsNCj4gPiA+ID4gICAgICAg
ICAgICAgICBzcGkwID0gJnNwaTANCj4gPiA+ID4gICAgICAgfTsNCj4gPiA+ID4gVGhlIDAgaW4g
dGhlIHNwaTAgYWxpYXMgd2lsbCB0cmFuc2xhdGUgdG8gYnVzIG51bSAwIHNvIG9uZSBjYW4gY29u
dHJvbCB0aGUgL2RldiBub2RlcywgbGlrZSAvZGV2L3NwaWRldjANCj4gPiA+ID4gSSBhbSBsb29r
aW5nIGZvciB0aGUgc2FtZSBmb3IgZXRoZXJuZXQgZGV2aWNlczoNCj4gPiA+ID4gIGV0aGVybmV0
NCA9ICZlbmV0NDsgIC8qIHNob3VsZCBiZWNvbWUgZXRoNCAqLw0KPiA+ID4gPiAgZXRoZXJuZXQw
ID0gJmVuZXQwOyAgLyogc2hvdWxkIGJlY29tZSBldGgwICovDQo+ID4gPiA+IGJ1dCBJIGNhbm5v
dCBmaW5kIHNvbWV0aGluZyBsaWtlIHRoYXQgZm9yIGV0aCBkZXZpY2VzLg0KPiA+ID4gPiANCj4g
PiA+ID4gQ291bGQgc3VjaCBmdW5jdGlvbmFsaXR5IGJlIGFkZGVkPw0KPiA+ID4gDQo+ID4gPiBJ
dCBjb3VsZCwgZG8gd2Ugd2FudCBhbmQgbmVlZCB0bywgbm8uIFlvdSBoYXZlIHRoZSBFdGhlcm5l
dCBhbGlhcyBpbg0KPiA+ID4gL3N5cy9jbGFzcy9uZXQvKi9kZXZpY2UvdWV2ZW50IGFscmVhZHkg
dGhhdCB3b3VsZCBhbGxvdyB5b3UgdG8gcGVyZm9ybQ0KPiA+ID4gdGhhdCAocmUpbmFtaW5nIGlu
IHVzZXItc3BhY2U6DQo+ID4gPiANCj4gPiA+ICMgY2F0IC9zeXMvY2xhc3MvbmV0L2V0aDAvZGV2
aWNlL3VldmVudA0KPiA+ID4gRFJJVkVSPWJjbWdlbmV0DQo+ID4gPiBPRl9OQU1FPWV0aGVybmV0
DQo+ID4gPiBPRl9GVUxMTkFNRT0vcmRiL2V0aGVybmV0QGYwNDgwMDAwDQo+ID4gPiBPRl9UWVBF
PW5ldHdvcmsNCj4gPiA+IE9GX0NPTVBBVElCTEVfMD1icmNtLGdlbmV0LXY1DQo+ID4gPiBPRl9D
T01QQVRJQkxFX049MQ0KPiA+ID4gT0ZfQUxJQVNfMD1ldGgwICAgICAgICAgICAgICAgICA8PT09
PT09PT09PT09PT09PT09DQo+ID4gPiBNT0RBTElBUz1vZjpOZXRoZXJuZXRUbmV0d29ya0NicmNt
LGdlbmV0LXY1DQo+ID4gDQo+ID4gWWVzLCBvbmUgY2FuIGlmIG9uZSB1c2VzIHVkZXYgYW5kIGNh
biBmaW5kIHNvbWV0aGluZyB0byBpZGVudGlmeSB0aGUgaHcgSS9GIHdpdGgsIG15DQo+ID4gY2F0
IC9zeXMvY2xhc3MvbmV0L2V0aDAvZGV2aWNlL3VldmVudCBsb29rcyBsaWtlOg0KPiA+IERSSVZF
Uj1mc2xfZHBhDQo+ID4gTU9EQUxJQVM9cGxhdGZvcm06ZHBhYS1ldGhlcm5ldA0KPiANCj4gRG9l
cyBub3QgZHBhYSBoYXZlIGEgbm90aW9uIG9mIEV0aGVybmV0IHBvcnRzIGFuZCB0aG9zZSBzaG91
bGQgaGF2ZQ0KPiBwcm9wZXIgaW5mb3JtYXRpb24/IE1heWJlIHRoYXQgaXMgcGFydCBvZiB5b3Vy
IHByb2JsZW0gaGVyZSwgaXQgc2hvdWxkDQo+IGhhdmUgdGhlIE9GX0FMSUFTIGluZm9ybWF0aW9u
IHNvbWVob3cgYXZhaWxhYmxlLg0KDQpJIGNhbm5vdCBzYXkgQVRNLCBidXQgdGhpcyBsYWNrIG9m
IHN0YW5kYXJkIGRvZXMgbm90IG1ha2UgaXQgZWFzaWVyIHRvIHJlbmFtZSBJL0YncyBpbiB1ZGV2
Lg0KDQo+IA0KPiA+IG5vdCBzdXJlIG1kZXYgc3VwcG9ydHMgdGhpcywgZG9lcyBpdD8NCj4gPiBP
dXIgc2ltcGxlIGluc3RhbGxlciBGUyhpbml0cmFtZnMpIGRvZXNuJ3QgaGF2ZSBlaXRoZXIgdWRl
diBvciBtZGV2Lg0KPiANCj4gSSBkb24ndCBrbm93LCBidXQgeW91IGNvdWxkIGhhdmUgYSBzaW1w
bGUgc2hlbGwgc2NyaXB0IHRoYXQgbG9va3MgYXQNCj4gc3BlY2lmaWMgbmV0d29yayBkZXZpY2Ug
cHJvcGVydGllcyB0byBkZWNpZGUgb24gdGhlIG5hbWluZyBhbmQgY2FsbA0KPiBpZnJlbmFtZS4N
Cg0KVGhpcyByZWludmVudGluZyBvZiB0aGUgd2hlZWwgaXMgd2hhdCBJIGFtIHRyeWluZyB0byBh
dm9pZC4NCg0KPiANCj4gPiBJIGFsc28gbm90ZWQgdGhhdCB1c2luZyBzdGF0dXMgPSAiZGlzYWJs
ZWQiIGRpZG4ndCB3b3JrIGVpdGhlciB0byBjcmVhdGUgYSBmaXggbmFtZSBzY2hlbWUuDQo+ID4g
RXZlbiB3b3JzZSwgYWxsIHRoZSBldGggSS9GIGFmdGVyIGdldHMgcmVudW1iZXJlZC4gSXQgc2Vl
bXMgdG8gbWUgdGhlcmUNCj4gPiBpcyB2YWx1ZSBpbiBoYXZpbmcgc3RhYmlsaXR5IGluIGV0aCBJ
L0YgbmFtaW5nIGF0IGJvb3QuDQo+ID4gVGhlbiB1c2Vyc3BhY2UodWRldikgY2FuIHJlbmFtZSBp
ZiBuZWVkIGJlLg0KPiA+IA0KPiA+IFN1cmUgd291bGQgbGlrZSB0byBrbm93biBtb3JlIGFib3V0
IHdoeSB0aGlzIGZlYXR1cmUgaXMgbm90IHdhbnRlZCA/DQo+ID4gDQo+ID4gSSBmb3VuZA0KPiA+
ICAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC80MTIyNDQxLw0KPiA+IFlvdSBx
dW90ZSBwb2xpY3kgYXMgcmVhc29uIGJ1dCBzdXJlbHkgaXQgbXVzdCBiZSBiZXR0ZXIgdG8NCj4g
PiBoYXZlIHNvbWV0aGluZyBzdGFibGUsIGNvbm5lY3RlZCB0byB0aGUgaGFyZHdhcmUgbmFtZSwg
dGhhbiBzZW1pcmFuZG9tIG5hbWluZz8NCj4gDQo+IElmIHRoZSBEZXZpY2UgVHJlZSBub2RlcyBh
cmUgb3JkZXJlZCBieSBhc2NlbmRpbmcgYmFzZSByZWdpc3RlciBhZGRyZXNzLA0KPiBteSB1bmRl
cnN0YW5kaW5nIGlzIHRoYXQgeW91IGdldCB0aGUgc2FtZSBvcmRlciBhcyBmYXIgYXMNCj4gcGxh
dGZvcm1fZGV2aWNlIGNyZWF0aW9uIGdvZXMsIHRoaXMgbWF5IG5vdCBiZSB0cnVlIGluIHRoZSBm
dXR1cmUgaWYgUm9iDQo+IGRlY2lkZXMgdG8gcmFuZG9taXplIHRoYXQsIGJ1dCBBRkFJQ1QgdGhp
cyBpcyBzdGlsbCB0cnVlLiBUaGlzIG1heSBub3QNCj4gd29yayB3ZWxsIHdpdGggc3RhdHVzID0g
ZGlzYWJsZWQgcHJvcGVydGllcyBiZWluZyBpbnNlcnRlZCBoZXJlIGFuZA0KPiB0aGVyZSwgYnV0
IHdlIGhhdmUgdXNlZCB0aGF0IGhlcmUgYW5kIGl0IGhhcyB3b3JrZWQgZm9yIGFzIGZhciBhcyBJ
IGNhbg0KPiByZW1lbWJlciBkb2luZyBpdC4NCg0KSSByZWNhbGwgaXQgaXMgdGhlIG9yZGVyIGlu
IHdoaWNoIHRoZSBldGggYWxpYXMgYXBwZWFyIHRoYXQgY29udHJvbHMgdGhlIG5hbWluZywNCm5v
dCAxMDAlIHN1cmUgdGhvdWdoLg0KDQo+IA0KPiBTZWNvbmQsIHlvdSBtaWdodCB3YW50IHRvIG5h
bWUgbmV0d29yayBkZXZpY2VzIGV0aFgsIGJ1dCB3aGF0IGlmIEkgd2FudA0KPiB0byBuYW1lIHRo
ZW0gZXRoZXJuZXRYIG9yIGZvb1ggb3IgYmFyWD8gU2hvdWxkIHdlIGJlIGFjY2VwdGluZyBhDQo+
IG1lY2hhbmlzbSBpbiB0aGUga2VybmVsIHRoYXQgd291bGQgYWxsb3cgc29tZW9uZSB0byBuYW1l
IHRoZSBpbnRlcmZhY2VzDQo+IHRoZSB3YXkgdGhleSB3YW50IHN0cmFpZ2h0IGZyb20gYSBuYW1l
IGJlaW5nIHByb3ZpZGVkIGluIERldmljZSBUcmVlPw0KDQpJIGp1c3Qgd2FudCB0byBoYXZlIHN0
YWJsZSBib290IG5hbWVzLCBha2EgZXRoWCwgd2hpY2ggY2FuIGRlZmluZWQgaW4NCnRoZSBwbGF0
Zm9ybXMgRFQuIFRoZW4gdXNlcnNwYWNlIGNhbiBnbyBmcm9tIHRoZXJlIHRvIHdoYXRldmVyIGl0
IG5lZWRzLA0KdWRldiBjb3VsZCBwb3NzaWJseSB1c2UgdGhlc2Ugc3RhYmxlIGJvb3QgbmFtZXMg
dG8gaWRlbnRpZnkgdGhlIEkvRidzIHRvIHJlbmFtZS4NCg0KQVRNLCBpdCBpcyBwcmV0dHkgaGFy
ZCB0byBldmVuIHVzZSB1ZGV2IHdoZW4gL3N5cy9jbGFzcy9uZXQvZXRoMC9kZXZpY2UvdWV2ZW50
DQpjYW4gbG9vayBkaWZmZXJlbnQgZXZlbiBmb3IgT0YgY3JlYXRlZCBpbnRlcmZhY2VzLg0KDQo+
IA0KPiBBbGlhc2VzIGFyZSBmaW5lIGZvciBwcm92aWRpbmcgcmVsYXRpdmUgc3RhYmlsaXR5IHdp
dGhpbiB0aGUgRGV2aWNlIFRyZWUNCj4gaXRzZWxmIGFuZCBib290IHByb2dyYW1zIHRoYXQgbWln
aHQgbmVlZCB0byBtb2RpZnkgdGhlIERldmljZSBUcmVlIChlLmc6DQo+IGluc2VydGluZyBNQUMg
YWRkcmVzc2VzKSBzdWNoIHRoYXQgeW91IGRvbid0IGhhdmUgdG8gZW5jb2RlIGxvZ2ljIHRvDQo+
IHNlYXJjaCBmb3Igbm9kZXMgYnkgY29tcGF0aWJsZSBzdHJpbmdzIGV0Yy4gYnV0IG91dHNpZGUg
b2YgdGhhdCB1c2UNCj4gY2FzZSwgaXQgc2VlbXMgdG8gbWUgdGhhdCB5b3UgY2FuIHJlc29sdmUg
ZXZlcnkgbmFtaW5nIGRlY2lzaW9uIGluDQo+IHVzZXItc3BhY2UuDQoNCldlbGwsIHlvdSBjYW4g
cmVzb2x2ZSBNQUMgYWRkcmVzcyBhc3NpZ25tZW50IGluIHVzZXIgc3BhY2UgdG9vIGJ1dCBtb3N0
DQp3aWxsIGFncmVlIHRoYXQgaXMgbm90IGNvbnZlbmllbnQuIEkgc3VnZ2VzdCBpdCBpcyBhbHNv
IGhhbmR5IHRvIGhhdmUNCnNvbWUgY29udHJvbCBvZiBJL0YgZW51bWVyYXRpb24oZXRoWCB0aGF0
IGlzKSBmcm9tIHBsYXRmb3JtIGNvZGUgbGlrZSBEVC4NCg0KIEpvY2tlDQo=
