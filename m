Return-Path: <pbathija@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.90])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B56FAB7079
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 16:57:37 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit
	resources.
Date: Thu, 5 Nov 2009 21:57:06 -0800
Message-ID: <9D1E2BDCB5C57B46B56E6D80843439EB094F5008@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <1257451218.13611.114.camel@pasglop>
References: <1253053555-25097-1-git-send-email-pbathija@amcc.com>
	<20091105134330.GA30489@zod.rchland.ibm.com>
	<1257437226.2753.64.camel@mulgrave.site>
	<1257451218.13611.114.camel@pasglop>
From: "Pravin Bathija" <pbathija@amcc.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"James Bottomley" <James.Bottomley@suse.de>
Cc: Eric.Moore@lsi.com, linux-scsi@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuamFtaW4gSGVycmVu
c2NobWlkdCBbbWFpbHRvOmJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZ10NCj4gU2VudDogVGh1cnNk
YXksIE5vdmVtYmVyIDA1LCAyMDA5IDEyOjAwIFBNDQo+IFRvOiBKYW1lcyBCb3R0b21sZXkNCj4g
Q2M6IEpvc2ggQm95ZXI7IEVyaWMuTW9vcmVAbHNpLmNvbTsgUHJhdmluIEJhdGhpamE7IGxpbnV4
LQ0KPiBzY3NpQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtZGV2QG96bGFicy5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gW1NDU0ldIG1wdCBmdXNpb246IEZpeCAzMiBiaXQgcGxhdGZvcm1z
IHdpdGggNjQNCj4gYml0IHJlc291cmNlcy4NCj4gDQo+IE9uIFRodSwgMjAwOS0xMS0wNSBhdCAx
MDowNyAtMDYwMCwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOg0KPiANCj4gPiA+ID4gCWlvYy0+bWVt
bWFwID0gbWVtOw0KPiA+ID4gPi0JZGluaXRwcmludGsoaW9jLCBwcmludGsoTVlJT0Nfc19JTkZP
X0ZNVCAibWVtID0gJXAsDQo+IG1lbV9waHlzID0gJWx4XG4iLA0KPiA+ID4gPi0JICAgIGlvYy0+
bmFtZSwgbWVtLCBtZW1fcGh5cykpOw0KPiA+ID4gPisJZGluaXRwcmludGsoaW9jLCBwcmludGso
TVlJT0Nfc19JTkZPX0ZNVCAibWVtID0gJXAsDQo+IG1lbV9waHlzID0gJWxseFxuIiwNCj4gPiA+
ID4rCSAgICBpb2MtPm5hbWUsIG1lbSwgKHU2NCltZW1fcGh5cykpOw0KPiA+ID4gPg0KPiA+ID4g
PiAJaW9jLT5tZW1fcGh5cyA9IG1lbV9waHlzOw0KPiA+ID4gPiAJaW9jLT5jaGlwID0gKFNZU0lG
X1JFR1MgX19pb21lbSAqKW1lbTsNCj4gPiA+ID4NCj4gPiA+ID4gCS8qIFNhdmUgUG9ydCBJTyB2
YWx1ZXMgaW4gY2FzZSB3ZSBuZWVkIHRvIGRvIGRvd25sb2FkYm9vdA0KPiAqLw0KPiA+ID4gPi0J
aW9jLT5waW9fbWVtX3BoeXMgPSBwb3J0Ow0KPiA+ID4gPisJcG9ydCA9IGlvcmVtYXAocG9ydF9w
aHlzLCBwc2l6ZSk7DQo+ID4gPiA+KwlpZiAocG9ydCA9PSBOVUxMKSB7DQo+ID4gPiA+KwkJcHJp
bnRrKE1ZSU9DX3NfRVJSX0ZNVCAiIDogRVJST1IgLSBVbmFibGUgdG8gbWFwDQo+IGFkYXB0ZXIi
DQo+ID4gPiA+KwkJCSIgcG9ydCAhXG4iLCBpb2MtPm5hbWUpOw0KPiA+ID4gPisJCXJldHVybiAt
RUlOVkFMOw0KPiA+DQo+ID4gU28gdGhpcyBsb29rcyBwcm9ibGVtYXRpYyBvbiBhIGZldyBwbGF0
Zm9ybXMgLi4uIHdoYXQgaGFwcGVucyB0bw0KPiA+IHBsYXRmb3JtcyB0aGF0IGhhdmUgbm8gSU8g
c3BhY2U/ICBUaGV5IGF1dG9tYXRpY2FsbHkgZmFpbCBoZXJlIGFuZCBpdA0KPiA+IGxvb2tzIGxp
a2UgdGhlIGFkYXB0ZXIgbmV2ZXIgYXR0YWNoZXMuDQo+IA0KPiBZdXAsIHRoYXQgcGFydCBvZiB0
aGUgcGF0Y2ggbG9va3Mgd3JvbmcuDQo+IA0KPiBIb3dldmVyLCBhIG1lY2hhbmljYWwgcmVwbGFj
ZW1lbnQgb2YgdW5zaWduZWQgbG9uZydzIHdpdGgNCj4gcmVzb3VyY2Vfc2l6ZV90IHRvIGhvbGQg
cGh5c2ljYWwgYWRkcmVzc2VzIHNob3VsZCBiZSBmaW5lIGRlc3BpdGUgdGhlDQo+IGxhY2sgb2Yg
ZmVlZGJhY2sgZnJvbSBMU0kuDQo+IA0KPiBQcmF2aW4sIHRoYXQgaW9yZW1hcCBkZWZpbml0ZWx5
IHNlZW1zIGxpa2UgaXQgaGFzIG5vdGhpbmcgdG8gZG8gdGhlcmUsDQo+IHBvcnQgSU8gaXMgYWxy
ZWFkeSByZW1hcHBlZCBmb3IgeW91IGJ5IHRoZSBjb3JlIFBDSSBjb2RlIGFuZCBzaG91bGQNCj4g
d29yaw0KPiAiYXMgaXMiLiBQbGVhc2UgcmVzcGluIHdpdGhvdXQgdGhhdCBjaGFuZ2UuDQo+IA0K
PiBDaGVlcnMsDQo+IEJlbi4NCj4gDQoNClRoYW5rcyBmb3IgdGhlIGlucHV0LiBXaWxsIG1ha2Ug
dGhlIHN1Z2dlc3RlZCBjaGFuZ2VzIGFuZCByZS1zdWJtaXQgcGF0Y2guDQpSZWdhcmRzLA0KUHJh
dmluDQo=
