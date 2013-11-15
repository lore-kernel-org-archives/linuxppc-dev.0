Return-Path: <Varun.Sethi@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB7E22C007B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 14:17:09 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Haiying Wang
 <Haiying.Wang@freescale.com>
Subject: RE: [PATCH] iommu/fsl_pamu: use physical cpu index to find the
 matched cpu nodes
Date: Fri, 15 Nov 2013 03:16:53 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A5B0AE8@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1384457440.2144.15.camel@haiying-laptop>
 <1384467025.1403.210.camel@snotra.buserror.net>
In-Reply-To: <1384467025.1403.210.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "joro@8bytes.org" <joro@8bytes.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGFpeWluZy9TY290dCwNCkZvcmdvdCB0byBtZW50aW9uIHRoaXMsIHRoZSBQQU1VIGRyaXZlciBo
YXMgdG8gaGFuZGxlIHN0YXNoIGRlc3RpbmF0aW9uIHNldHRpbmdzIGJvdGggZm9yIHBvd2VyIGFu
ZCBkc3AgY29yZXMgKG9uIEI0IHBsYXRmb3JtKS4gRm9yIHRoZSBkc3AgY29yZXMgd2Ugd291bGQg
ZXhwZWN0IHRoZSBwaHlzaWNhbCBjb3JlIGlkIChub3QgY29udHJvbGxlZCBieSBMaW51eCkuIFRv
IG1ha2UgdGhlIGludGVyZmFjZSBjb25zaXN0ZW50LCBJIHdvdWxkIGV4cGVjdCB0aGUgY2FsbGVy
IChmb3IgaW9tbXVfc2V0X2F0dHIpIHRvIHBhc3MgdGhlIHBoeXNpY2FsIGNvcmUgaWQuDQoNClJl
Z2FyZHMNClZhcnVuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29v
ZCBTY290dC1CMDc0MjENCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxNSwgMjAxMyAzOjQwIEFN
DQo+IFRvOiBXYW5nIEhhaXlpbmctUjU0OTY0DQo+IENjOiBqb3JvQDhieXRlcy5vcmc7IGlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eHBwYy0NCj4gZGV2QGxpc3RzLm96bGFi
cy5vcmc7IFNldGhpIFZhcnVuLUIxNjM5NQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBpb21tdS9m
c2xfcGFtdTogdXNlIHBoeXNpY2FsIGNwdSBpbmRleCB0byBmaW5kIHRoZQ0KPiBtYXRjaGVkIGNw
dSBub2Rlcw0KPiANCj4gT24gVGh1LCAyMDEzLTExLTE0IGF0IDE0OjMwIC0wNTAwLCBIYWl5aW5n
IFdhbmcgd3JvdGU6DQo+ID4gSW4gdGhlIGNhc2Ugd2UgbWlzcyB0byBicmluZyB1cCBzb21lIGNw
dXMsIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHdlIGNhbg0KPiA+IGZpbmQgdGhlIGNvcnJlY3QgY3B1
IG5vZGVzIGluIHRoZSBkZXZpY2UgdHJlZSBiYXNlZCBvbiB0aGUgZ2l2ZW4NCj4gPiBsb2dpY2Fs
IGNwdSBpbmRleCBmcm9tIHRoZSBjYWxsZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWl5
aW5nIFdhbmcgPEhhaXlpbmcuV2FuZ0BmcmVlc2NhbGUuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL2lvbW11L2ZzbF9wYW11LmMgfCAgICAzICsrLQ0KPiA+ICAxIGZpbGVzIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L2ZzbF9wYW11LmMgYi9kcml2ZXJzL2lvbW11L2ZzbF9wYW11LmMgaW5kZXgNCj4g
PiBjYmEwNDk4Li5hOWFiNTdiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvZnNsX3Bh
bXUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvZnNsX3BhbXUuYw0KPiA+IEBAIC01MzksNiAr
NTM5LDcgQEAgdTMyIGdldF9zdGFzaF9pZCh1MzIgc3Rhc2hfZGVzdF9oaW50LCB1MzIgdmNwdSkN
Cj4gDQo+IFNob3VsZCBwcm9iYWJseSBhbHNvIHMvdmNwdS9jcHUvZyBhcyB2Y3B1IG1ha2VzIG5v
IHNlbnNlIG91dHNpZGUgb2YNCj4gdmlydHVhbGl6YXRpb24gY29kZS4NCj4gDQo+ID4gIAl1MzIg
Y2FjaGVfbGV2ZWw7DQo+ID4gIAlpbnQgbGVuLCBmb3VuZCA9IDA7DQo+ID4gIAlpbnQgaTsNCj4g
PiArCXUzMiBjcHVpZCA9IGdldF9oYXJkX3NtcF9wcm9jZXNzb3JfaWQodmNwdSk7DQo+IA0KPiBz
L2NwdWlkL3BoeXNfY3B1LyBvciBzaW1pbGFyDQo+IA0KPiAtU2NvdHQNCj4gDQoNCg==
