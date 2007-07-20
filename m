Return-Path: <jdboyer@mediatrix.com>
Received: from MAIL1.mediatrix.com (mail1.mediatrix.com [207.134.65.15])
	by ozlabs.org (Postfix) with ESMTP id 376E5DDED0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jul 2007 02:20:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7CAE8.2600868C"
Subject: Bug in PowerPC math emulator (stfiwx)
Date: Fri, 20 Jul 2007 12:07:40 -0400
Message-ID: <6C7A33B8773A2E4C9BDF935D13FA3E71C2B2B6@MAIL1.mediatrix.com>
From: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
To: <linuxppc-embedded@ozlabs.org>
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

------_=_NextPart_001_01C7CAE8.2600868C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,

I encountered a problem while running "valgrind" on my 8323E based
system, running kernel 2.6.19.7. My userland program performs a few
floating point operations at initialization, which is normally handled
by the math emulator. But when running it through valgrind, the VEX will
"regenerate" code dynamically, and internally uses instruction "stfiwx".
Here is a disassembly of that instruction taken from gdb.

	0x42336e64:     stfiwx  f15,0,r1

Although this instruction is valid, the math-emulator rejects it as
invalid. I looked into arch/powerpc/math-emu/math.c, and this is caused
by the second argument which is 0 (rA=3D0).

In fact, it appears to me that the case XE and XEU are swapped. The
argument rA=3D0 is invalid for the instructions which updates rA after
computing the effective address, but this is checked in the XE case
instead of XEU.

In attachement, there is a patch for this. The valgrind is very happy
with it now.

There is also a test program (fputest.c) which no longer produces a
SIGILL with the patch.


P.S.: Please CC me cause I'm not on your mailing list.

Sincerely,

Jean-Denis Boyer, Eng.
Mediatrix Telecom, a division of Media5 Corporation
(819)829-8749 x241=20

------_=_NextPart_001_01C7CAE8.2600868C
Content-Type: application/octet-stream;
	name="math.patch"
Content-Transfer-Encoding: base64
Content-Description: math.patch
Content-Disposition: attachment;
	filename="math.patch"

LS0tIGxpbnV4Lm9yaWcvYXJjaC9wb3dlcnBjL21hdGgtZW11L21hdGguYwkyMDA2LTExLTI5IDE2
OjU3OjM3LjAwMDAwMDAwMCAtMDUwMAorKysgbGludXgvYXJjaC9wb3dlcnBjL21hdGgtZW11L21h
dGguYwkyMDA3LTA3LTIwIDExOjU1OjMwLjAwMDAwMDAwMCAtMDQwMApAQCAtNDA1LDcgKzQwNSw3
IEBACiAJCW9wMSA9ICh2b2lkICopJmN1cnJlbnQtPnRocmVhZC5mcHJbKGluc24gPj4gMTEpICYg
MHgxZl07CiAJCWJyZWFrOwogCi0JY2FzZSBYRToKKwljYXNlIFhFVToKIAkJaWR4ID0gKGluc24g
Pj4gMTYpICYgMHgxZjsKIAkJaWYgKCFpZHgpCiAJCQlnb3RvIGlsbGVnYWw7CkBAIC00MTQsNyAr
NDE0LDcgQEAKIAkJb3AxID0gKHZvaWQgKikocmVncy0+Z3ByW2lkeF0gKyByZWdzLT5ncHJbKGlu
c24gPj4gMTEpICYgMHgxZl0pOwogCQlicmVhazsKIAotCWNhc2UgWEVVOgorCWNhc2UgWEU6CiAJ
CWlkeCA9IChpbnNuID4+IDE2KSAmIDB4MWY7CiAJCW9wMCA9ICh2b2lkICopJmN1cnJlbnQtPnRo
cmVhZC5mcHJbKGluc24gPj4gMjEpICYgMHgxZl07CiAJCW9wMSA9ICh2b2lkICopKChpZHggPyBy
ZWdzLT5ncHJbaWR4XSA6IDApCg==

------_=_NextPart_001_01C7CAE8.2600868C
Content-Type: application/octet-stream;
	name="fputest.c"
Content-Transfer-Encoding: base64
Content-Description: fputest.c
Content-Disposition: attachment;
	filename="fputest.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CgppbnQgbWFpbigpCnsKICAgIGludCBpLCAqcDsKICAgIHAgPSAm
aTsKCglhc20gdm9sYXRpbGUoInN0Zml3eCAgMTUsMCwlMCIgOiAiPXIiKHApKTsKCiAgICBwcmlu
dGYoIiVkXG4iLCBpKTsKCXJldHVybiAwOwp9Cgo=

------_=_NextPart_001_01C7CAE8.2600868C--
