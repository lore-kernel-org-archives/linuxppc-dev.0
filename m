Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 68D81B70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 04:44:49 +1000 (EST)
Date: Thu, 9 Sep 2010 11:44:46 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, peterz@infradead.org,
	mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
Message-ID: <20100909184446.GB3496@ovro.caltech.edu>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100909162306.GA3496@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 09, 2010 at 09:23:07AM -0700, Ira W. Snyder wrote:
> On Thu, Sep 09, 2010 at 12:58:16PM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2010-09-08 at 19:52 -0700, Ira W. Snyder wrote:
> > > 
> > > I will attempt to get the debugger to stop at start_kernel. I'm having
> > > trouble driving the JTAG debugger (a BDI2000). I have used Denx's
> > > guide
> > > [1] in the past, but the section on debugging the kernel itself is now
> > > missing.
> > > 
> > > [1] http://www.denx.de/wiki/view/DULG/DebuggingLinuxKernel
> > > 
> > > I'll keep trying. 
> > 
> > start_kernel might be too late...
> > 
> > You can also hack thing :-) Like in the asm, before machine_init(),
> > stick something in the DABR and put a HW breakpoint with the BDI2000 on
> > the Data Access exception handler to "catch" when it faults.
> > 
> 
> I have succeeded in getting the debugger to break early on during boot.
> I have it set to break at start_here, in arch/powerpc/kernel/head_32.S.
> 
> My U-Boot bootloader indicates that the fdt is being loaded to address
> 0x7f8000, which translates to VA 0xc07f8000. See this output:
> 
>    Booting using the fdt blob at 0x2269f1c
>    Uncompressing Kernel Image ... OK
>    Loading Ramdisk to 0fea0000, end 0ff76699 ... OK
>    Loading Device Tree to 007f8000, end 007ff78f ... OK
> 
> As soon an the debugger hit the start_here breakpoint, I ran the
> following command. It should dump out the flat device tree to a file,
> which I can then analyze:
> 
> (gdb) dump memory ~/fdt.bin 0xc07f8000 0xc07ff78f
> 
> On the good kernel (CONFIG_PROVE_LOCKING=n), I get a valid device tree
> in fdt.bin. I see the stuff I would expect.
> 
> On the bad kernel (CONFIG_PROVE_LOCKING=y), I get all zeroes in fdt.bin.
> So clearly something is overwriting the fdt.
> 
> However, note that this happens *before* lockdep_init() runs. Grepping
> for CONFIG_PROVE_LOCKING in arch/powerpc and drivers/of shows nothing.
> I'm not sure exactly how this is related to lockdep.
> 
> Some more suggestions for things to try would be great. For now, I'm
> going to try getting the debugger to break near the end of U-Boot, to
> see if the memory is overwritten there, and not in Linux.
> 

Here is some more information. After tracing U-Boot's execution, I've
found that U-Boot is not the problem. The FDT is correct in-memory at
the point it jumps into the kernel. I literally halted it on the
instruction before the jmp and checked.

I've also found that setting a breakpoint at 0x0 stops right when the
Linux kernel starts, at symbol _start. AFAIK, the MMU is not yet
enabled, so I have to subtract 0xc0000000 from all addresses.

Single stepping through the initial assembly portion of kernel startup
shows that the FDT gets clobbered during the function early_init(). This
trace is reproduced below.

For whatever reason, even when single stepping, the debugger absolutely
refuses to enter the early_init function.

Misc Information:
1) 0xd00dfeed is an FDT magic number
2) 0x7f8000 is the physical address of the FDT in memory

(gdb) info break
Num Type           Disp Enb Address    What
2   hw breakpoint  keep y   0x00000000 /home/iws/devel/linux-2.6/arch/powerpc/kernel/head_32.S:72
        breakpoint already hit 3 times
(gdb) detach
Ending remote debugging.
(gdb) target remote bdi2k:2001
Remote debugging using bdi2k:2001
0x0ffbe760 in ?? ()
(gdb) continue 
Continuing.

Breakpoint 2, _stext () at /home/iws/devel/linux-2.6/arch/powerpc/kernel/head_32.S:72
72              nop     /* used by __secondary_hold on prep (mtx) and chrp smp */
Current language:  auto; currently asm
(gdb) print /x *0x7f8000
$6 = 0xd00dfeed
(gdb) s
73              nop     /* used by __secondary_hold on prep (mtx) and chrp smp */
(gdb) s
74              nop
(gdb) s
__start () at /home/iws/devel/linux-2.6/arch/powerpc/kernel/head_32.S:113
113             cmpwi   0,r5,0
(gdb) s
114             beq     1f
(gdb) s
142     1:      mr      r31,r3                  /* save parameters */
(gdb) s
143             mr      r30,r4
(gdb) s
144             li      r24,0                   /* cpu # */
(gdb) s
151             bl      early_init
(gdb) print /x *0x7f8000
$7 = 0xd00dfeed
(gdb) s
__start () at /home/iws/devel/linux-2.6/arch/powerpc/kernel/head_32.S:156
156             bl      mmu_off
(gdb) print /x *0x7f8000
$8 = 0x0

Ira
