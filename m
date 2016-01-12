Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 378631A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 00:32:52 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>, Vaibhav Jain
 <vaibhav@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
CC: Frank Haverkamp <HAVERKAM@de.ibm.com>, "Matthew R. Ochs"
 <mrochs@linux.vnet.ibm.com>, "imunsie@au1.ibm.com" <imunsie@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Subject: RE: cxl: Fix DSI misses when the context owning task exits
Date: Tue, 12 Jan 2016 13:29:50 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CCC4462@AcuExch.aculab.com>
References: <1448362578-32456-1-git-send-email-vaibhav@linux.vnet.ibm.com>
 <20160111091403.79FBE140323@ozlabs.org>
In-Reply-To: <20160111091403.79FBE140323@ozlabs.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogTWljaGFlbCBFbGxlcm1hbg0KPiBTZW50OiAxMSBKYW51YXJ5IDIwMTYgMDk6MTQNCj4g
T24gVHVlLCAyMDE1LTI0LTExIGF0IDEwOjU2OjE4IFVUQywgVmFpYmhhdiBKYWluIHdyb3RlOg0K
PiA+IFByZXNlbnRseSB3aGVuIGEgdXNlci1zcGFjZSBwcm9jZXNzIGlzc3VlcyBDWExfSU9DVExf
U1RBUlRfV09SSyBpb2N0bCB3ZQ0KPiA+IHN0b3JlIHRoZSBwaWQgb2YgdGhlIGN1cnJlbnQgdGFz
a19zdHJ1Y3QgYW5kIHVzZSBpdCB0byBnZXQgcG9pbnRlciB0bw0KPiA+IHRoZSBtbV9zdHJ1Y3Qg
b2YgdGhlIHByb2Nlc3MsIHdoaWxlIHByb2Nlc3NpbmcgcGFnZSBvciBzZWdtZW50IGZhdWx0cw0K
PiA+IGZyb20gdGhlIGNhcGkgY2FyZC4gSG93ZXZlciB0aGlzIGNhdXNlcyBpc3N1ZXMgd2hlbiB0
aGUgdGhyZWFkIHRoYXQgaGFkDQo+ID4gb3JpZ2luYWxseSBpc3N1ZWQgdGhlIHN0YXJ0LXdvcmsg
aW9jdGwgZXhpdHMgaW4gd2hpY2ggY2FzZSB0aGUgc3RvcmVkDQo+ID4gcGlkIGlzIG5vIG1vcmUg
dmFsaWQgYW5kIHRoZSBjeGwgZHJpdmVyIGlzIHVuYWJsZSB0byBoYW5kbGUgZmF1bHRzIGFzDQo+
ID4gdGhlIG1tX3N0cnVjdCBjb3JyZXNwb25kaW5nIHRvIHByb2Nlc3MgaXMgbm8gbW9yZSBhY2Nl
c3NpYmxlLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGlzIGlzc3VlIGJ5IHVzaW5nIHRo
ZSBtbV9zdHJ1Y3Qgb2YgdGhlIG5leHQgYWxpdmUNCj4gPiB0YXNrIGluIHRoZSB0aHJlYWQgZ3Jv
dXAuIFRoaXMgaXMgZG9uZSBieSBpdGVyYXRpbmcgb3ZlciBhbGwgdGhlIHRhc2tzDQo+ID4gaW4g
dGhlIHRocmVhZCBncm91cCBzdGFydGluZyBmcm9tIHRocmVhZCBncm91cCBsZWFkZXIgYW5kIGNh
bGxpbmcNCj4gPiBnZXRfdGFza19tbSBvbiBlYWNoIG9uZSBvZiB0aGVtLiBXaGVuIGEgdmFsaWQg
bW1fc3RydWN0IGlzIG9idGFpbmVkIHRoZQ0KPiA+IHBpZCBvZiB0aGUgYXNzb2NpYXRlZCB0YXNr
IGlzIHN0b3JlZCBpbiB0aGUgY29udGV4dCByZXBsYWNpbmcgdGhlDQo+ID4gZXhpdGluZyBvbmUg
Zm9yIGhhbmRsaW5nIGZ1dHVyZSBmYXVsdHMuDQoNCkkgZG9uJ3QgZXZlbiBjbGFpbSB0byB1bmRl
cnN0YW5kIHRoZSBsaW51eCBtb2RlbCBmb3IgaGFuZGxpbmcgcHJvY2Vzcw0KYWRkcmVzcyBtYXBz
LCBub3Igd2hhdCB0aGUgY3hsIGRyaXZlciBpcyBkb2luZywgYnV0IHRoZSBhYm92ZSBsb29rcw0K
bW9yZSB0aGFuIGRvZGd5Lg0KDQoJRGF2aWQNCg0K
