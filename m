Return-Path: <ptich@hotmail.com>
Received: from bay0-omc2-s17.bay0.hotmail.com (bay0-omc2-s17.bay0.hotmail.com
	[65.54.246.153]) by ozlabs.org (Postfix) with ESMTP id 5752D67BC4
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 20:40:25 +1100 (EST)
Message-ID: <BAY102-F634C51A5AEEB25090456BA9FD0@phx.gbl>
In-Reply-To: <1162631621.28571.26.camel@localhost.localdomain>
From: "M Ptich" <ptich@hotmail.com>
To: benh@kernel.crashing.org
Subject: Re: Booting without Uboot on 8548E
Date: Sat, 04 Nov 2006 09:28:16 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>You should seriously think about porting
>over to arch/powerpc instead.

8548E is E500v2 core. Our Kernel is from Freescale, it is using arch/ppc. I 
am not sure how well (if at all) E500 is supported in the arch/powerpc from 
the FSF ditribution.

>I'm not familiar about which core family the 85xx is. Doesn't it use the
>decrementer ?

Actually E500 could use Decrementer, with its Autoreload feature to get an 
exact time tick. I did not think about it, will investigate.

M Ptich



>From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>To: M Ptich <ptich@hotmail.com>
>CC: linuxppc-dev@ozlabs.org
>Subject: Re: Booting without Uboot on 8548E
>Date: Sat, 04 Nov 2006 20:13:40 +1100
>MIME-Version: 1.0
>Received: from gate.crashing.org ([63.228.1.57]) by 
>bay0-mc7-f7.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2444); Sat, 4 
>Nov 2006 01:13:43 -0800
>Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])by 
>gate.crashing.org (8.13.8/8.13.8) with ESMTP id kA49DeGf013357;Sat, 4 Nov 
>2006 03:13:41 -0600
>X-Message-Info: LsUYwwHHNt3660MmjhEvYg2f34OAemlKtU9j2Z7TuGo=
>References: <BAY102-F21BB220054F2541A7614E4A9FD0@phx.gbl>
>X-Mailer: Evolution 2.8.1 Return-Path: benh@kernel.crashing.org
>X-OriginalArrivalTime: 04 Nov 2006 09:13:43.0980 (UTC) 
>FILETIME=[86C386C0:01C6FFF1]
>
>On Sat, 2006-11-04 at 08:52 +0000, M Ptich wrote:
> > Documentation mentions that the only dependencies between 2.6 Kernel and
> > bootloader are:
> >
> > 1. 5 input parameters (bd_t pointer, start and end of command line, 
>start
> > and end of ram disk)
> > 2. bd_t pointer and command line must with within 16MB of Kernel
> > 3. Initial TLB1 entry must have IPROT=1
>
>This is for arch/ppc, which is sort-of deprecated. You should seriously
>think about porting over to arch/powerpc instead.
>
> > Slowly, we are finding that this list is not complete. For example, 
>address
> > calculation at the start of platform_init (r3 + ...) assumes that Kernel 
>has
> > been initially loaded at 0-base virtual address.
>
>For which CPU core ? 6xx/7xx/7xxx/G2 cores don't assume such a thing,
>the kernel can be loaded anywhere as long as the virtual and physical
>addresses are the same.
>
> > And now we are stuck with apparently another dependency: our Kernel 
>fails to
> > advance beyond time calibration because jiffies are not getting 
>incremented,
> > so we are not getting timer interrupts. Is it true that Kernel relies on
> > EPIC timer set in Uboot ? If not - where the timer insterrupts are
> > configured ?
>
>I'm not familiar about which core family the 85xx is. Doesn't it use the
>decrementer ?
>
>Ben.
>
>

_________________________________________________________________
Get FREE company branded e-mail accounts and business Web site from 
Microsoft Office Live 
http://clk.atdmt.com/MRT/go/mcrssaub0050001411mrt/direct/01/
