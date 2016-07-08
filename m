Return-Path: <yangbo.lu@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0076.outbound.protection.outlook.com [104.47.2.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlzrr2xJxzDqpk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 13:05:47 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Scott Wood <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Mark Rutland <mark.rutland@arm.com>, "Ulf
 Hansson" <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Russell King
 <linux@arm.linux.org.uk>, Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Joerg Roedel <joro@8bytes.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Rob Herring
 <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, Yang-Leo Li
 <leoyang.li@nxp.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 2/4] soc: fsl: add GUTS driver for QorIQ platforms
Date: Fri, 8 Jul 2016 03:05:41 +0000
Message-ID: <HE1PR04MB0889950E99B791029F1670E9F83C0@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <1465609853.22191.151.camel@buserror.net>
 <HE1PR04MB0889646206BFAD68046F3473F83B0@HE1PR04MB0889.eurprd04.prod.outlook.com>
 <4094106.qfxJu3tJbO@wuerfel>
In-Reply-To: <4094106.qfxJu3tJbO@wuerfel>
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

SGkgQXJuZCwNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFybmQg
QmVyZ21hbm4gW21haWx0bzphcm5kQGFybmRiLmRlXQ0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAw
NywgMjAxNiA0OjMwIFBNDQo+IFRvOiBZYW5nYm8gTHUNCj4gQ2M6IFNjb3R0IFdvb2Q7IGxpbnV4
cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBNYXJrIFJ1dGxhbmQ7IFVsZiBIYW5zc29uOw0KPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1pMmNAdmdlci5rZXJuZWwub3JnOyBs
aW51eC0NCj4gY2xrQHZnZXIua2VybmVsLm9yZzsgUWlhbmcgWmhhbzsgUnVzc2VsbCBLaW5nOyBC
aHVwZXNoIFNoYXJtYTsgSm9lcmcNCj4gUm9lZGVsOyBDbGF1ZGl1IE1hbm9pbDsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IEt1bWFyIEdhbGE7IFJvYg0KPiBIZXJyaW5nOyBTYW50b3NoIFNo
aWxpbWthcjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBuZXRkZXZA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBYaWFvYm8gWGllOyBZ
YW5nLUxlbw0KPiBMaTsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAyLzRdIHNvYzogZnNsOiBhZGQgR1VUUyBkcml2ZXIgZm9yIFFvcklRIHBs
YXRmb3Jtcw0KPiANCj4gT24gVGh1cnNkYXksIEp1bHkgNywgMjAxNiAyOjM1OjMzIEFNIENFU1Qg
WWFuZ2JvIEx1IHdyb3RlOg0KPiA+IEhpIEFybmQsDQo+ID4NCj4gPiBDb3VsZCB5b3UgcmVwbHkg
d2hlbiB5b3Ugc2VlIHRoZSBlbWFpbD8NCj4gPiBJZiB5b3VyIG1ldGhvZCBkb2VzbuKAmXQgcmVz
b2x2ZSB0aGUgcHJvYmxlbSwgd2Ugc3RpbGwgd2FudCB0byB1c2Ugb3VyDQo+IG9sZCBwYXRjaHNl
dC4NCj4gPg0KPiA+IFRoaXMgZ3V0cyBkcml2ZXIgaGFkIGJlZW4gZGlzY3Vzc2VkIGFib3V0IG9u
ZSB5ZWFyIGFuZCBibG9ja2VkIG1hbnkNCj4gd29ya2Fyb3VuZCB1cHN0cmVhbS4NCj4gPiBTbyBw
bGVhc2UgaGVscCB0byByZXZpZXcgYW5kIGNvbW1lbnQgc29vbi4NCj4gPg0KPiANCj4gSSBkb24n
dCByZWFsbHkgc2VlIGhvdyBtb3JlIGRpc2N1c3Npb24gaXMgZ29pbmcgdG8gaGVscCB1cyBoZXJl
LiBJIHRoaW5rDQo+IEkndmUgbWFkZSBpdCBwcmV0dHkgY2xlYXIgdGhhdCBJIGRvbid0IHdhbnQg
dG8gc2VlIGFub3RoZXIgcGxhdGZvcm0NCj4gc3BlY2lmaWMgd2F5IHRvIHJlYWQgYW4gU29DIHJl
dmlzaW9uIGFuZCBJJ3ZlIGV2ZW4gc2VudCBhIHByb29mLW9mLQ0KPiBjb25jZXB0IHBhdGNoIHRv
IHNob3cgaG93IHRoZSBpbnRlcmZhY2UgY2FuIHdvcmssIG5vdyBpdCdzIHVwIHRvIHlvdSB0bw0K
PiBmaXQgdGhlIGd1dHMgaGFyZHdhcmUgaW50byB0aGF0IGFuZCBzZW5kIGEgbmV3IHBhdGNoIHNl
cmllcy4NCj4gDQo+IAlBcm5kDQoNCkkgdGhpbmsgeW91ciBwcm9vZi1vZi1jb25jZXB0IHBhdGNo
IGlzIHN0aWxsIGluIGRpc2N1c3Npb24uIFNvbWUgYW5zd2VycyBhcmUgbmVlZGVkIGZyb20geW91
IHRvDQphZGRyZXNzIFNjb3R0J3MgY29tbWVudHMgb24geW91ciBwYXRjaHNldC4gSGF2ZSB5b3Ug
cmVhY2hlZCBhbiBhZ3JlZW1lbnQ/DQoNClRoYW5rcy4NCg0KLSBZYW5nYm8gTHUNCg0KDQoNCg==
