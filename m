Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0235.outbound.protection.outlook.com [207.46.163.235])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E3B002C009B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 16:57:15 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 3/3] powerpc/fsl: Use the new interface to save or
 restore registers
Date: Mon, 20 Jan 2014 05:57:06 +0000
Message-ID: <18d3109ac114477a805618829632b463@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
 <1389686397-46555-3-git-send-email-dongsheng.wang@freescale.com>
 <1389742224.24905.140.camel@snotra.buserror.net>
 <93a6a30cd8d240109405d45c8e143dea@BN1PR03MB188.namprd03.prod.outlook.com>
 <1389842143.24905.195.camel@snotra.buserror.net>
In-Reply-To: <1389842143.24905.195.camel@snotra.buserror.net>
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

PiA+ID4gPiBVc2UgZnNsX2NwdV9zdGF0ZV9zYXZlL2ZzbF9jcHVfc3RhdGVfcmVzdG9yZSB0byBz
YXZlL3Jlc3RvcmUgcmVnaXN0ZXJzLg0KPiA+ID4gPiBVc2UgdGhlIGZ1bmN0aW9ucyB0byBzYXZl
L3Jlc3RvcmUgcmVnaXN0ZXJzLCBzbyB3ZSBkb24ndCBuZWVkIHRvDQo+ID4gPiA+IG1haW50YWlu
IHRoZSBjb2RlLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIERvbmdzaGVu
ZyA8ZG9uZ3NoZW5nLndhbmdAZnJlZXNjYWxlLmNvbT4NCj4gPiA+DQo+ID4gPiBJcyB0aGVyZSBh
bnkgZnVuY3Rpb25hbCBjaGFuZ2Ugd2l0aCB0aGlzIHBhdGNoc2V0IChlLmcuIHN1c3BlbmQNCj4g
PiA+IHN1cHBvcnRlZCBvbiBjaGlwcyB3aGVyZSBpdCB3YXNuJ3QgYmVmb3JlKSwgb3IgaXMgaXQg
anVzdCBjbGVhbnVwPyAgQQ0KPiA+ID4gY292ZXIgbGV0dGVyIHdvdWxkIGJlIHVzZWZ1bCB0byBk
ZXNjcmliZSB0aGUgcHVycG9zZSBvZiB0aGUgb3ZlcmFsbA0KPiA+ID4gcGF0Y2hzZXQgd2hlbiBp
dCBpc24ndCBvYnZpb3VzLg0KPiA+ID4NCj4gPg0KPiA+IFllcywganVzdCBjbGVhbnVwLi4NCj4g
DQo+IEl0IHNlZW1zIHRvIGJlIGludHJvZHVjaW5nIGNvbXBsZXhpdHkgcmF0aGVyIHRoYW4gcmVt
b3ZpbmcgaXQuICBJcyB0aGlzDQo+IGNsZWFudXAgbmVlZGVkIHRvIHByZXBhcmUgZm9yIGFkZGlu
ZyBuZXcgZnVuY3Rpb25hbGl0eT8NCj4gDQo+IFBsdXMsIEknbSBza2VwdGljYWwgdGhhdCB0aGlz
IGlzIGZ1bmN0aW9uYWxseSBlcXVpdmFsZW50LiAgSXQgbG9va3MgbGlrZQ0KPiB0aGUgbmV3IGNv
ZGUgc2F2ZXMgYSBsb3QgbW9yZSB0aGFuIHRoZSBvbGQgY29kZSBkb2VzLiAgV2h5Pw0KPiANCg0K
QWN0dWFsbHksIEkgd2FudCB0byB0YWtlIGEgcHJhY3RpY2FsIGV4YW1wbGUgdG8gcHVzaCB0aGUg
c2F2ZS9yZXN0b3JlIHBhdGNoZXMuDQpBbmQgdGhpcyBpcyBhbHNvIHJlYXNvbmFibGUgZm9yIDMy
Yml0LWhpYmVybmF0aW9uLCB0aGUgY29kZSBpcyBtb3JlIGNsZWFuLiA6KQ0KSSB0aGluayBJIG5l
ZWQgdG8gY2hhbmdlIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGUgcGF0Y2guDQoNCj4gPiA+ID4gKw0K
PiA+ID4gPiArCS8qIFJlc3RvcmUgYmFzZSByZWdpc3RlciAqLw0KPiA+ID4gPiArCWxpCXI0LCAw
DQo+ID4gPiA+ICsJYmwJZnNsX2NwdV9zdGF0ZV9yZXN0b3JlDQo+ID4gPg0KPiA+ID4gV2h5IGFy
ZSB5b3UgY2FsbGluZyBhbnl0aGluZyB3aXRoICJmc2wiIGluIHRoZSBuYW1lIGZyb20gY29kZSB0
aGF0IGlzDQo+ID4gPiBzdXBwb3NlZCB0byBiZSBmb3IgYWxsIGJvb2tlPw0KPiA+ID4NCj4gPiBF
MjAwLCBFMzAwIG5vdCBzdXBwb3J0Lg0KPiA+IFN1cHBvcnQgRTUwMCwgRTUwMHYyLCBFNTAwTUMs
IEU1NTAwLCBFNjUwMC4NCj4gPg0KPiA+IERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyBhYm91
dCB0aGlzPw0KPiANCj4gV2hhdCBhYm91dCBub24tRlNMIGJvb2tlIHN1Y2ggYXMgNDR4Pw0KPiAN
Cj4gT3IgaWYgdGhpcyBmaWxlIG5ldmVyIHN1cHBvcnRlZCA0NHgsIHJlbmFtZSBpdCBhcHByb3By
aWF0ZWx5Lg0KPiANCkN1cnJlbnRseSBkb2VzIG5vdCBzdXBwb3J0LiBvayBjaGFuZ2UgdGhlIG5h
bWUgZmlyc3QsIGlmIGxhdGVyIHN1cHBvcnQsIGFuZA0KdGhlbiBhZ2FpbiB0byBtb2RpZnkgdGhl
IG5hbWUgb2YgdGhpcyBmdW5jdGlvbi4NCg0KSG93IGFib3V0IDg1eHhfY3B1X3N0YXRlX3Jlc3Rv
cmU/DQoNClRoYW5rcywNCi1Eb25nc2hlbmcNCg==
