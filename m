Return-Path: <yuantian.tang@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0086.outbound.protection.outlook.com [104.47.2.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvZcr3gL8zDqQZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 21:36:44 +1000 (AEST)
From: Yuantian Tang <yuantian.tang@nxp.com>
To: Scott Wood <oss@buserror.net>, Michael Turquette
 <mturquette@baylibre.com>, Russell King <linux@armlinux.org.uk>, Stephen Boyd
 <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Yang-Leo Li
 <leoyang.li@nxp.com>, Xiaofeng Ren <xiaofeng.ren@nxp.com>
Subject: RE: [PATCH v3 2/2] cpufreq: qoriq: Don't look at clock implementation
 details
Date: Wed, 20 Jul 2016 03:02:49 +0000
Message-ID: <DB6PR0401MB2648CA1169D59950CD8BEC78F0080@DB6PR0401MB2648.eurprd04.prod.outlook.com>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <1466058085-19353-2-git-send-email-oss@buserror.net>
 <146785501714.73491.8643317356949121718@resonance>
 <1467864803.32358.63.camel@buserror.net>
 <146794477678.73491.8244253339435407853@resonance>
 <1468012014.32358.74.camel@buserror.net>
In-Reply-To: <1468012014.32358.74.camel@buserror.net>
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

UElORy4NCg0KUmVnYXJkcywNCll1YW50aWFuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogU2NvdHQgV29vZCBbbWFpbHRvOm9zc0BidXNlcnJvci5uZXRdDQo+IFNlbnQ6
IFNhdHVyZGF5LCBKdWx5IDA5LCAyMDE2IDU6MDcgQU0NCj4gVG86IE1pY2hhZWwgVHVycXVldHRl
IDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT47IFJ1c3NlbGwgS2luZw0KPiA8bGludXhAYXJtbGlu
dXgub3JnLnVrPjsgU3RlcGhlbiBCb3lkIDxzYm95ZEBjb2RlYXVyb3JhLm9yZz47IFZpcmVzaA0K
PiBLdW1hciA8dmlyZXNoLmt1bWFyQGxpbmFyby5vcmc+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmp3
QHJqd3lzb2NraS5uZXQ+DQo+IENjOiBsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnOyBsaW51eC1w
bUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLQ0KPiBkZXZAbGlzdHMub3psYWJzLm9yZzsgWXVh
bnRpYW4gVGFuZyA8eXVhbnRpYW4udGFuZ0BueHAuY29tPjsgWWFuZy1MZW8gTGkNCj4gPGxlb3lh
bmcubGlAbnhwLmNvbT47IFhpYW9mZW5nIFJlbiA8eGlhb2ZlbmcucmVuQG54cC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8yXSBjcHVmcmVxOiBxb3JpcTogRG9uJ3QgbG9vayBhdCBj
bG9jaw0KPiBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzDQo+IA0KPiBPbiBUaHUsIDIwMTYtMDctMDcg
YXQgMTk6MjYgLTA3MDAsIE1pY2hhZWwgVHVycXVldHRlIHdyb3RlOg0KPiA+IFF1b3RpbmcgU2Nv
dHQgV29vZCAoMjAxNi0wNy0wNiAyMToxMzoyMykNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIDIwMTYt
MDctMDYgYXQgMTg6MzAgLTA3MDAsIE1pY2hhZWwgVHVycXVldHRlIHdyb3RlOg0KPiA+ID4gPg0K
PiA+ID4gPiBRdW90aW5nIFNjb3R0IFdvb2QgKDIwMTYtMDYtMTUgMjM6MjE6MjUpDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC1zdGF0aWMgc3RydWN0IGRldmljZV9ub2RlICpjcHVf
dG9fY2xrX25vZGUoaW50IGNwdSkNCj4gPiA+ID4gPiArc3RhdGljIHN0cnVjdCBjbGsgKmNwdV90
b19jbGsoaW50IGNwdSkNCj4gPiA+ID4gPiDCoHsNCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCAqY2xrX25wOw0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0
IGNsayAqY2xrOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoGlmICghY3B1
X3ByZXNlbnQoY3B1KSkNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJldHVybiBOVUxMOw0KPiA+ID4gPiA+IEBAIC0xMTIsMzcgKzgwLDI4IEBAIHN0YXRpYyBzdHJ1
Y3QgZGV2aWNlX25vZGUNCj4gPiA+ID4gPiAqY3B1X3RvX2Nsa19ub2RlKGludA0KPiA+ID4gPiA+
IGNwdSkNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFucCkNCj4gPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBOVUxMOw0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gLcKgwqDCoMKgwqDCoMKgY2xrX25wID0gb2ZfcGFyc2VfcGhhbmRsZShucCwgImNsb2Nr
cyIsIDApOw0KPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoGlmICghY2xrX25wKQ0KPiA+ID4gPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gTlVMTDsNCj4gPiA+ID4gPiAt
DQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgY2xrID0gb2ZfY2xrX2dldChucCwgMCk7DQo+ID4g
PiA+IFdoeSBub3QgdXNlIGRldm1fY2xrX2dldCBoZXJlPw0KPiA+ID4gZGV2bV9jbGtfZ2V0KCkg
aXMgYSB3cmFwcGVyIGFyb3VuZCBjbGtfZ2V0KCkgd2hpY2ggaXMgbm90IHRoZSBzYW1lDQo+ID4g
PiBhcyBvZl9jbGtfZ2V0KCkuIMKgV2hhdCBkZXZpY2Ugd291bGQgeW91IHBhc3MgdG8gZGV2bV9j
bGtfZ2V0KCksIGFuZA0KPiA+ID4gd2hhdCBuYW1lIHdvdWxkIHlvdSBwYXNzPw0KPiA+IEknbSBm
dXp6eSBvbiB3aGV0aGVyIG9yIG5vdCB5b3UgZ2V0IGEgc3RydWN0IGRldmljZSBmcm9tIGEgY3B1
ZnJlcQ0KPiA+IGRyaXZlci4gSWYgc28sIHRoZW4gdGhhdCB3b3VsZCBiZSB0aGUgb25lIHRvIHVz
ZS4gSSB3b3VsZCBob3BlIHRoYXQNCj4gPiBjcHVmcmVxIGRyaXZlcnMgbW9kZWwgY3B1cyBhcyBk
ZXZpY2VzLCBidXQgSSdtIHJlYWxseSBub3Qgc3VyZSB3aXRob3V0DQo+ID4gbG9va2luZyBpbnRv
IHRoZSBjb2RlLg0KPiANCj4gSXQncyBub3QgdGhlIGNwdWZyZXEgY29kZSB0aGF0IHByb3ZpZGVz
IGl0LCBidXQgZ2V0X2NwdV9kZXZpY2UoKSBjb3VsZCBiZQ0KPiB1c2VkLg0KPiANCj4gRG8geW91
IGhhdmUgYW55IGNvbW1lbnRzIG9uIHRoZSBmaXJzdCBwYXRjaCBvZiB0aGlzIHNldD8NCj4gDQo+
IC1TY290dA0KDQo=
