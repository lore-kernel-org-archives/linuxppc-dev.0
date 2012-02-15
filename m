Return-Path: <B32616@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe004.messaging.microsoft.com
 [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 30F051007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 18:29:50 +1100 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: RE: [PATCH V2 RESEND] fsl-sata: I/O load balancing
Date: Wed, 15 Feb 2012 07:29:36 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB702B124@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1329284944-17943-1-git-send-email-qiang.liu@freescale.com>
 <CADRPPNQ8LUr13J4k8fsBYSSxXVuxFdEvKyL4abxZpY32Meh=uQ@mail.gmail.com>
In-Reply-To: <CADRPPNQ8LUr13J4k8fsBYSSxXVuxFdEvKyL4abxZpY32Meh=uQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "jgarzik@pobox.com" <jgarzik@pobox.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1pZGUtb3duZXJAdmdl
ci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtaWRlLQ0KPiBvd25lckB2Z2VyLmtlcm5lbC5vcmdd
IE9uIEJlaGFsZiBPZiBMaSBZYW5nDQo+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMTUsIDIw
MTIgMzoyMiBQTQ0KPiBUbzogTGl1IFFpYW5nLUIzMjYxNg0KPiBDYzogamdhcnppa0Bwb2JveC5j
b207IGxpbnV4LWlkZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLQ0KPiBkZXZAbGlzdHMub3ps
YWJzLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIFYyIFJFU0VORF0gZnNsLXNhdGE6IEkvTyBsb2FkIGJhbGFuY2luZw0KPiANCj4gT24gV2Vk
LCBGZWIgMTUsIDIwMTIgYXQgMTo0OSBQTSwgUWlhbmcgTGl1IDxxaWFuZy5saXVAZnJlZXNjYWxl
LmNvbT4NCj4gd3JvdGU6DQo+IA0KPiBIaSBMaXUgUWlhbmcsDQo+IA0KPiBUaGUgcGF0Y2ggaXMg
ZmluZSBleGNlcHQgZm9yIHRoZSB0aXRsZSBhbmQgY29tbWVudC4gIEl0J3MgdG9vIHZhZ3VlIHRv
DQo+IHNheSBJL08gbG9hZCBiYWxhbmNpbmcuICBZb3UgbmVlZCBleHBsaWNpdCBkZXNjcmlwdGlv
biBsaWtlICJhZGQNCj4gaW50ZXJydXB0IGNvYWxlc2Npbmcgc3VwcG9ydCIgYXMgdGl0bGUuDQo+
IA0KPiA+IFJlZHVjZSBpbnRlcnJ1cHQgc2lnbmFscyB0aHJvdWdoIHJlc2V0IEludGVycnVwdCBD
b2FsZXNjaW5nIENvbnRyb2wgUmVnLg0KPiA+IFByb3ZpZGUgZHluYW1pYyBtZXRob2QgdG8gYWRq
dXN0IGludGVycnVwdCBzaWduYWxzIGFuZCB0aW1lciB0aWNrcyBieQ0KPiBzeXNmcy4NCj4gPiBJ
dCBpcyBhIHRyYWRlb2ZmIGZvciBkaWZmZXJlbnQgYXBwbGljYXRpb25zLg0KPiANCj4gSG93IGFi
b3V0Og0KPiANCj4gQWRkcyBzdXBwb3J0IGZvciBpbnRlcnJ1cHQgY29hbGVzY2luZyBmZWF0dXJl
IHRvIHJlZHVjZSBpbnRlcnJ1cHQgZXZlbnRzLg0KPiBQcm92aWRlcyBtZWNoYW5pc20gb2YgYWRq
dXN0aW5nIGNvYWxlc2NpbmcgY291bnQgYW5kIHRpbWVvdXQgdGljayBieQ0KPiBzeXNmcyBvbiBy
dW50aW1lLCBzbyB0aGF0IHRyYWRlb2ZmIG9mIGxhdGVuY3kgYW5kIENQVSBsb2FkIGNhbiBiZSBt
YWRlDQo+IGRlcGVuZGluZyBvbiBhcHBsaWNhdGlvbnMuDQo+IA0KT2ssIEkgd2lsbCBjaGFuZ2Ug
dGhlIHRpdGxlIGFuZCBjb21tZW50cyBtb3JlIHNwZWNpZmljYWxseS4NCg0KPiAtIExlbw0KPiAt
LQ0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAidW5zdWJz
Y3JpYmUgbGludXgtaWRlIiBpbg0KPiB0aGUgYm9keSBvZiBhIG1lc3NhZ2UgdG8gbWFqb3Jkb21v
QHZnZXIua2VybmVsLm9yZyBNb3JlIG1ham9yZG9tbyBpbmZvIGF0DQo+IGh0dHA6Ly92Z2VyLmtl
cm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0KDQo=
