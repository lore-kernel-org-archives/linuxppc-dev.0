From: Michael Engel <engel@math.uni-siegen.de>
Message-Id: <200007211527.RAA09444@jordan.numerik.math.uni-siegen.de>
Subject: Understanding PPC boot code ...
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 21 Jul 2000 17:27:36 +0200 (MET DST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm currently porting Linux to a PowerPC G3 evaluation board and am
experiencing some problems. The boot loader code (from arch/ppc/boot/)
works fine - I can get output via the 16550-compatible UART (after I
changed the I/O addresses) and the boot procedure runs up to
"Now booting the kernel". I'm currently using kernel 2.4.0 test 4.

Now, I'm not sure how the memory has to be set up / used to start
the kernel successfully. The firmware in my board doesn't permit to
load kernels below 0x200000, so I'm loading it there. The complete
bootloader output I get is:

---
Entry point at 0x200000 ...
loaded at:     00200000 00214E20
relocated to:  00800000 00814E20
board data at: 00007658 0000E064
relocated to:  0080E314 00814D20
zimage at:     0020B000 002E1B62
relocated to:  00815000 008EBB62
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/sda2
Uncompressing Linux...done.
Now booting the kernel
---

That's all (and yes - I did put some code to output some charaters to the
serial port at the start of arch/ppc/kernel/head.S). If you already see
some problems with the memory setup, please let me know ...

If I understand the boot code correctly, the boot loader now is supposed
to jump to __start in arch/ppc/kernel/head.S via the following
instructions in arch/ppc/boot/head.S:

        /*
         * get start address of kernel code which is stored as a coff
         * entry.  see boot/head.S -- Cort
         */
        li      r9,0x4
        mtlr    r9
        lis     r10,0xdeadc0de@h
        ori     r10,r10,0xdeadc0de@l
        li      r9,0
        stw     r10,0(r9)

	[ stuff about radstone firmware removed ... ]

        blr
hang:
        b       hang

So, if I'm correct, the boot loader expects the address of __start to be
stored in memory at address 0x4 - which most probably isn't true in my
case.

Now my question - how is that address supposed to get there ? I suspect
some entry in the linker script, but I haven't been able to locate it.

If someone could give me some insight on what black magic is going on
here ;-), I'd be very happy ...

Thanks a lot in advance,
	Michael Engel	(engel@unix-ag.org)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
