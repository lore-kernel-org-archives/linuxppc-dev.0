From: xiaogeng_jin@agilent.com
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4271E.AB5B5831"
Subject: [Patch] i2c-algo-8240.c: no ack in m8240_readbytes()
Date: Tue, 20 Apr 2004 15:30:15 -0600
Message-ID: <3236F92B82933347807DFF6A8BA63280143104@wcosmb04.cos.agilent.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------_=_NextPart_001_01C4271E.AB5B5831
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Wolfgang,

I had the following problem when using i2c-algo-8240 module on MPC8245 =
and fixed it by the attached patch. The problem is that no ACK is =
generated after each byte is received by the master (the i2c interface =
of MPC8245). And the solution is to clear TXAK after each =
m8240_iic_read() in m8240_readbytes(). Also during initialization TXAK =
is cleared.

BTW, I'm not sure if the problem exists in MPC8240. I don't have 8240 to =
test.

> However I have some problem using this module on my custom=20
> MPC8245 board. There is no problem for write. Data seems to=20
> be written into SEEPROM. The following message is captured by=20
> the i2c monitor.
> Msg     3 [Start]#A0[W][A]00[A]00[A]01[A]02[A]03[A]04[A][Stop]
>=20
> But for read, only the first byte is returned when I try to=20
> read multiple bytes. The following messages show that I try=20
> to read 4 bytes at the beginning of SEEPROM.
> Msg    14 [Start]#A0[W][A]00[A]00[A][Stop]
> Msg    15 [Start]#A0[R][A]01[N]FF[N]FF[N]FF[N]FF[N][Stop]
>=20
> I suspect that the i2c controller doesn't generate the ack=20
> bit, which is supposed to do so. Why does the controller=20
> generate ACK automatically for write operations but not for=20
> read operations?
>=20

Regards,
-Shawn.

------_=_NextPart_001_01C4271E.AB5B5831
Content-Type: application/octet-stream;
	name="i2c-algo-8240.patch"
Content-Transfer-Encoding: base64
Content-Description: i2c-algo-8240.patch
Content-Disposition: attachment;
	filename="i2c-algo-8240.patch"

LS0tIGRlbngvbGludXhwcGNfMl80X2RldmVsL2RyaXZlcnMvaTJjL2kyYy1hbGdvLTgyNDAuYwlU
dWUgRGVjIDMwIDAyOjQ4OjQyIDIwMDMKKysrIGxpbnV4cHBjXzJfNF9kZXZlbC9kcml2ZXJzL2ky
Yy9pMmMtYWxnby04MjQwLmMJVHVlIEFwciAyMCAxNDoxNjoxOCAyMDA0CkBAIC0yODksNiArMjg5
LDcgQEAKIAogCWZvciAoaSA9IDA7IGkgPCBjb3VudDsgKytpKSB7CiAJCWJ1ZltyZGNvdW50XSA9
IG04MjQwX2lpY19yZWFkKCZpMmMtPmkyY2RyKTsKKwkJbTgyNDBfaWljX3dyaXRlKCZpMmMtPmky
Y2NyLCB+TTgyNDBfSTJDQ1JfVFhBSywgTTgyNDBfSTJDQ1JfVFhBSyk7CiAJCWlmIChkdW1teSkg
ewogCQkJZHVtbXkgPSAwOwogCQl9IGVsc2UgewpAQCAtMzEwLDcgKzMxMSw3IEBACiAJCXByaW50
ayhLRVJOX0lORk8gImkyYy1hbGdvLTgyNDAubzogaTJjX3JlYWQ6IGkyY19pbmIgdGltZWQgb3V0
LlxuIik7CiAJCXJldHVybiAtRVJFTU9URUlPOwogCX0KLSAgICAKKwogCXJldHVybiByZGNvdW50
OwogfQogCi0tLSBkZW54L2xpbnV4cHBjXzJfNF9kZXZlbC9pbmNsdWRlL2xpbnV4L2kyYy1hbGdv
LTgyNDAuaAlXZWQgRGVjICAzIDExOjIyOjA2IDIwMDMKKysrIGxpbnV4cHBjXzJfNF9kZXZlbC9p
bmNsdWRlL2xpbnV4L2kyYy1hbGdvLTgyNDAuaAlUaHUgQXByIDE1IDE3OjMwOjE4IDIwMDQKQEAg
LTMwLDExICszMCwxNiBAQAogI2RlZmluZSBJMkNfQUxHT184MjQwX0ggMQogCiAjaW5jbHVkZSA8
bGludXgvaTJjLmg+CisjaW5jbHVkZSA8bGludXgvY29uZmlnLmg+CiAKICNkZWZpbmUgTTgyNDBf
STJDX09GRlNFVCAgMHgzMDAwCiAjZGVmaW5lIE04MjQwX0kyQ19TSVpFICAgIDB4MTAwMAogCisj
aWZuZGVmIENPTkZJR19FUDgyNDUKICNkZWZpbmUgTTgyNDBfSVJRX0kyQyAgICAgMTYKKyNlbHNl
CisjZGVmaW5lIE04MjQwX0lSUV9JMkMgICAgIDYKKyNlbmRpZgogCiB0eXBlZGVmIHN0cnVjdCBp
MmNfODI0MF9zCiB7CkBAIC02Myw3ICs2OCw3IEBACiAjZGVmaW5lIE04MjQwX0kyQ0NSX01JRU4g
ICAgICAgMHgwMDAwMDA0MAogI2RlZmluZSBNODI0MF9JMkNDUl9NRU4gICAgICAgIDB4MDAwMDAw
ODAKIAotI2RlZmluZSBNODI0MF9JMkNDUl9JTklUX01BU0sgIChNODI0MF9JMkNDUl9NRU4gfCBN
ODI0MF9JMkNDUl9NU1RBIHwgXAorI2RlZmluZSBNODI0MF9JMkNDUl9JTklUX01BU0sgIChNODI0
MF9JMkNDUl9NRU4gfCBNODI0MF9JMkNDUl9NU1RBIHwgTTgyNDBfSTJDQ1JfVFhBSyB8IFwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTTgyNDBfSTJDQ1JfTVRYIHwgTTgyNDBfSTJD
Q1JfUlNUQSkKIAogCS8qIERlZmluZXMgZm9yIHRoZSBJMkMgU3RhdHVzIFJlZ2lzdGVyCg==

------_=_NextPart_001_01C4271E.AB5B5831--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
