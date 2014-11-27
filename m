Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0121.outbound.protection.outlook.com [207.46.100.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 249691A0994
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 14:44:27 +1100 (AEDT)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Mike Turquette <mturquette@linaro.org>
Subject: RE: [PATCH v2 0/3] fix a kernel panic on fsl corenet board when
 CONFIG_CLK_PPC_CORENET is enabled
Date: Thu, 27 Nov 2014 03:30:09 +0000
Message-ID: <DM2PR03MB574DB4A270F85EB73EB76CDFA710@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
 <1415333263.23458.417.camel@snotra.buserror.net>
In-Reply-To: <1415333263.23458.417.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Kevin Hao <haokexin@gmail.com>,
 Gerhard Sittig <gsi@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jingchang Lu <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGVsbG8gTWlrZSwNCg0KQ291bGQgeW91IHBsZWFzZSBhcHBseSB0aGlzIHBhdGNoPw0KVGhpcyBw
YXRjaCBoYXMgYmVlbiBhY2tlZCBmb3IgYSB3aGlsZS4NCg0KVGhhbmtzLA0KWXVhbnRpYW4NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51eHBwYy1kZXYNCj4gW21h
aWx0bzpsaW51eHBwYy1kZXYtYm91bmNlcytiMjk5ODM9ZnJlZXNjYWxlLmNvbUBsaXN0cy5vemxh
YnMub3JnXSBPbg0KPiBCZWhhbGYgT2YgU2NvdHQgV29vZA0KPiBTZW50OiBGcmlkYXksIE5vdmVt
YmVyIDA3LCAyMDE0IDEyOjA4IFBNDQo+IFRvOiBLZXZpbiBIYW8NCj4gQ2M6IE1pa2UgVHVycXVl
dHRlOyBHZXJoYXJkIFNpdHRpZzsgTHUgSmluZ2NoYW5nLUIzNTA4MzsNCj4gbGludXhwcGMtZGV2
QGxpc3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzNdIGZpeCBhIGtl
cm5lbCBwYW5pYyBvbiBmc2wgY29yZW5ldCBib2FyZCB3aGVuDQo+IENPTkZJR19DTEtfUFBDX0NP
UkVORVQgaXMgZW5hYmxlZA0KPiANCj4gT24gU3VuLCAyMDE0LTEwLTE5IGF0IDE0OjExICswODAw
LCBLZXZpbiBIYW8gd3JvdGU6DQo+ID4gSGksDQo+ID4NCj4gPiBJIGhhdmUgZG9uZSBhIGJvb3Qg
dGVzdCBvbiBwMjAxNHJkYiBhbmQgdDQyNDBxZHMgYm9hcmRzLiBJIGRvbid0IGhhdmUNCj4gPiBh
biBhY2Nlc3MgdG8gbXBjNTEyeCBib2FyZCwgc28gb25seSBidWlsZCB0ZXN0IGZvciB0aGF0Lg0K
PiA+DQo+ID4gdjI6DQo+ID4gIC0gUmV2ZXJ0IHRoZSBjb21taXQgZGE3ODhhY2IyODM4IGZpcnN0
Lg0KPiA+ICAtIEludm9rZSBvZl9jbGtfaW5pdCgpIGZyb20gYSBjb21tb24gcGxhY2UuDQo+ID4N
Cj4gPiB2MQ0KPiA+IFRoaXMgdHJpZXMgdG8gZml4IGEga2VybmVsIHBhbmljIGludHJvZHVjZWQg
YnkgY29tbWl0IGRhNzg4YWNiMjgzOA0KPiA+ICgiY2xrOiBwcGMtY29yZW5ldDogRml4IFNlY3Rp
b24gbWlzbWF0Y2ggd2FybmluZyIpLg0KPiA+DQo+ID4gS2V2aW4gSGFvICgzKToNCj4gPiAgIFJl
dmVydCAiY2xrOiBwcGMtY29yZW5ldDogRml4IFNlY3Rpb24gbWlzbWF0Y2ggd2FybmluZyINCj4g
PiAgIHBvd2VycGM6IGNhbGwgb2ZfY2xrX2luaXQoKSBmcm9tIHRpbWVfaW5pdCgpDQo+ID4gICBj
bGs6IHBwYy1jb3JlbmV0OiBmaXggc2VjdGlvbiBtaXNtYXRjaCB3YXJuaW5nDQo+ID4NCj4gPiAg
YXJjaC9wb3dlcnBjL2tlcm5lbC90aW1lLmMgICAgICAgICAgICAgICAgICAgIHwgIDUgKysrKw0K
PiA+ICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzUxMngvY2xvY2stY29tbW9uY2xrLmMgfCAxMSAr
KysrLS0tDQo+ID4gIGRyaXZlcnMvY2xrL2Nsay1wcGMtY29yZW5ldC5jICAgICAgICAgICAgICAg
ICB8IDQzICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQs
IDE2IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPiA+DQo+IA0KPiBBY2tlZC1ieTog
U2NvdHQgV29vZCA8c2NvdHR3b29kQGZyZWVzY2FsZS5jb20+DQo+IA0KPiBXaG9zZSB0cmVlIHNo
b3VsZCB0aGlzIGdvIHRocm91Z2g/DQo+IA0KPiAtU2NvdHQNCj4gDQo+IA0KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eHBwYy1kZXYgbWFp
bGluZyBsaXN0DQo+IExpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQo+IGh0dHBzOi8vbGlz
dHMub3psYWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXYNCg==
