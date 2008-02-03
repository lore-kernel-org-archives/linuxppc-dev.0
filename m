Return-Path: <bernhard@intevation.de>
Received: from kolab.intevation.de (aktaia.intevation.org [212.95.126.10])
	by ozlabs.org (Postfix) with ESMTP id DEBFEDDE1E
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 03:59:33 +1100 (EST)
From: Bernhard Reiter <bernhard@intevation.de>
To: debian-powerpc@lists.debian.org
Subject: compile quirk linux-2.6.24 (with workaround)
Date: Sun, 3 Feb 2008 17:29:05 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2273785.q9goPjTH5Y";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200802031729.12069.bernhard@intevation.de>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2273785.q9goPjTH5Y
Content-Type: multipart/mixed;
  boundary="Boundary-01=_TvepHCewSVEVwkp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_TvepHCewSVEVwkp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear linux powerpc Maintainers and Users,

recently I have tried to compile a new kernel on a Debian sarge ppc
system (PowerBook5,6 MacRISC3 Power Macintosh).

The build system bailed out with
       BOOTCC  arch/powerpc/boot/4xx.o
        cc1: error: bad value (440) for -mcpu=3D switch
        make[1]: *** [arch/powerpc/boot/4xx.o] Fehler 1

I have tracked this a few steps and the attached patch made the compile for=
 me
as my compiler gcc-Version 3.3.5 (Debian 1:3.3.5-13)=20
cannot produce code for 4xx it seems.

The "ARCH=3Dppc64" I have came about also looked wrong, but I do not know
if this part of the patch is really necessary.
It is just a workaround, as I have no insight of what is really going wrong.

I hope my report is useful,
Bernhard

Details:
I have used "make oldconfig" with a 2.6.17 kernel and answered some questio=
ns.
Here is the first section of the .config I've ended up with:


# CONFIG_PPC64 is not set

#
# Processor support
#
CONFIG_6xx=3Dy
# CONFIG_PPC_85xx is not set
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_E200 is not set
CONFIG_PPC_FPU=3Dy
CONFIG_ALTIVEC=3Dy
CONFIG_PPC_STD_MMU=3Dy
CONFIG_PPC_STD_MMU_32=3Dy
# CONFIG_PPC_MM_SLICES is not set
# CONFIG_SMP is not set
CONFIG_PPC32=3Dy
CONFIG_WORD_SIZE=3D32
CONFIG_PPC_MERGE=3Dy
CONFIG_MMU=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy
CONFIG_GENERIC_TIME=3Dy
CONFIG_GENERIC_TIME_VSYSCALL=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_IRQ_PER_CPU=3Dy
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_ARCH_HAS_ILOG2_U32=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
CONFIG_PPC=3Dy
CONFIG_EARLY_PRINTK=3Dy
CONFIG_GENERIC_NVRAM=3Dy
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_PPC_OF=3Dy
CONFIG_OF=3Dy
CONFIG_PPC_UDBG_16550=3Dy
# CONFIG_GENERIC_TBSYNC is not set
CONFIG_AUDIT_ARCH=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_SYS_SUPPORTS_APM_EMULATION=3Dy
# CONFIG_DEFAULT_UIMAGE is not set
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"




=2D-=20
Managing Director - Owner: www.intevation.net       (Free Software Company)
Germany Coordinator: fsfeurope.org. Coordinator: www.Kolab-Konsortium.com.
Intevation GmbH, Osnabr=FCck, DE; Amtsgericht Osnabr=FCck, HRB 18998
Gesch=E4ftsf=FChrer Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner

--Boundary-01=_TvepHCewSVEVwkp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.6.24-rc7.fix.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linux-2.6.24-rc7.fix.diff"

diff -ur linux-2.6.24-rc7/arch/powerpc/boot/Makefile linux-2.6.24-rc7.new/a=
rch/powerpc/boot/Makefile
=2D-- linux-2.6.24-rc7/arch/powerpc/boot/Makefile	2008-01-20 21:31:13.54435=
7150 +0100
+++ linux-2.6.24-rc7.new/arch/powerpc/boot/Makefile	2008-01-15 00:05:14.935=
750138 +0100
@@ -49,13 +49,13 @@
 src-wlib :=3D string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_mis=
c.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
=2D		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
+		mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
 		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
 		fsl-soc.c mpc8xx.c pq2.c
 src-plat :=3D of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
=2D		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
+		cuboot-pq2.c cuboot-sequoia.c cuboot-bamboo.c \
 		fixed-head.S ep88xc.c cuboot-hpc2.c
 src-boot :=3D $(src-wlib) $(src-plat) empty.c
=20
Nur in linux-2.6.24-rc7.new/arch/powerpc/boot: zImage.coff.
Nur in linux-2.6.24-rc7.new/arch/powerpc/boot: zImage.miboot.
Nur in linux-2.6.24-rc7.new/arch/powerpc/kernel: vmlinux.lds.
diff -ur linux-2.6.24-rc7/arch/powerpc/Makefile linux-2.6.24-rc7.new/arch/p=
owerpc/Makefile
=2D-- linux-2.6.24-rc7/arch/powerpc/Makefile	2008-01-20 21:31:13.524359050 =
+0100
+++ linux-2.6.24-rc7.new/arch/powerpc/Makefile	2008-01-14 23:48:30.58375013=
8 +0100
@@ -165,7 +165,8 @@
 boot :=3D arch/$(ARCH)/boot
=20
 $(BOOT_TARGETS): vmlinux
=2D	$(Q)$(MAKE) ARCH=3Dppc64 $(build)=3D$(boot) $(patsubst %,$(boot)/%,$@)
+	$(Q)$(MAKE) ARCH=3Dpowerpc $(build)=3D$(boot) $(patsubst %,$(boot)/%,$@)
+# $(Q)$(MAKE) ARCH=3Dppc64 $(build)=3D$(boot) $(patsubst %,$(boot)/%,$@)
=20
 define archhelp
   @echo '* zImage          - Compressed kernel image (arch/$(ARCH)/boot/zI=
mage.*)'

--Boundary-01=_TvepHCewSVEVwkp--

--nextPart2273785.q9goPjTH5Y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.5 (GNU/Linux)

iD8DBQBHpevXh9ag3dpKERYRAuWEAJ9UrqE2dpnkf3OTZji16hnA9zWC0wCgvla+
P8p3bH05KV1nQ2cfUlHlA9k=
=Ezkj
-----END PGP SIGNATURE-----

--nextPart2273785.q9goPjTH5Y--
