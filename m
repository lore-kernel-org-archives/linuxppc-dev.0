Date: Tue, 1 Oct 2002 21:50:00 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Current rsync doesn't compile
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="134458388-1804289383-1033501808=:509"
Message-Id: <E17wT1z-00008E-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--134458388-1804289383-1033501808=:509
Content-Type: TEXT/plain; charset=us-ascii

Hi Ben,

Your current rsync tree doesn't compile due to this error with the IRDA
suppport:

make[3]: Entering directory `/usr/src/2.4/linux-2.4.benh/drivers/net/irda'
gcc -D__KERNEL__ -I/usr/src/2.4/linux-2.4.benh/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/usr/src/2.4/linux-2.4.benh/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -DMODULE  -nostdinc -iwithprefix include -DKBUILD_BASENAME=irtty  -c -o irtty.o irtty.c
irtty.c: In function `irtty_set_dtr_rts':
irtty.c:761: `TIOCM_MODEM_BITS' undeclared (first use in this function)
irtty.c:761: (Each undeclared identifier is reported only once
irtty.c:761: for each function it appears in.)
make[3]: *** [irtty.o] Error 1
make[3]: Leaving directory `/usr/src/2.4/linux-2.4.benh/drivers/net/irda'
make[2]: *** [_modsubdir_irda] Error 2
make[2]: Leaving directory `/usr/src/2.4/linux-2.4.benh/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: Leaving directory `/usr/src/2.4/linux-2.4.benh/drivers'
make: *** [_mod_drivers] Error 2

Searching around a bit it seems TIOCM_MODEM_BITS is not yet defined for
all arches; it is in your tree only for parisc (where this originated
from). The original patch from them seems to have included some other
arches, but that was not applied.

So, please apply something like the attached to make the kernel compile.
This is functionally equivalent to what existed before the half-applied
patch by the parisc people introduced  TIOCM_MODEM_BITS (see
http://lists.parisc-linux.org/pipermail/parisc-linux-cvs/2002-August/031396.html).

Thanks, and cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

--134458388-1804289383-1033501808=:509
Content-Type: TEXT/plain; name=patch
Content-Disposition: attachment; filename=patch

--- /usr/src/sources/2.4/linux-2.4.benh/include/asm-ppc/termios.h	Fri Jan  1 00:45:37 1904
+++ include/asm-ppc/termios.h	Tue Oct  1 21:34:31 2002
@@ -174,6 +174,9 @@
 #define TIOCM_OUT2	0x4000
 #define TIOCM_LOOP	0x8000

+/* IRDA support */
+#define TIOCM_MODEM_BITS	TIOCM_OUT2
+
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 #define TIOCSER_TEMT    0x01	/* Transmitter physically empty */


--134458388-1804289383-1033501808=:509--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
