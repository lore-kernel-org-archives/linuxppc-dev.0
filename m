Return-Path: <B13201@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2C1FAB6F13
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 21:03:32 +1100 (EST)
From: Liu Yu-B13201 <B13201@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v4 1/3] KVM: PPC: epapr: Factor out the epapr init
Date: Fri, 17 Feb 2012 10:03:25 +0000
Message-ID: <4CA99838F21AB847ACC344051E2317090571F056@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
 <4F3D3933.3020501@freescale.com>
In-Reply-To: <4F3D3933.3020501@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAxNywgMjAxMiAxOjEzIEFNDQo+IFRvOiBMaXUg
WXUtQjEzMjAxDQo+IENjOiBhZ3JhZkBzdXNlLmRlOyBrdm0tcHBjQHZnZXIua2VybmVsLm9yZzsg
a3ZtQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXhwcGMtZGV2QG96bGFicy5vcmc7IFdvb2QgU2Nv
dHQtQjA3NDIxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS8zXSBLVk06IFBQQzogZXBhcHI6
IEZhY3RvciBvdXQgdGhlIGVwYXByIGluaXQNCj4gDQo+IE9uIDAyLzE2LzIwMTIgMDM6MjYgQU0s
IExpdSBZdSB3cm90ZToNCj4gPiBmcm9tIHRoZSBrdm0gZ3Vlc3QgcGFyYXZpcnQgaW5pdCBjb2Rl
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGl1IFl1IDx5dS5saXVAZnJlZXNjYWxlLmNvbT4N
Cj4gPiAtLS0NCj4gPiB2NDoNCj4gPiAxLiBjb2RlIGNsZWFudXANCj4gPiAyLiBtb3ZlIGt2bV9o
eXBlcmNhbGxfc3RhcnQoKSB0byBlcGFwcl9oeXBlcmNhbGxfc3RhcnQoKQ0KPiA+DQo+ID4gIGFy
Y2gvcG93ZXJwYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICAgIDQgKysNCj4gPiAgYXJj
aC9wb3dlcnBjL2luY2x1ZGUvYXNtL2VwYXByX2hjYWxscy5oIHwgICAgMiArDQo+ID4gIGFyY2gv
cG93ZXJwYy9rZXJuZWwvTWFrZWZpbGUgICAgICAgICAgICB8ICAgIDEgKw0KPiA+ICBhcmNoL3Bv
d2VycGMva2VybmVsL2VwYXByLlMgICAgICAgICAgICAgfCAgIDI1ICsrKysrKysrKysrKysrKysN
Cj4gPiAgYXJjaC9wb3dlcnBjL2tlcm5lbC9lcGFwcl9wYXJhLmMgICAgICAgIHwgICA0OQ0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGFyY2gvcG93ZXJwYy9rZXJuZWwv
a3ZtLmMgICAgICAgICAgICAgICB8ICAgMjggKystLS0tLS0tLS0tLS0tLS0tDQo+ID4gIGFyY2gv
cG93ZXJwYy9rZXJuZWwva3ZtX2VtdWwuUyAgICAgICAgICB8ICAgMTAgLS0tLS0tDQo+ID4gIGFy
Y2gvcG93ZXJwYy9rdm0vS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAgIDEgKw0KPiA+ICA4IGZp
bGVzIGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1v
ZGUNCj4gPiAxMDA2NDQgYXJjaC9wb3dlcnBjL2tlcm5lbC9lcGFwci5TICBjcmVhdGUgbW9kZSAx
MDA2NDQNCj4gPiBhcmNoL3Bvd2VycGMva2VybmVsL2VwYXByX3BhcmEuYw0KPiANCj4gVGhlIGNv
bW1lbnQgYWJvdXQgc3BlbGxpbmcgb3V0ICJwYXJhdmlydCIgd2Fzbm4ndCBtZWFudCB0byBiZSBy
ZXN0cmljdGVkDQo+IHRvIHRoZSBrY29uZmlnIHN5bWJvbC4gIFRoZXJlIGFyZSBsb3RzIG9mIHdv
cmRzIHRoYXQgYmVnaW4gd2l0aCAicGFyYSIsDQo+IGFuZCBlUEFQUiBpc24ndCBqdXN0IGFib3V0
IHZpcnR1YWxpemF0aW9uLg0KDQpXaGF0IGRvIHlvdSBtZWFuPyBEbyB5b3Ugc3VnZ2VzdCB0aGF0
IHdlIHNob3VsZCBuYW1lIGl0IGVwYXByX3BhcmF2aXJ0LmM/DQoNClRoYW5rcywNCll1DQo=
