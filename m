Cc: Linux PPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <395CBCDD.3421494D@lucent.com>
Date: Fri, 30 Jun 2000 10:29:33 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
To: Gong Zhuo <gongzhuo@163.net>
Subject: Re: How to debug MMU on powerpc?
References: <017301bfe268$960eed20$4607a8c0@LocalHost>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gong Zhuo wrote:
>   I am using MVME2600 and debug my program through serial port. I must use
> MMU for some reasons and the virtual address and physical address is not
> consistent. That means virtual address 0 maybe physical address 0xc000. I
> have used BAT method. All the mapping is finished in assembly language and I
> have make the cross-compile , gdb for powerpc-eabi. But how can I link and
> debug my program?

>From your descriptiojn your program is not running under Linux, but is
a stand-alone program. If this is not true and you intend to run it
under Linux, then you must let Linux manage the MMU.

A stand-alone program which is using the MMU must be carefully designed
so that the MMU can be initialized and then enabled properly. There are
two basic ways to do this:
 A) arrange so the startup code will be mapped virtual=physical, so it
    can start with MMU disabled, setup the BATs (and segments if any),
    and then enable the MMU. Since this code is mapped virtual=physical
    it continues to run after the MMU is enabled.
 B) arrange so the startup code runs with MMU disabled, setup the BATs
    (and segments if any) and then:
	mtspr SRR1,<desired MSR value with MMU enabled>
	mtspr SRR0,<virtual address to start at>
	rfi
    Note that the fact that branches are generally PC-relative makes
    this a lot easier -- you may not need to do anything at all to
    make it work correctly (initialize the BATs with load immediates,
    not data accesses). Note also that if the code starts with the
    MMU enabled you must use much care in modifying the BATs.
Our proprietary OS uses mthod A (the entire kernel runs
virtual=physical, only user programs have non-physical virtual
addresses); Linux's head.S uses method B.


>   1. If I link my program with virtual address , the code before the mmu is
> opened will be linked with the virtual address but they should run in the
> physical address.

Sure, but as branches and calls are PC-relative, it may still work.
You need to be careful about data accesses, however. As you are using
BATs, there is a simple subtraction/addition to relate virtual and
physical addresses, and you can explicitly do that for data accesses.
Look at Linux's head.S (in directory arch/ppc/kernel) for examples of
this during startup; the value to be subtracted for virt->phys is
called KERNELBASE (but in the mm code is called PAGE_OFFSET (:-().


>   2. The powerpc-eabi-gdb will load my program to the entry-point of virtual
> address, but the mmu has not been opened at that time.

See above. It depends in detail how your loading of the program arranges
to jump to its starting point. Note that most boot ROMs and debug ROMS
do not use the MMU and will load the program where you tell it and
simply jump to its first location or a physical address you tell it.
You must take the behavior of your boot/debug ROM into account when
designing the startup of your program.

Hmmm. Your paragraph here sort-of implies that you intend to startup
Linux, run gdb, and have gdb load and execute your program which
will then take over the MMU (etc.). This is unlikely to work,
because the execution environment for gdb and the Linux kernel will
be completely destroyed. I repeat: if you intend to run this program
under Linux then you must let Linux manage the MMU.

	Note: the version of PPC Linux I have (2.2.15) uses only
	DBAT2,DBAT3,IBAT2,IBAT3, so the other BATs are available
	for system-specific uses. My custom drivers use DBAT0 and
	DBAT1. Before doing this you must make sure that the
	system-level code for your board does not already use
	these BATs (write a module to dump the BATs, or inspect
	the Linux startup code VERY carefully). This may be what
	you are looking for.


Tom Roberts	tjroberts@lucnet.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
