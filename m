Return-Path: <qiang.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0127.outbound.protection.outlook.com [207.46.100.127])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449DB1A1E15
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 12:37:56 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xiaobo Xie
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Leo <LeoLi@freescale.com>, "paulus@samba.org" <paulus@samba.org>
Subject: RE: [PATCH V7 2/3] qe_common: add qe_muram_ functions to manage muram
Date: Wed, 2 Sep 2015 02:22:38 +0000
Message-ID: <SN1PR0301MB1550B83E62EAEB41C4387A0F9B690@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1441011520-15424-1-git-send-email-qiang.zhao@freescale.com>
 <1441011520-15424-2-git-send-email-qiang.zhao@freescale.com>
 <1441154062.4966.113.camel@freescale.com>
In-Reply-To: <1441154062.4966.113.camel@freescale.com>
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

T24gV2VkLCAyMDE1LTA5LTAyIGF0IDg6MzRBTSArMDgwMCwgV29vZCBTY290dC1CMDc0MjEgd3Jv
dGU6DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3
NDIxDQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDAyLCAyMDE1IDg6MzQgQU0NCj4gVG86
IFpoYW8gUWlhbmctQjQ1NDc1DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsNCj4gbGF1cmFhQGNvZGVhdXJvcmEub3JnOyBY
aWUgWGlhb2JvLVI2MzA2MTsgYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBMaQ0KPiBZYW5nLUxl
by1SNTg0NzI7IHBhdWx1c0BzYW1iYS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNyAyLzNd
IHFlX2NvbW1vbjogYWRkIHFlX211cmFtXyBmdW5jdGlvbnMgdG8gbWFuYWdlDQo+IG11cmFtDQo+
IA0KPiBPbiBNb24sIDIwMTUtMDgtMzEgYXQgMTY6NTggKzA4MDAsIFpoYW8gUWlhbmcgd3JvdGU6
DQo+IA0KPiA+IC1pbnQgY3BtX211cmFtX2luaXQodm9pZCkNCj4gPiAtew0KPiA+IC0gICAgIHN0
cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQo+ID4gLSAgICAgc3RydWN0IHJlc291cmNlIHI7DQo+ID4g
LSAgICAgdTMyIHplcm9bT0ZfTUFYX0FERFJfQ0VMTFNdID0ge307DQo+ID4gLSAgICAgcmVzb3Vy
Y2Vfc2l6ZV90IG1heCA9IDA7DQo+ID4gLSAgICAgaW50IGkgPSAwOw0KPiA+IC0gICAgIGludCBy
ZXQgPSAwOw0KPiA+IC0NCj4gPiAtICAgICBpZiAobXVyYW1fcGJhc2UpDQo+ID4gLSAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4gPiAtDQo+ID4gLSAgICAgc3Bpbl9sb2NrX2luaXQoJmNwbV9tdXJh
bV9sb2NrKTsNCj4gPiAtICAgICAvKiBpbml0aWFsaXplIHRoZSBpbmZvIGhlYWRlciAqLw0KPiA+
IC0gICAgIHJoX2luaXQoJmNwbV9tdXJhbV9pbmZvLCAxLA0KPiA+IC0gICAgICAgICAgICAgc2l6
ZW9mKGNwbV9ib290X211cmFtX3JoX2Jsb2NrKSAvDQo+ID4gLSAgICAgICAgICAgICBzaXplb2Yo
Y3BtX2Jvb3RfbXVyYW1fcmhfYmxvY2tbMF0pLA0KPiA+IC0gICAgICAgICAgICAgY3BtX2Jvb3Rf
bXVyYW1fcmhfYmxvY2spOw0KPiA+IC0NCj4gPiAtICAgICBucCA9IG9mX2ZpbmRfY29tcGF0aWJs
ZV9ub2RlKE5VTEwsIE5VTEwsICJmc2wsY3BtLW11cmFtLWRhdGEiKTsNCj4gPiAtICAgICBpZiAo
IW5wKSB7DQo+ID4gLSAgICAgICAgICAgICAvKiB0cnkgbGVnYWN5IGJpbmRpbmdzICovDQo+ID4g
LSAgICAgICAgICAgICBucCA9IG9mX2ZpbmRfbm9kZV9ieV9uYW1lKE5VTEwsICJkYXRhLW9ubHki
KTsNCj4gPiAtICAgICAgICAgICAgIGlmICghbnApIHsNCj4gPiAtICAgICAgICAgICAgICAgICAg
ICAgcHJpbnRrKEtFUk5fRVJSICJDYW5ub3QgZmluZCBDUE0gbXVyYW0gZGF0YQ0KPiBub2RlIik7
DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FTk9ERVY7DQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+IC0gICAgICAgICAgICAgfQ0KPiA+IC0gICAgIH0N
Cj4gPiAtDQo+ID4gLSAgICAgbXVyYW1fcGJhc2UgPSBvZl90cmFuc2xhdGVfYWRkcmVzcyhucCwg
emVybyk7DQo+ID4gLSAgICAgaWYgKG11cmFtX3BiYXNlID09IChwaHlzX2FkZHJfdClPRl9CQURf
QUREUikgew0KPiA+IC0gICAgICAgICAgICAgcHJpbnRrKEtFUk5fRVJSICJDYW5ub3QgdHJhbnNs
YXRlIHplcm8gdGhyb3VnaCBDUE0gbXVyYW0NCj4gbm9kZSIpOw0KPiA+IC0gICAgICAgICAgICAg
cmV0ID0gLUVOT0RFVjsNCj4gPiAtICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+IC0gICAgIH0N
Cj4gDQo+IERpZCB5b3UgcGFzcyAtTSAtQyB0byBnaXQgZm9ybWF0LXBhdGNoPw0KDQoNClllcyEN
Cg0KPiANCj4gLVNjb3R0DQotWmhhbw0K
