Return-Path: <yangbo.lu@nxp.com>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80057.outbound.protection.outlook.com [40.107.8.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4128wp4v8ZzF34M
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 14:45:27 +1000 (AEST)
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Richard Cochran <richardcochran@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Madalin-cristian Bucur
 <madalin.bucur@nxp.com>, Rob Herring <robh+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [v3, 00/10] Support DPAA PTP clock and timestamping
Date: Fri, 8 Jun 2018 04:45:20 +0000
Message-ID: <DB6PR0401MB25365FAE0E0C7387CB085B96F87B0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
 <20180608042706.7gfg5p6574ntc2lq@localhost>
In-Reply-To: <20180608042706.7gfg5p6574ntc2lq@localhost>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIENvY2hyYW4gW21h
aWx0bzpyaWNoYXJkY29jaHJhbkBnbWFpbC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgSnVuZSA4LCAy
MDE4IDEyOjI3IFBNDQo+IFRvOiBZLmIuIEx1IDx5YW5nYm8ubHVAbnhwLmNvbT4NCj4gQ2M6IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IE1hZGFsaW4tY3Jpc3RpYW4gQnVjdXINCj4gPG1hZGFsaW4u
YnVjdXJAbnhwLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBTaGF3biBH
dW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZl
bWxvZnQubmV0PjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBs
aXN0cy5vemxhYnMub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFt2MywgMDAvMTBd
IFN1cHBvcnQgRFBBQSBQVFAgY2xvY2sgYW5kIHRpbWVzdGFtcGluZw0KPiANCj4gT24gVGh1LCBK
dW4gMDcsIDIwMTggYXQgMDU6MjA6NDBQTSArMDgwMCwgWWFuZ2JvIEx1IHdyb3RlOg0KPiA+IFRo
aXMgcGF0Y2hzZXQgaXMgdG8gc3VwcG9ydCBEUEFBIEZNQU4gUFRQIGNsb2NrIGFuZCBIVyB0aW1l
c3RhbXBpbmcuDQo+ID4gSXQgaGFkIGJlZW4gdmVyaWZpZWQgb24gYm90aCBBUk0gcGxhdGZvcm0g
YW5kIFBQQyBwbGF0Zm9ybS4NCj4gPiAtIFRoZSBwYXRjaCAjMSB0byBwYXRjaCAjNSBhcmUgdG8g
c3VwcG9ydCBEUEFBIEZNQU4gMTU4OCB0aW1lciBpbg0KPiA+ICAgcHRwX3FvcmlxIGRyaXZlci4N
Cj4gPiAtIFRoZSBwYXRjaCAjNiB0byBwYXRjaCAjMTAgYXJlIHRvIGFkZCBIVyB0aW1lc3RhbXBp
bmcgc3VwcG9ydCBpbg0KPiA+ICAgRFBBQSBldGhlcm5ldCBkcml2ZXIuDQo+IA0KPiBSaWdodCBu
b3csIG5ldC1uZXh0IGlzIGNsb3NlZCBmb3IgbmV3IHN0dWZmLiAgWW91IHdpbGwgaGF2ZSB0byBw
b3N0IHRoZSBzZXJpZXMNCj4gYWdhaW4gYWZ0ZXIgdGhlIG1lcmdlIHdpbmRvdyBjbG9zZXMuICBZ
b3UgY2FuIGNoZWNrIHRoZSBzdGF0dXMgaGVyZToNCj4gDQo+IA0KPiBodHRwczovL2VtZWEwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHA6JTJGJTJGdmdlci5rZXJu
DQo+IGVsLm9yZyUyRn5kYXZlbSUyRm5ldC1uZXh0Lmh0bWwmZGF0YT0wMiU3QzAxJTdDeWFuZ2Jv
Lmx1JTQwbnhwLmNvDQo+IG0lN0NiYWFiMGIyMmU3NDQ0Mzg2YzM3MDA4ZDVjY2Y4MWIzNyU3QzY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5DQo+IGM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2NjQwMjg4MzQ3
NTYzNzQyJnNkYXRhPWpDbU5sd29lV0E1MFBWNA0KPiB3M2xLWiUyRnM0YWtQancwVlYyT3JKM3Q0
Rml6SjAlM0QmcmVzZXJ2ZWQ9MA0KPiANCj4gV2hlbiB5b3UgZG8gcmUtcG9zdCwgeW91IGNhbiBh
ZGQgbXk6DQo+IA0KPiBBY2tlZC1ieTogUmljaGFyZCBDb2NocmFuIDxyaWNoYXJkY29jaHJhbkBn
bWFpbC5jb20+DQoNCltZLmIuIEx1XSBHZXQgaXQuIEFuZCB0aGFua3MgYSBsb3Qg8J+Yig0K
