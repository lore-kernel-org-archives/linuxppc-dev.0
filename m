Message-ID: <40A536BD.5090302@mvista.com>
Date: Fri, 14 May 2004 14:14:37 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Dieu Morales <dieumorales@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Porting Linux to Radstone PPC7A
References: <20040514135900.26033.qmail@web60402.mail.yahoo.com>
In-Reply-To: <20040514135900.26033.qmail@web60402.mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dieu Morales wrote:

><snip>
>
>After making minor changes to the system controller's
>base register address and the serial base addresses, I
>saw Linux begin booting.  I am using the latest kernel
>source 2.6.6.  I have noticed when I compile the
>kernel with early output debug messages turned on, I
>do receive serial I/O up until the MMU_init( )
>finishes and start_kernel( ) begins (last debug text
>seen is “MMU:exit”), where the system hangs in the
>first ppc_md.progress ( ) call in setup_arch( ).
>Looking at the assembly code comments after MMU_init(
>), there is reference to unmapping memory and setting
>up the exception vectors.  Is this unmapping before
>start_kernel( ) causing me to lose my serial I/O?
>
Probably not.

>  If
>so, how do I get it back?
>
If you're using the mpsc for serial I/O then you moved its reg base when
you moved the bridges reg base. It sounds like you know this, though.
However, you also have to change the address you ioremap and the address
you put in the STD_SERIAL_PORT_DFNS. Maybe you forgot one of them?

If you're using an external 16550-type uart for serial I/O, then unless
you change the dev bus window that maps in its regs, you don't want to
change its address in the code. Did you change it by mistake?

>
>To continue on, I turned off the early output debug
>messages option and have been debugging by setting
>card reset calls.  Through this method, I have
>presently traced into console_init( ) which does not
>return.  Any thoughts on what would cause hang-ups in
>this function?
>
A guess would be that you're accessing an mpsc reg that isn't mapped
into kernel virt space and panic'ing.

>
>Since the setup_arch( ) returned, I figured all was
>well.  The board has a GT64260 system controller and
>an ALi M1535+ South Bridge.  To add the South Bridge
>support I added the  ALi M1535 in the configuration
>menu to my kernel.  Is this the correct driver or
>would this need to be updated for the M1535+?
>
There may be more to it. I don't recall what's on an M1535 but if its
has a PIC and you want to using it, you need to cascade the interrupts
properly.

>
>Finally, while analyzing the EV64260_setup.c code, I
>noticed certain hard-coded interrupt memory maps.  Are
>these maps board-specific?
>
If you're talking about the pci interrupt map then yes, it is board
specific. You need to read the docs or schematics for your board to see
how they routed pci interrupts and set up the table accordingly. By
default, GPP interrupts start at 64 (e.g., GPP0 == irq 64, GPP1 == irq
65, ...). If the M1535 has an 8259 or other PIC in it and you want to
shoe-horn it in front of the 64260's irq's, you have to shift all
64260-related irq's back 16 and cascade the PICs correctly. That
includes shifting the mpsc & embedded enet irq's too.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
