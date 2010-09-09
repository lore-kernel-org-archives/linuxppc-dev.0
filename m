Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 27C8DB710F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 06:55:09 +1000 (EST)
Date: Thu, 9 Sep 2010 13:55:07 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Timur Tabi <timur@freescale.com>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
Message-ID: <20100909205507.GG3496@ovro.caltech.edu>
References: <1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<20100909184446.GB3496@ovro.caltech.edu>
	<AANLkTinFu+dttvBA2qyXFxQGOTRpmWeuvmHj40BFKNCm@mail.gmail.com>
	<20100909193642.GD3496@ovro.caltech.edu>
	<4C893842.6090009@freescale.com>
	<20100909200606.GE3496@ovro.caltech.edu>
	<4C893FDD.1000507@freescale.com>
	<20100909203142.GF3496@ovro.caltech.edu>
	<4C89454F.8070701@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C89454F.8070701@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 09, 2010 at 03:36:31PM -0500, Timur Tabi wrote:
> Ira W. Snyder wrote:
> > That did it!
>
> Yea!
>
> > I'm using include/configs/MPC8349EMDS.h. On that board,
> > CONFIG_SYS_BOOTMAPSZ is 8MB. Boosting it to 16MB fixed the problem and
> > the kernel now boots.
>
> Ah, yes.  I believe the reason that is the case is because some of those
> boards were shipped with only 8MB of RAM.
>
> > I'll make a post to the U-Boot list asking if this should be boosted for
> > MPC8349EMDS (and others?). It is easy to build a kernel that overruns
> > this limit. Other than debugging options, my kernel is fairly minimal,
> > only a few drivers are built in.
>
> I think we should first determine if the kernel boot map limit really is
> 16MB.  If it's more than that, then we should consider making it match.
> Assuming, of course, that the U-Boot code can handle a situation where
> CONFIG_SYS_BOOTMAPSZ is larger than the actual amount of RAM.
>

I have no idea how to determine this.

The code that caused the problem runs so early in boot that the MMU is
not running yet. Looking through the tiny bit of code, it appears that
it just uses whatever the bootloader set up for it. It hasn't gotten to
the initial_bats function yet.

The comment in initial_bats (arch/powerpc/kernel/head_32.S) says:

/*
 * On 601, we use 3 BATs to map up to 24M of RAM at _PAGE_OFFSET
 * (we keep one for debugging) and on others, we use one 256M BAT.
 */

I think the MPC8349EA would be a 603 CPU, meaning that we could increase
CONFIG_SYS_BOOTMAPSZ up to 256MB (if the board had that much RAM).

> > I'm using your always-relocate-fdt patch. Your patch made no difference
> > to the FDT location. U-Boot with and without your patch bo
>
> My patch only does something if the FDT is already located inside the boot
> map.  Since you were expanding the size of the boot map, there's a chance
> that the FDT was located between 8MB and 16MB, and if so, my patch would
> have made a difference.
>

Yep, you're exactly correct. I tried loading my FIT image to a lower
address (0xa00000 == 10MB), both with and without your patch:

Without your patch (vanilla U-Boot):

   Verifying Hash Integrity ... crc32+ OK
   Booting using the fdt blob at 0xc6a278
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 0fe9f000, end 0ff75699 ... OK

With your patch:

   Verifying Hash Integrity ... crc32+ OK
   Booting using the fdt blob at 0xc42d6c
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 0fe9f000, end 0ff75699 ... OK
   Loading Device Tree to 00ff8000, end 00fff84f ... OK

You'll see that your patch now relocated the FDT. It didn't cause any
problems. I'll post to the thread on the U-Boot ML.

[ dropped mingo and peterz from the CC list, they're not powerpc people ]

Thanks,
Ira
