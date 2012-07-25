Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 98E4E2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 19:01:32 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/6] powerpc/fsl-pci: Determine primary bus by looking
 for ISA node
Date: Wed, 25 Jul 2012 09:01:22 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A276B1@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-3-git-send-email-B38951@freescale.com>
 <500EEDD9.8050507@freescale.com>
In-Reply-To: <500EEDD9.8050507@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+ICsvKg0KPiA+ICsgKiBSZWN1cnNpdmVseSBzY2FuIGFsbCB0aGUgY2hpbGRyZW4gbm9kZXMg
b2YgcGFyZW50IGFuZCBmaW5kIG91dCBpZg0KPiB0aGVyZQ0KPiA+ICsgKiBpcyAiaXNhIiBub2Rl
LiBSZXR1cm4gMSBpZiBwYXJlbnQgaGFzIGlzYSBub2RlIG90aGVyd2lzZSByZXR1cm4gMC4NCj4g
PiArICovDQo+ID4gK2ludCBoYXNfaXNhX25vZGUoc3RydWN0IGRldmljZV9ub2RlICpwYXJlbnQp
DQo+ID4gK3sNCj4gPiArCXN0YXRpYyBpbnQgcmVzdWx0Ow0KPiA+ICsJc3RydWN0IGRldmljZV9u
b2RlICpjdXJfY2hpbGQ7DQo+ID4gKw0KPiA+ICsJY3VyX2NoaWxkID0gTlVMTDsNCj4gPiArCXJl
c3VsdCA9IDA7DQo+ID4gKwl3aGlsZSAoIXJlc3VsdCAmJiAoY3VyX2NoaWxkID0gb2ZfZ2V0X25l
eHRfY2hpbGQocGFyZW50LA0KPiBjdXJfY2hpbGQpKSkgew0KPiA+ICsJCS8qIEdldCAiaXNhIiBu
b2RlIGFuZCByZXR1cm4gMSAqLw0KPiA+ICsJCWlmIChvZl9ub2RlX2NtcChjdXJfY2hpbGQtPnR5
cGUsICJpc2EiKSA9PSAwKQ0KPiA+ICsJCQlyZXR1cm4gcmVzdWx0ID0gMTsNCj4gPiArCQloYXNf
aXNhX25vZGUoY3VyX2NoaWxkKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gcmVzdWx0
Ow0KPiA+ICt9DQo+IA0KPiBXaHkgYXJlIHlvdSByZWltcGxlbWVudGluZyB0aGlzPyAgSXQncyBh
bHJlYWR5IGluIExpbnVzJ3MgdHJlZS4gIFNlZQ0KPiBmc2xfcGNpX2luaXQoKS4NCj4gDQo+IFBs
dXMsIHlvdXIgdmVyc2lvbiBpcyByZWN1cnNpdmUgd2hpY2ggaXMgdW5hY2NlcHRhYmxlIGluIGtl
cm5lbCBjb2RlDQo+IHdpdGggYSBzbWFsbCBzdGFjayAob3V0c2lkZSBvZiBhIGZldyByYXJlIGV4
YW1wbGVzIHdoZXJlIHRoZSBkZXB0aCBoYXMgYQ0KPiBzbWFsbCBmaXhlZCB1cHBlciBib3VuZCks
IGFuZCBvbmNlIGl0IGZpbmRzIGFuIElTQSBub2RlLCBpdCByZXR1cm5zIDENCj4gZm9yZXZlciwg
cmVnYXJkbGVzcyBvZiB3aGF0IG5vZGUgeW91IHBhc3MgaW4gaW4gdGhlIGZ1dHVyZS4NCj4gDQo+
IC1TY290dA0KDQpZZXMsIHJlY3Vyc2l2ZSBmdW5jdGlvbiBpcyBub3QgcmVjb21tZW5kZWQgZm9y
IGtlcm5lbCBidXQgbWF5YmUgaXQncyBub3QgdW5hY2NlcHRhYmxlLg0KVGhpcyBmdW5jdGlvbiBp
cyBub3Qgc28gZGVlcCBzdGFja2VkIGFuZCBzaW1wbGUuIEluIG15IG9waW5pb24gdGhpcyBpcyBh
Y2NlcHRhYmxlLg0KDQpUaGFua3MuDQotSG9uZ3Rhby4NCg0K
