Content-Type: text/plain;
  charset="iso-8859-1"
From: Paul Ruhland <pruhland@rochester.rr.com>
To: "Steve Clarke" <steve.clarke@overturenetworks.com>
Subject: Re: PCMCIA on MBX860
Date: Sun, 4 Feb 2001 13:49:50 -0500
References: <HCELKHHHIOJIDLBGAKBCKECFCAAA.steve.clarke@overturenetworks.com>
In-Reply-To: <HCELKHHHIOJIDLBGAKBCKECFCAAA.steve.clarke@overturenetworks.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Message-Id: <01020413495000.00647@kanga>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Saturday 03 February 2001 13:34, Steve Clarke wrote:
> I would like to get PCMCIA working on an MBX860 running HardHat. There was
> a thread in Nov 2000 on this topic between Paul Ruhland and Matthew Locke.
> Based on this thread, I started with pcmcia-cs-3.1.24.
>
> However, in 3.1.24 m8xx_pcmcia.c does not have references to the MBX board.
> It supports RPXxxx, ADS and FADS. Paul's email on 11-21-2000 said that he
> made MBX specific changes. Are these changes publicly available? If so, how
> do I get these changes?
>

Steve,

I will send you the changes for the MBX860 in another reply tomorrow (
20010205 ).  All of that code is presently on my work machine.

There are additions to 'pcmcia-cs-3.1.24/modules/m8xx_pcmcia.c' for board
specific voltage_set, hardware enable, and hardware disable.   If you have
the MBX860 docs you may want to look at the CSR configuration...using the
hardware specific code already present in 'm8xx_pcmcia.c' you could add
support for the MBX...its not really to involved...basically you have to
control the pcmcia reset, buffer enable, and voltage select lines.

Also, some things to check to get the card services and socket driver running
on ppc:

After 'make install', assuming your using the SysV script layout, you have to
edit '/etc/sysconfig/pcmcia' ( on your target filesystem ) and change the
following line:

  PCIC=i82365

to this:

  PCIC=m8xx_pcmcia

Also, the 'pcmcia-cs-3.1.24/modules/cs.c' module is responsible for telling
the card driver which interrupt to use.  This code seems broken for the
mpc850/860 ( always uses interrupt 0, which won't work ).  I ended up
hardcoding this interrupt to 11 for both boards I've gotten pcmcia working on
( MBX860 and TQM850L ).  In 'pcmcia-cs-3.1.24/modules/cs.c', in the
'cs_request_irq' function, I changed the initialization of the 'irq' var from
0 to 11.  This is not the best solution but I haven't had time to do a proper
fix.  It has to do with the fact that pcmcia on mpc850/860 is neither ISA or
PCI so the default just falls thru that function.

Also, I've experienced problems with the installed '/etc/pcmcia/network'
script...I would lose my nfs connection ( on eth0 ... SCCx ) when it tries to
bring up the pcmcia interface.   I ended up writing a much simpler script
that just does the required 'ifconfig ...' to bring up the interface.  I will
send you this as well...if your not using a network card it really doesn't
affect you.

There are also changes to the kernel...specifically in
'linux/include/asm-ppc/mpc8xx.h' and 'linux/arch/ppc/mm/init.c'.  You have to
ioremap the PCMCIA_IO_ADDR or the kernel will panic when it tries setup the
serial io during boot and of course the card services won't work with out it.
Here is the relevant changes required in 'mpc8xx.h':

/* Currently, all 8xx boards that support a processor to PCI/ISA bridge
 * use the same memory map.
 */
#if defined(CONFIG_PCI) && defined(PCI_ISA_IO_ADDR)
#define	_IO_BASE PCI_ISA_IO_ADDR
#define	_ISA_MEM_BASE PCI_ISA_MEM_ADDR
#define PCI_DRAM_OFFSET 0x80000000
#else
//#define _IO_BASE         0
#define _IO_BASE           0xEC000000   /* PCMCIA_IO_ADDR in board header */
#define _IO_BASE_SIZE  0x1000           /* PCMCIA_IO_SIZE */
#define _ISA_MEM_BASE   0
#define PCI_DRAM_OFFSET 0
#endif

For the MBX, I didn't use the board specific header defined
PCMCIA_IO_ADDR/PCMCIA_IO_SIZE because it contained a 'uint' reference that is
unknown to this section of code during compile.  You must make sure this
address/size is the same one used by the pcmcia card services as well...it
uses the board specific header from the kernel source tree so it should be
ok.  You may want to just remove the '(uint)' from
the'linux/include/asm-ppc/mbx.h' PCMCIA_IO_ADDR and PCMCIA_IO_SIZE
defines...this way you will be sure the kernel and pcmcia code are using the
same values.  Also, while your at it, change the defined PCMCIA_IO_SIZE to
0x1000.

In 'linux/arch/ppc/mm/init.c' at approx. line 1160 you have to do the ioremap:

#ifdef CONFIG_MBX
        ioremap(NVRAM_ADDR, NVRAM_SIZE);
        ioremap(MBX_CSR_ADDR, MBX_CSR_SIZE);
        ioremap(PCI_CSR_ADDR, PCI_CSR_SIZE);

	/* Map some of the PCI/ISA I/O space to get the IDE interface.
	*/
        ioremap(PCI_ISA_IO_ADDR, 0x4000);
        ioremap(PCI_IDE_ADDR, 0x4000);

        /* map the pcmcia io space */
        ioremap( PCMCIA_IO_ADDR, 0x1000);
#endif
#

I hope this wasn't too confusing...

-------------------------------
Paul Ruhland
Micrwave Data Systems Inc.
175 Science Parkway
Rochester, NY 14620
TEL: +1.716.242.8372
EMAIL: pruhland@microwavedata.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
