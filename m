Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 3F9E5679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 08:55:28 +1000 (EST)
Date: Thu, 16 Jun 2005 15:55:25 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ed Goforth <egoforth@gmail.com>
Message-ID: <20050616155525.A4541@cox.net>
References: <75b39f0105061614333199ec37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <75b39f0105061614333199ec37@mail.gmail.com>;
	from egoforth@gmail.com on Thu, Jun 16, 2005 at 05:33:44PM -0400
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: mmap on 440gx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jun 16, 2005 at 05:33:44PM -0400, Ed Goforth wrote:
> I've been struggling with implementing mmap on a 440gx-based custom
> board.  I have been able to use ioremap(), but we really need a mmap()
> for our software.  The kernel is 2.4.18 (TimeSys 4.0).

There are some special things done for handling [io]_remap_page/pfn_range
on other vendor kernels and the current mainline kernel.  I'm not sure
if your vendor kernel addressed them since it would be a vendor-specific
patch in that timeframe.  The special things are due to 36-bit
addressing.

> I'm trying to access one of our FPGA's located at 0x50000000.  Offsets

Let's start at the beginning.  How do you have FPGA's at 0x50000000?
that address falls with the fix DDR SDRAM area on the 440GX memory
map. All peripheral and EBC space is mapped by 4GB. You lost me
right here. Oh wait, are you referring to the least significant 32-bits
of the physical mapping. It's not really at 0x50000000.

You need something like the bigphys_remap patch for 2.4 that can be
found at ftp://source.mvista.com/pub/linuxppc/

It does the same fixup for remap_page_range() that happens for
ioremap().  In 2.6 this stuff is all in the mainline kernel but
you use io_rename_[page|pfn]_range() there.

-Matt
