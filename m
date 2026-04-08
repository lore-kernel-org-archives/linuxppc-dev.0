Return-Path: <linuxppc-dev+bounces-19507-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B814C1073CB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 13:20:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frNw5069kz2yDk;
	Wed, 08 Apr 2026 23:20:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775654404;
	cv=none; b=cDmEi3lTusz1oGpCaw+IYU1nPk4ZchQSIBZRBDOIe2D1Ikvxe3c0WHXfup+asUzrAKllnCqlDA4yFIznzCkboPXrcBx9C8n3chUILNLFFEPvTC0fcjHYiJeO5mvgx37oDgZAqEa6PPEDMam1XgRETq1xmEgBXQiw7k9TukxK66LPVk71ILQJQAfs2DMVazP1XBDKV//1h5rsGAOppA8YBhTWbXJqSNx71sA7Qq3mBfnfjccHMapkPEKZKMgJ64E5wyNYZaOUonAVbJR69Ri9KVINwiSeGmVeBF847oJZKqsf87/V9qwrjff/VDVVPntlTr9BtAWtTYua5NfWv+v9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775654404; c=relaxed/relaxed;
	bh=40U6NdL8Gx9NIYzlKcY/dNARqIXyqawjjSe8PecDZeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5XXvb+BHEnmE+94svZISqUiT5MvdStqCOVsa4mnGNhtqXIZNptCqAGKuh9/VGnvL2IAPSqn/rKWjtFj88edI5ZIldIOQs+pW9yZ6Kvg6EXkiHTZ+Trz5GovXRGd8y/xGOCcqNTlgZ8MsmhwC437pXNZgO1amYGTrzuXZ3YAagu4/lWCaQKJ3cJtoCAf8k5J6W+ow/MnWUXHEoq8GVttblZ3NXNMdpIyKq2htphflLUSXnXgp/dYSI2n8DgHBBziVLyfCS6aVrsUhmjqju0pIyfwDryx1A3Flkf3Zy2+MuLUa00myDsRpr0knyVaDJvh9oYu7VZZg8j10VeihuhdOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frNw26qK6z2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 23:20:02 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 8C46AF40664; Wed, 08 Apr 2026 15:19:57 +0200 (CEST)
Date: Wed, 8 Apr 2026 15:19:57 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Link Mauve <linkmauve@linkmauve.fr>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org,
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH V10 0/4] Rust support for powerpc [RESEND]
Message-ID: <adZV_VISz8DNraug@luna>
References: <20260406200149.3727922-1-mkchauras@gmail.com>
 <adYlLLfRgSyxus3n@luna>
 <adZBWoVVoJefiTcM@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <adZBWoVVoJefiTcM@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Jabber-ID: linkmauve@linkmauve.fr

On Wed, Apr 08, 2026 at 05:23:39PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Wed, Apr 08, 2026 at 11:51:40AM +0200, Link Mauve wrote:
> > Hi,
> >=20
> > (This email is a resent, my IP address got flagged by spamhaus again
> > because I=E2=80=99m on a residential range, hopefully this incident is
> > resolved=E2=80=A6)
> >=20
> > On Tue, Apr 07, 2026 at 01:31:45AM +0530, Mukesh Kumar Chaurasiya (IBM)=
 wrote:
> > > Enable experimental rust support for ppc64le and ppc32be. The patch f=
or
> > > ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has b=
een
> > > merged over it. ppc32 needs some toolchain fixes mentioned in the pat=
ch
> > > `rust: Add PowerPC support` and the discussion for that is done here[=
1].
> > >=20
> > > This has been tested on
> > > - powernv9 hardware
> > > - pseries P11 hardware
> > > - pseries(9, 10) qemu
> > > - powernv(9, 10) qemu
> > > - rustdoc on x86 and powerpc64le
> > > - rusttest on x86 and powerpc64le
> >=20
> > I just tested your series for the Wii, so targeting powerpc (32, be),
> > and got this error:
> > ```
> > error[E0463]: can't find crate for `pin_init_internal`
> >    --> ../rust/pin-init/src/lib.rs:365:11
> >     |
> > 365 | pub use ::pin_init_internal::pin_data;
> >     |           ^^^^^^^^^^^^^^^^^ can't find crate
> >=20
> > error: aborting due to 1 previous error
> >=20
> > For more information about this error, try `rustc --explain E0463`.
> > ```
> >=20
> > I didn=E2=80=99t get this error in a previous version of your series, w=
ould you
> > want me to bisect them?
> >=20
> > Thanks for your continuous work on it anyway!
> >=20
>=20
> Hey Link,
>=20
> Thanks for testing this.
>=20
> Can you give me the command generated via make with V=3D1
> e.g. `make LLVM=3D1 V=3D1`

Here it is:
```
% make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-musl- O=3Dwii W=3D1 V=
=3D1 -j1
make  -C /home/linkmauve/dev/linux/wii \
-f /home/linkmauve/dev/linux/Makefile
make[1]: Entering directory '/home/linkmauve/dev/linux/wii'
make --no-print-directory -C /home/linkmauve/dev/linux/wii \
-f /home/linkmauve/dev/linux/Makefile
ln -fsn .. source
# GEN     Makefile
  { echo "# Automatically generated by /home/linkmauve/dev/linux/Makefile: =
don't edit"; echo "export KBUILD_OUTPUT =3D /home/linkmauve/dev/linux/wii";=
 echo "include /home/linkmauve/dev/linux/Makefile"; } > Makefile
test -e .gitignore || \
{ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
make -f ../scripts/Makefile.build obj=3Darch/powerpc/kernel/syscalls all
make -f ../scripts/Makefile.build obj=3Dscripts/basic
make -f ../scripts/Makefile.build obj=3Dscripts/dtc
make -f ../scripts/Makefile.build obj=3Dscripts
make -f ../scripts/Makefile.build obj=3Dscripts/gcc-plugins \
need-builtin=3D \
need-modorder=3D \

set -e; mkdir -p include/config/; trap "rm -f include/config/.tmp_kernel.re=
lease" EXIT; { ../scripts/setlocalversion ..; } > include/config/.tmp_kerne=
l.release; if [ ! -r include/config/kernel.release ] || ! cmp -s include/co=
nfig/kernel.release include/config/.tmp_kernel.release; then : '  UPD     i=
nclude/config/kernel.release'; mv -f include/config/.tmp_kernel.release inc=
lude/config/kernel.release; fi
make -f ../scripts/Makefile.asm-headers obj=3Darch/powerpc/include/generate=
d/uapi/asm \
generic=3Dinclude/uapi/asm-generic
make -f ../scripts/Makefile.asm-headers obj=3Darch/powerpc/include/generate=
d/asm \
generic=3Dinclude/asm-generic
set -e; mkdir -p include/generated/uapi/linux/; trap "rm -f include/generat=
ed/uapi/linux/.tmp_version.h" EXIT; { 	if [ 0 -gt 255 ]; then echo \#define=
 LINUX_VERSION_CODE 459007; else echo \#define LINUX_VERSION_CODE 458752; f=
i; echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + ((c) > 2=
55 ? 255 : (c)))'; echo \#define LINUX_VERSION_MAJOR 7; echo \#define LINUX=
_VERSION_PATCHLEVEL 0; echo \#define LINUX_VERSION_SUBLEVEL 0; } > include/=
generated/uapi/linux/.tmp_version.h; if [ ! -r include/generated/uapi/linux=
/version.h ] || ! cmp -s include/generated/uapi/linux/version.h include/gen=
erated/uapi/linux/.tmp_version.h; then : '  UPD     include/generated/uapi/=
linux/version.h'; mv -f include/generated/uapi/linux/.tmp_version.h include=
/generated/uapi/linux/version.h; fi
set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_uts=
release.h" EXIT; { 	if [ `echo -n "7.0.0-rc7-wii+" | wc -c ` -gt 64 ]; then=
 echo '"7.0.0-rc7-wii+" exceeds 64 characters' >&2; exit 1; fi; echo \#defi=
ne UTS_RELEASE \"7.0.0-rc7-wii+\"; } > include/generated/.tmp_utsrelease.h;=
 if [ ! -r include/generated/utsrelease.h ] || ! cmp -s include/generated/u=
tsrelease.h include/generated/.tmp_utsrelease.h; then : '  UPD     include/=
generated/utsrelease.h'; mv -f include/generated/.tmp_utsrelease.h include/=
generated/utsrelease.h; fi
set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_com=
pile.h" EXIT; { ../scripts/mkcompile_h "ppc" "powerpc-linux-musl-gcc (GCC) =
14.2.1 20250405" "powerpc-linux-musl-ld"; } > include/generated/.tmp_compil=
e.h; if [ ! -r include/generated/compile.h ] || ! cmp -s include/generated/=
compile.h include/generated/.tmp_compile.h; then : '  UPD     include/gener=
ated/compile.h'; mv -f include/generated/.tmp_compile.h include/generated/c=
ompile.h; fi
=2E./scripts/remove-stale-files
make -f ../scripts/Makefile.build obj=3Dscripts/mod
set -e; mkdir -p scripts/mod/; trap "rm -f scripts/mod/.tmp_devicetable-off=
sets.h" EXIT; { 	 echo "#ifndef __DEVICETABLE_OFFSETS_H__"; echo "#define _=
_DEVICETABLE_OFFSETS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; =
echo " * This file was generated by Kbuild"; echo " */"; echo ""; sed -ne 	=
's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 =
*/:; s:^->\([^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::;=
 p;}' < scripts/mod/devicetable-offsets.s; echo ""; echo "#endif"; } > scri=
pts/mod/.tmp_devicetable-offsets.h; if [ ! -r scripts/mod/devicetable-offse=
ts.h ] || ! cmp -s scripts/mod/devicetable-offsets.h scripts/mod/.tmp_devic=
etable-offsets.h; then : '  UPD     scripts/mod/devicetable-offsets.h'; mv =
-f scripts/mod/.tmp_devicetable-offsets.h scripts/mod/devicetable-offsets.h=
; fi
make -f ../scripts/Makefile.build obj=3D. prepare
set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_tim=
econst.h" EXIT; { echo 1000 | bc -q ../kernel/time/timeconst.bc; } > includ=
e/generated/.tmp_timeconst.h; if [ ! -r include/generated/timeconst.h ] || =
! cmp -s include/generated/timeconst.h include/generated/.tmp_timeconst.h; =
then : '  UPD     include/generated/timeconst.h'; mv -f include/generated/.=
tmp_timeconst.h include/generated/timeconst.h; fi
set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_bou=
nds.h" EXIT; { 	 echo "#ifndef __LINUX_BOUNDS_H__"; echo "#define __LINUX_B=
OUNDS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; echo " * This f=
ile was generated by Kbuild"; echo " */"; echo ""; sed -ne 	's:^[[:space:]]=
*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 */:; s:^->\([^ =
]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' < kernel/=
bounds.s; echo ""; echo "#endif"; } > include/generated/.tmp_bounds.h; if [=
 ! -r include/generated/bounds.h ] || ! cmp -s include/generated/bounds.h i=
nclude/generated/.tmp_bounds.h; then : '  UPD     include/generated/bounds.=
h'; mv -f include/generated/.tmp_bounds.h include/generated/bounds.h; fi
set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_asm=
-offsets.h" EXIT; { 	 echo "#ifndef __ASM_OFFSETS_H__"; echo "#define __ASM=
_OFFSETS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; echo " * Thi=
s file was generated by Kbuild"; echo " */"; echo ""; sed -ne 	's:^[[:space=
:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 */:; s:^->\(=
[^ ]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' < arch=
/powerpc/kernel/asm-offsets.s; echo ""; echo "#endif"; } > include/generate=
d/.tmp_asm-offsets.h; if [ ! -r include/generated/asm-offsets.h ] || ! cmp =
-s include/generated/asm-offsets.h include/generated/.tmp_asm-offsets.h; th=
en : '  UPD     include/generated/asm-offsets.h'; mv -f include/generated/.=
tmp_asm-offsets.h include/generated/asm-offsets.h; fi
set -e; mkdir -p include/generated/; trap "rm -f include/generated/.tmp_rq-=
offsets.h" EXIT; { 	 echo "#ifndef __RQ_OFFSETS_H__"; echo "#define __RQ_OF=
FSETS_H__"; echo "/*"; echo " * DO NOT MODIFY."; echo " *"; echo " * This f=
ile was generated by Kbuild"; echo " */"; echo ""; sed -ne 	's:^[[:space:]]=
*\.ascii[[:space:]]*"\(.*\)".*:\1:; /^->/{s:->#\(.*\):/* \1 */:; s:^->\([^ =
]*\) [\$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; s:->::; p;}' < kernel/=
sched/rq-offsets.s; echo ""; echo "#endif"; } > include/generated/.tmp_rq-o=
ffsets.h; if [ ! -r include/generated/rq-offsets.h ] || ! cmp -s include/ge=
nerated/rq-offsets.h include/generated/.tmp_rq-offsets.h; then : '  UPD    =
 include/generated/rq-offsets.h'; mv -f include/generated/.tmp_rq-offsets.h=
 include/generated/rq-offsets.h; fi
# CALL    ../scripts/checksyscalls.sh
  sh ../scripts/checksyscalls.sh powerpc-linux-musl-gcc -Wp,-MMD,./.missing=
-syscalls.d -nostdinc -I../arch/powerpc/include -I./arch/powerpc/include/ge=
nerated -I../include -I./include -I../arch/powerpc/include/uapi -I./arch/po=
werpc/include/generated/uapi -I../include/uapi -I./include/generated/uapi -=
include ../include/linux/compiler-version.h -include ../include/linux/kconf=
ig.h -include ../include/linux/compiler_types.h -D__KERNEL__ -mbig-endian -=
m32 -I ../arch/powerpc -fmacro-prefix-map=3D../=3D -Wundef -DKBUILD_EXTRA_W=
ARN1 -std=3Dgnu11 -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-s=
trict-aliasing -msoft-float -ffixed-r2 -mmultiple -mno-readonly-in-sdata -m=
cpu=3Dpowerpc -mno-prefixed -mno-pcrel -mno-altivec -mno-vsx -mno-mma -fno-=
asynchronous-unwind-tables -mno-string -mbig-endian -fno-delete-null-pointe=
r-checks -Os -fno-allow-store-data-races -fno-stack-protector -fomit-frame-=
pointer -ftrivial-auto-var-init=3Dzero -fno-stack-clash-protection -fmin-fu=
nction-alignment=3D4 -fstrict-flex-arrays=3D3 -fms-extensions -fno-strict-o=
verflow -fno-stack-check -fconserve-stack -fno-builtin-wcslen -Wall -Wextra=
 -Wundef -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int -We=
rror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-format-security -Wno-tr=
igraphs -Wno-frame-address -Wno-address-of-packed-member -Wmissing-declarat=
ions -Wmissing-prototypes -Wframe-larger-than=3D1280 -Wno-main -Wno-type-li=
mits -Wno-dangling-pointer -Wvla-larger-than=3D1 -Wno-pointer-sign -Wcast-f=
unction-type -Wno-array-bounds -Wno-stringop-overflow -Wno-alloc-size-large=
r-than -Wimplicit-fallthrough=3D5 -Werror=3Ddate-time -Werror=3Dincompatibl=
e-pointer-types -Werror=3Ddesignated-init -Wenum-conversion -Wunused -Wmiss=
ing-format-attribute -Wmissing-include-dirs -Wunused-const-variable -Wno-mi=
ssing-field-initializers -Wno-shift-negative-value -Wno-maybe-uninitialized=
 -Wno-sign-compare -Wno-unused-parameter -DGCC_PLUGINS -I../. -I.    -DKBUI=
LD_MODFILE=3D'"./missing-syscalls"' -DKBUILD_BASENAME=3D'"missing_syscalls"=
' -DKBUILD_MODNAME=3D'"missing_syscalls"' -D__KBUILD_MODNAME=3Dmissing_sysc=
alls
make -f ../scripts/Makefile.build obj=3Darch/powerpc/kernel/vdso include/ge=
nerated/vdso32-offsets.h
mkdir -p ./tools
make O=3D/home/linkmauve/dev/linux/wii subdir=3Dtools -C ../tools/ objtool
mkdir -p /home/linkmauve/dev/linux/wii/tools/objtool && make O=3D/home/link=
mauve/dev/linux/wii subdir=3Dtools/objtool --no-print-directory -C objtool
make -C /home/linkmauve/dev/linux/tools/build CFLAGS=3D LDFLAGS=3D /home/li=
nkmauve/dev/linux/wii/tools/objtool/fixdep
if [ ! -f /home/linkmauve/dev/linux/wii/tools/objtool/fixdep ]; then						\
	make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. obj=
=3Dfixdep HOSTCFLAGS=3D"-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 =
-fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include";	\
	rm -f /home/linkmauve/dev/linux/wii/tools/objtool/fixdep.o;						\
fi
make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. obj=3D=
fixdep HOSTCFLAGS=3D"-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fo=
mit-frame-pointer -std=3Dgnu11   -I ../scripts/include"
make -C /home/linkmauve/dev/linux/tools/lib/subcmd/ O=3D/home/linkmauve/dev=
/linux/wii/tools/objtool/libsubcmd \
	DESTDIR=3D/home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd prefix=3D =
subdir=3D \
	CC=3D"gcc" LD=3D"ld" AR=3D"ar" EXTRA_CFLAGS=3D"-std=3Dgnu11 -fomit-frame-p=
ointer -O2 -g -Werror -Wall -Wextra -Wmissing-prototypes -Wmissing-declarat=
ions -Wwrite-strings -Wno-implicit-fallthrough -Wno-sign-compare -Wno-unuse=
d-parameter -I/home/linkmauve/dev/linux/tools/include -I/home/linkmauve/dev=
/linux/tools/include/uapi -I/home/linkmauve/dev/linux/tools/arch/x86/includ=
e/uapi -I/home/linkmauve/dev/linux/tools/arch/powerpc/include -I/home/linkm=
auve/dev/linux/tools/objtool/include -I/home/linkmauve/dev/linux/tools/objt=
ool/arch/powerpc/include -I/home/linkmauve/dev/linux/wii/tools/objtool/libs=
ubcmd/include   " \
	/home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/libsubcmd.a install_=
headers
make -C /home/linkmauve/dev/linux/tools/build CFLAGS=3D LDFLAGS=3D /home/li=
nkmauve/dev/linux/wii/tools/objtool/libsubcmd/fixdep
if [ ! -f /home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/fixdep ]; t=
hen						\
	make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. obj=
=3Dfixdep HOSTCFLAGS=3D"-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 =
-fomit-frame-pointer -std=3Dgnu11   -I ../scripts/include";	\
	rm -f /home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/fixdep.o;					=
	\
fi
make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. obj=3D=
fixdep HOSTCFLAGS=3D"-Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fo=
mit-frame-pointer -std=3Dgnu11   -I ../scripts/include"
make[5]: 'install_headers' is up to date.
sh ./sync-check.sh
make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D. obj=3D=
objtool CC=3D"gcc" LD=3D"ld" AR=3D"ar" CFLAGS=3D"-std=3Dgnu11 -fomit-frame-=
pointer -O2 -g -Werror -Wall -Wextra -Wmissing-prototypes -Wmissing-declara=
tions -Wwrite-strings -Wno-implicit-fallthrough -Wno-sign-compare -Wno-unus=
ed-parameter -I/home/linkmauve/dev/linux/tools/include -I/home/linkmauve/de=
v/linux/tools/include/uapi -I/home/linkmauve/dev/linux/tools/arch/x86/inclu=
de/uapi -I/home/linkmauve/dev/linux/tools/arch/powerpc/include -I/home/link=
mauve/dev/linux/tools/objtool/include -I/home/linkmauve/dev/linux/tools/obj=
tool/arch/powerpc/include -I/home/linkmauve/dev/linux/wii/tools/objtool/lib=
subcmd/include   " \
	LDFLAGS=3D"/home/linkmauve/dev/linux/wii/tools/objtool/libsubcmd/libsubcmd=
=2Ea -lelf  "
make -f /home/linkmauve/dev/linux/tools/build/Makefile.build dir=3D./arch/p=
owerpc obj=3Dobjtool
sh ../scripts/rust_is_available.sh
make -f ../scripts/Makefile.build obj=3Drust
# RUSTC L rust/pin_init.o
  OBJTREE=3D/home/linkmauve/dev/linux/wii rustc --edition=3D2021 -Zbinary_d=
ep_depinfo=3Dy -Astable_features -Aunused_features -Dnon_ascii_idents -Duns=
afe_op_in_unsafe_fn -Wmissing_docs -Wrust_2018_idioms -Wunreachable_pub -Wc=
lippy::all -Wclippy::as_ptr_cast_mut -Wclippy::as_underscore -Wclippy::cast=
_lossless -Wclippy::ignored_unit_patterns -Wclippy::mut_mut -Wclippy::needl=
ess_bitwise_bool -Aclippy::needless_lifetimes -Wclippy::no_mangle_with_rust=
_abi -Wclippy::ptr_as_ptr -Wclippy::ptr_cast_constness -Wclippy::ref_as_ptr=
 -Wclippy::undocumented_unsafe_blocks -Wclippy::unnecessary_safety_comment =
-Wclippy::unnecessary_safety_doc -Wrustdoc::missing_crate_level_docs -Wrust=
doc::unescaped_backticks -Cpanic=3Dabort -Cembed-bitcode=3Dn -Clto=3Dn -Cfo=
rce-unwind-tables=3Dn -Ccodegen-units=3D1 -Csymbol-mangling-version=3Dv0 -C=
relocation-model=3Dstatic -Zfunction-sections=3Dn -Wclippy::float_arithmeti=
c --target=3Dpowerpc-unknown-linux-gnu -Copt-level=3Ds -Cdebug-assertions=
=3Dn -Coverflow-checks=3Dy @./include/generated/rustc_cfg --extern pin_init=
_internal --extern macros --cfg=3D'kernel' --emit=3Ddep-info=3Drust/.pin_in=
it.o.d --emit=3Dobj=3Drust/pin_init.o --emit=3Dmetadata=3Drust/libpin_init.=
rmeta --crate-type rlib -L./rust --crate-name pin_init ../rust/pin-init/src=
/lib.rs --sysroot=3D/dev/null -Zunstable-options   ; ./tools/objtool/objtoo=
l --static-call   rust/pin_init.o
error[E0463]: can't find crate for `pin_init_internal`
   --> ../rust/pin-init/src/lib.rs:365:11
    |
365 | pub use ::pin_init_internal::pin_data;
    |           ^^^^^^^^^^^^^^^^^ can't find crate

error: aborting due to 1 previous error

For more information about this error, try `rustc --explain E0463`.
make[3]: *** [../rust/Makefile:681: rust/pin_init.o] Error 1
make[2]: *** [/home/linkmauve/dev/linux/Makefile:1343: prepare] Error 2
make[1]: *** [/home/linkmauve/dev/linux/Makefile:248: __sub-make] Error 2
make[1]: Leaving directory '/home/linkmauve/dev/linux/wii'
make: *** [Makefile:248: __sub-make] Error 2
make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-musl- O=3Dwii W=3D1 V=3D1=
 -j1  1.15s user 0.56s system 100% cpu 1.695 total
```

>=20
> Regards,
> Mukesh
>=20
> > >=20
> > > We are actively working with our LLVM team to get the target for ppc,
> > > ppc64 and ppc64le in the rust compiler.
> > >=20
> > >=20
> > > [1] https://lore.kernel.org/all/20260204030507.8203-1-linkmauve@linkm=
auve.fr
> > > [2] https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gmai=
l.com
> > >=20
> > > Changelog:
> > > V9 -> V10:
> > > - rust/Makefile updated with review comments from Miguel
> > > - Patch 1/4 updated with commit message and subject
> > > V9: https://lore.kernel.org/all/20260404121610.1956528-1-mkchauras@gm=
ail.com/
> > >=20
> > > V8 -> V9:
> > > - rust/Makefile updated with a directory instead of abspath
> > > V8: https://lore.kernel.org/all/20260403145308.1042622-1-mkchauras@gm=
ail.com/
> > >=20
> > > V7 -> V8:
> > > - rust/Makefile updated to separate host libraries from target
> > > V7: https://lore.kernel.org/all/20260329160254.2592207-1-mkchauras@gm=
ail.com/
> > >=20
> > > Changelog:
> > > V6 -> V7:
> > > - Documentation removed as powerpc is still under development
> > > - Added a fix for race condition in rust/Makefile
> > > V6: https://lore.kernel.org/all/20260210090023.2587534-1-mkchauras@gm=
ail.com
> > >=20
> > > V5 -> V6:
> > > - Added a missing Tested by from Venkat which got missed since V3
> > > - Support is marked as Maintained instead of experimental
> > > V5: https://lore.kernel.org/all/20260210053756.2088302-1-mkchauras@gm=
ail.com
> > >=20
> > > V4 -> V5:
> > > - Removed a nested ifdef from PPC64 for Little endian toolchain
> > > V4: https://lore.kernel.org/all/20260209105456.1551677-1-mkchauras@gm=
ail.com
> > >=20
> > > V3 -> V4:
> > > - Co-developed-by header added in patch 1
> > > V3: https://lore.kernel.org/all/20260205180429.3280657-1-mkchauras@gm=
ail.com
> > >=20
> > > V2 -> V3:
> > > - Splited HAVE_RUST in 2 lines
> > > - BINDGEN_TARGET_powerpc initialized before assigning the same to
> > >   BINDGEN_TARGET
> > > V2: https://lore.kernel.org/all/20260204210125.613350-1-mkchauras@gma=
il.com
> > >=20
> > > V1 -> V2:
> > > - jump label fix for rust has been moved to a separate patch
> > > - PPC32 support has been taken
> > > - rust support has been marked experimental
> > > - target.json dependency has been removed
> > > - HAVE_RUST now depends on CPU_LITTLE_ENDIAN for PPC64
> > >=20
> > > Link Mauve (1):
> > >   rust: Add PowerPC support
> > >=20
> > > Mukesh Kumar Chaurasiya (IBM) (3):
> > >   rust: Fix "multiple candidates for rmeta dependency core" error
> > >   powerpc/jump_label: adjust inline asm to be consistent
> > >   powerpc: Enable Rust for ppc64le
> > >=20
> > >  arch/powerpc/Kconfig                  |  2 +
> > >  arch/powerpc/Makefile                 |  7 +++
> > >  arch/powerpc/include/asm/jump_label.h | 23 ++++++----
> > >  rust/Makefile                         | 66 ++++++++++++++++---------=
--
> > >  4 files changed, 61 insertions(+), 37 deletions(-)
> > >=20
> > > --=20
> > > 2.53.0
> > >=20
> > >=20
> >=20
> > --=20
> > Link Mauve
> >=20

--=20
Link Mauve

