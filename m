Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 413E42C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 13:49:17 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 2/3] powerpc/85xx: Provide two functions to save/restore
 the core registers
Date: Thu, 23 Jan 2014 02:49:09 +0000
Message-ID: <46dd04cc9b6245fa90d20e2d94ff8523@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
 <1389686397-46555-2-git-send-email-dongsheng.wang@freescale.com>
 <1389743456.24905.143.camel@snotra.buserror.net>
 <a11e0d7b3b954aa68483513340043452@BN1PR03MB188.namprd03.prod.outlook.com>
 <1389842249.24905.196.camel@snotra.buserror.net>
 <6f81ef13c25744b685b99a3fbb304f1b@BN1PR03MB188.namprd03.prod.outlook.com>
 <1390266361.24905.399.camel@snotra.buserror.net>
 <7db8f36932f84bc5bdcb8a7777c55383@BN1PR03MB188.namprd03.prod.outlook.com>
 <1390438219.24905.551.camel@snotra.buserror.net>
In-Reply-To: <1390438219.24905.551.camel@snotra.buserror.net>
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

PiA+ID4NCj4gPiA+IFRoZSB3aG9sZSBwb2ludCBvZiBjYWxsaW5nIGVuYWJsZV9rZXJuZWxfZnAo
KSBpbiBDIGNvZGUgYmVmb3JlDQo+ID4gPiBzdXNwZW5kaW5nIGlzIHRvIGVuc3VyZSB0aGF0IHRo
ZSBGUCBzdGF0ZSBnZXRzIHNhdmVkLiAgSWYgRlAgaXMgdXNlZA0KPiA+ID4gYWZ0ZXIgdGhhdCBw
b2ludCBpdCBpcyBhIGJ1Zy4gIElmIHlvdSdyZSB3b3JyaWVkIGFib3V0IHN1Y2ggYnVncywgdGhl
bg0KPiA+ID4gY2xlYXIgTVNSW0ZQXSBhZnRlciBjYWxsaW5nIGVuYWJsZV9rZXJuZWxfZnAoKSwg
cmF0aGVyIHRoYW4gYWRkaW5nDQo+ID4gPiByZWR1bmRhbnQgc3RhdGUgc2F2aW5nLg0KPiA+ID4N
Cj4gPg0KPiA+IGVuYWJsZV9rZXJuZWxfZnAoKSBjYWxsaW5nIGluIE1FTSBzdXNwZW5kIGZsb3cu
DQo+ID4gSGliZXJuYXRpb24gaXMgZGlmZmVyZW50IHdpdGggTUVNIHN1c3BlbmQsIGFuZCBJJ20g
bm90IHN1cmUgd2hlcmUgd2lsbCBjYWxsDQo+IHRoaXMNCj4gPiBpbnRlcmZhY2UsIHNvIHdlIG5l
ZWQgdG8gZW5zdXJlIHRoZSBpbnRlZ3JpdHkgb2YgdGhlIGNvcmUgc2F2aW5nLiBJIGRvbid0DQo+
IHRoaW5rDQo+ID4gdGhpcyBjb2RlIGlzICpyZWR1bmRhbnQqLiBJIHRydXN0IHRoYXQgdGhlIGtl
cm5lbCBjYW4ga2VlcCB0aGUgRlAgcmVsYXRlZA0KPiA+IG9wZXJhdGlvbnMsIHRoYXQncyB3aHkg
YSBqdWRnbWVudCBpcyBoZXJlLiA6KQ0KPiANCj4gRm9yIGhpYmVybmF0aW9uLCBzYXZlX3Byb2Nl
c3Nvcl9zdGF0ZSgpIGlzIGNhbGxlZCBmaXJzdCwgd2hpY2ggZG9lcw0KPiBmbHVzaF9mcF90b190
aHJlYWQoKSB3aGljaCBoYXMgYSBzaW1pbGFyIGVmZmVjdCAodGhvdWdoIEkgd29uZGVyIGlmIGl0
J3MNCj4gYmVpbmcgY2FsbGVkIG9uIHRoZSBjb3JyZWN0IHRhc2sgZm9yIG5vbi1TTVApLg0KPiAN
ClllcywgdGhhbmtzLCBJIG1pc3MgdGhpcyBjb2RlLjopDQoNCkJ1dCBJIHN0aWxsIHRoaW5rIHdl
IG5lZWQgdG8ga2VlcCB0aGlzIGp1ZGdtZW50LCBiZWNhdXNlIGkgcHJvdmlkZSBhbiBBUEkuDQpJ
ZiB5b3Ugc3RpbGwgaW5zaXN0IG9uIEkgY2FuIHJlbW92ZSAqRlAqLCBidXQgSSBkb24ndCB3YW50
IHRvIGRvIHRoaXMuLjopDQo=
