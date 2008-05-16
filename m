Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 26176DE03F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 May 2008 00:56:53 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Jx1MY-0005Iv-Ft
	for linuxppc-embedded@ozlabs.org; Fri, 16 May 2008 07:56:50 -0700
Message-ID: <17276753.post@talk.nabble.com>
Date: Fri, 16 May 2008 07:56:50 -0700 (PDT)
From: swamydp <swamydp@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: linux 2.6 hangs at __delay function on Viretx 4 board
In-Reply-To: <20080514150139.E258D8D006F@mail70-va3.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <17222725.post@talk.nabble.com>
	<20080514150139.E258D8D006F@mail70-va3.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


John

Thanks for your suggestions.

 I looked up the virtual address for __log_buf in System.map and subtracted
0xc0000000 to get the physical address. I then reset the processor from XMD
and dump contents of the physical address of __log_buf using 'mrd' command
from XMD. All I see is bunch of zeros in those locations.

I am debugging but do not have much clue.

Swamy



John Linn wrote:
> 
> Hi Swamy,
> 
> I have seen this sometime before I think, but don't remember why.
> 
> I see that udelay depends on loops_per_jiffy, have you looked to see
> what value it is? Maybe it's garbage and some large value?
> 
> Have you tried dumping the __log_buf to understand how far it got thru
> booting the kernel before it got hung?
> 
> I assume you must be using xmd to load the image, you can also use it to
> dump the buffer.
> 
> On another processor I have seen it get hung in the calibrate_delay call
> from the kernel if the interrupts or timer aren't working, but haven't
> ever seen that on the Powerpc.
> 
> Thanks,
> John
> 
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+john.linn=xilinx.com@ozlabs.org] On
> Behalf Of swamydp
> Sent: Tuesday, May 13, 2008 9:29 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: linux 2.6 hangs at __delay function on Viretx 4 board
> 
> 
> 
> I am trying to boot linux 2.6 on HITECH virtex 4(fx60) board. Linux
> hangs at
> address 0xc00045ec which is in the __udelay function. I am using EDK
> 9.2i
> and gcc version 4.0.2 for compiling the kernel. The following is the
> boot
> message from the bootloader. 
> 
> loaded at:     00400000 0054E19C
> board data at: 0054C120 0054C19C
> relocated to:  00404064 004040E0
> zimage at:     00404E55 0054B5B4
> avail ram:     0054F000 02000000
> 
> Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/sda2
> Uncompressing Linux...done.
> Now booting the kernel
> 
> Any help is greatly appreciated. I have run out of ideas to fix this.
> 
> Thanks
> swamy
> 
> -- 
> View this message in context:
> http://www.nabble.com/linux-2.6-hangs-at-__delay-function-on-Viretx-4-bo
> ard-tp17222725p17222725.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/linux-2.6-hangs-at-__delay-function-on-Viretx-4-board-tp17222725p17276753.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
