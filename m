Return-Path: <linuxppc-dev+bounces-21921-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B2ECD6E60
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:28:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVP7h0Qqqz2xRs;
	Wed, 03 Jun 2026 07:28:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:df5:b000:5::4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780435679;
	cv=none; b=h1byflzYHr672IjPnq/66nkD8m4qhSwRufAWWliR+O8AMLdeXL4suJJolQx8FdOBS1N1ZTP6kbvbhqQBPYVWmy/JLyT0jUf6S6WJFp+ykh7KGZnMEAlaeUcbycqX7THhWNB45B3R3zIwStD5AumBN41Y+MMcagNgL+7NttFQMKE7U5l4BqjJA4/rP0F/Y1hZZtzB4dQ9sht15cHZ4FYpA80+ge6tfFagfk6zU78rJRwxjmpk7CgCbr5LtB1T0e/RiZnvW/S6nT1n78RxF3PVVp+slkYcOzHd7A3vY+1f4aekqgjuu0hh5yzTJ/DUGsSUpUwfZc79NTy6pdC6KMAkMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780435679; c=relaxed/relaxed;
	bh=QHJWUzaxAjAwO50jN0VRJ4HhHQ27C9Ov0iuJbjyggSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y60Jj5M3AeYJcCU4kDy3Y/eq0bzls52Y5g3W7E/eMYSwr3MRyp70cOzvmfcfUYfM2yinBjY21YsqApKCf+IdLudxU2JHhxocFOcuf4g2+sESf3gVl9jgWwwWPVXKM1owVQebT/ViMxQ1AtJ1zBBpwRT1/1IEX2raDUgSAf4+FOirOAScRvL6z7t04TBtzjvH/5Qb4mU7QKvXUfMqjqJBzfqU8UxRstl2XHGZaHsFe3kLZwFWqElsinrdBDQjZyWehcK1Fh0PFFe4wv9KSSMb5M76rZDKBJp2/iP8L24GthuWGOh4ek7fFWXf4+Qbt51TA71EtNuH+l/YSC/gwYM3qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=ZiYHZPZC; dkim-atps=neutral; spf=pass (client-ip=2001:df5:b000:5::4; helo=gate2.alliedtelesis.co.nz; envelope-from=chris.packham@alliedtelesis.co.nz; receiver=lists.ozlabs.org) smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=ZiYHZPZC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alliedtelesis.co.nz (client-ip=2001:df5:b000:5::4; helo=gate2.alliedtelesis.co.nz; envelope-from=chris.packham@alliedtelesis.co.nz; receiver=lists.ozlabs.org)
X-Greylist: delayed 552 seconds by postgrey-1.37 at boromir; Wed, 03 Jun 2026 07:27:58 AEST
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVP7f59N0z2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 07:27:58 +1000 (AEST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 32EA32C027A;
	Wed,  3 Jun 2026 09:18:40 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1780435120;
	bh=QHJWUzaxAjAwO50jN0VRJ4HhHQ27C9Ov0iuJbjyggSo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ZiYHZPZC7mvnQFOnz6AsYonAqcaVKoAJDjveI8uzJDR0Gef5PLojEcVciTMHvlB9z
	 Kqkrv2TE6vHJJEh4U663nWIoatwdHTfF1AMaswJhnzStZnB15L2dOnpKnkHOszLOaF
	 oQUN9eV1POnl/UdtU99LIImDlk1hIEGtIassFwZAAoXzs1AWo44H+hqQvJ1553EzOQ
	 GDnhwRfhzMawAOWUvKMVW8rm8RzlMt2fG3tFZiXVPwK277B3IJoq918IlQAKPg5tMc
	 HM0gZV+XQTleMWhPGwTb0b6Uh1bcBaHYMVRxMlCkWQ/Fg1znxX34cdFZOTsWiTVX5T
	 cobZ/m9c2iqjw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a1f48b00000>; Wed, 03 Jun 2026 09:18:40 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Wed, 3 Jun 2026 09:18:39 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Wed, 3 Jun 2026 09:18:39 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
	"yury.norov@gmail.com" <yury.norov@gmail.com>, "paulmck@kernel.org"
	<paulmck@kernel.org>, "romank@linux.microsoft.com"
	<romank@linux.microsoft.com>, "rafael.j.wysocki@intel.com"
	<rafael.j.wysocki@intel.com>, "riel@surriel.com" <riel@surriel.com>,
	"joelagnelf@nvidia.com" <joelagnelf@nvidia.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] smp: prevent soft lockup in smp_call_function_many_cond
Thread-Topic: [PATCH] smp: prevent soft lockup in smp_call_function_many_cond
Thread-Index: AQHc8tVh2nzsjYht7UeJGi2H6N5BUQ==
Date: Tue, 2 Jun 2026 21:18:39 +0000
Message-ID: <7a0693c5-8bda-403e-9889-f65f7f768356@alliedtelesis.co.nz>
References: <20260527031618.2940365-1-mark.tomlinson@alliedtelesis.co.nz>
In-Reply-To: <20260527031618.2940365-1-mark.tomlinson@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.33.22.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <971229E76A7A2A47AF90196FB95BE0E4@alliedtelesis.co.nz>
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
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Es1xrjcA c=1 sm=1 tr=0 ts=6a1f48b0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=h_iZXT0v-hxsJzBmdx4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

KGFkZGluZyBvdGhlcnMgc3VnZ2VzdGVkIGJ5IGdldF9tYWludGFpbmVyLnBsKQ0KDQpPbiAyNy8w
NS8yMDI2IDE1OjE2LCBNYXJrIFRvbWxpbnNvbiB3cm90ZToNCj4gVXNpbmcgdGhlIFBvd2VyUEMg
UDIwNDAgKGU1MDBtYykgQ1BVLCBzb2Z0IGxvY2t1cHMgY2FuIG9jY2FzaW9uYWxseSBiZQ0KPiBz
ZWVuIGluIHNtcF9jYWxsX2Z1bmN0aW9uX21hbnlfY29uZCgpLiBUaGUgY29uY2x1c2lvbiBpcyB0
aGF0IHRoaXMgQ1BVDQo+IGRvZXMgbm90IHByb2Nlc3MgdGhlIGRvb3JiZWxsIGludGVycnVwdCB3
aGlsZSBpbiBhIGRhdGEtc3RvcmFnZSAoTU1VKQ0KPiBleGNlcHRpb24uIElmIG1vcmUgdGhhbiBv
bmUgQ1BVIGluIGEgbXVsdGkgY29yZSBlbnZpcm9ubWVudCBpcyBjYWxsaW5nDQo+IHRoaXMgZnVu
Y3Rpb24gYXQgdGhlIHNhbWUgdGltZSwgaXQgaXMgcG9zc2libGUgZm9yIGEgZGVhZGxvY2sgdG8g
b2NjdXIuDQo+DQo+IFRoZSBmaXggZm9yIHRoaXMgaXMgdG8gY2FsbCBmbHVzaF9zbXBfY2FsbF9m
dW5jdGlvbl9xdWV1ZSgpIGJlZm9yZQ0KPiB3YWl0aW5nIGZvciByZXNwb25zZXMgZnJvbSBvdGhl
ciBDUFVzLiBJZiB0aGVyZSBpcyBzb21ldGhpbmcgaW4gdGhlDQo+IHF1ZXVlLCB0aGlzIGlzIGEg
Z29vZCB0aW1lIHRvIHByb2Nlc3MgaXQgYmVmb3JlIGJ1c3ktd2FpdGluZyBvbiBvdGhlcg0KPiBD
UFVzLiBPbiBvdGhlciBhcmNoaXRlY3R1cmVzIHRoaXMgY2FsbCB3aWxsIHF1aWNrbHkgZG8gbm90
aGluZywgYXMgdGhlDQo+IHF1ZXVlIHdpbGwgYmUgZW1wdHkuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IE1hcmsgVG9tbGluc29uIDxtYXJrLnRvbWxpbnNvbkBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiAt
LS0NCj4gICBrZXJuZWwvc21wLmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NtcC5jIGIva2VybmVsL3NtcC5jDQo+
IGluZGV4IGEwYmI1NmJkOGRkYS4uM2M0NDY3NjU0YWIwIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwv
c21wLmMNCj4gKysrIGIva2VybmVsL3NtcC5jDQo+IEBAIC04ODQsNiArODg0LDggQEAgc3RhdGlj
IHZvaWQgc21wX2NhbGxfZnVuY3Rpb25fbWFueV9jb25kKGNvbnN0IHN0cnVjdCBjcHVtYXNrICpt
YXNrLA0KPiAgIAkJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOw0KPiAgIAl9DQo+ICAgDQo+ICsJ
Zmx1c2hfc21wX2NhbGxfZnVuY3Rpb25fcXVldWUoKTsNCj4gKw0KPiAgIAlpZiAocnVuX3JlbW90
ZSAmJiB3YWl0KSB7DQo+ICAgCQlmb3JfZWFjaF9jcHUoY3B1LCBjZmQtPmNwdW1hc2spIHsNCj4g
ICAJCQljYWxsX3NpbmdsZV9kYXRhX3QgKmNzZDs=

