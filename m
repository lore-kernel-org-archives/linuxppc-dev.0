Return-Path: <r63061@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CA3842C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 13:28:02 +1100 (EST)
Received: from mail81-ch1 (localhost [127.0.0.1])	by mail81-ch1-R.bigfish.com
 (Postfix) with ESMTP id AF5E83A0071	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Nov 2013 02:27:57 +0000 (UTC)
Received: from CH1EHSMHS041.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.226])	by mail81-ch1.bigfish.com (Postfix) with ESMTP id
 464E04C01F9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 02:27:56 +0000 (UTC)
From: Xiaobo Xie <r63061@freescale.com>
To: Scott Wood <B07421@freescale.com>
Subject: RE: [PATCH V5 1/2] powerpc/85xx: Add QE common init function
Date: Wed, 6 Nov 2013 02:27:55 +0000
Message-ID: <69EC9ED88E3CC04094A78F8074A7986D62F872@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1380188253-4710-1-git-send-email-X.Xie@freescale.com>
 <1380301237.24959.397.camel@snotra.buserror.net>
In-Reply-To: <1380301237.24959.397.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgU2NvdHQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBT
Y290dC1CMDc0MjENCj4gU2VudDogU2F0dXJkYXksIFNlcHRlbWJlciAyOCwgMjAxMyAxOjAxIEFN
DQo+IFRvOiBYaWUgWGlhb2JvLVI2MzA2MQ0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFi
cy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNSAxLzJdIHBvd2VycGMvODV4eDogQWRkIFFF
IGNvbW1vbiBpbml0IGZ1bmN0aW9uDQo+IA0KPiBPbiBUaHUsIDIwMTMtMDktMjYgYXQgMTc6Mzcg
KzA4MDAsIFhpZSBYaWFvYm8gd3JvdGU6DQo+ID4gKyNpZmRlZiBDT05GSUdfUVVJQ0NfRU5HSU5F
DQo+ID4gK3ZvaWQgX19pbml0IG1wYzg1eHhfcWVfaW5pdCh2b2lkKQ0KPiA+ICt7DQo+ID4gKwlz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5wOw0KPiA+ICsNCj4gPiArCW5wID0gb2ZfZmluZF9jb21wYXRp
YmxlX25vZGUoTlVMTCwgTlVMTCwgImZzbCxxZSIpOw0KPiA+ICsJaWYgKCFucCkgew0KPiA+ICsJ
CW5wID0gb2ZfZmluZF9ub2RlX2J5X25hbWUoTlVMTCwgInFlIik7DQo+ID4gKwkJaWYgKCFucCkg
ew0KPiA+ICsJCQlwcl9lcnIoIiVzOiBDb3VsZCBub3QgZmluZCBRdWljYyBFbmdpbmUgbm9kZVxu
IiwNCj4gPiArCQkJCQlfX2Z1bmNfXyk7DQo+ID4gKwkJCXJldHVybjsNCj4gPiArCQl9DQo+ID4g
Kwl9DQo+ID4gKw0KPiA+ICsJcWVfcmVzZXQoKTsNCj4gPiArCW9mX25vZGVfcHV0KG5wKTsNCj4g
DQo+IFlvdSdyZSBtaXNzaW5nIHRoZSBvZl9kZXZpY2VfaXNfYXZhaWxhYmxlKCkgY2hlY2s6DQoN
Ckkgd2lsbCBhZGQgdGhpcyBjaGVjaywgdGhhbmtzLg0KDQo+IA0KPiA+IC0JbnAgPSBvZl9maW5k
X2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAiZnNsLHFlIik7DQo+ID4gLQlpZiAoIW5wKSB7
DQo+ID4gLQkJbnAgPSBvZl9maW5kX25vZGVfYnlfbmFtZShOVUxMLCAicWUiKTsNCj4gDQo+IC1T
Y290dA0KPiANCg0K
