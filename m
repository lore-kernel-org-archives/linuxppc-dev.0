Message-ID: <3AC37111.C041F0CA@mvista.com>
Date: Thu, 29 Mar 2001 10:29:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Alex Shnitman <alexsh@hectic.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Stability of MontaVista's 2.4.0-test2-1.2.2-1
References: <H00002af04b2e173@MHS> <3AC23B01.A9162C3B@matrox.com> <3AC25348.C33F8692@mvista.com> <20010329163258.C13092@mangodsp.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sigh...  :(

Evidently, some [pmac-related] changes have gone in the last 2-3 weeks that have broken things.  I'll take a
look at it today or tomorrow.

If you can't wait, its probably not hard to fix.  Its likely nothing more than adding some stubs to
ppc_stubs.c

Mark
--

Alex Shnitman wrote:

> Hi, Mark!
>
> On Wed, Mar 28, 2001 at 02:10:33PM -0700, you wrote the following:
>
> > That version of the kernel does have problems.  Get the latest linuxppc_2_5
> > source and try that.  I haven't tested the last couple weeks but before then,
> > it was very solid.  Sandpoint support is in it.
>
> I've just tried it. I downloaded the tree with bitkeeper, and applied
> sp_patch_25, but got the following linking errors at the final stage
> of the compilation:
>
> arch/ppc/kernel/kernel.o: In function `lookup_partitions':
> arch/ppc/kernel/kernel.o(.text+0x9046): undefined reference to `pmac_newworld'
> arch/ppc/kernel/kernel.o(.text+0x904a): undefined reference to `pmac_newworld'
> arch/ppc/kernel/kernel.o: In function `sandpoint_get_irq':
> arch/ppc/kernel/kernel.o(.text+0x95fc): undefined reference to `openpic_irq'
> arch/ppc/kernel/kernel.o(.text+0x95fc): relocation truncated to fit: R_PPC_REL24 openpic_irq
> arch/ppc/kernel/kernel.o(.text+0x9620): undefined reference to `openpic_eoi'
> arch/ppc/kernel/kernel.o(.text+0x9620): relocation truncated to fit: R_PPC_REL24 openpic_eoi
> arch/ppc/kernel/kernel.o: In function `sandpoint_post_irq':
> arch/ppc/kernel/kernel.o(.text+0x9670): undefined reference to `openpic_eoi'
> arch/ppc/kernel/kernel.o(.text+0x9670): relocation truncated to fit: R_PPC_REL24 openpic_eoi
> arch/ppc/kernel/kernel.o: In function `pmac_nvram_init':
> arch/ppc/kernel/kernel.o(.text.init+0xd20): undefined reference to `find_devices'
> arch/ppc/kernel/kernel.o(.text.init+0xd20): relocation truncated to fit: R_PPC_REL24 find_devices
> arch/ppc/kernel/kernel.o(.text.init+0xd54): undefined reference to `device_is_compatible'
> arch/ppc/kernel/kernel.o(.text.init+0xd54): relocation truncated to fit: R_PPC_REL24 device_is_compatible
> arch/ppc/kernel/kernel.o(.text.init+0xe82): undefined reference to `sys_ctrler'
> arch/ppc/kernel/kernel.o(.text.init+0xe86): undefined reference to `sys_ctrler'
> drivers/video/video.o: In function `chips_init':
> drivers/video/video.o(.text.init+0x2e48): undefined reference to `find_devices'
> drivers/video/video.o(.text.init+0x2e48): relocation truncated to fit: R_PPC_REL24 find_devices
> make: *** [vmlinux] Error 1
>
> --
> Alex Shnitman <alexsh@hectic.net>
> http://alexsh.hectic.net/   UIN 188956
> PGP 0xEC5D619D / E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA
>

--
Mark A. Greer (mgreer@mvista.com; 480-517-0287)
MontaVista Software, Inc.
2141 E. Broadway Road, Suite 108
Tempe, AZ  85282


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
