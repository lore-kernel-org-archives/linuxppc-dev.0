Return-Path: <michel@daenzer.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8516BB7B63
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 18:15:23 +1000 (EST)
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id B2F59DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 18:15:21 +1000 (EST)
Subject: Re: [PATCH 3/3] agp/uninorth: Unify U3 and pre-U3 insert_memory
	and remove_memory hooks.
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1250147148.3587.115.camel@pasglop>
References: <1249422665-24437-1-git-send-email-michel@daenzer.net>
	<1249422665-24437-3-git-send-email-michel@daenzer.net>
	<1250147148.3587.115.camel@pasglop>
Content-Type: multipart/mixed; boundary="=-ARB5HCMANhLcJW9co1jp"
Date: Thu, 13 Aug 2009 10:15:13 +0200
Message-Id: <1250151313.4992.202.camel@thor>
Mime-Version: 1.0
Cc: Dave Airlie <airlied@linux.ie>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-ARB5HCMANhLcJW9co1jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-08-13 at 17:05 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2009-08-04 at 23:51 +0200, Michel D=C3=A4nzer wrote:
> > From: Michel D=C3=A4nzer <daenzer@vmware.com>
> >=20
> > Signed-off-by: Michel D=C3=A4nzer <daenzer@vmware.com>
> > ---
>=20
> Hi Michel !
>=20
> While your two previous patches apply just fine, this one doesn't,
> the uninorth_insert_memory() function seems to be slightly different
> upstream. Does this depend on some separate yet unapplied patches ?

I previously sent the attached patches to Dave in the course of the
radeon KMS issues thread. Not sure which of these he's picked up yet, if
any.


> I'm putting 1/3 and 2/3 into my -test branch and they should hit my
> -next branch in a couple of days.
>=20
> Or do you prefer us to merge that via Dave ?
>=20
> The thing is, stuff in -powerpc is much more likely to get some amount
> of testing on actual ppc hardware than stuff in random other trees :-)

I'm fine with either way.


--=20
Earthling Michel D=C3=A4nzer           |                http://www.vmware.c=
om
Libre software enthusiast         |          Debian, X and DRI developer

--=-ARB5HCMANhLcJW9co1jp
Content-Disposition: attachment; filename="0001-uninorth-Handle-user-memory-types.patch"
Content-Type: text/x-patch; name="0001-uninorth-Handle-user-memory-types.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBiNzNhY2MxYTQ4Y2JlYTRkOWJhOWNhYTQxNDUxYjM4MjIzYmVkNTE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogPT91dGYtOD9xP01pY2hlbD0yMEQ9QzM9QTRuemVyPz0gPGRh
ZW56ZXJAdm13YXJlLmNvbT4NCkRhdGU6IFRodSwgMTMgQXVnIDIwMDkgMDg6NDI6MzYgKzAyMDAN
ClN1YmplY3Q6IFtQQVRDSF0gdW5pbm9ydGg6IEhhbmRsZSB1c2VyIG1lbW9yeSB0eXBlcy4NCg0K
U2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPGRhZW56ZXJAdm13YXJlLmNvbT4NCi0tLQ0K
IGRyaXZlcnMvY2hhci9hZ3AvdW5pbm9ydGgtYWdwLmMgfCAgIDE4ICsrKysrKysrKysrKysrKyst
LQ0KIDEgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9hZ3AvdW5pbm9ydGgtYWdwLmMgYi9kcml2ZXJzL2No
YXIvYWdwL3VuaW5vcnRoLWFncC5jDQppbmRleCAwM2Y5NWVjLi44ODBkM2Y2IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9jaGFyL2FncC91bmlub3J0aC1hZ3AuYw0KKysrIGIvZHJpdmVycy9jaGFyL2Fn
cC91bmlub3J0aC1hZ3AuYw0KQEAgLTE0NiwxMyArMTQ2LDIwIEBAIHN0YXRpYyBpbnQgdW5pbm9y
dGhfaW5zZXJ0X21lbW9yeShzdHJ1Y3QgYWdwX21lbW9yeSAqbWVtLCBvZmZfdCBwZ19zdGFydCwN
CiB7DQogCWludCBpLCBqLCBudW1fZW50cmllczsNCiAJdm9pZCAqdGVtcDsNCisJaW50IG1hc2tf
dHlwZTsNCiANCiAJdGVtcCA9IGFncF9icmlkZ2UtPmN1cnJlbnRfc2l6ZTsNCiAJbnVtX2VudHJp
ZXMgPSBBX1NJWkVfMzIodGVtcCktPm51bV9lbnRyaWVzOw0KIA0KLQlpZiAodHlwZSAhPSAwIHx8
IG1lbS0+dHlwZSAhPSAwKQ0KKwlpZiAodHlwZSAhPSBtZW0tPnR5cGUpDQorCQlyZXR1cm4gLUVJ
TlZBTDsNCisNCisJbWFza190eXBlID0gYWdwX2JyaWRnZS0+ZHJpdmVyLT5hZ3BfdHlwZV90b19t
YXNrX3R5cGUoYWdwX2JyaWRnZSwgdHlwZSk7DQorCWlmIChtYXNrX3R5cGUgIT0gMCkgew0KIAkJ
LyogV2Uga25vdyBub3RoaW5nIG9mIG1lbW9yeSB0eXBlcyAqLw0KIAkJcmV0dXJuIC1FSU5WQUw7
DQorCX0NCisNCiAJaWYgKChwZ19zdGFydCArIG1lbS0+cGFnZV9jb3VudCkgPiBudW1fZW50cmll
cykNCiAJCXJldHVybiAtRUlOVkFMOw0KIA0KQEAgLTE4NCwxMyArMTkxLDIwIEBAIHN0YXRpYyBp
bnQgdTNfaW5zZXJ0X21lbW9yeShzdHJ1Y3QgYWdwX21lbW9yeSAqbWVtLCBvZmZfdCBwZ19zdGFy
dCwgaW50IHR5cGUpDQogCWludCBpLCBudW1fZW50cmllczsNCiAJdm9pZCAqdGVtcDsNCiAJdTMy
ICpncDsNCisJaW50IG1hc2tfdHlwZTsNCiANCiAJdGVtcCA9IGFncF9icmlkZ2UtPmN1cnJlbnRf
c2l6ZTsNCiAJbnVtX2VudHJpZXMgPSBBX1NJWkVfMzIodGVtcCktPm51bV9lbnRyaWVzOw0KIA0K
LQlpZiAodHlwZSAhPSAwIHx8IG1lbS0+dHlwZSAhPSAwKQ0KKwlpZiAodHlwZSAhPSBtZW0tPnR5
cGUpDQorCQlyZXR1cm4gLUVJTlZBTDsNCisNCisJbWFza190eXBlID0gYWdwX2JyaWRnZS0+ZHJp
dmVyLT5hZ3BfdHlwZV90b19tYXNrX3R5cGUoYWdwX2JyaWRnZSwgdHlwZSk7DQorCWlmIChtYXNr
X3R5cGUgIT0gMCkgew0KIAkJLyogV2Uga25vdyBub3RoaW5nIG9mIG1lbW9yeSB0eXBlcyAqLw0K
IAkJcmV0dXJuIC1FSU5WQUw7DQorCX0NCisNCiAJaWYgKChwZ19zdGFydCArIG1lbS0+cGFnZV9j
b3VudCkgPiBudW1fZW50cmllcykNCiAJCXJldHVybiAtRUlOVkFMOw0KIA0KLS0gDQoxLjYuMy4z
DQoNCg==


--=-ARB5HCMANhLcJW9co1jp
Content-Disposition: attachment; filename*0=0002-uninorth-Also-handle-user-memory-types-in-u3_remove_.pat; filename*1=ch
Content-Type: text/x-patch; name="0002-uninorth-Also-handle-user-memory-types-in-u3_remove_.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAwZTRmMjVhNjE2ZmRiNTEzNjM3MmFiMDUyM2E0M2FmMzlmZjdmY2Q2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogPT91dGYtOD9xP01pY2hlbD0yMEQ9QzM9QTRuemVyPz0gPGRh
ZW56ZXJAdm13YXJlLmNvbT4NCkRhdGU6IFRodSwgMTMgQXVnIDIwMDkgMDg6NDI6MzggKzAyMDAN
ClN1YmplY3Q6IFtQQVRDSF0gdW5pbm9ydGg6IEFsc28gaGFuZGxlIHVzZXIgbWVtb3J5IHR5cGVz
IGluIHUzX3JlbW92ZV9tZW1vcnkoKS4NCk1JTUUtVmVyc2lvbjogMS4wDQpDb250ZW50LVR5cGU6
IHRleHQvcGxhaW47IGNoYXJzZXQ9dXRmLTgNCkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhi
aXQNCg0KQWxzbyBzaG9ydC1jaXJjdWl0IGVtcHR5IHVwZGF0ZXMuDQoNClNpZ25lZC1vZmYtYnk6
IE1pY2hlbCBEw6RuemVyIDxkYWVuemVyQHZtd2FyZS5jb20+DQotLS0NCiBkcml2ZXJzL2NoYXIv
YWdwL3VuaW5vcnRoLWFncC5jIHwgICAyOSArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0K
IDEgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9hZ3AvdW5pbm9ydGgtYWdwLmMgYi9kcml2ZXJzL2NoYXIv
YWdwL3VuaW5vcnRoLWFncC5jDQppbmRleCA4ODBkM2Y2Li5jZDYzZDc2IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9jaGFyL2FncC91bmlub3J0aC1hZ3AuYw0KKysrIGIvZHJpdmVycy9jaGFyL2FncC91
bmlub3J0aC1hZ3AuYw0KQEAgLTE0OCw5ICsxNDgsNiBAQCBzdGF0aWMgaW50IHVuaW5vcnRoX2lu
c2VydF9tZW1vcnkoc3RydWN0IGFncF9tZW1vcnkgKm1lbSwgb2ZmX3QgcGdfc3RhcnQsDQogCXZv
aWQgKnRlbXA7DQogCWludCBtYXNrX3R5cGU7DQogDQotCXRlbXAgPSBhZ3BfYnJpZGdlLT5jdXJy
ZW50X3NpemU7DQotCW51bV9lbnRyaWVzID0gQV9TSVpFXzMyKHRlbXApLT5udW1fZW50cmllczsN
Ci0NCiAJaWYgKHR5cGUgIT0gbWVtLT50eXBlKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogDQpAQCAt
MTYwLDYgKzE1NywxMiBAQCBzdGF0aWMgaW50IHVuaW5vcnRoX2luc2VydF9tZW1vcnkoc3RydWN0
IGFncF9tZW1vcnkgKm1lbSwgb2ZmX3QgcGdfc3RhcnQsDQogCQlyZXR1cm4gLUVJTlZBTDsNCiAJ
fQ0KIA0KKwlpZiAobWVtLT5wYWdlX2NvdW50ID09IDApDQorCQlyZXR1cm4gMDsNCisNCisJdGVt
cCA9IGFncF9icmlkZ2UtPmN1cnJlbnRfc2l6ZTsNCisJbnVtX2VudHJpZXMgPSBBX1NJWkVfMzIo
dGVtcCktPm51bV9lbnRyaWVzOw0KKw0KIAlpZiAoKHBnX3N0YXJ0ICsgbWVtLT5wYWdlX2NvdW50
KSA+IG51bV9lbnRyaWVzKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogDQpAQCAtMTkzLDkgKzE5Niw2
IEBAIHN0YXRpYyBpbnQgdTNfaW5zZXJ0X21lbW9yeShzdHJ1Y3QgYWdwX21lbW9yeSAqbWVtLCBv
ZmZfdCBwZ19zdGFydCwgaW50IHR5cGUpDQogCXUzMiAqZ3A7DQogCWludCBtYXNrX3R5cGU7DQog
DQotCXRlbXAgPSBhZ3BfYnJpZGdlLT5jdXJyZW50X3NpemU7DQotCW51bV9lbnRyaWVzID0gQV9T
SVpFXzMyKHRlbXApLT5udW1fZW50cmllczsNCi0NCiAJaWYgKHR5cGUgIT0gbWVtLT50eXBlKQ0K
IAkJcmV0dXJuIC1FSU5WQUw7DQogDQpAQCAtMjA1LDYgKzIwNSwxMiBAQCBzdGF0aWMgaW50IHUz
X2luc2VydF9tZW1vcnkoc3RydWN0IGFncF9tZW1vcnkgKm1lbSwgb2ZmX3QgcGdfc3RhcnQsIGlu
dCB0eXBlKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0NCiANCisJaWYgKG1lbS0+cGFnZV9jb3Vu
dCA9PSAwKQ0KKwkJcmV0dXJuIDA7DQorDQorCXRlbXAgPSBhZ3BfYnJpZGdlLT5jdXJyZW50X3Np
emU7DQorCW51bV9lbnRyaWVzID0gQV9TSVpFXzMyKHRlbXApLT5udW1fZW50cmllczsNCisNCiAJ
aWYgKChwZ19zdGFydCArIG1lbS0+cGFnZV9jb3VudCkgPiBudW1fZW50cmllcykNCiAJCXJldHVy
biAtRUlOVkFMOw0KIA0KQEAgLTIzNCwxMCArMjQwLDE5IEBAIGludCB1M19yZW1vdmVfbWVtb3J5
KHN0cnVjdCBhZ3BfbWVtb3J5ICptZW0sIG9mZl90IHBnX3N0YXJ0LCBpbnQgdHlwZSkNCiB7DQog
CXNpemVfdCBpOw0KIAl1MzIgKmdwOw0KKwlpbnQgbWFza190eXBlOw0KKw0KKwlpZiAodHlwZSAh
PSBtZW0tPnR5cGUpDQorCQlyZXR1cm4gLUVJTlZBTDsNCiANCi0JaWYgKHR5cGUgIT0gMCB8fCBt
ZW0tPnR5cGUgIT0gMCkNCisJbWFza190eXBlID0gYWdwX2JyaWRnZS0+ZHJpdmVyLT5hZ3BfdHlw
ZV90b19tYXNrX3R5cGUoYWdwX2JyaWRnZSwgdHlwZSk7DQorCWlmIChtYXNrX3R5cGUgIT0gMCkg
ew0KIAkJLyogV2Uga25vdyBub3RoaW5nIG9mIG1lbW9yeSB0eXBlcyAqLw0KIAkJcmV0dXJuIC1F
SU5WQUw7DQorCX0NCisNCisJaWYgKG1lbS0+cGFnZV9jb3VudCA9PSAwKQ0KKwkJcmV0dXJuIDA7
DQogDQogCWdwID0gKHUzMiAqKSAmYWdwX2JyaWRnZS0+Z2F0dF90YWJsZVtwZ19zdGFydF07DQog
CWZvciAoaSA9IDA7IGkgPCBtZW0tPnBhZ2VfY291bnQ7ICsraSkNCi0tIA0KMS42LjMuMw0KDQo=


--=-ARB5HCMANhLcJW9co1jp--
