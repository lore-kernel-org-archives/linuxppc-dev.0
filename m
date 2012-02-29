Return-Path: <B32616@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33F40B6FC9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 13:55:19 +1100 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: "jgarzik@pobox.com" <jgarzik@pobox.com>
Subject: RE: [PATCH V3] fsl-sata: add support for interrupt coalsecing feature
Date: Wed, 29 Feb 2012 02:54:58 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB70424A8@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1329291634-883-1-git-send-email-qiang.liu@freescale.com>
 <CADRPPNTmRvPVymJmW4vagU+2M4DmqeDSEj=4=R_=YDJekOTccQ@mail.gmail.com>
In-Reply-To: <CADRPPNTmRvPVymJmW4vagU+2M4DmqeDSEj=4=R_=YDJekOTccQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgSmVmZiwNCg0KRG8geW91IHBsYW4gdG8gYXBwbHkgaXQgdG8gdXBzdHJlYW0sIG9yIGFueSBz
dWdnZXN0aW9ucz8gVGhhbmtzLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IGxpbnV4LWlkZS1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1pZGUtDQo+
IG93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIExpIFlhbmcNCj4gU2VudDogV2Vk
bmVzZGF5LCBGZWJydWFyeSAxNSwgMjAxMiAzOjUxIFBNDQo+IFRvOiBMaXUgUWlhbmctQjMyNjE2
DQo+IENjOiBqZ2FyemlrQHBvYm94LmNvbTsgbGludXgtaWRlQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjNdIGZzbC1zYXRhOiBhZGQgc3VwcG9ydCBmb3Ig
aW50ZXJydXB0IGNvYWxzZWNpbmcNCj4gZmVhdHVyZQ0KPiANCj4gT24gV2VkLCBGZWIgMTUsIDIw
MTIgYXQgMzo0MCBQTSwgUWlhbmcgTGl1IDxxaWFuZy5saXVAZnJlZXNjYWxlLmNvbT4NCj4gd3Jv
dGU6DQo+ID4gQWRkcyBzdXBwb3J0IGZvciBpbnRlcnJ1cHQgY29hbGVzY2luZyBmZWF0dXJlIHRv
IHJlZHVjZSBpbnRlcnJ1cHQNCj4gZXZlbnRzLg0KPiA+IFByb3ZpZGVzIGEgbWVjaGFuaXNtIG9m
IGFkanVzdGluZyBjb2FsZXNjaW5nIGNvdW50IGFuZCB0aW1lb3V0IHRpY2sgYnkNCj4gPiBzeXNm
cyBhdCBydW50aW1lLCBzbyB0aGF0IHRyYWRlb2ZmIG9mIGxhdGVuY3kgYW5kIENQVSBsb2FkIGNh
biBiZSBtYWRlDQo+ID4gZGVwZW5kaW5nIG9uIGRpZmZlcmVudCBhcHBsaWNhdGlvbnMuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBRaWFuZyBMaXUgPHFpYW5nLmxpdUBmcmVlc2NhbGUuY29tPg0K
PiANCj4gQWNrZWQtYnk6IExpIFlhbmcgPGxlb2xpQGZyZWVzY2FsZS5jb20+DQo+IA0KPiAtIExl
bw0KPiAtLQ0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAi
dW5zdWJzY3JpYmUgbGludXgtaWRlIiBpbg0KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFq
b3Jkb21vQHZnZXIua2VybmVsLm9yZyBNb3JlIG1ham9yZG9tbyBpbmZvIGF0DQo+IGh0dHA6Ly92
Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0KDQo=
