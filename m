Date: 14 Jun 2002 05:22:50 -0000
Message-ID: <20020614052250.20441.qmail@webmail5.rediffmail.com>
MIME-Version: 1.0
From: "vandana  mehtani" <vandana_mehtani123@rediffmail.com>
Reply-To: "vandana  mehtani" <vandana_mehtani123@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Cc: paulus@samba.org
Subject: how to load on the FADS
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi everybody
sir, i have already made the crosscompiler for powerpc..
to load it on the FADS board are these steps sufficient..
i have downloaded the paulus kernel from ppckernel.org version
2.4.2


STEPS:--

           1)Define the IMMR to 0xf0000000

 	  2)Initialize the memory controller so that RAM is available
at
 	  physical address 0x00000000.  On the SBC8260 is this 16M
(64M)
 	  SDRAM.

 	 3)The boot ROM should only clear the RAM that it is using.

 	  The reason for doing this is to enhances the chances of a
 	  successful post mortem on a Linux panic.  One of the first
 	  items to examine is the 16k (LOG_BUF_LEN) circular console
 	  buffer called log_buf which is defined in kernel/printk.c.

 	 4)To enhance boot ROM performance, the I-cache can be
enabled.

          5) Build the board information structure (see
 	  include/asm-ppc/est8260.h for its definition)

 	6)The compressed Linux kernel (zImage) contains a bootstrap
loader
 	  that is position independent; you can load it into any RAM,
 	  ROM or FLASH memory address >= 0x00500000 (above 5 MB), or
 	  at its link address of 0x00400000 (4 MB).


 	7)Load R3 with the address of the board information structure

 	8)Transfer control to zImage

thanks in advance
bye
vandana


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
