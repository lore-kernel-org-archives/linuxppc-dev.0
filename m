Message-ID: <20040514135900.26033.qmail@web60402.mail.yahoo.com>
Date: Fri, 14 May 2004 06:59:00 -0700 (PDT)
From: Dieu Morales <dieumorales@yahoo.com>
Subject: Porting Linux to Radstone PPC7A 
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have been experimenting with trying to get Linux
running on the PPC7A in which a ppcboot bootrom was
provided along with source.  I was hoping this would
not be too difficult as the board appears to resemble
the EVB64260 board.

After making minor changes to the system controller's
base register address and the serial base addresses, I
saw Linux begin booting.  I am using the latest kernel
source 2.6.6.  I have noticed when I compile the
kernel with early output debug messages turned on, I
do receive serial I/O up until the MMU_init( )
finishes and start_kernel( ) begins (last debug text
seen is “MMU:exit”), where the system hangs in the
first ppc_md.progress ( ) call in setup_arch( ).
Looking at the assembly code comments after MMU_init(
), there is reference to unmapping memory and setting
up the exception vectors.  Is this unmapping before
start_kernel( ) causing me to lose my serial I/O?  If
so, how do I get it back?

To continue on, I turned off the early output debug
messages option and have been debugging by setting
card reset calls.  Through this method, I have
presently traced into console_init( ) which does not
return.  Any thoughts on what would cause hang-ups in
this function?

Since the setup_arch( ) returned, I figured all was
well.  The board has a GT64260 system controller and
an ALi M1535+ South Bridge.  To add the South Bridge
support I added the  ALi M1535 in the configuration
menu to my kernel.  Is this the correct driver or
would this need to be updated for the M1535+?

Finally, while analyzing the EV64260_setup.c code, I
noticed certain hard-coded interrupt memory maps.  Are
these maps board-specific?

Any help would be greatly appreciated.  Thanks.





SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
