Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00527C282D0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDE5214DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 08:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="fbaN9ZfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDE5214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43pfMQ1M0WzDqMS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 19:10:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=40.107.76.74; helo=nam02-cy1-obe.outbound.protection.outlook.com;
 envelope-from=mathias.thore@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="fbaN9ZfJ";
 dkim-atps=neutral
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760074.outbound.protection.outlook.com [40.107.76.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43pfJ219twzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 19:07:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BhEtcvqnc8c2kIojiSKpyh6GAQ+BIPmbHgjrwFBO5Y=;
 b=fbaN9ZfJzHgePh/OpmiuXTywrEQNcMIjple6EDNnAREL33M/l54iiT1fgtgKhtnz53wUgd3YXq1yj0HPWCOWHMd4j1hTpbqgkl/nXhqJpA9LxS3IOB+S4FQU5yQ+DLrLFl93EVMDCpXDOpuGYGpv0FkXIXl+U18e937OBuR1yB4=
Received: from DM6PR10MB3721.namprd10.prod.outlook.com (20.179.69.153) by
 DM6PR10MB2636.namprd10.prod.outlook.com (20.176.89.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 08:07:54 +0000
Received: from DM6PR10MB3721.namprd10.prod.outlook.com
 ([fe80::dde5:6747:ecec:62b5]) by DM6PR10MB3721.namprd10.prod.outlook.com
 ([fe80::dde5:6747:ecec:62b5%4]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 08:07:54 +0000
From: Mathias Thore <Mathias.Thore@infinera.com>
To: Li Yang <leoyang.li@nxp.com>
Subject: RE: [PATCH] ucc_geth: Reset BQL queue when stopping device
Thread-Topic: [PATCH] ucc_geth: Reset BQL queue when stopping device
Thread-Index: AQHUtuj3UNEzRrgKOUG24I15ihkwVKXEb4cAgABQNtWAAHWKAIAArdIw
Date: Tue, 29 Jan 2019 08:07:54 +0000
Message-ID: <DM6PR10MB3721D7BA109A3823D9DACF1984970@DM6PR10MB3721.namprd10.prod.outlook.com>
References: <20190128090747.15851-1-mathias.thore@infinera.com>
 <6bc7e64a-b91a-cb6e-ed65-5e412cef3a76@c-s.fr>
 <DM6PR10MB37217EA1DBEFE3D5CEB5A85084960@DM6PR10MB3721.namprd10.prod.outlook.com>
 <CADRPPNS3M=j4DDMtq_Mb+Xo1M71_yM+_N7n48u-z5pSSzdBoXg@mail.gmail.com>
In-Reply-To: <CADRPPNS3M=j4DDMtq_Mb+Xo1M71_yM+_N7n48u-z5pSSzdBoXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mathias.Thore@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; DM6PR10MB2636;
 6:XNASzQZETF42rN2Jy7iwKUHaGMyRN0UqmjliJOVDX6Eu9Cr0rll6yALQXXXbqC9GVVM0GY9spk6oFIJ2COftL3qfx7Ja6hHTtl3T7y7fPIArqfI2AuM9DWFGi7bab6IbQzKA6PSjzHqysRKtLDuaWdBPpyEg3cWoR0WNATr3iIaXNxJHBESClibcwYBWePiPfsQYVGFCN6xRWklztOUONQUTv9B/9Wm6EJ6UP8l7xHGEPnhm9mrZRxq9Rme4WBijgx2V+gS/ELsA9RqQIY3237ywCoAwMzycsfSGFCFfy3PDEFLRQSB7wu7+9NhWVILwVLOgqxY2Jl3koU0vQG70eyZEOykVeYowtQVtXtm5Kc5bzZLNqte+J0qQn2BwGMJyubYBWm50ksRoKJfi5HhmAQ9zjnYm3IRGZD51USJlO/Vw/jns7/7dWqeHel3Bj+nN+zl6nBrPoo7NbJtm+gM/qw==;
 5:pXQ3Ix5j0H7Pf0AsVRIBRHKBfVvzukq5J+2bXOaPbdvYP09IU2XONHU6CUXNBei1rk6PRUtF2D813F5b+gCnL6ArkESkSRap5ru+ay1DdRlXzVitAQ+ZhXxm9bAqisA6RHeC4ZSyttnmWCjxmh8jcWiR+wxbHDHBYY+IL7t9HpVbjCaSwhjI4kkMH8dSszH+aBZhjuGLHmEjNmIJQffOFA==;
 7:uqsXUvnD4OP54Txjt4/B0OI+kwhIbKnp+gZBGG4sqkUCl386U7R4vipmxEho0dat2Y4nLSYbbSn5pWWRxgX6oFFbUVUFDmDrcssuR4Jy+uMp9xrt6Qk73vKP8xU8T3dGO0izQBizVrCKCCJzmdPASQ==
x-ms-office365-filtering-correlation-id: 04b1bdee-ed55-4cd1-0e7e-08d685c0df34
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:DM6PR10MB2636; 
x-ms-traffictypediagnostic: DM6PR10MB2636:
x-microsoft-antispam-prvs: <DM6PR10MB2636714FC1669456CB8C567884970@DM6PR10MB2636.namprd10.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(39860400002)(366004)(136003)(346002)(13464003)(199004)(189003)(81156014)(316002)(8936002)(305945005)(6916009)(74316002)(8676002)(81166006)(7736002)(229853002)(66574012)(6246003)(33656002)(107886003)(53936002)(4326008)(26005)(102836004)(71200400001)(71190400001)(486006)(11346002)(186003)(53546011)(25786009)(478600001)(68736007)(446003)(6506007)(476003)(6436002)(7696005)(66066001)(76176011)(3846002)(9686003)(54906003)(99286004)(106356001)(105586002)(72206003)(55016002)(93886005)(86362001)(256004)(5024004)(6116002)(2906002)(14454004)(97736004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR10MB2636;
 H:DM6PR10MB3721.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FvhPPMDpYJ5gQX9540mdr3cETD6ZdT3nA6WRyV5iguOI4IOcKFvgAxaAVBnXHRF7H1BQ6hsgsQ0uXDZcySb+iVESgK4pnMLGfOS3nfkLpnrSFMbimpFtreg9Aex2slVaqGJLwGzJtzNsIuE1HdVFRoZRH6pnzqQZIOMHFRmknjzEDatPZ6BVoo94e+651uVS6om6akKLex6+K8JJ4imxt6+myFJnUltMXnsaz67YVGyvbVhEzTEB/wfGhEKbG+FcQTn+y64g3ZDUSGqtPuyfmwTtz11peUIxxX6WqNuxKYkcY4qu7JmF5M1As5YHSASsHN8ScsLjQN0kBz7JADpcvG/Z0bkThKH45GGuVsdXCvAnp6ZGA56+e/aepTa5/Ic6ayVlNvQ/cxwOWynf2GqmhVQoxJKD8NoZvyJmpV5g7ao=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b1bdee-ed55-4cd1-0e7e-08d685c0df34
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 08:07:54.1447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2636
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 David Gounaris <David.Gounaris@infinera.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SXMgdGhlcmUgYSBzY2VuYXJpbyB3aGVyZSB3ZSBhcmUgY2xlYXJpbmcgdGhlIFRYIHJpbmcgYnV0
IGRvbid0IHdhbnQgdG8gcmVzZXQgdGhlIEJRTCBUWCBxdWV1ZT8NCg0KSSB0aGluayBpdCBtYWtl
cyBzZW5zZSB0byBrZWVwIGl0IGluIHVjY19nZXRoX2ZyZWVfdHggc2luY2UgdGhlIHJlYXNvbiBp
dCBpcyBuZWVkZWQgaXNuJ3QgdGhlIHRpbWVvdXQgcGVyIHNlLCBidXQgcmF0aGVyIHRoZSBjbGVh
cmluZyBvZiB0aGUgVFggcmluZy4gVGhpcyB3YXksIGl0IHdpbGwgYmUgcGVyZm9ybWVkIG5vIG1h
dHRlciB3aHkgdGhlIGRyaXZlciBlbmRzIHVwIGNhbGxpbmcgdGhpcyBmdW5jdGlvbi4NCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExpIFlhbmcgW21haWx0bzpsZW95YW5nLmxp
QG54cC5jb21dIA0KU2VudDogTW9uZGF5LCAyOCBKYW51YXJ5IDIwMTkgMjI6MzcNClRvOiBNYXRo
aWFzIFRob3JlIDxNYXRoaWFzLlRob3JlQGluZmluZXJhLmNvbT4NCkNjOiBDaHJpc3RvcGhlIExl
cm95IDxjaHJpc3RvcGhlLmxlcm95QGMtcy5mcj47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBEYXZpZCBHb3VuYXJpcyA8RGF2aWQuR291bmFy
aXNAaW5maW5lcmEuY29tPjsgSm9ha2ltIFRqZXJubHVuZCA8Sm9ha2ltLlRqZXJubHVuZEBpbmZp
bmVyYS5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSB1Y2NfZ2V0aDogUmVzZXQgQlFMIHF1ZXVl
IHdoZW4gc3RvcHBpbmcgZGV2aWNlDQoNCk9uIE1vbiwgSmFuIDI4LCAyMDE5IGF0IDg6MzcgQU0g
TWF0aGlhcyBUaG9yZSA8TWF0aGlhcy5UaG9yZUBpbmZpbmVyYS5jb20+IHdyb3RlOg0KPg0KPiBI
aSwNCj4NCj4NCj4gVGhpcyBpcyB3aGF0IHdlIG9ic2VydmVkOiB0aGVyZSB3YXMgYSBzdG9ybSBv
biB0aGUgbWVkaXVtIHNvIHRoYXQgb3VyIGNvbnRyb2xsZXIgY291bGQgbm90IGRvIGl0cyBUWCwg
cmVzdWx0aW5nIGluIHRpbWVvdXQuIFdoZW4gdGltZW91dCBvY2N1cnMsIHRoZSBkcml2ZXIgY2xl
YXJzIGFsbCBkZXNjcmlwdG9ycyBmcm9tIHRoZSBUWCBxdWV1ZS4gVGhlIGZ1bmN0aW9uIGNhbGxl
ZCBpbiB0aGlzIHBhdGNoIGlzIHVzZWQgdG8gcmVmbGVjdCB0aGlzIGNsZWFyaW5nIGFsc28gaW4g
dGhlIEJRTCBsYXllci4gV2l0aG91dCBpdCwgdGhlIGNvbnRyb2xsZXIgd291bGQgZ2V0IHN0dWNr
LCB1bmFibGUgdG8gcGVyZm9ybSBUWCwgZXZlbiBzZXZlcmFsIG1pbnV0ZXMgYWZ0ZXIgdGhlIHN0
b3JtIGhhZCBlbmRlZC4gQnJpbmdpbmcgdGhlIGRldmljZSBkb3duIGFuZCB0aGVuIHVwIGFnYWlu
IHdvdWxkIHNvbHZlIHRoZSBwcm9ibGVtLCBidXQgdGhpcyBwYXRjaCBhbHNvIHNvbHZlcyBpdCBh
dXRvbWF0aWNhbGx5Lg0KDQpUaGUgZXhwbGFuYXRpb24gbWFrZXMgc2Vuc2UuICBTbyB0aGlzIHNo
b3VsZCBvbmx5IGJlIHJlcXVpcmVkIGluIHRoZSB0aW1lb3V0IHNjZW5hcmlvIGluc3RlYWQgb2Yg
b3RoZXIgY2xlYW4gdXAgc2NlbmFyaW9zIGxpa2UgZGV2aWNlIHNodXRkb3duPyAgSWYgc28sIGl0
IHByb2JhYmx5IGl0IHdpbGwgYmUgYmV0dGVyIHRvIGJlIGRvbmUgaW4gdWNjX2dldGhfdGltZW91
dF93b3JrKCk/DQoNCj4NCj4NCj4gU29tZSBvdGhlciBkcml2ZXJzIGRvIHRoZSBzYW1lLCBmb3Ig
ZXhhbXBsZSBlMTAwMGUgZHJpdmVyIGNhbGxzIG5ldGRldl9yZXNldF9xdWV1ZSBpbiBpdHMgZTEw
MDBfY2xlYW5fdHhfcmluZyBmdW5jdGlvbi4gSXQgaXMgcG9zc2libGUgdGhhdCBvdGhlciBkcml2
ZXJzIHNob3VsZCBkbyB0aGUgc2FtZTsgSSBoYXZlIG5vIHdheSBvZiB2ZXJpZnlpbmcgdGhpcy4N
Cj4NCj4NCj4gUmVnYXJkcywNCj4NCj4gTWF0aGlhcw0KPg0KPiAtLQ0KPg0KPg0KPiBGcm9tOiBD
aHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGMtcy5mcj4NCj4gU2VudDogTW9uZGF5
LCBKYW51YXJ5IDI4LCAyMDE5IDEwOjQ4IEFNDQo+IFRvOiBNYXRoaWFzIFRob3JlOyBsZW95YW5n
LmxpQG54cC5jb207IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IA0KPiBsaW51eHBwYy1kZXZAbGlz
dHMub3psYWJzLm9yZzsgRGF2aWQgR291bmFyaXM7IEpvYWtpbSBUamVybmx1bmQNCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gdWNjX2dldGg6IFJlc2V0IEJRTCBxdWV1ZSB3aGVuIHN0b3BwaW5nIGRl
dmljZQ0KPg0KPg0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRl
IG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQg
aXMgc2FmZS4NCj4NCj4NCj4gSGksDQo+DQo+IExlIDI4LzAxLzIwMTkgw6AgMTA6MDcsIE1hdGhp
YXMgVGhvcmUgYSDDqWNyaXQgOg0KPiA+IEFmdGVyIGEgdGltZW91dCBldmVudCBjYXVzZWQgYnkg
Zm9yIGV4YW1wbGUgYSBicm9hZGNhc3Qgc3Rvcm0sIHdoZW4gDQo+ID4gdGhlIE1BQyBhbmQgUEhZ
IGFyZSByZXNldCwgdGhlIEJRTCBUWCBxdWV1ZSBuZWVkcyB0byBiZSByZXNldCBhcyANCj4gPiB3
ZWxsLiBPdGhlcndpc2UsIHRoZSBkZXZpY2Ugd2lsbCBleGhpYml0IHNldmVyZSBwZXJmb3JtYW5j
ZSBpc3N1ZXMgDQo+ID4gZXZlbiBhZnRlciB0aGUgc3Rvcm0gaGFzIGVuZGVkLg0KPg0KPiBXaGF0
IGFyZSB0aGUgc3ltcHRvbW5zID8NCj4NCj4gSXMgdGhpcyByZXNldCBuZWVkZWQgb24gYW55IG5l
dHdvcmsgZHJpdmVyIGluIHRoYXQgY2FzZSwgb3IgaXMgaXQgDQo+IHNvbWV0aGluZyBwYXJ0aWN1
bGFyIGZvciB0aGUgdWNjX2dldGggPw0KPiBGb3IgaW5zdGFuY2UsIHRoZSBmcmVlc2NhbGUgZnNf
ZW5ldCBkb2Vzbid0IGhhdmUgdGhhdCByZXNldC4gU2hvdWxkIGl0IA0KPiBoYXZlIGl0IHRvbyA/
DQo+DQo+IENocmlzdG9waGUNCj4NCj4gPg0KPiA+IENvLWF1dGhvcmVkLWJ5OiBEYXZpZCBHb3Vu
YXJpcyA8ZGF2aWQuZ291bmFyaXNAaW5maW5lcmEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1h
dGhpYXMgVGhvcmUgPG1hdGhpYXMudGhvcmVAaW5maW5lcmEuY29tPg0KPiA+IC0tLQ0KPiA+ICAg
ZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL3VjY19nZXRoLmMgfCAyICsrDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL3VjY19nZXRoLmMgDQo+ID4gYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9mcmVlc2NhbGUvdWNjX2dldGguYw0KPiA+IGluZGV4IGMzZDUzOWUyMDllZC4u
ZWIzZTY1ZTg4NjhmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVz
Y2FsZS91Y2NfZ2V0aC5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxl
L3VjY19nZXRoLmMNCj4gPiBAQCAtMTg3OSw2ICsxODc5LDggQEAgc3RhdGljIHZvaWQgdWNjX2dl
dGhfZnJlZV90eChzdHJ1Y3QgdWNjX2dldGhfcHJpdmF0ZSAqdWdldGgpDQo+ID4gICAgICAgdTE2
IGksIGo7DQo+ID4gICAgICAgdTggX19pb21lbSAqYmQ7DQo+ID4NCj4gPiArICAgICBuZXRkZXZf
cmVzZXRfcXVldWUodWdldGgtPm5kZXYpOw0KPiA+ICsNCj4gPiAgICAgICB1Z19pbmZvID0gdWdl
dGgtPnVnX2luZm87DQo+ID4gICAgICAgdWZfaW5mbyA9ICZ1Z19pbmZvLT51Zl9pbmZvOw0KPiA+
DQo+ID4NCj4NCg==
