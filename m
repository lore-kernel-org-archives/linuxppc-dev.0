Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5F68FB7109
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 07:59:09 +1000 (EST)
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
In-Reply-To: <20100909162306.GA3496@ovro.caltech.edu>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 10 Sep 2010 07:58:54 +1000
Message-ID: <1284069534.6515.36.camel@pasglop>
Mime-Version: 1.0
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


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

I suspect your uboot setup. The one thing lockdep does is massively
increase the amount of kernel bss. I suspect you are just overlapping DT
and bss and hence wiping out the DT when clearing the bss.

I would have expected uboot to warn (the kernel ELF header contains the
BSS size) but apparently that isn't the case.

Cheers,
Ben. 
