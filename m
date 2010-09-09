Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 8A092B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 02:23:10 +1000 (EST)
Date: Thu, 9 Sep 2010 09:23:07 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
Message-ID: <20100909162306.GA3496@ovro.caltech.edu>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284001096.6515.33.camel@pasglop>
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 09, 2010 at 12:58:16PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2010-09-08 at 19:52 -0700, Ira W. Snyder wrote:
> > 
> > I will attempt to get the debugger to stop at start_kernel. I'm having
> > trouble driving the JTAG debugger (a BDI2000). I have used Denx's
> > guide
> > [1] in the past, but the section on debugging the kernel itself is now
> > missing.
> > 
> > [1] http://www.denx.de/wiki/view/DULG/DebuggingLinuxKernel
> > 
> > I'll keep trying. 
> 
> start_kernel might be too late...
> 
> You can also hack thing :-) Like in the asm, before machine_init(),
> stick something in the DABR and put a HW breakpoint with the BDI2000 on
> the Data Access exception handler to "catch" when it faults.
> 

I have succeeded in getting the debugger to break early on during boot.
I have it set to break at start_here, in arch/powerpc/kernel/head_32.S.

My U-Boot bootloader indicates that the fdt is being loaded to address
0x7f8000, which translates to VA 0xc07f8000. See this output:

   Booting using the fdt blob at 0x2269f1c
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 0fea0000, end 0ff76699 ... OK
   Loading Device Tree to 007f8000, end 007ff78f ... OK

As soon an the debugger hit the start_here breakpoint, I ran the
following command. It should dump out the flat device tree to a file,
which I can then analyze:

(gdb) dump memory ~/fdt.bin 0xc07f8000 0xc07ff78f

On the good kernel (CONFIG_PROVE_LOCKING=n), I get a valid device tree
in fdt.bin. I see the stuff I would expect.

On the bad kernel (CONFIG_PROVE_LOCKING=y), I get all zeroes in fdt.bin.
So clearly something is overwriting the fdt.

However, note that this happens *before* lockdep_init() runs. Grepping
for CONFIG_PROVE_LOCKING in arch/powerpc and drivers/of shows nothing.
I'm not sure exactly how this is related to lockdep.

Some more suggestions for things to try would be great. For now, I'm
going to try getting the debugger to break near the end of U-Boot, to
see if the memory is overwritten there, and not in Linux.

Ira
