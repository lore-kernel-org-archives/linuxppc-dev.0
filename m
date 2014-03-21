Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 960B22C00A0
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2014 23:02:34 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 13714-05 for <linuxppc-dev@ozlabs.org>;
 Fri, 21 Mar 2014 12:02:32 +0000 (GMT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, "ego@linux.vnet.ibm.com"
 <ego@linux.vnet.ibm.com>
Subject: RE: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
Date: Fri, 21 Mar 2014 12:01:07 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6E5386@AcuExch.aculab.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
 <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
In-Reply-To: <CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Linux PM list <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogVmlyZXNoIEt1bWFyDQogDQo+IE9uIDIxIE1hcmNoIDIwMTQgMTY6MzQsIEdhdXRoYW0g
UiBTaGVub3kgPGVnb0BsaW51eC52bmV0LmlibS5jb20+IHdyb3RlOg0KPiA+IEhlaCEgV2VsbCwg
dGhhdCB3YXNuJ3QgdGhlIHJlYXNvbiB3aHkgdGhpcyB3YXMgc2VudCBvdXQgYXMgYSBzZXBhcmF0
ZQ0KPiA+IHBhdGNoLCBidXQgbmV2ZXIgbWluZC4gVGhvdWdoIEkgZG9uJ3QgdW5kZXJzdGFuZCB3
aHkgaXQgd291bGQgYmUNCj4gPiBkaWZmaWN1bHQgdG8gcmV2aWV3IHRoZSBwYXRjaCB0aG91Z2gu
DQo+IA0KPiBCZWNhdXNlIHRoZSBpbml0aWFsIGRyaXZlciB3YXNuJ3QgY29tcGxldGUgZWFybGll
ci4gVGhlcmUgd2VyZSAyLTMgcGF0Y2hlcw0KPiBhZnRlciB0aGUgZmlyc3Qgb25lIHdoaWNoIGFy
ZSBjaGFuZ2luZyB3aGF0IHRoZSBmaXJzdCBwYXRjaCBoYXMgYWRkZWQuDQo+IE5vdGhpbmcgZWxz
ZSA6KQ0KPiANCj4gPj4gPiArc3RhdGljIHZvaWQgcG93ZXJudl9yZWFkX2NwdV9mcmVxKHZvaWQg
KnJldF9mcmVxKQ0KPiA+PiA+ICt7DQo+ID4+ID4gKyAgICAgICB1bnNpZ25lZCBsb25nIHBtc3By
X3ZhbDsNCj4gPj4gPiArICAgICAgIHM4IGxvY2FsX3BzdGF0ZV9pZDsNCj4gPj4gPiArICAgICAg
IGludCAqY3VyX2ZyZXEsIGZyZXEsIHBzdGF0ZV9pZDsNCj4gPj4gPiArDQo+ID4+ID4gKyAgICAg
ICBjdXJfZnJlcSA9IChpbnQgKilyZXRfZnJlcTsNCj4gPj4NCj4gPj4gWW91IGRvbid0IG5lZWQg
Y3VyX2ZyZXEgdmFyaWFibGUgYXQgYWxsLi4NCj4gPg0KPiA+IEkgZG9uJ3QgbGlrZSBpdCBlaXRo
ZXIuIEJ1dCB0aGUgY29tcGlsZXIgY29tcGxhaW5zIHdpdGhvdXQgdGhpcyBoYWNrDQo+ID4gOi0o
DQo+IA0KPiBXaHkgd291bGQgdGhlIGNvbXBpbGVyIHdhcm4gZm9yIGRvaW5nIHRoaXM/Og0KPiAN
Cj4gKihpbnQgKilyZXRfZnJlcSA9IGZyZXE7DQoNCkJlY2F1c2UgaXQgaXMgdmVyeSBsaWtlbHkg
dG8gYmUgd3JvbmcuDQpJbiBnZW5lcmFsIGNhc3RzIG9mIHBvaW50ZXJzIHRvIGludGVnZXIgdHlw
ZXMgYXJlIGRhbmdlcm91cy4NCkluIHRoaXMgY2FzZSB3aHkgbm90IG1ha2UgdGhlIGZ1bmN0aW9u
IHJldHVybiB0aGUgdmFsdWU/DQoNCglEYXZpZA0KDQoNCg==
