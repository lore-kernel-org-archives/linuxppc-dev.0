Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C821F67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 13:03:09 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j2V35v4f001317 for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 20:05:57 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j2V34kBE023672
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 21:04:47 -0600 (CST)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673011732F4@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "Walter L. Wimer III" <walt.wimer@timesys.com>,
	Kumar Gala <kumar.gala@freescale.com>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
Date: Thu, 31 Mar 2005 11:03:00 +0800
MIME-Version: 1.0
Content-Type: text/plain
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

Well, it seems to be a historic problem.  Freescale BSP was originally ported from u-boot-1.0.0 and linux-2.4.22.  So the BCSR was freely chosen as 0xf8000000.  Later, we updated them to u-boot-1.1.1 and linux-2.4.26, and make the BCSR consistent to older version.  However the sourceforge u-boot-1.1.1 support for MPC8272ADS was committed by Arabella guys, they chose BCSR mapping to 0xf4500000.  Kumar's MPC8272 support which is in 2.6.11 source was developed using sourceforge u-boot-1.1.1 seemingly.

This might brought up a question that if we need a convention or something to define the recommended memory mapping for PowerPC BSPs.  As there are different groups of people around the world developing BSPs for PowerPC platforms, and often the communication between them is very limited.

For now using kernel and u-boot released from the same vendor is recommended.


Best Regards,
Leo


> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Walter L. Wimer
> III
> Sent: Thursday, March 31, 2005 12:00 AM
> To: Linux PPC Embedded list
> Subject: Re: Problem running Linux 2.6.11 on MPC8272ADS
> 
> 
> This matched my experience as well.
> 
> Does anyone know why U-Boot 1.1.1 from Freescale uses a different BCSR
> address than U-Boot 1.1.1 from Sourceforge?
> 
> Any opinions on which address is the "correct" one to use?  Kumar asked
> for a patch to fix this, so what do we think the correct fix is?
> 
> 
> 
> Thanks!
> 
> Walt
> 
> 
> 
> On Wed, 2005-03-30 at 10:18 +0200, Mike Rapoport wrote:
> > Walter,
> > Thanks for you help. I've discovered several things and now the things
> > seem to work fine.
> > I've used u-boot-1.1.1 that came with the Freescale BSP and it maps BCSR
> > to 0xf8000000. The "regular" u-boot-1.1.1 (from sf.net) maps the BCSR to
> > 0xf4500000 as well as the kernel does (arch/ppc/platforms/pq2ads.h). The
> > difference causes the "hang"-like behaviour when the kernel initializes
> > serial comm and kernel crash afterwards when FCC is initialized.
> >
> > Mike.
> >
> > >Thanks for the data points, Alex.
> > >
> > >I'm using U-Boot 1.1.1 and vanilla kernel.org 2.6.11.4 (actually now
> > >2.6.11.5).  My BCSR_ADDR looks the same as what you've listed below, so
> > >I'd guess the difference is with U-Boot...  (Another engineer here
> > >installed U-Boot on my board, from, I believe, a binary copy he got from
> > >a Freescale(?) CD...  I didn't build U-Boot from source...  That's
> > >something I'll need to take a look at...)
> > >
> > >Mike, have you discovered anything further about your problem?
> > >
> > >
> > >
> > >Walt
> > >
> > >
> > >
> > >On Tue, 2005-03-29 at 08:29 +0200, Bastos Fernandez Alexandre wrote:
> > >
> > >
> > >>Hi,
> > >>
> > >>>From "linux/arch/ppc/platforms/pq2ads.h"
> > >>#define BCSR_ADDR ((uint) 0xf4500000)
> > >>>From "u-boot/include/configs/MPC8260ADS.h"
> > >>#define CFG_BCSR 0xF4500000
> > >>So ...
> > >>Which version of u-boot and/or linux tree are you using?
> > >>With linuxppc-2.5 and u-boot 1.2 everything works fine for me.
> > >>Maybe Mike's problem is other. Maybe not. :-)
> > >>
> > >>Best regards,
> > >>Alex
> > >>
> > >>
> > >>
> > >>>-----Original Message-----
> > >>>From:	Walter L. Wimer III [SMTP:walt.wimer@timesys.com]
> > >>>Sent:	Monday, March 28, 2005 6:07 PM
> > >>>To:	Mike Rapoport
> > >>>Cc:	linuxppc-embedded@ozlabs.org
> > >>>Subject:	Re: Problem running Linux 2.6.11 on MPC8272ADS
> > >>>
> > >>>
> > >>>Hi Mike,
> > >>>
> > >>>I had the same "hang" experience.  The file arch/ppc/platforms/pq2ads.c
> > >>>contains the following function:
> > >>>
> > >>>  void __init
> > >>>  m82xx_board_setup(void)
> > >>>  {
> > >>>  	/* Enable the 2nd UART port */
> > >>>  	*(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_RS232_EN2;
> > >>>  }
> > >>>
> > >>>
> > >>>I had to ifdef-out the assignment statement above.  It appears that the
> > >>>definition for BCSR_ADDR in the kernel code differs from what U-Boot is
> > >>>using, and that area of memory isn't properly mapped into the kernel
> > >>>address space this early in the boot sequence.  As a result, I was
> > >>>getting an Oops() before the console was even enabled (I could see the
> > >>>Oops message by examining the kernel's printk log buffer using a
> > >>>BDI-2000 hardware debugger).
> > >>>
> > >>>
> > >>>
> > >>>Good luck,
> > >>>
> > >>>Walt Wimer
> > >>>TimeSys Corporation
> > >>>
> > >>>
> > >>>
> > >>>
> > >>>On Sun, 2005-03-27 at 11:31 +0200, Mike Rapoport wrote:
> > >>>
> > >>>
> > >>>>Hi,
> > >>>>I'm trying to bring up the Linux 2.6.11 on MPC8272ADS and it seem to
> > >>>>hang up at the very beginning.
> > >>>>I use ads8272_defconfig and then enable console on SCC:
> > >>>>
> > >>>>CONFIG_SERIAL_CPM=y
> > >>>>CONFIG_SERIAL_CPM_CONSOLE=y
> > >>>>CONFIG_SERIAL_CPM_SCC1=y
> > >>>>
> > >>>>
> > >>>>when I boot the kernel from the u-boot the system hangs up right after
> > >>>>the kernel decompression.
> > >>>>
> > >>>>
> > >>>>
> > >>>_______________________________________________
> > >>>Linuxppc-embedded mailing list
> > >>>Linuxppc-embedded@ozlabs.org
> > >>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > >>>
> > >>>
> > >
> > >
> > >
> > >
> >
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
