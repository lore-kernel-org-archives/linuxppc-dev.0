Message-ID: <38E9D766.28A0BD27@ascom.ch>
Date: Tue, 04 Apr 2000 13:52:06 +0200
From: Ruedi Hofer <ruedi.hofer@ascom.ch>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
CC: erammsu@kieraypc01.p.y.ki.era.ericsson.se, kernel@linux01.hasler.ascom.ch
Subject: Re: Re: PCMCIA support for 860
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Well, I found out that I have to add in kernel/ksyms.c the line
EXPORT_SYMBOL(request_irq);

Now I'm able to load the different kernel modules, but

sh-2.03#
sh-2.03# insmod pcmcia_core
Linux PCMCIA Card Services 3.1.10
  kernel build: 2.2.13 #85 Tue Apr 4 10:26:49 CEST 2000
  options:  none
sh-2.03# insmod m8xx_pcmcia
m8xx_pcmcia: Version 0.03, 14-Feb-2000, Magnus Damm
m8xx_pcmcia: ADS using SLOT_A with IRQ 13.
sh-2.03# insmod ds
sh-2.03# insmod ide_cs
/lib/modules/2.2.13/pcmcia/ide_cs.o: unresolved symbol ide_unregister
/lib/modules/2.2.13/pcmcia/ide_cs.o: unresolved symbol ide_register
sh-2.03#

... I can't add the module ide_cs. For that reason, do I have to
enable 'Enhanced IDE support' in the kernel options??

If I do so, I get the following compile errors:

m8xx_setup.c: In function `m8xx_init_IRQ':
m8xx_setup.c:286: warning: implicit declaration of function `cpm_interrupt_init'
m8xx_setup.c: In function `m8xx_ide_init_hwif_ports':
m8xx_setup.c:390: warning: unused variable `port'
m8xx_setup.c: In function `m8xx_init':
m8xx_setup.c:522: structure has no member named `ide_request_irq'
make[1]: *** [m8xx_setup.o] Error 1
make[1]: Leaving directory
`/usr/src/linux-mpc8xx-2.2.13-damm-bossek-fpu-pcmcia/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

Why that?

--
Best regards

Ruedi Hofer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
