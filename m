Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.0.14.0.20010914174808.026db880@pop.gmx.de>
Date: Fri, 14 Sep 2001 17:58:29 +0800
To: linuxppc-embedded@lists.linuxppc.org
From: Michael Habermann <MHabermann@gmx.de>
Subject: MMU and BDI2000
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I've not found a BDI newsgroup or FAQ so I'm sorry
for a little bit off-topic.

I'm using a BDI 2000 and I can successfully debug the PPCBOOT and the
kernel.

But I've trouble debugging a driver module loaded at runtime. I get the module
address out of the module_list linked list + sizeof_struct and can break
successfully in the driver. After calling add-symbol-file in GDB. Even single
stepping works.

But I get problems debugging variables. The BDI often prints:
'*** MMU: address translation for 0xC100B288 failed',
and most variables I cannot see. Also entering 'phy 0xC100B288' at the BDI
returns:
'# PPC: MMU address translation failed'

The system works without problems, so the MMU seems to work. Only the BDI
cannot translate it in some cases.

What is wrong?

I'm using a FADS860, PPCBoot and the kernel 2.4.4 from ftp.denx.de.

The INIT and TARGET sections of my BDI config file are:

[INIT]
WSPR	149	0xFDC3000F      ;DER  : set debug enable register
WSPR	638	0xFF000000      ;IMMR : internal memory at 0xFF000000
WSPR	158	0x00000007      ;ICTRL:
WSPR	796	0x00000000	;M_TWB invalidate TWB
WM32		0x000000f0	0x00000000	;invalidate page table base (PTBASE)
WM32    	0xFF000004      0xFFFFFF88      ;SYPCR


[TARGET]
CPUTYPE	    MPC800
CPUCLOCK    25000000    ;the CPU clock rate after processing the init list
BDIMODE     AGENT       ;the BDI working mode (LOADONLY | AGENT)
BREAKMODE   HARD        ;SOFT or HARD, HARD uses PPC hardware breakpoints
MMU XLAT


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
