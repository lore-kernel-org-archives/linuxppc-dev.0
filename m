Return-Path: <V.Sethi@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0063.outbound.protection.outlook.com [157.55.234.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVYmD0TmxzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 02:44:58 +1100 (AEDT)
From: Varun Sethi <V.Sethi@nxp.com>
To: Madalin-Cristian Bucur <madalin.bucur@nxp.com>, "joro@8bytes.org"
 <joro@8bytes.org>, Andy Fleming <afleming@gmail.com>
CC: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [v2] powerpc: Fix incorrect PPC32 PAMU dependency
Date: Wed, 23 Mar 2016 12:12:31 +0000
Message-ID: <VI1PR04MB11355CF1883CDDB39EACF4B3E8810@VI1PR04MB1135.eurprd04.prod.outlook.com>
References: <AM4PR04MB16047A161F9CFDF7C65FCCC1EC810@AM4PR04MB1604.eurprd04.prod.outlook.com>
In-Reply-To: <AM4PR04MB16047A161F9CFDF7C65FCCC1EC810@AM4PR04MB1604.eurprd04.prod.outlook.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXhwcGMtZGV2IFtt
YWlsdG86bGludXhwcGMtZGV2LQ0KPiBib3VuY2VzK3ZhcnVuLnNldGhpPWZyZWVzY2FsZS5jb21A
bGlzdHMub3psYWJzLm9yZ10gT24gQmVoYWxmIE9mIE1hZGFsaW4tDQo+IENyaXN0aWFuIEJ1Y3Vy
DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjMsIDIwMTYgMzoyOSBQTQ0KPiBUbzogam9yb0A4
Ynl0ZXMub3JnOyBBbmR5IEZsZW1pbmcgPGFmbGVtaW5nQGdtYWlsLmNvbT4NCj4gQ2M6IGlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW3YyXSBwb3dlcnBjOiBGaXggaW5jb3JyZWN0IFBQQzMyIFBBTVUg
ZGVwZW5kZW5jeQ0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206
IEFuZHkgRmxlbWluZyA8YWZsZW1pbmdAZ21haWwuY29tPg0KPiA+IFRvOiBqb3JvQDhieXRlcy5v
cmcNCj4gPiBDYzogaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcsIGxpbnV4cHBjLWRl
dkBsaXN0cy5vemxhYnMub3JnDQo+ID4gU3ViamVjdDogW3YyXSBwb3dlcnBjOiBGaXggaW5jb3Jy
ZWN0IFBQQzMyIFBBTVUgZGVwZW5kZW5jeQ0KPiA+DQo+ID4gVGhlIEZyZWVzY2FsZSBQQU1VIGNh
biBiZSBlbmFibGVkIG9uIGJvdGggMzIgYW5kIDY0LWJpdCBQb3dlciBjaGlwcy4NCj4gPiBDb21t
aXQgNDc3YWI3YTE5Y2VjODQwOWU0ZTJkZDEwZTczNDhlNGNhYzNjMDZlNQ0KPiA+IChpb21tdTog
TWFrZSBtb3JlIGRyaXZlcnMgZGVwZW5kIG9uIENPTVBJTEVfVEVTVCkgcmVzdHJpY3RlZCBQQU1V
IHRvDQo+ID4gUFBDMzIuIFBQQyBjb3ZlcnMgYm90aC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFuZHkgRmxlbWluZyA8YWZsZW1pbmdAZ21haWwuY29tPg0KPiANCj4gVGVzdGVkLWJ5OiBNYWRh
bGluIEJ1Y3VyIDxtYWRhbGluLmJ1Y3VyQGZyZWVzY2FsZS5jb20+DQo+IA0KQWNrZC1ieTogVmFy
dW4gU2V0aGkgPFZhcnVuLlNldGhpQGZyZWVzY2FsZS5jb20+DQo=
