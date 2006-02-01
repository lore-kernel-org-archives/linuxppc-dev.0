Return-Path: <s.egbert@sbcglobal.net>
Received: from smtp111.sbc.mail.mud.yahoo.com (smtp111.sbc.mail.mud.yahoo.com
	[68.142.198.210]) by ozlabs.org (Postfix) with SMTP id 63EAF689D9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Feb 2006 19:18:10 +1100 (EST)
Message-ID: <43E06D3F.3020300@sbcglobal.net>
Date: Wed, 01 Feb 2006 00:11:43 -0800
From: "S. Egbert" <s.egbert@sbcglobal.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Linux 2.4 and UARTLITE
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm using XUARTLITE with PPC405 and special core.  U-Boot hasn't
leverage this combo before (AFAICT, U-Boot XUARTLITE is used only with
MicroBlaze CPU).

So, I took a Oct. 10 2005 snapshot and integrated the XUARTLITE into
U-Boot.  That works so far when Xilinx bootloader (via ISOCM/DSOCM)
loads the Linux 2.4.20 SREC-formatted file directly from flash into DDR
and jumps to 0x100.  So, it has been established that a working Linux
XUARTLITE output has been had by Xilinx-booting directly from
flash-based Linux.SREC.  (that was my earlier announcement).

But flashing 8MB Linux.SREC, every time I tweak things, isn't my cup of
tea.  It is not reasonable to wait 45 minutes for a serial download to
finish.  So, I thought, why not U-Boot it.

My next step is to put a uImage (Linux XUARTLITE) into flash using

    => tftpboot 30000000 uImage
    => bootm 30000000

bootm confirms that the uImage checksum is good and jumps to 0x100.

The calling sequence within Linux in question is:

 + _start  (linux/arch/ppc/kernel/head_4xx.S)
   + initial_mmu (also in head_4xx.S)
   + start_here (head_4xx.S)
     + machine_init (
     + MMU_init (arch/ppc/mm/init.c)
         --> XUARLITE register goes phantom here <--
     + start_kernel (init/main.c)


Via linux/arch/ppc/mm/init.c ppc_md.progress() debug output, I see that
outputs various "MMU:" debug lines and then it falls silent (no further
output).

   id mach(): done
   MMU:enter
   MMU:hw init
   MMU:mapin
   MMU:setio
   MMU:exit

so, it finished mmu_init() and platform_init() just fine.

Using Xilinx XDM, one can repeatedly poke the XUARTLITE transmit
register and evoke character outputs just fine while in Linux IDLE
(scheduler) mode.  So, the XUARTLITE hardware is still working at this
point.  HW works still.

I noticed that in Linux PPC, to get 'early debug output' using
CONFIG_SERIAL_TEXT_DEBUG option, PPC4xx TLB Slot 0 is dedicated to
mapping of serial hardware registers/memory region.  Somehow that TLB
remapping fails.

At the moment, I'm about to re-review the TLB slot 0 and figure out why
poking the XUARTLITE transmit register isn't working from memory-mapped
mode.

Any insight is greatly appreciated, particularly on how to read PPC405
TLB registers.



Steve
