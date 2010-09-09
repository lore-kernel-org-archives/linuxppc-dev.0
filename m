Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 77475B7104
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 06:06:09 +1000 (EST)
Date: Thu, 9 Sep 2010 13:06:06 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Timur Tabi <timur@freescale.com>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
Message-ID: <20100909200606.GE3496@ovro.caltech.edu>
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<20100909184446.GB3496@ovro.caltech.edu>
	<AANLkTinFu+dttvBA2qyXFxQGOTRpmWeuvmHj40BFKNCm@mail.gmail.com>
	<20100909193642.GD3496@ovro.caltech.edu>
	<4C893842.6090009@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C893842.6090009@freescale.com>
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 09, 2010 at 02:40:50PM -0500, Timur Tabi wrote:
> Ira W. Snyder wrote:
> > As noted in another email, it appears that U-Boot puts the FDT in such a
> > place that Linux overwrites it with the BSS. The CONFIG_PROVE_LOCKING=y
> > option expands the BSS by a large amount, which causes the error. It
> > isn't directly lockdep related.
> > 
> > I don't know if this is a U-Boot problem or a Linux problem. I have no
> > idea how to fix the bug.
> 
> I wonder if this patch that I wrote for U-Boot will fix the problem:
> 
> http://lists.denx.de/pipermail/u-boot/2010-May/071822.html
> 

Nope, I tried it and it doesn't fix the problem. It relocates the FDT to
exactly the same address as before the patch.

I think the problem is that the U-Boot loader doesn't take into account
the Linux kernel's BSS size, and puts the FDT too close.

Here is the relevant U-Boot output after applying your patch. It was not
changed from the previous output.

   Booting using the fdt blob at 0x226a278
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 0fe9f000, end 0ff75699 ... OK
   Loading Device Tree to 007f8000, end 007ff78f ... OK

My ramdisk is right near the end of RAM. This board has 256MB of RAM.
0x0ff75699 / 1024 / 1024 == 255.4586

The FDT is just before the 8MB boundary:
0x007ff78f / 1024 / 1024 == 7.9979

My uncompressed vmlinux.bin.gz is ~3.5MB:
iws@rena ~/devel/correlator/fit-image $ zcat vmlinux.bin.gz > vmlinux.bin
iws@rena ~/devel/correlator/fit-image $ du -b vmlinux.bin
3573068 vmlinux.bin

As posted in my other email, Linux's BSS is ~5.2MB:
(gdb) print __bss_start
$23 = 0xc0369000 <Address 0xc0369000 out of bounds>
(gdb) print __bss_stop
$25 = 0xc08a0c48 <Address 0xc08a0c48 out of bounds>

(0xc08a0c48 - 0xc0369000) / 1024 / 1024 == 5.21784210205078125


Total (code + BSS): 3573068 + 5471304 == 9044372  (~8.62MB)

That easily overruns the location where U-Boot puts the FDT. Is this a
U-Boot bug, meaning I should post this information on the U-Boot
mailing list?

Thanks,
Ira
