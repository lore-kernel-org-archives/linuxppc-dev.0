Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 84FB567A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Mar 2005 03:42:43 +1000 (EST)
In-Reply-To: <1112198401.24332.8.camel@excalibur.timesys.com>
References: <1112198401.24332.8.camel@excalibur.timesys.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <2432ded5d3780d5c73c912fc375379c7@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 30 Mar 2005 11:42:35 -0600
To: "Walter L. Wimer III" <walt.wimer@timesys.com>
Cc: Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>
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

Also,

If you guys come to some conclusion about a fix we can make to the=20
boards that would improve functionality, I'll try to get that back to=20
the board guys to look at implementing for future revs.

- kumar

On Mar 30, 2005, at 10:00 AM, Walter L. Wimer III wrote:

>
>
> This matched my experience as well.
>
> Does anyone know why U-Boot 1.1.1 from Freescale uses a different BCSR
> address than U-Boot 1.1.1 from Sourceforge?
>
> Any opinions on which address is the "correct" one to use?=A0 Kumar =
asked
>  for a patch to fix this, so what do we think the correct fix is?
>
>
>
>
> Thanks!
>
> Walt
>
>
>
>
> On Wed, 2005-03-30 at 10:18 +0200, Mike Rapoport wrote:
>  > Walter,
>  > Thanks for you help. I've discovered several things and now the=20
> things
> > seem to work fine.
>  > I've used u-boot-1.1.1 that came with the Freescale BSP and it maps=20=

> BCSR
> > to 0xf8000000. The "regular" u-boot-1.1.1 (from sf.net) maps the=20
> BCSR to
> > 0xf4500000 as well as the kernel does (arch/ppc/platforms/pq2ads.h).=20=

> The
> > difference causes the "hang"-like behaviour when the kernel=20
> initializes
> > serial comm and kernel crash afterwards when FCC is initialized.
>  >
> > Mike.
>  >
> > >Thanks for the data points, Alex.
>  > >
>  > >I'm using U-Boot 1.1.1 and vanilla kernel.org 2.6.11.4 (actually=20=

> now
>  > >2.6.11.5).=A0 My BCSR_ADDR looks the same as what you've listed=20
> below, so
>  > >I'd guess the difference is with U-Boot...=A0 (Another engineer =
here
>  > >installed U-Boot on my board, from, I believe, a binary copy he=20
> got from
>  > >a Freescale(?) CD...=A0 I didn't build U-Boot from source...=A0 =
That's
>  > >something I'll need to take a look at...)
>  > >
>  > >Mike, have you discovered anything further about your problem?
>  > >
>  > >
>  > >
>  > >Walt
>  > >
>  > >
>  > >
>  > >On Tue, 2005-03-29 at 08:29 +0200, Bastos Fernandez Alexandre=20
> wrote:
>  > >=A0
> > >
>  > >>Hi,
> > >>
>  > >>>=46rom "linux/arch/ppc/platforms/pq2ads.h"
> > >>#define BCSR_ADDR ((uint) 0xf4500000)
>  > >>>=46rom "u-boot/include/configs/MPC8260ADS.h"
> > >>#define CFG_BCSR 0xF4500000
>  > >>So ...
>  > >>Which version of u-boot and/or linux tree are you using?
>  > >>With linuxppc-2.5 and u-boot 1.2 everything works fine for me.
>  > >>Maybe Mike's problem is other. Maybe not. :-)
>  > >>
>  > >>Best regards,
>  > >>Alex
>  > >>
>  > >>=A0=A0=A0
> > >>
>  > >>>-----Original Message-----
>  > >>>From:=A0=A0=A0=A0=A0 Walter L. Wimer III =
[SMTP:walt.wimer@timesys.com]
> > >>>Sent:=A0=A0=A0=A0=A0 Monday, March 28, 2005 6:07 PM
>  > >>>To:=A0=A0=A0=A0=A0=A0=A0 Mike Rapoport
> > >>>Cc:=A0=A0=A0=A0=A0=A0=A0 linuxppc-embedded@ozlabs.org
> > >>>Subject:=A0=A0 Re: Problem running Linux 2.6.11 on MPC8272ADS
> > >>>
>  > >>>
>  > >>>Hi Mike,
>  > >>>
>  > >>>I had the same "hang" experience.=A0 The file=20
> arch/ppc/platforms/pq2ads.c
> > >>>contains the following function:
>  > >>>
>  > >>>=A0 void __init
>  > >>>=A0 m82xx_board_setup(void)
> > >>>=A0 {
>  > >>>=A0=A0 /* Enable the 2nd UART port */
>  > >>>=A0=A0 *(volatile uint *)(BCSR_ADDR + 4) &=3D ~BCSR1_RS232_EN2;
> > >>>=A0 }
>  > >>>
>  > >>>
>  > >>>I had to ifdef-out the assignment statement above.=A0 It appears=20=

> that the
>  > >>>definition for BCSR_ADDR in the kernel code differs from what=20
> U-Boot is
>  > >>>using, and that area of memory isn't properly mapped into the=20
> kernel
>  > >>>address space this early in the boot sequence.=A0 As a result, I=20=

> was
>  > >>>getting an Oops() before the console was even enabled (I could=20=

> see the
>  > >>>Oops message by examining the kernel's printk log buffer using a
>  > >>>BDI-2000 hardware debugger).
>  > >>>
>  > >>>
>  > >>>
>  > >>>Good luck,
>  > >>>
>  > >>>Walt Wimer
>  > >>>TimeSys Corporation
>  > >>>
>  > >>>
>  > >>>
>  > >>>
>  > >>>On Sun, 2005-03-27 at 11:31 +0200, Mike Rapoport wrote:
>  > >>>=A0=A0=A0=A0=A0
> > >>>
>  > >>>>Hi,
>  > >>>>I'm trying to bring up the Linux 2.6.11 on MPC8272ADS and it=20
> seem to
> > >>>>hang up at the very beginning.
>  > >>>>I use ads8272_defconfig and then enable console on SCC:
>  > >>>>
>  > >>>>CONFIG_SERIAL_CPM=3Dy
> > >>>>CONFIG_SERIAL_CPM_CONSOLE=3Dy
> > >>>>CONFIG_SERIAL_CPM_SCC1=3Dy
> > >>>>
>  > >>>>
>  > >>>>when I boot the kernel from the u-boot the system hangs up=20
> right after
> > >>>>the kernel decompression.
> > >>>>
>  > >>>>=A0=A0=A0=A0=A0=A0=A0
> > >>>>
>  > >>>_______________________________________________
> > >>>Linuxppc-embedded mailing list
>  > >>>Linuxppc-embedded@ozlabs.org
> > >>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>  > >>>=A0=A0=A0=A0=A0
> > >>>
>  > >
>  > >
>  > >=A0
> > >
>  >
>
>  _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
