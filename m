Date: Tue, 7 Mar 2000 23:10:39 -0500
From: enneper <cesli@ewetel.net>
To: Andreas Tobler <toa@pop.agri.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCMCIA _i82365_ kernel 2.3.48 ?
Message-ID: <20000307231038.A398@gmx.li>
Reply-To: enneper@gmx.net
References: <20000307122746.A456@gmx.li> <38C4F5B3.4AF02E0B@pop.agri.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38C4F5B3.4AF02E0B@pop.agri.ch>; from Andreas Tobler on Tue, Mar 07, 2000 at 01:27:31PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



 Andreas Tobler }  Doing so, you'll get some steps further, but the build will fail  due to
 Andreas Tobler }  missing pci-functions. This is what I remember from doing so last time.

THX, first it works on the surface:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -fno-strict-aliasing -DMODULE   -DEXPORT_SYMTAB -c cs.c
cs.c: In function `pcmcia_request_irq':
cs.c:1794: warning: unused variable `mask'
cs.c:1793: warning: unused variable `try'
cs.c: At top level:
cs.c:2349: warning: `init_pcmcia_cs' defined but not used
cs.c:2365: warning: `exit_pcmcia_cs' defined but not used
ld  -r -o pcmcia_core.o cistpl.o rsrc_mgr.o bulkmem.o cs.o
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -fno-strict-aliasing -DMODULE   -c -o i82365.o i82365.c
i82365.c:110: warning: `do_scan' defined but not used
i82365.c:553: warning: `test_irq' defined but not used
i82365.c:737: warning: `add_socket' defined but not used
i82365.c:748: warning: `add_pcic' defined but not used
i82365.c:1499: warning: `init_i82365' defined but not used
i82365.c:1543: warning: `exit_i82365' defined but not used
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -fno-strict-aliasing -DMODULE   -c -o tcic.o tcic.c
tcic.c:379: warning: `init_tcic' defined but not used
tcic.c:516: warning: `exit_tcic' defined but not used
rm -f $TOPDIR/modules/PCMCIA_MODULES
echo ds.o pcmcia_core.o  i82365.o tcic.o >> $TOPDIR/modules/PCMCIA_MODULES
echo drivers/pcmcia/
drivers/pcmcia/
cd $TOPDIR/modules; for i in ds.o pcmcia_core.o  i82365.o tcic.o; do \
    ln -sf ../drivers/pcmcia//$i $i; done
make[2]: Leaving directory `/usr/src/linux-pmac-devel/drivers/pcmcia'

BUT, you remember correct:
Mar  7 22:50:12 arma kernel: Linux PCMCIA Card Services 3.1.11
Mar  7 22:50:12 arma kernel:   kernel build: 2.3.48 #12 Sun Mar 5 01:04:02 EST 2000
Mar  7 22:50:12 arma kernel:   options:  [pci]
Mar  7 22:50:12 arma kernel: ds: no socket drivers loaded!

anyhow, someone will fix it, kernel hacking is not mine.
greetings
Claus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
