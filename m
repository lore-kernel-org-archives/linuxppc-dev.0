Message-ID: <3C109F56.7D6FBDC0@inn.ericsson.se>
Date: Fri, 07 Dec 2001 11:52:06 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: Armin Kuster <akuster@mvista.com>
Cc: ppcdevel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IBM 4xx drivers restructuring
References: <3C0FF72D.3B43D74A@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Armin Kuster wrote:
>
> I have hit the issue of trying to reuse some of the drivers from the
> 405GP to NP405 and have the following proposal for making it a bit
> easier for other 4xx cores.  Also my goal is to get the drivers smart
> enough so they can init any number of the same devices in the init
> code.  I am going to use the term "internal peripheral support (ips)"
> when referring to the support of these devices use in the 405GP, NP405H,
> NP405L, stb3xxx and stb4xxx.

Any reason to not call it On-Chip Peripherals (OCP)? That would sound more
like the IBM docs


> 2)  Centralize the ips register mapping.
>         I would like to  move the #defines and ethernet register struct and
> created some new ones to a asm-ppc/ibm_ips.h to eliminates replication
> of the same info. This file is included in the asm-platform/board.h file
> before the cpu header(ibm405gp.h, ibmnp405.h, etc.)

Would not the cpu core file (ibm405(CR|GP))file automatically include the
right peripherals? Why would I like to override that from the board
configuration?? After all it's not like it's possible to actually change
anything anyway.


>
> 4) Created new cpu.c
>         I would like to create cpu.c files to do some register inits and keeps
> this form being replicated in each board.c file.
> example:
> ibm_ips.h
>
> typedef struct emac_regs {....}emac_t;
>
> ibmnp405.h
>
> #define EMAC_BASE_1 0xef008000
> #define EMAC_NUMS 1
>
> ibm405.c
>
> const emac_t* EMAC_ADDR[]=
> {
>         (emac_t*) EMAC_BASE_1,
> };


hmm I don't know if this is a good idea. What I think you mean here is that
ibm405 only contain things that is common to all 405 chips and np405 only
changes or adds stuff that is specifict to this chip. But then there is 405CR
that don't even have ethernet, this sugests that we really don't know much
about how the peripherals is related in different chips.

The ibm405 file should probably only contain stuff that is related to the 405
CORE and the chip specfic file(ibmnp405) should include/define all the
peripherals directly.

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
