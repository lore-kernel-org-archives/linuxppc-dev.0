Return-Path: <ALEBAS@televes.com>
Received: from mailext.televes.com (unknown [212.163.42.136])
	by ozlabs.org (Postfix) with ESMTP id 6267567A2F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 16:51:29 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mailext.televes.com (Postfix) with ESMTP id 079ED2B7544
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 08:56:42 +0200 (CEST)
Received: from mailext.televes.com ([127.0.0.1])
	by localhost (mailext [127.0.0.1]) (amavisd-new, port 10024) with SMTP
	id 18487-06 for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 08:56:41 +0200 (CEST)
Received: from televes.com (unknown [212.163.42.137])
	by mailext.televes.com (Postfix) with SMTP id BB4402B7542
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 08:56:41 +0200 (CEST)
Message-ID: <51DB8827D393D411BB69003048003F4601B1C1CE@tvesntr>
From: Bastos Fernandez Alexandre <ALEBAS@televes.com>
To: "'Walter L. Wimer III'" <walt.wimer@timesys.com>
Date: Tue, 29 Mar 2005 08:29:50 +0200
MIME-Version: 1.0
Content-Type: text/plain
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

Hi, 

>From "linux/arch/ppc/platforms/pq2ads.h"
#define BCSR_ADDR ((uint) 0xf4500000)
>From "u-boot/include/configs/MPC8260ADS.h"
#define CFG_BCSR 0xF4500000
So ...
Which version of u-boot and/or linux tree are you using?
With linuxppc-2.5 and u-boot 1.2 everything works fine for me.
Maybe Mike's problem is other. Maybe not. :-)

Best regards,
Alex

> -----Original Message-----
> From:	Walter L. Wimer III [SMTP:walt.wimer@timesys.com]
> Sent:	Monday, March 28, 2005 6:07 PM
> To:	Mike Rapoport
> Cc:	linuxppc-embedded@ozlabs.org
> Subject:	Re: Problem running Linux 2.6.11 on MPC8272ADS
> 
> 
> Hi Mike,
> 
> I had the same "hang" experience.  The file arch/ppc/platforms/pq2ads.c
> contains the following function:
> 
>   void __init
>   m82xx_board_setup(void)
>   {
>   	/* Enable the 2nd UART port */
>   	*(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_RS232_EN2;
>   }
> 
> 
> I had to ifdef-out the assignment statement above.  It appears that the
> definition for BCSR_ADDR in the kernel code differs from what U-Boot is
> using, and that area of memory isn't properly mapped into the kernel
> address space this early in the boot sequence.  As a result, I was
> getting an Oops() before the console was even enabled (I could see the
> Oops message by examining the kernel's printk log buffer using a
> BDI-2000 hardware debugger).
> 
> 
> 
> Good luck,
> 
> Walt Wimer
> TimeSys Corporation
> 
> 
> 
> 
> On Sun, 2005-03-27 at 11:31 +0200, Mike Rapoport wrote:
> > Hi,
> > I'm trying to bring up the Linux 2.6.11 on MPC8272ADS and it seem to 
> > hang up at the very beginning.
> > I use ads8272_defconfig and then enable console on SCC:
> > 
> > CONFIG_SERIAL_CPM=y
> > CONFIG_SERIAL_CPM_CONSOLE=y
> > CONFIG_SERIAL_CPM_SCC1=y
> > 
> > 
> > when I boot the kernel from the u-boot the system hangs up right after 
> > the kernel decompression.
> > 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
