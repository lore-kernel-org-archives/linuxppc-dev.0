Message-ID: <37E19581.D5837449@netx4.com>
Date: Thu, 16 Sep 1999 21:12:33 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: <sebastien_tadeoni@yahoo.fr>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cross compilation for MPC860
References: <19990917002315.B636D7B8@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> Anyway, here's the complete list of problems I had building the 2.2.5 snapshot
> for an 860T board.

The only likely 860T board to build with 2.2.5 is the FADS, and
I have not kept that up to date (which is why fec.c is out of date).


> The FEC driver fell through the cracks changing request_irq to request_8xxirq:

There is more that has to change if you are  not building for
a FADS board.  You have to assign the appropriate MII interrupts
and write the MMI command/status for the particular PHY you are
using.

The RPCg Classic and CLLF are both 860T boards.  I will update all
of the fec.c driver when I get a chance to port to those boards.



> The Makefile in arch/ppc/kernel includes openpic.o, i8259.o and pmac_pic.o
> whenever CONFIG_APUS isn't set; even though most other platforms don't want
> them either.
> 
> drivers/char/Makefile includes pc_keyb.o and defkeymap.o whenever the ARCH is
> not m68k, which means they get included in all embedded 8xx builds.
> 
> drivers/macintosh/Makefile includes via-cuda.o et al whenever CONFIG_MBX is
> not defined. I changed it like this:

You shouldn't have to change it for anything.  If your linker
is working properly, it isn't going to include those objects and
there is no harm in building them.
  

> 
> Lots of the EXPORT_SYMBOLs in arch/ppc/kernel/ppc_ksyms.c caused me grief;
> I had to wrap isa_io_base, isa_mem_base and pci_dram_offset in
> #ifdef CONFIG_PCI. I #if 0'd out _prep_type and ucSystemType, and all of:

Something is wrong with your tools or the configuration you have
selected.  None of these changes are necessary.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
