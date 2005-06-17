Return-Path: <egoforth@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.192])
	by ozlabs.org (Postfix) with ESMTP id 372CB67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 13:47:24 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so767009wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 20:47:22 -0700 (PDT)
Message-ID: <75b39f010506162047236fec19@mail.gmail.com>
Date: Thu, 16 Jun 2005 23:47:22 -0400
From: Ed Goforth <egoforth@gmail.com>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20050616155525.A4541@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <75b39f0105061614333199ec37@mail.gmail.com>
	<20050616155525.A4541@cox.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: mmap on 440gx
Reply-To: Ed Goforth <egoforth@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/16/05, Matt Porter <mporter@kernel.crashing.org> wrote:
> On Thu, Jun 16, 2005 at 05:33:44PM -0400, Ed Goforth wrote:

Thanks for taking the time to reply.

> > I've been struggling with implementing mmap on a 440gx-based custom
> > board.  I have been able to use ioremap(), but we really need a mmap()
> > for our software.  The kernel is 2.4.18 (TimeSys 4.0).
>=20
> There are some special things done for handling [io]_remap_page/pfn_range
> on other vendor kernels and the current mainline kernel.  I'm not sure
> if your vendor kernel addressed them since it would be a vendor-specific
> patch in that timeframe.  The special things are due to 36-bit
> addressing.
>=20
> > I'm trying to access one of our FPGA's located at 0x50000000.  Offsets
>=20
> Let's start at the beginning.  How do you have FPGA's at 0x50000000?
> that address falls with the fix DDR SDRAM area on the 440GX memory
> map. All peripheral and EBC space is mapped by 4GB. You lost me
> right here. Oh wait, are you referring to the least significant 32-bits
> of the physical mapping. It's not really at 0x50000000.

Of course, you're correct.  The 36-bit base address is 0x1_0000_0000.=20
It is mapped to the 32-bit address 0x5000_0000.

Should I pass the 36-bit address to remap_page_range()?

For what it's worth, __pa(0x5000_0000) returns 0x9000_0000.

>=20
> You need something like the bigphys_remap patch for 2.4 that can be
> found at ftp://source.mvista.com/pub/linuxppc/

I just checked the source, and that patch has indeed been applied.

>=20
> It does the same fixup for remap_page_range() that happens for
> ioremap().  In 2.6 this stuff is all in the mainline kernel but
> you use io_rename_[page|pfn]_range() there.
>=20
> -Matt
>=20
Thanks,
Ed
