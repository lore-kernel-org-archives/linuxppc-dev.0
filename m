Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD03FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 22:08:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634BA21B1C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 22:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634BA21B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440rBc6N7fzDq75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 09:08:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=longman@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440r732B7fzDqWj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 09:05:34 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C965FC079C4C;
 Thu, 14 Feb 2019 22:05:31 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E104860BEC;
 Thu, 14 Feb 2019 22:05:27 +0000 (UTC)
Subject: Re: [PATCH v4 0/3] locking/rwsem: Rwsem rearchitecture part 0
To: Peter Zijlstra <peterz@infradead.org>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <20190214103715.GI32494@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <5c373ba6-419e-c4d5-965f-a566a6182b28@redhat.com>
Date: Thu, 14 Feb 2019 17:05:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190214103715.GI32494@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 14 Feb 2019 22:05:32 +0000 (UTC)
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-mips@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp,
 linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>,
 linux-um@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Tim Chen <tim.c.chen@linux.intel.com>, linux-parisc@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, nios2-dev@lists.rocketboards.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gMDIvMTQvMjAxOSAwNTozNyBBTSwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6Cj4gT24gV2Vk
LCBGZWIgMTMsIDIwMTkgYXQgMDU6MDA6MTRQTSAtMDUwMCwgV2FpbWFuIExvbmcgd3JvdGU6
Cj4+IHY0Ogo+PiAgLSBSZW1vdmUgcndzZW0tc3BpbmxvY2suYyBhbmQgbWFrZSBhbGwgYXJj
aHMgdXNlIHJ3c2VtLXhhZGQuYy4KPj4KPj4gdjM6Cj4+ICAtIE9wdGltaXplIF9fZG93bl9y
ZWFkX3RyeWxvY2soKSBmb3IgdGhlIHVuY29udGVuZGVkIGNhc2UgYXMgc3VnZ2VzdGVkCj4+
ICAgIGJ5IExpbnVzLgo+Pgo+PiB2MjoKPj4gIC0gQWRkIHBhdGNoIDIgdG8gb3B0aW1pemUg
X19kb3duX3JlYWRfdHJ5bG9jaygpIGFzIHN1Z2dlc3RlZCBieSBQZXRlclouCj4+ICAtIFVw
ZGF0ZSBwZXJmb3JtYW5jZSB0ZXN0IGRhdGEgaW4gcGF0Y2ggMS4KPj4KPj4gVGhlIGdvYWwg
b2YgdGhpcyBwYXRjaHNldCBpcyB0byByZW1vdmUgdGhlIGFyY2hpdGVjdHVyZSBzcGVjaWZp
YyBmaWxlcwo+PiBmb3IgcndzZW0teGFkZCB0byBtYWtlIGl0IGVhc2VyIHRvIGFkZCBlbmhh
bmNlbWVudHMgaW4gdGhlIGxhdGVyIHJ3c2VtCj4+IHBhdGNoZXMuIEl0IGFsc28gcmVtb3Zl
cyB0aGUgbGVnYWN5IHJ3c2VtLXNwaW5sb2NrLmMgZmlsZSBhbmQgbWFrZSBhbGwKPj4gdGhl
IGFyY2hpdGVjdHVyZXMgdXNlIG9uZSBzaW5nbGUgaW1wbGVtZW50YXRpb24gb2YgcndzZW0g
LSByd3NlbS14YWRkLmMuCj4+Cj4+IFdhaW1hbiBMb25nICgzKToKPj4gICBsb2NraW5nL3J3
c2VtOiBSZW1vdmUgYXJjaCBzcGVjaWZpYyByd3NlbSBmaWxlcwo+PiAgIGxvY2tpbmcvcndz
ZW06IFJlbW92ZSByd3NlbS1zcGlubG9jay5jICYgdXNlIHJ3c2VtLXhhZGQuYyBmb3IgYWxs
Cj4+ICAgICBhcmNocwo+PiAgIGxvY2tpbmcvcndzZW06IE9wdGltaXplIGRvd25fcmVhZF90
cnlsb2NrKCkKPiBBY2tlZC1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+Cj4KPiB3aXRoIHRoZSBjYXZlYXQgdGhhdCBJJ20gaGFwcHkgdG8gZXhj
aGFuZ2UgcGF0Y2ggMyBiYWNrIHRvIG15IGVhcmxpZXIKPiBzdWdnZXN0aW9uIGluIGNhc2Ug
V2lsbCBleHBlc3NlcyBjb25jZXJucyB3cnQgdGhlIEFSTTY0IHBlcmZvcm1hbmNlIG9mCj4g
TGludXMnIHN1Z2dlc3Rpb24uCgpJIGluc2VydGVkIGEgZmV3IGxvY2sgZXZlbnQgY291bnRl
cnMgaW50byB0aGUgcndzZW0gdHJ5bG9jayBjb2RlOgoKc3RhdGljIGlubGluZSBpbnQgX19k
b3duX3JlYWRfdHJ5bG9jayhzdHJ1Y3Qgcndfc2VtYXBob3JlICpzZW0pCnsKwqDCoMKgwqDC
oMKgwqAgLyoKwqDCoMKgwqDCoMKgwqDCoCAqIE9wdGltaXplIGZvciB0aGUgY2FzZSB3aGVu
IHRoZSByd3NlbSBpcyBub3QgbG9ja2VkIGF0IGFsbC4KwqDCoMKgwqDCoMKgwqDCoCAqLwrC
oMKgwqDCoMKgwqDCoCBsb25nIHRtcCA9IFJXU0VNX1VOTE9DS0VEX1ZBTFVFOwoKwqDCoMKg
wqDCoMKgwqAgbG9ja2V2ZW50X2luYyhyd3NlbV9ydHJ5bG9jayk7CsKgwqDCoMKgwqDCoMKg
IGRvIHsKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhdG9taWNfbG9uZ190
cnlfY21weGNoZ19hY3F1aXJlKCZzZW0tPmNvdW50LCAmdG1wLArCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdG1wICsgUldTRU1fQUNUSVZFX1JFQURfQklBUykpIHsKwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByd3NlbV9zZXRfcmVhZGVyX293
bmVkKHNlbSk7CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIDE7CsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9CsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb2NrZXZlbnRfaW5jKHJ3c2VtX3J0cnlsb2NrX3Jl
dHJ5KTsKwqDCoMKgwqDCoMKgwqAgfSB3aGlsZSAodG1wID49IDApOwrCoMKgwqDCoMKgwqDC
oCBsb2NrZXZlbnRfaW5jKHJ3c2VtX3J0cnlsb2NrX2ZhaWwpOwrCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gMDsKfQoKc3RhdGljIGlubGluZSBpbnQgX19kb3duX3dyaXRlX3RyeWxvY2soc3Ry
dWN0IHJ3X3NlbWFwaG9yZSAqc2VtKQp7CsKgwqDCoMKgwqDCoMKgIGxvbmcgdG1wOwoKwqDC
oMKgwqDCoMKgwqAgbG9ja2V2ZW50X2luYyhyd3NlbV93dHJ5bG9jayk7CsKgwqDCoMKgwqDC
oMKgIHRtcCA9IGF0b21pY19sb25nX2NtcHhjaGdfYWNxdWlyZSgmc2VtLT5jb3VudCwgUldT
RU1fVU5MT0NLRURfVkFMVUUsCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBSV1NFTV9BQ1RJVkVfV1JJVEVfQklBUyk7CsKgwqDCoMKgwqDCoMKgIGlmICh0
bXAgPT0gUldTRU1fVU5MT0NLRURfVkFMVUUpIHsKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJ3c2VtX3NldF9vd25lcihzZW0pOwrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIHRydWU7CsKgwqDCoMKgwqDCoMKgIH0KwqDCoMKgwqDCoMKgwqAgbG9j
a2V2ZW50X2luYyhyd3NlbV93dHJ5bG9ja19mYWlsKTsKwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IGZhbHNlOwp9CgpJIGJvb3RlZCB0aGUgbmV3IGtlcm5lbCBvbiBhIDQtc29ja2V0IDU2LWNv
cmUgMTEyLXRocmVhZCBCcm9hZHdlbGwKc3lzdGVtLiBUaGUgY291bnRlciB2YWx1ZXMKCjEp
IEFmdGVyIGJvb3R1cDoKCnJ3c2VtX3J0cnlsb2NrPTc4NDAyOQpyd3NlbV9ydHJ5bG9ja19m
YWlsPTU5CnJ3c2VtX3J0cnlsb2NrX3JldHJ5PTM5NApyd3NlbV93dHJ5bG9jaz0xODI4NApy
d3NlbV93dHJ5bG9ja19mYWlsPTIzMAoKMikgQWZ0ZXIgcGFyYWxsZWwga2VybmVsIGJ1aWxk
ICgtajExMik6Cgpyd3NlbV9ydHJ5bG9jaz0zMzg2Njc1NTkKcndzZW1fcnRyeWxvY2tfZmFp
bD0xOApyd3NlbV9ydHJ5bG9ja19yZXRyeT01MQpyd3NlbV93dHJ5bG9jaz0xNzAxNjMzMgpy
d3NlbV93dHJ5bG9ja19mYWlsPTk4MDU4CgpBdCBsZWFzdCBmb3IgdGhlc2UgdHdvIHVzZSBj
YXNlcywgdHJ5LWZvci1vd25lcnNoaXAgYXMgc3VnZ2VzdGVkIGJ5CkxpbnVzIGlzIHRoZSBy
aWdodCBjaG9pY2UuCgpDaGVlcnMsCkxvbmdtYW4KCg==
