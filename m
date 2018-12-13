Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CF4C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 19:48:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EFE82086D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 19:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="stxSFvW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EFE82086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43G44105kKzDr0w
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 06:48:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="stxSFvW+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (helo)
 smtp.helo=nam05-by2-obe.outbound.protection.outlook.com
 (client-ip=40.107.71.54; helo=nam05-by2-obe.outbound.protection.outlook.com;
 envelope-from=thomas.lendacky@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=amdcloud.onmicrosoft.com
 header.i=@amdcloud.onmicrosoft.com header.b="stxSFvW+"; 
 dkim-atps=neutral
Received: from NAM05-BY2-obe.outbound.protection.outlook.com
 (mail-eopbgr710054.outbound.protection.outlook.com [40.107.71.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43G41B0fZFzDqfX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 06:46:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK8TG67186BUChbeATFds9zvBXv8AsAISN24sv3wPZs=;
 b=stxSFvW+4NMehiGvfqrNlGULM+FRdt0HlH2USjIELn0MQpxXvQItE1CmRkCZsswhf+L7/93NiEiDgC2kh1CGSF8PXhbz2clt8MkDkTAD6aYDTQ0Kso3IbFxRZeNOFQF5+FrfFZ+8pQv8beFOj4geSo3VuO/92RTDWvCD0OFbEyc=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0543.namprd12.prod.outlook.com (10.162.1.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 19:45:58 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 19:45:58 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, Robin Murphy
 <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-direct: Fix return value of dma_direct_supported
Thread-Topic: [PATCH] dma-direct: Fix return value of dma_direct_supported
Thread-Index: AQHUW3OhFptGvYyAe0eCrvzwxT16ZaUO8xaAgAA/mwCAbk9TgA==
Date: Thu, 13 Dec 2018 19:45:57 +0000
Message-ID: <ebe0d4aa-5f37-cc40-4a80-cfe499d5b8e4@amd.com>
References: <20181003234746.3586.42014.stgit@localhost.localdomain>
 <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com>
 <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com>
In-Reply-To: <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0051.namprd05.prod.outlook.com
 (2603:10b6:803:41::28) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; SN1PR12MB0543;
 20:/z/HzlONN4D96Ss4kOWap9tjZJECbTb1D6dye19VWYuHu2Hrc2OPqH2bnZUx369pzoEmBmNWdpfmMrWn3VuQR0lj6WkUkDC2pXgHURr2wUYqtXSuGorTavau1tNp5hCQxVEcRP2EQ/TRU8gwL+5W+YekNUctCGymqtjfekXnRDoCLD4Pzq3fOCVN0juv6wbQ65ktfcpIDsVV5CS/n942IASnKEXeQs9cCjSz4g6+9fAhGgoA50hsU4eaz4c+cYNc
x-ms-office365-filtering-correlation-id: e86df2b7-a153-4702-acf9-08d6613399df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:SN1PR12MB0543; 
x-ms-traffictypediagnostic: SN1PR12MB0543:
x-microsoft-antispam-prvs: <SN1PR12MB05433D4EE57991B294CDB523ECA00@SN1PR12MB0543.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:SN1PR12MB0543; BCL:0; PCL:0; RULEID:; SRVR:SN1PR12MB0543; 
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(136003)(376002)(39860400002)(396003)(51914003)(199004)(189003)(52314003)(7416002)(8676002)(8936002)(81156014)(81166006)(966005)(5660300001)(14454004)(36756003)(31686004)(25786009)(478600001)(66066001)(72206003)(229853002)(7736002)(305945005)(105586002)(106356001)(99286004)(97736004)(256004)(26005)(6486002)(6436002)(6246003)(110136005)(39060400002)(54906003)(71200400001)(4326008)(186003)(6506007)(386003)(102836004)(53546011)(6306002)(31696002)(446003)(11346002)(476003)(486006)(53936002)(68736007)(6512007)(2616005)(86362001)(52116002)(76176011)(6116002)(71190400001)(2906002)(3846002)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB0543;
 H:SN1PR12MB0175.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rh9+T5HcukRSU+htgD8z8mC4ZHRw6InUTK6m/KbsMi1eNFgDuYlcjkThsEmwhS5o2xdqcfLNQB/mVqB2I1KHtYOhktvM/sq7EQJx6SEhUxV2x65zb0Rw1EFscn1My5r4bp3psp+xMxR+l63AT/YqaI4ZmZME3e4ST2PRfJtEfR5XymU3XnoVbnuuW7O+tPjeEKyl0ODxMDQ7GVwlvaPRmOWf2VNe5eHRtV+ECg1c73uVQyKg633mQ+QgYOBD7Kz3T4VINob4PZDF8dI6/cdFqe9yih+QFtrdsMcWigxLjYb9er1GUxCBiui3KJ8q1rU9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A476C45E58342046B6EFC4F230F8426C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e86df2b7-a153-4702-acf9-08d6613399df
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 19:45:57.7787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0543
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 "alexander.h.duyck@linux.intel.com" <alexander.h.duyck@linux.intel.com>,
 "open list:LINUX FOR POWERPC
 \(32-BIT AND 64-BIT\)" <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gMTAvMDQvMjAxOCAxMDoxMyBBTSwgQWxleGFuZGVyIER1eWNrIHdyb3RlOg0KPiBPbiBUaHUs
IE9jdCA0LCAyMDE4IGF0IDQ6MjUgQU0gUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNv
bT4gd3JvdGU6DQo+Pg0KPj4gT24gMDQvMTAvMTggMDA6NDgsIEFsZXhhbmRlciBEdXljayB3cm90
ZToNCj4+PiBJdCBhcHBlYXJzIHRoYXQgaW4gY29tbWl0IDlkN2EyMjRiNDYzZSAoImRtYS1kaXJl
Y3Q6IGFsd2F5cyBhbGxvdyBkbWEgbWFzaw0KPj4+IDw9IHBoeXNpc2NhbCBtZW1vcnkgc2l6ZSIp
IHRoZSBsb2dpYyBvZiB0aGUgdGVzdCB3YXMgY2hhbmdlZCBmcm9tIGEgIjwiIHRvDQo+Pj4gYSAi
Pj0iIGhvd2V2ZXIgSSBkb24ndCBzZWUgYW55IHJlYXNvbiBmb3IgdGhhdCBjaGFuZ2UuIEkgYW0g
YXNzdW1pbmcgdGhhdA0KPj4+IHRoZXJlIHdhcyBzb21lIGFkZGl0aW9uYWwgY2hhbmdlIHBsYW5u
ZWQsIHNwZWNpZmljYWxseSBJIHN1c3BlY3QgdGhlIGxvZ2ljDQo+Pj4gd2FzIGludGVuZGVkIHRv
IGJlIHJldmVyc2VkIGFuZCBwb3NzaWJseSB1c2VkIGZvciBhIHJldHVybi4gU2luY2UgdGhhdCBp
cw0KPj4+IHRoZSBjYXNlIEkgaGF2ZSBnb25lIGFoZWFkIGFuZCBkb25lIHRoYXQuDQo+Pg0KPj4g
QmFoLCBzZWVtcyBJIGdvdCBodW5nIHVwIG9uIHRoZSBtaW5fbWFzayBjb2RlIGFib3ZlIGl0IGFu
ZCB0b3RhbGx5DQo+PiBvdmVybG9va2VkIHRoYXQgdGhlIGNvbmRpdGlvbiBpdHNlbGYgZ290IGZs
aXBwZWQuIEl0IHByb2JhYmx5IGFsc28gY2FuJ3QNCj4+IGhlbHAgdGhhdCBpdCdzIGFuIGludCBy
ZXR1cm4gdHlwZSwgYnV0IHRyZWF0ZWQgYXMgYSBib29sIGJ5IGNhbGxlcnMNCj4+IHJhdGhlciB0
aGFuICIwIGZvciBzdWNjZXNzIiBhcyBpbnQgdGVuZHMgdG8gaW1wbHkgaW4gaXNvbGF0aW9uLg0K
Pj4NCj4+IEFueXdheSwgcGF5aW5nIGEgYml0IG1vcmUgYXR0ZW50aW9uIHRoaXMgdGltZSwgSSB0
aGluayB0aGlzIGxvb2tzIGxpa2UNCj4+IHRoZSByaWdodCBmaXggLSBjaGVlcnMgQWxleC4NCj4+
DQo+PiBSb2Jpbi4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJldmlldy4NCj4gDQo+IC0gQWxleA0K
PiANCj4gUC5TLiBJdCBsb29rcyBsaWtlIEkgZm9yZ290IHRvIGFkZCBDaHJpc3RvcGggdG8gdGhl
IG9yaWdpbmFsIG1haWwNCj4gc2luY2UgSSBoYWQganVzdCBjb3BpZWQgdGhlIFRvIGFuZCBDYyBm
cm9tIHRoZSBvcmlnaW5hbCBzdWJtaXNzaW9uLCBzbw0KPiBJIGFkZGVkIGhpbSB0byB0aGUgQ2Mg
Zm9yIHRoaXMuDQo+IA0KPj4+IFRoaXMgYWRkcmVzc2VzIGlzc3VlcyBJIGhhZCBvbiBteSBzeXN0
ZW0gdGhhdCBwcmV2ZW50ZWQgbWUgZnJvbSBib290aW5nDQo+Pj4gd2l0aCB0aGUgYWJvdmUgbWVu
dGlvbmVkIGNvbW1pdCBhcHBsaWVkIG9uIGFuIHg4Nl82NCBzeXN0ZW0gdy8gSW50ZWwgSU9NTVUu
DQo+Pj4NCj4+PiBGaXhlczogOWQ3YTIyNGI0NjNlICgiZG1hLWRpcmVjdDogYWx3YXlzIGFsbG93
IGRtYSBtYXNrIDw9IHBoeXNpc2NhbCBtZW1vcnkgc2l6ZSIpDQo+Pj4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZGVyIER1eWNrIDxhbGV4YW5kZXIuaC5kdXlja0BsaW51eC5pbnRlbC5jb20+DQo+Pj4g
LS0tDQo+Pj4gICBrZXJuZWwvZG1hL2RpcmVjdC5jIHwgICAgNCArLS0tDQo+Pj4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0t
Z2l0IGEva2VybmVsL2RtYS9kaXJlY3QuYyBiL2tlcm5lbC9kbWEvZGlyZWN0LmMNCj4+PiBpbmRl
eCA1YTA4MDZiNTM1MWIuLjY1ODcyZjZjMmU5MyAxMDA2NDQNCj4+PiAtLS0gYS9rZXJuZWwvZG1h
L2RpcmVjdC5jDQo+Pj4gKysrIGIva2VybmVsL2RtYS9kaXJlY3QuYw0KPj4+IEBAIC0zMDEsOSAr
MzAxLDcgQEAgaW50IGRtYV9kaXJlY3Rfc3VwcG9ydGVkKHN0cnVjdCBkZXZpY2UgKmRldiwgdTY0
IG1hc2spDQo+Pj4NCj4+PiAgICAgICBtaW5fbWFzayA9IG1pbl90KHU2NCwgbWluX21hc2ssICht
YXhfcGZuIC0gMSkgPDwgUEFHRV9TSElGVCk7DQo+Pj4NCj4+PiAtICAgICBpZiAobWFzayA+PSBw
aHlzX3RvX2RtYShkZXYsIG1pbl9tYXNrKSkNCj4+PiAtICAgICAgICAgICAgIHJldHVybiAwOw0K
Pj4+IC0gICAgIHJldHVybiAxOw0KPj4+ICsgICAgIHJldHVybiBtYXNrID49IHBoeXNfdG9fZG1h
KGRldiwgbWluX21hc2spOw0KDQpTbyBJIHRoaW5rIHRoaXMgbmVlZHMgdG8gYmUgX19waHlzX3Rv
X2RtYSgpIGhlcmUuIEkgb25seSByZWNlbnRseSBnb3QgYQ0Kc3lzdGVtIHRoYXQgaGFkIGEgZGV2
aWNlIHdoZXJlIHRoZSBkcml2ZXIgb25seSBzdXBwb3J0ZWQgMzItYml0IERNQSBhbmQNCmZvdW5k
IHRoYXQgd2hlbiBTTUUgaXMgYWN0aXZlIHRoaXMgcmV0dXJucyAwIGFuZCBjYXVzZXMgdGhlIGRy
aXZlciB0byBmYWlsDQp0byBpbml0aWFsaXplLiBUaGlzIGlzIGJlY2F1c2UgdGhlIFNNRSBlbmNy
eXB0aW9uIGJpdCAoYml0IDQ3KSBpcyBwYXJ0IG9mDQp0aGUgY2hlY2sgd2hlbiB1c2luZyBwaHlz
X3RvX2RtYSgpLiBEdXJpbmcgYWN0dWFsIERNQSB3aGVuIFNNRSBpcyBhY3RpdmUsDQpib3VuY2Ug
YnVmZmVycyB3aWxsIGJlIHVzZWQgZm9yIGFueXRoaW5nIHRoYXQgY2FuJ3QgbWVldCB0aGUgNDgt
Yml0DQpyZXF1aXJlbWVudC4gQnV0IGZvciB0aGlzIHRlc3QsIHVzaW5nIF9fcGh5c190b19kbWEo
KSBzaG91bGQgZ2l2ZSB0aGUNCmRlc2lyZWQgcmVzdWx0cywgcmlnaHQ/DQoNCklmIHlvdSBhZ3Jl
ZSB3aXRoIHRoaXMsIEknbGwgc3VibWl0IGEgcGF0Y2ggdG8gbWFrZSB0aGUgY2hhbmdlLiBJIG1p
c3NlZA0KdGhpcyBpbiA0LjE5LCBzbyBJJ2xsIG5lZWQgdG8gc3VibWl0IHNvbWV0aGluZyB0byBz
dGFibGUsIHRvby4gVGhlIG9ubHkNCmlzc3VlIHRoZXJlIGlzIHRoZSA0LjIwIGZpeCB3b24ndCBh
cHBseSBjbGVhbmx5IHRvIDQuMTkuDQoNClRoYW5rcywNClRvbQ0KDQo+Pj4gICB9DQo+Pj4NCj4+
PiAgIGludCBkbWFfZGlyZWN0X21hcHBpbmdfZXJyb3Ioc3RydWN0IGRldmljZSAqZGV2LCBkbWFf
YWRkcl90IGRtYV9hZGRyKQ0KPj4+DQo+Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18NCj4+PiBpb21tdSBtYWlsaW5nIGxpc3QNCj4+PiBpb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KPj4+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11DQo+Pj4NCj4+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+PiBpb21tdSBtYWlsaW5nIGxpc3QNCj4+IGlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnDQo+PiBodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ0K
