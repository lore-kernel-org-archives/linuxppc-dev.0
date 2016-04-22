Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrvGL0YlrzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 21:56:10 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>, Tejun Heo
 <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "Rob Herring" <robh+dt@kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Christian Lamparter
 <chunkeey@googlemail.com>, =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: RE: [PATCH v1 08/23] ata: sata_dwc_460ex: don't call
 ata_sff_qc_issue() on DMA commands
Date: Fri, 22 Apr 2016 11:32:00 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4A7ECF@AcuExch.aculab.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1461262544-115408-9-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1461262544-115408-9-git-send-email-andriy.shevchenko@linux.intel.com>
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

RnJvbTogQW5keSBTaGV2Y2hlbmtvDQo+IFNlbnQ6IDIxIEFwcmlsIDIwMTYgMTk6MTUNCj4gYXRh
X3NmZl9xY19pc3N1ZSgpIGNhbid0IGhhbmRsZSBETUEgY29tbWFuZHMgYW5kIHRodXMgd2UgaGF2
ZSB0byBhdm9pZCBpdCBmb3INCj4gdGhlbS4gRG8gY2FsbCBhdGFfYm1kbWFfcWNfaXNzdWUoKSBp
bnN0ZWFkIGZvciB0aGlzIGNhc2UuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IENocmlzdGlhbiBMYW1w
YXJ0ZXIgPGNodW5rZWV5QGdvb2dsZW1haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFNo
ZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2F0YS9zYXRhX2R3Y180NjBleC5jIHwgNiArKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9hdGEvc2F0YV9kd2NfNDYwZXguYyBiL2RyaXZlcnMvYXRhL3NhdGFfZHdjXzQ2MGV4LmMN
Cj4gaW5kZXggMDM4ZTVmYi4uODQ1YzM1ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hdGEvc2F0
YV9kd2NfNDYwZXguYw0KPiArKysgYi9kcml2ZXJzL2F0YS9zYXRhX2R3Y180NjBleC5jDQo+IEBA
IC0xMDYxLDEwICsxMDYxLDEyIEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgc2F0YV9kd2NfcWNfaXNz
dWUoc3RydWN0IGF0YV9xdWV1ZWRfY21kICpxYykNCj4gIAkJCV9fZnVuY19fLCB0YWcsIHFjLT5h
cC0+bGluay5zYWN0aXZlLCBzYWN0aXZlKTsNCj4gDQo+ICAJCWFwLT5vcHMtPnNmZl90Zl9sb2Fk
KGFwLCAmcWMtPnRmKTsNCj4gLQkJc2F0YV9kd2NfZXhlY19jb21tYW5kX2J5X3RhZyhhcCwgJnFj
LT50ZiwgcWMtPnRhZywNCj4gKwkJc2F0YV9kd2NfZXhlY19jb21tYW5kX2J5X3RhZyhhcCwgJnFj
LT50ZiwgdGFnLA0KPiAgCQkJCQkgICAgIFNBVEFfRFdDX0NNRF9JU1NVRURfUEVORCk7DQo+ICsJ
fSBlbHNlIGlmIChhdGFfaXNfZG1hKHFjLT50Zi5wcm90b2NvbCkpIHsNCj4gKwkJcmV0dXJuIGF0
YV9ibWRtYV9xY19pc3N1ZShxYyk7DQo+ICAJfSBlbHNlIHsNCj4gLQkJYXRhX3NmZl9xY19pc3N1
ZShxYyk7DQo+ICsJCXJldHVybiBhdGFfc2ZmX3FjX2lzc3VlKHFjKTsNCj4gIAl9DQo+ICAJcmV0
dXJuIDA7DQo+ICB9DQoNCkknZCBudWtlIHRob3NlICdlbHNlIGlmJywgdGhleSBtYWtlIGl0IHZl
cnkgaGFyZCB0byByZWFkLg0KSSBUaGluayB0aGUgY29kZSBpczoNCg0KCQlzYXRhX2R3Y19leGVj
X2NvbW1hbmRfYnlfdGFnKC4uLik7DQoJCXJldHVybiAwOw0KCX0NCg0KCWlmIChhdGFfaXNfZG1h
KHFjLT50Zi5wcm90b2NvbCkpDQoJCXJldHVybiBhdGFfYm1kbWFfcWNfaXNzdWUocWMpOw0KDQoJ
cmV0dXJuIGF0YV9zZmZfcWNfaXNzdWUocWMpOw0KfQ0KDQoJRGF2aWQNCg0K
