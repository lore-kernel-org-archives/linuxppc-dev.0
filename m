Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66240C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 22:18:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66C12075D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 22:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="hYORZsPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66C12075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fnpN4KRrzF37g
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 09:18:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=infinera.com header.i=@infinera.com header.b="hYORZsPB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=104.47.36.65; helo=nam02-sn1-obe.outbound.protection.outlook.com;
 envelope-from=joakim.tjernlund@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="hYORZsPB";
 dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0065.outbound.protection.outlook.com [104.47.36.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fnll2JmMzDrSJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 09:16:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCv4xSUOzBnt0dpNsbGmmq+jETcEXTwMRJLWWsQDYlo=;
 b=hYORZsPBtH7D88VPXu3obH8axsN/0CIMITDsHHjd1np/ptgv5TZH0KF/ZiDtm2CzAxUHvrJdB19RVxDkTXDjzBEI/PCL7oa3HMx0gMDTKRbIYyeO4dXNyKy7GjZh1LxBlW9moclgeBEpB9wRjS13wnaaBdf2c8ramj73dSOkxcg=
Received: from SN1PR10MB0736.namprd10.prod.outlook.com (10.163.206.15) by
 SN1PR10MB0718.namprd10.prod.outlook.com (10.163.206.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 22:15:55 +0000
Received: from SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055]) by SN1PR10MB0736.namprd10.prod.outlook.com
 ([fe80::6855:de72:6814:7055%3]) with mapi id 15.20.1273.014; Tue, 23 Oct 2018
 22:15:55 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "f.fainelli@gmail.com"
 <f.fainelli@gmail.com>
Subject: Re: ethernet "bus" number in DTS ?
Thread-Topic: ethernet "bus" number in DTS ?
Thread-Index: AQHUavBvzf0FONUzZkq6koorQ03jUaUtDssAgAAQjQCAAAT2AIAAHHCAgAABcICAACPdgA==
Date: Tue, 23 Oct 2018 22:15:55 +0000
Message-ID: <60cff09428688abab8464fb9c67e96fda99cd66d.camel@infinera.com>
References: <88328977dfeaf667a98d791074b721fe730d285b.camel@infinera.com>
 <518e0cf1-ef7e-b251-a153-34e01a80267d@gmail.com>
 <694b6f4f6b66eb35176e3eb48bbec474c9647007.camel@infinera.com>
 <8225ba9e-ce8f-b0e0-8f3d-73783693eea4@gmail.com>
 <af78570fc7874ca656ee2d81c3841f789fc7d0eb.camel@infinera.com>
 <adaad568-bbaf-fd5d-a2c3-ae7bf1be3d31@gmail.com>
In-Reply-To: <adaad568-bbaf-fd5d-a2c3-ae7bf1be3d31@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN1PR10MB0718;
 6:ku98fWdfkXpyukQsG9PbyNnqTlM/rX+0ij02P4HyksgpsJU7Vy21EIxM/SoEuOIO3Hvnk6qU9d+OIM1Jv7K1fvRSdzHjG3jtutQ2yDIRbHtJee3oq8UYI/Oa+gXuyYuvu0sFvyW+9Cp/F38QPgfHF19kOX5NTpCm+U+KYZ9oj+U5SKZtHvZC6k4tJfwoESzUHB1R+IjLGqVttDcD11/rKn2B/iNljuRZISNmQVa5htll2Qs9jwIaQbVu2EPiFtgTihlKy4u1fhDkljO6hv8R67wmAyYhDLdItyq//qCo2c3FT9z/Ub0nlHrOdaJPjvCVN/kh9id8KNo3AwWePaEG+xqnJkYqVysWoLrpvBEOdyCN3xmMQ/E/9Og1Cry6wPqCwG2/K08khpxQZhMd98Icj8x/mzhtm6wni0hnzsxXzELwNtNgOKxLKIkUsMuuB0khVv51OqfoNUIY5CmKs/x/64U7Bx+9m0oRV5JzEeCpJ38=;
 5:+Qp/eTUIYOgZCSkbF567OMKLkjloUNQZhkHQWlv4eR6SV0xvGa4q92l1c80YV8ftrdv80rRmZbpsidgMwX3f8u8cQpG3OJ8qul2RwGEnrQD1BGAbR/9fS9MZhRpspIQptT6veXhLZCDdBj+zWZkXY4eOt1Iu08C1QfMJmn1qvr8=;
 7:SqZ4gIO8nz32qor3YC8zyms/Vy08l7Nk0RwoRMBzLXtqK+gu4eJM1HQ+6yR4jm6D5JJXbxX1ytuBlYkVlICyMqjo3RHG5mJZb4+LaqSO/A2yuYMms0c7YDKIThX43Kn91H9cIRyJTKDoAK8Inoqt3D8yjDuTk25yLw4qc3RU0qmfV368a/BJPfGLulSwL/AvvPeWqUFUQTuBtoidwkgoqqd8u7KL1vBEbzLhbK++DxlB6Pce+lfB9DnjJmCqbiRt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ce7e5565-cd4f-43ab-fbee-08d639351a51
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:SN1PR10MB0718; 
x-ms-traffictypediagnostic: SN1PR10MB0718:
x-microsoft-antispam-prvs: <SN1PR10MB0718286153E60E6EB225B404F4F50@SN1PR10MB0718.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:SN1PR10MB0718; BCL:0; PCL:0; RULEID:; SRVR:SN1PR10MB0718; 
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(376002)(396003)(366004)(136003)(189003)(199004)(14454004)(81166006)(106356001)(53936002)(25786009)(2906002)(8676002)(39060400002)(68736007)(81156014)(966005)(4001150100001)(256004)(110136005)(8936002)(14444005)(4326008)(186003)(316002)(2616005)(11346002)(446003)(2501003)(105586002)(26005)(476003)(97736004)(305945005)(478600001)(6512007)(229853002)(6486002)(76176011)(6436002)(2900100001)(71200400001)(486006)(5250100002)(554214002)(6506007)(53546011)(66066001)(118296001)(2201001)(86362001)(71190400001)(5660300001)(6306002)(93886005)(72206003)(6246003)(7736002)(6116002)(3846002)(36756003)(99286004)(102836004)(403724002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR10MB0718;
 H:SN1PR10MB0736.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tBP4rU5QPbbHHDHGNL32Hb8+b2DYv/nF6lSZZym9pc3mE3IYfJzpKkdCVx9EPgaT4C2FnSB2L2JlK4tNZZvf/Kbd2hqAOqpGUV/c1XVBXUUwwNjauOE9LiBgfP0MZKAHNnu99sgBUNfYLdlt/C7B1i1gE13EfsKm0ysel+V5wkTaXh2DJ03Aq+AuiGaSogyndGA4rspWDkzqmj/gfr/oFEqVS+pJyoxm3867aJTjHdZHcH5v8AtyIC7k6CSVTZaHEV9ZqIg5A+SHeQOqniaLtJ+Hp3lFJLXryto5zZhB+cfczzqQXc/kb7IDvEr48nfCGqkr0mPT7Bb3uE3O1Lb3Tdu9dWjODtNyNiP9odeg2Ak=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA74E95F133DB34ABBB559E1D5F744BE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7e5565-cd4f-43ab-fbee-08d639351a51
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 22:15:55.6353 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR10MB0718
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

T24gVHVlLCAyMDE4LTEwLTIzIGF0IDEzOjA3IC0wNzAwLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3Rl
Og0KPiANCj4gT24gMTAvMjMvMTggMTowMiBQTSwgSm9ha2ltIFRqZXJubHVuZCB3cm90ZToNCj4g
PiBPbiBUdWUsIDIwMTgtMTAtMjMgYXQgMTE6MjAgLTA3MDAsIEZsb3JpYW4gRmFpbmVsbGkgd3Jv
dGU6DQo+ID4gPiBPbiAxMC8yMy8xOCAxMTowMiBBTSwgSm9ha2ltIFRqZXJubHVuZCB3cm90ZToN
Cj4gPiA+ID4gT24gVHVlLCAyMDE4LTEwLTIzIGF0IDEwOjAzIC0wNzAwLCBGbG9yaWFuIEZhaW5l
bGxpIHdyb3RlOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIDEwLzIzLzE4IDk6NDkgQU0sIEpv
YWtpbSBUamVybmx1bmQgd3JvdGU6DQo+ID4gPiA+ID4gPiBTUEkgKGFuZCBvdGhlcnMpIGhhcyBh
IHdheSB0byBkZWZpbmUgYnVzIG51bWJlciBpbiBhIGFsaWFzZXM6DQo+ID4gPiA+ID4gPiAgICAg
ICBhbGlhc2VzIHsNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgZXRoZXJuZXQ0ID0gJmVuZXQ0
Ow0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBldGhlcm5ldDAgPSAmZW5ldDA7DQo+ID4gPiA+
ID4gPiAgICAgICAgICAgICAgIGV0aGVybmV0MSA9ICZlbmV0MTsNCj4gPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgZXRoZXJuZXQyID0gJmVuZXQyOw0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBl
dGhlcm5ldDMgPSAmZW5ldDM7DQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIHNwaTAgPSAmc3Bp
MA0KPiA+ID4gPiA+ID4gICAgICAgfTsNCj4gPiA+ID4gPiA+IFRoZSAwIGluIHRoZSBzcGkwIGFs
aWFzIHdpbGwgdHJhbnNsYXRlIHRvIGJ1cyBudW0gMCBzbyBvbmUgY2FuIGNvbnRyb2wgdGhlIC9k
ZXYgbm9kZXMsIGxpa2UgL2Rldi9zcGlkZXYwDQo+ID4gPiA+ID4gPiBJIGFtIGxvb2tpbmcgZm9y
IHRoZSBzYW1lIGZvciBldGhlcm5ldCBkZXZpY2VzOg0KPiA+ID4gPiA+ID4gIGV0aGVybmV0NCA9
ICZlbmV0NDsgIC8qIHNob3VsZCBiZWNvbWUgZXRoNCAqLw0KPiA+ID4gPiA+ID4gIGV0aGVybmV0
MCA9ICZlbmV0MDsgIC8qIHNob3VsZCBiZWNvbWUgZXRoMCAqLw0KPiA+ID4gPiA+ID4gYnV0IEkg
Y2Fubm90IGZpbmQgc29tZXRoaW5nIGxpa2UgdGhhdCBmb3IgZXRoIGRldmljZXMuDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IENvdWxkIHN1Y2ggZnVuY3Rpb25hbGl0eSBiZSBhZGRlZD8NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBJdCBjb3VsZCwgZG8gd2Ugd2FudCBhbmQgbmVlZCB0bywgbm8u
IFlvdSBoYXZlIHRoZSBFdGhlcm5ldCBhbGlhcyBpbg0KPiA+ID4gPiA+IC9zeXMvY2xhc3MvbmV0
LyovZGV2aWNlL3VldmVudCBhbHJlYWR5IHRoYXQgd291bGQgYWxsb3cgeW91IHRvIHBlcmZvcm0N
Cj4gPiA+ID4gPiB0aGF0IChyZSluYW1pbmcgaW4gdXNlci1zcGFjZToNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiAjIGNhdCAvc3lzL2NsYXNzL25ldC9ldGgwL2RldmljZS91ZXZlbnQNCj4gPiA+ID4g
PiBEUklWRVI9YmNtZ2VuZXQNCj4gPiA+ID4gPiBPRl9OQU1FPWV0aGVybmV0DQo+ID4gPiA+ID4g
T0ZfRlVMTE5BTUU9L3JkYi9ldGhlcm5ldEBmMDQ4MDAwMA0KPiA+ID4gPiA+IE9GX1RZUEU9bmV0
d29yaw0KPiA+ID4gPiA+IE9GX0NPTVBBVElCTEVfMD1icmNtLGdlbmV0LXY1DQo+ID4gPiA+ID4g
T0ZfQ09NUEFUSUJMRV9OPTENCj4gPiA+ID4gPiBPRl9BTElBU18wPWV0aDAgICAgICAgICAgICAg
ICAgIDw9PT09PT09PT09PT09PT09PT0NCj4gPiA+ID4gPiBNT0RBTElBUz1vZjpOZXRoZXJuZXRU
bmV0d29ya0NicmNtLGdlbmV0LXY1DQo+ID4gPiA+IA0KPiA+ID4gPiBZZXMsIG9uZSBjYW4gaWYg
b25lIHVzZXMgdWRldiBhbmQgY2FuIGZpbmQgc29tZXRoaW5nIHRvIGlkZW50aWZ5IHRoZSBodyBJ
L0Ygd2l0aCwgbXkNCj4gPiA+ID4gY2F0IC9zeXMvY2xhc3MvbmV0L2V0aDAvZGV2aWNlL3VldmVu
dCBsb29rcyBsaWtlOg0KPiA+ID4gPiBEUklWRVI9ZnNsX2RwYQ0KPiA+ID4gPiBNT0RBTElBUz1w
bGF0Zm9ybTpkcGFhLWV0aGVybmV0DQo+ID4gPiANCj4gPiA+IERvZXMgbm90IGRwYWEgaGF2ZSBh
IG5vdGlvbiBvZiBFdGhlcm5ldCBwb3J0cyBhbmQgdGhvc2Ugc2hvdWxkIGhhdmUNCj4gPiA+IHBy
b3BlciBpbmZvcm1hdGlvbj8gTWF5YmUgdGhhdCBpcyBwYXJ0IG9mIHlvdXIgcHJvYmxlbSBoZXJl
LCBpdCBzaG91bGQNCj4gPiA+IGhhdmUgdGhlIE9GX0FMSUFTIGluZm9ybWF0aW9uIHNvbWVob3cg
YXZhaWxhYmxlLg0KPiA+IA0KPiA+IEkgY2Fubm90IHNheSBBVE0sIGJ1dCB0aGlzIGxhY2sgb2Yg
c3RhbmRhcmQgZG9lcyBub3QgbWFrZSBpdCBlYXNpZXIgdG8gcmVuYW1lIEkvRidzIGluIHVkZXYu
DQo+ID4gDQo+ID4gPiA+IG5vdCBzdXJlIG1kZXYgc3VwcG9ydHMgdGhpcywgZG9lcyBpdD8NCj4g
PiA+ID4gT3VyIHNpbXBsZSBpbnN0YWxsZXIgRlMoaW5pdHJhbWZzKSBkb2Vzbid0IGhhdmUgZWl0
aGVyIHVkZXYgb3IgbWRldi4NCj4gPiA+IA0KPiA+ID4gSSBkb24ndCBrbm93LCBidXQgeW91IGNv
dWxkIGhhdmUgYSBzaW1wbGUgc2hlbGwgc2NyaXB0IHRoYXQgbG9va3MgYXQNCj4gPiA+IHNwZWNp
ZmljIG5ldHdvcmsgZGV2aWNlIHByb3BlcnRpZXMgdG8gZGVjaWRlIG9uIHRoZSBuYW1pbmcgYW5k
IGNhbGwNCj4gPiA+IGlmcmVuYW1lLg0KPiA+IA0KPiA+IFRoaXMgcmVpbnZlbnRpbmcgb2YgdGhl
IHdoZWVsIGlzIHdoYXQgSSBhbSB0cnlpbmcgdG8gYXZvaWQuDQo+IA0KPiBFbWJlZGRlZCBpcyBh
bGwgYWJvdXQgYmVpbmcgYSBzcGVjaWFsIHNub3dmbGFrZSBhbmQgcmUtaW52ZW50aW5nIHRoZQ0K
PiB3aGVlbCwgYnV0IGhhdmluZyBzb21lIGRlc2t0b3AtbGlrZSBkaXN0cmlidXRpb24gdXNlci1z
cGFjZSB3b3VsZA0KPiBjZXJ0YWlubHkgYWxsb3cgeW91IHRvIHJlLWludmVudCBvdGhlciBwYXJ0
cyBvZiB0aGUgd2hlZWwuDQo+IA0KPiA+ID4gPiBJIGFsc28gbm90ZWQgdGhhdCB1c2luZyBzdGF0
dXMgPSAiZGlzYWJsZWQiIGRpZG4ndCB3b3JrIGVpdGhlciB0byBjcmVhdGUgYSBmaXggbmFtZSBz
Y2hlbWUuDQo+ID4gPiA+IEV2ZW4gd29yc2UsIGFsbCB0aGUgZXRoIEkvRiBhZnRlciBnZXRzIHJl
bnVtYmVyZWQuIEl0IHNlZW1zIHRvIG1lIHRoZXJlDQo+ID4gPiA+IGlzIHZhbHVlIGluIGhhdmlu
ZyBzdGFiaWxpdHkgaW4gZXRoIEkvRiBuYW1pbmcgYXQgYm9vdC4NCj4gPiA+ID4gVGhlbiB1c2Vy
c3BhY2UodWRldikgY2FuIHJlbmFtZSBpZiBuZWVkIGJlLg0KPiA+ID4gPiANCj4gPiA+ID4gU3Vy
ZSB3b3VsZCBsaWtlIHRvIGtub3duIG1vcmUgYWJvdXQgd2h5IHRoaXMgZmVhdHVyZSBpcyBub3Qg
d2FudGVkID8NCj4gPiA+ID4gDQo+ID4gPiA+IEkgZm91bmQNCj4gPiA+ID4gICBodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3BhdGNoLzQxMjI0NDEvDQo+ID4gPiA+IFlvdSBxdW90ZSBwb2xp
Y3kgYXMgcmVhc29uIGJ1dCBzdXJlbHkgaXQgbXVzdCBiZSBiZXR0ZXIgdG8NCj4gPiA+ID4gaGF2
ZSBzb21ldGhpbmcgc3RhYmxlLCBjb25uZWN0ZWQgdG8gdGhlIGhhcmR3YXJlIG5hbWUsIHRoYW4g
c2VtaXJhbmRvbSBuYW1pbmc/DQo+ID4gPiANCj4gPiA+IElmIHRoZSBEZXZpY2UgVHJlZSBub2Rl
cyBhcmUgb3JkZXJlZCBieSBhc2NlbmRpbmcgYmFzZSByZWdpc3RlciBhZGRyZXNzLA0KPiA+ID4g
bXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHlvdSBnZXQgdGhlIHNhbWUgb3JkZXIgYXMgZmFyIGFz
DQo+ID4gPiBwbGF0Zm9ybV9kZXZpY2UgY3JlYXRpb24gZ29lcywgdGhpcyBtYXkgbm90IGJlIHRy
dWUgaW4gdGhlIGZ1dHVyZSBpZiBSb2INCj4gPiA+IGRlY2lkZXMgdG8gcmFuZG9taXplIHRoYXQs
IGJ1dCBBRkFJQ1QgdGhpcyBpcyBzdGlsbCB0cnVlLiBUaGlzIG1heSBub3QNCj4gPiA+IHdvcmsg
d2VsbCB3aXRoIHN0YXR1cyA9IGRpc2FibGVkIHByb3BlcnRpZXMgYmVpbmcgaW5zZXJ0ZWQgaGVy
ZSBhbmQNCj4gPiA+IHRoZXJlLCBidXQgd2UgaGF2ZSB1c2VkIHRoYXQgaGVyZSBhbmQgaXQgaGFz
IHdvcmtlZCBmb3IgYXMgZmFyIGFzIEkgY2FuDQo+ID4gPiByZW1lbWJlciBkb2luZyBpdC4NCj4g
PiANCj4gPiBJIHJlY2FsbCBpdCBpcyB0aGUgb3JkZXIgaW4gd2hpY2ggdGhlIGV0aCBhbGlhcyBh
cHBlYXIgdGhhdCBjb250cm9scyB0aGUgbmFtaW5nLA0KPiA+IG5vdCAxMDAlIHN1cmUgdGhvdWdo
Lg0KPiANCj4gQWxpYXNlcyBhcmUgbm90IGxvb2tlZCB1cCBhdCBhbGwgYnkgdGhlIHBsYXRmb3Jt
IGJ1cyBjb2RlIG90aGVyIHRoYXQNCj4gd2l0aCBvZl9nZXRfYWxpYXMoKSBhbmQgZnJpZW5kcywg
aXQgaXMgdGhlIG9yZGVyIGluIHdoaWNoIHRoZSBub2RlcyBhcmUNCj4gZGVjbGFyZWQgaW4gdGhl
IERldmljZSBUcmVlLCBwcmVmZXJhYmx5IG9yZGVyZWQgYnkgYmFzZSBhZGRyZXNzIHRoYXQNCj4g
ZGljdGF0ZXMgdGhlIG9yZGVyIGluIHdoaWNoIHBsYXRmb3JtIGRldmljZXMgYXJlIGNyZWF0ZWQu
DQoNCkkgc2VlLCB0aGFua3MuDQoNCj4gDQo+ID4gPiBTZWNvbmQsIHlvdSBtaWdodCB3YW50IHRv
IG5hbWUgbmV0d29yayBkZXZpY2VzIGV0aFgsIGJ1dCB3aGF0IGlmIEkgd2FudA0KPiA+ID4gdG8g
bmFtZSB0aGVtIGV0aGVybmV0WCBvciBmb29YIG9yIGJhclg/IFNob3VsZCB3ZSBiZSBhY2NlcHRp
bmcgYQ0KPiA+ID4gbWVjaGFuaXNtIGluIHRoZSBrZXJuZWwgdGhhdCB3b3VsZCBhbGxvdyBzb21l
b25lIHRvIG5hbWUgdGhlIGludGVyZmFjZXMNCj4gPiA+IHRoZSB3YXkgdGhleSB3YW50IHN0cmFp
Z2h0IGZyb20gYSBuYW1lIGJlaW5nIHByb3ZpZGVkIGluIERldmljZSBUcmVlPw0KPiA+IA0KPiA+
IEkganVzdCB3YW50IHRvIGhhdmUgc3RhYmxlIGJvb3QgbmFtZXMsIGFrYSBldGhYLCB3aGljaCBj
YW4gZGVmaW5lZCBpbg0KPiA+IHRoZSBwbGF0Zm9ybXMgRFQuIFRoZW4gdXNlcnNwYWNlIGNhbiBn
byBmcm9tIHRoZXJlIHRvIHdoYXRldmVyIGl0IG5lZWRzLA0KPiA+IHVkZXYgY291bGQgcG9zc2li
bHkgdXNlIHRoZXNlIHN0YWJsZSBib290IG5hbWVzIHRvIGlkZW50aWZ5IHRoZSBJL0YncyB0byBy
ZW5hbWUuDQo+ID4gDQo+ID4gQVRNLCBpdCBpcyBwcmV0dHkgaGFyZCB0byBldmVuIHVzZSB1ZGV2
IHdoZW4gL3N5cy9jbGFzcy9uZXQvZXRoMC9kZXZpY2UvdWV2ZW50DQo+ID4gY2FuIGxvb2sgZGlm
ZmVyZW50IGV2ZW4gZm9yIE9GIGNyZWF0ZWQgaW50ZXJmYWNlcy4NCj4gDQo+IG5ldHdvcmsgZGV2
aWNlcyBoYXZlIGEgZ2F6aWxsaW9uIG9mIG90aGVyIHN5c2ZzIGF0dHJpYnV0ZXMgdGhhdCBhbGwg
bWFrZQ0KPiB0aGVtIHVuaXF1ZSBlbm91Z2ggdG8gY3JlYXRlIHN0YWJsZSBuYW1lcy4NCg0KVGhh
dCBpcyBraW5kIG9mIG15IHBvaW50LCB0aGVyZSBkb2Vzbid0IHNlZW0gdG8gYmUgYW55IHN0YWJs
ZSBzb3VyY2Ugb2YgaW5mbw0KdGhhdCBjYW4gYmUgcmVsaWVkIG9uLiBFYWNoIHBsYXRmb3JtL2Ry
aXZlciBpcyBpdCBvd24sIERUL09GIGNyZWF0ZWQgSS9GJ3Mgc2hvdWxkDQpsb29rIHRoZSBzYW1l
IGluIC9zeXMvY2xhc3MvbmV0L2V0aDAvZGV2aWNlL3VldmVudCBidXQgdGhhdCBpcyBub3Qgc28u
DQoNCkkgYW0gc3VyZSBJIGNhbiBmaW5kIHNvbWV0aGluZyB0aG91Z2guDQoNCj4gDQo+ID4gPiBB
bGlhc2VzIGFyZSBmaW5lIGZvciBwcm92aWRpbmcgcmVsYXRpdmUgc3RhYmlsaXR5IHdpdGhpbiB0
aGUgRGV2aWNlIFRyZWUNCj4gPiA+IGl0c2VsZiBhbmQgYm9vdCBwcm9ncmFtcyB0aGF0IG1pZ2h0
IG5lZWQgdG8gbW9kaWZ5IHRoZSBEZXZpY2UgVHJlZSAoZS5nOg0KPiA+ID4gaW5zZXJ0aW5nIE1B
QyBhZGRyZXNzZXMpIHN1Y2ggdGhhdCB5b3UgZG9uJ3QgaGF2ZSB0byBlbmNvZGUgbG9naWMgdG8N
Cj4gPiA+IHNlYXJjaCBmb3Igbm9kZXMgYnkgY29tcGF0aWJsZSBzdHJpbmdzIGV0Yy4gYnV0IG91
dHNpZGUgb2YgdGhhdCB1c2UNCj4gPiA+IGNhc2UsIGl0IHNlZW1zIHRvIG1lIHRoYXQgeW91IGNh
biByZXNvbHZlIGV2ZXJ5IG5hbWluZyBkZWNpc2lvbiBpbg0KPiA+ID4gdXNlci1zcGFjZS4NCj4g
PiANCj4gPiBXZWxsLCB5b3UgY2FuIHJlc29sdmUgTUFDIGFkZHJlc3MgYXNzaWdubWVudCBpbiB1
c2VyIHNwYWNlIHRvbyBidXQgbW9zdA0KPiA+IHdpbGwgYWdyZWUgdGhhdCBpcyBub3QgY29udmVu
aWVudC4gSSBzdWdnZXN0IGl0IGlzIGFsc28gaGFuZHkgdG8gaGF2ZQ0KPiA+IHNvbWUgY29udHJv
bCBvZiBJL0YgZW51bWVyYXRpb24oZXRoWCB0aGF0IGlzKSBmcm9tIHBsYXRmb3JtIGNvZGUgbGlr
ZSBEVC4NCj4gDQo+IElmIHRoYXQgaXMgd2hhdCB5b3UgZGVzaXJlIGJlY2F1c2UgeW91IGRvIG5v
dCB3YW50IHRvIHVzZSB1c2VyLXNwYWNlIHRvDQo+IGRvIHRoYXQgam9iLCB0aGF0IGlzIHByb2Jh
Ymx5IGZpbmUsIGl0J3Mgb3BlbiBzb3VyY2UgYWZ0ZXIgYWxsLCBhbiBub3QNCj4gZXZlcnkgcGF0
Y2ggaXMgYSBjYW5kaWRhdGUgZm9yIGJlaW5nIGluY2x1ZGVkIHVwc3RyZWFtLiBBIHBhdGNoIGRv
aW5nDQo+IHdoYXQgeW91IGRlc2NyaWJlIHdvdWxkIGxpa2VseSBiZSByZWplY3RlZCBhZ2Fpbi4N
Cj4gLS0NCg0KT2YgY291cnNlLCBidXQgSSBkaWRuJ3Qgc3RhcnQgdGhpcyB0aHJlYWQganVzdCB0
byBoYWNrIG15IG93biBwYXRjaC4gSSB3YW50ZWQNCmJ1eSBpbiBmcm9tIHRoZSBjb21tdW5pdHkg
YW5kIHRoYXQgaXMgbm90IGhhcHBlbmluZyBzbyBJIHdpbGwgcmVzdCBub3cuDQoNClRoYW5rcyB5
b3UgZm9yIHRha2luZyB0aGUgdGltZSB0byBkaXNjdXNzIHRoaXMsDQoNCiAgICAgICAgSm9ja2UN
Cg==
