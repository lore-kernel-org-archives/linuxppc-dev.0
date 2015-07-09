Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4CA81A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 16:14:17 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xiaobo
 Xie" <X.Xie@freescale.com>
Subject: RE: [PATCH 2/2] rheap: move rheap.c from arch/powerpc/lib/ to lib/
Date: Thu, 9 Jul 2015 06:14:08 +0000
Message-ID: <SN1PR0301MB1550000498E21C586CA9B52B9B900@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1432717920-43563-1-git-send-email-B45475@freescale.com>
 <1432717920-43563-2-git-send-email-B45475@freescale.com>
 <1432748213.4089.23.camel@freescale.com>
 <SN1PR0301MB15500729CC3A65394FED67389BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1433398423.3415.34.camel@freescale.com>
 <SN1PR0301MB1550B0B2F863A80559FE8B6B9BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1433457659.31070.2.camel@freescale.com>
 <SN1PR0301MB155069ED5F42D54AF2A769F09B910@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1436324117.2658.64.camel@freescale.com>
 <SN1PR0301MB1550F2C30F1393CA26F4FF3B9B910@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1436326077.2658.65.camel@freescale.com>
 <SN1PR0301MB155084FCD058F8EAAC5C5AEA9B910@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1436381938.2658.79.camel@freescale.com>
 <CY1PR0301MB1545D6DA1DDAEEF3B2FC82E79B900@CY1PR0301MB1545.namprd03.prod.outlook.com>
 <1436413840.2658.113.camel@freescale.com>
 <SN1PR0301MB1550CBF05BAD7AB19EC244519B900@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1436422143.2658.121.camel@freescale.com>
In-Reply-To: <1436422143.2658.121.camel@freescale.com>
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

T24gV2VkLCAyMDE1LTA3LTA5IGF0IDAyOjA5UE0gLTA1MDAsIFdvb2QgU2NvdHQgd3JvdGU6DQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0MjEN
Cj4gU2VudDogVGh1cnNkYXksIEp1bHkgMDksIDIwMTUgMjowOSBQTQ0KPiBUbzogWmhhbyBRaWFu
Zy1CNDU0NzUNCj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBYaWUgWGlhb2Jv
LVI2MzA2MQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gcmhlYXA6IG1vdmUgcmhlYXAuYyBm
cm9tIGFyY2gvcG93ZXJwYy9saWIvIHRvDQo+IGxpYi8NCj4gDQo+IE9uIFRodSwgMjAxNS0wNy0w
OSBhdCAwMTowNSAtMDUwMCwgWmhhbyBRaWFuZy1CNDU0NzUgd3JvdGU6DQo+ID4gT24gV2VkLCAy
MDE1LTA3LTA5IGF0IDExOjUxIC0wNTAwLCBXb29kIFNjb3R0IHdyb3RlOg0KPiA+DQo+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogV29vZCBTY290dC1CMDc0MjEN
Cj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDA5LCAyMDE1IDExOjUxIEFNDQo+ID4gPiBUbzog
WmhhbyBRaWFuZy1CNDU0NzUNCj4gPiA+IENjOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9y
ZzsgWGllIFhpYW9iby1SNjMwNjENCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSByaGVh
cDogbW92ZSByaGVhcC5jIGZyb20gYXJjaC9wb3dlcnBjL2xpYi8NCj4gPiA+IHRvIGxpYi8NCj4g
PiA+DQo+ID4gPiBUaGF0IGRvZXNuJ3QgaW52b2x2ZSBhIGRpZmZlcmVudCBhbGlnbm1lbnQgZm9y
IGVhY2ggYWxsb2NhdGlvbi4gIEl0DQo+ID4gPiB1c2VzIHRoZSBzYW1lIGFsaWdubWVudCBmb3Ig
YWxsIG9mIHRoZW0sIGFuZCB0aGUgYWxpZ25tZW50IHRoYXQNCj4gPiA+IGNwbV9jb21tb24uYyBw
cm92aWRlcyB0byByaF9pbml0KCkgaXMgMSBieXRlLg0KPiA+ID4NCj4gPiA+IC4uLmJ1dCBzaWdo
LCBjcG1fbXVyYW1fYWxsb2MoKSBpcyBjaGFuZ2luZyBjcG1fbXVyYW1faW5mby5hbGlnbm1lbnQN
Cj4gPiA+IGJlaGluZCB0aGUgcmhlYXAgY29kZSdzIGJhY2suICBEZXNwaXRlIHRoZSBleGlzdGVu
Y2Ugb2YNCj4gcmhfYWxsb2NfYWxpZ24oKS4NCj4gPiA+DQo+ID4gPiBTbyB5ZXMsIGFkZCBhbGln
bmVkIGFsbG9jYXRpb24gZnVuY3Rpb25hbGl0eSB0byBnZW5hbGxvYywgYnV0IGRvbid0DQo+ID4g
PiBkdXBsaWNhdGUNCj4gPiA+IGdlbl9wb29sX2FsbG9jKCkgdG8gZG8gc28uICBJbnN0ZWFkLCBy
ZW5hbWUgZ2VuX3Bvb2xfYWxsb2MoKSB0bw0KPiA+ID4gZ2VuX3Bvb2xfYWxsb2NfYWxpZ24oKSB3
aXRoIGFuIGFsaWdubWVudCBwYXJhbWV0ZXIgKGFsc28gbW9kaWZ5aW5nDQo+ID4gPiB0aGUgYWxn
byBmdW5jdGlvbiB0byB0YWtlIGFuIGFsaWdubWVudCBhcmcsIHdoaWNoDQo+ID4gPiBnZW5fcG9v
bF9maXJzdF9maXRfb3JkZXJfYWxpZ24oKSB3b3VsZCBpZ25vcmUpLCBhbmQgcHJvdmlkZSBhDQo+
ID4NCj4gPiBIZXJlLCBJIGRvbuKAmXQgdW5kZXJzdGFuZCBob3cgdG8gaGFuZGxlIHRoZSBhbGdv
IEluIHlvdXIgbWluZC4NCj4gPiBDYW4geW91IGV4cGxhaW4gbW9yZSBkZXRhaWxseT8NCj4gDQo+
IFRoZSBhbGdvcml0aG1zIHdvdWxkIGJlIHVuY2hhbmdlZCBleGNlcHQgdGhhdCB0aGV5IHdvdWxk
IHJlY2VpdmUgYSBuZXcNCj4gYWxpZ25tZW50IChvciBhbGlnbm1lbnQgbWFzaykgcGFyYW1ldGVy
LiAgZ2VuX3Bvb2xfZmlyc3RfZml0X29yZGVyX2FsaWduKCkNCj4gd291bGQgaWdub3JlIGl0LCBi
dXQgdGhlIG90aGVyIGFsZ29yaXRobXMgd291bGQgcGFzcyBpdCB0aHJvdWdoIHRvIHRoZQ0KPiBi
aXRtYXAgYWxsb2NhdG9yLg0KDQpIb3cgYWJvdXQgdG8gYWRkIGFuIGFsaWduX21hc2sgcGFyYW1l
dGVyIHRvIGdlbl9wb29sX2ZpcnN0X2ZpdD8gDQoNCj4gDQo+IC1TY290dA0KDQo=
