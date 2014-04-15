Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B32E5140083
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 12:19:26 +1000 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 1/2] powerpc/mpc85xx: add two functions to get suspend
 state which is standby or mem
Date: Tue, 15 Apr 2014 02:19:00 +0000
Message-ID: <46de6945e1144ab086253c52dd551e9f@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1397442250-14886-1-git-send-email-dongsheng.wang@freescale.com>
 <1397518031.20280.229.camel@snotra.buserror.net>
In-Reply-To: <1397518031.20280.229.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "chenhui.zhao@freescale.com" <chenhui.zhao@freescale.com>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTUsIDIwMTQgNzoyNyBBTQ0KPiBUbzogV2FuZyBE
b25nc2hlbmctQjQwNTM0DQo+IENjOiBKaW4gWmhlbmd4aW9uZy1SNjQxODg7IExpIFlhbmctTGVv
LVI1ODQ3MjsgWmhhbyBDaGVuaHVpLUIzNTMzNjsgbGludXhwcGMtDQo+IGRldkBsaXN0cy5vemxh
YnMub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBwb3dlcnBjL21wYzg1eHg6IGFkZCB0
d28gZnVuY3Rpb25zIHRvIGdldCBzdXNwZW5kIHN0YXRlDQo+IHdoaWNoIGlzIHN0YW5kYnkgb3Ig
bWVtDQo+IA0KPiBPbiBNb24sIDIwMTQtMDQtMTQgYXQgMTA6MjQgKzA4MDAsIERvbmdzaGVuZyBX
YW5nIHdyb3RlOg0KPiA+IEZyb206IFdhbmcgRG9uZ3NoZW5nIDxkb25nc2hlbmcud2FuZ0BmcmVl
c2NhbGUuY29tPg0KPiA+DQo+ID4gQWRkIHNldF9wbV9zdXNwZW5kX3N0YXRlICYgcG1fc3VzcGVu
ZF9zdGF0ZSBmdW5jdGlvbnMgdG8gc2V0L2dldCBzdXNwZW5kIHN0YXRlLg0KPiA+IFdoZW4gc3lz
dGVtIGdvaW5nIHRvIHNsZWVwLCBkZXZpY2VzIGNhbiBnZXQgdGhlIHN5c3RlbSBzdXNwZW5kDQo+
ID4gc3RhdGUoU1RBTkRCWS9NRU0pIHRocm91Z2ggcG1fc3VzcGVuZF9zdGF0ZSBmdW5jdGlvbiBh
bmQgaGFuZGxlIGRpZmZlcmVudA0KPiBzaXR1YXRpb25zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogV2FuZyBEb25nc2hlbmcgPGRvbmdzaGVuZy53YW5nQGZyZWVzY2FsZS5jb20+DQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L2NvbW1vbi5jDQo+ID4g
Yi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvY29tbW9uLmMNCj4gPiBpbmRleCBiNTY0YjVl
Li4zODUzZDQzIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9j
b21tb24uYw0KPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9jb21tb24uYw0K
PiA+IEBAIC04LDYgKzgsNyBAQA0KPiA+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4N
Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9zdXNwZW5kLmg+DQo+ID4NCj4gPiAgI2luY2x1ZGUgPGFzbS9xZS5oPg0KPiA+ICAjaW5jbHVk
ZSA8c3lzZGV2L2NwbTJfcGljLmg+DQo+ID4gQEAgLTQ3LDYgKzQ4LDE5IEBAIGludCBfX2luaXQg
bXBjODV4eF9jb21tb25fcHVibGlzaF9kZXZpY2VzKHZvaWQpDQo+ID4gIHsNCj4gPiAgCXJldHVy
biBvZl9wbGF0Zm9ybV9idXNfcHJvYmUoTlVMTCwgbXBjODV4eF9jb21tb25faWRzLCBOVUxMKTsg
IH0NCj4gPiArDQo+ID4gK3N0YXRpYyBzdXNwZW5kX3N0YXRlX3QgcG1fc3RhdGU7DQo+ID4gKw0K
PiA+ICt2b2lkIHNldF9wbV9zdXNwZW5kX3N0YXRlKHN1c3BlbmRfc3RhdGVfdCBzdGF0ZSkgew0K
PiA+ICsJcG1fc3RhdGUgPSBzdGF0ZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3VzcGVuZF9zdGF0
ZV90IHBtX3N1c3BlbmRfc3RhdGUodm9pZCkgew0KPiA+ICsJcmV0dXJuIHBtX3N0YXRlOw0KPiA+
ICt9DQo+IA0KPiBUaGVzZSBuZWVkIHRvIGJlIG5hbWVzcGFjZWQgdG8gaW5kaWNhdGUgdGhhdCB0
aGV5IGFwcGx5IG9ubHkgdG8gbXBjODV4eC4NCj4gV2hlcmUgZG8geW91IHBsYW4gb24gdXNpbmcg
dGhlc2UgZnJvbSwgdGhhdCBtcGM4NXh4IGNhbiBiZSBzYWZlbHkgYXNzdW1lZD8NCj4gDQoNCk1w
aWMgdGltZXIgYW5kIFBDSWUgZHJpdmVyLg0KDQo+IFRoaXMgc2VlbXMgbGlrZSBhIGZlYXR1cmUg
dGhhdCBzaG91bGQgYmUgaW1wbGVtZW50ZWQgaW4gZ2VuZXJpYyBjb2RlIGluc3RlYWQuDQo+IA0K
DQpPSywgSSB3aWxsIG1vdmUgdGhpcyB0byBhIGdlbmVyaWMgcGF0aC4NCg0KUmVnYXJkcywNCi1E
b25nc2hlbmcNCg0KPiAtU2NvdHQNCj4gDQoNCg==
