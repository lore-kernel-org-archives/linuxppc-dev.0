Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046DDC10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 08:15:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0401B20873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 08:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="fiVNTUt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0401B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fv3g3DW0zDqQZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 18:15:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=alliedtelesis.co.nz
 (client-ip=202.36.163.20; helo=gate2.alliedtelesis.co.nz;
 envelope-from=hamish.martin@alliedtelesis.co.nz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz
 header.b="fiVNTUt4"; dkim-atps=neutral
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fv1m4JwDzDqPM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 18:14:03 +1000 (AEST)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 669B8806AC;
 Thu, 11 Apr 2019 15:28:11 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1554953291;
 bh=J3lrMsxPFbCfmkIv/OghdQDaJ4xqzoVrL2tATR3m9cY=;
 h=From:To:CC:Subject:Date;
 b=fiVNTUt4DEDprMx5TVvAgf9unlyPL2dG3SY3AIqYq8dpOW5rjVDVUewd+Vl5H461Q
 ScnnXlwoufr/ttST+ZzslSakL1u70jvqBSAMRFyOund54pw73AMFzBpXNA8V9aQcwh
 6UKfNdw3gYtYcBvkkNFEILu0+RjyGN/gIJBR3hVyDk2N7a2i0Seul6/8xHIh0//iLJ
 Kk/sGWL02zYHuoO3vegwd9vi4Hr/AhgbpdFF0rQuAw4eYq7in3KURovedA2xl9Vfqz
 OKsHpEHVZ/XLYDvpLWHQcKKi/bdOw+BFRgyDqwB+8Bi7A6l9YF10hqopp0KEPp7nS4
 70uIR2t0ZuaGg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by
 mmarshal3.atlnz.lc with Trustwave SEG (v7, 5, 8, 10121)
 id <B5caeb44b0000>; Thu, 11 Apr 2019 15:28:11 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 11 Apr 2019 15:28:11 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 11 Apr 2019 15:28:11 +1200
From: Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>
Subject: Backwards compatiblity for QorIQ FMAN LIODN entries
Thread-Topic: Backwards compatiblity for QorIQ FMAN LIODN entries
Thread-Index: AQHU8BaWI/C4NayY00yPFjy8afmlPg==
Date: Thu, 11 Apr 2019 03:28:10 +0000
Message-ID: <1554953290.3747.66.camel@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:24:3a2c:4aff:fe70:2ab9]
Content-Type: text/plain; charset="utf-8"
Content-ID: <67A1AA396ADF3348A0C67EB6174FC3FE@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgUm9iIGFuZCBNYXJrLA0KDQpJIGFtIHVwZ3JhZGluZyB0aGUga2VybmVsIG9uIGEgRnJlZXNj
YWxlIFAyMDQwIGJhc2VkIHN5c3RlbSBhbmQgaGF2ZQ0Kc3RydWNrIGFuIGlzc3VlIHdpdGggTElP
RE5zIG5vdCBiZWluZyB1cGRhdGVkIGJ5IHVib290IGZvciBhbiBGTUFODQpldGhlcm5ldCBwb3J0
Lg0KDQpNeSBzeXN0ZW0gaGFzIGFuIG9sZCB1Ym9vdCBydW5uaW5nIHdoaWNoIGZhaWxzIGluIGl0
cyBhdHRlbXB0IHRvIHVwZGF0ZQ0KdGhlIGZtYW4gcnggcG9ydCBub2RlIHdpdGggdGhlIHJlcXVp
cmVkIExJT0ROIGVudHJ5LiBUaGlzIGlzIGJlY2F1c2UgbXkNCm9sZCB1Ym9vdCBpbnN0YWxsYXRp
b24gaXMgbG9va2luZyBmb3IgY29tcGF0aWJpbGl0eSB2YWx1ZSAiZnNsLGZtYW4tDQpwb3J0LTFn
LXJ4IiB3aGlsZSB0aGUgbGF0ZXN0IGtlcm5lbCBkZWZpbmVzIHRoZSBjb21wYXRpYmxlIHZhbHVl
IGFzDQoiZnNsLGZtYW4tdjItcG9ydC1yeCIgKHNlZSBmb3INCmluc3RhbmNlwqBhcmNoL3Bvd2Vy
cGMvYm9vdC9kdHMvZnNsL3FvcmlxLWZtYW4tMC0xZy0zLmR0c2kpLg0KTmV3ZXIgdWJvb3QgbG9v
a3MgZm9yIGJvdGggdmFsdWVzIHBlciB0aGlzIGNvbW1pdDoNCmh0dHBzOi8vZ2l0aHViLmNvbS91
LWJvb3QvdS1ib290L2NvbW1pdC85N2E4ZDAxMGUwMjkxMTFlNTcxMWE0NTI2NGE3MjZiDQplZGJl
YjI0YzQjZGlmZi00MzI0M2I5MTA4MzcyODNiYjFkNWQ2MjZmNGQ4OWQ3NQ0KDQpJIGFtIHVuYWJs
ZSB0byB1cGRhdGUgYm9vdGxvYWRlcnMgZm9yIGRldmljZXMgb2YgdGhpcyB0eXBlIGluIHRoZSBm
aWVsZA0Kc28gSSBhbSB3b25kZXJpbmcgaWYgdGhlIGNvcnJlY3QgYXBwcm9hY2ggaXMgdG8gYWRq
dXN0IG15IERUUyBmaWxlDQpsb2NhbGx5IHRvIGFkZCB0aGUgY29tcGF0aWJsZSBzdHJpbmcgbXkg
b2xkIHVib290IGlzIHNlYXJjaGluZyBmb3IsIG9yDQppZiB3ZSBzaG91bGQgYWRkIHRoaXMgdG8g
dGhlIHZhcmlvdXMgcW9yaXEtZm1hbiBkdHNpIGZpbGVzIGluIHRoZQ0Ka2VybmVsIHRvIG1ha2Ug
dGhpcyB3b3JrIGluIGEgbmljZSBiYWNrd2FyZHMgY29tcGF0aWJsZSB3YXkuDQoNCkxldCBtZSBr
bm93IHlvdXIgb3Bpbmlvbi4gSSdtIGhhcHB5IHRvIHdvcmsgdXAgYSBwYXRjaCBpZiB5b3UnZCBs
aWtlIHRvDQptYWtlIHRoZSBjaGFuZ2UgaW4gdGhlIGtlcm5lbCwgb3RoZXJ3aXNlIEknbGwgaGFu
ZGxlIGl0IGxvY2FsbHkgYnkNCm92ZXJyaWRpbmcgdGhlIGNvbXBhdGlibGUgc3RyaW5nIGluIG15
IHN5c3RlbSdzIGR0cyBmaWxlLg0KDQpUaGFua3MsDQpIYW1pc2ggTQ==
