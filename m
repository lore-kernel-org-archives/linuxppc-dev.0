Message-ID: <39DAF2C8.6171EABE@serialsystem.com.sg>
Date: Wed, 04 Oct 2000 16:05:13 +0700
From: Jari <jari.nguyen@smartstors.com>
Reply-To: jari.nguyen@smartstors.com
MIME-Version: 1.0
To: Scott Anderson <sanders@mvista.com>
CC: jari.nguyen@smartstors.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: mount RAMDISK directly on rom
References: <39D485A1.2785C0E4@serialsystem.com.sg> <39DABA39.37B03026@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
there is something I need to ask for more information about memory accessing.

Scott Anderson wrote:

> In general, I would add a driver that exposed your rom as a device and
> then just tell your kernel that root is on your device.

I think so, but when I modify rd.c,
I can not access the memory address on ROM.
for example:
I can turn on the led of CDK by using
the address 0xFF400000.
but when I need to read from the address on the ROM,

--------------------
0xFF5C6E11, for example:
    int b;
     b = *((char *)0xFF5C6E11);
--------------------

I'll see kernel panic like below:

--------------------------------------------------------------
NIP: C00AFB8C XER: E000107F LR: C00AFB84 REGS: c0ea1da0 TRAP: 0300
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0ea0000[16] 'a.out' mm->pgd c0fe1000 Last syscall: 3
last math 00000000
GPR00: 00000000 C0EA1E50 C0EA0000 00000200 00000000 00000000 7FFFFDA4 00000080

GPR08: FF5C6A11 FF5C6E11 C0110000 00000000 30026438 100187EC 100B0490 00000000

GPR16: 100B04F0 90100B0C 00000044 00000000 00009032 00EA1E80 00000000 C000253C

GPR24: C000227C 100B04F0 100006CC 00000001 7FFFFBA8 00000200 C0117778 00000200

Call backtrace:
00000284 C0027AA0 C00022D0 30025DC0 0FF094F8 00000000
Kernel panic: kernel access of bad area pc c00afb8c lr c00afb84 address
FF5C6E11 tsk a.out/16
--------------------------------------------------------------

Is there anybody tell me what happened?
I think that when I working in kernel space,
the address is not changed..?
and I can access the ROM
by using its address, is that right?


> I have
> successfully used the MTD drivers to do exactly this in the past.  I'd
> suggest poking around:
>   http://www.linux-mtd.infradead.org/
>

Thanks for your link, I'll try it right away,
but I think that I can not use it. ;-(
and I must concentrate into creating a driver to manage my task.
Is there anything to help me?

best regards,
Jari


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
