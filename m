Return-Path: <linuxppc-dev+bounces-21398-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C808CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 13:20:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMQql718Yz3bnx;
	Fri, 22 May 2026 23:20:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:df5:b000:5::4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779338501;
	cv=none; b=AN42iSUYkhVghxpvfKa8vI/ruRfnVl687mbYR+nVuMJGzFXzNvjatCAX5vMnhqbA3AdxmvC8zhYl2Ev9HMI9Xfnv6ypPgFIFxPgOGsr2z3BaR38obQKgo6FyylP2vk+e3dcbQxJlbZqq2PovXDKiNzjdNO/DuZtdNVF99ALv/RZ9ZICjQHlNrw38PqOhfK+1gruI21pAnWfMu+K15/2jluobnhG5kdY7mTdEoU9J7k0xZ6Og/xgz5W8E9qT8FzJn+0rbgjWoNvntb2hutjPAiwvtCuow7JPVle+gGACDqIgJM7o312jfeD85p/hmbPr+jwiLirQRclQ320Gr6CtAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779338501; c=relaxed/relaxed;
	bh=leHkq+ZIhgQnUy8zHicrboKzqDnDISZWAVKjaKns08M=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hPrwgxItimDM81Vd8LFbgnhIrzNSjzFceldS9Uf5zaPuVqzaE41v/Akqwd2jBn+ylF2jBaCf/MrDJdM8ufDTu2be312yLPS5/t2Fjmv7UgeNCIOs1ttDno6QPtfCxwL5DoCbxHx2nvEAnOkJS8dg1VZZwML6ET+LNZwEFZ3ML6GEUPYOomc1QqbKxjydB0ExzCYog9r95hOGtcNM65bqzTb/pOP+DNr8wkv2G3UhndeFTTHw6gQZJJ3qD07TfE5vvJ4ja21dVhZTt/Gg5VSAzsrVCpkEI0pi1Jj3hM3mQzbAWwzl2W6FyO5I2f2cWREGnsfr7MAQmEAlhgtiFy5Zqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=HOkv/lkY; dkim-atps=neutral; spf=pass (client-ip=2001:df5:b000:5::4; helo=gate2.alliedtelesis.co.nz; envelope-from=mark.tomlinson@alliedtelesis.co.nz; receiver=lists.ozlabs.org) smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=HOkv/lkY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alliedtelesis.co.nz (client-ip=2001:df5:b000:5::4; helo=gate2.alliedtelesis.co.nz; envelope-from=mark.tomlinson@alliedtelesis.co.nz; receiver=lists.ozlabs.org)
X-Greylist: delayed 449 seconds by postgrey-1.37 at boromir; Thu, 21 May 2026 14:41:39 AEST
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLbN35bcwz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 14:41:39 +1000 (AEST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B07F72C02A7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 16:34:04 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1779338044;
	bh=leHkq+ZIhgQnUy8zHicrboKzqDnDISZWAVKjaKns08M=;
	h=From:To:Subject:Date:From;
	b=HOkv/lkY8iwQUAcn4kMAoNDPka6nzIHwHlratdVRbsaGmYHmTylLjTkmv6b88qPvE
	 izUUMIjyjnXb/H0HFoI3Uc+e3w2m0iw13IKDXFHxXC5zZfQsMgoZGWGAgjflZB5/0y
	 h67uc0TedC7gx4umLzoODeOpmRad2/ftdbzQYanF50FARkkPM3R0U6tXcn7Af+Azq6
	 ZT5rFOBO1F5JaaK6tO4NXz4WAnUBxP4PPfaACMEgcq8E02nleDQDV6wNftYb8i7iPd
	 5f3F6WOIo32Ck1J+RTFpDnD1nLX0JzrfAm+Wp9u8eQiY4nGAHAtpP8poXKgbiWZSXt
	 ulShkXAyaitxw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a0e8b3c0000>; Thu, 21 May 2026 16:34:04 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 21 May 2026 16:34:04 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Thu, 21 May 2026 16:34:04 +1200
From: Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Soft lockup in smp_call_function_many_cond
Thread-Topic: Soft lockup in smp_call_function_many_cond
Thread-Index: AQHc6NsNxuqTA/5in02SJojtOsbmBQ==
Date: Thu, 21 May 2026 04:34:04 +0000
Message-ID: <01acfc009123f85092da89ebbd977881a3563769.camel@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.33.23.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D229F11D7D94A04FB71E4C0C6850C8FA@alliedtelesis.co.nz>
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
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Es1xrjcA c=1 sm=1 tr=0 ts=6a0e8b3c a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=3pNRdvVr4ggA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=kMe0sndCTgKBlfrlQeMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

V2UgaGF2ZSBiZWVuIGV4cGVyaWVuY2luZyByYW5kb20gc29mdGxvY2t1cHMgd2l0aCBhIFAyMDQw
IChlNTAwbWMpIENQVS4NClRoZSByYXRlIG9mIHRoZXNlIG9jY3VycmluZyBpcyB2ZXJ5IGxvdy4N
ClRoZSBzdGFjayB0cmFjZSBhcHBlYXJzIGJlbG93Og0KDQp3YXRjaGRvZzogQlVHOiBzb2Z0IGxv
Y2t1cCAtIENQVSMwIHN0dWNrIGZvciAyNnMhIFtzeXN0ZW1kOjFdDQpDUFU6IDAgVUlEOiAwIFBJ
RDogMSBDb21tOiBzeXN0ZW1kIFRhaW50ZWQ6IEcgICAgICAgICAgIE8gICAgICAgNi4xMi44NSAj
MQ0KVGFpbnRlZDogW09dPU9PVF9NT0RVTEUNCkhhcmR3YXJlIG5hbWU6IHg5MzAgZTUwMG1jIDB4
ODAyMzAwMzIgQ29yZU5ldCBHZW5lcmljDQpOSVA6ICA4MDBmNmU4OCBMUjogODAwMWNhZTggQ1RS
OiA4MDAyOGU1MA0KUkVHUzogODEwMjljNDAgVFJBUDogMDkwMCAgIFRhaW50ZWQ6IEcgICAgICAg
ICAgIE8gICAgICAgICg2LjEyLjg1KQ0KTVNSOiAgMDAwMjkwMDIgPENFLEVFLE1FPiAgQ1I6IDQ4
MDQyODQyICBYRVI6IDIwMDAwMDAwDQoNCkdQUjAwOiA4MDAxY2FlOCA4MTAyOWQzMCA4MTA4MDAw
MCAwMDAwMDAwYyBhYmMyZGI3MCBhYmMyYjM4MCAwMDAwMDAwMQ0KODBkYjY5N2MNCkdQUjA4OiBh
YmMxMWI3MCAwMDAwMDAwMSAwMDAwMDAwMSAwMDAwMDAwZiA0ODA0Mjg0MiAxMDAzODAyMCAxMDBh
MDAwMA0KMDAwMDAwMDANCkdQUjE2OiAwMDAwMDAwMCA3ZmNmZjkwMCAwMDAwMDAwMSAwMDAwMDAw
MCBhYmMwMTNjMCAwMDAwMDAwMCAxMDAxM2RiMA0KNzdmYjhmZjANCkdQUjI0OiAwMDAwMDAwMSBh
ZTNhMWUxMCA4MTAyOWYxMCA4MDAxYzc5MCA4MTAyOWRhYyAwMDAwMDAwMCAwMDAwMDAwMA0KMDAw
MDAwMDANCk5JUCBbODAwZjZlODhdIHNtcF9jYWxsX2Z1bmN0aW9uX21hbnlfY29uZCsweDI5Yy8w
eDRhYw0KTFIgWzgwMDFjYWU4XSBfX2ZsdXNoX3RsYl9wYWdlKzB4ZTQvMHgxMDgNCkNhbGwgVHJh
Y2U6DQpbODEwMjlkMzBdIFswMDAwMDAwOF0gMHg4ICh1bnJlbGlhYmxlKQ0KWzgxMDI5ZDkwXSBb
ODAwMWNhZThdIF9fZmx1c2hfdGxiX3BhZ2UrMHhlNC8weDEwOA0KWzgxMDI5ZGQwXSBbODAwMTlj
NTRdIHB0ZXBfc2V0X2FjY2Vzc19mbGFncysweGNjLzB4MTIwDQpbODEwMjlkZjBdIFs4MDIwZThi
Y10gZG9fd3BfcGFnZSsweDE2MC8weGUyOA0KWzgxMDI5ZTQwXSBbODAyMTEzMDhdIGhhbmRsZV9t
bV9mYXVsdCsweDc1Yy8weGU3OA0KWzgxMDI5ZWQwXSBbODAwMTkwYTBdIGRvX3BhZ2VfZmF1bHQr
MHgxNTQvMHg2OTQNCls4MTAyOWYwMF0gWzgwMDAwOTFjXSBEYXRhU3RvcmFnZSsweDE1Yy8weDE4
MA0KDQpJIHN1c3BlY3QgdGhhdCB0aGUgaXNzdWUgaXMgbW9yZSB0aGFuIG9uZSBDUFUgaXMgcnVu
bmluZyB0aGlzIGNvZGUgcGF0aCBhdA0KdGhlIHNhbWUgdGltZSwgYW5kIHRoZSB0d28gYXJlIGRl
YWRsb2NrZWQgd2FpdGluZyBmb3IgYSByZXNwb25zZSBmcm9tIGVhY2gNCm90aGVyLiBNeSByZWFz
b25pbmcgZm9yIGlzIHRoYXQgdGhlIGZvbGxvd2luZyBwYXRjaCBmaXhlcyB0aGUgaXNzdWU6DQoN
CmRpZmYgLS1naXQgYS9rZXJuZWwvc21wLmMgYi9rZXJuZWwvc21wLmMNCmluZGV4IGZhNmZhZjUw
ZmI0My4uZDk4NmI1MDc1ZWI3IDEwMDY0NA0KLS0tIGEva2VybmVsL3NtcC5jDQorKysgYi9rZXJu
ZWwvc21wLmMNCkBAIC04NzUsNyArODc1LDcgQEAgc3RhdGljIHZvaWQgc21wX2NhbGxfZnVuY3Rp
b25fbWFueV9jb25kKGNvbnN0IHN0cnVjdA0KY3B1bWFzayAqbWFzaywNCiAgICAgICAgICAgICAg
ICBjc2RfZG9fZnVuYyhmdW5jLCBpbmZvLCBOVUxMKTsNCiAgICAgICAgICAgICAgICBsb2NhbF9p
cnFfcmVzdG9yZShmbGFncyk7DQogICAgICAgIH0NCi0NCisgICAgICAgZmx1c2hfc21wX2NhbGxf
ZnVuY3Rpb25fcXVldWUoKTsNCiAgICAgICAgaWYgKHJ1bl9yZW1vdGUgJiYgd2FpdCkgew0KICAg
ICAgICAgICAgICAgIGZvcl9lYWNoX2NwdShjcHUsIGNmZC0+Y3B1bWFzaykgew0KICAgICAgICAg
ICAgICAgICAgICAgICAgY2FsbF9zaW5nbGVfZGF0YV90ICpjc2Q7DQoNClRoYXQgaXMsIGFmdGVy
IG1ha2luZyBhIHJlcXVlc3QgdG8gdGhlIG90aGVyIENQVShzKSwgcHJvY2VzcyBvdXIgb3duIGxp
c3QuDQoNCkkgc3VzcGVjdCBJIHNob3VsZG4ndCBoYXZlIHRvIGRvIHRoaXMsIGFuZCB0aGUgcHJv
YmxlbSBsaWVzIGVsc2V3aGVyZTsNCnBlcmhhcHMgYW4gaW50ZXJydXB0IG5vdCBiZWluZyBlbmFi
bGVkPyBEb2VzIGFueW9uZSBoYXZlIGFueSBzdWdnZXN0aW9ucz8NCg0K

