Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EF9062C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 13:43:39 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 2/3] powerpc/85xx: Provide two functions to save/restore
 the core registers
Date: Tue, 21 Jan 2014 02:43:30 +0000
Message-ID: <7db8f36932f84bc5bdcb8a7777c55383@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
 <1389686397-46555-2-git-send-email-dongsheng.wang@freescale.com>
 <1389743456.24905.143.camel@snotra.buserror.net>
 <a11e0d7b3b954aa68483513340043452@BN1PR03MB188.namprd03.prod.outlook.com>
 <1389842249.24905.196.camel@snotra.buserror.net>
 <6f81ef13c25744b685b99a3fbb304f1b@BN1PR03MB188.namprd03.prod.outlook.com>
 <1390266361.24905.399.camel@snotra.buserror.net>
In-Reply-To: <1390266361.24905.399.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "anton@enomsg.org" <anton@enomsg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "chenhui.zhao@freescale.com" <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAyMSwgMjAxNCA5OjA2IEFNDQo+IFRvOiBXYW5n
IERvbmdzaGVuZy1CNDA1MzQNCj4gQ2M6IGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZzsgWmhhbyBD
aGVuaHVpLUIzNTMzNjsgYW50b25AZW5vbXNnLm9yZzsgbGludXhwcGMtDQo+IGRldkBsaXN0cy5v
emxhYnMub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBwb3dlcnBjLzg1eHg6IFByb3Zp
ZGUgdHdvIGZ1bmN0aW9ucyB0byBzYXZlL3Jlc3RvcmUgdGhlDQo+IGNvcmUgcmVnaXN0ZXJzDQo+
IA0KPiBPbiBNb24sIDIwMTQtMDEtMjAgYXQgMDA6MDMgLTA2MDAsIFdhbmcgRG9uZ3NoZW5nLUI0
MDUzNCB3cm90ZToNCj4gPiA+ID4gPiA+ICsJLyoNCj4gPiA+ID4gPiA+ICsJICogTmVlZCB0byBz
YXZlIGZsb2F0LXBvaW50IHJlZ2lzdGVycyBpZiBNU1JbRlBdID0gMS4NCj4gPiA+ID4gPiA+ICsJ
ICovDQo+ID4gPiA+ID4gPiArCW1mbXNyCXIxMg0KPiA+ID4gPiA+ID4gKwlhbmRpLglyMTIsIHIx
MiwgTVNSX0ZQDQo+ID4gPiA+ID4gPiArCWJlcQkxZg0KPiA+ID4gPiA+ID4gKwlkb19zcl9mcHJf
cmVncyhzYXZlKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQyBjb2RlIHNob3VsZCBoYXZlIGFscmVh
ZHkgZW5zdXJlZCB0aGF0IE1TUltGUF0gaXMgbm90IDEgKGFuZCB0aHVzIHRoZQ0KPiBGUA0KPiA+
ID4gPiA+IGNvbnRleHQgaGFzIGJlZW4gc2F2ZWQpLg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4g
PiA+IFllcywgcmlnaHQuIEJ1dCBJIG1lYW4gaWYgdGhlIEZQIHN0aWxsIHVzZSBpbiBjb3JlIHNh
dmUgZmxvdywgd2UgbmVlZCB0bw0KPiBzYXZlDQo+ID4gPiBpdC4NCj4gPiA+ID4gSW4gdGhpcyBw
cm9jZXNzLCBpIGRvbid0IGNhcmUgd2hhdCBvdGhlciBjb2RlIGRvLCB3ZSBuZWVkIHRvIGZvY3Vz
IG9uIG5vdA0KPiA+ID4gbG9zaW5nDQo+ID4gPiA+IHZhbHVhYmxlIGRhdGEuDQo+ID4gPg0KPiA+
ID4gSXQgaXMgbm90IGFsbG93ZWQgdG8gdXNlIEZQIGF0IHRoYXQgcG9pbnQuDQo+ID4gPg0KPiA+
IElmIE1TUltGUF0gbm90IGFjdGl2ZSwgdGhhdCBpcyBGUCBub3QgYWxsb3dlZCB0byB1c2UuDQo+
ID4gQnV0IGhlcmUgaXMgYSBub3JtYWwganVkZ21lbnQsIGlmIE1TUltGUF0gaXMgYWN0aXZlLCB0
aGlzIG1lYW5zIHRoYXQgdGhlDQo+IGZsb2F0aW5nDQo+ID4gcG9pbnQgbW9kdWxlIGlzIGJlaW5n
IHVzZWQuIEkgb2ZmZXIgaXMgYSBmdW5jdGlvbiBvZiB0aGUgaW50ZXJmYWNlLCB3ZSBkb24ndA0K
PiBrbm93DQo+ID4gd2hlcmUgaXMgdGhlIGZ1bmN0aW9uIHdpbGwgYmUgY2FsbGVkLiBKdXN0IGJl
Y2F1c2Ugd2UgY2FsbCB0aGlzIGZ1bmN0aW9uIGluDQo+IHRoZQ0KPiA+IGNvbnRleHQgb2YgdW5j
ZXJ0YWludHksIHdlIG5lZWQgdGhpcyBqdWRnbWVudCB0byBlbnN1cmUgdGhhdCBubyBkYXRhIGlz
IGxvc3QuDQo+IA0KPiBUaGUgd2hvbGUgcG9pbnQgb2YgY2FsbGluZyBlbmFibGVfa2VybmVsX2Zw
KCkgaW4gQyBjb2RlIGJlZm9yZQ0KPiBzdXNwZW5kaW5nIGlzIHRvIGVuc3VyZSB0aGF0IHRoZSBG
UCBzdGF0ZSBnZXRzIHNhdmVkLiAgSWYgRlAgaXMgdXNlZA0KPiBhZnRlciB0aGF0IHBvaW50IGl0
IGlzIGEgYnVnLiAgSWYgeW91J3JlIHdvcnJpZWQgYWJvdXQgc3VjaCBidWdzLCB0aGVuDQo+IGNs
ZWFyIE1TUltGUF0gYWZ0ZXIgY2FsbGluZyBlbmFibGVfa2VybmVsX2ZwKCksIHJhdGhlciB0aGFu
IGFkZGluZw0KPiByZWR1bmRhbnQgc3RhdGUgc2F2aW5nLg0KPiANCg0KZW5hYmxlX2tlcm5lbF9m
cCgpIGNhbGxpbmcgaW4gTUVNIHN1c3BlbmQgZmxvdy4NCkhpYmVybmF0aW9uIGlzIGRpZmZlcmVu
dCB3aXRoIE1FTSBzdXNwZW5kLCBhbmQgSSdtIG5vdCBzdXJlIHdoZXJlIHdpbGwgY2FsbCB0aGlz
DQppbnRlcmZhY2UsIHNvIHdlIG5lZWQgdG8gZW5zdXJlIHRoZSBpbnRlZ3JpdHkgb2YgdGhlIGNv
cmUgc2F2aW5nLiBJIGRvbid0IHRoaW5rDQp0aGlzIGNvZGUgaXMgKnJlZHVuZGFudCouIEkgdHJ1
c3QgdGhhdCB0aGUga2VybmVsIGNhbiBrZWVwIHRoZSBGUCByZWxhdGVkDQpvcGVyYXRpb25zLCB0
aGF0J3Mgd2h5IGEganVkZ21lbnQgaXMgaGVyZS4gOikNCg0KVGhhbmtzLA0KLURvbmdzaGVuZw0K
