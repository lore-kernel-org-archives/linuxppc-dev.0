Date: Wed, 11 Jun 2003 19:53:33 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: "Brian S. Park" <brian@corelis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: writing device driver for memory mapped device
Message-ID: <20030612005333.GA12236@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <5.1.1.6.2.20030611171936.012e0c68@corelis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.1.6.2.20030611171936.012e0c68@corelis.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 11, 2003 at 05:28:02PM -0700, Brian S. Park wrote:
> Our custom board has FPGA connected to EBC bus of PPC405gp and is memory
> mapped. So, I only need a device driver which will allow me to map the
> memory to the user space application and handle some interrupts. Can any
> one recommend a good starting point?

This is pretty straight forward.  I assume you've setup the chip select
for the device ahead of time (eg. in PPCBoot) and configured the bus
width, memory location, etc.  If that's the case, you can use ioremap()
in your device driver and map the device into the kernel address space.

As far as the interrupts go, it depends on how you set them up on the
board.  If you used one of the IRQ0-6 interrupt pins (aka GPIO17-23)
pins, you can just add an interrupt handler and register the apprpriate
interrupt.  You may have to adjust the interrupt routing in the platform
setup.

If you get stuck, I can send you an example driver that may help you
out.  It maps in a memory mapped device on the peripheral bus.

> Also, what are we required to do to stay compliant with GPL? Is posting
> tarball of modified Linux/u-boot source on the web enough?

Just put a copy of the GPL in the tarball and mark the files as such.
Making it available for download is good practice.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
