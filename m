Date: Fri, 25 Oct 2002 19:30:59 +0200
Subject: Changes I would like to get into the 2_4_devel
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
To: Tom Rini <trini@kernel.crashing.org>
From: Anders Blomdell <anders.blomdell@control.lth.se>
Message-Id: <86C2D453-E83F-11D6-A4F1-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Where do I send a request of the following changes to linuxppc_2_4_devel:

in arch/ppc/Makefile:
   add -D__powerpc__ to CPPFLAGS and CFLAGS (just like it is on  kernel.org)
     This makes drivers/char/serial.c compile correctly (no more 5 bit
     characters)

in Makefile:
   add -D__linux__ to CPPFLAGS
     This makes coda.h compile correctly (u_quad_t)

in arch/ppc/kernel/i8259.c:
   Some way to set
     pci_intack = 0;
   if we are running on a MVME 2400/2600, since the PIB (PCI-to-ISA Bridge)
  does
   not support anything but polling of the 8229 pair.

arch/ppc/platforms/prpmc800_setup.c:
   patch previously sent.

I know that you think I have an incorrectly configured gcc, but I think
that it's a nice feature if the kernel compiles with a gcc that has been
configured according to the 'http://penguinppc.org/embedded/cross-compiling/
', even though it warns about gcc-3.x (3.2 generates working code with the
above changes)...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
