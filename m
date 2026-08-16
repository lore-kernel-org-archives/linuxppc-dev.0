Return-Path: <linuxppc-dev+bounces-25895-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98916C5B572
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Aug 2026 23:19:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNX473Rylz2y1Y;
	Mon, 17 Aug 2026 09:19:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.36.163.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786922391;
	cv=none; b=NHZVI5ATFJ6uSn4PhFNMHdwVXdezx/REouC15gEB07l/dnqzj6dz+09Cxct/GBPqmxtVWd2vPWYeB9LYO/C3g5aitLUS9mknS8L9yTBt5QGifNnL58hTx5tXwM5liTMGPkk/PgMaz4kC/R+YwcyxEQjM5rV/EppfUI77kBV8fFK4piO/gOGYPzJefTVF/FEkWuAyB36aLnRNsaoRWgASblUzHP4J0zwqAsZNLMTL0QBP6bkRH0no9kCJNdQPCui2NdWOtyMzVJHNRMkYQ+8Vv6HBwp8ZLW2FL/54nNJK8B61Z3gXJA6UPlWKA/UY8NdRDiUUridlwg2eMCBldyXlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786922391; c=relaxed/relaxed;
	bh=JddUaa0wLJyC6eSU+yxvhJrBLSskqrBTBPGi8c6Tuww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iZaXhKGKRfv74jDJrZ/CRZrmHA3FWh+Z+pZ1cSF2fBjf+vvh0c5Q2pj4x4KMX5B/S204+aEqT4qgsKR7Ol1GnxbVDetS6h6yNNDTPSBTPjdUfJwpSp1o6VVDErb3oAeFW7b2gWVEc0DSkmUC5pVXKY04vS5a9EBHajCUjbKA7kkXyJykG+p6uLIoNAPDIWag+B7Ka7wHBoWp7mlklDgcgxg4zA02HAuA2bLs33e02VITRY2f9OU5BaSwPPAKS1NQ+rsyg+tnkBexN3Dg4vjZlMaFWliz2drz/LUvHr1yOR+9WMviPXRjxjwIitVQt5wOy/qiRNsvfH7iQqmr1ibKyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=N1i4pxtV; dkim-atps=neutral; spf=pass (client-ip=202.36.163.20; helo=gate2.alliedtelesis.co.nz; envelope-from=chris.packham@alliedtelesis.co.nz; receiver=lists.ozlabs.org) smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=N1i4pxtV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alliedtelesis.co.nz (client-ip=202.36.163.20; helo=gate2.alliedtelesis.co.nz; envelope-from=chris.packham@alliedtelesis.co.nz; receiver=lists.ozlabs.org)
X-Greylist: delayed 3300 seconds by postgrey-1.37 at boromir; Mon, 17 Aug 2026 09:19:50 AEST
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNX460vQZz2y0B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2026 09:19:49 +1000 (AEST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 168E52C01D7;
	Mon, 17 Aug 2026 09:32:10 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1786915930;
	bh=JddUaa0wLJyC6eSU+yxvhJrBLSskqrBTBPGi8c6Tuww=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=N1i4pxtVLgvcn+9ZtP+NKO0YeaJXIumjb0bTEbZWKAULW8zMI1Bmx2wbBEEVSlvR9
	 Eucafh1bXagxm4ADjS18kq6kfkbMQBLXfbyUWa/Yaii8z9zFdZXA5+/SdgOj5lU0W+
	 XH2N+jkSbRhnvnukdP1/fRTa3l5bGWw3v7AzgZgS4RKqGGtWqq8jUqCE4yznb8ivty
	 d9rbtJ82lNYRUokLY0NjxW4Z1kqPoVDlG2qlGIsn4m2ScWlZaXwaB3LPXNovYvdjS2
	 s5DBpk8yXebj5P5svgIyGfApOCBQR/akL638/+YDPJnrAxJSjoqG3aJJETaEZ+19+n
	 zb56oJHhKv+7g==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a822c590000>; Mon, 17 Aug 2026 09:32:09 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 17 Aug 2026 09:32:09 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Mon, 17 Aug 2026 09:32:09 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Liu Zhenlong <dragonliu2018@gmail.com>, "andi.shyti@kernel.org"
	<andi.shyti@kernel.org>, "jochen@scram.de" <jochen@scram.de>,
	"maddy@linux.ibm.com" <maddy@linux.ibm.com>, "vz@mleia.com" <vz@mleia.com>,
	"piotr.wojtaszczyk@timesys.com" <piotr.wojtaszczyk@timesys.com>
CC: "mpe@ellerman.id.uk" <mpe@ellerman.id.uk>, "npiggin@gmail.com"
	<npiggin@gmail.com>, "chleroy@kernel.org" <chleroy@kernel.org>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>,
	"neelegup@linux.vnet.ibm.com" <neelegup@linux.vnet.ibm.com>,
	"benh@kernel.crashing.org" <benh@kernel.crashing.org>, "wsa@kernel.org"
	<wsa@kernel.org>, "stigge@antcom.de" <stigge@antcom.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH 1/5] i2c: mpc: fix device_node refcount leak in
 fsl_i2c_probe()/fsl_i2c_remove()
Thread-Topic: [PATCH 1/5] i2c: mpc: fix device_node refcount leak in
 fsl_i2c_probe()/fsl_i2c_remove()
Thread-Index: AQHdLOGwizUCWCZB906ULMjP0xiw17aganMA
Date: Sun, 16 Aug 2026 21:32:09 +0000
Message-ID: <5d7663b2-628e-43d3-9077-fc3a8c0fe9b3@alliedtelesis.co.nz>
References: <20260815181204.2321-1-dragonliu2018@gmail.com>
 <20260815181204.2321-2-dragonliu2018@gmail.com>
In-Reply-To: <20260815181204.2321-2-dragonliu2018@gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.33.22.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <795203B68820D24CBB330239887239E9@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=CKmJXgrD c=1 sm=1 tr=0 ts=6a822c59 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=g5w_v8IkoF8M0yuuWAMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgTGl1DQoNCk9uIDE2LzA4LzIwMjYgMDY6MTIsIExpdSBaaGVubG9uZyB3cm90ZToNCj4gZnNs
X2kyY19wcm9iZSgpIGNhbGxzIG9mX25vZGVfZ2V0KCkgdG8gdGFrZSBhbiBleHRyYSByZWZlcmVu
Y2Ugb24gdGhlDQo+IHBsYXRmb3JtIGRldmljZSdzIG9mX25vZGUgd2hlbiBhc3NpZ25pbmcgaXQg
dG8gdGhlIGFkYXB0ZXIgZGV2aWNlLCBidXQNCj4gbmVpdGhlciB0aGUgcHJvYmUgZXJyb3IgcGF0
aCBub3IgZnNsX2kyY19yZW1vdmUoKSBkcm9wcyBpdC4NCj4NCj4gZGV2aWNlX3JlbGVhc2UoKSBk
b2VzIG5vdCBjYWxsIG9mX25vZGVfcHV0KCkgYW5kIGkyY19hZGFwdGVyX2Rldl9yZWxlYXNlKCkN
Cj4gb25seSBjb21wbGV0ZXMgYSBzdHJ1Y3QsIHNvIHRoZSBleHRyYSByZWZlcmVuY2UgaXMgbmV2
ZXIgcmVsZWFzZWQsIGxlYWtpbmcNCj4gdGhlIGRldmljZV9ub2RlIG9uIGV2ZXJ5IHByb2JlIGZh
aWx1cmUgYW5kIGV2ZXJ5IGFkYXB0ZXIgcmVtb3ZhbC4NCj4NCj4gQWRkIHRoZSBtYXRjaGluZyBv
Zl9ub2RlX3B1dCgpIHRvIGJvdGggcGF0aHMuDQo+DQo+IEluIHRoZSBwcm9iZSBlcnJvciBwYXRo
LCBpMmNfYWRkX251bWJlcmVkX2FkYXB0ZXIoKSBmYWlsdXJlIGRvZXMgbm90IHJ1bg0KPiBpMmNf
ZGVsX2FkYXB0ZXIoKSwgc28gb2Zfbm9kZV9wdXQoaTJjLT5hZGFwLmRldi5vZl9ub2RlKSBpcyBz
YWZlLg0KPg0KPiBJbiBmc2xfaTJjX3JlbW92ZSgpLCBpMmNfZGVsX2FkYXB0ZXIoKSBjbGVhcnMg
YWRhcC0+ZGV2IHdpdGggbWVtc2V0KCkgYXQNCj4gdGhlIGVuZCAoY29tbWl0IGJkNGJjM2RiZGVk
OSAoImkyYzogQ2xlYXIgaTJjX2FkYXB0ZXIuZGV2IG9uIGFkYXB0ZXINCj4gcmVtb3ZhbCIpKSwg
d2hpY2ggemVyb2VzIGFkYXAtPmRldi5vZl9ub2RlIGJlZm9yZSBvZl9ub2RlX3B1dCgpIHJ1bnMs
DQo+IHR1cm5pbmcgaXQgaW50byBhIG5vLW9wLiAgQ2FjaGUgdGhlIHBvaW50ZXIgYmVmb3JlIGNh
bGxpbmcNCj4gaTJjX2RlbF9hZGFwdGVyKCksIHRoZSBzYW1lIGFwcHJvYWNoIHVzZWQgaW4gaTJj
LW11eA0KPiAoaTJjX211eF9kZWxfYWRhcHRlcnMpIGFuZCBtdGQgKGNvbW1pdCA1NjU3MGJkYWQ1
ZTMgKCJtdGQ6IGNvcmU6IEZpeA0KPiByZWZjb3VudCBlcnJvciBpbiBkZWxfbXRkX2RldmljZSgp
IikpLg0KPg0KPiBDb21waWxlLXRlc3RlZCB3aXRoIGdjYy1wb3dlcnBjLWxpbnV4LWdudSBvbiBw
bWFjMzIgZGVmY29uZmlnOyBubw0KPiBoYXJkd2FyZSBhdmFpbGFibGUgZm9yIHJ1bnRpbWUgdGVz
dGluZy4NCj4NCj4gRml4ZXM6IDlmZDA0OTkyN2NjYiAoIm9mL2kyYzogR2VuZXJhbGl6ZSBPRiBz
dXBwb3J0IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQXNzaXN0ZWQtYnk6IENs
YXVkZTpjbGF1ZGUtb3B1cy01DQo+IFNpZ25lZC1vZmYtYnk6IExpdSBaaGVubG9uZyA8ZHJhZ29u
bGl1MjAxOEBnbWFpbC5jb20+DQoNCkkgZGlkIHdvbmRlciBpZiB0aGVyZSB3YXMgYSBiZXR0ZXIg
d2F5IG9mIGZpeGluZyB0aGlzIGdlbmVyaWNhbGx5IHNpbmNlIA0KaXQgYWZmZWN0cyBtdWx0aXBs
ZSBkcml2ZXJzIGUuZy4gZG9pbmcgdGhlIHB1dCBpbiBpMmNfZGVsX2FkYXB0ZXIoKSwgDQphZGRp
bmcgYSBkZXZtXyBmdW5jdGlvbiB0aGFuIGRlYWxzIHdpdGggdGhlIHJlZmVyZW5jZSBvciBqdXN0
IG5vdCANCmFjcXVpcmluZyB0aGUgcmVmZXJlbmNlICh3aGljaCBzZWVtcyB0byBiZSB3aGF0IFNQ
SSBkb2VzKS4NCg0KUmVnYXJkbGVzcyBmb3IgYW4gb2xkZXIgZHJpdmVyIGxpa2UgaTJjLW1wYyB0
aGlzIGlzIHByb2JhYmx5IGEgbWluaW1hbGx5IA0Kc2FuZSBmaXguDQoNClJldmlld2VkLWJ5OiBD
aHJpcyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQoNCj4gLS0t
DQo+ICAgZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1tcGMuYyB8IDYgKysrKystDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1tcGMuYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMt
bXBjLmMNCj4gaW5kZXggYTIxZmE0NWJkNjRjLi44MTgyZjdkYzNkMGYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtbXBjLmMNCj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2Vz
L2kyYy1tcGMuYw0KPiBAQCAtODY3LDggKzg2NywxMCBAQCBzdGF0aWMgaW50IGZzbF9pMmNfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqb3ApDQo+ICAgCWkyY19zZXRfYWRhcGRhdGEoJmky
Yy0+YWRhcCwgaTJjKTsNCj4gICANCj4gICAJcmVzdWx0ID0gaTJjX2FkZF9udW1iZXJlZF9hZGFw
dGVyKCZpMmMtPmFkYXApOw0KPiAtCWlmIChyZXN1bHQpDQo+ICsJaWYgKHJlc3VsdCkgew0KPiAr
CQlvZl9ub2RlX3B1dChpMmMtPmFkYXAuZGV2Lm9mX25vZGUpOw0KPiAgIAkJcmV0dXJuIHJlc3Vs
dDsNCj4gKwl9DQo+ICAgDQo+ICAgCXJldHVybiAwOw0KPiAgIH07DQo+IEBAIC04NzYsOCArODc4
LDEwIEBAIHN0YXRpYyBpbnQgZnNsX2kyY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpv
cCkNCj4gICBzdGF0aWMgdm9pZCBmc2xfaTJjX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpvcCkNCj4gICB7DQo+ICAgCXN0cnVjdCBtcGNfaTJjICppMmMgPSBwbGF0Zm9ybV9nZXRfZHJ2
ZGF0YShvcCk7DQo+ICsJc3RydWN0IGRldmljZV9ub2RlICpub2RlID0gaTJjLT5hZGFwLmRldi5v
Zl9ub2RlOw0KPiAgIA0KPiAgIAlpMmNfZGVsX2FkYXB0ZXIoJmkyYy0+YWRhcCk7DQo+ICsJb2Zf
bm9kZV9wdXQobm9kZSk7DQo+ICAgfTsNCj4gICANCj4gICBzdGF0aWMgaW50IF9fbWF5YmVfdW51
c2VkIG1wY19pMmNfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYp

