Date: Thu, 12 Jul 2001 11:03:22 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200107121803.LAA22650@krakatoa.gigabitnetworks.com>
Subject: Re: ppc-linux EPIC (OpenPIC) and Interrupts on MPC8240
To: dan@mvista.com, linuxppc-embedded@lists.linuxppc.org,
	cort@cs.nmt.edu
Cc: jfd@cs.stanford.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Guys,

I installed hhl-host-kernel-2.4.2_hhl20-hhl2.0.1.noarch.rpm which has the
sandpoint lsp for any arch, and then I made the following mods to
open_pic.c and sandpoint_setup.c for my board which does not use the 8259
and rather, uses the EPIC in direct mode (IRQ0-4).


1) On OpenPIC discrete interrupt mode, in MPC8240-UM and from my working
   vxworks BSP, here is the call I added to openpic_init()

#define OPENPIC_CONFIG_SERIAL_INTS              (1<<27)
#define OPENPIC_CONFIG_DISCRETE_INTS            (1<<29)
#define OPENPIC_CONFIG_IN_RESET                 (1<<31)


static void openpic_discrete_mode(void)
{
  u_int t;

  if ( ppc_md.progress ) ppc_md.progress("openpic discrete mode\n",0x122);

  /* Reset and wait till done ... */
  openpic_reset();

  while ((t = openpic_read(&OpenPIC->Global.Global_Configuration0)) &
	 OPENPIC_CONFIG_IN_RESET)
    ;

  /* Discrete ints please */
  openpic_write(&OpenPIC->Global.Global_Configuration0,
                OPENPIC_CONFIG_DISCRETE_INTS);

  /* Set direct interrupts (disable serial interrupts) */
  t = openpic_read(&OpenPIC->Global.Global_Configuration1);
  openpic_write(&OpenPIC->Global.Global_Configuration1,
                t & ~OPENPIC_CONFIG_SERIAL_INTS);

  /* Clear all pending interrupts */
  while((t = openpic_readfield(&OpenPIC->THIS_CPU.Interrupt_Acknowledge,
			       OPENPIC_VECTOR_MASK)) != 0xff)
    ;
}


2) In openpic_get_irq(), comment out the chrp_int_ack stuff (like yours).

3) In sandpoint_init:

        /* ppc_md.irq_cannonicalize = NULL; */
        ppc_md.init_IRQ = sandpoint_init_IRQ;
        ppc_md.get_irq = openpic_get_irq;
        /* ppc_md.post_irq = NULL; */

4) In sandpoint_init_IRQ()

	OpenPIC_InitSenses = sandpoint_openpic_initsenses;
	OpenPIC_NumInitSenses = sizeof(sandpoint_openpic_initsenses);

	openpic_init(1, 0, NULL, -1);

5) Define:

static u_char sandpoint_openpic_initsenses[] __initdata = {
	0,	/* 0-15 not used by EPCI but by 8259 (std PC-type IRQs) */
	0,	/* 1 */
	0,	/* 2 */
	0,	/* 3 */
	0,	/* 4 */
	0,	/* 5 */
	0,	/* 6 */
	0,	/* 7 */
	0,	/* 8 */
	0,	/* 9 */
	0,	/* 10 */
	0,	/* 11 */
	0,	/* 12 */
	0,	/* 13 */
	0,	/* 14 */
	0,	/* 15 */
	/* MPC8240/EPIC in Direct mode (5 external interrupts) */
	1,	/* 16: EPIC IRQ 0: Unused */
	1,	/* 17: EPIC IRQ 1: DEC 21143 onboard 10/100 Enet */
	1,	/* 18: EPIC IRQ 2: CPCI IntA */
	1,	/* 19: EPIC IRQ 3: Local PCI Slot (Int{A,B,C,D} */
        0,	/* 20: EPIC IRQ 4: NS16550 UART COM1 */
	0,      /* 21: EPIC IRQ 5: Unused*/
	0,      /* 22: Unused */
	0,      /* 23: Unused */
	0,      /* 24: Unused */
	0,      /* 25: Unused */
	0,	/* 26: Unused */
	0,      /* 27: Unused */
	0,      /* 28: Unused */
	0,      /* 29: Unused */
	0,      /* 30: Unused */
	0,      /* 31: Unused */
};

Now, on the console, I edited drivers/char/serial.c and added:


static struct serial_state rs_table[RS_TABLE_SIZE] = {
        { 0, 9600, 0xffe08080, 20, ASYNC_BOOT_AUTOCONF,0,
	  PORT_16550, /* chip */
	  0, /*line*/
	  0, /*rev*/
	  0, /*tx fifo sz*/
	  0, /* custom div */
	  0, /* count */
	  0xffe08080, /* IO base */
	  0, /* shift */
	  0,0,0,0,0,
	  SERIAL_IO_MEM
	} /* ttyS0 */
};

Since my ns16550 UART is mapped (through a PLD) into PortX I/O space
at 0xffe08080.

Finally, I hacked up init/main.c with some PIO printf() routines (the
progress routine which does PIO on the 16550 for output) to tell me
where I am.

Alas, no luck. I see that init/main.c runs all the way to the idle loop,
but that damn openpic is not working, otherwise, I would be getting
interrupts. Is there some other way to debug this? Perhaps the init_senses
array is still wrong. I am not sure how to proceed. How would people
debug this? I am considering simply writing my own interrupt driver
based on code which I know works.



Many thanks in advance.

						-James


## Booting image at 00100000 ...
   Image Name:   vmlinux.bin.gz
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    658739 Bytes = 643 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): doneMMU:enterMMU:hash inithash:enterhash:find
piecehash:doneMMU:mapinMMU:setbatMMU:exitsetup_arch: entersetup_arch:
bootmemmpc10x:entermpc10x:exitarch: exitopenpic enteropenpic discrete mode
openpic timeropenpic extopenpic spuriousopenpic exitconsole_init

serial_out(ffe08083,00000093)

serial_out(ffe08080,00000001)

serial_out(ffe08081,00000000)

serial_out(ffe08083,00000013)

serial_out(ffe08081,00000000)

serial_out(ffe08084,00000003)

serial_in(ffe08085)
BogoMIPS:00000d6a
                 idle task started

serial_in(ffe08084)

serial_in(ffe08083)

serial_out(ffe08084,0000001a)

serial_in(ffe08086)

serial_out(ffe08084,000000ff)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
