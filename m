Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 239AC1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 02:53:56 +1100 (AEDT)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 02764-09 for <linuxppc-dev@lists.ozlabs.org>;
 Mon,  1 Dec 2014 15:53:44 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Madhavan Srinivasan' <maddy@linux.vnet.ibm.com>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>
Subject: RE: [RFC PATCH 0/2] powerpc: CR based local atomic operation
 implementation
Date: Mon, 1 Dec 2014 15:53:25 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1C9FFB90@AcuExch.aculab.com>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FDC8B@AcuExch.aculab.com>
 <547831DC.6000703@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1C9FE4A9@AcuExch.aculab.com>
 <547C8ADD.1050905@linux.vnet.ibm.com>
In-Reply-To: <547C8ADD.1050905@linux.vnet.ibm.com>
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

RnJvbTogTWFkaGF2YW4gU3Jpbml2YXNhbiBbbWFpbHRvOm1hZGR5QGxpbnV4LnZuZXQuaWJtLmNv
bV0NCi4uLg0KPiA+Pj4gSSBhbHNvIHdvbmRlciBpZiBpdCBpcyBwb3NzaWJsZSB0byBpbnNwZWN0
IHRoZSBpbnRlcnJ1cHRlZA0KPiA+Pj4gY29kZSB0byBkZXRlcm1pbmUgdGhlIHN0YXJ0L2VuZCBv
ZiB0aGUgUkFTIGJsb2NrLg0KPiA+Pj4gKEVhc2llc3QgaWYgeW91IGFzc3VtZSB0aGF0IHRoZXJl
IGlzIGEgc2luZ2xlICd3cml0ZScgaW5zdHJ1Y3Rpb24NCj4gPj4+IGFzIHRoZSBsYXN0IGVudHJ5
IGluIHRoZSBibG9jay4pDQo+ID4+Pg0KPiA+PiBTbyBlYWNoIGxvY2FsXyogZnVuY3Rpb24gYWxz
byBoYXZlIGNvZGUgaW4gdGhlIF9fZXhfdGFibGUgc2VjdGlvbi4gSUlVQywNCj4gPj4gX19leF90
YWJsZSBjb250YWlucyB0d28gYWRkcmVzcy4gU28gaWYgdGhlIHJldHVybiBhZGRyZXNzIGZvdW5k
IGluIHRoZQ0KPiA+PiBmaXJzdCBjb2x1bW4gb2YgdGhlIF9leF90YWJsZSwgdXNlIHRoZSBjb3Jy
ZXNwb25kaW5nIGFkZHJlc3MgaW4gdGhlDQo+ID4+IHNlY29uZCBjb2x1bW4gdG8gY29udGludWUg
ZnJvbS4NCj4gPg0KPiA+IFRoYXQgcmVhbGx5IGRvZXNuJ3Qgc2NhbGUuDQo+ID4gSSBkb24ndCBr
bm93IGhvdyBtYW55IDEwMDAgYWRkcmVzcyBwYWlycyB5b3UgdGFibGUgd2lsbCBoYXZlIChhbmQg
dGhlDQo+ID4gb25lcyBpbiBlYWNoIGxvYWRhYmxlIG1vZHVsZSksIGJ1dCB0aGUgc2VhcmNoIGlz
bid0IGdvaW5nIHRvIGJlIGNoZWFwLg0KPiA+DQo+ID4gSWYgdGhlc2Ugc2VxdWVuY2VzIGFyZSBy
ZXN0YXJ0YWJsZSB0aGVuIHRoZXkgY2FuIG9ubHkgaGF2ZSBvbmUgd3JpdGUNCj4gPiB0byBtZW1v
cnkuDQo+ID4NCj4gDQo+IE1heSBiZSwgYnV0IGkgc2VlIHRoZXNlIGlzc3VlcyBpbmNhc2Ugb2Yg
aW5zdHMgZGVjb2RlIHBhdGgsDQo+IA0KPiAxKSBEZWNvZGluZyBpbnN0cnVjdGlvbiBtYXkgYWxz
byBjYXVzZSBhIGZhdWx0IChpbiBjYXNlIG9mIG1vZHVsZSkgYW5kDQo+IGhhbmRsaW5nIGEgZmF1
bHQgYXQgdGhpcyBzdGFnZSB0b3dhcmQgdGhlIGV4aXQgcGF0aCBvZiBpbnRlcnJ1cHQgZXhpdA0K
PiBtYWtlcyBtZSBuZXJ2b3VzDQoNCkl0IHNob3VsZG4ndCBiZSBwb3NzaWJsZSB0byB1bmxvYWQg
YSBtb2R1bGUgdGhhdCBpcyBpbnRlcnJ1cHRlZCBieQ0KYSBoYXJkd2FyZSBpbnRlcnJ1cHQuDQpB
biAnaW52YWxpZCcgbG9hZGFibGUgbW9kdWxlIGNhbiBjYXVzZSBhbiBvb3BzL3BhbmljIGFueXdh
eS4NCg0KPiAyKSByZXN1bHRpbmcgY29kZSB3aXRoIGxvdCBvZiBjb25kaXRpb24gYW5kIGJyYW5j
aCAoZm9yIG9wY29kZSBkZWNvZGUpDQo+IHdpbGwgYmUgbG90IG1lc3N5IGFuZCBtYXkgYmUgYW4g
aXNzdWUgaW5jYXNlIG9mIG1haW50ZW5hbmNlLA0KDQpZb3UgZG9uJ3QgbmVlZCB0byBkZWNvZGUg
dGhlIGluc3RydWN0aW9ucy4NCkp1c3QgbG9vayBmb3IgdGhlIHR3byBzcGVjaWZpYyBpbnN0cnVj
dGlvbnMgdXNlZCBhcyBtYXJrZXJzLg0KVGhpcyBpcyBvbmx5IHJlYWxseSBwb3NzaWJsZSB3aXRo
IGZpeGVkLXNpemUgaW5zdHJ1Y3Rpb25zLg0KDQpJdCBtaWdodCBhbHNvIGJlIHRoYXQgdGhlICdp
bnRlcnJ1cHQgZW50cnknIHBhdGggaXMgZWFzaWVyIHRvDQptb2RpZnkgdGhhbiB0aGUgJ2ludGVy
cnVwdCBleGl0JyBvbmUgKGZld2VyIGNvZGUgcGF0aHMpIGFuZA0KeW91IGp1c3QgbmVlZCB0byBt
b2RpZnkgdGhlICdwYycgaW4gdGhlIHN0YWNrIGZyYW1lLg0KWW91IGFyZSBvbmx5IGludGVyZXN0
ZWQgaW4gaW50ZXJydXB0cyBmcm9tIGtlcm5lbCBzcGFjZS4NCg0KCURhdmlkDQoNCg0K
