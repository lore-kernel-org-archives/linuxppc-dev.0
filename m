Message-ID: <A109131318C4D1119AC20060088DECE30B9824@amwmail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: "'Michael Coy'" <mac12@po.cwru.edu>, linuxppc-embedded@lists.linuxppc.org
Subject: RE: PCMCIA ATA flash support
Date: Tue, 27 Jun 2000 13:56:16 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Michael,

What are the values of the NIP and LR at the time of the kernel panic?
We, too, are still battling the kernel panic: Kernel Mode Software FPU
Emulation problem with our MPC823 (custom) board.
We are not using PCMCIA or IDE support. However we are using AX.25, which
most (all??) others are not.

Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.

-----Original Message-----
From: Michael Coy [mailto:mac12@po.cwru.edu]
Sent: Tuesday, June 27, 2000 1:19 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCMCIA ATA flash support



OK, I have a backtrace and added some prink's and LED outputs at the
beginning and ends of interesting functions, and here is what I think is
going on:

the PCMCIA stuff recognizes the card as an ATA flashdisk and calls
ide_register() to set things up.
ide_register() calls ide_init_hwif_ports() to set up the ide controller
ide_init_hwif_ports() calls the processor-specific
m8xx_ide_init_hwif_ports().

While calling m8xx_ide_init_hwif_ports (before line 1 of hte function), I
get the kernel panic.

I tried printing the address of the function, as well as the first 50
bytes.  The address remains constant from boot to when I call it, but the
first 50 bytes are zeroed out somewhere inbetween.

The interesting part is I get three different backtraces, on different
kernel compiles, with the only difference being printk's.


00000100 C0097130 C40116E4 C40119B0 C4002118 C4003860 C4011178
C400E834 C400F518 C00336D8 C00022D8 0FF8CBA8 10002B4C 10003F80
0FF09E78 00000000

Here, C0097130 is ide_register.


C0002D44 C009719C C40116E4 C40119B0 C4002118 C4003860 C4011178
C400E834 C400F518 C0033734 C00022D8 0FF8CBA8 10002B4C 10003F80
0FF09E78 00000000

Here, C0002D44 is ide_init_hwif_ports, and C009719C is ide_register


C0002D7C C00971E0 C40116E4 C40119B0 C4002118 C4003860 C4011178
C400E834 C400F518 C0033778 C00022D8 0FF8CBA8 10002B4C 10003F80
0FF09E78 00000000

here, C0002D7C is cpu_temp (!??) and C00971E0 is ide_register.
Now, cpu_temp just returns 0.  And it isn't called from ide_register!

In any case, the printk's and led's indicate hte same behavior in each
case.

Any ideas?
Thanks,
mike


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
