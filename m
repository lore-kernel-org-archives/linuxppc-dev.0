Message-Id: <199812181410.PAA23866@kieray1>
Date: Fri, 18 Dec 1998 15:10:48 +0100 (MET)
From: Magnus Damm <eramdam@kieray1.p.y.ki.era.ericsson.se>
Reply-To: Magnus Damm <eramdam@kieray1.p.y.ki.era.ericsson.se>
Subject: Re:MPX860 : MBX_IMAP_ADDR undefined
To: linuxppc-dev@lists.linuxppc.org
Cc: kd@flaga.is
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>I could not find patch that adds this symbol, so I wanted to ask if sombody
>knows where to find a patch?

I haven't found any patch, but here's my changes to make 2.1.130 to work
on my MBX860 board.

edit Makefile, arch/ppc/Makefile, arch/ppc/coffboot/Makefile

errors:

arch/ppc/kernel/irq.c		MBX_IMAP_ADDR -> IMAP_ADDR
				corrected in 1.87

arch/ppc/kernel/process.c	prom_print(buf); -> //prom_print(buf);
				//?

arch/ppc/kernel/mbx_setup.c	mbx_cpm_reset() -> m8xx_cpm_reset()
				* cort added adbdev_init and powermac_init *
				corrected in 1.4

arch/ppc/kernel/setup.c		the good-old &res -> res
				corrected in 1.119

arch/ppc/kernel/time.c		MBX_IMAP_ADDR -> IMAP_ADDR
				the good-old &res -> res
				corrected in 1.38

arch/ppc/kernel/Makefile	feature.o not used by mbx
				corrected in 1.45

arch/ppc/mm/init.c		MBX_IMAP_ADDR -> IMAP_ADDR
				MBX_IMAP_SIZE -> IMAP_SIZE
				the good-old &res -> res
				corrected in 1.134

arch/ppc/8xx_io/enet.c		MBX_IMAP_ADDR -> IMAP_ADDR
				mbx_cpm_dpalloc() -> m8xx_cpm_dpalloc()
				corrected in 1.8

drivers/char/mem.c		adbdev_init - CONFIG_PPC fault.

init/main.c			powermac_init(); -> //powermac_init();
				1.162


Good luck!

/ Magnus



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
