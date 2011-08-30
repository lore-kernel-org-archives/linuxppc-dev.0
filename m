Return-Path: <pwsan@booyaka.com>
Received: from utopia.booyaka.com (utopia.booyaka.com [72.9.107.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14CF7B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 07:51:00 +1000 (EST)
Date: Tue, 30 Aug 2011 15:43:36 -0600 (MDT)
From: Paul Walmsley <paul@pwsan.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Wolfgang Grandegger <wg@grandegger.com>
Subject: Virtual addresses in arch/powerpc/boot/dts/tqm8548*.dts ?
Message-ID: <alpine.DEB.2.00.1108301508130.26173@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

Looking at some of the PPC DTS files in arch/powerpc/boot/dts, there are 
some files that are mostly identical, except for some strange 
differences.

For example, tqm8548.dts and tqm8548-bigflash.dts differ mostly in that 
the former file claims that the SoC registers start at 0xe0000000[1], but 
the latter file claims that the SoC registers start at 0xa0000000[2].

Commit 02b8a3d1eb2ae6353cfbce627ded22e299cf1989 ("powerpc/85xx: support 
for the TQM8548 module using the big Flash") claims that:

    Some TQM85xx boards could be equipped with up to 1 GiB (NOR) flash
    memory and therefore a modified memory map is required and setup by
    the board loader. This patch adds an appropriate DTS file.

So are these addresses virtual?  My (perhaps incorrect) understanding of 
the device tree files was that they were intended to describe the physical 
memory map, rather than the virtual memory map.  Or does this PowerPC 
variant have the ability to dynamically change its own physical address 
decoding?  Or is something else going on?


thanks for any clarification,

- Paul

1. arch/powerpc/boot/dts/tqm8548.dts line 53, as of Linux v3.1-rc3:
   http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/powerpc/boot/dts/tqm8548.dts;h=619776f72c904c611e9507d44db4bee1200e6688;hb=HEAD#l53

2. arch/powerpc/boot/dts/tqm8548-bigflash.dts line 53, as of Linux 
   v3.1-rc3:
   http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/powerpc/boot/dts/tqm8548-bigflash.dts;h=9452c3c05114e523033eebb278d7f78811890a87;hb=HEAD#l53
