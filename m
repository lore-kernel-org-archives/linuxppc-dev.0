Return-Path: <B38951@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5AE222C0113
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 12:41:28 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH 1/2] powerpc: Move opcode definitions from kvm/emulate.c
 to asm/ppc-opcode.h
Date: Fri, 26 Apr 2013 02:40:36 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C4C229@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1366684776-10946-1-git-send-email-hongtao.jia@freescale.com>
 <20130423052951.GB20902@concordia>
 <412C8208B4A0464FA894C5F0C278CD5D01C4A4B0@039-SN1MPN1-002.039d.mgd.msft.net>
 <1366777161.2869.0.camel@pasglop>
In-Reply-To: <1366777161.2869.0.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuamFtaW4gSGVycmVu
c2NobWlkdCBbbWFpbHRvOmJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZ10NCj4gU2VudDogV2VkbmVz
ZGF5LCBBcHJpbCAyNCwgMjAxMyAxMjoxOSBQTQ0KPiBUbzogSmlhIEhvbmd0YW8tQjM4OTUxDQo+
IENjOiBNaWNoYWVsIEVsbGVybWFuOyBXb29kIFNjb3R0LUIwNzQyMTsgbGludXhwcGMtZGV2QGxp
c3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHBvd2VycGM6IE1vdmUg
b3Bjb2RlIGRlZmluaXRpb25zIGZyb20NCj4ga3ZtL2VtdWxhdGUuYyB0byBhc20vcHBjLW9wY29k
ZS5oDQo+IA0KPiBPbiBUdWUsIDIwMTMtMDQtMjMgYXQgMDY6MzYgKzAwMDAsIEppYSBIb25ndGFv
LUIzODk1MSB3cm90ZToNCj4gPiBUaGVzZSBkZWZpbml0aW9ucyBhcmUgZmlyc3RseSB1c2VkIGJ5
IEtWTSBkZWZpbmVkIGxpa2UgT1BfMzFfWE9QX1RSQVAuDQo+ID4gVHdvIHdheXMgdG8gZXh0cmFj
dCB0aGVzZSBkZWZpbml0aW9ucyBmb3IgcHVibGljIHVzZToNCj4gPg0KPiA+IDEuIExpa2UgdGhp
cyBwYXRjaCBkaWQuIEZvciBrZWVwaW5nIHRoZSBLVk0gY29kZSB0aGF0IHVzaW5nIHRoZXNlDQo+
ID4gICAgZGVmaW5pdGlvbnMgdW5jaGFuZ2VkIHdlIGRvIG5vdCB1cGRhdGUgdGhlbSB0byBtYXRj
aC4NCj4gPg0KPiA+IDIuIE1vdmUgdGhlc2UgZGVmaW5pdGlvbnMgdG8gYW5vdGhlciAuaCBmaWxl
IGxpa2UgbXkgbGFzdCBwYXRjaCBkaWQ6DQo+ID4gICAgaHR0cDovL3BhdGNod29yay5vemxhYnMu
b3JnL3BhdGNoLzIzNTY0Ni8NCj4gPiAgICBZb3UgY2FuIHNlZSB0aGUgY29tbWVudHMgdGhlcmUu
DQo+IA0KPiBUaGVyZSdzIGEgYmV0dGVyIHdheSAuLi4gYnV0IGl0J3MgbW9yZSB3b3JrLg0KPiAN
Cj4gQWxsIG9wY29kZXMgYXJlIGJhc2VkIG9uIGEgcHJpbWFyeSBvcGNvZGUgYW5kIGEgcG90ZW50
aWFsIHNlY29uZGFyeQ0KPiBvcGNvZGUuIFlvdSBjb3VsZC9zaG91bGQgcmV3b3JrIHBwYy1vcGNv
ZGVzLmggdG8gaW4gZmFjdCBkZWZpbmUgdGhlbQ0KPiBhbGwgdGhhdCB3YXkgYXMgd2VsbCwgd2hp
Y2ggd291bGQgInJlY29uY2lsZSIgdGhlIEtWTSB3YXkgYW5kIHRoZQ0KPiBleGlzdGluZyBzdHVm
Zi4NCj4gDQo+IENoZWVycywNCj4gQmVuLg0KPiANCg0KQWdyZWUuIEJ1dCBJJ20gYWZyYWlkIHRv
IHNheSB0aGF0IEknbSB0b28gYnVzeSB0byBkbyB0aGlzICJtb3JlIHdvcmsiDQpyaWdodCBub3cu
IENvdWxkIHdlIGRlZmVyIHRoaXMgd29yayBmb3Igc29tZSB0aW1lPw0KDQpUaGFua3MuDQotIEhv
bmd0YW8NCg==
