Return-Path: <qiang.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0141.outbound.protection.outlook.com [207.46.100.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DECA1A0138
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 17:52:39 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xiaobo Xie
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Leo <LeoLi@freescale.com>, "paulus@samba.org" <paulus@samba.org>
Subject: RE: [PATCH v6 3/3] qe_common: add qe_muram_ functions to manage muram
Date: Tue, 25 Aug 2015 07:52:26 +0000
Message-ID: <SN1PR0301MB1550A026A5C471382BB293A69B610@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1440408703-6113-1-git-send-email-qiang.zhao@freescale.com>
 <1440408703-6113-3-git-send-email-qiang.zhao@freescale.com>
 <1440434073.30043.21.camel@freescale.com>
In-Reply-To: <1440434073.30043.21.camel@freescale.com>
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

DQpPbiBUdWUsIDIwMTUtMDgtMjUgYXQgMTI6MzUgKzA4MDAsIFdvb2QgU2NvdHQtQjA3NDIxIHdy
b3RlOg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIw
NzQyMQ0KPiBTZW50OiBUdWVzZGF5LCBBdWd1c3QgMjUsIDIwMTUgMTI6MzUgQU0NCj4gVG86IFpo
YW8gUWlhbmctQjQ1NDc1DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsNCj4gbGF1cmFhQGNvZGVhdXJvcmEub3JnOyBYaWUg
WGlhb2JvLVI2MzA2MTsgYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBMaQ0KPiBZYW5nLUxlby1S
NTg0NzI7IHBhdWx1c0BzYW1iYS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAzLzNdIHFl
X2NvbW1vbjogYWRkIHFlX211cmFtXyBmdW5jdGlvbnMgdG8gbWFuYWdlDQo+IG11cmFtDQo+IA0K
PiBPbiBNb24sIDIwMTUtMDgtMjQgYXQgMTc6MzEgKzA4MDAsIFpoYW8gUWlhbmcgd3JvdGU6DQo+
IA0KPiA+IEBAIC0xODcsMTIgKzE5MCw0MSBAQCBzdGF0aWMgaW5saW5lIGludCBxZV9hbGl2ZV9k
dXJpbmdfc2xlZXAodm9pZCkNCj4gPiAgfQ0KPiA+DQo+ID4gIC8qIHdlIGFjdHVhbGx5IHVzZSBj
cG1fbXVyYW0gaW1wbGVtZW50YXRpb24sIGRlZmluZSB0aGlzIGZvcg0KPiBjb252ZW5pZW5jZSAq
Lw0KPiA+IC0jZGVmaW5lIHFlX211cmFtX2luaXQgY3BtX211cmFtX2luaXQNCj4gPiAtI2RlZmlu
ZSBxZV9tdXJhbV9hbGxvYyBjcG1fbXVyYW1fYWxsb2MNCj4gPiAtI2RlZmluZSBxZV9tdXJhbV9h
bGxvY19maXhlZCBjcG1fbXVyYW1fYWxsb2NfZml4ZWQNCj4gPiAtI2RlZmluZSBxZV9tdXJhbV9m
cmVlIGNwbV9tdXJhbV9mcmVlDQo+ID4gLSNkZWZpbmUgcWVfbXVyYW1fYWRkciBjcG1fbXVyYW1f
YWRkcg0KPiA+IC0jZGVmaW5lIHFlX211cmFtX29mZnNldCBjcG1fbXVyYW1fb2Zmc2V0DQo+ID4g
K2ludCBxZV9tdXJhbV9pbml0KHZvaWQpOw0KPiA+ICsNCj4gPiArI2lmIGRlZmluZWQoQ09ORklH
X1FVSUNDX0VOR0lORSkNCj4gPiArdW5zaWduZWQgbG9uZyBxZV9tdXJhbV9hbGxvYyh1bnNpZ25l
ZCBsb25nIHNpemUsIHVuc2lnbmVkIGxvbmcgYWxpZ24pOw0KPiA+ICtpbnQgcWVfbXVyYW1fZnJl
ZSh1bnNpZ25lZCBsb25nIG9mZnNldCk7DQo+ID4gK3ZvaWQgX19pb21lbSAqcWVfbXVyYW1fYWRk
cih1bnNpZ25lZCBsb25nIG9mZnNldCk7DQo+ID4gK3Vuc2lnbmVkIGxvbmcgcWVfbXVyYW1fb2Zm
c2V0KHZvaWQgX19pb21lbSAqYWRkcik7DQo+ID4gK2RtYV9hZGRyX3QgcWVfbXVyYW1fZG1hKHZv
aWQgX19pb21lbSAqYWRkcik7DQo+ID4gKyNlbHNlDQo+ID4gK3N0YXRpYyBpbmxpbmUgdW5zaWdu
ZWQgbG9uZyBxZV9tdXJhbV9hbGxvYyh1bnNpZ25lZCBsb25nIHNpemUsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBhbGlnbikNCj4g
PiArew0KPiA+ICsgICAgIHJldHVybiAtRU5PU1lTOw0KPiA+ICt9DQo+IA0KPiBXaGF0IGNvZGUg
Y2FsbHMgdGhlc2UgZnVuY3Rpb25zIHdpdGhvdXQgQ09ORklHX1FVSUNDX0VOR0lORT8NCj4gDQo+
IEFyZSB5b3UgY29udmVydGluZyBxZSB3aXRob3V0IGNwbT8gIFdoeT8NCg0KQ1BNIGp1c3Qgd29y
ayBvbiBQb3dlclBDIG9sZCBib2FyZHMsIGl0IGlzIG5vdCBuZWNlc3NhcnkgdG8gY29udmVydCBp
dC4gICANCg0KPiANCj4gLVNjb3R0DQoNCg0KLVpoYW8NCg==
