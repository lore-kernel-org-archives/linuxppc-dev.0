Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0156.outbound.protection.outlook.com [207.46.163.156])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 73AA02C00F7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jan 2014 18:13:02 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: RE: [PATCH 2/2] fsl/pci: The new pci suspend/resume implementation
Date: Wed, 8 Jan 2014 07:12:53 +0000
Message-ID: <5ca123d4b32b49719cd9e8506916a9cf@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389081848-26506-1-git-send-email-dongsheng.wang@freescale.com>
 <1389081848-26506-2-git-send-email-dongsheng.wang@freescale.com>
 <4984978.bktZCpdLkC@vostro.rjw.lan>
In-Reply-To: <4984978.bktZCpdLkC@vostro.rjw.lan>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 Scott Wood <scottwood@freescale.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29j
a2kgW21haWx0bzpyandAcmp3eXNvY2tpLm5ldF0NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5
IDA4LCAyMDE0IDQ6NDIgQU0NCj4gVG86IFdhbmcgRG9uZ3NoZW5nLUI0MDUzNA0KPiBDYzogYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgV29vZCBTY290dC1CMDc0MjE7IGdhbGFrQGNvZGVhdXJvcmEub3Jn
OyBaYW5nIFJveS0NCj4gUjYxOTExOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eHBw
Yy1kZXZAbGlzdHMub3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZnNsL3Bj
aTogVGhlIG5ldyBwY2kgc3VzcGVuZC9yZXN1bWUgaW1wbGVtZW50YXRpb24NCj4gDQo+IE9uIFR1
ZXNkYXksIEphbnVhcnkgMDcsIDIwMTQgMDQ6MDQ6MDggUE0gRG9uZ3NoZW5nIFdhbmcgd3JvdGU6
DQo+ID4gRnJvbTogV2FuZyBEb25nc2hlbmcgPGRvbmdzaGVuZy53YW5nQGZyZWVzY2FsZS5jb20+
DQo+ID4NCj4gPiBUaGUgbmV3IHN1c3BlbmQvcmVzdW1lIGltcGxlbWVudGF0aW9uLCBzZW5kIHBt
ZSB0dXJub2ZmIG1lc3NhZ2UNCj4gPiBpbiBzdXNwZW5kLCBhbmQgc2VuZCBwbWUgZXhpdCBtZXNz
YWdlIGluIHJlc3VtZS4NCj4gPg0KPiA+IEFkZCBhIFBNRSBoYW5kbGVyLCB0byByZXNwb25zZSBQ
TUUgJiBtZXNzYWdlIGludGVycnVwdC4NCj4gPg0KPiA+IENoYW5nZSBwbGF0Zm9ybV9kcml2ZXIt
PnN1c3BlbmQvcmVzdW1lIHRvIHN5c2NvcmUtPnN1c3BlbmQvcmVzdW1lLg0KPiANCj4gQ2FuIHlv
dSBwbGVhc2UgZmlyc3QgZGVzY3JpYmUgdGhlIHByb2JsZW0geW91J3JlIHRyeWluZyB0byBhZGRy
ZXNzPw0KPiANCklmIHdlIGRvIG5vdGhpbmcgaW4gc3VzcGVuZC9yZXN1bWUsIHNvbWUgcGxhdGZv
cm0gUENJZSBpcC1ibG9jayBjYW4ndCBndWFyYW50ZWUNCnRoZSBsaW5rIGJhY2sgdG8gTDAgc3Rh
dGUgZnJvbSBzbGVlcCwgdGhlbiwgd2hlbiB3ZSByZWFkIHRoZSBFUCBkZXZpY2Ugd2lsbCBoYW5n
LiANCk9ubHkgd2Ugc2VuZCBwbWUgdHVybm9mZiBtZXNzYWdlIGluIHBjaSBjb250cm9sbGVyIHN1
c3BlbmQsIGFuZCBzZW5kIHBtZSBleGl0DQptZXNzYWdlIGluIHJlc3VtZSwgdGhlIGxpbmsgc3Rh
dGUgd2lsbCBiZSBub3JtYWwuDQoNCldoZW4gd2Ugc2VuZCBwbWUgdHVybm9mZiBtZXNzYWdlIGlu
IHBjaSBjb250cm9sbGVyIHN1c3BlbmQsIHRoZSBsaW5rcyB3aWxsIGludG8gbDIvbDMNCnJlYWR5
LCB0aGVuLCBob3N0IGNhbm5vdCBjb21tdW5pY2F0ZSB3aXRoIGVwIGRldmljZSwgYnV0IHBjaS1k
cml2ZXIgd2lsbCBjYWxsIGJhY2sgRVANCmRldmljZSB0byBzYXZlIHRoZW0gc3RhdGUuIFNvIHdl
IG5lZWQgdG8gY2hhbmdlIHBsYXRmb3JtX2RyaXZlci0+c3VzcGVuZC9yZXN1bWUgdG8NCnN5c2Nv
cmUtPnN1c3BlbmQvcmVzdW1lLg0KDQpUaGFua3MsDQotRG9uZ3NoZW5nDQo=
