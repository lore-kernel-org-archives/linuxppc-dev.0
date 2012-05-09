Return-Path: <zhangwm@marvell.com>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
 [74.125.149.71])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6A4D0B6EEB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2012 15:45:48 +1000 (EST)
From: Neil Zhang <zhangwm@marvell.com>
To: Christoph Fritz <chf.fritz@googlemail.com>, Chen Peter-B29397
 <B29397@freescale.com>, Chao Xie <cxie4@marvell.com>
Date: Tue, 8 May 2012 22:45:28 -0700
Subject: RE: [RFC] [PATCH] usb: gadget: fix dtd dma confusion
Message-ID: <175CCF5F49938B4D99B2E3EF7F558EBE1A180E49D9@SC-VEXCH4.marvell.com>
References: <20120409200656.GD2640@local>
 <CAOMZO5BTrA8G6wwQZ3e6bydJX7UtG7jj2c29Ln7u_3_jyUGB+w@mail.gmail.com>
 <20120410001017.GF2640@local>
 <CAOMZO5A=sHeyoQ0PCd=09qGGKb0NjXi-kF5qyG+3U-GhD7rhzg@mail.gmail.com>
 <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <175CCF5F49938B4D99B2E3EF7F558EBE1A180E49BA@SC-VEXCH4.marvell.com>
 <F281D0F91ED19E4D8E63A7504E8A649803B91E69@039-SN2MPN1-022.039d.mgd.msft.net>
 <20120509053826.GA3492@lovely.krouter>
In-Reply-To: <20120509053826.GA3492@lovely.krouter>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Cc: Oliver Neukum <oneukum@suse.de>, Kukjin Kim <kgene.kim@samsung.com>,
 Eric Miao <eric.y.miao@gmail.com>, Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Felipe Balbi <balbi@ti.com>, Ido Shayevitz <idos@codeaurora.org>,
 Estevam Fabio-R49496 <r49496@freescale.com>, "Hans J.
 Koch" <hjk@hansjkoch.de>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Daniel Mack <daniel@caiaq.de>, Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Russell King <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>,
 Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlzdG9waCBG
cml0eiBbbWFpbHRvOmNoZi5mcml0ekBnb29nbGVtYWlsLmNvbV0NCj4gU2VudDogMjAxMsTqNdTC
OcjVIDEzOjM4DQo+IFRvOiBDaGVuIFBldGVyLUIyOTM5NzsgQ2hhbyBYaWUNCj4gQ2M6IE5laWwg
Wmhhbmc7IEZhYmlvIEVzdGV2YW07IExpIFlhbmctUjU4NDcyOyBGZWxpcGUgQmFsYmk7IEdyZWcN
Cj4gS3JvYWgtSGFydG1hbjsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtZGV2
QGxpc3RzLm96bGFicy5vcmc7DQo+IEhhbnMgSi4gS29jaDsgRGFuaWVsIE1hY2s7IFRob21hcyBE
YWhsbWFubjsgTmljb2xhcyBGZXJyZTsgRXJpYyBNaWFvOw0KPiBSdXNzZWxsIEtpbmc7IEhhb2pp
YW4gWmh1YW5nOyBCZW4gRG9va3M7IEt1a2ppbiBLaW07IFNhc2NoYSBIYXVlcjsNCj4gT2xpdmVy
IE5ldWt1bTsgSWRvIFNoYXlldml0ejsgRXN0ZXZhbSBGYWJpby1SNDk0OTYNCj4gU3ViamVjdDog
UmU6IFtSRkNdIFtQQVRDSF0gdXNiOiBnYWRnZXQ6IGZpeCBkdGQgZG1hIGNvbmZ1c2lvbg0KPiAN
Cj4gSGkgUGV0ZXIsDQo+IA0KPiAgdGhhbmtzIHlvdSBmb3IgeW91ciBoZWxwLg0KPiANCj4gT24g
V2VkLCBNYXkgMDksIDIwMTIgYXQgMDI6MTE6NTZBTSArMDAwMCwgQ2hlbiBQZXRlci1CMjkzOTcg
d3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gPg0KPiA+ID4gPiBhZnRlciBhIHdoaWxlIG9mIHRlc3Rp
bmcgYW5kIHNlYXJjaGluZyBJIGNhbiBjb21lIHVwIHdpdGggYSBwYXRjaA0KPiA+ID4gPiB0aGF0
IGZpeGVzIGdfZXRoZXIgPC0+IGlwZXJmIGZvciBmc2xfdWRjIG9uIEFSTSBpLk1YMzUuDQo+ID4g
PiA+DQo+ID4gPiA+IFRoZSBzYWQgcGFydCBpcyB0aGF0IHRoaXMga2luZCBvZiBmaXggaXMgYWxy
ZWFkeSBpbXBsZW1lbnRlZCBmb3INCj4gPiA+ID4gbWFydmVsbCBtdl91ZGMgZHJpdmVyIHNpbmNl
IGxhc3QgeWVhciBidXQgc3RpbGwgX25vdF8gaW4gdGhlIH4xNQ0KPiA+ID4gPiBvdGhlciAqdWRj
LmMgZHJpdmVycy4NCj4gPiA+ID4NCj4gPg0KPiA+IEl0IGlzIGEgY29udHJvbGxlciBsaW1pdGF0
aW9uIChidWc/KSBmb3IgY2hpcGlkZWEgY29udHJvbGxlciB3aGVuDQo+IHVzaW5nDQo+ID4gZHRk
IGxpc3QgdG8gaGFuZGxlIG11bHRpLWR0ZHMgc2l0dWF0aW9uLiBUaGUgY29udHJvbGxlciB3aWxs
IHJlYWQNCj4gZHRkJ3MNCj4gPiBuZXh0IHBvaW50ZXIgYWZ0ZXIgdGhpcyBkdGQncyBhY3RpdmUg
Yml0IGhhcyBhbHJlYWR5IGJlZW4gY2xlYXJlZC4NCj4gPg0KPiA+IEZyZWVzY2FsZSBoYXMgYW4g
ZXJyYXRhIGZvciB0aGlzIHByb2JsZW0ncyBkZXNjcmlwdGlvbiBhbmQgc29sdXRpb24uDQo+ID4g
aHR0cDovL2NhY2hlLmZyZWVzY2FsZS5jb20vZmlsZXMvZHNwL2RvYy9lcnJhdGEvSU1YMjNDRS5w
ZGYNCj4gPiBTZWUgMjg1OA0KPiANCj4gSSdtIGhhY2tpbmcgaGVyZSBhbiBpLk1YMzUgbm90IGFu
IGkuTVgyMy4gU28gSSBhbHJlYWR5IGhhZCBhIGxvb2sgYXQNCj4gaXRzDQo+IGVycmF0YSBzaGVl
dA0KPiBodHRwOi8vY2FjaGUuZnJlZXNjYWxlLmNvbS9maWxlcy9kc3AvZG9jL2VycmF0YS9JTVgz
NUNFLnBkZg0KPiBidXQgZGlkbid0IGZpbmQgYSBzaW1pbGFyICJsaW1pdGF0aW9uIiBhcyB5b3Ug
bm93IHBvaW50ZWQgb3V0IGJ5IGVycmF0YQ0KPiBudW1iZXIgMjg1OCBmb3IgaS5NWDIzLg0KPiAN
Cj4gV2hhdCBhYm91dCB0aGUgZml4IGZvciBtdl91ZGMsIHNob3VsZG4ndCB0aGV5IGhhdmUgYSBz
aW1pbGFyDQo+ICJsaW1pdGF0aW9uIj8gSG93IGRvIHlvdSBleHBsYWluPw0KPiBPciBtYXliZSBz
b21lb25lIGZyb20gTWFydmVsbCBoYXMgYW4gYW5zd2VyPw0KPiANCg0KWWVzLCB3ZSBlbmNvdW50
ZXJlZCB0aGUgc2FtZSBpc3N1ZSwgYW5kIEkgaGF2ZSBhbnN3ZXJlZCB5b3VyIHF1ZXN0aW9uIHNl
dmVyYWwgaG91cnMgYWdvLg0KUGxlYXNlIGhhdmUgYSBsb29rLg0KDQo+IA0KPiBUaGFua3MsDQo+
ICAtLSBDaHJpc3RvcGgNCg0KQmVzdCBSZWdhcmRzLA0KTmVpbCBaaGFuZw0K
