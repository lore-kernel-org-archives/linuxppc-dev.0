Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 313171A0074
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Sep 2014 19:21:28 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 19010-06 for <linuxppc-dev@lists.ozlabs.org>;
 Mon,  1 Sep 2014 10:14:37 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Shilpa Bhat' <shilpa.bhat@linux.vnet.ibm.com>, Viresh Kumar
 <viresh.kumar@linaro.org>
Subject: RE: [PATCH v2] cpufreq: powernv: Set the cpus to nominal frequency
 during reboot/kexec
Date: Mon, 1 Sep 2014 09:12:43 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D174849AD@AcuExch.aculab.com>
References: <1409234816-10802-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAKohpokbYkL=cYQ+9-59vPhBmbAWqhrEz7RBPj5-edDB25DPgw@mail.gmail.com>
 <1409548719.13507.13.camel@localhost.localdomain>
In-Reply-To: <1409548719.13507.13.camel@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogU2hpbHBhIEJoYXQNCj4gSGkgVmlyZXNoLA0KPiBPbiBGcmksIDIwMTQtMDgtMjkgYXQg
MDU6MzMgKzA1MzAsIFZpcmVzaCBLdW1hciB3cm90ZToNCj4gPiBPbiAyOCBBdWd1c3QgMjAxNCAx
OTozNiwgU2hpbHBhc3JpIEcgQmhhdA0KPiA+IDxzaGlscGEuYmhhdEBsaW51eC52bmV0LmlibS5j
b20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IENoYW5nZXMgdjEtPnYyOg0KPiA+ID4gSW52b2tlIC50
YXJnZXQoKSBkcml2ZXIgY2FsbGJhY2sgdG8gc2V0IHRoZSBjcHVzIHRvIG5vbWluYWwgZnJlcXVl
bmN5DQo+ID4gPiBpbiByZWJvb3Qgbm90aWZpZXIsIGluc3RlYWQgb2YgY2FsbGluZyBjcHVmcmVx
X3N1c3BlbmQoKSBhcyBzdWdnZXN0ZWQNCj4gPiA+IGJ5IFZpcmVzaCBLdW1hci4NCj4gPiA+IE1v
ZGlmaWVkIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gPg0KPiA+IFRoaXMgY2hhbmdlbG9nIHdpbGwg
Z2V0IGNvbW1pdGVkLCBpcyB0aGlzIHdoYXQgeW91IHdhbnQ/DQo+IA0KPiA+ID4gKyAgICAgICBp
ZiAodW5saWtlbHkocmVib290aW5nKSAmJiBuZXdfaW5kZXggIT0gZ2V0X25vbWluYWxfaW5kZXgo
KSkNCj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiA+DQo+ID4gSGF2ZSB5
b3UgcGxhY2VkIHRoZSB1bmxpa2VseSBvbmx5IGFyb3VuZCAncmVib290aW5nJyBpbnRlbnRpb25h
bGx5IG9yDQo+ID4gc2hvdWxkIGl0IGNvdmVyIHdob2xlIGlmIHN0YXRlbWVudD8NCj4gPg0KPiAN
Cj4gWWVzIHVubGlrZWx5KCkgc2hvdWxkIGNvdmVyIHRoZSB3aG9sZSBpZiBzdGF0ZW1lbnQuLi4N
Cg0KQWN0dWFsbHkgaXQgcHJvYmFibHkgc2hvdWxkbid0Lg0KWW91IG5lZWQgdG8gbG9vayBhdCB0
aGUgZ2VuZXJhdGVkIGNvZGUgd2l0aCBlYWNoIGRpZmZlcmVudCBzZXQgb2YgJ3VubGlrZWx5KCkn
DQp0byBzZWUgaG93IGdjYyBwcm9jZXNzZXMgdGhlbS4NCkluIHRoaXMgY2FzZSwgaWYgJ3JlYm9v
dGluZycgaXMgZmFsc2UgeW91IHdhbnQgdG8gJ2ZhbGwgdGhyb3VnaCcgb24gYSBzdGF0aWNhbGx5
DQpwcmVkaWN0ZWQgJ25vdCB0YWtlbicgYnJhbmNoLiBZb3UgZG9uJ3QgZXZlciBjYXJlIGFib3V0
IHRoZSBzZWNvbmQgY2xhdXNlLg0KV2l0aCBhbiAndW5saWtlbHknIGNvdmVyaW5nIHRoZSBlbnRp
cmUgc3RhdGVtZW50IGdjYyBjb3VsZCBlYXNpbHkgYWRkIGENCmZvcndhcmRzIGNvbmRpdGlvbmFs
IGJyYW5jaCAodGhhdCB3aWxsIGJlIG1pcy1wcmVkaWN0ZWQpIGZvciB0aGUgJ3JlYm9vdGluZycg
dGVzdC4NCg0KKFllcywgSSBzcGVudCBhIGxvdCBvZiB0aW1lIGdldHRpbmcgZ2NjIHRvIGdlbmVy
YXRlIGJyYW5jaGVzIHRoYXQgd2VyZQ0KY29ycmVjdGx5IHN0YXRpY2FsbHkgcHJlZGljdGVkIGZv
ciBzb21lIGNvZGUgd2hlcmUgZXZlcnkgY3ljbGUgbWF0dGVyZWQuKQ0KDQoJRGF2aWQNCg0K
