Return-Path: <laurentiu.tudor@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0068.outbound.protection.outlook.com [104.47.1.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPpsM6Vv8zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 21:19:03 +1100 (AEDT)
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Scott Wood <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: Madalin-Cristian Bucur <madalin.bucur@nxp.com>,
 "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: booke: fix boot crash due to null hugepd
Date: Fri, 17 Feb 2017 10:18:56 +0000
Message-ID: <58A6CE0E.90905@nxp.com>
References: <20170216151129.8971-1-laurentiu.tudor@nxp.com>
 <1487326104.5636.47.camel@buserror.net>
In-Reply-To: <1487326104.5636.47.camel@buserror.net>
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

DQoNCk9uIDAyLzE3LzIwMTcgMTI6MDggUE0sIFNjb3R0IFdvb2Qgd3JvdGU6DQo+IE9uIFRodSwg
MjAxNy0wMi0xNiBhdCAwOToxMSAtMDYwMCwgbGF1cmVudGl1LnR1ZG9yQG54cC5jb20gd3JvdGU6
DQo+PiBGcm9tOiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPj4N
Cj4+IE9uIDMyLWJpdCBib29rLWUgbWFjaGluZXMsIGh1Z2VwZF9vaygpIGRvZXMgbm90IHRha2UN
Cj4+IGludG8gYWNjb3VudCBudWxsIGh1Z2VwZCB2YWx1ZXMsIGNhdXNpbmcgdGhpcyBjcmFzaCBh
dCBib290Og0KPg0KPiBXaHkgb25seSAzMi1iaXQ/DQoNCkkgd2FudGVkIHRvIGdldCB0aGlzIHBh
dGNoIG91dCBhcyBxdWljayBhcyBwb3NzaWJsZSBzbyBpIGRpZG4ndCBoYWQNCnRpbWUgdG8gaW52
ZXN0aWdhdGUgaW4gZGVwdGguIEkganVzdCB0ZXN0ZWQgb24gNjQtYml0IHRoYXQgdGhlDQprZXJu
ZWwgYm9vdHMgb2suDQoNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
bm9oYXNoL3BndGFibGUuaA0KPj4gYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbm9oYXNoL3Bn
dGFibGUuaA0KPj4gaW5kZXggMGNkOGEzOC4uZTU4MDVhZCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gv
cG93ZXJwYy9pbmNsdWRlL2FzbS9ub2hhc2gvcGd0YWJsZS5oDQo+PiArKysgYi9hcmNoL3Bvd2Vy
cGMvaW5jbHVkZS9hc20vbm9oYXNoL3BndGFibGUuaA0KPj4gQEAgLTIzMCw3ICsyMzAsNyBAQCBz
dGF0aWMgaW5saW5lIGludCBodWdlcGRfb2soaHVnZXBkX3QgaHBkKQ0KPj4gICAJcmV0dXJuICgo
aHBkX3ZhbChocGQpICYgMHg0KSAhPSAwKTsNCj4+ICAgI2Vsc2UNCj4+ICAgCS8qIFdlIGNsZWFy
IHRoZSB0b3AgYml0IHRvIGluZGljYXRlIGh1Z2VwZCAqLw0KPj4gLQlyZXR1cm4gKChocGRfdmFs
KGhwZCkgJiBQRF9IVUdFKSA9PSAgMCk7DQo+PiArCXJldHVybiAoaHBkX3ZhbChocGQpICYmICho
cGRfdmFsKGhwZCkgJiBQRF9IVUdFKSA9PSAwKTsNCj4+ICAgI2VuZGlmDQo+PiAgIH0NCj4+DQo+
DQo+IEFueSByZWFzb24gd2h5IHRoaXMgY2FuJ3QgZ28gYmFjayB0byBiZWluZyAiaHBkX3ZhbCho
cGQpID4gMCI/ICBXaHkgd2FzIG5vaGFzaA0KPiBjaGFuZ2VkIHRvIGJlZ2luIHdpdGg/ICBJIGRv
bid0IGV4cGVjdCBub2hhc2ggKG9yIGF0IGxlYXN0IGZzbC1ib29rM2UpIHdpbGwNCj4gZXZlciBo
YXZlIGEgcGFnZXRhYmxlIHRoYXQgaXMgbm90IG5hdGl2ZS1lbmRpYW4sIGFuZCAiPiAwIiBpcyBj
b25zaXN0ZW50IHdpdGgNCj4gd2hhdCB0aGUgVExCIG1pc3MgY29kZSBpcyBkb2luZy4NCg0KVGhl
IHBhdGNoIHRoYXQgaW50cm9kdWNlZCB0aGUgYnJva2VubmVzcyBjaGFuZ2VzICJodWdlcGRfdC5w
ZCIgZnJvbSANCiJzaWduZWQgbG9uZyIgdG8gInVuc2lnbmVkIGxvbmciIHNvIGFzIGEgY29uc2Vx
dWVuY2UgIj4gMCIgd2FzIHJlcGxhY2VkDQp3aXRoIHRoZSBiaXR3aXNlIG9wLg0KDQotLS0NCkJl
c3QgUmVnYXJkcywgTGF1cmVudGl1
