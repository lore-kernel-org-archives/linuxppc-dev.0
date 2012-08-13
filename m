Return-Path: <r58472@freescale.com>
From: Li Yang-R58472 <r58472@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH v2 2/2] powerpc/mpic: add global timer support
Date: Mon, 13 Aug 2012 06:17:36 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F093AEC18@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
 <5025639F.4070203@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259DB147E@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <ABB05CD9C9F68C46A5CEDC7F15439259DB147E@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2FuZyBEb25nc2hlbmct
QjQwNTM0DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDEzLCAyMDEyIDE6NTQgUE0NCj4gVG86IFdv
b2QgU2NvdHQtQjA3NDIxDQo+IENjOiBiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc7IHBhdWx1c0Bz
YW1iYS5vcmc7IGxpbnV4cHBjLQ0KPiBkZXZAbGlzdHMub3psYWJzLm9yZzsgR2FsYSBLdW1hci1C
MTE3ODA7IExpIFlhbmctUjU4NDcyDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjIgMi8yXSBwb3dl
cnBjL21waWM6IGFkZCBnbG9iYWwgdGltZXIgc3VwcG9ydA0KPiANCj4gDQo+IA0KPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogV29vZCBTY290dC1CMDc0MjENCj4gPiBT
ZW50OiBTYXR1cmRheSwgQXVndXN0IDExLCAyMDEyIDM6NDAgQU0NCj4gPiBUbzogV2FuZyBEb25n
c2hlbmctQjQwNTM0DQo+ID4gQ2M6IGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZzsgcGF1bHVzQHNh
bWJhLm9yZzsgbGludXhwcGMtDQo+ID4gZGV2QGxpc3RzLm96bGFicy5vcmc7IEdhbGEgS3VtYXIt
QjExNzgwOyBMaSBZYW5nLVI1ODQ3Mg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8yXSBw
b3dlcnBjL21waWM6IGFkZCBnbG9iYWwgdGltZXIgc3VwcG9ydA0KPiA+DQo+ID4gT24gMDgvMTAv
MjAxMiAxMjo1NCBBTSwgRG9uZ3NoZW5nLndhbmdAZnJlZXNjYWxlLmNvbSB3cm90ZToNCj4gPiA+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtcGljX3RpbWVyX2lkc1tdID0gew0K
PiA+ID4gKwl7IC5jb21wYXRpYmxlID0gIm9wZW4tcGljLGdsb2JhbC10aW1lciIsIH0sDQo+ID4g
PiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGdsb2JhbC10aW1lciIsIH0sDQo+ID4gPiArCXt9LA0K
PiA+ID4gK307DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIGludCBfX2luaXQgbXBpY190aW1lcl9p
bml0KHZvaWQpIHsNCj4gPiA+ICsJc3RydWN0IGRldmljZV9ub2RlICpucCA9IE5VTEw7DQo+ID4g
PiArDQo+ID4gPiArCWZvcl9lYWNoX25vZGVfYnlfdHlwZShucCwgIm9wZW4tcGljIikNCj4gPiA+
ICsJCWlmIChvZl9tYXRjaF9ub2RlKG1waWNfdGltZXJfaWRzLCBucCkpDQo+ID4gPiArCQkJZ3Jv
dXBfaW5pdChucCk7DQo+ID4gPiArDQo+ID4gPiArCWlmIChsaXN0X2VtcHR5KCZncm91cF9saXN0
KSkNCj4gPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4gMDsN
Cj4gPiA+ICt9DQo+ID4gPiArYXJjaF9pbml0Y2FsbChtcGljX3RpbWVyX2luaXQpOw0KPiA+DQo+
ID4gT2gsIGFuZCBkb24ndCBwcm9iZSBieSBkZXZpY2VfdHlwZS4NCg0KQWN0dWFsbHkgaXQgZG9l
cyBtYXRjaCB0aGUgY29tcGF0aWJsZS4gIFRoZSBkZXZpY2VfdHlwZSBpcyBqdXN0IHRvIHNwZWVk
IHVwIHRoZSBzZWFyY2guICBJIGRvbid0IHRoaW5rIGl0J3MgYSBwcm9ibGVtIHVubGVzcyB0aGUg
ZGV2aWNlIHR5cGUgaXMgbm90IG1hbmRhdG9yeSBhbnkgbW9yZSBmb3IgZGVmaW5lZCB0eXBlcy4N
Cg0KLSBMZW8NCg==
