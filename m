Return-Path: <jfree@sovereign.org>
Received: from sovereign.org (sovereign.org [66.93.224.192])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lux.homenet", Issuer "lux.homenet" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C16362BEDF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 15:42:14 +1000 (EST)
From: Jim Freeman <jfree@sovereign.org>
Date: Tue, 12 Oct 2004 23:42:09 -0600
To: Dan Kegel <dank@kegel.com>
Message-ID: <20041013054209.GD9264@sovereign.org>
References: <DBFABB80F7FD3143A911F9E6CFD477B0021B045A@hqemmail02.nvidia.com>
	<416BF876.4020606@kegel.com> <20041013051855.GB9264@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041013051855.GB9264@sovereign.org>
Cc: Stephen Warren <SWarren@nvidia.com>, crossgcc <crossgcc@sources.redhat.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: FW: NPTL support on PPC32 (MPC5200) ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Oct 12, 2004 at 11:18:55PM -0600, Jim Freeman wrote:
> I find that I have to apply the attached patch to
>=20
> 	contrib/crosstool-0.28-rc34-nptl_fixes.patch
=2E..
> [ ARCH=3Dppc, but dirname =3D powerpc/ ]
>=20
> The build hasn't finished yet, but at least it no longer dies at this
> spot.

Phbbt - dies later with

	powerpc-8540-linux-gnu-gcc  ../sysdeps/powerpc/elf/libc-start.c -c -std=3D=
gnu99 -O -Wa,-me500 -Wall -Winline -Wstrict-prototypes -Wwrite-strings -mno=
-string -msoft-float -msoft-float -mnew-mnemonics   -I../nptl   -I../includ=
e -I. -I/opt/src/crosstool-0.28-rc37/build/powerpc-8540-linux-gnu/gcc-3.4.2=
-glibc-2.3.3/build-glibc-startfiles/csu -I.. -I../libio -I../nptl -I/opt/sr=
c/crosstool-0.28-rc37/build/powerpc-8540-linux-gnu/gcc-3.4.2-glibc-2.3.3/bu=
ild-glibc-startfiles -I../sysdeps/powerpc/powerpc32/elf -I../sysdeps/powerp=
c/elf -I../nptl/sysdeps/unix/sysv/linux/powerpc/powerpc32 -I../nptl/sysdeps=
/unix/sysv/linux/powerpc -I../nptl/sysdeps/unix/sysv/linux -I../nptl/sysdep=
s/pthread -I../sysdeps/pthread -I../nptl/sysdeps/unix/sysv -I../nptl/sysdep=
s/unix -I../nptl/sysdeps/powerpc -I../sysdeps/unix/sysv/linux/powerpc/power=
pc32 -I../sysdeps/unix/sysv/linux/powerpc -I../sysdeps/unix/sysv/linux -I..=
/sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman -I../sysdeps/u=
nix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix/powerpc -I../sysdeps/unix=
 -I../sysdeps/posix -I../sysdeps/powerpc/powerpc32 -I../sysdeps/wordsize-32=
 -I../sysdeps/powerpc/soft-fp -I../sysdeps/powerpc/nofpu -I../sysdeps/power=
pc -I../sysdeps/ieee754/flt-32 -I../sysdeps/ieee754/dbl-64 -I../sysdeps/iee=
e754 -I../sysdeps/generic/elf -I../sysdeps/generic -nostdinc -isystem /opt/=
src/crosstool-0.28-rc37/result/powerpc-8540-linux-gnu/gcc-3.4.2-glibc-2.3.3=
/lib/gcc/powerpc-8540-linux-gnu/3.4.2/include -isystem /opt/src/crosstool-0=
=2E28-rc37/result/powerpc-8540-linux-gnu/gcc-3.4.2-glibc-2.3.3/powerpc-8540=
-linux-gnu/include -D_LIBC_REENTRANT -D_LIBC_REENTRANT -include ../include/=
libc-symbols.h       -DHAVE_INITFINI -o /opt/src/crosstool-0.28-rc37/build/=
powerpc-8540-linux-gnu/gcc-3.4.2-glibc-2.3.3/build-glibc-startfiles/csu/lib=
c-start.o -MD -MP -MF /opt/src/crosstool-0.28-rc37/build/powerpc-8540-linux=
-gnu/gcc-3.4.2-glibc-2.3.3/build-glibc-startfiles/csu/libc-start.o.dt
	In file included from ../sysdeps/powerpc/elf/libc-start.c:55:
	../sysdeps/generic/libc-start.c: In function `generic_start_main':
	../sysdeps/generic/libc-start.c:93: sorry, unimplemented: function 'generi=
c_start_main' can never be inlined because it uses setjmp
	make[2]: *** [/opt/src/crosstool-0.28-rc37/build/powerpc-8540-linux-gnu/gc=
c-3.4.2-glibc-2.3.3/build-glibc-startfiles/csu/libc-start.o] Error 1
	make[2]: Leaving directory `/opt/src/crosstool-0.28-rc37/build/powerpc-854=
0-linux-gnu/gcc-3.4.2-glibc-2.3.3/glibc-2.3.3/csu'
	make[1]: *** [csu/subdir_lib] Error 2
	make[1]: Leaving directory `/opt/src/crosstool-0.28-rc37/build/powerpc-854=
0-linux-gnu/gcc-3.4.2-glibc-2.3.3/glibc-2.3.3'
	make: *** [csu/subdir_lib] Error 2


Tired, bed (I'm a wimp).
