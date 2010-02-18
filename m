Return-Path: <android.anand@gmail.com>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id F36AAB7CD5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Feb 2010 22:15:33 +1100 (EST)
Received: by ywh37 with SMTP id 37so926177ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Feb 2010 03:15:31 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 18 Feb 2010 16:45:31 +0530
Message-ID: <7d50427c1002180315k38a35182s9532eedd107e5fed@mail.gmail.com>
Subject: Reading command line args from assmebly
From: Anand Android <android.anand@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary=001636c92bb6c4a3db047fde1521
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636c92bb6c4a3db047fde1521
Content-Type: multipart/alternative; boundary=001636c92bb6c4a3d2047fde151f

--001636c92bb6c4a3d2047fde151f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi All,
I have written one sample assmebly and c code which reads command line args
and displays .

find the source files as attachments.

expected output is ,
        $ ./a.out
           Inside __linker_init argc =3D 1
           Inside __linker_init argv[0] =3D ./a.out
           Segmentation fault [Seg fault Never mind]

if i statically link startx86.S  & linker.c  on x86 AND statrt_ppc.S &
linker.c on PS3,i'll get SEGV fault on both system. But on PS3, inside
'_start' function if i verify the contents of 'r1[stack pointer]' and '(Cha=
r
*) *(r1 + 4)'  in GDB i get '1' and '~/a.out' respectively .But once 'r1'
moved to r3[holds the 1st arg of the function] & passed as argument to
__linker_init ,inside the function '*elfdata' points '1' but (char *)
*(elfdata + 1) points to some junk string. some thing like this
"|c\033x|i\003=EF=BF=BDN\200\004 \224!=EF=BF=BD=EF=BF=BD|\b\002=EF=BF=BD\22=
0\001".
find the GDB log file of PS3.

if i link them without statically,i'll get the correct output on x86 .i.e

        $ ./a.out
           Inside __linker_init argc =3D 1
           Inside __linker_init argv[0] =3D ./a.out
           Segmentation fault [Seg fault Never mind]

but  on ps3 i get this,
        $ ./a.out
           Inside __linker_init argc =3D 0
           Inside __linker_init argv[0] =3D |c|i=EF=BF=BDN=EF=BF=BD =EF=BF=
=BD!=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD
           Segmentation fault
Why am i getting strange characters instead of './a.out' and y 'argc' havin=
g
'zero'  ?

Why is this two different outputs for static linking and dynamic linking ?

-Anand

--001636c92bb6c4a3d2047fde151f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi All,<br>
I have written one sample assmebly and c code which reads command line args=
 and displays .<br>
<br>
find the source files as attachments.<br>
<br>
expected output is ,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ ./a.out<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Inside __linke=
r_init argc =3D 1<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Inside __linke=
r_init argv[0] =3D ./a.out<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Segmentation f=
ault [Seg fault Never mind]<br>

<br>
if i statically link startx86.S=C2=A0 &amp; linker.c=C2=A0 on x86 AND
statrt_ppc.S &amp; linker.c on PS3,i&#39;ll get SEGV fault on both system.
But on PS3, inside &#39;_start&#39; function if i verify the contents of
&#39;r1[stack pointer]&#39; and &#39;(Char *) *(r1 + 4)&#39;=C2=A0 in GDB i=
 get &#39;1&#39; and
&#39;~/a.out&#39; respectively .But once &#39;r1&#39; moved to r3[holds the=
 1st arg of
the function] &amp; passed as argument to __linker_init ,inside the
function &#39;*elfdata&#39; points &#39;1&#39; but (char *) *(elfdata + 1) =
points to
some junk string. some thing like this &quot;|c\033x|i\003=EF=BF=BDN\200\00=
4
\224!=EF=BF=BD=EF=BF=BD|\b\002=EF=BF=BD\220\001&quot;.<br>

find the GDB log file of PS3.<br>
<br>
if i link them without statically,i&#39;ll get the correct output on x86 .i=
.e<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ ./a.out<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Inside __linke=
r_init argc =3D 1<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Inside __linke=
r_init argv[0] =3D ./a.out<br>

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Segmentation f=
ault [Seg fault Never mind]<br>
<br>
but=C2=A0 on ps3 i get this,<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ ./a.out<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Inside __linke=
r_init argc =3D 0<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Inside __linke=
r_init argv[0] =3D |c|i=EF=BF=BDN=EF=BF=BD =EF=BF=BD!=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Segmentation f=
ault<br>

Why am i getting strange characters instead of &#39;./a.out&#39; and y &#39=
;argc&#39; having &#39;zero&#39;=C2=A0 ?<br>
<br>
Why is this two different outputs for static linking and dynamic linking ?<=
br>
<br>
-Anand<br>
<br>

--001636c92bb6c4a3d2047fde151f--

--001636c92bb6c4a3db047fde1521
Content-Type: text/plain; charset=UTF-8; name="gdb.txt"
Content-Disposition: attachment; filename="gdb.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5tggutw0

VGhpcyBHREIgd2FzIGNvbmZpZ3VyZWQgYXMgInBvd2VycGMtbGludXgtZ251Ii4uLiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAKKGdkYikgYiBfc3RhcnQKQnJlYWtwb2ludCAxIGF0IDB4MTAw
MDAwZTQ6IGZpbGUgc3RhcnQuUywgbGluZSAzNS4KKGdkYikgciAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAKU3RhcnRpbmcgcHJvZ3JhbTogL2hvbWUvZGF5YW5hbmRh
L2p1bmtzL3Bvd2VyL2Eub3V0CgpCcmVha3BvaW50IDEsIF9zdGFydCAoKSBhdCBzdGFydC5TOjM3
CjM3ICAgICAgICAgICAgICBibCAgICAgIF9fbGlua2VyX2luaXQKQ3VycmVudCBsYW5ndWFnZTog
IGF1dG87IGN1cnJlbnRseSBhc20KKGdkYikgcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAKX19saW5rZXJfaW5pdCAoZWxmZGF0YT0weDApIGF0IGxpbmtlci5jOjUKNSAgICAgICAgeyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAKQ3VycmVudCBsYW5ndWFnZTogIGF1dG87IGN1
cnJlbnRseSBjICAgICAKKGdkYikgaSByCnIwICAgICAgICAgICAgIDB4MCAgICAgIDAKcjEgICAg
ICAgICAgICAgMHhmZjlhMTgyMCAgICAgICA0Mjg4Mjg4ODAwCnIyICAgICAgICAgICAgIDB4MCAg
ICAgIDAKcjMgICAgICAgICAgICAgMHhmZjlhMTgyMCAgICAgICA0Mjg4Mjg4ODAwCnI0ICAgICAg
ICAgICAgIDB4MCAgICAgIDAKcjUgICAgICAgICAgICAgMHgwICAgICAgMApyNiAgICAgICAgICAg
ICAweDAgICAgICAwCnI3ICAgICAgICAgICAgIDB4MCAgICAgIDAKcjggICAgICAgICAgICAgMHgw
ICAgICAgMApyOSAgICAgICAgICAgICAweDAgICAgICAwCnIxMCAgICAgICAgICAgIDB4MCAgICAg
IDAKcjExICAgICAgICAgICAgMHgwICAgICAgMApyMTIgICAgICAgICAgICAweDAgICAgICAwCnIx
MyAgICAgICAgICAgIDB4MCAgICAgIDAKcjE0ICAgICAgICAgICAgMHgwICAgICAgMApyMTUgICAg
ICAgICAgICAweDAgICAgICAwCnIxNiAgICAgICAgICAgIDB4MCAgICAgIDAKcjE3ICAgICAgICAg
ICAgMHgwICAgICAgMApyMTggICAgICAgICAgICAweDAgICAgICAwCnIxOSAgICAgICAgICAgIDB4
MCAgICAgIDAKcjIwICAgICAgICAgICAgMHgwICAgICAgMApyMjEgICAgICAgICAgICAweDAgICAg
ICAwCnIyMiAgICAgICAgICAgIDB4MCAgICAgIDAKcjIzICAgICAgICAgICAgMHgwICAgICAgMApy
MjQgICAgICAgICAgICAweDAgICAgICAwCnIyNSAgICAgICAgICAgIDB4MCAgICAgIDAKcjI2ICAg
ICAgICAgICAgMHgwICAgICAgMApyMjcgICAgICAgICAgICAweDAgICAgICAwCnIyOCAgICAgICAg
ICAgIDB4MCAgICAgIDAKcjI5ICAgICAgICAgICAgMHgwICAgICAgMApyMzAgICAgICAgICAgICAw
eDAgICAgICAwCnIzMSAgICAgICAgICAgIDB4MCAgICAgIDAKcGMgICAgICAgICAgICAgMHgxMDAw
MDBmNCAgICAgICAyNjg0MzU3MDAKbXNyICAgICAgICAgICAgMHg0MDEwYzAzMiAgICAgICAxMDc0
ODM5NjAyCmNyICAgICAgICAgICAgIDB4MCAgICAgIDAKbHIgICAgICAgICAgICAgMHgxMDAwMDBl
OCAgICAgICAyNjg0MzU2ODgKY3RyICAgICAgICAgICAgMHgwICAgICAgMAp4ZXIgICAgICAgICAg
ICAweDAgICAgICAwCihnZGIpIHAgKigweGZmOWExODIwKQokMSA9IDEKKGdkYikgcCAqKDB4ZmY5
YTE4MjArNCkKJDIgPSAtNjY3ODE2OQooZ2RiKSBwIChjaGFyICopKigweGZmOWExODIwKzQpCiQz
ID0gMHhmZjlhMTk2NyAiL2hvbWUvZGF5YW5hbmRhL2p1bmtzL3Bvd2VyL2Eub3V0IgooZ2RiKSBz
CjcgICAgICAgICAgICAgICBpbnQgYXJnYyA9IChpbnQpICplbGZkYXRhOwooZ2RiKSBzCjggICAg
ICAgICAgICAgICBjaGFyICoqYXJndiA9IChjaGFyKiopIChlbGZkYXRhICsgMSk7CihnZGIpIHAg
ZWxmZGF0YQokNCA9ICh1bnNpZ25lZCBpbnQgKiopIDB4ZmY5YTE4MjAKKGdkYikgcCAqZWxmZGF0
YQokNSA9ICh1bnNpZ25lZCBpbnQgKikgMHgxCihnZGIpIHAgKihlbGZkYXRhICsgMSkKJDYgPSAo
dW5zaWduZWQgaW50ICopIDB4MTAwMDAwZTgKKGdkYikgcCAoY2hhciAqKSooZWxmZGF0YSArIDEp
CiQ3ID0gMHgxMDAwMDBlOCAifGNcMDMzeHxpXDAwM++/vU5cMjAwXDAwNCBcMjI0Ie+/ve+/vXxc
YlwwMDLvv71cMjIwXDAwMSIKCgo=
--001636c92bb6c4a3db047fde1521
Content-Type: application/octet-stream; name="linker.c"
Content-Disposition: attachment; filename="linker.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5tgguu11

DQojaW5jbHVkZTxzdGRpby5oPg0KDQoNCnVuc2lnbmVkIF9fbGlua2VyX2luaXQodW5zaWduZWQg
KiplbGZkYXRhKQ0KIHsNCiANCglpbnQgYXJnYyA9IChpbnQpICplbGZkYXRhOw0KCWNoYXIgKiph
cmd2ID0gKGNoYXIqKikgKGVsZmRhdGEgKyAxKTsNCg0KCXByaW50ZigiSW5zaWRlIF9fbGlua2Vy
X2luaXQgYXJnYyA9ICVkXG4iLCBhcmdjICk7CQ0KCXByaW50ZigiSW5zaWRlIF9fbGlua2VyX2lu
aXQgYXJndlswXSA9ICVzXG4iLCBhcmd2WzBdKTsNCg0KCXJldHVybiAwOw0KfQ0KDQo=
--001636c92bb6c4a3db047fde1521
Content-Type: application/octet-stream; name="start_ppc.S"
Content-Disposition: attachment; filename="start_ppc.S"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5tgguu52

LyoKICogQ29weXJpZ2h0IChDKSAyMDA4IFRoZSBBbmRyb2lkIE9wZW4gU291cmNlIFByb2plY3QK
ICogQWxsIHJpZ2h0cyByZXNlcnZlZC4KICoKICogUmVkaXN0cmlidXRpb24gYW5kIHVzZSBpbiBz
b3VyY2UgYW5kIGJpbmFyeSBmb3Jtcywgd2l0aCBvciB3aXRob3V0CiAqIG1vZGlmaWNhdGlvbiwg
YXJlIHBlcm1pdHRlZCBwcm92aWRlZCB0aGF0IHRoZSBmb2xsb3dpbmcgY29uZGl0aW9ucwogKiBh
cmUgbWV0OgogKiAgKiBSZWRpc3RyaWJ1dGlvbnMgb2Ygc291cmNlIGNvZGUgbXVzdCByZXRhaW4g
dGhlIGFib3ZlIGNvcHlyaWdodAogKiAgICBub3RpY2UsIHRoaXMgbGlzdCBvZiBjb25kaXRpb25z
IGFuZCB0aGUgZm9sbG93aW5nIGRpc2NsYWltZXIuCiAqICAqIFJlZGlzdHJpYnV0aW9ucyBpbiBi
aW5hcnkgZm9ybSBtdXN0IHJlcHJvZHVjZSB0aGUgYWJvdmUgY29weXJpZ2h0CiAqICAgIG5vdGlj
ZSwgdGhpcyBsaXN0IG9mIGNvbmRpdGlvbnMgYW5kIHRoZSBmb2xsb3dpbmcgZGlzY2xhaW1lciBp
bgogKiAgICB0aGUgZG9jdW1lbnRhdGlvbiBhbmQvb3Igb3RoZXIgbWF0ZXJpYWxzIHByb3ZpZGVk
IHdpdGggdGhlCiAqICAgIGRpc3RyaWJ1dGlvbi4KICoKICogVEhJUyBTT0ZUV0FSRSBJUyBQUk9W
SURFRCBCWSBUSEUgQ09QWVJJR0hUIEhPTERFUlMgQU5EIENPTlRSSUJVVE9SUwogKiAiQVMgSVMi
IEFORCBBTlkgRVhQUkVTUyBPUiBJTVBMSUVEIFdBUlJBTlRJRVMsIElOQ0xVRElORywgQlVUIE5P
VAogKiBMSU1JVEVEIFRPLCBUSEUgSU1QTElFRCBXQVJSQU5USUVTIE9GIE1FUkNIQU5UQUJJTElU
WSBBTkQgRklUTkVTUwogKiBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQVJFIERJU0NMQUlNRUQu
IElOIE5PIEVWRU5UIFNIQUxMIFRIRQogKiBDT1BZUklHSFQgT1dORVIgT1IgQ09OVFJJQlVUT1JT
IEJFIExJQUJMRSBGT1IgQU5ZIERJUkVDVCwgSU5ESVJFQ1QsCiAqIElOQ0lERU5UQUwsIFNQRUNJ
QUwsIEVYRU1QTEFSWSwgT1IgQ09OU0VRVUVOVElBTCBEQU1BR0VTIChJTkNMVURJTkcsCiAqIEJV
VCBOT1QgTElNSVRFRCBUTywgUFJPQ1VSRU1FTlQgT0YgU1VCU1RJVFVURSBHT09EUyBPUiBTRVJW
SUNFUzsgTE9TUwogKiBPRiBVU0UsIERBVEEsIE9SIFBST0ZJVFM7IE9SIEJVU0lORVNTIElOVEVS
UlVQVElPTikgSE9XRVZFUiBDQVVTRUQKICogQU5EIE9OIEFOWSBUSEVPUlkgT0YgTElBQklMSVRZ
LCBXSEVUSEVSIElOIENPTlRSQUNULCBTVFJJQ1QgTElBQklMSVRZLAogKiBPUiBUT1JUIChJTkNM
VURJTkcgTkVHTElHRU5DRSBPUiBPVEhFUldJU0UpIEFSSVNJTkcgSU4gQU5ZIFdBWSBPVVQKICog
T0YgVEhFIFVTRSBPRiBUSElTIFNPRlRXQVJFLCBFVkVOIElGIEFEVklTRUQgT0YgVEhFIFBPU1NJ
QklMSVRZIE9GCiAqIFNVQ0ggREFNQUdFLgogKi8KCgkudGV4dAoJLmFsaWduIDQKCS50eXBlIF9z
dGFydCxAZnVuY3Rpb24KCS5nbG9ibCBfc3RhcnQKCl9zdGFydDoKCW1yCTMsMQoJYmwJX19saW5r
ZXJfaW5pdAoKCS8qIGxpbmtlciBpbml0IHJldHVybnMgdGhlIF9lbnRyeSBhZGRyZXNzIGluIHRo
ZSBtYWluIGltYWdlICovCi8qIAlyZXR1cm4gdmFsdWUgd2lsbCBiZSBpbiByMywqLwoJbXIgMywz
CgltdGN0cgkzCgliY3RyCQkJLypicmFuY2ggdGhlIGFkZHJlc3Mgc3RvcmVkIGluIHRoZSByMyBp
LmUgY291bnQgcmVnaXN0ZXIqLyAKCgkuc2VjdGlvbiAuY3RvcnMsICJ3YSIKCS5nbG9ibCBfX0NU
T1JfTElTVF9fCl9fQ1RPUl9MSVNUX186CgkubG9uZyAtMQo=
--001636c92bb6c4a3db047fde1521
Content-Type: application/octet-stream; name="start_x86.S"
Content-Disposition: attachment; filename="start_x86.S"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5tgguu93

DQogIC50ZXh0DQogIC5hbGlnbiA0DQogIC50eXBlIF9zdGFydCwgQGZ1bmN0aW9uDQogIC5nbG9i
bCBfc3RhcnQNCiAgDQogIF9zdGFydDoNCiAgICAgICAgICAvKiBzYXZlIHRoZSBlbGZkYXRhIHB0
ciB0byAlZWF4LCBBTkQgcHVzaCBpdCBvbnRvIHRoZSBzdGFjayAqLw0KICAgICAgICAgIG1vdiAg
ICAlZXNwLCAlZWF4DQogICAgICAgICAgcHVzaGwgICVlc3ANCiAgDQogICAgICAgICAgcHVzaGwg
ICVlYXgNCiAgICAgICAgICBjYWxsICAgX19saW5rZXJfaW5pdA0KICANCiAgICAgICAgICAvKiBs
aW5rZXIgaW5pdCByZXR1cm5zICglZWF4KSB0aGUgX2VudHJ5IGFkZHJlc3MgaW4gdGhlIG1haW4g
aW1hZ2UgKi8NCiAgICAgICAgICAvKiBlbnRyeSBwb2ludCBleHBlY3RzIHNwIHRvIHBvaW50IHRv
IGVsZmRhdGEgKi8NCiAgICAgICAgICBwb3BsICAgJWVzcA0KICAgICAgICAgIGptcCAgICAqJWVh
eA0KICANCiAgLnNlY3Rpb24gLmN0b3JzLCAid2EiDQogIC5nbG9ibCBfX0NUT1JfTElTVF9fDQog
IA0KICBfX0NUT1JfTElTVF9fOg0KICAgICAgICAgIC5sb25nIC0xDQoNCg==
--001636c92bb6c4a3db047fde1521--
