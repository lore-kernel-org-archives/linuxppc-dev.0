Return-Path: <yangbo.lu@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0045.outbound.protection.outlook.com [104.47.0.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4tQQ2lgRzDvVM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 17:00:14 +1100 (AEDT)
From: "Y.B. Lu" <yangbo.lu@nxp.com>
To: Scott Wood <oss@buserror.net>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>
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
Date: Fri, 28 Oct 2016 06:00:03 +0000
Message-ID: <DB6PR0401MB2536E2CE7B604554F52AF3AFF8AD0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1477625554-46700-1-git-send-email-yangbo.lu@nxp.com>
 <1477625554-46700-6-git-send-email-yangbo.lu@nxp.com>
 <1477629956.6812.15.camel@buserror.net>
In-Reply-To: <1477629956.6812.15.camel@buserror.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtbW1jLW93bmVy
QHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LW1tYy0NCj4gb3duZXJAdmdlci5rZXJuZWwu
b3JnXSBPbiBCZWhhbGYgT2YgU2NvdHQgV29vZA0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjgs
IDIwMTYgMTI6NDYgUE0NCj4gVG86IFkuQi4gTHU7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7
IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IEFybmQNCj4gQmVyZ21hbm4NCj4gQ2M6IGxpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IGNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWkyY0B2Z2VyLmtl
cm5lbC5vcmc7IGlvbW11QGxpc3RzLmxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgR3JlZyBLcm9haC1IYXJ0bWFuOyBNYXJrIFJ1dGxhbmQ7DQo+IFJvYiBI
ZXJyaW5nOyBSdXNzZWxsIEtpbmc7IEpvY2hlbiBGcmllZHJpY2g7IEpvZXJnIFJvZWRlbDsgQ2xh
dWRpdSBNYW5vaWw7DQo+IEJodXBlc2ggU2hhcm1hOyBRaWFuZyBaaGFvOyBLdW1hciBHYWxhOyBT
YW50b3NoIFNoaWxpbWthcjsgTGVvIExpOyBYLkIuDQo+IFhpZTsgTS5ILiBMaWFuDQo+IFN1Ympl
Y3Q6IFJlOiBbdjEzLCA1LzhdIHNvYzogZnNsOiBhZGQgR1VUUyBkcml2ZXIgZm9yIFFvcklRIHBs
YXRmb3Jtcw0KPiANCj4gT24gRnJpLCAyMDE2LTEwLTI4IGF0IDExOjMyICswODAwLCBZYW5nYm8g
THUgd3JvdGU6DQo+ID4gKwlndXRzLT5yZWdzID0gb2ZfaW9tYXAobnAsIDApOw0KPiA+ICsJaWYg
KCFndXRzLT5yZWdzKQ0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArCS8qIFJl
Z2lzdGVyIHNvYyBkZXZpY2UgKi8NCj4gPiArCW1hY2hpbmUgPSBvZl9mbGF0X2R0X2dldF9tYWNo
aW5lX25hbWUoKTsNCj4gPiArCWlmIChtYWNoaW5lKQ0KPiA+ICsJCXNvY19kZXZfYXR0ci5tYWNo
aW5lID0gZGV2bV9rc3RyZHVwKGRldiwgbWFjaGluZSwNCj4gPiBHRlBfS0VSTkVMKTsNCj4gPiAr
DQo+ID4gKwlzdnIgPSBmc2xfZ3V0c19nZXRfc3ZyKCk7DQo+ID4gKwlzb2NfZGllID0gZnNsX3Nv
Y19kaWVfbWF0Y2goc3ZyLCBmc2xfc29jX2RpZSk7DQo+ID4gKwlpZiAoc29jX2RpZSkgew0KPiA+
ICsJCXNvY19kZXZfYXR0ci5mYW1pbHkgPSBkZXZtX2thc3ByaW50ZihkZXYsIEdGUF9LRVJORUws
DQo+ID4gKwkJCQkJCcKgwqDCoMKgwqAiUW9ySVEgJXMiLCBzb2NfZGllLQ0KPiA+ID5kaWUpOw0K
PiA+ICsJfSBlbHNlIHsNCj4gPiArCQlzb2NfZGV2X2F0dHIuZmFtaWx5ID0gZGV2bV9rYXNwcmlu
dGYoZGV2LCBHRlBfS0VSTkVMLA0KPiA+ICJRb3JJUSIpOw0KPiA+ICsJfQ0KPiA+ICsJc29jX2Rl
dl9hdHRyLnNvY19pZCA9IGRldm1fa2FzcHJpbnRmKGRldiwgR0ZQX0tFUk5FTCwNCj4gPiArCQkJ
CQnCoMKgwqDCoMKgInN2cjoweCUwOHgiLCBzdnIpOw0KPiA+ICsJc29jX2Rldl9hdHRyLnJldmlz
aW9uID0gZGV2bV9rYXNwcmludGYoZGV2LCBHRlBfS0VSTkVMLCAiJWQuJWQiLA0KPiA+ICsJCQkJ
CcKgwqDCoMKgwqDCoMKgU1ZSX01BSihzdnIpLCBTVlJfTUlOKHN2cikpOw0KPiA+ICsNCj4gPiAr
CXNvY19kZXYgPSBzb2NfZGV2aWNlX3JlZ2lzdGVyKCZzb2NfZGV2X2F0dHIpOw0KPiA+ICsJaWYg
KElTX0VSUihzb2NfZGV2KSkNCj4gPiArCQlyZXR1cm4gUFRSX0VSUihzb2NfZGV2KTsNCj4gDQo+
IGlvcmVtYXAgbGVha3Mgb24gdGhpcyBlcnJvciBwYXRoLiDCoFVzZSBkZXZtX2lvcmVtYXBfcmVz
b3VyY2UoKS4NCj4gDQoNCltMdSBZYW5nYm8tQjQ3MDkzXSBPay4gSSBoYXZlIGZpeGVkIGl0IGlu
IHYxNC4gVGhhbmtzIDopDQoNCj4gLVNjb3R0DQo+IA0KPiAtLQ0KPiBUbyB1bnN1YnNjcmliZSBm
cm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJzY3JpYmUgbGludXgtbW1jIiBpbg0K
PiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21vQHZnZXIua2VybmVsLm9yZyBNb3Jl
IG1ham9yZG9tbyBpbmZvIGF0DQo+IGh0dHA6Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWlu
Zm8uaHRtbA0K
