Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.185])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79F711A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 03:37:46 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Sowmini Varadhan' <sowmini.varadhan@oracle.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: RE: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock
 into finer graularity pools and lock
Date: Tue, 31 Mar 2015 15:15:33 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB118E4@AcuExch.aculab.com>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
In-Reply-To: <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "paulus@samba.org" <paulus@samba.org>,
 "anton@au1.ibm.com" <anton@au1.ibm.com>, "aik@au1.ibm.com" <aik@au1.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogU293bWluaSBWYXJhZGhhbg0KPiBJbnZlc3RpZ2F0aW9uIG9mIG11bHRpdGhyZWFkZWQg
aXBlcmYgZXhwZXJpbWVudHMgb24gYW4gZXRoZXJuZXQNCj4gaW50ZXJmYWNlIHNob3cgdGhlIGlv
bW11LT5sb2NrIGFzIHRoZSBob3R0ZXN0IGxvY2sgaWRlbnRpZmllZCBieQ0KPiBsb2Nrc3RhdCwg
d2l0aCBzb21ldGhpbmcgb2YgdGhlIG9yZGVyIG9mICAyMU0gY29udGVudGlvbnMgb3V0IG9mDQo+
IDI3TSBhY3F1aXNpdGlvbnMsIGFuZCBhbiBhdmVyYWdlIHdhaXQgdGltZSBvZiAyNiB1cyBmb3Ig
dGhlIGxvY2suDQo+IFRoaXMgaXMgbm90IGVmZmljaWVudC4gQSBtb3JlIHNjYWxhYmxlIGRlc2ln
biBpcyB0byBmb2xsb3cgdGhlIHBwYw0KPiBtb2RlbCwgd2hlcmUgdGhlIGlvbW11X21hcF90YWJs
ZSBoYXMgbXVsdGlwbGUgcG9vbHMsIGVhY2ggc3RyZXRjaGluZw0KPiBvdmVyIGEgc2VnbWVudCBv
ZiB0aGUgbWFwLCBhbmQgd2l0aCBhIHNlcGFyYXRlIGxvY2sgZm9yIGVhY2ggcG9vbC4NCj4gVGhp
cyBtb2RlbCBhbGxvd3MgZm9yIGJldHRlciBwYXJhbGxlbGl6YXRpb24gb2YgdGhlIGlvbW11IG1h
cCBzZWFyY2guDQoNCkkndmUgd29uZGVyZWQgd2hldGhlciB0aGUgaW9tbXUgc2V0dXAgZm9yIGV0
aGVybmV0IHJlY2VpdmUgKGluIHBhcnRpY3VsYXIpDQpjb3VsZCBiZSBtYWRlIG11Y2ggbW9yZSBl
ZmZpY2llbnQgaWYgdGhlcmUgd2VyZSBhIGZ1bmN0aW9uIHRoYXQNCndvdWxkIHVubWFwIG9uZSBi
dWZmZXIgYW5kIG1hcCBhIHNlY29uZCBidWZmZXI/DQpNeSB0aG91Z2h0IGlzIHRoYXQgaW9tbXUg
cHRlIGVudHJ5IHVzZWQgYnkgdGhlIG9sZCBidWZmZXIgY291bGQganVzdA0KYmUgbW9kaWZpZWQg
dG8gcmVmZXJlbmNlIHRoZSBuZXcgb25lLg0KSW4gZWZmZWN0IGVhY2ggcmluZyBlbnRyeSB3b3Vs
ZCBlbmQgdXAgdXNpbmcgYSBmaXhlZCBpb21tdSBwdGUuDQoNClRoZSBvdGhlciBxdWVzdGlvbiBp
cyBob3cgbXVjaCBkYXRhIGNhbiBiZSBjb3BpZWQgaW4gMjZ1cyA/DQpPbiBpb21tdSBzeXN0ZW1z
ICdjb3B5YnJlYWsnIGxpbWl0cyBvbiByZWNlaXZlIGFuZCB0cmFuc21pdA0KbWF5IG5lZWQgdG8g
YmUgcXVpdGUgaGlnaC4NCg0KCURhdmlkDQoNCg==
