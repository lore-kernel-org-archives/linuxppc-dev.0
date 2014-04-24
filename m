Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B7C5F140109
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 13:05:50 +1000 (EST)
From: "Shengzhou.Liu@freescale.com" <Shengzhou.Liu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] net/phy:  tune get_phy_c45_ids to support more c45 phy
Date: Thu, 24 Apr 2014 03:05:29 +0000
Message-ID: <e8f3eb0b902143d59447c6ffc121182a@DM2PR03MB398.namprd03.prod.outlook.com>
References: <1398246951-27303-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1398286933.7841.49.camel@snotra.buserror.net>
In-Reply-To: <1398286933.7841.49.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "trini@ti.com" <trini@ti.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIx
DQo+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAyNCwgMjAxNCA1OjAyIEFNDQo+IFRvOiBMaXUgU2hl
bmd6aG91LUIzNjY4NQ0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IHRyaW5p
QHRpLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBuZXQvcGh5OiB0dW5lIGdldF9waHlfYzQ1
X2lkcyB0byBzdXBwb3J0IG1vcmUgYzQ1DQo+IHBoeQ0KPiANCj4gT24gV2VkLCAyMDE0LTA0LTIz
IGF0IDE3OjU1ICswODAwLCBTaGVuZ3pob3UgTGl1IHdyb3RlOg0KPiA+IEFzIHNvbWUgQzQ1IDEw
RyBQSFlzKGUuZy4gQ29ydGluYSBDUzQzMTUvQ1M0MzQwIFBIWSkgaGF2ZSB6ZXJvIERldmljZXMN
Cj4gPiBJbiBwYWNrYWdlLCBjdXJyZW50IGRyaXZlciBjYW4ndCBnZXQgY29ycmVjdCBkZXZpY2Vz
X2luX3BhY2thZ2UgdmFsdWUNCj4gPiBieSBub24temVybyBEZXZpY2VzIEluIHBhY2thZ2UuDQo+
ID4gc28gbGV0J3MgcHJvYmUgbW9yZSB3aXRoIHplcm8gRGV2aWNlcyBJbiBwYWNrYWdlIHRvIHN1
cHBvcnQgbW9yZSBDNDUNCj4gPiBQSFlzIHdoaWNoIGhhdmUgemVybyBEZXZpY2VzIEluIHBhY2th
Z2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVuZ3pob3UgTGl1IDxTaGVuZ3pob3UuTGl1
QGZyZWVzY2FsZS5jb20+DQo+ID4gLS0tDQo+ID4gVGVzdGVkIHdpdGggQ1M0MzE1IG9uIFQyMDgw
UkRCLCB0aGlzIHBhdGNoIGhhdmUgbm8gaW1wYWN0IG9uIHByZXZpb3VzDQo+IFhBVUkgcGh5IHdp
dGggdmVyaWZpY2F0aW9uLg0KPiA+DQo+ID4gIGRyaXZlcnMvbmV0L3BoeS9waHlfZGV2aWNlLmMg
fCAyNSArKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3BoeS9waHlfZGV2aWNlLmMNCj4gPiBiL2RyaXZlcnMvbmV0L3BoeS9waHlfZGV2aWNl
LmMgaW5kZXggY2ZiNTExMC4uOGZkNzc3ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9w
aHkvcGh5X2RldmljZS5jDQo+ID4gKysrIGIvZHJpdmVycy9uZXQvcGh5L3BoeV9kZXZpY2UuYw0K
PiANCj4gWW91IG5lZWQgdG8gc2VuZCB0aGlzIHRvIHRoZSBuZXRkZXYgbGlzdCBhbmQgbWFpbnRh
aW5lci4NCj4gDQo+IC1TY290dA0KPiANCltTaGVuZ3pob3VdIFNlbnQgdG8gbmV0ZGV2IGxpc3Qs
IGJ1dCBpdCBzZWVtcyB0aGVyZSBpcyBubyBtYWludGFpbmVyIG9mIGRyaXZlcnMvbmV0L3BoeSBp
biBNQUlOVEFJTkVSUyBsaXN0Lg0K
