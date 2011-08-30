Return-Path: <gary@mlbassoc.com>
Message-ID: <4E5D668B.1060609@mlbassoc.com>
Date: Tue, 30 Aug 2011 16:39:07 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Paul Walmsley <paul@pwsan.com>
Subject: Re: Virtual addresses in arch/powerpc/boot/dts/tqm8548*.dts ?
References: <alpine.DEB.2.00.1108301508130.26173@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.00.1108301508130.26173@utopia.booyaka.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2011-08-30 15:43, Paul Walmsley wrote:
>
> Hi,
>
> Looking at some of the PPC DTS files in arch/powerpc/boot/dts, there are
> some files that are mostly identical, except for some strange
> differences.
>
> For example, tqm8548.dts and tqm8548-bigflash.dts differ mostly in that
> the former file claims that the SoC registers start at 0xe0000000[1], but
> the latter file claims that the SoC registers start at 0xa0000000[2].
>
> Commit 02b8a3d1eb2ae6353cfbce627ded22e299cf1989 ("powerpc/85xx: support
> for the TQM8548 module using the big Flash") claims that:
>
>      Some TQM85xx boards could be equipped with up to 1 GiB (NOR) flash
>      memory and therefore a modified memory map is required and setup by
>      the board loader. This patch adds an appropriate DTS file.
>
> So are these addresses virtual?  My (perhaps incorrect) understanding of
> the device tree files was that they were intended to describe the physical
> memory map, rather than the virtual memory map.  Or does this PowerPC
> variant have the ability to dynamically change its own physical address
> decoding?  Or is something else going on?

These addresses correspond to the internal registers which can be moved.
The default address is set by hardware at reset time (check out the documentation
on the hardware reset word).  Obviously one board is strapped for the IMMR
at one address, another board at a different address.  I almost always configure
my boards to use 0xF0000000 for the IMMR.

>
>
> thanks for any clarification,
>
> - Paul
>
> 1. arch/powerpc/boot/dts/tqm8548.dts line 53, as of Linux v3.1-rc3:
>     http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/powerpc/boot/dts/tqm8548.dts;h=619776f72c904c611e9507d44db4bee1200e6688;hb=HEAD#l53
>
> 2. arch/powerpc/boot/dts/tqm8548-bigflash.dts line 53, as of Linux
>     v3.1-rc3:
>     http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/powerpc/boot/dts/tqm8548-bigflash.dts;h=9452c3c05114e523033eebb278d7f78811890a87;hb=HEAD#l53
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
