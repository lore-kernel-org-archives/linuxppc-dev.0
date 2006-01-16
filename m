Return-Path: <abhay.singh@oracle.com>
Received: from rgminet02.oracle.com (rgminet02.oracle.com [148.87.122.31])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6925668A78
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2006 04:14:27 +1100 (EST)
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.122.30])
	by rgminet02.oracle.com (Switch-3.1.6/Switch-3.1.7) with ESMTP id
	k0GCcEmI029340
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 05:38:14 -0700
Received: from rgmgw2.us.oracle.com (rgmgw2.us.oracle.com [138.1.186.111])
	by rgminet01.oracle.com (Switch-3.1.6/Switch-3.1.6) with ESMTP id
	k0GCc9W7029012
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 05:38:09 -0700
Received: from rgmgw2.us.oracle.com (localhost [127.0.0.1])
	by rgmgw2.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with ESMTP id
	k0GCc97d006518
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 05:38:09 -0700
Received: from abhsinghpc (dhcp-lexingtontowers-152-69-158-154.idc.oracle.com
	[152.69.158.154])
	by rgmgw2.us.oracle.com (Switch-3.1.4/Switch-3.1.0) with SMTP id
	k0GCc7Gf006331
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jan 2006 05:38:08 -0700
From: "Abhay Singh" <abhay.singh@oracle.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Issue while linking c++ applicatiopn on Linux Power
Date: Mon, 16 Jan 2006 18:08:03 +0530
Message-ID: <PHENJGDFMJPEBOBLGEMOEEIDCIAA.abhay.singh@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01C2_01C61AC7.CB3637E0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_01C2_01C61AC7.CB3637E0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
I am porting a huge c++ server application on Linux Power PC.
The compiler which I am using is IBM xlC 7.0 version. The gcc version
installed is 3.3.3.
I am using xlC for building the c++ application and shared objects, as
opposed for the gcc -fPIC option, Iam using -qpic=3Dlarge for creating =
the
position independance code.
While linking one of out libraries, we encountered an issue like "
"relocation truncated to fit: R_PPC_LOCAL24PC
_GLOBAL_OFFSET_TABLE_+fffffffffffffffc"
Then after using the -Wl,--relax as linker option we were able to create =
the
shared library.

Now but during the creation of the final executable during the link =
time, I
am facing a similar issue like

objws/opt/dcsdblk.o(.text+0xe620): In function `os_vector<DCWFormat
const*>::reserve(unsigned int)':
: relocation truncated to fit: R_PPC_LOCAL24PC
_GLOBAL_OFFSET_TABLE_+fffffffffffffffc
objws/opt/dcsdblk.o(.text+0xe70c): In function `os_allocator<DCWFormat
const*>::allocate(unsigned int, void const*)':
: relocation truncated to fit: R_PPC_LOCAL24PC
_GLOBAL_OFFSET_TABLE_+fffffffffffffffc
objws/opt/dcsdblk.o(.text+0xe790): In function `os_vector<DCWFormat
const*>::insert(DCWFormat const**, unsigned int, DCWFormat const* =
const&)':
: relocation truncated to fit: R_PPC_LOCAL24PC
_GLOBAL_OFFSET_TABLE_+fffffffffffffffc

Even the Wl,--relax option is noy helping us.

I saw one small c test program as=20

#include <stdio.h>
char realbig[36000032] =3D {1,2};

int main()
{
        printf ("&realbig =3D %#lx\n", &realbig);
}

while compiling gives the same kind of error. Although this error =
vanishes,
if we do a 64 bit build using option -q64 for xlC and -m64 for gcc.

Please let me know, if there is any resolution for the above described
issue.

Thanks and regards,
Abhay Kumar Singh
Oracle India Private Limited.
Tel: 91-80-51086837


------=_NextPart_000_01C2_01C61AC7.CB3637E0
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

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
AAAAAABGAAAAAFKFAABzeQEAHgAJgAggBgAAAAAAwAAAAAAAAEYAAAAAVIUAAAEAAAAEAAAAOS4w
AAsADYAIIAYAAAAAAMAAAAAAAABGAAAAAIKFAAABAAAACwA6gAggBgAAAAAAwAAAAAAAAEYAAAAA
DoUAAAAAAAADADyACCAGAAAAAADAAAAAAAAARgAAAAARhQAAAAAAAAMAPYAIIAYAAAAAAMAAAAAA
AABGAAAAABiFAAAAAAAACwBSgAggBgAAAAAAwAAAAAAAAEYAAAAABoUAAAAAAAADAFOACCAGAAAA
AADAAAAAAAAARgAAAAABhQAAAAAAAAIB+A8BAAAAEAAAAPbYpQRqGfdNljU/LLsfDtcCAfoPAQAA
ABAAAAD22KUEahn3TZY1Pyy7Hw7XAgH7DwEAAABcAAAAAAAAADihuxAF5RAaobsIACsqVsIAAFBT
VFBSWC5ETEwAAAAAAAAAAE5JVEH5v7gBAKoAN9luAAAARDpcT3V0bG9va19Mb2NhbF9NYWlsc1xv
dXRsb29rLnBzdAADAP4PBQAAAAMADTT9NwAAAgF/AAEAAAA2AAAAPFBIRU5KR0RGTUpQRUJPQkxH
RU1PRUVJRENJQUEuYWJoYXkuc2luZ2hAb3JhY2xlLmNvbT4AAAADAAYQPe78vgMABxDTBQAAAwAQ
EAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEhJLElBTVBPUlRJTkdBSFVHRUMrK1NFUlZFUkFQUExJ
Q0FUSU9OT05MSU5VWFBPV0VSUENUSEVDT01QSUxFUldISUNISUFNVVNJTkdJU0lCTVhMQzcwVkVS
U0lPTlRIRUdDQ1YAAAAAM2c=

------=_NextPart_000_01C2_01C61AC7.CB3637E0--
