Subject: Re: problem with sound driver in iBook2
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
To: Heinz Kirchmann <kirchman@dfki.uni-kl.de>
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3F298B5B.1080900@dfki.uni-kl.de>
References: <3F298B5B.1080900@dfki.uni-kl.de>
Content-Type: multipart/mixed; boundary="=-5hP+y9IuCSAYJoLEwlF/"
Message-Id: <1059738192.19000.19.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 01 Aug 2003 13:43:12 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--=-5hP+y9IuCSAYJoLEwlF/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-31 at 23:34, Heinz Kirchmann wrote:=20
> I tried to collect some info, why the dmasound driver does not work=20
> correctly on my iBook2. Besides the fact, that recording is not possible=20
> with the standard dmasound_pmac and dmasound_core drivers, I noticed=20
> problems with audacity, too. After calling audacity (version 1.0.1)=20
> neither recording nor playing were possible any more. I made some tests=20
> and it turned out, that opening /dev/dsp with flag O_RDWR caused the=20
> driver not to release the device cleanly.
>=20
> System:
>    Hardware: iBook2 G3 800 12"
>    OS: Debian 3.0
>    Kernel: 2.4.21-ben2 (from rsync, no configuration changes)
>=20
> I took a closer look at the kernel sources of dmasound_core.c and=20
> dmasound_awacs.c in subdirectory 'drivers/sound/dmasound'.
>=20
> I noticed the following strange things in dmasound_core.c and=20
> dmasound_awacs.c:
>=20
> a) in sq_open (dmasound_core.c) I found two (conflicting?) concepts to=20
> decide, if the soundcard offers recording possibility or not: macro=20
> 'HAS_RECORD' was set and dmasound.mach.record was _not_ set.=20

They aren't conflicting. HAS_RECORD defines whether the code for
recording is built in at all, dmasound.mach.record says whether
recording is supported for the machine it's running on.

> I decided to change the corresponding line in function dmasound_awacs_ini=
t=20
> (file dmasound_awacs.c) around line 3109:
>=20
>          if (awacs_revision !=3D AWACS_TUMBLER &&
>              awacs_revision !=3D AWACS_SNAPPER &&
>              awacs_revision !=3D AWACS_DACA)
> 		dmasound.mach.capabilities =3D DSP_CAP_DUPLEX ;
> 		dmasound.mach.record =3D PMacRecord ;
> ...
>=20
> I commented out the line with AWACS_SNAPPER in it, thus causing=20
> dmasound.mach.record to be set to a value !=3D NULL.
>=20
> b) the structure sq_fops of type 'struct file_operations' (in=20
> dmasound_core.c) does not define a function for 'read'. Even though=20
> 'HAS_RECORD' is defined, the corresponding value is set to NULL. What am=20
> I missing here?
> I decided to set the value for 'read' to 'sq_read'.

This is done in sq_init() if recording is supported.

> These two changes changed the behaviour of the driver as follows:
> a) open for reading now possible, but a call to read will cause the read=20
> function to return immediately with successful return value but returned=20
> data does not contain any senseful samples.
> b) driver does not lock up sound device after opening with O_RDWR.

Well, this just avoids the problem by pretending that recording is
supported, when in fact it isn't.

However, as some apps open the device with O_RDWR even when they're
never going to read from it, this might not be the worst approach. This
patch does more or less what you describe, but reads will return
-EINVAL.

Does anybody see a problem with this? (I mean a more annoying problem
than the one it works around? :)


--=20
Earthling Michel D=C3=A4nzer   \  Debian (powerpc), XFree86 and DRI develop=
er
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=3Ddaenzer

--=-5hP+y9IuCSAYJoLEwlF/
Content-Disposition: attachment; filename=dmasound-read.diff
Content-Type: text/x-patch; name=dmasound-read.diff; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtdXAgLXIgbGludXgtMi40LjIwLWJlbjgvZHJpdmVycy9zb3VuZC9kbWFzb3VuZC9kbWFz
b3VuZF9jb3JlLmMgbGludXgtMi40LjIwLWJlbjgteGZzLWxvbGF0L2RyaXZlcnMvc291bmQvZG1h
c291bmQvZG1hc291bmRfY29yZS5jDQotLS0gbGludXgtMi40LjIwLWJlbjgvZHJpdmVycy9zb3Vu
ZC9kbWFzb3VuZC9kbWFzb3VuZF9jb3JlLmMJMjAwMi0wNy0yNiAxNDoxMTo0MS4wMDAwMDAwMDAg
KzAyMDANCisrKyBsaW51eC0yLjQuMjAtYmVuOC14ZnMtbG9sYXQvZHJpdmVycy9zb3VuZC9kbWFz
b3VuZC9kbWFzb3VuZF9jb3JlLmMJMjAwMy0wOC0wMSAxMzoyODo1NC4wMDAwMDAwMDAgKzAyMDAN
CkBAIC04ODEsMTMgKzg4MSw2IEBAIHN0YXRpYyBpbnQgc3Ffb3BlbihzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCANCiAJCQlkbWFzb3VuZC5tYWNoLnJlbGVhc2UoKTsNCiAJCQlyZXR1cm4gcmM7DQogCQl9
DQotCX0gZWxzZSB7IC8qIG5vIHJlY29yZCBmdW5jdGlvbiBpbnN0YWxsZWQ7IGluIGNvbXBhdCBt
b2RlICovDQotCQlpZiAoZmlsZS0+Zl9tb2RlICYgRk1PREVfUkVBRCkgew0KLQkJCS8qIFRPRE86
IGlmIE9fUkRXUiwgcmVsZWFzZSBhbnkgcmVzb3VyY2VzIGdyYWJiZWQgYnkgd3JpdGUgcGFydCAq
Lw0KLQkJCWRtYXNvdW5kLm1hY2gucmVsZWFzZSgpIDsNCi0JCQkvKiBJIHRoaW5rIHRoaXMgaXMg
d2hhdCBpcyByZXF1aXJlZCBieSBvcGVuKDIpICovDQotCQkJcmV0dXJuIC1FTlhJTyA7DQotCQl9
DQogCX0NCiAjZWxzZSAvKiAhSEFTX1JFQ09SRCAqLw0KIAlpZiAoZmlsZS0+Zl9tb2RlICYgRk1P
REVfUkVBRCkgew0KQEAgLTEzMzMsNyArMTMyNiw3IEBAIHN0YXRpYyBzdHJ1Y3QgZmlsZV9vcGVy
YXRpb25zIHNxX2ZvcHMgPQ0KIAlvcGVuOgkJc3Ffb3BlbiwNCiAJcmVsZWFzZToJc3FfcmVsZWFz
ZSwNCiAjaWZkZWYgSEFTX1JFQ09SRA0KLQlyZWFkOgkJTlVMTAkvKiBkZWZhdWx0IHRvIG5vIHJl
YWQgZm9yIGNvbXBhdCBtb2RlICovDQorCXJlYWQ6CQlzcV9yZWFkLA0KICNlbmRpZg0KIH07DQog
DQpAQCAtMTM0MywxMCArMTMzNiw2IEBAIHN0YXRpYyBpbnQgX19pbml0IHNxX2luaXQodm9pZCkN
CiAJaW50IHNxX3VuaXQ7DQogI2VuZGlmDQogDQotI2lmZGVmIEhBU19SRUNPUkQNCi0JaWYgKGRt
YXNvdW5kLm1hY2gucmVjb3JkKQ0KLQkJc3FfZm9wcy5yZWFkID0gc3FfcmVhZCA7DQotI2VuZGlm
DQogCXNxX3VuaXQgPSByZWdpc3Rlcl9zb3VuZF9kc3AoJnNxX2ZvcHMsIC0xKTsNCiAJaWYgKHNx
X3VuaXQgPCAwKSB7DQogCQlwcmludGsoS0VSTl9FUlIgImRtYXNvdW5kX2NvcmU6IGNvdWxkbid0
IHJlZ2lzdGVyIGZvcHNcbiIpIDsNCg==

--=-5hP+y9IuCSAYJoLEwlF/--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
