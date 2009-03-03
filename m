Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 895F9DDF58
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 17:22:38 +1100 (EST)
Date: Tue, 3 Mar 2009 17:22:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: powerpc allnoconfig
Message-Id: <20090303172232.f12ffbf8.sfr@canb.auug.org.au>
In-Reply-To: <20090302213801.1dd255f3.akpm@linux-foundation.org>
References: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
	<12051.1236047470@neuling.org>
	<20090302184049.27a73395.akpm@linux-foundation.org>
	<20090303135203.b36312a0.sfr@canb.auug.org.au>
	<20090302185514.2cc73512.akpm@linux-foundation.org>
	<20090303141905.52dbf9b1.sfr@canb.auug.org.au>
	<20090302200809.26b5d5bb.akpm@linux-foundation.org>
	<20090303154043.fee7902e.sfr@canb.auug.org.au>
	<20090302213801.1dd255f3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__3_Mar_2009_17_22_32_+1100_.9Y2gj.O58q9lkN+"
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__3_Mar_2009_17_22_32_+1100_.9Y2gj.O58q9lkN+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 2 Mar 2009 21:38:01 -0800 Andrew Morton <akpm@linux-foundation.org>=
 wrote:
>
> > I think we need a better bug report :-)
> > Kernel version?
>=20
> Current mainline.
>=20
> > What error do you get now?
>=20
> Same as before.
>=20
> > allmodconfig and defconfig turn CONFIG_PPC64 on.  allnoconfig turns it
> > off so you are trying to build a 32 bit kernel with a 64 bit compiler.
>=20
> Oh.  Well that will tear it.
>=20
> How does one prepare a powerpc64 allnoconfig?

Like above.

See this is what happens for me:

$ git describe
v2.6.29-rc6-305-g2450cf5
$ /home/sfr/kernels/cross/bin/powerpc64-linux-gcc -v
Using built-in specs.
Target: powerpc64-linux
Configured with: /home/sfr/kernels/tools/gcc-4.3.2/configure --target=3Dpow=
erpc64-linux --enable-targets=3Dall --prefix=3D/home/sfr/kernels/cross --wi=
th-mpfr=3D/usr --enable-languages=3Dc --without-headers --enable-sjlj-excep=
tions --with-system-libunwind --disable-nls --disable-threads --disable-sha=
red --disable-libmudflap --disable-libssp --disable-libgomp --disable-decim=
al-float --enable-checking=3Drelease
Thread model: single
gcc version 4.3.2 (GCC)=20
$ mkdir ../powerpc_allnoconfig
$ echo CONFIG_PPC64=3Dy >../powerpc64_allnoconfig
$ KCONFIG_ALLCONFIG=3D../powerpc64_allnoconfig make O=3D../powerpc_allnocon=
fig ARCH=3Dpowerpc CROSS_COMPILE=3D/home/sfr/kernels/cross/bin/powerpc64-li=
nux- allnoconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/basic/hash
  GEN     /home/sfr/kernels/powerpc_allnoconfig/Makefile
  HOSTCC  scripts/kconfig/conf.o
  HOSTCC  scripts/kconfig/kxgettext.o
  SHIPPED scripts/kconfig/zconf.tab.c
  SHIPPED scripts/kconfig/lex.zconf.c
  SHIPPED scripts/kconfig/zconf.hash.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
scripts/kconfig/conf -n arch/powerpc/Kconfig
#
# configuration written to .config
#
$ make O=3D../powerpc_allnoconfig ARCH=3Dpowerpc CROSS_COMPILE=3D/home/sfr/=
kernels/cross/bin/powerpc64-linux- vmlinux
  GEN     /home/sfr/kernels/powerpc_allnoconfig/Makefile
scripts/kconfig/conf -s arch/powerpc/Kconfig
  Using /home/sfr/kernels/work as source for kernel
  GEN     /home/sfr/kernels/powerpc_allnoconfig/Makefile
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  CHK     include/linux/utsrelease.h
  UPD     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-powerpc
  CC      kernel/bounds.s
  GEN     include/linux/bounds.h
  CC      arch/powerpc/kernel/asm-offsets.s
  GEN     include/asm/asm-offsets.h
  CALL    /home/sfr/kernels/work/scripts/checksyscalls.sh
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
	.
	.
	.
  CC      kernel/sysctl.o
/home/sfr/kernels/work/kernel/sysctl.c:103: warning: 'one' defined but not =
used
	.
	.
	.
  LD      vmlinux.o
  MODPOST vmlinux.o
WARNING: modpost: Found 2 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=3Dy'
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
$ grep CONFIG_PPC64 ../powerpc_allnoconfig/.config
CONFIG_PPC64=3Dy
$ file ../powerpc_allnoconfig/vmlinux
../powerpc_allnoconfig/vmlinux: ELF 64-bit MSB executable, 64-bit PowerPC o=
r cisco 7500, version 1 (SYSV), statically linked, not stripped

So, I can only imagine it is your toolchain that is letting you down.
What is your host machine?  Can I send you a new toolchain? (Mine are only
good for building kernels - they have no libraries - they are build by a
script I got from Segher Boessenkool.)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__3_Mar_2009_17_22_32_+1100_.9Y2gj.O58q9lkN+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmszKgACgkQjjKRsyhoI8wdzgCfffo0WrDYq6ZAzT7ReXXBW2cj
b0YAn2nUwAe3wtzhZfiYSauQNWYqqMB8
=mMjj
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Mar_2009_17_22_32_+1100_.9Y2gj.O58q9lkN+--
