Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE001.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id E25A4DE310
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 May 2008 02:28:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board
Date: Fri, 16 May 2008 10:28:04 -0600
In-Reply-To: <17276753.post@talk.nabble.com>
References: <17222725.post@talk.nabble.com><20080514150139.E258D8D006F@mail70-va3.bigfish.com>
	<17276753.post@talk.nabble.com>
From: John Linn <John.Linn@xilinx.com>
To: "swamydp" <swamydp@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20080516162807.2132E181804D@mail89-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Swamy,

Looks like the kernel is probably not running at all yet, may stuck in
early initialization.

1. Has the kernel ever ran on this board or is this development to get
it running?

I have ran into issues with the memory being setup incorrectly (the end
address/how much memory) and seen something similar to this. I would
review the bootstrap loader output carefully to ensure the memory is
setup correctly.

2. Not sure on the tools you are using to build it.  You mention the
EDK, but you must not be using it's compiler as it's not configured in
the EDK to build Linux. =


I use the ELDK 4.1 right now as we are still figuring out our tool
situation. =


3. Without a good JTAG emulator, bring up can be painful in my
experience.  The EDK GDB/XMD is not fully MMU aware, so once the MMU is
one it won't allow you to debug.  If you have access to an MMU aware
debugger that could help.

I have used BDI 2000 for these type of problems and it helped.

4. In the absense of an MMU debugger, using the UART to slam bytes out
of the serial port can help. The UART lite is easier for that as there's
no setup required. The kernel can map an MMU TLB so that the UART is
usable early, make sure that is setup in the early startup.  Then I just
use *(char *)<The UART xmt reg address> =3D <data byte> in the code to see
what it's doing.

5. I would probably see where the udelay is called early in the kernel
startup and why. I sometimes hack on it, comment stuff out, to get past
it and figure out more data.  Not always a good path, but can help.

Good luck,
John


-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of swamydp
Sent: Friday, May 16, 2008 8:57 AM
To: linuxppc-embedded@ozlabs.org
Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board


John

Thanks for your suggestions.

 I looked up the virtual address for __log_buf in System.map and
subtracted
0xc0000000 to get the physical address. I then reset the processor from
XMD
and dump contents of the physical address of __log_buf using 'mrd'
command
from XMD. All I see is bunch of zeros in those locations.

I am debugging but do not have much clue.

Swamy



John Linn wrote:
> =

> Hi Swamy,
> =

> I have seen this sometime before I think, but don't remember why.
> =

> I see that udelay depends on loops_per_jiffy, have you looked to see
> what value it is? Maybe it's garbage and some large value?
> =

> Have you tried dumping the __log_buf to understand how far it got thru
> booting the kernel before it got hung?
> =

> I assume you must be using xmd to load the image, you can also use it
to
> dump the buffer.
> =

> On another processor I have seen it get hung in the calibrate_delay
call
> from the kernel if the interrupts or timer aren't working, but haven't
> ever seen that on the Powerpc.
> =

> Thanks,
> John
> =

> =

> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
> Behalf Of swamydp
> Sent: Tuesday, May 13, 2008 9:29 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: linux 2.6 hangs at __delay function on Viretx 4 board
> =

> =

> =

> I am trying to boot linux 2.6 on HITECH virtex 4(fx60) board. Linux
> hangs at
> address 0xc00045ec which is in the __udelay function. I am using EDK
> 9.2i
> and gcc version 4.0.2 for compiling the kernel. The following is the
> boot
> message from the bootloader. =

> =

> loaded at:     00400000 0054E19C
> board data at: 0054C120 0054C19C
> relocated to:  00404064 004040E0
> zimage at:     00404E55 0054B5B4
> avail ram:     0054F000 02000000
> =

> Linux/PPC load: console=3DttyS0,9600 console=3Dtty0 root=3D/dev/sda2
> Uncompressing Linux...done.
> Now booting the kernel
> =

> Any help is greatly appreciated. I have run out of ideas to fix this.
> =

> Thanks
> swamy
> =

> -- =

> View this message in context:
>
http://www.nabble.com/linux-2.6-hangs-at-__delay-function-on-Viretx-4-bo
> ard-tp17222725p17222725.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> =

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> =

> =

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> =

> =


-- =

View this message in context:
http://www.nabble.com/linux-2.6-hangs-at-__delay-function-on-Viretx-4-bo
ard-tp17222725p17276753.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
