Subject: Re: Cross compilation for MPC860
To: sebastien_tadeoni@yahoo.fr (sibastien tadioni)
Date: Fri, 17 Sep 1999 10:23:15 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <19990916125231.12806.rocketmail@web601.yahoomail.com> from "sibastien tadioni" at Sep 16, 99 02:52:31 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19990917002315.B636D7B8@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


=?iso-8859-1?q?s=E9bastien=20tad=E9oni?= writes:
> I have no problem for installing binutils-2.2.1.0.19a.
> But during the make of egcs-core-1.1.2, some command like
> 'powerpc-linux-ar' were unknown.

Any particular reason for using old versions of binutils & egcs?

My suggestion is that if you're just starting out, now is the best time to
make sure you're using the latest gcc (2.95.1) and binutils. You have to make
a tiny mod to the gcc specs file if you use binutils 2.9.1, because the name of
the linker emulation has changed since the last binutils release. I'm currently
using the binutils-990809 snapshot. Haven't actually run any code it produces
yet though.

Anyway, here's the complete list of problems I had building the 2.2.5 snapshot
for an 860T board. All these are fixed in the 2.3.18 snapshot, but you may not
want to be on the bleeding edge yet:

The FEC driver fell through the cracks changing request_irq to request_8xxirq:


*** arch/ppc/8xx_io/fec.c.dist	Wed Aug 11 12:56:00 1999
--- arch/ppc/8xx_io/fec.c	Wed Aug 11 12:56:27 1999
***************
*** 981,989 ****
  	/* Install our interrupt handlers.  The 860T FADS board uses
  	 * IRQ2 for the MII interrupt.
  	 */
! 	if (request_irq(FEC_INTERRUPT, fec_enet_interrupt, 0, "fec", dev) != 0)
  		panic("Could not allocate FEC IRQ!");
! 	if (request_irq(SIU_IRQ2, mii_link_interrupt, 0, "mii", dev) != 0)
  		panic("Could not allocate MII IRQ!");
  
  	dev->base_addr = (unsigned long)fecp;
--- 981,989 ----
  	/* Install our interrupt handlers.  The 860T FADS board uses
  	 * IRQ2 for the MII interrupt.
  	 */
! 	if (request_8xxirq(FEC_INTERRUPT, fec_enet_interrupt, 0, "fec", dev) != 0)
  		panic("Could not allocate FEC IRQ!");
! 	if (request_8xxirq(SIU_IRQ2, mii_link_interrupt, 0, "mii", dev) != 0)
  		panic("Could not allocate MII IRQ!");
  
  	dev->base_addr = (unsigned long)fecp;


On similar lines, kernel/ksyms.c includes an EXPORT_SYMBOL of request_irq
(which no longer exists).

The Makefile in arch/ppc/kernel includes openpic.o, i8259.o and pmac_pic.o
whenever CONFIG_APUS isn't set; even though most other platforms don't want
them either.
  
drivers/char/Makefile includes pc_keyb.o and defkeymap.o whenever the ARCH is
not m68k, which means they get included in all embedded 8xx builds.

drivers/macintosh/Makefile includes via-cuda.o et al whenever CONFIG_MBX is
not defined. I changed it like this:

*** drivers/macintosh/Makefile.dist	Tue Aug 10 16:07:44 1999
--- drivers/macintosh/Makefile	Tue Aug 10 16:25:03 1999
***************
*** 15,21 ****
  L_TARGET := macintosh.a
  M_OBJS   :=
  
! ifndef CONFIG_MBX
  L_OBJS   := via-cuda.o macio-adb.o via-pmu.o mediabay.o
  LX_OBJS  := adb.o
  endif
--- 15,21 ----
  L_TARGET := macintosh.a
  M_OBJS   :=
  
! ifdef CONFIG_PMAC
  L_OBJS   := via-cuda.o macio-adb.o via-pmu.o mediabay.o
  LX_OBJS  := adb.o
  endif



There seems to be a typo in net/core/dev.c:

*** /tmp/linux/net/core/dev.c	Fri Apr  9 08:40:36 1999
--- embedded-2.2.5/net/core/dev.c	Tue Aug 10 18:14:35 1999
***************
*** 1949,1955 ****
  	arcnet_init();
  #endif
  #if defined(CONFIG_8xx)
! #ifdef CONFIG_860T
  	fec_enet_init();
  #else
          cpm_enet_init();
--- 1949,1955 ----
  	arcnet_init();
  #endif
  #if defined(CONFIG_8xx)
! #ifdef CONFIG_MPC860T
  	fec_enet_init();
  #else
          cpm_enet_init();

Lots of the EXPORT_SYMBOLs in arch/ppc/kernel/ppc_ksyms.c caused me grief;
I had to wrap isa_io_base, isa_mem_base and pci_dram_offset in
#ifdef CONFIG_PCI. I #if 0'd out _prep_type and ucSystemType, and all of:

  EXPORT_SYMBOL(adb_request);
  EXPORT_SYMBOL(adb_autopoll);
  EXPORT_SYMBOL(adb_register);

  EXPORT_SYMBOL(pmu_request);
  EXPORT_SYMBOL(pmu_send_request);
  EXPORT_SYMBOL(pmu_poll);

  EXPORT_SYMBOL(find_devices);
  EXPORT_SYMBOL(find_type_devices);
  EXPORT_SYMBOL(find_compatible_devices);

  EXPORT_SYMBOL(feature_set);
  EXPORT_SYMBOL(feature_clear);
  EXPORT_SYMBOL(feature_test);

  EXPORT_SYMBOL(device_is_compatible);

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
