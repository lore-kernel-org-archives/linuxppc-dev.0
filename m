Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 9251DB70F0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 06:31:45 +1000 (EST)
Date: Thu, 9 Sep 2010 13:31:42 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Timur Tabi <timur@freescale.com>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
Message-ID: <20100909203142.GF3496@ovro.caltech.edu>
References: <1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<20100909184446.GB3496@ovro.caltech.edu>
	<AANLkTinFu+dttvBA2qyXFxQGOTRpmWeuvmHj40BFKNCm@mail.gmail.com>
	<20100909193642.GD3496@ovro.caltech.edu>
	<4C893842.6090009@freescale.com>
	<20100909200606.GE3496@ovro.caltech.edu>
	<4C893FDD.1000507@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C893FDD.1000507@freescale.com>
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 09, 2010 at 03:13:17PM -0500, Timur Tabi wrote:
> Ira W. Snyder wrote:
> > That easily overruns the location where U-Boot puts the FDT. Is this a
> > U-Boot bug, meaning I should post this information on the U-Boot
> > mailing list?
> 
> Possibly.
> 
> I am under the impression that the memory in the boot block that contains
> the FDT is marked as "reserved" in the device tree, so that the kernel
> doesn't overwrite it.  However, that obviously isn't helpful if we haven't
> parsed the device tree yet.
> 
> What concerns me is this in U-Boot:
> 
> /*
>  * For booting Linux, the board info and command line data
>  * have to be in the first 16 MB of memory, since this is
>  * the maximum mapped by the Linux kernel during initialization.
>  */
> #define CONFIG_SYS_BOOTMAPSZ	(16 << 20)	/* Initial Memory map for Linux*/
> 
> If the 16MB mapping limit is true, then does this mean that the Linux's BSS
> is larger than the memory that is mapped?  If so, that means that Linux
> can't even access all of its BSS at this point.  Somehow, I doubt that.
> 
> Can you try increasing the size of CONFIG_SYS_BOOTMAPSZ?  Combined with my
> always-relocate-fdt, I think this will force the FDT to be placed higher in
> memory.
> 

That did it!

I'm using include/configs/MPC8349EMDS.h. On that board,
CONFIG_SYS_BOOTMAPSZ is 8MB. Boosting it to 16MB fixed the problem and
the kernel now boots.

I'll make a post to the U-Boot list asking if this should be boosted for
MPC8349EMDS (and others?). It is easy to build a kernel that overruns
this limit. Other than debugging options, my kernel is fairly minimal,
only a few drivers are built in.

I'm using your always-relocate-fdt patch. Your patch made no difference
to the FDT location. U-Boot with and without your patch both work fine,
as soon as I boosted CONFIG_SYS_BOOTMAPSZ to 16MB.

With your patch:
   Booting using the fdt blob at 0x226a278
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 0fe9f000, end 0ff75699 ... OK
   Loading Device Tree to 00ff8000, end 00fff78f ... OK

Without your patch:
   Booting using the fdt blob at 0x226a278
   Uncompressing Kernel Image ... OK
   Loading Ramdisk to 0fe9f000, end 0ff75699 ... OK
   Loading Device Tree to 00ff8000, end 00fff78f ... OK


Thanks,
Ira
