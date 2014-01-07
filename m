Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E0D62C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 21:18:28 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/mpic: supply a .disable callback
Date: Tue, 7 Jan 2014 10:18:10 +0000
Message-ID: <a889eb6414b44d418a34bc5e61fc538a@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389073086-6763-1-git-send-email-dongsheng.wang@freescale.com>
 <1389073776.4672.5.camel@pasglop>
In-Reply-To: <1389073776.4672.5.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuamFtaW4gSGVycmVu
c2NobWlkdCBbbWFpbHRvOmJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZ10NCj4gU2VudDogVHVlc2Rh
eSwgSmFudWFyeSAwNywgMjAxNCAxOjUwIFBNDQo+IFRvOiBXYW5nIERvbmdzaGVuZy1CNDA1MzQN
Cj4gQ2M6IFdvb2QgU2NvdHQtQjA3NDIxOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBwb3dlcnBjL21waWM6IHN1cHBseSBhIC5kaXNhYmxlIGNh
bGxiYWNrDQo+IA0KPiBPbiBUdWUsIDIwMTQtMDEtMDcgYXQgMTM6MzggKzA4MDAsIERvbmdzaGVu
ZyBXYW5nIHdyb3RlOg0KPiA+IEZyb206IFdhbmcgRG9uZ3NoZW5nIDxkb25nc2hlbmcud2FuZ0Bm
cmVlc2NhbGUuY29tPg0KPiA+DQo+ID4gQ3VycmVudGx5IE1QSUMgcHJvdmlkZXMgLm1hc2ssIGJ1
dCBub3QgLmRpc2FibGUuICBUaGlzIG1lYW5zIHRoYXQNCj4gPiBlZmZlY3RpdmVseSBkaXNhYmxl
X2lycSgpIHNvZnQtZGlzYWJsZXMgdGhlIGludGVycnVwdCwgYW5kIHlvdSBnZXQNCj4gPiBhIC5t
YXNrIGNhbGwgaWYgYW4gaW50ZXJydXB0IGFjdHVhbGx5IG9jY3Vycy4NCj4gPg0KPiA+IEknbSBu
b3Qgc3VyZSBpZiB0aGlzIHdhcyBpbnRlbmRlZCBhcyBhIHBlcmZvcm1hbmNlIGJlbmVmaXQgKGl0
IHNlZW1zIGNvbW1vbg0KPiA+IHRvIG9taXQgLmRpc2FibGUgb24gcG93ZXJwYyBpbnRlcnJ1cHQg
Y29udHJvbGxlcnMsIGJ1dCBub3doZXJlIGVsc2UpLCBidXQgaXQNCj4gPiBpbnRlcmFjdHMgYmFk
bHkgd2l0aCB0aHJlYWRlZC93b3JrcXVldWUgaW50ZXJydXB0cyAoaW5jbHVkaW5nIEtWTQ0KPiA+
IHJlZmxlY3Rpb24pLiAgSW4gc3VjaCBjYXNlcywgd2hlcmUgdGhlIHJlYWwgaW50ZXJydXB0IGhh
bmRsZXIgZG9lcyBhDQo+ID4gZGlzYWJsZV9pcnFfbm9zeW5jKCksIHNjaGVkdWxlcyBkZWZlcmVk
IGhhbmRsaW5nLCBhbmQgcmV0dXJucywgd2UgZ2V0IHR3bw0KPiA+IGludGVycnVwdHMgZm9yIGV2
ZXJ5IHJlYWwgaW50ZXJydXB0LiAgVGhlIHNlY29uZCBpbnRlcnJ1cHQgZG9lcyBub3RoaW5nDQo+
ID4gYnV0IHNlZSB0aGF0IElSUV9ESVNBQkxFRCBpcyBzZXQsIGFuZCBkZWNpZGUgdGhhdCBpdCB3
b3VsZCBiZSBhIGdvb2QNCj4gPiBpZGVhIHRvIGFjdHVhbGx5IGNhbGwgLm1hc2suDQo+IA0KPiBX
ZSBwcm9iYWJseSBkb24ndCB3YW50IHRvIGRvIHRoYXQgZm9yIGVkZ2UsIG9ubHkgbGV2ZWwgaW50
ZXJydXB0cy4NCj4gDQpTb3JyeSBCZW4sIEkgYW0gbm90IHVuZGVyc3RhbmQgeW91ciBjb21tZW50
cy4NCg0KVGhpcyBpc3N1ZSBpcyB0aGUga2VybmVsIGFwaSBpcnFfZGlzYWJsZSgpIG9ubHkgdXNl
IGNoaXAtPmlycV9kaXNhYmxlKCksIGJ1dCBtcGljDQpub3QgaGF2ZSB0aGlzIGludGVyZmFjZSBz
byB3ZSBkb24ndCByZWFsIGRpc2FibGUgdGhlIGludGVycnVwdC4NCg0KLURvbmdzaGVuZw0KDQo+
IENoZWVycywNCj4gQmVuLg0KPiANCg0K
