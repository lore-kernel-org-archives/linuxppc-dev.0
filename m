Return-Path: <B36685@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BEF18B74CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2012 21:17:05 +1100 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH] powerpc/usb: fix issue of CPU halt when missing USB PHY
 clock
Date: Thu, 16 Feb 2012 10:16:46 +0000
Message-ID: <3F453DDFF675A64A89321A1F3528102170A519@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1328088017-9262-1-git-send-email-Shengzhou.Liu@freescale.com>
 <4F290FCF.1040406@codeaurora.org>
 <3F453DDFF675A64A89321A1F352810216EDA8B@039-SN1MPN1-005.039d.mgd.msft.net>
 <1329273064.3772.18.camel@pasglop>
In-Reply-To: <1329273064.3772.18.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Pavan Kondeti <pkondeti@codeaurora.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJlbmphbWluIEhlcnJlbnNj
aG1pZHQgW21haWx0bzpiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmddDQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgRmVicnVhcnkgMTUsIDIwMTIgMTA6MzEgQU0NCj4gVG86IExpdSBTaGVuZ3pob3UtQjM2Njg1
DQo+IENjOiBQYXZhbiBLb25kZXRpOyBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eHBw
Yy0NCj4gZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gcG93ZXJw
Yy91c2I6IGZpeCBpc3N1ZSBvZiBDUFUgaGFsdCB3aGVuIG1pc3NpbmcNCj4gVVNCIFBIWSBjbG9j
aw0KPiANCj4gDQo+ID4gPiA+ICsJaWYgKCEoaW5fYmUzMihub25fZWhjaSArIEZTTF9TT0NfVVNC
X0NUUkwpICYNCj4gPiA+ID4gK0NUUkxfUEhZX0NMS19WQUxJRCkpDQo+ID4gPiB7DQo+ID4gPiA+
ICsJCXByaW50ayhLRVJOX1dBUk5JTkcgImZzbC1laGNpOiBVU0IgUEhZIGNsb2NrDQo+IGludmFs
aWRcbiIpOw0KPiA+ID4gPiArCQlyZXR1cm4gLTE7DQo+ID4gPg0KPiA+ID4gUGxlYXNlIHJldHVy
biBhIHByb3BlciBlcnJvciBjb2RlLiAtRU5PREVWID8NCj4gPg0KPiA+IFtTaGVuZ3pob3VdIE9r
LCB1cGRhdGVkIGluIHYyLCB0aGFua3MuDQo+ID4gPg0KPiANCj4gTm90ZSB0aGF0IEkganVzdCBn
b3QgYSBwNTAyMGRzIGZyb20gRlNMLCBhbmQgd2l0aCBpdCdzIGRlZmF1bHQNCj4gY29uZmlndXJh
dGlvbiwgd2hlbiBJIGJ1aWxkICYgYm9vdCBjdXJyZW50IHVwc3RyZWFtIHdpdGggRlNMIFVTQg0K
PiBzdXBwb3J0ICg2NC1iaXQga2VybmVsKSBpdCBoYW5ncyB3aGVuIGluaXRpYWxpemluZyBVU0Iu
DQo+IA0KPiBXaXRoIG9yIHdpdGhvdXQgdGhpcyBwYXRjaC4NCj4gDQo+IEl0IGNvbXBsYWlucyBh
Ym91dCBpbnZhbGlkIGRyLW1vZGUgKHRoZXJlJ3MgdHdvIFVTQiBub2RlcyBpbiB0aGUgLmR0cw0K
PiBjb21pbmcgZnJvbSB1Ym9vdCwgYW4gIm1waCIgYW5kICJkciIsIHRoZSBmb3JtZXIgaGFzIG5v
IGRyLW1vZGUNCj4gcHJvcGVydHkgaW4gdGhlIGRldmljZS10cmVlLg0KPiANCj4gSXMgdGhlIGN1
cnJlbnQga2VybmVsIGluY29tcGF0aWJsZSB3aXRoIG9sZCBkZXZpY2UtdHJlZSdzID8gKHRoYXQg
d291bGQNCj4gYmUgYSBzaGFtZS4uLikNCj4gDQo+IENoZWVycywNCj4gQmVuLg0KPiANCj4gDQpM
b29rcyBsaWtlIHRoZXJlIGlzIGEgYnVnLCBwbGVhc2UgdHJ5IHRvIGFkZCB0aGUgcGF0Y2ggaHR0
cDovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzE0MTU1OA0KLVNoZW5nemhvdQ0KDQoNCg0K
