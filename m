Return-Path: <tmaenner@aehr.com>
Received: from loki.aehr.com (loki.aehr.com [207.168.29.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7692ADDE30
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Mar 2007 06:45:45 +1000 (EST)
From: Thomas Maenner <tmaenner@aehr.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Avoid using libm in rootfs
Date: Thu, 29 Mar 2007 13:45:35 -0700
References: <20070329192932.98FBD353A6C@atlas.denx.de>
In-Reply-To: <20070329192932.98FBD353A6C@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703291345.35978.tmaenner@aehr.com>
Cc: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Maybe on the same subject or OT, I'm having trouble with ELDK 4.1.0, kernel=
=20
2.4.25, u-boot 1.1.6, kernel and ramdisk copied from flash into RAM on a=20
TQM860L module.

Using a fresh ramdisk and installed busybox 1.4.2, plus the shared libs fro=
m=20
ELDK, init barks that it can not find /lib/libc.so.6, although it's there=20
(case 1)

Using fresh ELDK ramdisk, init complains about missing libm.so.6, although =
it=20
is there... (case 2)

Some ldd and readelf output:

case 1:
devel01:/devel/abts_devel/work/tom/tq_ramdisk # ppc_8xx-ldd=20
tmp_mount/bin/busybox
        libcrypt.so.1=20
=3D> /devel.rtl01/bist_devel/tools/ppc/eldk-4.1.0/ppc_8xx/lib/libcrypt.so.1
        libc.so.6=20
=3D> /devel.rtl01/bist_devel/tools/ppc/eldk-4.1.0/ppc_8xx/lib/libc.so.6
        ld.so.1=20
=3D> /devel.rtl01/bist_devel/tools/ppc/eldk-4.1.0/ppc_8xx/lib/ld.so.1

devel01:/devel/abts_devel/work/tom/tq_ramdisk # ppc_8xx-readelf -d=20
tmp_mount/bin/busybox | grep NEEDED
 0x00000001 (NEEDED)                     Shared library: [libcrypt.so.1]
 0x00000001 (NEEDED)                     Shared library: [libc.so.6]

case 2:
devel01:/devel/abts_devel/work/tom/tq_ramdisk # ppc_8xx-ldd new/bin/busybox
        libcrypt.so.1=20
=3D> /devel.rtl01/bist_devel/tools/ppc/eldk-4.1.0/ppc_8xx/lib/libcrypt.so.1
        libm.so.6=20
=3D> /devel.rtl01/bist_devel/tools/ppc/eldk-4.1.0/ppc_8xx/lib/libm.so.6
        libc.so.6=20
=3D> /devel.rtl01/bist_devel/tools/ppc/eldk-4.1.0/ppc_8xx/lib/libc.so.6
        ld.so.1=20
=3D> /devel.rtl01/bist_devel/tools/ppc/eldk-4.1.0/ppc_8xx/lib/ld.so.1

devel01:/devel/abts_devel/work/tom/tq_ramdisk # ppc_8xx-readelf -d=20
new/bin/busybox |grep NEEDED
 0x00000001 (NEEDED)                     Shared library: [libcrypt.so.1]
 0x00000001 (NEEDED)                     Shared library: [libm.so.6]
 0x00000001 (NEEDED)                     Shared library: [libc.so.6]

Shouldn't the paths from ldd be for example /lib/libc.so.6 ?

Anybody has any idea what that could be?
I'll gladly provide any other information you'll need.

Thanks much in advance
Tom

On Thursday 29 March 2007 12:29, Wolfgang Denk wrote:
> In message <F1F6EC0C8B75034F9E3A79FC85122E8E71CD4A@aquib01a> you wrote:
> > Is it possible to avoid using libm in my roofs? Why a simple application
>
> Yes, this is possible.
>
> > always need it? Is it needed by libc or libstdc++?
>
> Simple applications don't need no libm. Neither  libc  nor  libstdc++
> per se require libm.
>
> It is your code and the library functions you call which causes such
> dependencies. Note that you have to be aware that even innocent
> looking calls like a
>
> 	printf ("Hello World\n");
>
> may be the culprits

=2D-=20
Thomas Maenner
Engineering Project Manager
AEHR Test Systems
400 Kato Terrace
=46remont, CA 94539
Phone: =A0+1-510-623-9400x323
Cell: =A0 +1-925-389-6653
=46ax: =A0 =A0+1-510-623-9450
E-Mail: mailto:tmaenner@aehr.com
