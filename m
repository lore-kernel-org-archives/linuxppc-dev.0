From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: "'Troy Benjegerdes'" <hozer@drgw.net>,
	<linuxppc-embedded@lists.linuxppc.org>, <paulus@samba.org>,
	Gabriel Paubert <paubert@iram.es>
Subject: RE: Bogomips and loops_per_jiffy
Date: Wed, 8 May 2002 19:43:02 +0200
Message-Id: <20020508174302.29360@smtp.wanadoo.fr>
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFFA000@mail.mediatrix.com>
References: <F1BED55F35F4D3118C0F00E0295CFF4DFFA000@mail.mediatrix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==_20020508174302.8887-1_=="
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--==_20020508174302.8887-1_==
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Paul & Gabriel !

We indeed have some weird stuff mixing signed & unsigned in the
arch/ppc/kernel/time.c code. The patch enclosed, from Jean-Denis
Boyer, seems the right fix, except for one thing: I'd rather
change the test from >=3D to > (which in the old could would mean
changing the while (... < 0 to <=3D 0) as I see no reason to trigger
a new decrementer interrupt in ... 0 ticks !

Can you confirm it's ok to push =3F

Regards,
Ben.

>
>Troy,
>with the patch, now, it completely hangs.
>The reason is that in timer=5Finterrupt()
>
>=09while ((next=5Fdec =3D tb=5Fticks=5Fper=5Fjiffy - =
tb=5Fdelta(&jiffy=5Fstamp)) < 0)
>{
>
>Now that next=5Fdec is unsigned, this condition is always false.
>
>Here is another patch I suggest to replace yours.
>Its in attachement to this email.
>I tested it, and it seems OK.
>
>I did not include your modification made to the type of local variables in
>function do=5Fsettimeofday().
>I do not see how it is related to our problem.
>
>
>--------------------------------------------
> Jean-Denis Boyer, B.Eng., System Architect
> Mediatrix Telecom Inc.
> 4229 Garlock Street
> Sherbrooke (Qu=E9bec)
> J1L 2C8  CANADA
> (819)829-8749 x241
>--------------------------------------------
>

--==_20020508174302.8887-1_==
Content-Type: application/binary; name="patch.time.2";
 x-mac-type="3F3F3F3F"; x-mac-creator="3F3F3F3F"
Content-Disposition: attachment
Content-Transfer-Encoding: base64

LS0tIEtlcm5lbC5vcmlnL2FyY2gvcHBjL2tlcm5lbC90aW1lLmMJTW9uIEFwciAyMiAxMjox
OTowNSAyMDAyCisrKyBLZXJuZWwvYXJjaC9wcGMva2VybmVsL3RpbWUuYwlXZWQgTWF5ICA4
IDEyOjQ2OjU3IDIwMDIKQEAgLTk5LDggKzk5LDggQEAKIEVYUE9SVF9TWU1CT0wocnRjX2xv
Y2spOwogCiAvKiBUaW1lciBpbnRlcnJ1cHQgaGVscGVyIGZ1bmN0aW9uICovCi1zdGF0aWMg
aW5saW5lIGludCB0Yl9kZWx0YSh1bnNpZ25lZCAqamlmZnlfc3RhbXApIHsKLQlpbnQgZGVs
dGE7CitzdGF0aWMgaW5saW5lIHVuc2lnbmVkIHRiX2RlbHRhKHVuc2lnbmVkICpqaWZmeV9z
dGFtcCkgeworCXVuc2lnbmVkIGRlbHRhOwogCWlmIChfX1VTRV9SVEMoKSkgewogCQlkZWx0
YSA9IGdldF9ydGNsKCk7CiAJCWlmIChkZWx0YSA8ICpqaWZmeV9zdGFtcCkgKmppZmZ5X3N0
YW1wIC09IDEwMDAwMDAwMDA7CkBAIC0xNTAsNyArMTUwLDcgQEAKICAqLwogaW50IHRpbWVy
X2ludGVycnVwdChzdHJ1Y3QgcHRfcmVncyAqIHJlZ3MpCiB7Ci0JaW50IG5leHRfZGVjOwor
CXVuc2lnbmVkIG5leHRfZGVjOwogCXVuc2lnbmVkIGxvbmcgY3B1ID0gc21wX3Byb2Nlc3Nv
cl9pZCgpOwogCXVuc2lnbmVkIGppZmZ5X3N0YW1wID0gbGFzdF9qaWZmeV9zdGFtcChjcHUp
OwogCWV4dGVybiB2b2lkIGRvX0lSUShzdHJ1Y3QgcHRfcmVncyAqKTsKQEAgLTE2MCw3ICsx
NjAsMTMgQEAKIAogCWhhcmRpcnFfZW50ZXIoY3B1KTsKIAkKLQl3aGlsZSAoKG5leHRfZGVj
ID0gdGJfdGlja3NfcGVyX2ppZmZ5IC0gdGJfZGVsdGEoJmppZmZ5X3N0YW1wKSkgPCAwKSB7
CisJd2hpbGUoMSkgeworCQl1bnNpZ25lZCBkZWx0YSA9IHRiX2RlbHRhKCZqaWZmeV9zdGFt
cCk7CisJCWlmKHRiX3RpY2tzX3Blcl9qaWZmeSA+PSBkZWx0YSkgeworCQkJbmV4dF9kZWMg
PSB0Yl90aWNrc19wZXJfamlmZnkgLSBkZWx0YTsKKwkJCWJyZWFrOworCQl9CisKIAkJamlm
Znlfc3RhbXAgKz0gdGJfdGlja3NfcGVyX2ppZmZ5OwogCQlpZiAoIXVzZXJfbW9kZShyZWdz
KSkKIAkJCXBwY19kb19wcm9maWxlKGluc3RydWN0aW9uX3BvaW50ZXIocmVncykpOwo=
--==_20020508174302.8887-1_==--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
