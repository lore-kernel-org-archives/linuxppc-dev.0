Message-ID: <3C164380.33078521@mvista.com>
Date: Tue, 11 Dec 2001 09:33:52 -0800
From: Armin Kuster <Darth_vapor@mvista.com>
MIME-Version: 1.0
To: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
Cc: Armin Kuster <akuster@mvista.com>,
	ppcdevel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IBM 4xx drivers restructuring
References: <3C0FF72D.3B43D74A@mvista.com> <3C109F56.7D6FBDC0@inn.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kenneth Johansson wrote:
>
> Armin Kuster wrote:
> >
> > I have hit the issue of trying to reuse some of the drivers from the
> > 405GP to NP405 and have the following proposal for making it a bit
> > easier for other 4xx cores.  Also my goal is to get the drivers smart
> > enough so they can init any number of the same devices in the init
> > code.  I am going to use the term "internal peripheral support (ips)"
> > when referring to the support of these devices use in the 405GP, NP405H,
> > NP405L, stb3xxx and stb4xxx.
>
> Any reason to not call it On-Chip Peripherals (OCP)? That would sound more
> like the IBM docs

 Sounds better...OCP is more descriptive

>
> > 2)  Centralize the ips register mapping.
> >         I would like to  move the #defines and ethernet register struct and
> > created some new ones to a asm-ppc/ibm_ips.h to eliminates replication
> > of the same info. This file is included in the asm-platform/board.h file
> > before the cpu header(ibm405gp.h, ibmnp405.h, etc.)
>
> Would not the cpu core file (ibm405(CR|GP))file automatically include the
> right peripherals? Why would I like to override that from the board
> configuration?? After all it's not like it's possible to actually change
> anything anyway.
>

I does not over ride anything in the board configuration.  The header
only centilized the OCP structs & #defines into one file.  If I do it in
the core files then I am replicating info.

> >
> > 4) Created new cpu.c
> >         I would like to create cpu.c files to do some register inits and keeps
> > this form being replicated in each board.c file.
> > example:
> > ibm_ips.h
> >
> > typedef struct emac_regs {....}emac_t;
> >
> > ibmnp405.h
> >
> > #define EMAC_BASE_1 0xef008000
> > #define EMAC_NUMS 1
> >
> > ibm405.c
> >
> > const emac_t* EMAC_ADDR[]=
> > {
> >         (emac_t*) EMAC_BASE_1,
> > };
>
> hmm I don't know if this is a good idea. What I think you mean here is that
> ibm405 only contain things that is common to all 405 chips and np405 only
> changes or adds stuff that is specifict to this chip. But then there is 405CR
> that don't even have ethernet, this sugests that we really don't know much
> about how the peripherals is related in different chips.
>
> The ibm405 file should probably only contain stuff that is related to the 405
> CORE and the chip specfic file(ibmnp405) should include/define all the
> peripherals directly.
>

The OCP are pci, uart, gpio, opb, i2c, ide ,emac & zmii and are what
help define the GP or L or H.  I am not addressing things that
differentiate between cores. 403 , 405 etc.


-- armin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
