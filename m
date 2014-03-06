Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 00FFD2C00BB
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2014 20:51:59 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 01127-01 for <linuxppc-dev@ozlabs.org>;
 Thu,  6 Mar 2014 09:45:17 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Sukadev Bhattiprolu' <sukadev@linux.vnet.ibm.com>, "Arnaldo Carvalho de
 Melo" <acme@ghostprotocols.net>
Subject: RE: [PATCH 3/3] perf: Use 64-bit value when comparing sample_regs
Date: Thu, 6 Mar 2014 09:44:47 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6D3983@AcuExch.aculab.com>
References: <1394080919-17957-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1394080919-17957-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1394080919-17957-4-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Michael Ellerman <michaele@au1.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stephane Eranian <eranian@google.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogU3VrYWRldiBCaGF0dGlwcm9sdQ0KPiBXaGVuIGNoZWNraW5nIHdoZXRoZXIgYSBiaXQg
cmVwcmVzZW50aW5nIGEgcmVnaXN0ZXIgaXMgc2V0IGluDQo+IHNhbXBsZV9yZWdzLCBhIDY0LWJp
dCBtYXNrLCB1c2UgNjQtYml0IHZhbHVlICgxTEwpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3Vr
YWRldiBCaGF0dGlwcm9sdSA8c3VrYWRldkBsaW51eC52bmV0LmlibS5jb20+DQo+IC0tLQ0KPiAg
dG9vbHMvcGVyZi91dGlsL3Vud2luZC5jIHwgICAgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rvb2xz
L3BlcmYvdXRpbC91bndpbmQuYyBiL3Rvb2xzL3BlcmYvdXRpbC91bndpbmQuYw0KPiBpbmRleCA3
NDJmMjNiLi4yYjg4OGM2IDEwMDY0NA0KPiAtLS0gYS90b29scy9wZXJmL3V0aWwvdW53aW5kLmMN
Cj4gKysrIGIvdG9vbHMvcGVyZi91dGlsL3Vud2luZC5jDQo+IEBAIC0zOTYsMTEgKzM5NiwxMSBA
QCBzdGF0aWMgaW50IHJlZ192YWx1ZSh1bndfd29yZF90ICp2YWxwLCBzdHJ1Y3QgcmVnc19kdW1w
ICpyZWdzLCBpbnQgaWQsDQo+ICB7DQo+ICAJaW50IGksIGlkeCA9IDA7DQo+IA0KPiAtCWlmICgh
KHNhbXBsZV9yZWdzICYgKDEgPDwgaWQpKSkNCj4gKwlpZiAoIShzYW1wbGVfcmVncyAmICgxTEwg
PDwgaWQpKSkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAgCWZvciAoaSA9IDA7IGkgPCBp
ZDsgaSsrKSB7DQo+IC0JCWlmIChzYW1wbGVfcmVncyAmICgxIDw8IGkpKQ0KPiArCQlpZiAoc2Ft
cGxlX3JlZ3MgJiAoMUxMIDw8IGkpKQ0KPiAgCQkJaWR4Kys7DQo+ICAJfQ0KDQpUaGVyZSBhcmUg
bXVjaCBmYXN0ZXIgd2F5cyB0byBjb3VudCB0aGUgbnVtYmVyIG9mIHNldCBiaXRzLCBlc3BlY2lh
bGx5DQppZiB5b3UgbWlnaHQgbmVlZCB0byBjaGVjayBhIHNpZ25pZmljYW50IG51bWJlciBvZiBi
aXRzLg0KVGhlcmUgbWlnaHQgZXZlbiBiZSBhIGZ1bmN0aW9uIGRlZmluZWQgc29tZXdoZXJlIHRv
IGRvIGl0Lg0KQmFzaWNhbGx5IHlvdSBqdXN0IGFkZCB1cCB0aGUgYml0cywgZm9yIDE2IGJpdCBp
dCB3b3VsZCBiZToNCgl2YWwgPSAodmFsICYgMHg1NTU1KSArICh2YWwgPj4gMSkgJiAweDU1NTU7
DQoJdmFsID0gKHZhbCAmIDB4MzMzMykgKyAodmFsID4+IDIpICYgMHgzMzMzOw0KCXZhbCA9ICh2
YWwgJiAweDBmMGYpICsgKHZhbCA+PiA0KSAmIDB4MGYwZjsNCgl2YWwgPSAodmFsICYgMHgwMGZm
KSArICh2YWwgPj4gOCkgJiAweDAwZmY7DQpBcyB0aGUgc2l6ZSBvZiB0aGUgd29yayBpbmNyZWFz
ZXMgdGhlIGltcHJvdmVtZW50IGlzIG1vcmUgc2lnbmlmaWNhbnQuDQooU29tZSBvZiB0aGUgbGF0
ZXIgbWFza2luZyBjYW4gcHJvYmFibHkgYmUgcHJvdmVuIHVubmVjZXNzYXJ5LikNCg0KCURhdmlk
DQoNCg==
