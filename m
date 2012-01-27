Return-Path: <B32579@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C1EADB6EFF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2012 01:20:44 +1100 (EST)
From: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
To: "dedekind1@gmail.com" <dedekind1@gmail.com>
Subject: RE: [PATCH] mtd/nand:Fix wrong usage of is_blank() in
 fsl_ifc_run_command
Date: Fri, 27 Jan 2012 14:20:33 +0000
Message-ID: <071A08F2C6A57E4E94D980ECA553F8744DABE2@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1326859991-7469-1-git-send-email-prabhakar@freescale.com>
 <1327670133.26648.40.camel@sauron.fi.intel.com>
In-Reply-To: <1327670133.26648.40.camel@sauron.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJ0ZW0gQml0eXV0c2tp
eSBbbWFpbHRvOmRlZGVraW5kMUBnbWFpbC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAy
NywgMjAxMiA2OjQ2IFBNDQo+IFRvOiBLdXNod2FoYSBQcmFiaGFrYXItQjMyNTc5DQo+IENjOiBs
aW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5v
cmc7IFdvb2QNCj4gU2NvdHQtQjA3NDIxOyBBZ2dyd2FsIFBvb25hbS1CMTA4MTINCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gbXRkL25hbmQ6Rml4IHdyb25nIHVzYWdlIG9mIGlzX2JsYW5rKCkgaW4N
Cj4gZnNsX2lmY19ydW5fY29tbWFuZA0KPiANCj4gT24gV2VkLCAyMDEyLTAxLTE4IGF0IDA5OjQz
ICswNTMwLCBQcmFiaGFrYXIgS3VzaHdhaGEgd3JvdGU6DQo+ID4gRnJlZXNjYWxlIElGQyBOQU5E
IE1hY2hpbmUgY2FsY3VsYXRlcyBFQ0Mgb24gNTEyYnl0ZSBzZWN0b3IgYW5kIHNhbWUNCj4gPiBp
cyB1c2VkIGluDQo+ID4gZnNsX2lmY19ydW5fY29tbWFuZCgpIGR1cmluZyBFQ0Mgc3RhdHVzIHZl
cmlmaWNhdGlvbi4gQWxzbyB0aGlzIHNlY3Rvcg0KPiA+IGlzIHBhc3NlZCB0byBpc19ibGFuaygp
IGZvciBibGFuayBjaGVja2luZy4gSXQgaXMgd3JvbmcgYXQgZmlyc3QgcGxhY2UNCj4gPiBiZWNh
dXNlIGlzX2JsYW5rKCkncyBpbXBsZW1lbnRhdGlvbiBjaGVja3MgZm9yIFBhZ2Ugc2l6ZSBhbmQg
T09CIGFyZWENCj4gc2l6ZS4NCj4gPiBpc19ibGFuaygpIHNob3VsZCBiZSBjYWxsZWQgcGVyIHBh
Z2UgZm9yIG1haW4gYW5kIE9PQiBhcmVhDQo+IHZlcmlmaWNhdGlvbi4NCj4gPg0KPiA+IFZhcmlh
YmxlcyBuYW1lIGFyZSByZWRlZmluZWQgdG8gYXZvaWQgY29uZnVzaW9uIGJldHdlZW4gYnVmZmVy
IGFuZCBlY2MNCj4gc2VjdG9yLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUG9vbmFtIEFnZ3J3
YWwgPHBvb25hbS5hZ2dyd2FsQGZyZWVzY2FsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2Nv
dHQgV29vZCA8c2NvdHR3b29kQGZyZWVzY2FsZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUHJh
Ymhha2FyIEt1c2h3YWhhIDxwcmFiaGFrYXJAZnJlZXNjYWxlLmNvbT4NCj4gDQo+IFRoZSBkcml2
ZXIgaXMgbm90IGluIDMuMy1yYzEsIHNvIEkgc2tpcCB0aGlzIHBhdGNoLg0KPiANCg0KDQpUaGlz
IHBhdGNoIGlzIHNxdWFzaGVkIGluIExpbnV4IE5BTkQgZHJpdmVyIHBhdGNoLiBJdCB3aWxsIGJl
IHByb3ZpZGVkIGJ5IGdhbGFrJ3MgdHJlZQ0KDQoiTkFORCBNYWNoaW5lIHN1cHBvcnQgZm9yIElu
dGVncmF0ZWQgRmxhc2ggQ29udHJvbGxlciINCmh0dHA6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9w
YXRjaC8xMzcwMjQvDQoNCi0tUHJhYmhha2FyDQoNCg==
