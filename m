Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 042C567B2B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Apr 2005 00:40:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C53EA4.65523A50"
Date: Mon, 11 Apr 2005 09:40:24 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859355@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Stefan Nickl" <Stefan.Nickl@kontron.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH] RE: FCC Ethernet startup crash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C53EA4.65523A50
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Found a soulution.
Still have no idea about the cause.

The part that had to be called twice toget the ethernet to work was=20

	/* Enable transmit/receive */
	fccp->fcc_gfmr |=3D FCC_GFMR_ENR | FCC_GFMR_ENT;

So I added that to the end of init_fcc_startup(), and kept the rest of
the patch the same as v1 (or v2)
None of the interrupts are enabled at this time, so any spurious packets
will not get reported up to IP layer anyways.

This works on my hardware. (tested with ping -f)

Signed-off-by: Rune Torgersen <runet@innovsys.com>

------_=_NextPart_001_01C53EA4.65523A50
Content-Type: application/octet-stream; name="fcc_enet_startup_crash_v4.patch"
Content-Transfer-Encoding: base64
Content-Description: fcc_enet_startup_crash_v4.patch
Content-Disposition: attachment;
	filename="fcc_enet_startup_crash_v4.patch"

PT09PT0gYXJjaC9wcGMvODI2MF9pby9mY2NfZW5ldC5jIDEuMjQgdnMgZWRpdGVkID09PT09Ci0t
LSAxLjI0L2FyY2gvcHBjLzgyNjBfaW8vZmNjX2VuZXQuYwkyMDA1LTAzLTE4IDE0OjUxOjMxIC0w
NjowMAorKysgZWRpdGVkL2FyY2gvcHBjLzgyNjBfaW8vZmNjX2VuZXQuYwkyMDA1LTA0LTExIDA5
OjM0OjEwIC0wNTowMApAQCAtMjE1OSwxNSArMjE1OSw4IEBACiAJKih2b2xhdGlsZSB1aW50ICop
KEJDU1JfQUREUiArIDEyKSB8PSAgQkNTUjNfRkVUSDJfUlNUOwogI2VuZGlmCiAKLSNpZiBkZWZp
bmVkKENPTkZJR19VU0VfTURJTykgfHwgZGVmaW5lZChDT05GSUdfVFFNODI2MCkKLQkvKiBzdGFy
dCBpbiBmdWxsIGR1cGxleCBtb2RlLCBhbmQgbmVnb3RpYXRlIHNwZWVkCi0JICovCi0JZmNjX3Jl
c3RhcnQgKGRldiwgMSk7Ci0jZWxzZQotCS8qIHN0YXJ0IGluIGhhbGYgZHVwbGV4IG1vZGUKLQkg
Ki8KLQlmY2NfcmVzdGFydCAoZGV2LCAwKTsKLSNlbmRpZgorCS8qIEVuYWJsZSB0cmFuc21pdC9y
ZWNlaXZlICovCisJZmNjcC0+ZmNjX2dmbXIgfD0gRkNDX0dGTVJfRU5SIHwgRkNDX0dGTVJfRU5U
OwogfQogCiAjaWZkZWYJQ09ORklHX1VTRV9NRElPCkBAIC0yMzcyLDI0ICsyMzY1LDI4IEBACiAJ
ZmVwLT5zZXF1ZW5jZV9kb25lID0gMDsKIAlmZXAtPmxpbmsgPSAwOwogCi0JaWYgKGZlcC0+cGh5
KSB7Ci0JCWZjY19yZXN0YXJ0KGRldiwgMCk7CS8qIGFsd2F5cyBzdGFydCBpbiBoYWxmLWR1cGxl
eCAqLwotCQltaWlfZG9fY21kKGRldiwgZmVwLT5waHktPmFja19pbnQpOwotCQltaWlfZG9fY21k
KGRldiwgZmVwLT5waHktPmNvbmZpZyk7Ci0JCW1paV9kb19jbWQoZGV2LCBwaHlfY21kX2NvbmZp
Zyk7ICAvKiBkaXNwbGF5IGNvbmZpZ3VyYXRpb24gKi8KLQkJd2hpbGUoIWZlcC0+c2VxdWVuY2Vf
ZG9uZSkKLQkJCXNjaGVkdWxlKCk7Ci0KLQkJbWlpX2RvX2NtZChkZXYsIGZlcC0+cGh5LT5zdGFy
dHVwKTsKLQkJbmV0aWZfc3RhcnRfcXVldWUoZGV2KTsKLQkJcmV0dXJuIDA7CQkvKiBTdWNjZXNz
ICovCi0JfQotCXJldHVybiAtRU5PREVWOwkJLyogTm8gUEhZIHdlIHVuZGVyc3RhbmQgKi8KKwlp
ZiAoIWZlcC0+cGh5KQorCQlyZXR1cm4gLUVOT0RFVjsJCS8qIE5vIFBIWSB3ZSB1bmRlcnN0YW5k
ICovCisKKwltaWlfZG9fY21kKGRldiwgZmVwLT5waHktPmFja19pbnQpOworCW1paV9kb19jbWQo
ZGV2LCBmZXAtPnBoeS0+Y29uZmlnKTsKKwltaWlfZG9fY21kKGRldiwgcGh5X2NtZF9jb25maWcp
OyAgLyogZGlzcGxheSBjb25maWd1cmF0aW9uICovCisJd2hpbGUoIWZlcC0+c2VxdWVuY2VfZG9u
ZSkKKwkJc2NoZWR1bGUoKTsKKworCW1paV9kb19jbWQoZGV2LCBmZXAtPnBoeS0+c3RhcnR1cCk7
CiAjZWxzZQogCWZlcC0+bGluayA9IDE7Ci0JZmNjX3Jlc3RhcnQoZGV2LCAwKTsJLyogYWx3YXlz
IHN0YXJ0IGluIGhhbGYtZHVwbGV4ICovCi0JbmV0aWZfc3RhcnRfcXVldWUoZGV2KTsKLQlyZXR1
cm4gMDsJCQkJCS8qIEFsd2F5cyBzdWNjZWVkICovCiAjZW5kaWYJLyogQ09ORklHX1VTRV9NRElP
ICovCisKKwluZXRpZl9zdGFydF9xdWV1ZShkZXYpOworCisjaWYgZGVmaW5lZChDT05GSUdfVVNF
X01ESU8pIHx8IGRlZmluZWQoQ09ORklHX1RRTTgyNjApCisJZmNjX3Jlc3RhcnQgKGRldiwgMSk7
CS8qIHN0YXJ0IGluIGZ1bGwgZHVwbGV4IG1vZGUgKi8KKyNlbHNlCisJZmNjX3Jlc3RhcnQgKGRl
diwgMCk7CS8qIHN0YXJ0IGluIGhhbGYgZHVwbGV4IG1vZGUgKi8KKyNlbmRpZgorCisJcmV0dXJu
IDA7CQkvKiBBbHdheXMgc3VjY2VlZCAqLwogfQogCg==

------_=_NextPart_001_01C53EA4.65523A50--
