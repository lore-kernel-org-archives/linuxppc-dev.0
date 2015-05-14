Return-Path: <Varun.Sethi@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0107.outbound.protection.outlook.com [157.56.111.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C4DC1A03A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 04:17:32 +1000 (AEST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] iommu/fsl: Fix the dependency check for PAMU driver.
Date: Thu, 14 May 2015 18:17:23 +0000
Message-ID: <BN1PR0301MB06270D8B13522C351C24A63DEAD80@BN1PR0301MB0627.namprd03.prod.outlook.com>
References: <1431625272-17869-1-git-send-email-Varun.Sethi@freescale.com>
 <1431627194.3868.182.camel@freescale.com>
In-Reply-To: <1431627194.3868.182.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "joro@8bytes.org" <joro@8bytes.org>, "jroedel@suse.de" <jroedel@suse.de>,
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

SGkgU2NvdHQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBT
Y290dC1CMDc0MjENCj4gU2VudDogVGh1cnNkYXksIE1heSAxNCwgMjAxNSAxMTo0MyBQTQ0KPiBU
bzogU2V0aGkgVmFydW4tQjE2Mzk1DQo+IENjOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9y
ZzsganJvZWRlbEBzdXNlLmRlOyBqb3JvQDhieXRlcy5vcmc7DQo+IGlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGlvbW11L2ZzbDogRml4IHRo
ZSBkZXBlbmRlbmN5IGNoZWNrIGZvciBQQU1VIGRyaXZlci4NCj4gDQo+IE9uIFRodSwgMjAxNS0w
NS0xNCBhdCAyMzoxMSArMDUzMCwgVmFydW4gU2V0aGkgd3JvdGU6DQo+ID4gRml4IHRoZSBidWls
ZCBkZXBlbmRlbmN5IGZvciB0aGUgUEFNVSBkcml2ZXIuIFBQQzMyIGJ1aWxkIGRlcGVuZGVjeSBp
cw0KPiBpbmNvcnJlY3QuDQo+ID4gQWRkIHRoZSBDT1JFTkVUX0dFTkVSSUMgYnVpbGQgZGVwZW5k
ZW5jeSBmb3IgUEFNVSBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWYXJ1biBTZXRo
aSA8VmFydW4uU2V0aGlAZnJlZXNjYWxlLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pb21t
dS9LY29uZmlnIHwgICAgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L0tjb25m
aWcgYi9kcml2ZXJzL2lvbW11L0tjb25maWcgaW5kZXgNCj4gPiAxYWU0ZTU0Li40YWNlOGRiIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMv
aW9tbXUvS2NvbmZpZw0KPiA+IEBAIC01MCw3ICs1MCw3IEBAIGNvbmZpZyBPRl9JT01NVQ0KPiA+
DQo+ID4gIGNvbmZpZyBGU0xfUEFNVQ0KPiA+ICAJYm9vbCAiRnJlZXNjYWxlIElPTU1VIHN1cHBv
cnQiDQo+ID4gLQlkZXBlbmRzIG9uIFBQQzMyDQo+ID4gKwlkZXBlbmRzIG9uIENPUkVORVRfR0VO
RVJJQw0KPiA+ICAJZGVwZW5kcyBvbiBQUENfRTUwME1DIHx8IENPTVBJTEVfVEVTVA0KPiA+ICAJ
c2VsZWN0IElPTU1VX0FQSQ0KPiA+ICAJc2VsZWN0IEdFTkVSSUNfQUxMT0NBVE9SDQo+IA0KPiBD
T1JFTkVUX0dFTkVSSUMgaXMgZm9yIGJvYXJkIHN1cHBvcnQuICBUaGVyZSBpcyBubyBndWFyYW50
ZWUgdGhhdCBhbGwNCj4gY29yZW5ldCBib2FyZHMgd2lsbCB1c2UgaXQuICBZb3UgYWxyZWFkeSBk
ZXBlbmQgb24gUFBDX0U1MDBNQzsgd2h5IGRvIHlvdQ0KPiBuZWVkIGFueXRoaW5nIGVsc2UgKGJl
c2lkZXMgcHJvYmFibHkgZ2V0dGluZyByaWQgb2YgInx8IENPTVBJTEVfVEVTVCINCj4gd2hpY2gg
aXMgdXNlbGVzcyBpZiB5b3UgZG8gYWRkIENPUkVORVRfR0VORVJJQywgYmVjYXVzZQ0KPiBDT1JF
TkVUX0dFTkVSSUMgaW1wbGllcyBQUENfRTUwME1DKT8NClllcyB0aGlzIGlzIHJlcXVpcmVkIHRv
IGNvdW50ZXIgInx8Q09NUElMRV9URVNULg0KDQotVmFydW4NCg0K
