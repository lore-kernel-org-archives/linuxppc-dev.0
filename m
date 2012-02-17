Return-Path: <B32616@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8155F1007D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 14:30:47 +1100 (EST)
From: Liu Qiang-B32616 <B32616@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH V2 RESEND] fsl-sata: I/O load balancing
Date: Fri, 17 Feb 2012 03:30:36 +0000
Message-ID: <BCB48C05FCE8BC4D9E61E841ECBE6DB702C9DB@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1329284944-17943-1-git-send-email-qiang.liu@freescale.com>
 <1329439216.2892.36.camel@pasglop>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB702B97D@039-SN2MPN1-013.039d.mgd.msft.net>
 <1329448660.2892.42.camel@pasglop>
In-Reply-To: <1329448660.2892.42.camel@pasglop>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCZW5qYW1pbiBIZXJyZW5zY2ht
aWR0IFttYWlsdG86YmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnXQ0KPiBTZW50OiBGcmlkYXksIEZl
YnJ1YXJ5IDE3LCAyMDEyIDExOjE4IEFNDQo+IFRvOiBMaXUgUWlhbmctQjMyNjE2DQo+IENjOiBq
Z2FyemlrQHBvYm94LmNvbTsgbGludXgtaWRlQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtDQo+
IGRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJFOiBbUEFUQ0ggVjIgUkVTRU5EXSBmc2wtc2F0YTogSS9PIGxvYWQgYmFsYW5jaW5n
DQo+IA0KPiBPbiBGcmksIDIwMTItMDItMTcgYXQgMDE6NTQgKzAwMDAsIExpdSBRaWFuZy1CMzI2
MTYgd3JvdGU6DQo+ID4gVGhlIGRlZmF1bHQgd2lsbCBiZSBzZXQgaW4gYSBjb21tb24gaW50ZXJm
YWNlDQo+ID4gZnNsX3NhdGFfc2V0X2lycV9jb2FsZXNjaW5nIHdoZW4gaW5pdGlhbGl6ZSB0aGUg
Y29udHJvbGxlci4gVGhpcw0KPiA+IGludGVyZmFjZSB3aWxsIGNoZWNrIHRoZSByYW5nZSBvZiBp
bnRyIGNvdW50IGFuZCB0aWNrcyBhbmQgbWFrZSBzdXJlDQo+IHRoZSB2YWx1ZXMgYXJlIHJlYXNv
bmFibHkuDQo+IA0KPiBBbGxyaWdodCwgYnV0IHRoZSBjdXJyZW50IGRlZmF1bHRzIGFyZSBiYXNp
Y2FsbHkgbm8gY29hbGVzY2luZyByaWdodCA/DQo+IA0KPiA+IEl0J3MgaGFyZCB0byBmaW5kIGEg
YWdncmVzc2l2ZSB2YWx1ZSB0byBhZGFwdCBhbGwgc2NlbmFyaW9zLCBzbyBJIHVzZQ0KPiA+IGVj
aG8gdG8gYWRqdXN0IHRoZSB2YWx1ZS4gSSByZW1lbWJlciBQNTAyMCBoYXZlIHNvbWUgcGVyZm9y
bWFuY2UgaXNzdWUsDQo+IEkgd2lsbCBjaGVjayBpdC4NCj4gPiBCVFcsIHdoaWNoIGZpbGVzeXN0
ZW0gZG8geW91IHVzZT8gRXh0MiBpcyBsb3dlciB0aGFuIGV4dDQgYmVjYXVzZQ0KPiA+IG1ldGFk
YXRhIGlzIGNvbnRpbnVvdXNseSB3cm90ZSB0byBkaXNrLiBZb3UgY2FuIHRyeSBleHQ0IG9yIHhm
cy4NCj4gDQo+IGV4dDMgYXQgdGhlIG1vbWVudCwgSSBwbGFuIHRvIHN3aXRjaCB0byBleHQ0IHdo
ZW4gSSBmaW5pc2ggdGhhdCBmc2NrIHBhc3MNCj4gd2hpY2ggaXMgdGFraW5nIGhvdXJzLi4uIEkg
YW0gbm90IGF3YXJlIG9mIHRoZSA1MDIwIHBlcmZvcm1hbmNlIGlzc3VlcywNCj4gaXMgdGhpcyBz
b21ldGhpbmcgZG9jdW1lbnRlZCBhbmQvb3IgZml4YWJsZSA/DQo+IA0KDQpNeSBwYXRjaCBtYXkg
bm90IG1lZXQgeW91ciByZXF1aXJlbWVudDooDQpGb3IgeW91ciBwZXJmb3JtYW5jZSByZXF1aXJl
bWVudCwgSSBzdWdnZXN0IHVzZSBleHQ0IGZpbGVzeXN0ZW0gYW5kIFNTRC4NCg0KVGhhbmtzLg0K
DQo+IENoZWVycywNCj4gQmVuLg0KPiANCj4gDQoNCg==
