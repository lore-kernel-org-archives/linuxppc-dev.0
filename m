Message-ID: <3C0FF72D.3B43D74A@mvista.com>
Date: Thu, 06 Dec 2001 14:54:37 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: ppcdevel <linuxppc-dev@lists.linuxppc.org>
Subject: IBM 4xx drivers restructuring
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have hit the issue of trying to reuse some of the drivers from the
405GP to NP405 and have the following proposal for making it a bit
easier for other 4xx cores.  Also my goal is to get the drivers smart
enough so they can init any number of the same devices in the init
code.  I am going to use the term "internal peripheral support (ips)"
when referring to the support of these devices use in the 405GP, NP405H,
NP405L, stb3xxx and stb4xxx.

1) Menuconfig change
	I would like to use a single CONFIG_<mfg>_IPS to enable a given driver
instead of "if 405gp -o np405 " so that the config.in is a bit cleaner.
This config variable will be a bool defined in the /platform/config.in
in the board sections.

2)  Centralize the ips register mapping.
	I would like to  move the #defines and ethernet register struct and
created some new ones to a asm-ppc/ibm_ips.h to eliminates replication
of the same info. This file is included in the asm-platform/board.h file
before the cpu header(ibm405gp.h, ibmnp405.h, etc.)

3) Centralize the defined base address and number for each of the ips
into the processor headers.
	I would like to move the defines out of the drivers and into a single
place.

4) Created new cpu.c
	I would like to create cpu.c files to do some register inits and keeps
this form being replicated in each board.c file.
example:
ibm_ips.h

typedef struct emac_regs {....}emac_t;

ibmnp405.h

#define	EMAC_BASE_1 0xef008000
#define EMAC_NUMS 1

ibm405.c

const emac_t* EMAC_ADDR[]=
{
	(emac_t*) EMAC_BASE_1,
};

5) Change drivers to loop though and initialize for any number of
devices.
	In ther current state, many of the 405/4xx drivers can not be easily
reused.  Whith the above changes and driver restructuring, porting a new
405 processor model shoul dony require two file changes. its cpu.h and
cpu.c


I have changed the ethernet driver all ready and does init two emacs on
the cedar.


feedback


-- armin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
