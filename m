Message-ID: <8D4C69676E66D511A1CB00508BBBB19215796D@ranmx1.ran.harris.com>
From: "Fend, Matthias" <mfend@harris.com>
To: "'LinuxPPC-Embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: pcmcia problems
Date: Wed, 3 Apr 2002 03:55:32 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello everybody,

i'm trying to run pcmcia service (ISDNCard (Fritz PCMCIA V2.0) on a custom
mpc860 board.

i started with pcmcia-cs-3.1.33 i changed the  PCMCIA_MEM_WIN_BASE in
m8xx_pcmcia to 0xE0000000
i also implemented the adapter methods for the voltage selection

in /arch/ppc/mm/init.c  MMU_init(void)
i added the line
  ioremap(0xE0000000,0x1000);

i load the modules pcmcia_core.o ds.o and m8xx_pcmcia.o

the iopins (CD,VS,WP..) seem to work fine (tested with cardctl status 0)

but if i try to run
> ./cardctl ident 0
i only get:
> no product info available
> function: 2 (serial)
>sh-2.03#

if i turn debug on i get this message
cs: overrun in get_next_tuple for socket 0


so now it don't know if it is a software problem or a hardware problem...

Q1: any ideas what i could try in next step

Q2: what is the difference between MEM_BASE and IO_BASE

Q3: cardmgr always think that he detects an anonyoumous memory and start this
service .. is this caused by the
bad cis reading or is this another problem?

thx matthias

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
