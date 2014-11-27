Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 857CA1A099F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 01:07:13 +1100 (AEDT)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 32370-02 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 27 Nov 2014 14:07:03 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Madhavan Srinivasan' <maddy@linux.vnet.ibm.com>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>
Subject: RE: [RFC PATCH 0/2] powerpc: CR based local atomic operation
 implementation
Date: Thu, 27 Nov 2014 14:05:55 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1C9FDC8B@AcuExch.aculab.com>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "rusty@rustcorp.com.au" <rusty@rustcorp.com.au>,
 "paulus@samba.org" <paulus@samba.org>, "anton@samba.org" <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogTWFkaGF2YW4gU3Jpbml2YXNhbg0KPiBUaGlzIHBhdGNoc2V0IGNyZWF0ZSB0aGUgaW5m
cmFzdHJ1Y3R1cmUgdG8gaGFuZGxlIHRoZSBDUiBiYXNlZA0KPiBsb2NhbF8qIGF0b21pYyBvcGVy
YXRpb25zLiBMb2NhbCBhdG9taWMgb3BlcmF0aW9ucyBhcmUgZmFzdA0KPiBhbmQgaGlnaGx5IHJl
ZW50cmFudCBwZXIgQ1BVIGNvdW50ZXJzLiAgVXNlZCBmb3IgcGVyY3B1DQo+IHZhcmlhYmxlIHVw
ZGF0ZXMuIExvY2FsIGF0b21pYyBvcGVyYXRpb25zIG9ubHkgZ3VhcmFudGVlDQo+IHZhcmlhYmxl
IG1vZGlmaWNhdGlvbiBhdG9taWNpdHkgd3J0IHRoZSBDUFUgd2hpY2ggb3ducyB0aGUNCj4gZGF0
YSBhbmQgdGhlc2UgbmVlZHMgdG8gYmUgZXhlY3V0ZWQgaW4gYSBwcmVlbXB0aW9uIHNhZmUgd2F5
Lg0KDQpUaGVzZSBhcmUgdXN1YWxseSBjYWxsZWQgJ3Jlc3RhcnRhYmxlIGF0b21pYyBzZXF1ZW5j
ZXMgKFJBUyknLg0KDQo+IEhlcmUgaXMgdGhlIGRlc2lnbiBvZiB0aGUgZmlyc3QgcGF0Y2guIFNp
bmNlIGxvY2FsXyogb3BlcmF0aW9ucw0KPiBhcmUgb25seSBuZWVkIHRvIGJlIGF0b21pYyB0byBp
bnRlcnJ1cHRzIChJSVVDKSwgcGF0Y2ggdXNlcw0KPiBvbmUgb2YgdGhlIENvbmRpdGlvbiBSZWdp
c3RlciAoQ1IpIGZpZWxkcyBhcyBhIGZsYWcgdmFyaWFibGUuIFdoZW4NCj4gZW50ZXJpbmcgdGhl
IGxvY2FsXyosIHNwZWNpZmljIGJpdCBpbiB0aGUgQ1I1IGZpZWxkIGlzIHNldA0KPiBhbmQgb24g
ZXhpdCwgYml0IGlzIGNsZWFyZWQuIENSIGJpdCBjaGVja2luZyBpcyBkb25lIGluIHRoZQ0KPiBp
bnRlcnJ1cHQgcmV0dXJuIHBhdGguIElmIENSNVtFUV0gYml0IHNldCBhbmQgaWYgd2UgcmV0dXJu
DQo+IHRvIGtlcm5lbCwgd2UgcmVzZXQgdG8gc3RhcnQgb2YgbG9jYWxfKiBvcGVyYXRpb24uDQoN
CkkgZG9uJ3QgY2xhaW0gdG8gYmUgYWJsZSB0byByZWFkIHBwYyBhc3NlbWJsZXIuDQpCdXQgSSBj
YW4ndCBzZWUgdGhlIGNvZGUgdGhhdCBjbGVhcnMgQ1I1W0VRXSBmb3IgdGhlIGR1cmF0aW9uDQpv
ZiB0aGUgSVNSLg0KV2l0aG91dCBpdCBhIG5lc3RlZCBpbnRlcnJ1cHQgd2lsbCBnbyB0aHJvdWdo
IHVud2FudGVkIHBhdGhzLg0KDQpUaGVyZSBhcmUgYWxzbyBhIGxvdCBvZiAnbWFnaWMnIGNvbnN0
YW50cyBpbiB0aGF0IGFzc2VtYmx5IGNvZGUuDQoNCkkgYWxzbyB3b25kZXIgaWYgaXQgaXMgcG9z
c2libGUgdG8gaW5zcGVjdCB0aGUgaW50ZXJydXB0ZWQNCmNvZGUgdG8gZGV0ZXJtaW5lIHRoZSBz
dGFydC9lbmQgb2YgdGhlIFJBUyBibG9jay4NCihFYXNpZXN0IGlmIHlvdSBhc3N1bWUgdGhhdCB0
aGVyZSBpcyBhIHNpbmdsZSAnd3JpdGUnIGluc3RydWN0aW9uDQphcyB0aGUgbGFzdCBlbnRyeSBp
biB0aGUgYmxvY2suKQ0KDQpBbHNvLCBob3cgZXhwZW5zaXZlIGlzIGl0IHRvIGRpc2FibGUgYWxs
IGludGVycnVwdHM/DQoNCglEYXZpZA0KDQo=
