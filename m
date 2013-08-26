Return-Path: <B40534@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3F8202C008C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 12:34:29 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 1/2] powerpc/85xx: add hardware automatically enter
 altivec idle state
Date: Mon, 26 Aug 2013 02:34:19 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259010289ED@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1376637789-27330-1-git-send-email-dongsheng.wang@freescale.com>
 <83499AB5-DCE7-407D-AEC1-B2493D1D38BE@kernel.crashing.org>
 <1376671853.31636.252.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F154392590101E5A5@039-SN2MPN1-021.039d.mgd.msft.net>
 <1376959116.31636.392.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F1543925901027BD3@039-SN2MPN1-021.039d.mgd.msft.net>
 <1377184761.5029.96.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010281F1@039-SN2MPN1-021.039d.mgd.msft.net>
 <1377271865.20722.44.camel@snotra.buserror.net>
In-Reply-To: <1377271865.20722.44.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMjMsIDIwMTMgMTE6MzEgUE0NCj4gVG86IFdhbmcg
RG9uZ3NoZW5nLUI0MDUzNA0KPiBDYzogV29vZCBTY290dC1CMDc0MjE7IEt1bWFyIEdhbGE7IFpo
YW8gQ2hlbmh1aS1CMzUzMzY7IGxpbnV4cHBjLQ0KPiBkZXZAbGlzdHMub3psYWJzLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDEvMl0gcG93ZXJwYy84NXh4OiBhZGQgaGFyZHdhcmUgYXV0b21h
dGljYWxseSBlbnRlcg0KPiBhbHRpdmVjIGlkbGUgc3RhdGUNCj4gDQo+IE9uIFRodSwgMjAxMy0w
OC0yMiBhdCAyMTo1MiAtMDUwMCwgV2FuZyBEb25nc2hlbmctQjQwNTM0IHdyb3RlOg0KPiA+DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogV29vZCBTY290dC1C
MDc0MjENCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjIsIDIwMTMgMTE6MTkgUE0NCj4g
PiA+IFRvOiBXYW5nIERvbmdzaGVuZy1CNDA1MzQNCj4gPiA+IENjOiBXb29kIFNjb3R0LUIwNzQy
MTsgS3VtYXIgR2FsYTsgWmhhbyBDaGVuaHVpLUIzNTMzNjsgbGludXhwcGMtDQo+ID4gPiBkZXZA
bGlzdHMub3psYWJzLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHBvd2VycGMv
ODV4eDogYWRkIGhhcmR3YXJlIGF1dG9tYXRpY2FsbHkNCj4gZW50ZXINCj4gPiA+IGFsdGl2ZWMg
aWRsZSBzdGF0ZQ0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgMjAxMy0wOC0yMSBhdCAyMjoxMyAtMDUw
MCwgV2FuZyBEb25nc2hlbmctQjQwNTM0IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+ID4gRnJvbTogV29vZCBTY290dC1CMDc0MjEN
Cj4gPiA+ID4gPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjAsIDIwMTMgODozOSBBTQ0KPiA+ID4g
PiA+IFRvOiBXYW5nIERvbmdzaGVuZy1CNDA1MzQNCj4gPiA+ID4gPiBDYzogV29vZCBTY290dC1C
MDc0MjE7IEt1bWFyIEdhbGE7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnDQo+ID4gPiA+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHBvd2VycGMvODV4eDogYWRkIGhhcmR3YXJlIGF1
dG9tYXRpY2FsbHkNCj4gPiA+ID4gPiBlbnRlciBhbHRpdmVjIGlkbGUgc3RhdGUNCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IEl0IGp1c3Qgc2VlbXMgd3JvbmcgdG8gaGF2ZSBhbiBhZC1ob2MgbWVjaGFu
aXNtIGZvciBydW5uaW5nDQo+ID4gPiA+ID4gY29yZS1zcGVjaWZpYyBjb2RlIHdoZW4gd2UgaGF2
ZSBjcHV0YWJsZS4uLiAgSWYgd2UgcmVhbGx5IG5lZWQNCj4gdGhpcywNCj4gPiA+ID4gPiBtYXli
ZSB3ZSBzaG91bGQgYWRkIGEgImNwdV9zZXR1cF9sYXRlIiBmdW5jdGlvbiBwb2ludGVyLg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gV2l0aCB5b3VyIHBhdGNoLCB3aGVuIGRvZXMgdGhlIHBvd2VyIG1h
bmFnZW1lbnQgcmVnaXN0ZXIgZ2V0IHNldA0KPiA+ID4gPiA+IHdoZW4gaG90IHBsdWdnaW5nIGEg
Y3B1Pw0KPiA+ID4gPiA+DQo+ID4gPiA+IFVtLi4gSSBkb24ndCBkZWFsIHdpdGggdGhpcyBzaXR1
YXRpb24uIEkgd2lsbCBmaXggaXQuDQo+ID4gPiA+IF9fc2V0dXAvcmVzdG9yZV9jcHVfZTY1MDAg
bG9va3MgZ29vZC4gQnV0IG9ubHkgYm9vdGNwdSBjYWxsDQo+ID4gPiBfX3NldHVwX2NwdV9lNjUw
MCwgbm90IG9uIGVhY2ggY3B1Lg0KPiA+ID4gPiBJIHRoaW5rIHRoaXMgaXMgYSBidWcuDQo+ID4g
Pg0KPiA+ID4gT3RoZXIgQ1BVcyBjYWxsIF9fcmVzdG9yZV9jcHVfZTY1MDAuDQo+ID4gPg0KPiA+
IE5vLCB0aGVyZSBpcyBib290Y29yZSBvZiBzZWNvbmRhcnkgdGhyZWFkLCBhbmQgb3RoZXIgY29y
ZXMgb2YgZmlyc3QNCj4gdGhyZWFkIGNhbGwgX19yZXN0b3JlX2NwdV9lNjUwMC4NCj4gDQo+IFRo
aXMgaXMgdGhlIHVwc3RyZWFtIGxpc3QgLS0gdGhlcmUgaXMgbm8gZTY1MDAgdGhyZWFkIHN1cHBv
cnQgeWV0LiA6LSkNCj4gDQo+IEJ1dCBpbiB0aGUgU0RLIEkgZG8gc2VlIGdlbmVyaWNfc2Vjb25k
YXJ5X2NvbW1vbl9pbml0IGJlaW5nIGNhbGxlZCBmcm9tDQo+IGdlbmVyaWNfc2Vjb25kYXJ5X3Ro
cmVhZF9pbml0LCB3aGljaCBtZWFucyBfX3Jlc3RvcmVfY3B1X2U2NTAwIHdpbGwgYmUNCj4gY2Fs
bGVkLg0KDQpUaGFua3MuDQo=
