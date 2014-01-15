Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 875C62C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 13:57:43 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 3/3] powerpc/fsl: Use the new interface to save or
 restore registers
Date: Wed, 15 Jan 2014 02:57:36 +0000
Message-ID: <93a6a30cd8d240109405d45c8e143dea@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
 <1389686397-46555-3-git-send-email-dongsheng.wang@freescale.com>
 <1389742224.24905.140.camel@snotra.buserror.net>
In-Reply-To: <1389742224.24905.140.camel@snotra.buserror.net>
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
MjENCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDE1LCAyMDE0IDc6MzAgQU0NCj4gVG86IFdh
bmcgRG9uZ3NoZW5nLUI0MDUzNA0KPiBDYzogYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBaaGFv
IENoZW5odWktQjM1MzM2OyBhbnRvbkBlbm9tc2cub3JnOyBsaW51eHBwYy0NCj4gZGV2QGxpc3Rz
Lm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzNdIHBvd2VycGMvZnNsOiBVc2Ug
dGhlIG5ldyBpbnRlcmZhY2UgdG8gc2F2ZSBvciByZXN0b3JlDQo+IHJlZ2lzdGVycw0KPiANCj4g
T24gVHVlLCAyMDE0LTAxLTE0IGF0IDE1OjU5ICswODAwLCBEb25nc2hlbmcgV2FuZyB3cm90ZToN
Cj4gPiBGcm9tOiBXYW5nIERvbmdzaGVuZyA8ZG9uZ3NoZW5nLndhbmdAZnJlZXNjYWxlLmNvbT4N
Cj4gPg0KPiA+IFVzZSBmc2xfY3B1X3N0YXRlX3NhdmUvZnNsX2NwdV9zdGF0ZV9yZXN0b3JlIHRv
IHNhdmUvcmVzdG9yZSByZWdpc3RlcnMuDQo+ID4gVXNlIHRoZSBmdW5jdGlvbnMgdG8gc2F2ZS9y
ZXN0b3JlIHJlZ2lzdGVycywgc28gd2UgZG9uJ3QgbmVlZCB0bw0KPiA+IG1haW50YWluIHRoZSBj
b2RlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2FuZyBEb25nc2hlbmcgPGRvbmdzaGVuZy53
YW5nQGZyZWVzY2FsZS5jb20+DQo+IA0KPiBJcyB0aGVyZSBhbnkgZnVuY3Rpb25hbCBjaGFuZ2Ug
d2l0aCB0aGlzIHBhdGNoc2V0IChlLmcuIHN1c3BlbmQNCj4gc3VwcG9ydGVkIG9uIGNoaXBzIHdo
ZXJlIGl0IHdhc24ndCBiZWZvcmUpLCBvciBpcyBpdCBqdXN0IGNsZWFudXA/ICBBDQo+IGNvdmVy
IGxldHRlciB3b3VsZCBiZSB1c2VmdWwgdG8gZGVzY3JpYmUgdGhlIHB1cnBvc2Ugb2YgdGhlIG92
ZXJhbGwNCj4gcGF0Y2hzZXQgd2hlbiBpdCBpc24ndCBvYnZpb3VzLg0KPiANCg0KWWVzLCBqdXN0
IGNsZWFudXAuLg0KDQo+ID4gKw0KPiA+ICsJLyogUmVzdG9yZSBiYXNlIHJlZ2lzdGVyICovDQo+
ID4gKwlsaQlyNCwgMA0KPiA+ICsJYmwJZnNsX2NwdV9zdGF0ZV9yZXN0b3JlDQo+IA0KPiBXaHkg
YXJlIHlvdSBjYWxsaW5nIGFueXRoaW5nIHdpdGggImZzbCIgaW4gdGhlIG5hbWUgZnJvbSBjb2Rl
IHRoYXQgaXMNCj4gc3VwcG9zZWQgdG8gYmUgZm9yIGFsbCBib29rZT8NCj4gDQpFMjAwLCBFMzAw
IG5vdCBzdXBwb3J0Lg0KU3VwcG9ydCBFNTAwLCBFNTAwdjIsIEU1MDBNQywgRTU1MDAsIEU2NTAw
Lg0KDQpEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbnMgYWJvdXQgdGhpcz8NCg0KVGhhbmtzLA0K
LURvbmdzaGVuZw0KDQo=
