Date: Fri, 16 Jan 2004 09:35:45 -0700
From: Rob Baxter <robb@synergymicro.com>
To: Jeff Angielski <jeff@theptrgroup.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc826x BAD interrupts
Message-ID: <20040116163545.GA8577@synergymicro.com>
References: <1074268973.4323.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1074268973.4323.13.camel@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 16, 2004 at 11:02:53AM -0500, Jeff Angielski wrote:
>
> Looking at /proc/interrupts, I see a large number of "BAD" interrups on
> both my MPC8260 reference board (2.4.21) and my PPC8266 custom board
> (2.4.23).  Both use u-boot as the bootloader.
>
> bash-2.05# cat /proc/interrupts
>            CPU0
>  24:          0   8260 SIU   Edge      PCI IRQ demux
>  33: 2658326944   8260 SIU   Edge      fenet
>  40:      32524   8260 SIU   Edge      uart
>  41:          0   8260 SIU   Edge      uart
> BAD:    8862006  <<====== this the problem
>
> The source of this count is ppc_spurious_interrupts which is incremented
> in the arch/ppc/kernel/irq.c if:
>
> 	1) there is no interrupt handler installed
>
> 	2) SIVEC is showing zero (no interrupts pending)
>
> Looking into the problem it would appear that the problem is the later
> case and the get_irq() function in ppc8260_pic.c is indeed reading a
> zero from the SIVEC.
>
> The questions I have are:
>
> 1) Has anybody seen this behavior on their PowerPC platform?
> 2) Does anybody know why the SIVEC would be showing a zero?
>
> TIA,
> Jeff Angielski
> The PTR Group
>
>
>

Hi Jeff,

Yes, I have seen this on a PowerPC platform.  And what I have noticed is
that faster (i.e., internal core frequency) the processor the more
likelihood of this happening.  However, it is highly dependent upon the
platform (e.g., interrupting devices, interrupt controller).

A good example is an interrupt request from a PCI bus device.  Many device
driver interrupt handlers will clear the source of the interrupt by either
reading or writing some register within the device, perform some necessary
actions, and return from the handler.  The PCI device is slow to negate its
interrupt request and the interrupt controller sees the interrupt request
from the device again.  With the platforms that I'm associated with I've
seen this happen more frequently (i.e., BAD interrupts) as processor
internal core frequencies increase, especially with the 7457.

--
Rob Baxter

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
