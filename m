Message-Id: <200204221807.g3MI7Uh27005@ares.gdc.ca>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Robert Morin <rmorin@miranda.com>
Reply-To: rmorin@miranda.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC8240 PTE setup
Date: Mon, 22 Apr 2002 14:07:46 -0400
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everyone,

I am new to embedded Linux but I have more than 10 years experience
in embedded systems on many different processors and real-time
O/Ses.

I have based my work on the Linux kernel 2.5.8 and the ZX4500 platform
(plus my modification). My goal is to move from pSOS to Linux and for the
moment I am using the pSOS bootloader (PPCBOOT on its way) to load
the linux kernel.

I have a problem with the MMU (MPC8240+CPLD+serial
port+DiskOnChip on PortX). The boot process is looping in
openpic_safe_writefield() and I can see with my BDI2000 that the
MMU is not translating correctly virtual addresses to physical
addresses. I made a patch to use a BAT instead of PTE but
this cause only to move the problem further upstream
(unable to run /busybox correctly).

I have check the parameter passed with ioremap() and it's
ok. With the BDI2000, I get this with the phys command:

	phys 0xfdfd0000          (virtual address returned by ioremap)

	PHYS = 0xfffff000	END = 0xffffffff
instead of
	PHYS 0xfdf40000 END = 0xfdffffff


Here is a screenshot (this is a pSOS boot sequence):


Standard output device initialized...
System clock initialized...
SYSTEM START @ 09:52:18  22/04/2002  (usec tick)
DiskOnChip has a capacity of 32 MB
Initializing User Accounts, this may take a while...
Initializing FTP Server Daemon...
15.0/mxz/index :  200b - prepc error value
No startup table - cannot initialize revision control.
Cannot open system files -- trying TFTP instead.
Remote file: zImage.img, IP: 10.64.21.18
TFTP download completed.
Transfering control to the downloaded code.

(here it is)

loaded at:     00100000 001B0BCC
relocated to:  00800000 008B0BCC
zimage at:     00805980 0088DBE4
initrd at:     0088E000 008A69BF
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,19200 root=/dev/ram0 init=/busybox lash
Uncompressing Linux...done.
Now booting the kernel

Robert Morin
Firmware engineer
Miranda Media Network
St-Laurent, Qc
Canada


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
