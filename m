Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 34F412C0119
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 20:51:44 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Jiang Liu <jiang.liu@linux.intel.com>, Yijing Wang
 <wangyijing@huawei.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: RE: [PATCH 1/2] pci: Fix root port bus->self is NULL
Date: Tue, 7 Jan 2014 09:51:34 +0000
Message-ID: <80033eb36b0f40d682aeecc8b99dbd95@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
 <52CBBA86.7020401@huawei.com> <52CBC0B6.1090904@linux.intel.com>
In-Reply-To: <52CBC0B6.1090904@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcHJvYmUuYyBiL2RyaXZlcnMvcGNpL3Byb2Jl
LmMgaW5kZXgNCj4gPj4gMzhlNDAzZC4uN2YyZDFhYiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVy
cy9wY2kvcHJvYmUuYw0KPiA+PiArKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQo+ID4+IEBAIC0x
NDcyLDYgKzE0NzIsOSBAQCBpbnQgcGNpX3NjYW5fc2xvdChzdHJ1Y3QgcGNpX2J1cyAqYnVzLCBp
bnQgZGV2Zm4pDQo+ID4+ICAJaWYgKCFkZXYtPmlzX2FkZGVkKQ0KPiA+PiAgCQlucisrOw0KPiA+
Pg0KPiA+PiArCWlmIChwY2lfcGNpZV90eXBlKGRldikgPT0gUENJX0VYUF9UWVBFX1JPT1RfUE9S
VCkNCj4gPj4gKwkJYnVzLT5zZWxmID0gZGV2Ow0KPiA+DQo+ID4gSW4gdGhpcyBjYXNlLCBidXMg
aXMgdGhlIHBjaSByb290IGJ1cyBJIHRoaW5rLCBzbyB3aHkgc2V0IGJ1cy0+c2VsZiA9IHJvb3QN
Cj4gcG9ydCA/DQo+ID4gImJ1cy0+c2VsZiIgc2hvdWxkIHBvaW50ZXIgdG8gdGhlIHBjaSBkZXZp
Y2UgdGhhdCBicmlkZ2Ugb3V0IHRoaXMgYnVzLg0KPiBZZXMsIHRoaXMgcGF0Y2ggc2VlbXMgd3Jv
bmcuIElmIGRldiBpcyByb290IHBvcnQsIGJ1cyBzaG91bGQgYmUgcm9vdCBidXMsIHNvIHdlDQo+
IHNob3VsZG4ndCBzZXQgcm9vdF9idXMtPnNlbGYgPSBwY2lfZGV2X29mX3Jvb3RfcG9ydC4NCj4g
DQpXaHkgdGhlIHJvb3QgYnVzLT5zZWxmIHBvaW50ZXIgdG8gdGhlIGJyaWRnZT8NCklmIGNoaWxk
IGJ1cyBjcmVhdGUgZnJvbSByb290IGJ1cywgdGhlIGNoaWxkLT5zZWxmIHdpbGwgZ2V0IHRoZSBi
cmlkZ2Uocm9vdCBwb3J0KSBwY2kgZGV2aWNlLg0KDQo+IEFjdHVhbGx5IFBDSSBjb3JlIGhhcyBj
b3JyZWN0bHkgc2V0dXAgcGNpX2J1cy0+c2VsZiBmb3Igc2Vjb25kYXJ5IGJ1cyBvZiBQQ0llDQo+
IHJvb3QgcG9ydC4NClllcywgcmlnaHQuIEJ1dCB0aGUgcm9vdC1idXMtPnNlbGYgaXMgTlVMTC4g
SSB0aGluayB0aGUgcm9vdCBidXMgc2hvdWxkIGdldCByb290IHBvcnQNCnBjaSBkZXZpY2UgZm9y
IGl0c2VsZi4gSWYgdGhlcmUgaXMgbm8gYnJpZGdlIGF0IGJvYXJkIGhvdyB0byBnZXQgdGhlIHJv
b3QgcG9ydCBkZXZpY2U/DQoNCi1Eb25nc2hlbmcNCg0KPiANCj4gVGhhbmtzIQ0KPiBHZXJyeQ0K
PiANCg0K
