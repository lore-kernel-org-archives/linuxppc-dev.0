Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0134.outbound.protection.outlook.com [207.46.100.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 25B3C1A0038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 12:35:58 +1000 (AEST)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Sudeep Holla <sudeep.holla@arm.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Hongtao Jia
 <hongtao.jia@freescale.com>, Marc Zyngier <marc.zyngier@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 04/17] powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead of
 redundant mpic_irq_set_wake
Date: Wed, 23 Sep 2015 02:35:51 +0000
Message-ID: <SN1PR0301MB1616AD6C1C410ACB49A5D9279D440@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-5-git-send-email-sudeep.holla@arm.com>
 <1442965805.19102.303.camel@freescale.com>
In-Reply-To: <1442965805.19102.303.camel@freescale.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjMsIDIwMTUgNzo1MCBBTQ0KPiBUbzog
U3VkZWVwIEhvbGxhDQo+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IFRob21hcyBHbGVpeG5lcjsNCj4gUmFmYWVsIEouIFd5c29ja2k7
IEJlbmphbWluIEhlcnJlbnNjaG1pZHQ7IFBhdWwgTWFja2VycmFzOyBNaWNoYWVsIEVsbGVybWFu
OyBKaWENCj4gSG9uZ3Rhby1CMzg5NTE7IE1hcmMgWnluZ2llcjsgbGludXhwcGMtZGV2QGxpc3Rz
Lm96bGFicy5vcmc7IFdhbmcgRG9uZ3NoZW5nLQ0KPiBCNDA1MzQNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAwNC8xN10gcG93ZXJwYzogbXBpYzogdXNlIElSUUNISVBfU0tJUF9TRVRfV0FLRSBpbnN0
ZWFkIG9mDQo+IHJlZHVuZGFudCBtcGljX2lycV9zZXRfd2FrZQ0KPiANCj4gT24gTW9uLCAyMDE1
LTA5LTIxIGF0IDE2OjQ3ICswMTAwLCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+ID4gbXBpY19pcnFf
c2V0X3dha2UgcmV0dXJuIC1FTlhJTyBmb3Igbm9uIEZTTCBNUElDIGFuZCBzZXRzIElSUUZfTk9f
U1VTUEVORA0KPiA+IGZsYWcgZm9yIEZTTCBvbmVzLiBlbmFibGVfaXJxX3dha2UgYWxyZWFkeSBy
ZXR1cm5zIC1FTlhJTyBpZiBpcnFfc2V0X3dhaw0KPiA+IGlzIG5vdCBpbXBsZW1lbnRlZC4gQWxz
byB0aGVyZSdzIG5vIG5lZWQgdG8gc2V0IHRoZSBJUlFGX05PX1NVU1BFTkQgZmxhZw0KPiA+IGFz
IGl0IGRvZXNuJ3QgZ3VhcmFudGVlIHdha2V1cCBmb3IgdGhhdCBpbnRlcnJ1cHQuDQo+ID4NCg0K
Tm9uLWZyZWVzY2FsZSByZXR1cm4gLUVOWElPLCBpcyB0aGVyZSBhbnkgaXNzdWU/IElmIG5vbi1m
cmVlc2NhbGUgcGxhdGZvcm0gZG9lcw0Kbm90IHN1cHBvcnQgaXQsIGJ1dCBJUHMgc3RpbGwgdXNl
IGVuYWJsZS9kaXNhYmxlX2lycV93YWtlLCB3ZSBzaG91bGQgcmV0dXJuIGEgZXJyb3IgbnVtYmVy
Lg0KDQpJUlFDSElQX1NLSVBfU0VUX1dBS0UganVzdCBza2lwIHRoaXMgZmVhdHVyZSwgdGhpcyBp
cyBub3Qgb3VyIGV4cGVjdGVkLg0KSWYgbm9uLWZyZWVzY2FsZSBwbGF0Zm9ybSBuZWVkIHRoaXMg
ZmxhZyB0byBza2lwIHRoaXMgZmVhdHVyZSwgaXQgc2hvdWxkIGJlIGFkZA0KaW4gc2VsZiBwbGF0
Zm9ybS4NCg0KQFNjb3R0Og0KSWYgc2V0IHRoaXMgZmxhZyB3ZSBjYW5ub3Qga2VlcCBhIGlycSBh
cyBhIHdha2V1cCBzb3VyY2Ugd2hlbiBzeXN0ZW0gZ29pbmcgdG8NClNVU1BFTkQgb3IgTUVNLg0K
DQppcnFfc2V0X3dha2UoKSBtZWFucyB3ZSBjYW4gc2V0IHRoaXMgaXJxIGFzIGEgd2FrZSBzb3Vy
Y2UuDQpJUlFDSElQX1NLSVBfU0VUX1dBS0UgaXMgaWdub3JlIGlycV9zZXRfd2FrZSgpIGZlYXR1
cmUuDQoNClJlZ2FyZHMsDQotRG9uZ3NoZW5nDQoNCg==
