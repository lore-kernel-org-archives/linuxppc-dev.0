Return-Path: <raghav@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0103.outbound.protection.outlook.com [157.56.110.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B2EEF1A113B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 20:12:39 +1100 (AEDT)
From: Dogra Raghav <raghav@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: Kushwaha Prabhakar <prabhakar@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 1/2] mpc85xx/lbc: modify suspend/resume entry sequence
Date: Tue, 3 Nov 2015 09:12:31 +0000
Message-ID: <BY2PR0301MB0775B7E33F9D499183492087D22B0@BY2PR0301MB0775.namprd03.prod.outlook.com>
References: <1446186299-2921-1-git-send-email-raghav@freescale.com>
 <BY2PR0301MB0775A3A01F8585352ED5EFADD22C0@BY2PR0301MB0775.namprd03.prod.outlook.com>
 <1446505257.22185.43.camel@freescale.com>
 <BY2PR0301MB077529F563722A726BC39804D22B0@BY2PR0301MB0775.namprd03.prod.outlook.com>
 <1446529190.22185.51.camel@freescale.com>
 <BY2PR0301MB0775900A89741E58FA3822D9D22B0@BY2PR0301MB0775.namprd03.prod.outlook.com>
 <1446531228.22185.60.camel@freescale.com>
 <BY2PR0301MB07750650283AD03A00191EDFD22B0@BY2PR0301MB0775.namprd03.prod.outlook.com>
 <1446536197.22185.61.camel@freescale.com>
In-Reply-To: <1446536197.22185.61.camel@freescale.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMDMsIDIwMTUgMTowNyBQTQ0KPiBUbzogRG9n
cmEgUmFnaGF2LUI0NjE4NCA8cmFnaGF2QGZyZWVzY2FsZS5jb20+DQo+IENjOiBLdXNod2FoYSBQ
cmFiaGFrYXItQjMyNTc5IDxwcmFiaGFrYXJAZnJlZXNjYWxlLmNvbT47IGxpbnV4cHBjLQ0KPiBk
ZXZAbGlzdHMub3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gbXBjODV4eC9s
YmM6IG1vZGlmeSBzdXNwZW5kL3Jlc3VtZSBlbnRyeQ0KPiBzZXF1ZW5jZQ0KPiANCj4gT24gVHVl
LCAyMDE1LTExLTAzIGF0IDAwOjMzIC0wNjAwLCBEb2dyYSBSYWdoYXYtQjQ2MTg0IHdyb3RlOg0K
PiA+IEhpIFNjb3R0LA0KPiA+DQo+ID4gSSBqdXN0IGNoZWNrZWQgb24gcGF0Y2h3b3JrIGFuZCBu
b3RpY2VkIHRoYXQgdGhlIG9yaWdpbmFsIHBhdGNoIGhhcw0KPiA+IGJlZW4gbW9kaWZpZWQgYXMg
c29tZWhvdyBteSBvcmlnaW5hbCBjb21tZW50IGhhcyBiZWNvbWUgcGFydCBvZiB0aGUNCj4gcGF0
Y2g6DQo+ID4gKyAgICAgaWYgKCFsYmMpDQo+ID4gKyAgICAgICAgICAgICBnb3RvIG91dDsNCj4g
Pg0KPiA+ICAgICAgIGN0cmwtPnNhdmVkX3JlZ3MgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3QgZnNs
X2xiY19yZWdzKSwgR0ZQX0tFUk5FTCk7DQo+ID4gICAgICAgaWYgKCFjdHJsLT5zYXZlZF9yZWdz
KQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gW0RvZ3JhIFJhZ2hhdi1C
NDYxODRdIFRoaXMgaXMgdGhlIGV4aXN0aW5nIHVwc3RyZWFtIGNvZGUuIEFyZSB5b3UNCj4gPiBz
dWdnZXN0aW5nIHRvIG1vZGlmeSB0aGUgdXBzdHJlYW0gY29kZSB0byB0YWtlIGNhcmUgb2YgaW5k
aXZpZHVhbA0KPiByZWdpc3RlcnM/DQo+ID4NCj4gPiAgICAgICBfbWVtY3B5X2Zyb21pbyhjdHJs
LT5zYXZlZF9yZWdzLCBsYmMsIHNpemVvZihzdHJ1Y3QNCj4gPiBmc2xfbGJjX3JlZ3MpKTsNCj4g
PiArDQo+ID4gVGhlIHBhdGNod29yayBpcyBhbHNvIHNob3dpbmcgdHdvIGxpbmtzIGZvciB0aGUg
cGF0Y2guIFBsZWFzZSBhcHBseQ0KPiA+IHRoZSBvcmlnaW5hbCBwYXRjaCBwcmVzZW50IGF0Og0K
PiA+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvNTM4NjA1Lw0KPiA+DQo+ID4g
SSB3aWxsIGxvb2sgaW50byBob3cgdGhpcyBoYXBwZW5lZCB0byBhdm9pZCBzdWNoIGluY2lkZW50
cyBpbiBmdXR1cmUuDQo+IA0KPiBZb3VyIHJlcGx5IGxvb2tlZCBsaWtlIGEgbmV3IHBhdGNoLCBz
byBQYXRjaHdvcmsgdHJlYXRlZCBpdCBhcyBzdWNoLiAgSWYgeW91IGZpeA0KPiB5b3VyIG1haWxl
ciB0byB1c2UgcHJvcGVyIHF1b3RlIG1hcmtlcnMgKHRoZSA+IGF0IHRoZSBiZWdpbm5pbmcgb2Yg
ZWFjaA0KPiBsaW5lKSB0aGVuIHRoaXMgd29uJ3QgaGFwcGVuLg0KPiANCj4gLVNjb3R0DQoNCk9r
LCBzb3J0ZWQuDQoNCi1SYWdoYXYNCg==
