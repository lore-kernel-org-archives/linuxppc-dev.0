From: David Given <dg@tao-group.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: ATI Rage Pro 128 TR
Date: Mon, 21 Jan 2002 18:40:44 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_W7XA5540W9A0DH89J7KZ"
Message-Id: <E16SjNP-0003T5-00@rhodium.tao.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--------------Boundary-00=_W7XA5540W9A0DH89J7KZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


A while back I posted that I was having problems getting the video to wor=
k on=20
our new iMac, a blue CDROM version (how do I work out what it *actually*=20
is?). It uses a Rage Pro 128 TR video card, that the kernel didn't know a=
bout.

Well, I found a patch for an ancient 2.4 kernel that claimed to supported=
 it,=20
hacked it into 2.4.17, cleaned it up etc, and here it is. Attached.

There still appear to be some problems, but that may be because I'm not=20
working it correctly. Most screen modes make the screen go black; I suspe=
ct=20
that the monitor's really a fixed-sync. DirectFB programs cause certain=20
programs, like syslogd, do go into D state --- I haven't worked out why y=
et.=20
OTOH, this could be because DirectFB is trying to hardware accelerate the=
=20
card. However, leaving the standard screen mode and just changing depth w=
orks=20
fine.

I noticed that somebody else was having problems with iMac video --- perh=
aps=20
this will help.

On a related note, is there a program that will reset the console back to=
=20
text mode if my application crashes and leaves it in graphics mode anywhe=
re?

In related news, my earlier problem about strange SIGFPEs for no apparent=
=20
reason may be an artifact of my slighty dodgy userland threading code ---=
 it=20
uses sys_sigreturn to change the register set of the process. Because MSR=
=20
isn't available from userland, I was just assuming 0; this wouldn't cause=
 a=20
problem anyway because the only bits I can change are FE0 and FE1 anyway,=
 and=20
my app doesn't use floating point, right? Yeah, right.

Anyone know how I can read the current values of FE0 and FE1 from userlan=
d?

- --=20
David Given
dg@tao-group.com


--------------Boundary-00=_W7XA5540W9A0DH89J7KZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch"

ZGlmZiAtdU5yIGxpbnV4Lm9yaWcvZHJpdmVycy92aWRlby9hdHkxMjhmYi5jIGxpbnV4L2RyaXZl
cnMvdmlkZW8vYXR5MTI4ZmIuYwotLS0gbGludXgub3JpZy9kcml2ZXJzL3ZpZGVvL2F0eTEyOGZi
LmMJU3VuIE5vdiAxMSAxODowOTozNyAyMDAxCisrKyBsaW51eC9kcml2ZXJzL3ZpZGVvL2F0eTEy
OGZiLmMJTW9uIEphbiAyMSAxMTo1NjowNSAyMDAyCkBAIC0xNTQsNiArMTU0LDcgQEAKICAgICB7
IlJhZ2UxMjggUkwgKEFHUCkiLCBQQ0lfREVWSUNFX0lEX0FUSV9SQUdFMTI4X1JMLCByYWdlXzEy
OH0sCiAgICAgeyJSYWdlMTI4IFBybyBQRiAoQUdQKSIsIFBDSV9ERVZJQ0VfSURfQVRJX1JBR0Ux
MjhfUEYsIHJhZ2VfMTI4X3Byb30sCiAgICAgeyJSYWdlMTI4IFBybyBQUiAoUENJKSIsIFBDSV9E
RVZJQ0VfSURfQVRJX1JBR0UxMjhfUFIsIHJhZ2VfMTI4X3Byb30sCisgICAgeyJSYWdlMTI4IFBy
byBUUiAoQUdQKSIsIFBDSV9ERVZJQ0VfSURfQVRJX1JBR0UxMjhfVFIsIHJhZ2VfMTI4X3Byb30s
CiAgICAgeyJSYWdlIE1vYmlsaXR5IE0zIChQQ0kpIiwgUENJX0RFVklDRV9JRF9BVElfUkFHRTEy
OF9MRSwgcmFnZV9NM30sCiAgICAgeyJSYWdlIE1vYmlsaXR5IE0zIChBR1ApIiwgUENJX0RFVklD
RV9JRF9BVElfUkFHRTEyOF9MRiwgcmFnZV9NM30sCiAgICAge05VTEwsIDAsIHJhZ2VfMTI4fQpA
QCAtMTY0NSw2ICsxNjQ2LDcgQEAKICAgICAgICAgICAgIHVuc2lnbmVkIGludCB2bW9kZSA9IHNp
bXBsZV9zdHJ0b3VsKHRoaXNfb3B0KzYsIE5VTEwsIDApOwogICAgICAgICAgICAgaWYgKHZtb2Rl
ID4gMCAmJiB2bW9kZSA8PSBWTU9ERV9NQVgpCiAgICAgICAgICAgICAgICAgZGVmYXVsdF92bW9k
ZSA9IHZtb2RlOworCiAgICAgICAgIH0gZWxzZSBpZiAoIXN0cm5jbXAodGhpc19vcHQsICJjbW9k
ZToiLCA2KSkgewogICAgICAgICAgICAgdW5zaWduZWQgaW50IGNtb2RlID0gc2ltcGxlX3N0cnRv
dWwodGhpc19vcHQrNiwgTlVMTCwgMCk7CiAgICAgICAgICAgICBzd2l0Y2ggKGNtb2RlKSB7CkBA
IC0xNzIzLDYgKzE3MjUsMjggQEAKICAgICAgICAgfSBlbHNlIHsKICAgICAgICAgICAgIGlmIChk
ZWZhdWx0X3Ztb2RlIDw9IDAgfHwgZGVmYXVsdF92bW9kZSA+IFZNT0RFX01BWCkKICAgICAgICAg
ICAgICAgICBkZWZhdWx0X3Ztb2RlID0gVk1PREVfMTAyNF83NjhfNjA7CisKKwkgICAgLyogaU1h
Y3MgbmVlZCB0aGF0IHJlc29sdXRpb24KKwkgICAgICogUG93ZXJNYWMyLDEgZmlyc3QgcjEyOCBp
TWFjcworCSAgICAgKiBQb3dlck1hYzIsMiBzdW1tZXIgMjAwMCBpTWFjcworCSAgICAgKiBQb3dl
ck1hYzQsMSBqYW51YXIgMjAwMSBpTWFjcyAiZmxvd2VyIHBvd2VyIgorCSAgICAgKi8KKwkgICAg
aWYgKG1hY2hpbmVfaXNfY29tcGF0aWJsZSgiUG93ZXJNYWMyLDEiKSB8fAorCQltYWNoaW5lX2lz
X2NvbXBhdGlibGUoIlBvd2VyTWFjMiwyIikgfHwKKwkJbWFjaGluZV9pc19jb21wYXRpYmxlKCJQ
b3dlck1hYzQsMSIpKQorCQlkZWZhdWx0X3Ztb2RlID0gVk1PREVfMTAyNF83NjhfNzU7CisKKwkg
ICAgLyogUG93ZXJCb29rIEZpcmV3aXJlIChQaXNtbykgKi8KKwkgICAgaWYgKG1hY2hpbmVfaXNf
Y29tcGF0aWJsZSgiUG93ZXJCb29rMywxIikpCisJCWRlZmF1bHRfdm1vZGUgPSBWTU9ERV8xMDI0
Xzc2OF82MDsKKworCSAgICAvKiBQb3dlckJvb2sgVGl0YW5pdW0gKi8KKwkgICAgaWYgKG1hY2hp
bmVfaXNfY29tcGF0aWJsZSgiUG93ZXJCb29rMywyIikpCisJCWRlZmF1bHRfdm1vZGUgPSBWTU9E
RV8xMTUyXzc2OF82MDsKKworCSAgICAvKiBpQm9vayBGaXJld2lyZSAqLworCSAgICBpZiAobWFj
aGluZV9pc19jb21wYXRpYmxlKCJQb3dlckJvb2syLDIiKSkKKwkJZGVmYXVsdF92bW9kZSA9IFZN
T0RFXzgwMF82MDBfNjA7CiAKICAgICAgICAgICAgIGlmIChkZWZhdWx0X2Ntb2RlIDwgQ01PREVf
OCB8fCBkZWZhdWx0X2Ntb2RlID4gQ01PREVfMzIpCiAgICAgICAgICAgICAgICAgZGVmYXVsdF9j
bW9kZSA9IENNT0RFXzg7Cg==

--------------Boundary-00=_W7XA5540W9A0DH89J7KZ--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
