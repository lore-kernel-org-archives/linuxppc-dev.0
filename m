Subject: FEC driver doesn't compile
From: "Nikunj A. Dadhania" <nikunj.dadhania@fci.com>
To: Linux PPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1051259707.12150.60.camel@127.0.0.1>
Mime-Version: 1.0
Date: 25 Apr 2003 14:05:08 +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I was trying to compile the FEC driver without MDIO for PHY
configuration, it gives an error as follows:

I am using linux kernel 2.4.20 from kernel.org.

make[2]: Entering directory
`/build/usr/nikunj/work/atca/src/linux-2.4.20/arch/ppc/8xx_io'
powerpc-linux-gcc -D__KERNEL__
-I/build/usr/nikunj/work/atca/src/linux-2.4.20/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer
-I/build/usr/nikunj/work/atca/src/linux-2.4.20/arch/ppc -fsigned-char
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring
-mcpu=860   -nostdinc -iwithprefix include -DKBUILD_BASENAME=fec  -c -o
fec.o fec.c
fec.c: In function `fec_enet_init':
fec.c:1911: structure has no member named `old_status'
fec.c: At top level:
fec.c:1373: warning: `mii_link_interrupt' defined but not used
make[2]: *** [fec.o] Error 1


A quick look into the code of arch/ppc/8xx_io/fec.c, the
fec_enet_private structure has defined old_status under the
CONFIG_USE_MDIO define and in function fec_enet_init the variable
fec->old_status is accessed outside CONFIG_USE_MDIO.

I guess the old_status variable could be kept outside the
CONFIG_USE_MDIO in the structure declaration.

Is there any patch avaiable for the same?
Am I missing something?

Please comment

Thanks
Nikunj


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
