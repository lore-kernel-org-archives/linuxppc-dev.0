Return-Path: <SRS0=3fZu=5I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D0EC1975A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 02:34:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E575420722
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 02:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="q6JKPxeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E575420722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48lz444ZNdzDqbG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 13:34:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=alliedtelesis.co.nz (client-ip=202.36.163.20;
 helo=gate2.alliedtelesis.co.nz;
 envelope-from=chris.packham@alliedtelesis.co.nz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz
 header.a=rsa-sha256 header.s=mail181024 header.b=q6JKPxeJ; 
 dkim-atps=neutral
X-Greylist: delayed 410 seconds by postgrey-1.36 at bilbo;
 Mon, 23 Mar 2020 13:32:52 AEDT
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48lz1w0XQYzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2020 13:32:51 +1100 (AEDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 55C088364E;
 Mon, 23 Mar 2020 15:25:59 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1584930359;
 bh=bWdvbtemEJH5lhjVe6KKJq6aIJiapPUHg8GUIOQKP58=;
 h=From:To:CC:Subject:Date;
 b=q6JKPxeJm915cOn42ahIgqRs8L/iiU+JrFLy6bejb8rmLICoRUQA1WHi7arJsi1gN
 BXGUky/EV8C8ogy/iU3lOMPZv/jfJNso1FSTR00bdEXeYXKvKlaUlfBFAG1CxH5LXV
 sfS5v2ijMpsluoeQ7oXXDTnwWRNFsMS0xsA/pQ+LfoGd2eWSYUxo7u6Yuojex0Mj/x
 hQGWsY8rV/5hOfgP3LJnpKQMKPHbvLDLnvfZsz4arfCnAuFIwZKSoGdRc7+7ZvgBu9
 gT+bulINVs90irPiNRrZ4ZtQaNhGrMvkO+FPtkW/bUAoVUrD706v/r1ebK9cqsi6KG
 Ic46LpId8mO2Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by
 mmarshal3.atlnz.lc with Trustwave SEG (v7, 5, 8, 10121)
 id <B5e781e350000>; Mon, 23 Mar 2020 15:25:57 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Mar 2020 15:25:58 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Mon, 23 Mar 2020 15:25:58 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "cai@lca.pw" <cai@lca.pw>
Subject: Argh, can't find dcache properties !
Thread-Topic: Argh, can't find dcache properties !
Thread-Index: AQHWALpiXt3RJnRHvUCUrPyClavMpQ==
Date: Mon, 23 Mar 2020 02:25:57 +0000
Message-ID: <be8c123a90f6d1664a902b6ad6c754b9f3d9e567.camel@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.14.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <085B17206966C34EB5E44D3E6DDA78A6@atlnz.lc>
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
Cc: Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

SGkgQWxsLA0KDQpKdXN0IGJvb3RpbmcgdXAgdjUuNS4xMSBvbiBhIEZyZWVzY2FsZSBUMjA4MFJE
QiBhbmQgSSdtIHNlZWluZyB0aGUNCmZvbGxvd2luZyBtZXNhZ2UuDQoNCmtlcm4ud2FybmluZyBs
aW51eGJveCBrZXJuZWw6IEFyZ2gsIGNhbid0IGZpbmQgZGNhY2hlIHByb3BlcnRpZXMgIQ0Ka2Vy
bi53YXJuaW5nIGxpbnV4Ym94IGtlcm5lbDogQXJnaCwgY2FuJ3QgZmluZCBpY2FjaGUgcHJvcGVy
dGllcyAhDQoNClRoaXMgd2FzIGNoYW5nZWQgZnJvbSBEQkcoKSB0byBwcl93YXJuKCkgaW4gY29t
bWl0IDNiOTE3NmU5YTg3NA0KKCJwb3dlcnBjL3NldHVwXzY0OiBmaXggLVdlbXB0eS1ib2R5IHdh
cm5pbmdzIikgYnV0IHRoZSBtZXNzYWdlIHNlZW1zDQp0byBiZSBtdWNoIG9sZGVyIHRoYW4gdGhh
dC4gU28gaXQncyBwcm9iYWJseSBiZWVuIGFuIGlzc3VlIG9uIHRoZSBUMjA4MA0KKGFuZCBvdGhl
ciBRb3JJUSBTb0NzKSBmb3IgYSB3aGlsZS4NCg0KTG9va2luZyBhdCB0aGUgY29kZSB0aGUgdDIw
OHggZG9lc24ndCBzcGVjaWZpeSBhbnkgb2YgdGhlIGQtY2FjaGUtDQpzaXplL2ktY2FjaGUtc2l6
ZSBwcm9wZXJ0aWVzLiBTaG91bGQgSSBhZGQgdGhlbSB0byBzaWxlbmNlIHRoZSB3YXJuaW5nDQpv
ciBzd2l0Y2ggaXQgdG8gcHJfZGVidWcoKS9wcl9pbmZvKCk/DQoNClRoYW5rcywNCkNocmlzDQoN
Cg==
