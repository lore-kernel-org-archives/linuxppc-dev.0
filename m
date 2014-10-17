Return-Path: <xuelin.shi@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0109.outbound.protection.outlook.com [157.56.110.109])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 380421A02B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 13:47:27 +1100 (AEDT)
From: Xuelin Shi <xuelin.shi@freescale.com>
To: Dan Williams <dan.j.williams@intel.com>, "Koul, Vinod"
 <vinod.koul@intel.com>
Subject: RE: [PATCH v3] dmaengine: driver support for FSL RaidEngine device.
Date: Fri, 17 Oct 2014 02:13:20 +0000
Message-ID: <4cd56c90d1e44249bd2d417005183ec7@BL2PR03MB147.namprd03.prod.outlook.com>
References: <1397202086-22489-1-git-send-email-xuelin.shi@freescale.com>
 <CAA9_cme=Bo3tYi0-bNXBRNLZnC-4FZyaSYZ=3iRD_5xfiVX5Mw@mail.gmail.com>
 <0c8d1963a25648f8a8f820bbc55afe4f@BL2PR03MB147.namprd03.prod.outlook.com>
 <CAPcyv4go1ghjD7fiEzwPJmcjRMBv7p0t7Sm9Ki=1Hu-0GKqoCQ@mail.gmail.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Harninder Rai <harninder.rai@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
 Naveen Burmi <NaveenBurmi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgRGFuICYgVmlub2QsDQoNCkkgaGF2ZSBzZW50IG91dCB0aGUgdjQgb2YgdGhpcyBwYXRjaCBh
bmQgbm90IHJlY2VpdmVkIGFueSBmdXJ0aGVyIGZlZWRiYWNrIHlldC4NCg0KVGhpcyBwYXRjaCBs
b29rcyBydWxlZCBvdXQgZnJvbSB0aGUgcGF0Y2h3b3JrLiBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtZG1hZW5naW5lL2xpc3QvP3BhZ2U9Mg0KDQpTbyBkbyB5b3Ug
a25vdyB3aGF0IGhhcHBlbmVkIHRvIHRoaXMgcGF0Y2g/DQoNClRoYW5rcywNClh1ZWxpbiBTaGkN
Cg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2hpIFh1ZWxpbi1CMjkyMzcg
DQpTZW50OiAyMDE0xOo01MIxNcjVIDExOjA4DQpUbzogJ0RhbiBXaWxsaWFtcycNCkNjOiBLb3Vs
LCBWaW5vZDsgYW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tOyBkbWFlbmdpbmVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eHBwYy1kZXY7IFJhaSBIYXJuaW5kZXItQjAxMDQ0OyBCdXJtaSBOYXZlZW4t
QjE2NTAyDQpTdWJqZWN0OiBSRTogW1BBVENIIHYzXSBkbWFlbmdpbmU6IGRyaXZlciBzdXBwb3J0
IGZvciBGU0wgUmFpZEVuZ2luZSBkZXZpY2UuDQoNClllcywgImRlcGVuZCBvbiAhQVNZTkNfVFhf
Q0hBTk5FTF9TV0lUQ0giIGlzIGJldHRlciBzaW5jZSBmc2xkbWEgc2VsZWN0cyB0aGlzIGNvbmRp
dGlvbi4NCg0KVGhhbmtzLA0KWHVlbGluIFNoaQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogRGFuIFdpbGxpYW1zIFttYWlsdG86ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tXQ0K
U2VudDogMjAxNMTqNNTCMTXI1SA4OjMwDQpUbzogU2hpIFh1ZWxpbi1CMjkyMzcNCkNjOiBLb3Vs
LCBWaW5vZDsgYW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tOyBkbWFlbmdpbmVAdmdlci5rZXJu
ZWwub3JnOyBsaW51eHBwYy1kZXY7IFJhaSBIYXJuaW5kZXItQjAxMDQ0OyBCdXJtaSBOYXZlZW4t
QjE2NTAyDQpTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBkbWFlbmdpbmU6IGRyaXZlciBzdXBwb3J0
IGZvciBGU0wgUmFpZEVuZ2luZSBkZXZpY2UuDQoNCk9uIFN1biwgQXByIDEzLCAyMDE0IGF0IDc6
NDggUE0sIFh1ZWxpbiBTaGkgPHh1ZWxpbi5zaGlAZnJlZXNjYWxlLmNvbT4gd3JvdGU6DQo+IEhp
IERhbiwNCj4NCj4gZnNsIGRtYSBkZXZpY2UgYW5kIGZzbCByYWlkIGRldmljZSBhcmUgdHdvIGRp
ZmZlcmVuY3QgZGV2aWNlcyB0aGF0IA0KPiBib3RoIHByb3ZpZGUgYXN5bmNfbWVtY3B5IGNhcGFi
aWxpdHksIHNvIEkgdXNlICFGU0xfRE1BIHRvIGRpc2FibGUgdGhlIGZzbCBkbWEgZGV2aWNlLg0K
Pg0KPiBUaGF0J3MgdG8gc2F5LCBlaXRoZXIgc2VsZWN0IGZzbGRtYSBkZXZpY2UsIGVpdGhlciBm
c2wgcmFpZCBkZXZpY2UuDQo+DQoNClJpZ2h0LCBidXQgdGhhdCdzIG5vdCB3aGF0IHlvdXIgcHJv
cG9zZWQgS2NvbmZpZyBkZXBlbmRlbmN5IGxpbmUgZG9lcy4NCg0KWW91IHdhbnQgc29tZXRoaW5n
IGxpa2UgImRlcGVuZHMgb24gRlNMX1NPQyAmJiAhKEZTTF9ETUEgfHwgRlNMX0RNQT1tKSINCg0K
SG93ZXZlciwgdGhlIG1vcmUgcHJvYmxlbWF0aWMgb3B0aW9uIGlzIEFTWU5DX1RYX0NIQU5ORUxf
U1dJVENILiAgVGhhdCBvcHRpb24gaXMgcHJvYmxlbWF0aWMgZm9yIFJBSUQsIHNvIEkgcHJvcG9z
ZSAiZGVwZW5kIG9uICFBU1lOQ19UWF9DSEFOTkVMX1NXSVRDSCIgc2luY2UgdGhhdCBhZGRyZXNz
ZXMgYm90aCBwcm9ibGVtcy4NCg0KDQo=
