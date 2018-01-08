Return-Path: <yangbo.lu@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30085.outbound.protection.outlook.com [40.107.3.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFKtN00p9zF0R0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 14:06:33 +1100 (AEDT)
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Leo Li <leoyang.li@nxp.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Fabio
 Estevam" <fabio.estevam@nxp.com>
Subject: RE: [PATCH] soc/fsl/guts: Add a NULL check for devm_kasprintf()
Date: Mon, 8 Jan 2018 03:06:27 +0000
Message-ID: <DB6PR0401MB2536946B309CD2F95E230CC3F8130@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1515244954-8374-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1515244954-8374-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWls
dG86ZmVzdGV2YW1AZ21haWwuY29tXQ0KPiBTZW50OiAyMDE4xOox1MI2yNUgMjE6MjMNCj4gVG86
IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPg0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96
bGFicy5vcmc7IFkuYi4gTHUgPHlhbmdiby5sdUBueHAuY29tPjsgRmFiaW8NCj4gRXN0ZXZhbSA8
ZmFiaW8uZXN0ZXZhbUBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHNvYy9mc2wvZ3V0czog
QWRkIGEgTlVMTCBjaGVjayBmb3IgZGV2bV9rYXNwcmludGYoKQ0KPiANCj4gRnJvbTogRmFiaW8g
RXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPg0KPiANCj4gZGV2bV9rYXNwcmludGYoKSBt
YXkgZmFpbCwgc28gd2Ugc2hvdWxkIGJldHRlciBhZGQgYSBOVUxMIGNoZWNrIGFuZA0KPiBwcm9w
YWdhdGUgYW4gZXJyb3Igb24gZmFpbHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZhYmlvIEVz
dGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT4NCg0KW1kuYi4gTHVdIEl0IG1ha2VzIHNlbnNl
LiANCkFja2VkLWJ5OiBZYW5nYm8gTHUgPHlhbmdiby5sdUBueHAuY29tPg0KDQo+IC0tLQ0KPiAg
ZHJpdmVycy9zb2MvZnNsL2d1dHMuYyB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvZnNsL2d1dHMuYyBi
L2RyaXZlcnMvc29jL2ZzbC9ndXRzLmMgaW5kZXgNCj4gZDg5YTZhOC4uODIyNTFiNCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9zb2MvZnNsL2d1dHMuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9mc2wv
Z3V0cy5jDQo+IEBAIC0xNjcsMTAgKzE2NywxNiBAQCBzdGF0aWMgaW50IGZzbF9ndXRzX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJfSBlbHNlIHsNCj4gIAkJc29j
X2Rldl9hdHRyLmZhbWlseSA9IGRldm1fa2FzcHJpbnRmKGRldiwgR0ZQX0tFUk5FTCwgIlFvcklR
Iik7DQo+ICAJfQ0KPiArCWlmICghc29jX2Rldl9hdHRyLmZhbWlseSkNCj4gKwkJcmV0dXJuIC1F
Tk9NRU07DQo+ICAJc29jX2Rldl9hdHRyLnNvY19pZCA9IGRldm1fa2FzcHJpbnRmKGRldiwgR0ZQ
X0tFUk5FTCwNCj4gIAkJCQkJICAgICAic3ZyOjB4JTA4eCIsIHN2cik7DQo+ICsJaWYgKCFzb2Nf
ZGV2X2F0dHIuc29jX2lkKQ0KPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gIAlzb2NfZGV2X2F0dHIu
cmV2aXNpb24gPSBkZXZtX2thc3ByaW50ZihkZXYsIEdGUF9LRVJORUwsICIlZC4lZCIsDQo+ICAJ
CQkJCSAgICAgICAoc3ZyID4+ICA0KSAmIDB4Ziwgc3ZyICYgMHhmKTsNCj4gKwlpZiAoIXNvY19k
ZXZfYXR0ci5yZXZpc2lvbikNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+IA0KPiAgCXNvY19kZXYg
PSBzb2NfZGV2aWNlX3JlZ2lzdGVyKCZzb2NfZGV2X2F0dHIpOw0KPiAgCWlmIChJU19FUlIoc29j
X2RldikpDQo+IC0tDQo+IDIuNy40DQoNCg==
