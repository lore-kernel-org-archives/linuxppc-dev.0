Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EAAC27C4F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2024 11:39:33 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=U4TZlGj1;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W5Fkq0xGwz3cY9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2024 21:39:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=U4TZlGj1;
	dkim-atps=neutral
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W5Fk10FTfz3cW1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2024 21:38:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718969923;
	bh=qNele2Oqe7XHnJ1CRHAoX0YzlVUc7SVZQpM/MCDav7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U4TZlGj1Jc9QFDIrMqe9M9fZu8bBXe+ZxW+kt7zsQ7QWJLMEH0RRKJ+GFTIw/3Awd
	 kEXyHWoKT2B0Pdn90yx3QUlxIplQQwtckG5ftIm5MCySSSF+l21T2xvIBGRj/H3RKR
	 V0qpGdDUKmlbTqYaIUUJAcPbvcmsAbJdB5kZpwiZijKlPmlYkRBqO0BkEFuMuI3vc8
	 +P3UmOMnw2VMqK+RRHSYUDIs2Aowe2tCwO2NDG/EbIWeA4owMu7Q7wUMs04B0RHfLg
	 pfx9e8TjLnJK589Sp9vYV5l0z1dqjlPnLwcPZHFHsMS5u0MbXqW8xC6k/hTmmryd/G
	 EKJSNRpHB+F0Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5Fjt6GVcz4wbr;
	Fri, 21 Jun 2024 21:38:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anjali K <anjalik@linux.ibm.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] powerpc/pseries: Whitelist dtl slub object for copying
 to userspace
In-Reply-To: <45c38d92-8d7c-466c-833d-0c2aa389eeda@linux.ibm.com>
References: <20240614173844.746818-1-anjalik@linux.ibm.com>
 <202406171053.F72BF013@keescook> <87cyoe67zg.fsf@mail.lhotse>
 <45c38d92-8d7c-466c-833d-0c2aa389eeda@linux.ibm.com>
Date: Fri, 21 Jun 2024 21:38:41 +1000
Message-ID: <87zfrecypq.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
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
Cc: npiggin@gmail.com, naveen@kernel.org, christophe.leroy@csgroup.eu, gustavoars@kernel.org, linux-hardening@vger.kernel.org, vishalc@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

QW5qYWxpIEsgPGFuamFsaWtAbGludXguaWJtLmNvbT4gd3JpdGVzOg0KPiBIaSBNaWNoYWVsDQo+
DQo+IE9uIDE4LzA2LzI0IDEyOjQxLCBNaWNoYWVsIEVsbGVybWFuIHdyb3RlOg0KPj4gSSBndWVz
cyB0aGVyZSBpc24ndCBhIGttZW1fY2FjaGVfY3JlYXRlX3VzZXJfcmVhZG9ubHkoKSA/DQoNCj4g
VGhhbmsgeW91IGZvciB5b3VyIHJldmlldy7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIMKgDQo+IA0KPiBNeSB1bmRlcnN0YW5kaW5nIG9mIHRoZSBxdWVzdGlvbiBp
cyB3aGV0aGVyIHRoZXJlJ3MgYSB3YXkgdG8gd2hpdGVsaXN0IGHCoCDCoA0KPiByZWdpb24gc3Vj
aCB0aGF0IGl0IGNhbiBiZSBjb3BpZWQgdG8gdXNlcnNwYWNlLCBidXQgbm90IHdyaXR0ZW4gdG8g
dXNpbmfCoCDCoA0KPiBjb3B5X2Zyb21fdXNlcigpLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgwqANCiANClllcyB0aGF0J3Mgd2hh
dCBJIG1lYW50LCBhbmQgSSBwcmV0dHkgbXVjaCB3b3JrZWQgdGhhdCBvdXQgZnJvbSBsb29raW5n
DQphdCB0aGUgaW1wbGVtZW50YXRpb24sIGJ1dCB3YXMgaG9waW5nIEtlZXMgd291bGQgdGVsbCBt
ZSBpdCB3YXMgdGhlcmUNCnNvbWV3aGVyZSwgb3IgaW1wbGVtZW50IGl0IDopICBBcG9sb2dpZXMg
Zm9yIGJlaW5nIGNyeXB0aWMuDQoNCj4gTm8sIHdlIGRvbid0IGhhdmUgYSBmdW5jdGlvbiB0byB3
aGl0ZWxpc3Qgb25seSBmb3IgY29weV90b191c2VyKCkgYW5kIG5vdCDCoA0KPiBjb3B5X2Zyb21f
dXNlcigpLg0KDQpZZXAuIEknbGwgdGFrZSB0aGlzIHBhdGNoIGFzLWlzLCBJIHRoaW5rIHdlJ3Zl
IGVzdGFibGlzaGVkIHRoYXQgaXQncw0KcHJldHR5IGxvdyByaXNrIHRvIHdoaXRlbGlzdCB0aGUg
d2hvbGUgY2FjaGUuDQoNCmNoZWVycw0K
