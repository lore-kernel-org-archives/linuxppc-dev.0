Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C641ADDEF5
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 13:40:59 +1100 (EST)
Date: Mon, 2 Mar 2009 18:40:49 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: powerpc allnoconfig
Message-Id: <20090302184049.27a73395.akpm@linux-foundation.org>
In-Reply-To: <12051.1236047470@neuling.org>
References: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
	<12051.1236047470@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 03 Mar 2009 13:31:10 +1100 Michael Neuling <mikey@neuling.org> wrote:

> > make mrproper
> > make allnoconfig
> > make vmlinux
> > 
> > gives:
> > 
> > scripts/kconfig/conf -s arch/powerpc/Kconfig
> >   CHK     include/linux/version.h
> >   UPD     include/linux/version.h
> >   CHK     include/linux/utsrelease.h
> >   UPD     include/linux/utsrelease.h
> >   SYMLINK include/asm -> include/asm-powerpc
> >   HOSTCC  scripts/ihex2fw
> >   HOSTCC  scripts/kallsyms
> >   HOSTCC  scripts/conmakehash
> >   CC      scripts/mod/empty.o
> >   HOSTCC  scripts/mod/mk_elfconfig
> > scripts/mod/empty.c:1: error: -m64 requires a PowerPC64 cpu
> > make[2]: *** [scripts/mod/empty.o] Error 1
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [scripts/mod] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [scripts] Error 2
> 
> I can't replicate this with Linus' latest tree with gcc 4.3 or 4.0.

ho hum.

> What's your tool chain?  Does it compile 32 or 64bit by default?

It's a cross-compiler: http://userweb.kernel.org/~akpm/cross-compilers/

Here's a `make V=1':

rm -f include/config/kernel.release
echo 2.6.29-rc6 > include/config/kernel.release
set -e; : '  CHK     include/linux/version.h'; mkdir -p include/linux/; 	(echo \#define LINUX_VERSION_CODE 132637; echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))';) < /usr/src/25/Makefile > include/linux/version.h.tmp; if [ -r include/linux/version.h ] && cmp -s include/linux/version.h include/linux/version.h.tmp; then rm -f include/linux/version.h.tmp; else : '  UPD     include/linux/version.h'; mv -f include/linux/version.h.tmp include/linux/version.h; fi
set -e; : '  CHK     include/linux/utsrelease.h'; mkdir -p include/linux/; 	if [ `echo -n "2.6.29-rc6" | wc -c ` -gt 64 ]; then echo '"2.6.29-rc6" exceeds 64 characters' >&2; exit 1; fi; (echo \#define UTS_RELEASE \"2.6.29-rc6\";) < include/config/kernel.release > include/linux/utsrelease.h.tmp; if [ -r include/linux/utsrelease.h ] && cmp -s include/linux/utsrelease.h include/linux/utsrelease.h.tmp; then rm -f include/linux/utsrelease.h.tmp; else : '  UPD     include/linux/utsrelease.h'; mv -f include/linux/utsrelease.h.tmp include/linux/utsrelease.h; fi
set -e; if [ -L include/asm ]; then asmlink=`readlink include/asm | cut -d '-' -f 2`; if [ "$asmlink" != "powerpc" ]; then echo "ERROR: the symlink include/asm points to asm-$asmlink but asm-powerpc was expected"; echo "       set ARCH or save .config and run 'make mrproper' to fix it"; exit 1; fi; test -e $asmlink || rm include/asm; elif [ -d include/asm ]; then echo "ERROR: include/asm is a directory but a symlink was expected"; exit 1; fi
make -f scripts/Makefile.build obj=scripts/basic
if [ ! -L include/asm ]; then : '  SYMLINK include/asm -> include/asm-powerpc'; if [ ! -d include/asm-powerpc ]; then mkdir -p include/asm-powerpc; fi; ln -fsn asm-powerpc include/asm; fi
mkdir -p .tmp_versions 
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=scripts/mod
  /opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-gcc -Wp,-MD,scripts/mod/.empty.o.d  -nostdinc -isystem /opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/lib/gcc/powerpc64-unknown-linux-gnu/4.1.0/./include -Iinclude  -I/usr/src/25/arch/powerpc/include -include include/linux/autoconf.h -D__KERNEL__ -Iarch/powerpc -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -O2 -msoft-float -pipe -Iarch/powerpc -ffixed-r2 -mmultiple -mno-altivec -mno-spe -mspe=no -funit-at-a-time -mno-string -mcpu=powerpc -Wa,-maltivec -fno-stack-protector -fomit-frame-pointer -Wdeclaration-after-statement -Wno-pointer-sign  -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(empty)"  -D"KBUILD_MODNAME=KBUILD_STR(empty)"  -c -o scripts/mod/empty.o scripts/mod/empty.c
scripts/mod/empty.c:1: error: -m64 requires a PowerPC64 cpu
make[2]: *** [scripts/mod/empty.o] Error 1
make[1]: *** [scripts/mod] Error 2
make: *** [scripts] Error 2
**FAILED**
