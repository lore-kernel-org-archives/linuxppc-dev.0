Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 6C18067A70
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 09:27:28 +1100 (EST)
Message-ID: <421BB1CB.1070803@mvista.com>
Date: Tue, 22 Feb 2005 15:27:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: James Chapman <jchapman@katalix.com>
References: <421B4126.1070808@katalix.com>
In-Reply-To: <421B4126.1070808@katalix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mv64x60 patches for Radstone PPC7D - for review
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi James.

James Chapman wrote:

> Attached is a series of patches adding support for Radstone PPC7D
> boards and Marvell Discovery watchdog. PPC7D are rugged Marvell
> Discovery boards with PPC7447A CPUs, dual GigE, dual PMC and optional
> SCSI, VGA.
>
> Signed-off-by: James Chapman <jchapman@katalix.com>
>
> The patches are split into separate pieces to aid review. Most patches
> are generic for mv64x60 boards and could be applied separately. Patch
> p9, however, requires all other patches. 


 From now on, please make a separate email per patch.  That way the 
email threads/patch discussions are easier to track.

>
>
> Patch p2 just makes fields in /proc/interrupts line up so it is
> optional.
>
> p1 - fix mv64360_pic_irq_offset bugs when non-zero 


While you're in there, would you make a #define for the IRQ 28 in 
include/asm-ppc/mv64x60_defs.h.  Otherwise, it looks good.

>
>
> p2 - cleanup formatting of mv64360 entries in /proc/interrupts
>      [optional] 


Looks fine but you may as well combine w/ patch p1.

>
>
> p3 - add pciauto_ignore_device() hook to allow platforms to ignore
>      specific devices in pciauto_bus_scan(). Should this hook be
>      in ppc_md instead? 


Is there a reason ppc_md.pci_exclude_device doesn't work?

>
>
> p4 - add GPP IO pin/IRQ register definitions 


Looks fine.

>
>
> p5 - add extern i8259_pic_irq_offset 


XXXX

>
>
> p6 - add 7447A and 7457 CPU definitions 


Looks okay to me but these should probably be posted to linuxppc-dev.

>
>
> p7 - add mv64x60 watchdog support 


I think it would be better to use platform_data to pass in the 
duration/timeout value and not a config option.  Other than that, it 
looks okay to me but I didn't go over it in detail.

When you separate this patch into its own email, you should send it to 
whoever looks after the watchdog drivers, cc the appropriate mailing 
list, and lmkl and/or linuxppc-embedded.

>
>
> p8 - add mv64x60_setclr_bits() which can be used to set and clear bits
>      of a mv64x60 register with a single chip register write. 


Is this really necessary?  I have learned that many in the community 
really hate little routines like this.  I have a todo item to get rid of 
the _set/clr_bits routines and replace them explicit code.

>
>
> p9 - add Radstone PPC7D board support 


I didn't go through this in great detail but I do have a few comments:

 > +++ linux-2.6/arch/ppc/boot/simple/misc-radstone_ppc7d.c 

 > +void __attribute__ ((weak)) mv64x60_board_init(void)

Don't make this "weak", there is one alread defined as weak that you're 
replacing.

 > +       /* Map 0xe0000000-0xffffffff early because we need access to SRAM
 > +        * and the ISA memory space (for serial port) here.

You mean for accessing the serial port while in the bootwrapper, right?  
The firmware doesn't put anything out the serial port?  If so, there is 
likely a mapping alread setup for you to use, no?

 > +++ linux-2.6/arch/ppc/Kconfig

Why bother with RADSTONE_DEBUG?  Plus I'm told that pr_debug() is the 
preferred method for this.

Why a separate CONFIG_RADSTONE and CONFIG_RADSTONE_PPC7C?  You never use 
CONFIG_RADSTONE.

 > +++ linux-2.6/arch/ppc/platforms/radstone_ppc7d.c

It looks like you only really use the 8250 uart.  Is that correct?  If 
so, get rid of the MPSC stuff since its only clutter.

 > static void __init ppc7d_early_serial_map(void)

I don't think you need this as long as you have your 
STD_SERIAL_PORT_DFNS setup correctly.

 > TODC_ALLOC();

It doesn't look like you need this since you don't actually use a 
time-of-day/realtime clock.

 > DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1533, ppc7d_fixup_ali1535);

You have a lot of pci fixups.  Are they all necessary?  I noticed a 
quirk already implemented for the 1533...

General note: you have a lot of lines that wrap in an 80 column window.  
I guess its a personal preference but I find it hard to read.  Would you 
mind breaking them into separate lines?

Mark
