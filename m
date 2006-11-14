Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id 62E3E67D20
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 21:51:09 +1100 (EST)
Received: from mail6.sony.co.jp (localhost [127.0.0.1])
	by mail6.sony.co.jp (R8/Sony) with ESMTP id kAEAp7KL025456
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 19:51:07 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail6.sony.co.jp (R8/Sony) with SMTP id kAEAp7cs025412
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 19:51:07 +0900 (JST)
Message-ID: <45599F91.9070802@am.sony.com>
Date: Tue, 14 Nov 2006 02:50:57 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/16] cell: abstract spu management routines
References: <4554DA9C.9040102@am.sony.com>
	<1163475880.8048.78.camel@localhost.localdomain>
	<200611141055.22317.arnd@arndb.de>
In-Reply-To: <200611141055.22317.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

QXJuZCBCZXJnbWFubiB3cm90ZToNCj4gT24gVHVlc2RheSAxNCBOb3ZlbWJlciAyMDA2IDA0OjQ0
LCBNaWNoYWVsIEVsbGVybWFuIHdyb3RlOg0KPj4gT0ssIGJhY2sgdG8gdGhlIHRhc2sgYXQgaGFu
ZCA6KSDvv71Gb3IgdGhlIG1vbWVudCBJJ2QgcmF0aGVyIHNlZSB5b3UgbGVhdmUNCj4+IG91dCBk
dW1wX2RhdGFfZmllbGRzKCksIGFzIG5laXRoZXIgSFYgb3IgYmFyZW1ldGFsIGltcGxlbWVudGF0
aW9ucyBkbw0KPj4gYW55dGhpbmcuIEp1c3QgcHV0IHRoZSBvZmZlbmRpbmcgeG1vbiBjb2RlIGlu
c2lkZSBhbiAjaWZkZWYNCj4+IENPTkZJR19QUENfQ0VMTF9OQVRJVkUuIGVnOg0KPj4gDQo+PiBJ
bmRleDogY2VsbC9hcmNoL3Bvd2VycGMveG1vbi94bW9uLmMNCj4+ID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+IC0t
LSBjZWxsLm9yaWcvYXJjaC9wb3dlcnBjL3htb24veG1vbi5jIO+/vTIwMDYtMTEtMTQgMTQ6NDM6
MTEuMDAwMDAwMDAwICsxMTAwDQo+PiArKysgY2VsbC9hcmNoL3Bvd2VycGMveG1vbi94bW9uLmMg
77+9IO+/vSDvv70gMjAwNi0xMS0xNCAxNDo0MjozNS4wMDAwMDAwMDAgKzExMDANCj4+IEBAIC0y
ODA3LDEyICsyODA3LDExIEBAIHN0YXRpYyB2b2lkIGR1bXBfc3B1X2ZpZWxkcyhzdHJ1Y3Qgc3B1
ICoNCj4+IO+/vSDvv70g77+9IO+/vSDvv70g77+9IO+/vSDvv70g77+9IO+/vSDvv70g77+9IGlu
X2JlMzIoJnNwdS0+cHJvYmxlbS0+c3B1X3N0YXR1c19SKSk7DQo+PiDvv70g77+9IO+/vSDvv70g
RFVNUF9WQUxVRSgiMHgleCIsIHByb2JsZW0tPnNwdV9ucGNfUlcsDQo+PiDvv70g77+9IO+/vSDv
v70g77+9IO+/vSDvv70g77+9IO+/vSDvv70g77+9IO+/vSBpbl9iZTMyKCZzcHUtPnByb2JsZW0t
PnNwdV9ucGNfUlcpKTsNCj4+ICsjaWZkZWYgQ09ORklHX1BQQ19DRUxMX05BVElWRQ0KPj4g77+9
IO+/vSDvv70g77+9IERVTVBfRklFTEQoc3B1LCAiMHglcCIsIHByaXYxKTsNCj4+IC0NCj4+IC0g
77+9IO+/vSDvv70gaWYgKHNwdS0+cHJpdjEpIHsNCj4+IC0g77+9IO+/vSDvv70g77+9IO+/vSDv
v70g77+9IERVTVBfVkFMVUUoIjB4JWx4IiwgcHJpdjEtPm1mY19zcjFfUlcsDQo+PiAtIO+/vSDv
v70g77+9IO+/vSDvv70g77+9IO+/vSDvv70g77+9IO+/vSDvv70g77+9IO+/vSDvv70g77+9IGlu
X2JlNjQoJnNwdS0+cHJpdjEtPm1mY19zcjFfUlcpKTsNCj4+IC0g77+9IO+/vSDvv70gfQ0KPj4g
KyDvv70g77+9IO+/vSBEVU1QX1ZBTFVFKCIweCVseCIsIHByaXYxLT5tZmNfc3IxX1JXLA0KPj4g
KyDvv70g77+9IO+/vSDvv70g77+9IO+/vSDvv70g77+9IO+/vSDvv70g77+9IGluX2JlNjQoJnNw
dS0+cHJpdjEtPm1mY19zcjFfUlcpKTsNCj4+ICsjZW5kaWYNCj4gDQo+IE9vcHMuIE51bGwgcG9p
bnRlciBkZXJlZmVyZW5jZS4NCj4gDQo+IFlvdSBjYW4ndCBkbyB0aGlzIGlmIHlvdSB3YW50IHRv
IGNvbXBpbGUgaW4gYm90aCBuYXRpdmUgYW5kIFBTM1BGDQo+IHN1cHBvcnQgaW4gYSBzaW5nbGUg
a2VybmVsLiBJIHRoaW5rIHlvdXIgb3JpZ2luYWwgY29kZSB0aGF0IHByaW50cw0KPiBwcml2MSBh
bmQgdGhlIHNyMSBvbmx5IGlmIHByaXYxIGV4aXN0cyBpcyBmaW5lIG9uIGJvdGggd2F5cy4NCg0K
Tm8sIHRoYXQgd29uJ3Qgd29yayBlaXRoZXIgc2luY2UgSSBtb3ZlZCBwcml2MSB0byBzdHJ1Y3Qg
c3B1X3BkYXRhLg0KDQorc3RydWN0IHNwdV9wZGF0YSB7DQorCWludCBuaWQ7DQorCXN0cnVjdCBk
ZXZpY2Vfbm9kZSAqZGV2bm9kZTsNCisJc3RydWN0IHNwdV9wcml2MSBfX2lvbWVtICpwcml2MTsN
Cit9Ow0KDQpUaGUgb25seSB3YXkgSSBzZWUgdGhpcyB3b3JraW5nIGlzIHRvIGhhdmUgYSBwbGF0
Zm9ybSBzcGVjaWZpYw0Kcm91dGluZSB0byBkdW1wIHRob3NlIHNwdV9wZGF0YSB2YXJpYWJsZXMu
ICBUaGUgcHJvYmxlbSBpcyB0aGF0DQpvbmx5IHRoZSBzcHUgcGxhdGZvcm0gY29kZSBrbm93cyBh
Ym91dCB0aGUgdmFyaWFibGVzLCBhbmQgb25seSB0aGUNCnhtb24gY29kZSBrbm93cyBob3cgdG8g
ZG8gdGhlIGR1bXAuICBUaGF0IGlzIHdoeSBJIHN1Z2dlc3RlZCBlYXJsaWVyDQp0byByZS13b3Jr
IHRoZSB4bW9uIGNvZGUgdG8gbWFrZSBhIGR1bXAgcm91dGluZSB3aXRoIGdsb2JhbCBzY29wZQ0K
dGhhdCBjYW4gYmUgY2FsbGVkIGZyb20gdGhlIHZhcmlvdXMgc3B1IHBsYXRmb3JtIA0Kc3B1X2R1
bXBfcGRhdGFfZmllbGRzKCkgcm91dGluZXMuDQoNCk5vdGUgdGhhdCB0aGlzIGlzIG5vdCBzcGVj
aWZpYyB0byB0aGUgbmF0aXZlIHN1cHBvcnQsIHNpbmNlIEkgd2FudA0KdG8gaG9vayBteSBwbGF0
Zm9ybSBjb2RlIGludG8geG1vbiBhbHNvLCBhbmQgSSBuZWVkIHRvIHNvbWVob3cNCmR1bXAgbXkg
dmFyaWFibGVzLiAgU28gdGhlIHNvbHV0aW9uIGlzIG5vdCB0byBhZGQgcHJpdjEgYmFjayBpbnRv
DQpzdHJ1Y3Qgc3B1Lg0KDQotR2VvZmYNCg==
