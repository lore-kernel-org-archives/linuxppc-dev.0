Return-Path: <Fabien.Clement@thomson.net>
Received: from dmzraw5.extranet.tce.com (dmzraw5.extranet.tce.com
	[157.254.234.142]) by ozlabs.org (Postfix) with ESMTP id B4FC8681BE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 21:26:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C5F0E1.7914D184"
Date: Thu, 24 Nov 2005 11:26:03 +0100
Message-ID: <9C1918067C3BC14C9C351C206D8A843701F54B1A@rennsmail03.eu.thmulti.com>
From: "Clement Fabien" <Fabien.Clement@thomson.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: [Patch] CPM allocation mechanism in 2.6.13
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

------_=_NextPart_001_01C5F0E1.7914D184
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello

I found out that the rh_alloc mechanism used in 2.6.xx does not always
provide aligned blocks.=20
I'm using a 8275 and try to start the SAR driver of Alex Zeffert.

Here is a trace of allocations at linux startup of the code that gives
me problems:

<...>
rh_alloc Required size =3D 8, align =3D 16
rh_alloc Block available, blk->size =3D 00003f40 - Start =3D 000000c0
rh_alloc Alloc size =3D 16, align =3D 16 - Start =3D 000000c0

rh_alloc Required size =3D 6144, align =3D 32=20
rh_alloc Block available, blk->size =3D 00003f30 - Start =3D 000000d0=20
rh_alloc Alloc size =3D 6144, align =3D 32 - Start =3D 000000d0=20
(!!!! WRONG ALIGNMENT !!!!)

rh_alloc Required size =3D 264, align =3D 64=20
rh_alloc Block available, blk->size =3D 00002730 - Start =3D 000018d0
rh_alloc Alloc size =3D 320, align =3D 64 - Start =3D 000018d0 =20
(!!!! WRONG ALIGNMENT !!!!)

rh_alloc Required size =3D 64, align =3D 16
rh_alloc Block available, blk->size =3D 000025f0 - Start =3D 00001a10
rh_alloc Alloc size =3D 64, align =3D 16 - Start =3D 00001a10
<...>

If we observe rh_alloc (arch/ppc/lib/rheap.c) function

The following line only ensures that there is enough space to perform
alignment:
1.	size =3D (size + (info->alignment - 1)) & ~(info->alignment - 1);

But with the block start modification mechanism you cannot ensure that
the next block will be aligned :=20
2.   	blk->start =3D (int8_t *)blk->start + size;

The allocation mechanism must take into account the starting address, as
it was in Linux 2.4 following code (3. extracted from commproc.c)
3.     off =3D ((p->start_addr + align_mask) & (~align_mask)) -
p->start_addr;

I've had an initial discussion with Pantelis who suggests that alignment
shall be unique for this heap:=20

>> Excuse me, how do you modify the rheap's alignment at runtime?
>> The allocators prototype is:

>> void *rh_alloc(rh_info_t * info, int size, const char *owner)

>> I don't see an alignment parameter.

>> If you are modifying info->alignment by hand before calling you can't

>> possibly expect this to work.

>> The alignment is fixed after the creation of the rheap.
>> If you need specific alignment you do it like this.

>> u8 *p =3D rh_alloc(info, size + (align - 1), "owner");

>> p =3D (void *)((unsigned long)p + (align - 1) & ~(align - 1));

So I guess the problem is in the usage of the function in kernel: it is
initialized with 1 byte alignment (in cpm2_dpinit in
arch/ppc/syslib/cpm2_common.c), then the cpm_dpalloc manipulates the
alignment like this:

4.	cpm_dpmem_info.alignment =3D align;
	start =3D rh_alloc(&cpm_dpmem_info, size, "commproc");


I do not have an exact idea whether to modify cpm_dpalloc or rh_alloc.
Can someone provide inputs on this subject?

Please see also the patch I suggest to correct the rh_alloc function

Regards
Fabien Clement


------_=_NextPart_001_01C5F0E1.7914D184
Content-Type: application/octet-stream;
	name="rheap.patch"
Content-Transfer-Encoding: base64
Content-Description: rheap.patch
Content-Disposition: attachment;
	filename="rheap.patch"

SW5kZXg6IGFyY2gvcHBjL2xpYi9yaGVhcC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9ob21lL2Nv
bmYvdG5wL2xpbnV4cHBjL2xpbnV4L2FyY2gvcHBjL2xpYi9yaGVhcC5jLHYKcmV0cmlldmluZyBy
ZXZpc2lvbiAxLjEuMS4xCmRpZmYgLWIgLXUgLXIxLjEuMS4xIHJoZWFwLmMKLS0tIGFyY2gvcHBj
L2xpYi9yaGVhcC5jCTYgRGVjIDIwMDQgMTY6MTU6MjIgLTAwMDAJMS4xLjEuMQorKysgYXJjaC9w
cGMvbGliL3JoZWFwLmMJMjQgTm92IDIwMDUgMDk6NDI6MzcgLTAwMDAKQEAgLTQzMSwxMyArNDMx
LDE1IEBACiAJcmhfYmxvY2tfdCAqYmxrOwogCXJoX2Jsb2NrX3QgKm5ld2JsazsKIAl2b2lkICpz
dGFydDsKKyAgIHVuc2lnbmVkIGludCBvZmY7CisgICB1bnNpZ25lZCBpbnQgYWxpZ25fbWFzayA9
IChpbmZvLT5hbGlnbm1lbnQgLSAxKTsKIAogCS8qIFZhbGlkYXRlIHNpemUgKi8KIAlpZiAoc2l6
ZSA8PSAwKQogCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKIAogCS8qIEFsaWduIHRvIGNvbmZp
Z3VyZWQgYWxpZ25tZW50ICovCi0Jc2l6ZSA9IChzaXplICsgKGluZm8tPmFsaWdubWVudCAtIDEp
KSAmIH4oaW5mby0+YWxpZ25tZW50IC0gMSk7CisgICBzaXplID0gKHNpemUgKyBhbGlnbl9tYXNr
KSAmICh+YWxpZ25fbWFzayk7CiAKIAlpZiAoYXNzdXJlX2VtcHR5KGluZm8sIDEpIDwgMCkKIAkJ
cmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7CkBAIC00NDYsNyArNDQ4LDExIEBACiAJbGlzdF9mb3Jf
ZWFjaChsLCAmaW5mby0+ZnJlZV9saXN0KSB7CiAJCWJsayA9IGxpc3RfZW50cnkobCwgcmhfYmxv
Y2tfdCwgbGlzdCk7CiAJCWlmIChzaXplIDw9IGJsay0+c2l6ZSkKKyAgICAgIHsKKyAgICAgICAg
IG9mZiA9ICgoaW50KShibGstPnN0YXJ0ICsgYWxpZ25fbWFzaykgJiAofmFsaWduX21hc2spKSAt
IChpbnQpYmxrLT5zdGFydDsKKyAgICAgICAgIGlmIChibGstPnNpemUgPj0gc2l6ZSArIG9mZikg
CiAJCQlicmVhazsKKyAgICAgIH0KIAkJYmxrID0gTlVMTDsKIAl9CiAKQEAgLTQ1NCw3ICs0NjAs
NyBAQAogCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKIAogCS8qIEp1c3QgZml0cyAqLwotCWlm
IChibGstPnNpemUgPT0gc2l6ZSkgeworCWlmIChibGstPnNpemUgPT0gKHNpemUgKyBvZmYpKSB7
CiAJCS8qIE1vdmUgZnJvbSBmcmVlIGxpc3QgdG8gdGFrZW4gbGlzdCAqLwogCQlsaXN0X2RlbCgm
YmxrLT5saXN0KTsKIAkJYmxrLT5vd25lciA9IG93bmVyOwpAQCAtNDYyLDIxICs0NjgsMjMgQEAK
IAogCQlhdHRhY2hfdGFrZW5fYmxvY2soaW5mbywgYmxrKTsKIAotCQlyZXR1cm4gc3RhcnQ7CiAJ
fQotCisgICBlbHNlCisgICB7ICAKIAluZXdibGsgPSBnZXRfc2xvdChpbmZvKTsKIAluZXdibGst
PnN0YXJ0ID0gYmxrLT5zdGFydDsKLQluZXdibGstPnNpemUgPSBzaXplOworICAgCW5ld2Jsay0+
c2l6ZSA9IHNpemUgKyBvZmY7CiAJbmV3YmxrLT5vd25lciA9IG93bmVyOwogCiAJLyogYmxrIHN0
aWxsIGluIGZyZWUgbGlzdCwgd2l0aCB1cGRhdGVkIHN0YXJ0LCBzaXplICovCi0JYmxrLT5zdGFy
dCA9IChpbnQ4X3QgKilibGstPnN0YXJ0ICsgc2l6ZTsKLQlibGstPnNpemUgLT0gc2l6ZTsKKyAg
IAlibGstPnN0YXJ0ID0gKGludDhfdCAqKWJsay0+c3RhcnQgKyBzaXplICsgb2ZmOworICAgCWJs
ay0+c2l6ZSAtPSAoc2l6ZSArIG9mZik7CiAKLQlzdGFydCA9IG5ld2Jsay0+c3RhcnQ7CisgICAJ
c3RhcnQgPSBuZXdibGstPnN0YXJ0ICsgb2ZmOwogCiAJYXR0YWNoX3Rha2VuX2Jsb2NrKGluZm8s
IG5ld2Jsayk7CisgICB9CisKIAogCXJldHVybiBzdGFydDsKIH0K

------_=_NextPart_001_01C5F0E1.7914D184--
