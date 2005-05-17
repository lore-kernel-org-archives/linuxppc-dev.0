Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 785A7679F5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 11:21:42 +1000 (EST)
In-Reply-To: <42884448.6040505@ybb.ne.jp>
References: <42884448.6040505@ybb.ne.jp>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <63792af268f18c480d5ecf218a4e61af@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 16 May 2005 20:21:22 -0500
To: "Takeharu KATO" <takeharu1219@ybb.ne.jp>
Cc: Glenn Burkhardt <glenn@aoi-industries.com>,
	"Gala Kumar K.-galak" <galak@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] BOOKE_WDT Part 1/2 (Re: PPC 44x Watchdog timer)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

No problem, can you replace all the cmd line parsing with early_param()=20=

code in arch/ppc/kernel/setup.c.  Take a look at=20
arch/ppc64/kernel/setup.c for an example.  We still need to add a call=20=

to parse_early_param() in setup_arch().

Matt & I need to talk about the driver patch.  Once I have more=20
feedback on that I'll let you know.  The major issue I have is having=20
the interrupt handler in drivers/char/watchdog/.. instead of=20
arch/ppc/kernel/traps.c.  However, I dont have a good idea how to=20
structure the changes.

- kumar

On May 16, 2005, at 1:57 AM, Takeharu KATO wrote:

> Hi Kumar:
>
> I'm sorry that the reply becomes slow.
>
> Kumar Gala wrote:
>  >>
>  >
> > Any reason you moved this code into DecrementerHandler?
> >
> >>=A0=A0 /* 0x1000 - Programmable Interval Timer (PIT) Exception */
>  >>=A0=A0=A0=A0=A0=A0=A0=A0=A0 START_EXCEPTION(0x1000, Decrementer)
>  >>=A0 -=A0=A0=A0=A0=A0=A0 NORMAL_EXCEPTION_PROLOG
> >> -=A0=A0=A0=A0=A0=A0 lis=A0=A0=A0=A0 r0,TSR_PIS@h
> >> -=A0=A0=A0=A0=A0=A0 mtspr=A0=A0 SPRN_TSR,r0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 /* Clear the PIT exception=20
> */
>  >>=A0 -=A0=A0=A0=A0=A0=A0 addi=A0=A0=A0 r3,r1,STACK_FRAME_OVERHEAD
> >> -=A0=A0=A0=A0=A0=A0 EXC_XFER_LITE(0x1000, timer_interrupt)
> >> +=A0=A0=A0=A0=A0=A0 b=A0=A0=A0 DecrementerHandler
> >>
>  Current PIT exception handler is too big.
>  If it is not moved, compilation is failed with relocation error.
>  Because current PIT handler overwrites WDT handler's codes, the=20
> compiler
> can not relocate PIT and WDT handler correctly.
