Return-Path: <xuelin.shi@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 96C462C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 17:35:08 +1100 (EST)
From: Xuelin Shi <xuelin.shi@freescale.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH] fix dmaengine_unmap failure.
Date: Thu, 20 Mar 2014 06:34:59 +0000
Message-ID: <2072b2b9599b4eda88dafb998b4793c8@BL2PR03MB147.namprd03.prod.outlook.com>
References: <1395131520-30207-1-git-send-email-xuelin.shi@freescale.com>
 <CAPcyv4gs-jos5TvfDbsaXTNebQf8VjJvbdjmjsbGZLZwZKi34g@mail.gmail.com>
 <30ef7093dcc247e490831a43355ec10f@BL2PR03MB147.namprd03.prod.outlook.com>
 <CAPcyv4imH14PuiZJwMw1B+UnxBgHzPAS22p4b171MrmKDBJM+Q@mail.gmail.com>
In-Reply-To: <CAPcyv4imH14PuiZJwMw1B+UnxBgHzPAS22p4b171MrmKDBJM+Q@mail.gmail.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Cc: Vinod Koul <vinod.koul@intel.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgRGFuLA0KDQpJJ20gT0sgdG8gc2F2ZSBtZW1vcnkgaGVyZS4gSSdkIGxpa2UgdG8gc2VuZCB2
Mi4NCg0KVGhhbmtzLA0KWHVlbGluIFNoaQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogRGFuIFdpbGxpYW1zIFttYWlsdG86ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tXSANClNl
bnQ6IDIwMTTE6jPUwjE5yNUgMjM6NDQNClRvOiBTaGkgWHVlbGluLUIyOTIzNw0KQ2M6IFZpbm9k
IEtvdWw7IGxpbnV4cHBjLWRldjsgZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDog
UmU6IFtQQVRDSF0gZml4IGRtYWVuZ2luZV91bm1hcCBmYWlsdXJlLg0KDQpPbiBUdWUsIE1hciAx
OCwgMjAxNCBhdCAxMTozOSBQTSwgWHVlbGluIFNoaSA8eHVlbGluLnNoaUBmcmVlc2NhbGUuY29t
PiB3cm90ZToNCj4gSGkgRGFuLA0KPg0KPiBJbiBhc3luY19tdWx0KC4uLikgb2YgYXN5bmNfcmFp
ZDZfcmVjb3YuYywgdGhlIGNvdW50IDMgaXMgdXNlZCB0byByZXF1ZXN0IGFuIHVubWFwLg0KPiBI
b3dldmVyIHRoZSB0b19jbnQgYW5kIGJpZGlfY250IGFyZSBib3RoIHNldCB0byAxIGFuZCBmcm9t
X2NudCB0byAwLg0KPiBUaGVuIHdoaWxlIHRyeWluZyB0byBkbyB1bm1hcCwgd2UgYXJlIGdldHRp
bmcgdGhlIHdyb25nICJ1bm1hcCIgZnJvbSBhIGRpZmZlcmVudCBtZW1wb29sLg0KPg0KPiBJbiB0
aGlzIHBhdGNoLCB0aGUgbWVtcG9vbCBpcyBhc3NvY2lhdGVkIHdpdGggdGhlIHVubWFwIHN0cnVj
dHVyZSBpbnN0ZWFkIG9mIGNvbXB1dGluZyBpdCBhZ2Fpbi4NCj4gQnkgdGhpcyB3YXksIGl0IGlz
IGd1YXJhbnRlZWQgdGhhdCB0aGUgdW5tYXAgaXMgdGhlIHNhbWUgd2hlbiB3ZSBnZXQgYW5kIHB1
dCB0aGUgdW5tYXAgZGF0YS4NCj4NCj4gQlRXOiB0aGUgbWVtcG9vbCBpcyBqdXN0IHVzZWQgdG8g
bWFuYWdlIHRoZSBzdHJ1Y3QgdW5tYXAsIG5vdCB0aGUgcGFnZXMuDQo+DQoNCkkgc2VlLCB3aGF0
IGFib3V0IGp1c3Qgc3RvcmluZyB0aGUgbWFwX2NudCBhdCBhbGxvY2F0aW9uIHRpbWU/ICBJdCBj
b3VsZCBiZSBhbm90aGVyIGJ5dGUgaW4gc3RydWN0IGRtYWVuZ2luZV91bm1hcF9kYXRhIHJhdGhl
ciB0aGFuIGFuIDggYnl0ZSBwb2ludGVyLg0KDQoNCg==
