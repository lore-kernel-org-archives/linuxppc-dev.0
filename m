Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 578461A0B4D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 20:53:10 +1100 (AEDT)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 14432-08 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 18 Dec 2014 09:52:58 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Rusty Russell' <rusty@rustcorp.com.au>, 'Madhavan Srinivasan'
 <maddy@linux.vnet.ibm.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Subject: RE: [RFC PATCH 0/2] powerpc: CR based local atomic operation
 implementation
Date: Thu, 18 Dec 2014 09:52:37 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CA0E993@AcuExch.aculab.com>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FDC8B@AcuExch.aculab.com>
 <547831DC.6000703@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FE4A9@AcuExch.aculab.com>
 <547C8ADD.1050905@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FFB90@AcuExch.aculab.com>
 <87k31ptwty.fsf@rustcorp.com.au>
In-Reply-To: <87k31ptwty.fsf@rustcorp.com.au>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "anton@samba.org" <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogUnVzdHkgUnVzc2VsbA0KPiBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBBQ1VMQUIu
Q09NPiB3cml0ZXM6DQo+ID4gRnJvbTogTWFkaGF2YW4gU3Jpbml2YXNhbiBbbWFpbHRvOm1hZGR5
QGxpbnV4LnZuZXQuaWJtLmNvbV0NCj4gPiAuLi4NCj4gPj4gPj4+IEkgYWxzbyB3b25kZXIgaWYg
aXQgaXMgcG9zc2libGUgdG8gaW5zcGVjdCB0aGUgaW50ZXJydXB0ZWQNCj4gPj4gPj4+IGNvZGUg
dG8gZGV0ZXJtaW5lIHRoZSBzdGFydC9lbmQgb2YgdGhlIFJBUyBibG9jay4NCj4gPj4gPj4+IChF
YXNpZXN0IGlmIHlvdSBhc3N1bWUgdGhhdCB0aGVyZSBpcyBhIHNpbmdsZSAnd3JpdGUnIGluc3Ry
dWN0aW9uDQo+ID4+ID4+PiBhcyB0aGUgbGFzdCBlbnRyeSBpbiB0aGUgYmxvY2suKQ0KPiA+PiA+
Pj4NCj4gPj4gPj4gU28gZWFjaCBsb2NhbF8qIGZ1bmN0aW9uIGFsc28gaGF2ZSBjb2RlIGluIHRo
ZSBfX2V4X3RhYmxlIHNlY3Rpb24uIElJVUMsDQo+ID4+ID4+IF9fZXhfdGFibGUgY29udGFpbnMg
dHdvIGFkZHJlc3MuIFNvIGlmIHRoZSByZXR1cm4gYWRkcmVzcyBmb3VuZCBpbiB0aGUNCj4gPj4g
Pj4gZmlyc3QgY29sdW1uIG9mIHRoZSBfZXhfdGFibGUsIHVzZSB0aGUgY29ycmVzcG9uZGluZyBh
ZGRyZXNzIGluIHRoZQ0KPiA+PiA+PiBzZWNvbmQgY29sdW1uIHRvIGNvbnRpbnVlIGZyb20uDQo+
ID4+ID4NCj4gPj4gPiBUaGF0IHJlYWxseSBkb2Vzbid0IHNjYWxlLg0KPiA+PiA+IEkgZG9uJ3Qg
a25vdyBob3cgbWFueSAxMDAwIGFkZHJlc3MgcGFpcnMgeW91IHRhYmxlIHdpbGwgaGF2ZSAoYW5k
IHRoZQ0KPiA+PiA+IG9uZXMgaW4gZWFjaCBsb2FkYWJsZSBtb2R1bGUpLCBidXQgdGhlIHNlYXJj
aCBpc24ndCBnb2luZyB0byBiZSBjaGVhcC4NCj4gPj4gPg0KPiA+PiA+IElmIHRoZXNlIHNlcXVl
bmNlcyBhcmUgcmVzdGFydGFibGUgdGhlbiB0aGV5IGNhbiBvbmx5IGhhdmUgb25lIHdyaXRlDQo+
ID4+ID4gdG8gbWVtb3J5Lg0KLi4uDQo+ID4+IDIpIHJlc3VsdGluZyBjb2RlIHdpdGggbG90IG9m
IGNvbmRpdGlvbiBhbmQgYnJhbmNoIChmb3Igb3Bjb2RlIGRlY29kZSkNCj4gPj4gd2lsbCBiZSBs
b3QgbWVzc3kgYW5kIG1heSBiZSBhbiBpc3N1ZSBpbmNhc2Ugb2YgbWFpbnRlbmFuY2UsDQo+ID4N
Cj4gPiBZb3UgZG9uJ3QgbmVlZCB0byBkZWNvZGUgdGhlIGluc3RydWN0aW9ucy4NCj4gPiBKdXN0
IGxvb2sgZm9yIHRoZSB0d28gc3BlY2lmaWMgaW5zdHJ1Y3Rpb25zIHVzZWQgYXMgbWFya2Vycy4N
Cj4gPiBUaGlzIGlzIG9ubHkgcmVhbGx5IHBvc3NpYmxlIHdpdGggZml4ZWQtc2l6ZSBpbnN0cnVj
dGlvbnMuDQo+ID4NCj4gPiBJdCBtaWdodCBhbHNvIGJlIHRoYXQgdGhlICdpbnRlcnJ1cHQgZW50
cnknIHBhdGggaXMgZWFzaWVyIHRvDQo+ID4gbW9kaWZ5IHRoYW4gdGhlICdpbnRlcnJ1cHQgZXhp
dCcgb25lIChmZXdlciBjb2RlIHBhdGhzKSBhbmQNCj4gPiB5b3UganVzdCBuZWVkIHRvIG1vZGlm
eSB0aGUgJ3BjJyBpbiB0aGUgc3RhY2sgZnJhbWUuDQo+ID4gWW91IGFyZSBvbmx5IGludGVyZXN0
ZWQgaW4gaW50ZXJydXB0cyBmcm9tIGtlcm5lbCBzcGFjZS4NCj4gDQo+IEl0J3MgYW4gb3Zlcm9w
dGltaXphdGlvbiBmb3IgY2FzZSB0aGF0IHN0YXRpc3RpY2FsbHkgbmV2ZXIgaGFwcGVucy4NCj4g
WW91IHdvbid0IGV2ZW4gYmUgYWJsZSB0byBtZWFzdXJlIHRoZSBkaWZmZXJlbmNlLg0KPiANCj4g
VGhlIHF1ZXN0aW9uIG9mIGJsb2F0IHJlbWFpbnMsIGJ1dCB0aGF0J3MgYWxzbyBlYXNpbHkgbWVh
c3VyZWQuICBJbg0KPiBwcmFjdGljZSwgSSdkIGd1ZXNzIGxlc3MgdGhhbiAxay4NCg0KSUlSQyB0
aGV5IHdlcmUgJ3N0YXRpYyBpbmxpbmUnIHNvIHRoZSB0YWJsZSBvZiBhZGRyZXNzZXMgaXMgZ2Vu
ZXJhdGVkDQpmb3IgZXZlcnkgdXNlIHNpdGUuDQooY29weWluL291dCBnZW5lcmF0ZXMgYSBzaW1p
bGFybHkgZW5vcm1vdXMgdGFibGUgb2YgYWRkcmVzc2VzIG9uIGFtZDY0KQ0KDQoNCklmIHRoZXkg
d2VyZSByZWFsIGZ1bmN0aW9ucyAoc28gb25seSBhcHBlYXJlZCBvbmNlKSBpdCB3b3VsZG4ndCBi
ZSBhcyBiYWQuDQpJbmRlZWQsIGluIHRoYXQgY2FzZSwgYnkgcHV0dGluZyBhbGwgc3VjaCBmdW5j
dGlvbnMgaW50byBhIHNlcGFyYXRlIGNvZGUNCnNlY3Rpb24gYSBzaW1wbGUgJ3dpbmRvdyB0ZXN0
JyBjYW4gYmUgZG9uZSBvbiB0aGUgcmV0dXJuIGFkZHJlc3MgaW5zdGVhZA0Kb2YgcmVzZXJ2aW5n
IG9uZSBvZiB0aGUgQ1IgYml0cy4NCg0KWW91IGFsc28gb25seSBuZWVkIHRvIHNhdmUgdGhlIHN0
YXJ0IGFuZCBlbmQgb2YgZWFjaCBibG9jaywgbm90IHRoZQ0KcmVzdGFydCBhZGRyZXNzIGZvciBl
dmVyeSBpbnN0cnVjdGlvbiB3aXRoaW4gdGhlIGJsb2NrLg0KDQoJRGF2aWQNCg0K
