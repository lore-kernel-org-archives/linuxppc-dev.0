Mime-Version: 1.0
Message-Id: <a05101404b891963659eb@[10.8.16.89]>
Date: Thu, 14 Feb 2002 10:29:12 -0600
To: linuxppc-embedded@lists.linuxppc.org
From: Greg Allen <gallen@arlut.utexas.edu>
Subject: Re: serial ports on 8245
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>mpc10x_bridge_init() is always called before $(PLATFORM)_map_io()

No -- it's the other way around. Mapping IO is very early.

arch/ppc/kernel/head.S start_here:
-  calls machine_init() in arch/ppc/kernel/setup.c
       calls platform_init() in arch/ppc/platforms/$(PLATFORM)_setup.c
          sets ppc_md.setup_io_mappings = $(PLATFORM)_map_io
          sets ppc_md.setup_arch = $(PLATFORM)_setup_arch

-  then calls MMU_init() in arch/ppc/mm/init.c
       calls ppc_md.setup_io_mappings() (which is $(PLATFORM)_map_io)

-  then calls start_kernel() in init/main.c
       calls setup_arch() arch/ppc/kernel/setup.c
          calls ppc_md.setup_arch() (which is $(PLATFORM)_setup_arch)
             calls mpc10x_bridge_init() eventually


Also, look in arch/ppc/mm/pgtable.c:
---------------------------------------------------------------
/*
  * Set up a mapping for a block of I/O.
  * virt, phys, size must all be page-aligned.
  * This should only be called before ioremap is called.
  */
void __init io_block_mapping(unsigned long virt, unsigned long phys,
			     unsigned int size, int flags)
---------------------------------------------------------------

mpc10x_bridge_init() calls ioremap(), so all calls to
io_block_mapping() from $(PLATFORM)_map_io must be done earlier.

Thanks,
-Greg
--
  Gregory E. Allen, MSEE Engineering Scientist
  Applied Research Laboratories:
  The University of Texas at Austin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
