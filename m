Return-Path: <yangbo.lu@nxp.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20073.outbound.protection.outlook.com [40.107.2.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4tYT2V8LzDvk6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 17:06:21 +1100 (AEDT)
From: "Y.B. Lu" <yangbo.lu@nxp.com>
To: "Y.B. Lu" <yangbo.lu@nxp.com>, Scott Wood <oss@buserror.net>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Russell King <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>,
 Joerg Roedel <joro@8bytes.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>, Bhupesh Sharma
 <bhupesh.sharma@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>, Kumar Gala
 <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>, Leo Li
 <leoyang.li@nxp.com>, "X.B. Xie" <xiaobo.xie@nxp.com>, "M.H. Lian"
 <minghuan.lian@nxp.com>
Subject: RE: [v13, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
Date: Fri, 28 Oct 2016 06:06:10 +0000
Message-ID: <DB6PR0401MB253607E63983FFF02C24B75DF8AD0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1477625554-46700-1-git-send-email-yangbo.lu@nxp.com>
 <1477625554-46700-6-git-send-email-yangbo.lu@nxp.com>
 <1477629956.6812.15.camel@buserror.net>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZLkIuIEx1DQo+IFNlbnQ6IEZy
aWRheSwgT2N0b2JlciAyOCwgMjAxNiAyOjAwIFBNDQo+IFRvOiAnU2NvdHQgV29vZCc7IGxpbnV4
LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IEFybmQNCj4gQmVy
Z21hbm4NCj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGNsa0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5vcmc7IGlvbW11QGxpc3RzLmxpbnV4LQ0KPiBmb3Vu
ZGF0aW9uLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgR3JlZyBLcm9haC1IYXJ0bWFuOyBN
YXJrIFJ1dGxhbmQ7DQo+IFJvYiBIZXJyaW5nOyBSdXNzZWxsIEtpbmc7IEpvY2hlbiBGcmllZHJp
Y2g7IEpvZXJnIFJvZWRlbDsgQ2xhdWRpdSBNYW5vaWw7DQo+IEJodXBlc2ggU2hhcm1hOyBRaWFu
ZyBaaGFvOyBLdW1hciBHYWxhOyBTYW50b3NoIFNoaWxpbWthcjsgTGVvIExpOyBYLkIuDQo+IFhp
ZTsgTS5ILiBMaWFuDQo+IFN1YmplY3Q6IFJFOiBbdjEzLCA1LzhdIHNvYzogZnNsOiBhZGQgR1VU
UyBkcml2ZXIgZm9yIFFvcklRIHBsYXRmb3Jtcw0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogbGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9y
ZyBbbWFpbHRvOmxpbnV4LW1tYy0NCj4gPiBvd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFs
ZiBPZiBTY290dCBXb29kDQo+ID4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDI4LCAyMDE2IDEyOjQ2
IFBNDQo+ID4gVG86IFkuQi4gTHU7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IHVsZi5oYW5z
c29uQGxpbmFyby5vcmc7IEFybmQNCj4gPiBCZXJnbWFubg0KPiA+IENjOiBsaW51eHBwYy1kZXZA
bGlzdHMub3psYWJzLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gbGludXgt
YXJtLSBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gPiBsaW51eC0gY2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgtaTJjQHZnZXIua2Vy
bmVsLm9yZzsNCj4gPiBpb21tdUBsaXN0cy5saW51eC0gZm91bmRhdGlvbi5vcmc7IG5ldGRldkB2
Z2VyLmtlcm5lbC5vcmc7IEdyZWcNCj4gPiBLcm9haC1IYXJ0bWFuOyBNYXJrIFJ1dGxhbmQ7IFJv
YiBIZXJyaW5nOyBSdXNzZWxsIEtpbmc7IEpvY2hlbg0KPiA+IEZyaWVkcmljaDsgSm9lcmcgUm9l
ZGVsOyBDbGF1ZGl1IE1hbm9pbDsgQmh1cGVzaCBTaGFybWE7IFFpYW5nIFpoYW87DQo+IEt1bWFy
IEdhbGE7IFNhbnRvc2ggU2hpbGlta2FyOyBMZW8gTGk7IFguQi4NCj4gPiBYaWU7IE0uSC4gTGlh
bg0KPiA+IFN1YmplY3Q6IFJlOiBbdjEzLCA1LzhdIHNvYzogZnNsOiBhZGQgR1VUUyBkcml2ZXIg
Zm9yIFFvcklRIHBsYXRmb3Jtcw0KPiA+DQo+ID4gT24gRnJpLCAyMDE2LTEwLTI4IGF0IDExOjMy
ICswODAwLCBZYW5nYm8gTHUgd3JvdGU6DQo+ID4gPiArCWd1dHMtPnJlZ3MgPSBvZl9pb21hcChu
cCwgMCk7DQo+ID4gPiArCWlmICghZ3V0cy0+cmVncykNCj4gPiA+ICsJCXJldHVybiAtRU5PTUVN
Ow0KPiA+ID4gKw0KPiA+ID4gKwkvKiBSZWdpc3RlciBzb2MgZGV2aWNlICovDQo+ID4gPiArCW1h
Y2hpbmUgPSBvZl9mbGF0X2R0X2dldF9tYWNoaW5lX25hbWUoKTsNCj4gPiA+ICsJaWYgKG1hY2hp
bmUpDQo+ID4gPiArCQlzb2NfZGV2X2F0dHIubWFjaGluZSA9IGRldm1fa3N0cmR1cChkZXYsIG1h
Y2hpbmUsDQo+ID4gPiBHRlBfS0VSTkVMKTsNCj4gPiA+ICsNCj4gPiA+ICsJc3ZyID0gZnNsX2d1
dHNfZ2V0X3N2cigpOw0KPiA+ID4gKwlzb2NfZGllID0gZnNsX3NvY19kaWVfbWF0Y2goc3ZyLCBm
c2xfc29jX2RpZSk7DQo+ID4gPiArCWlmIChzb2NfZGllKSB7DQo+ID4gPiArCQlzb2NfZGV2X2F0
dHIuZmFtaWx5ID0gZGV2bV9rYXNwcmludGYoZGV2LCBHRlBfS0VSTkVMLA0KPiA+ID4gKwkJCQkJ
CcKgwqDCoMKgwqAiUW9ySVEgJXMiLCBzb2NfZGllLQ0KPiA+ID4gPmRpZSk7DQo+ID4gPiArCX0g
ZWxzZSB7DQo+ID4gPiArCQlzb2NfZGV2X2F0dHIuZmFtaWx5ID0gZGV2bV9rYXNwcmludGYoZGV2
LCBHRlBfS0VSTkVMLA0KPiA+ID4gIlFvcklRIik7DQo+ID4gPiArCX0NCj4gPiA+ICsJc29jX2Rl
dl9hdHRyLnNvY19pZCA9IGRldm1fa2FzcHJpbnRmKGRldiwgR0ZQX0tFUk5FTCwNCj4gPiA+ICsJ
CQkJCcKgwqDCoMKgwqAic3ZyOjB4JTA4eCIsIHN2cik7DQo+ID4gPiArCXNvY19kZXZfYXR0ci5y
ZXZpc2lvbiA9IGRldm1fa2FzcHJpbnRmKGRldiwgR0ZQX0tFUk5FTCwgIiVkLiVkIiwNCj4gPiA+
ICsJCQkJCcKgwqDCoMKgwqDCoMKgU1ZSX01BSihzdnIpLCBTVlJfTUlOKHN2cikpOw0KPiA+ID4g
Kw0KPiA+ID4gKwlzb2NfZGV2ID0gc29jX2RldmljZV9yZWdpc3Rlcigmc29jX2Rldl9hdHRyKTsN
Cj4gPiA+ICsJaWYgKElTX0VSUihzb2NfZGV2KSkNCj4gPiA+ICsJCXJldHVybiBQVFJfRVJSKHNv
Y19kZXYpOw0KPiA+DQo+ID4gaW9yZW1hcCBsZWFrcyBvbiB0aGlzIGVycm9yIHBhdGguIMKgVXNl
IGRldm1faW9yZW1hcF9yZXNvdXJjZSgpLg0KPiA+DQo+IA0KPiBbTHUgWWFuZ2JvLUI0NzA5M10g
T2suIEkgaGF2ZSBmaXhlZCBpdCBpbiB2MTQuIFRoYW5rcyA6KQ0KDQpbTHUgWWFuZ2JvLUI0NzA5
M10gU29ycnksIHVzZWQgdGhlIHdyb25nIGVycm9yIGNvZGUuLi4gV2lsbCByZXNlbnQgaXQNCg0K
PiANCj4gPiAtU2NvdHQNCj4gPg0KPiA+IC0tDQo+ID4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlz
IGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vic2NyaWJlIGxpbnV4LW1tYyINCj4gPiBpbiB0aGUg
Ym9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZyBNb3JlIG1ham9y
ZG9tbw0KPiA+IGluZm8gYXQgaHR0cDovL3ZnZXIua2VybmVsLm9yZy9tYWpvcmRvbW8taW5mby5o
dG1sDQo=
