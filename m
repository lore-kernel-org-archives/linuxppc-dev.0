Date: Tue, 28 May 2002 06:23:51 -0700
From: Matt Porter <porter@cox.net>
To: Sangmoon Kim <dogoil@etinsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: map iomem in linux_2_4_dev
Message-ID: <20020528062351.A2267@home.com>
References: <022501c20633$cbeb4f10$1a11efcb@industrialDiv.hanasys.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <022501c20633$cbeb4f10$1a11efcb@industrialDiv.hanasys.co.kr>; from dogoil@etinsys.com on Tue, May 28, 2002 at 07:38:19PM +0900
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 28, 2002 at 07:38:19PM +0900, Sangmoon Kim wrote:
>
> Hi,
> >
> > No, that's rubbish.  Use one or the other. ioremap() takes a physical
> > address and returns the virtual address at which it mapped it.
> >
> Sometimes it is needed to use  io_block_mapping and ioremap.
> io_block_mapping maps a phiscal address to a virtual address.
> And ioremap returns the virtual address.
> When I ported linux on an MPC755 based custom board.
> My hardware didn't running because it had a serial port at 0x78000000.
> Linux uses 0 to 0x7fffffff as a virtual memory for applications.
> And the address of 0x78000000 overlaped the serial port.
> I had to use io_block_mapping to map it at different location on system initialization,
> and ioremap to get the mapped address on serial port driver.
> I'm sorry, if it's another rubbish.

You don't need io_block_mapping.  Follow one of the many examples to
use early_serial_init with an ioremap call for your UART.

The only reason your method works is that the io_block_mapping is
actually using a BAT on our classic PPC platform.  ioremap will
look for an existent BAT mapping and just return the translated
virtual address in this case.  Relying on this is bad practice
since it will not work on other PPC systems.

As David correctly pointed out, only use io_block_mapping when
you absolutely must control the placement of the virtual address.
There are cases when this is necessary since the hardware engineers
always send us garbage to support.  Mapping a UART at init time is
not one of these.

BTW, your UART at physical 0x78000000 has zero bearing on the default
PPC Linux task size virtual addresses from 0-0x7fffffff.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
