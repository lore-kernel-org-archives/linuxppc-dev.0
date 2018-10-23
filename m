Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18191C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 18:05:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C26A20671
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 18:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="dqFDyGWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C26A20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fhBQ3Yb5zF38n
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 05:05:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="dqFDyGWE";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=40.107.69.68; helo=nam04-co1-obe.outbound.protection.outlook.com;
 envelope-from=joakim.tjernlund@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="dqFDyGWE";
 dkim-atps=neutral
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690068.outbound.protection.outlook.com [40.107.69.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fh7j4C5TzF36k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 05:02:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGF9Lhr0BjbazCk8qPgyPLYWuBrI7UjuIFkW+DhJDkI=;
 b=dqFDyGWEhjY+GlitW5n4t819O8RPopx3DD4IJdNaPNsQ8Ji/k9YTB8oc4ay3eDnsTyIBMEBsQx2hIGr2nTzuYKgmvz7k420/1uc3r3X4VgvrsNEwj0siHlqTlT//Sc/Gbk7z+ti85hjXabLaCRvQXRosQx6t1vHz8RBmfkkvsQc=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0366.namprd10.prod.outlook.com (10.162.102.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.18; Tue, 23 Oct 2018 18:02:52 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055%3]) with mapi id 15.20.1273.014; Tue, 23 Oct 2018
 18:02:52 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "f.fainelli@gmail.com"
 <f.fainelli@gmail.com>
Subject: Re: ethernet "bus" number in DTS ?
Thread-Topic: ethernet "bus" number in DTS ?
Thread-Index: AQHUavBvzf0FONUzZkq6koorQ03jUaUtDssAgAAQjQA=
Date: Tue, 23 Oct 2018 18:02:52 +0000
Message-ID: <694b6f4f6b66eb35176e3eb48bbec474c9647007.camel@infinera.com>
References: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
 <518e0cf1-ef7e-b251-a153-34e01a80267d@gmail.com>
In-Reply-To: <518e0cf1-ef7e-b251-a153-34e01a80267d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN1PR10MB0366;
 6:XsNFy+U9xajTHndUitUxrcbzBEkJWbUMZ4eqbv69wbc/dZxCjbBmIuGv16X7qvPz98gyGlBRI1p8MyfPkA9d8GHaAp5SwVTBdR5mh6wQ48u1XHysvUu7aDhcHvhufs/VBS1e7DRdC3a5K/pv+XymqDBN1rsqqV7ObMrok4odym033XH5bA3CTjGDrw05S7f1aVym5dACJ7GdsYQ8eqcuD6CvA+6wbJUOz+hM7VOQkeX4qiA7vdbNyJ1xXvGu5bUgxTFJuQfORdHwQYinP9DZaGuCqc6q3rAgbQpr1vkt1mStvfWcP0dZKBz33FkstHx1+yBbpK9XFKslrhpATBT7eqkFVXPcGz7YoWaQJBryyuqFBw4et0O2Ke/RccIbQIbLuyzgngWXqpCKvuuvXUsUN4QiyzSvKla6VkdrYp+mBsLbk3JEbxbnFkHUHAlccjk09gLms0riuodH6lswGtqiUg==;
 5:buFAkOWQ+a+oRkgWISvb4ZmPiu8BNC1vDmEDHWuQqCYvSEfM6o0snPCCrAiYPsN8BXB+nMGRkVyD/IkwAPweaFIIsqA/VKQhgIMLdNWOSxnxPduzgQUARNRvBYLs260Phgq3awyNGSEkEPmZQiTHLmy9efCSfdd0+Hc0Niz15uQ=;
 7:JV9/hvFvClBdWDehki+CPwPc7pZsELWAtQJzyYvJ2haPNhjXVni6JBEn/aKNpuOQ8HAouRy43TUHLP9MnPVgrMP0Pvr7E/J29mbSmCNbSx0WbpMr8ogjqvDtoZ9VzvUhlyhBFLq1gaijoocyj7bBlQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c3cc5dd9-cab4-4a60-f0bd-08d63911c03e
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:SN1PR10MB0366; 
x-ms-traffictypediagnostic: SN1PR10MB0366:
x-microsoft-antispam-prvs: <SN1PR10MB036659BD7474674DDBAF23EBF4F50@SN1PR10MB0366.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:SN1PR10MB0366; BCL:0; PCL:0; RULEID:; SRVR:SN1PR10MB0366; 
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(366004)(189003)(199004)(2201001)(105586002)(106356001)(2900100001)(53936002)(4326008)(305945005)(25786009)(7736002)(4001150100001)(6246003)(68736007)(476003)(97736004)(11346002)(2906002)(81156014)(81166006)(39060400002)(86362001)(110136005)(316002)(36756003)(8936002)(53546011)(8676002)(6506007)(2616005)(76176011)(486006)(5250100002)(6486002)(2501003)(229853002)(446003)(102836004)(6116002)(3846002)(966005)(72206003)(66066001)(14454004)(71200400001)(99286004)(71190400001)(478600001)(6512007)(6306002)(5660300001)(118296001)(14444005)(256004)(5024004)(186003)(554214002)(26005)(6436002)(403724002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR10MB0366;
 H:SN1PR10MB0736.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FvkpTvWevuEuOWjIiGpoT/9kh/lKDdLheUEFHciIVkoHuuODgtGQ2HeUb63J4xeD56XFqgSgrchlP8EVlvH0P04vVSTmczmdQNf40CmE1vReDzWHZHQLHCSLSnTnOz8UCt5DHGYiFg83KltPRfxnwyf9AMSrcqb4UdNhKzRPvpY/JcKTVraHLJYgiAEdkA3dbliiu5T12qvlEKgOWvSNNFC1zaZ3h038T8mPoD4rgyUt3cr7zWQAVnVe7dktigWBwWuqseAaXyPEFsRmcxfqkiJ3uuPjESvz42j5pm7V0D2vZNawKMS2sTQytoGpJel+i63EKxKx4Mj1eW6rwxNkqd4qwmAAe7VKcbGTgUR4XVE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DBDEB633481984CBA0CF84FA2EED3BB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cc5dd9-cab4-4a60-f0bd-08d63911c03e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 18:02:52.0831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0366
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

T24gVHVlLCAyMDE4LTEwLTIzIGF0IDEwOjAzIC0wNzAwLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3Rl
Og0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBv
cmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4gDQo+IA0KPiBPbiAxMC8yMy8xOCA5OjQ5IEFNLCBKb2FraW0gVGplcm5sdW5kIHdyb3RlOg0K
PiA+IFNQSSAoYW5kIG90aGVycykgaGFzIGEgd2F5IHRvIGRlZmluZSBidXMgbnVtYmVyIGluIGEg
YWxpYXNlczoNCj4gPiAgICAgICBhbGlhc2VzIHsNCj4gPiAgICAgICAgICAgICAgIGV0aGVybmV0
NCA9ICZlbmV0NDsNCj4gPiAgICAgICAgICAgICAgIGV0aGVybmV0MCA9ICZlbmV0MDsNCj4gPiAg
ICAgICAgICAgICAgIGV0aGVybmV0MSA9ICZlbmV0MTsNCj4gPiAgICAgICAgICAgICAgIGV0aGVy
bmV0MiA9ICZlbmV0MjsNCj4gPiAgICAgICAgICAgICAgIGV0aGVybmV0MyA9ICZlbmV0MzsNCj4g
PiAgICAgICAgICAgICAgIHNwaTAgPSAmc3BpMA0KPiA+ICAgICAgIH07DQo+ID4gVGhlIDAgaW4g
dGhlIHNwaTAgYWxpYXMgd2lsbCB0cmFuc2xhdGUgdG8gYnVzIG51bSAwIHNvIG9uZSBjYW4gY29u
dHJvbCB0aGUgL2RldiBub2RlcywgbGlrZSAvZGV2L3NwaWRldjANCj4gPiBJIGFtIGxvb2tpbmcg
Zm9yIHRoZSBzYW1lIGZvciBldGhlcm5ldCBkZXZpY2VzOg0KPiA+ICBldGhlcm5ldDQgPSAmZW5l
dDQ7ICAvKiBzaG91bGQgYmVjb21lIGV0aDQgKi8NCj4gPiAgZXRoZXJuZXQwID0gJmVuZXQwOyAg
Lyogc2hvdWxkIGJlY29tZSBldGgwICovDQo+ID4gYnV0IEkgY2Fubm90IGZpbmQgc29tZXRoaW5n
IGxpa2UgdGhhdCBmb3IgZXRoIGRldmljZXMuDQo+ID4gDQo+ID4gQ291bGQgc3VjaCBmdW5jdGlv
bmFsaXR5IGJlIGFkZGVkPw0KPiANCj4gSXQgY291bGQsIGRvIHdlIHdhbnQgYW5kIG5lZWQgdG8s
IG5vLiBZb3UgaGF2ZSB0aGUgRXRoZXJuZXQgYWxpYXMgaW4NCj4gL3N5cy9jbGFzcy9uZXQvKi9k
ZXZpY2UvdWV2ZW50IGFscmVhZHkgdGhhdCB3b3VsZCBhbGxvdyB5b3UgdG8gcGVyZm9ybQ0KPiB0
aGF0IChyZSluYW1pbmcgaW4gdXNlci1zcGFjZToNCj4gDQo+ICMgY2F0IC9zeXMvY2xhc3MvbmV0
L2V0aDAvZGV2aWNlL3VldmVudA0KPiBEUklWRVI9YmNtZ2VuZXQNCj4gT0ZfTkFNRT1ldGhlcm5l
dA0KPiBPRl9GVUxMTkFNRT0vcmRiL2V0aGVybmV0QGYwNDgwMDAwDQo+IE9GX1RZUEU9bmV0d29y
aw0KPiBPRl9DT01QQVRJQkxFXzA9YnJjbSxnZW5ldC12NQ0KPiBPRl9DT01QQVRJQkxFX049MQ0K
PiBPRl9BTElBU18wPWV0aDAgICAgICAgICAgICAgICAgIDw9PT09PT09PT09PT09PT09PT0NCj4g
TU9EQUxJQVM9b2Y6TmV0aGVybmV0VG5ldHdvcmtDYnJjbSxnZW5ldC12NQ0KDQpZZXMsIG9uZSBj
YW4gaWYgb25lIHVzZXMgdWRldiBhbmQgY2FuIGZpbmQgc29tZXRoaW5nIHRvIGlkZW50aWZ5IHRo
ZSBodyBJL0Ygd2l0aCwgbXkNCmNhdCAvc3lzL2NsYXNzL25ldC9ldGgwL2RldmljZS91ZXZlbnQg
bG9va3MgbGlrZToNCkRSSVZFUj1mc2xfZHBhDQpNT0RBTElBUz1wbGF0Zm9ybTpkcGFhLWV0aGVy
bmV0DQoNCm5vdCBzdXJlIG1kZXYgc3VwcG9ydHMgdGhpcywgZG9lcyBpdD8NCk91ciBzaW1wbGUg
aW5zdGFsbGVyIEZTKGluaXRyYW1mcykgZG9lc24ndCBoYXZlIGVpdGhlciB1ZGV2IG9yIG1kZXYu
DQoNCkkgYWxzbyBub3RlZCB0aGF0IHVzaW5nIHN0YXR1cyA9ICJkaXNhYmxlZCIgZGlkbid0IHdv
cmsgZWl0aGVyIHRvIGNyZWF0ZSBhIGZpeCBuYW1lIHNjaGVtZS4NCkV2ZW4gd29yc2UsIGFsbCB0
aGUgZXRoIEkvRiBhZnRlciBnZXRzIHJlbnVtYmVyZWQuIEl0IHNlZW1zIHRvIG1lIHRoZXJlDQpp
cyB2YWx1ZSBpbiBoYXZpbmcgc3RhYmlsaXR5IGluIGV0aCBJL0YgbmFtaW5nIGF0IGJvb3QuDQpU
aGVuIHVzZXJzcGFjZSh1ZGV2KSBjYW4gcmVuYW1lIGlmIG5lZWQgYmUuIA0KDQpTdXJlIHdvdWxk
IGxpa2UgdG8ga25vd24gbW9yZSBhYm91dCB3aHkgdGhpcyBmZWF0dXJlIGlzIG5vdCB3YW50ZWQg
Pw0KDQpJIGZvdW5kDQogIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvNDEyMjQ0
MS8NCllvdSBxdW90ZSBwb2xpY3kgYXMgcmVhc29uIGJ1dCBzdXJlbHkgaXQgbXVzdCBiZSBiZXR0
ZXIgdG8NCmhhdmUgc29tZXRoaW5nIHN0YWJsZSwgY29ubmVjdGVkIHRvIHRoZSBoYXJkd2FyZSBu
YW1lLCB0aGFuIHNlbWlyYW5kb20gbmFtaW5nPw0KDQogSm9ja2UNCg0K
