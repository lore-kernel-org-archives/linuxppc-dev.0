Message-ID: <3D4FBE55.71B00BF7@irisa.fr>
Date: Tue, 06 Aug 2002 14:17:25 +0200
From: Romain Dolbeau <dolbeau@irisa.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Trouble compiling 2.5.30 on old powermac
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

first of all, a big thanks to all hackers for the 2.4.x
releases that have been fine for me for a looong time :-)

But to be able to port the "pm3fb" driver to 2.5, I need
a 2.5.x kernel. None of those I tried compiled.
Michel Dänzer suggested posting my problems here, so here
it is.

The box is an old 7500 upgraded with a 192Mhz 604e, running
Debian (used to be "woody", now it's "sarge"). binutils come
from Debian "sid" as I need the newer binutils for 2.5.
Additional hardware include an old mac-flashed Matrox
Millenium, and a Formac Proformance III video card (the one
that need pm3fb).

Source tree is linuxppc-2.5 from source.mvista.com,
through rsync.

1) at least 3 non-essential drivers cannot compile:
   the mac serial port, the mac floppy drive, and the
   external SCSI bus (53C94, MESH compiles). I can
   provide the errors if they're needed.

2) arch/ppc/kernel/process.c fails with:
#####
  gcc -Wp,-MD,./.process.o.d -D__KERNEL__ -I/usr/src/linuxppc-2.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -I/usr/src/linuxppc-2.5/arch/ppc -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring -nostdinc -iwithprefix include    -DKBUILD_BASENAME=process   -c -o process.o process.c
process.c: In function `set_fpexc_mode':
process.c:426: `PR_FP_EXC_PRECISE' undeclared (first use in this function)
process.c:426: (Each undeclared identifier is reported only once
process.c:426: for each function it appears in.)
make[2]: *** [process.o] Error 1
make[2]: Leaving directory `/usr/src/linuxppc-2.5/arch/ppc/kernel'
#####

Thanks in advance for any informations/advices/fixes/...

--
DOLBEAU Romain               |  Energy derives from both
ENS Cachan / Ker Lann        |    the plus and negative
Thesard IRISA / CAPS         |       -- Metallica,
dolbeaur@club-internet.fr    |           'Eye of the Beholder'

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
