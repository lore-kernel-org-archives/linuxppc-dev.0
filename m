Return-Path: <walt.wimer@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 3F84D67A64
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 02:07:02 +1000 (EST)
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: Mike Rapoport <mike@compulab.co.il>
In-Reply-To: <42467D8A.8050606@compulab.co.il>
References: <42467D8A.8050606@compulab.co.il>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 11:06:59 -0500
Message-Id: <1112026020.25896.8.camel@excalibur.timesys.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problem running Linux 2.6.11 on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Mike,

I had the same "hang" experience.  The file arch/ppc/platforms/pq2ads.c
contains the following function:

  void __init
  m82xx_board_setup(void)
  {
  	/* Enable the 2nd UART port */
  	*(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_RS232_EN2;
  }


I had to ifdef-out the assignment statement above.  It appears that the
definition for BCSR_ADDR in the kernel code differs from what U-Boot is
using, and that area of memory isn't properly mapped into the kernel
address space this early in the boot sequence.  As a result, I was
getting an Oops() before the console was even enabled (I could see the
Oops message by examining the kernel's printk log buffer using a
BDI-2000 hardware debugger).



Good luck,

Walt Wimer
TimeSys Corporation




On Sun, 2005-03-27 at 11:31 +0200, Mike Rapoport wrote:
> Hi,
> I'm trying to bring up the Linux 2.6.11 on MPC8272ADS and it seem to 
> hang up at the very beginning.
> I use ads8272_defconfig and then enable console on SCC:
> 
> CONFIG_SERIAL_CPM=y
> CONFIG_SERIAL_CPM_CONSOLE=y
> CONFIG_SERIAL_CPM_SCC1=y
> 
> 
> when I boot the kernel from the u-boot the system hangs up right after 
> the kernel decompression.
> 
