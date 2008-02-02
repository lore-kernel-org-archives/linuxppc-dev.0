Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	by ozlabs.org (Postfix) with ESMTP id 9C500DDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Feb 2008 15:22:06 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: build is broken
Date: Fri, 1 Feb 2008 20:22:03 -0800
Message-ID: <F795765B112E7344AF36AA911279641502D1AA29@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <20080201212408.1bdf4acd@zod.rchland.ibm.com>
References: <F795765B112E7344AF36AA911279641502D1AA28@xmb-sjc-212.amer.cisco.com>
	<20080201212408.1bdf4acd@zod.rchland.ibm.com>
From: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Josh Boyer [mailto:jwboyer@gmail.com]=20
> Sent: Friday, February 01, 2008 7:24 PM
> To: Bizhan Gholikhamseh (bgholikh)
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: build is broken
>=20
> On Fri, 1 Feb 2008 15:23:21 -0800
> "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com> wrote:
>=20
> > Hi
> > I just downloaded the latest source tree from :
> > git://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> >=20
> > I am using gnu cross compiler version 3.4.3. I get the an "awk" and=20
> > "assmbeler" error.
> >=20
> > Please help me out. Thanks
> >=20
> > $ <mailto:bizhan@PPC]$>  make ARCH=3Dpowerpc
> > CROSS_COMPILE=3Dpowerpc-linux-gnu- uImage
> > awk: cmd. line:1: (FILENAME=3D- FNR=3D2) fatal: attempt to=20
> access field -1
> >   CHK     include/linux/version.h
> >   CHK     include/linux/utsrelease.h
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/linux/compile.h
> >   CALL    arch/powerpc/kernel/systbl_chk.sh
> >   LD      vmlinux.o
> >   MODPOST vmlinux.o
> > WARNING: vmlinux.o(.meminit.text+0x9f8): Section mismatch=20
> in reference=20
> > from the function free_area_init_node() to the function
> > .init.text:__alloc_bootmem_node()
> > The function __meminit free_area_init_node() references a function=20
> > __init __alloc_bootmem_node().
> > If free_area_init_node is only used by __alloc_bootmem_node then=20
> > annotate free_area_init_node with a matching annotation.
> > =20
> >   AS      .tmp_kallsyms2.o
> >   LD      vmlinux
> >   SYSMAP  System.map
> >   SYSMAP  .tmp_System.map
> >   BOOTCC  arch/powerpc/boot/treeboot-walnut.o
> > Assembler messages:
> > Error: Internal assembler error for instruction icbt=20
> Internal error,=20
> > aborting at=20
> >=20
> /usr/src/RPM/BUILD/crosstool/source/binutils-2.15/gas/config/tc-ppc.c
> > line 1300 in ppc_setup_opcodes
> > Please report this bug.
> > make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2
> > make: *** [uImage] Error 2
>=20
> I have no idea why you would get that if you have a properly=20
> built toolchain.  Can you do a fresh compile with V=3D1 set?
>=20
> josh
>
I did the fresh build with V=3D1. I still get the same awk error and the
compile's last line output:
  powerpc-linux-gnuspe-gcc -m32
-Wp,-MD,arch/powerpc/boot/.treeboot-walnut.o.d -Wall -Wundef
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -Os -msoft-float
-pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc -isystem
/opt/Embedix/usr/local/powerpc-linux-gnuspe/gcc-3.4.3-e500-glibc-2.3.3-s
pe/lib/gcc/powerpc-linux-gnuspe/3.4.3/include -Iarch/powerpc/boot
-I/home/bizhan/PPC/arch/powerpc/boot
-I/home/bizhan/PPC/arch/powerpc/boot/libfdt -mcpu=3D405 -c -o
arch/powerpc/boot/treeboot-walnut.o arch/powerpc/boot/treeboot-walnut.c
Assembler messages:
Error: Internal assembler error for instruction icbt
Internal error, aborting at
/usr/src/RPM/BUILD/crosstool/source/binutils-2.15/gas/config/tc-ppc.c
line 1300 in ppc_setup_opcodes
Please report this bug.
make[1]: *** [arch/powerpc/boot/treeboot-walnut.o] Error 2
make: *** [uImage] Error 2

Any help greatly apprieciated.

Thanks,
Bizhan
