Date: Thu, 25 Jul 2002 11:21:01 -0700
From: Matt Porter <porter@cox.net>
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: driver for 440GP
Message-ID: <20020725112101.B24858@home.com>
References: <20020724220610.37041.qmail@web11503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020724220610.37041.qmail@web11503.mail.yahoo.com>; from kqtrinh@yahoo.com on Wed, Jul 24, 2002 at 03:06:10PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jul 24, 2002 at 03:06:10PM -0700, Khai Trinh wrote:
>
> Hi folks,
>
> I am trying to write a driver for the 440GP peripheral
> device with physical memory map of 0x1xxxxxxxx (total
> of 36 bits) on the PLB address space.
>
> When I get to do:
>
> request_mem_region() and then
> ioremap64()
>
> Don't I need a 64 bit request_mem_region() call? Is
> there such a kernel call before I call ioremap64()?

Two options for now:

1) Use the least significant 32-bits of the physical address to
   do the region manipulation.

2) Don't register the region.  We don't really do a good job
   of this in most PPC code anyway.

In 2.5, we can make resource start/end u64's, but it's intrusive
enough that I can't imagine it going into 2.4 (I certainly
wouldn't ask for it).  The region manipulation API would now use
u64's and printk formatting has to be handled since a u64 is
a different type on 32/64 platforms.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
