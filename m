Return-Path: <walt.wimer@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 3D19D67A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 01:44:41 +1000 (EST)
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: Bastos Fernandez Alexandre <ALEBAS@televes.com>
In-Reply-To: <51DB8827D393D411BB69003048003F4601B1C1CE@tvesntr>
References: <51DB8827D393D411BB69003048003F4601B1C1CE@tvesntr>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 10:44:39 -0500
Message-Id: <1112111080.26645.14.camel@excalibur.timesys.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Problem running Linux 2.6.11 on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks for the data points, Alex.

I'm using U-Boot 1.1.1 and vanilla kernel.org 2.6.11.4 (actually now
2.6.11.5).  My BCSR_ADDR looks the same as what you've listed below, so
I'd guess the difference is with U-Boot...  (Another engineer here
installed U-Boot on my board, from, I believe, a binary copy he got from
a Freescale(?) CD...  I didn't build U-Boot from source...  That's
something I'll need to take a look at...)

Mike, have you discovered anything further about your problem?



Walt



On Tue, 2005-03-29 at 08:29 +0200, Bastos Fernandez Alexandre wrote:
> Hi, 
> 
> >From "linux/arch/ppc/platforms/pq2ads.h"
> #define BCSR_ADDR ((uint) 0xf4500000)
> >From "u-boot/include/configs/MPC8260ADS.h"
> #define CFG_BCSR 0xF4500000
> So ...
> Which version of u-boot and/or linux tree are you using?
> With linuxppc-2.5 and u-boot 1.2 everything works fine for me.
> Maybe Mike's problem is other. Maybe not. :-)
> 
> Best regards,
> Alex
> 
> > -----Original Message-----
> > From:	Walter L. Wimer III [SMTP:walt.wimer@timesys.com]
> > Sent:	Monday, March 28, 2005 6:07 PM
> > To:	Mike Rapoport
> > Cc:	linuxppc-embedded@ozlabs.org
> > Subject:	Re: Problem running Linux 2.6.11 on MPC8272ADS
> > 
> > 
> > Hi Mike,
> > 
> > I had the same "hang" experience.  The file arch/ppc/platforms/pq2ads.c
> > contains the following function:
> > 
> >   void __init
> >   m82xx_board_setup(void)
> >   {
> >   	/* Enable the 2nd UART port */
> >   	*(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_RS232_EN2;
> >   }
> > 
> > 
> > I had to ifdef-out the assignment statement above.  It appears that the
> > definition for BCSR_ADDR in the kernel code differs from what U-Boot is
> > using, and that area of memory isn't properly mapped into the kernel
> > address space this early in the boot sequence.  As a result, I was
> > getting an Oops() before the console was even enabled (I could see the
> > Oops message by examining the kernel's printk log buffer using a
> > BDI-2000 hardware debugger).
> > 
> > 
> > 
> > Good luck,
> > 
> > Walt Wimer
> > TimeSys Corporation
> > 
> > 
> > 
> > 
> > On Sun, 2005-03-27 at 11:31 +0200, Mike Rapoport wrote:
> > > Hi,
> > > I'm trying to bring up the Linux 2.6.11 on MPC8272ADS and it seem to 
> > > hang up at the very beginning.
> > > I use ads8272_defconfig and then enable console on SCC:
> > > 
> > > CONFIG_SERIAL_CPM=y
> > > CONFIG_SERIAL_CPM_CONSOLE=y
> > > CONFIG_SERIAL_CPM_SCC1=y
> > > 
> > > 
> > > when I boot the kernel from the u-boot the system hangs up right after 
> > > the kernel decompression.
> > > 
> > 
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
