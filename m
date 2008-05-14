Return-Path: <John.Linn@xilinx.com>
Received: from outbound1-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 82FE0DE1BB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 May 2008 01:03:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board
Date: Wed, 14 May 2008 09:01:37 -0600
In-Reply-To: <17222725.post@talk.nabble.com>
References: <17222725.post@talk.nabble.com>
From: "John Linn" <John.Linn@xilinx.com>
To: "swamydp" <swamydp@gmail.com>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20080514150139.E258D8D006F@mail70-va3.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Swamy,

I have seen this sometime before I think, but don't remember why.

I see that udelay depends on loops_per_jiffy, have you looked to see
what value it is? Maybe it's garbage and some large value?

Have you tried dumping the __log_buf to understand how far it got thru
booting the kernel before it got hung?

I assume you must be using xmd to load the image, you can also use it to
dump the buffer.

On another processor I have seen it get hung in the calibrate_delay call
from the kernel if the interrupts or timer aren't working, but haven't
ever seen that on the Powerpc.

Thanks,
John


-----Original Message-----
From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org] On
Behalf Of swamydp
Sent: Tuesday, May 13, 2008 9:29 PM
To: linuxppc-embedded@ozlabs.org
Subject: linux 2.6 hangs at __delay function on Viretx 4 board



I am trying to boot linux 2.6 on HITECH virtex 4(fx60) board. Linux
hangs at
address 0xc00045ec which is in the __udelay function. I am using EDK
9.2i
and gcc version 4.0.2 for compiling the kernel. The following is the
boot
message from the bootloader.=20

loaded at:     00400000 0054E19C
board data at: 0054C120 0054C19C
relocated to:  00404064 004040E0
zimage at:     00404E55 0054B5B4
avail ram:     0054F000 02000000

Linux/PPC load: console=3DttyS0,9600 console=3Dtty0 root=3D/dev/sda2
Uncompressing Linux...done.
Now booting the kernel

Any help is greatly appreciated. I have run out of ideas to fix this.

Thanks
swamy

--=20
View this message in context:
http://www.nabble.com/linux-2.6-hangs-at-__delay-function-on-Viretx-4-bo
ard-tp17222725p17222725.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
