Return-Path: <Gang.Liu@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0244.outbound.protection.outlook.com [207.46.163.244])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE2EB1A000D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 20:09:59 +1000 (EST)
From: "Gang.Liu@freescale.com" <Gang.Liu@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Martijn de Gouw
 <martijn.de.gouw@prodrive-technologies.com>
Subject: RE: [PATCH v2] fsl-rio: add support for mapping inbound windows
Date: Wed, 25 Jun 2014 09:55:01 +0000
Message-ID: <50df6a8d1d394ec0a4838998e4474197@BY2PR03MB412.namprd03.prod.outlook.com>
References: <1403532715-21389-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
 <1403656857.2435.61.camel@snotra.buserror.net>
In-Reply-To: <1403656857.2435.61.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "Alexandre.Bounine@idt.com" <Alexandre.Bounine@idt.com>,
 Martijn de Gouw <martijn.de.gouw@prodrive.nl>,
 "Barry.Wood@idt.com" <Barry.Wood@idt.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "stef.van.os@prodrive-technologies.com"
 <stef.van.os@prodrive-technologies.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gZnNsLXJpbzogYWRkIHN1cHBvcnQgZm9yIG1hcHBpbmcg
aW5ib3VuZCB3aW5kb3dzDQo+IA0KPiBGcm9tOiBNYXJ0aWpuIGRlIEdvdXcgPG1hcnRpam4uZGUu
Z291d0Bwcm9kcml2ZS5ubD4NCj4gDQo+IEFkZCBzdXBwb3J0IGZvciBtYXBwaW5nIGFuZCB1bm1h
cHBpbmcgb2YgaW5ib3VuZCByYXBpZGlvIHdpbmRvd3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBN
YXJ0aWpuIGRlIEdvdXcgPG1hcnRpam4uZGUuZ291d0Bwcm9kcml2ZS10ZWNobm9sb2dpZXMuY29t
Pg0KPiAtLS0NCj4gIGFyY2gvcG93ZXJwYy9zeXNkZXYvZnNsX3Jpby5jIHwgICA5MiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgYXJjaC9wb3dlcnBjL3N5c2Rl
di9mc2xfcmlvLmggfCAgIDEyICsrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMDQgaW5zZXJ0
aW9ucygrKQ0KDQo+ICsJLyogY2hlY2sgZm9yIGNvbmZsaWN0aW5nIHJhbmdlcyAqLw0KPiArCWZv
ciAoaSA9IDA7IGkgPCBSSU9fSU5CX0FUTVVfQ09VTlQ7IGkrKykgew0KPiArCQlyaXdhciA9IGlu
X2JlMzIoJnByaXYtPmluYl9hdG11X3JlZ3NbaV0ucml3YXIpOw0KPiArCQlpZiAoKHJpd2FyICYg
UklXQVJfRU5BQkxFKSA9PSAwKQ0KPiArCQkJY29udGludWU7DQo+ICsJCXdpbl9zdGFydCA9ICgo
dTY0KShpbl9iZTMyKCZwcml2LT5pbmJfYXRtdV9yZWdzW2ldLnJpd2JhcikgJg0KPiBSSVdCQVJf
QkFERF9NQVNLKSkNCj4gKwkJCTw8IFJJV0JBUl9CQUREX1ZBTF9TSElGVDsNCj4gKwkJd2luX2Vu
ZCA9IHdpbl9zdGFydCArICgoMSA8PCAoKHJpd2FyICYgUklXQVJfU0laRV9NQVNLKSArIDEpKSAt
IDEpOw0KPiArCQlpZiAocnN0YXJ0IDwgd2luX2VuZCAmJiAocnN0YXJ0ICsgc2l6ZSkgPiB3aW5f
c3RhcnQpDQo+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQoNCkZvciB0aGUgaW5ib3VuZCB3
aW5kb3csIHRoZSBiYXNlIGFkZHJlc3MgbXVzdCBiZSBhbGlnbmVkIGJhc2VkIG9uIHRoZQ0Kc2l6
ZSBzZWxlY3RlZCBpbiB0aGUgd2luZG93IHNpemUgYml0cy4gU28gSSB0aGluayBpdCB3aWxsIGJl
IGJldHRlcg0KaWYgeW91IGNhbiBjaGVjayB0aGUgYWxpZ25tZW50Lg0KDQoNCj4gQEAgLTU5OCw2
ICs2ODcsOCBAQCBpbnQgZnNsX3Jpb19zZXR1cChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYp
DQo+ICAJCQlSSU9fQVRNVV9SRUdTX1BPUlQyX09GRlNFVCkpOw0KPiANCj4gIAkJcHJpdi0+bWFp
bnRfYXRtdV9yZWdzID0gcHJpdi0+YXRtdV9yZWdzICsgMTsNCj4gKwkJcHJpdi0+aW5iX2F0bXVf
cmVncyA9IChzdHJ1Y3QgcmlvX2luYl9hdG11X3JlZ3MgKikNCj4gKwkJCShwcml2LT5yZWdzX3dp
biArIFJJT19JTkJfQVRNVV9SRUdTX09GRlNFVCk7DQoNClRoZSBSSU9fSU5CX0FUTVVfUkVHU19P
RkZTRVQgaXMganVzdCBmb3IgcG9ydCAxLCBJIHRoaW5rIHRoZSBwb3J0IDINCmFsc28gc2hvdWxk
IGJlIHN1cHBvcnRlZC4NCg0KQmVzdCBSZWdhcmRzLA0KTGl1IEdhbmcNCg==
