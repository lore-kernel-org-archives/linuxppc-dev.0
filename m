Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 25B6D67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Mar 2005 02:21:53 +1000 (EST)
In-Reply-To: <1112026020.25896.8.camel@excalibur.timesys.com>
References: <1112026020.25896.8.camel@excalibur.timesys.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <4a399aeb5127923823feb2ced5eb0e1d@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 28 Mar 2005 10:21:38 -0600
To: "Walter L. Wimer III" <walt.wimer@timesys.com>
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

A patch to make this work properly would be appreciated.

- kumar

On Mar 28, 2005, at 10:06 AM, Walter L. Wimer III wrote:

>
>
> Hi Mike,
>
> I had the same "hang" experience.=A0 The file =
arch/ppc/platforms/pq2ads.c
> contains the following function:
>
> =A0 void __init
>  =A0 m82xx_board_setup(void)
> =A0 {
>  =A0 =A0=A0=A0=A0=A0 /* Enable the 2nd UART port */
>  =A0 =A0=A0=A0=A0=A0 *(volatile uint *)(BCSR_ADDR + 4) &=3D =
~BCSR1_RS232_EN2;
> =A0 }
>
>
>
> I had to ifdef-out the assignment statement above.=A0 It appears that =
the
>  definition for BCSR_ADDR in the kernel code differs from what U-Boot=20=

> is
>  using, and that area of memory isn't properly mapped into the kernel
>  address space this early in the boot sequence.=A0 As a result, I was
>  getting an Oops() before the console was even enabled (I could see =
the
>  Oops message by examining the kernel's printk log buffer using a
>  BDI-2000 hardware debugger).
>
>
>
>
> Good luck,
>
> Walt Wimer
>  TimeSys Corporation
>
>
>
>
>
> On Sun, 2005-03-27 at 11:31 +0200, Mike Rapoport wrote:
>  > Hi,
>  > I'm trying to bring up the Linux 2.6.11 on MPC8272ADS and it seem =
to
> > hang up at the very beginning.
>  > I use ads8272_defconfig and then enable console on SCC:
>  >
> > CONFIG_SERIAL_CPM=3Dy
> > CONFIG_SERIAL_CPM_CONSOLE=3Dy
> > CONFIG_SERIAL_CPM_SCC1=3Dy
> >
> >
> > when I boot the kernel from the u-boot the system hangs up right=20
> after
> > the kernel decompression.
> >
>
>  _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
