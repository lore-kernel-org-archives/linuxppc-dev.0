Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 153F42C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 22:37:15 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>
Subject: RE: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
Date: Thu, 9 May 2013 12:36:14 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF3F80D6@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1367970043.3398.39@snotra> <5189B02E.3000109@windriver.com>
 <300B73AA675FCE4A93EB4FC1D42459FF3EFA26@039-SN2MPN1-013.039d.mgd.msft.net>
 <518A1AD8.3090103@windriver.com> <518B7913.6010302@windriver.com>
 <300B73AA675FCE4A93EB4FC1D42459FF3F7FBE@039-SN2MPN1-012.039d.mgd.msft.net>
 <518B8B2A.1020103@windriver.com>
In-Reply-To: <518B8B2A.1020103@windriver.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiB0aWVqdW4uY2hlbiBbbWFpbHRv
OnRpZWp1bi5jaGVuQHdpbmRyaXZlci5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMDksIDIw
MTMgMjo0MCBQTQ0KPiBUbzogQ2FyYW1hbiBNaWhhaSBDbGF1ZGl1LUIwMjAwOA0KPiBDYzogV29v
ZCBTY290dC1CMDc0MjE7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBhZ3JhZkBzdXNl
LmRlOyBrdm0tDQo+IHBwY0B2Z2VyLmtlcm5lbC5vcmc7IGt2bUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFt2MV1bS1ZNXVtQQVRDSCAxLzFdIGt2bTpwcGM6Ym9vZWh2OiBkaXJlY3Qg
SVNJIGV4Y2VwdGlvbiB0bw0KPiBHdWVzdA0KPiANCj4gT24gMDUvMDkvMjAxMyAwNzozNCBQTSwg
Q2FyYW1hbiBNaWhhaSBDbGF1ZGl1LUIwMjAwOCB3cm90ZToNCj4gPj4+PiBWRiBzdGFuZHMgZm9y
IHZpcnR1YWxpemF0aW9uIGZhdWx0IHNlZSBNQVM4W1ZGXSBhbmQgd2UgbWF5IHVzZSBpdA0KPiBm
b3INCj4gPj4gdmlydHVhbGl6ZWQNCj4gPj4NCj4gPj4gTG9va3MgS1ZNIFBQQyBoYXZlIG5vIHRo
aXMgbWVjaGFuaXNtIGN1cnJlbnRseSBzaW5jZSBJIGRvbid0IGZpbmQNCj4gTUFTOF9WRg0KPiA+
PiBpcw0KPiA+PiB1c2VkIGluIGtlcm5lbCwgcmlnaHQ/DQo+ID4NCj4gPiBZZXMgYnV0ICd3ZSBt
YXkgdXNlIGl0JyBpbiB0aGUgZmVhdHVyZSwgSSBoYXZlIGEgZnVuY3Rpb25hbCBQT0Mgd2l0aA0K
PiBWRi4NCj4gDQo+IEFueSBJTyBwZXJmb3JtYW5jZSB0byBiZSBpbXByb3ZlZCB3aXRoIHRoaXMg
UE9DPw0KDQpWRiBhcHByb2FjaCBwdXRzIG1vcmUgc3RyZXNzIG9uIEhXIFRMQiBzbyBJIGRpZCBu
b3QgYWR2YW5jZSB3aXRoIHBlcmZvcm1hbmNlDQptZWFzdXJlbWVudHMgdGhvdWdoIGl0IG1heSB3
b3J0aCB0byBkbyBpdC4NCg0KLU1pa2UNCg==
