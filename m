Date: Tue, 21 May 2002 10:33:34 -0700
From: Matt Porter <porter@cox.net>
To: caokai <tk19@taikebj.com.cn>
Cc: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: how do openpic works with VIA VT82C686B interrupt control?
Message-ID: <20020521103334.A17649@home.com>
References: <3CE85B40.BF72BB80@taikebj.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CE85B40.BF72BB80@taikebj.com.cn>; from tk19@taikebj.com.cn on Mon, May 20, 2002 at 10:11:12AM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 20, 2002 at 10:11:12AM +0800, caokai wrote:
>
> Hi,all
> I am porting hhl2.1 sandpoint to a custom 8245 board .
> This board have VIA VT82C686B pci south bridge to control the serial
> port. VIA VT82C686B have a 8259 compatible interrupt control.
> Specifically,the 4 PCI interrupts are routed to EPIC external interrupts
> 1-4,The PIC INTR line from the VIA southbridge is connected to EPIC
> externel interrupt 0.
> Now everything seems ok except the serial interrupt seems broken.The
> serial port interrupt is controled by VIA VT82C686B interrupt control.
> How can I start to solve this problem.Do I need to add a VIA VT82C686B
> driver?
> I know sandpoint 8245 have a 8259 .but this board we DO NOT have 8259.I
> should get rid of these 8259  code?

Huh?  This makes absolutely no sense.  You first say the PIC INTR line
from 686B is hooked to EPIC input 0 (good).  Then you claim you have
no 8259 on this board.  The PIC INTR line is the INTR from the master
8259 in the 686B.  What do you mean, "bus this board we DO NOT have
8259"?

You need to follow the many examples in the kernel (including
sandpoint) for cascading a  pair of 8259's from an EPIC/OpenPIC.

See below:

> this is my board's output log.I have added some debug information.

<snip>

> PCI: Probing PCI hardware
> 2.retvalue=0x1,idsel=0~~~sandpoint_map_irq *dev=PCI device
> 1057:0006,idsel= 0x0,
> pin=0x1,IRQ=0x1 ~~~
> +++pcibios update irq:1+++
> 1.retvalue=0x13,idsel=22~~~sandpoint_map_irq *dev=PCI device
> 1106:0686,idsel= 0x
> 16,pin=0x1,IRQ=0x13 ~~~
> +++pcibios update irq:19+++
> 1.retvalue=0x13,idsel=22~~~sandpoint_map_irq *dev=PCI device
> 1106:0571,idsel= 0x
> 16,pin=0x1,IRQ=0x13 ~~~
> +++pcibios update irq:19+++
> 1.retvalue=0x14,idsel=22~~~sandpoint_map_irq *dev=PCI device
> 1106:3038,idsel= 0x
> 16,pin=0x4,IRQ=0x14 ~~~
> +++pcibios update irq:20+++
> 1.retvalue=0x14,idsel=22~~~sandpoint_map_irq *dev=PCI device
> 1106:3038,idsel= 0x
> 16,pin=0x4,IRQ=0x14 ~~~
> +++pcibios update irq:20+++
> 1.retvalue=0x13,idsel=22~~~sandpoint_map_irq *dev=PCI device
> 1106:3057,idsel= 0x
> 16,pin=0x1,IRQ=0x13 ~~~
> +++pcibios update irq:19+++
> 1.retvalue=0x15,idsel=22~~~sandpoint_map_irq *dev=PCI device
> 1106:3058,idsel= 0x
> 16,pin=0x3,IRQ=0x15 ~~~
> +++pcibios update irq:21+++
> 1.retvalue=0x15,idsel=22~~~sandpoint_map_irq *dev=PCI device
> 1106:3068,idsel= 0x
> 16,pin=0x3,IRQ=0x15 ~~~
> +++pcibios update irq:21+++
> 1.retvalue=0x12,idsel=25~~~sandpoint_map_irq *dev=PCI device
> 8086:1209,idsel= 0x
> 19,pin=0x1,IRQ=0x12 ~~~
> +++pcibios update irq:18+++

<snip>

> PCI: Via IRQ fixup for 00:16.2, from 20 to 4
> PCI: Via IRQ fixup for 00:16.3, from 20 to 4
> PCI: Via IRQ fixup for 00:16.5, from 21 to 5
> PCI: Via IRQ fixup for 00:16.6, from 21 to 5

Function 2 is getting "fixed up" by the generic PCI quirks
system to IRQ 4.  On the 686B, the intline register does
non spec compliant things by enabling an internal routing
based on the value.  You need to write proper 0-0xf values
into those intline registers to avoid this "fixup"  Fix
irq map so it doesn't assign bogus values and you won't
trigger this quirk.

> ttyS00 at 0xfe0003f8 (irq = 4) is a 16550A
> ttyS01 at 0xfe0002f8 (irq = 3) is a 16550A

Looks good.  Fix all your interrupt routing conflicts and
serial will start working...it doesn't want to share with
function 2. ;)

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
