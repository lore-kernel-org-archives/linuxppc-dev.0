Date: Mon, 17 Jan 2000 16:02:51 -0600
From: Grant Erickson <grant@lcse.umn.edu>
To: Niklaus Giger <n.giger@netstal.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Help Sought for 403GCX-startup
In-Reply-To: <s8835efe.002@netstal.com>
Message-ID: <Pine.SGI.4.10.10001171543350.277235-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 17 Jan 2000, Niklaus Giger wrote:
> I successfully managed to create vmlinux for the oak-IBM 403
> Evaluation Board.

Excellent! Based on the latest 2.3.39 code or the 2.3.39 plus my patches?

> As our OAK-board does not work anymore (it is over 4 years old and out
> of service) I tried to load the vmlinux using my vxworks boot-rom. I
> got a memory access while trying to access 0xc0000008.

The kernel shouldn't ever access 0xc0000008 during normal operation. The
entry point from the boot loader (did try to boot vmlinux.img in
arch/ppc/treeboot or vmlinux directly?) is at 0x00000000. Shortly
thereafter, the MMU is enabled and code should start executing from
0xc0002100 (or in that approximate range).

> Therefore I tried to change in linux/arch/ppc/Makefile the 
> KERNELLOAD =0xc0000000
> to
> KERNELLOAD =0x10000
> as all my 4 MB RAM (known at boottime) is located at address 0.
> After make clean vmlinux I was able to load vmlinux.

You don't ever want to change KERNELLOAD or KERNELBASE, otherwise the
virtual memory and MMU code will all break.

> It load, but it does not start up. A hardware debugging session using
> the JTAG-based SDS-debugger showed, that it crashed after very few
> instruction at 0x10074
> 
> SDS-debugger deassembles:
> 00010000: or r31,r3,r3
> 00010004: or r30,r4,r4
> 00010008: or r29,r5,r5
> 0001000C: or r28,r6,r6
> 00010010: or r27,r7,r7
> 00010014: addi r24,r0,0
> 00010018: addis r3,r0,0xC0000000@HI
> 0001001C: addis r3,r3,0x00000000@HI
> 00010020: addis r4,r3,0x40000000@HI
> 00010024: mfspr r7,PID
> 00010028: addi r0,r0,0
> 0001002C: mtspr PID,r0
> 00010030: rlwinm r4,r4,0,0,21
> 00010034: ori r4,r4,0x304
> 00010038: rlwinm r3,r3,0,0,21
> 0001003C: ori r3,r3,0x3C0
> 00010040: illegal
> 00010044: illegal
> 00010048: isync
> 0001004C: mtspr PID,r7
> 00010050: addis r4,r0,0xC0000000@HI
> 00010054: addis r0,r4,0x40000000@HI
> 00010058: mtspr EVPR,r0
> 0001005C: mfmsr r0
> 00010060: ori r0,r0,0x30
> 00010064: mtspr SRR1,r0
> 00010068: addis r0,r0,0x00010000@HI
> 0001006C: ori r0,r0,0x21C8
> 00010070: mtspr SRR0,r0
> 00010074: rfi

The above code is from head_4xx.S and is the entry point from the boot
loader. It basically sets up a TLB page mapping that is used when the
kernel puts the processor into virtual mode after the 'rfi' you cited gets
executed.

> After the rfi at 0x10074. PC is at 0x121C8 (000121BC  is abort:)

The lower address of 0x21C8 is the assembly tag 'start_here' found in
head_4xx.S (see above when I talked about 0xc0002100). This is where the
real work to jump to the Linux kernel starts and it all is done in virtual
mode.

> It seems to me that my MMU is not yet correctly setup?

I don't suspect that's the problem. At the very least, you should be able
to successfully execute the kernel up through 'identify_machine'
in the vicinity of virtual address 0xc00f8810. After that, there's some
setup code that relies on information passed in from the Oak evaluation
board (see main.c in arch/ppc/treeboot).

> Could you please be so kind to describe your patchs (against 2.3.39)
> and post them on your home page?

Most of my changes are summarized in the "Recent Changes" subheading on
that web page. Recently, most changes have been focused around the
Ethernet controller.

> I would also appreciate any hints how to disable the 16650-SCC (our
> hardware does not have one) and how to uses the internal 403 (I have
> the knowledge to program it).

There's currently no code in the 4xx-based port which uses or assumes the
16650 serial controller found on the Oak board, so you shouldn't need to
change a thing. As for the internal 403 serial port, I haven't yet coded
in support for that yet. It's on the "to-do" list.

Regards,

Grant Erickson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
