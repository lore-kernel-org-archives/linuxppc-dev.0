Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05FFE67BAD
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 20:13:47 +1100 (EST)
Subject: Re: Booting without Uboot on 8548E
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: M Ptich <ptich@hotmail.com>
In-Reply-To: <BAY102-F21BB220054F2541A7614E4A9FD0@phx.gbl>
References: <BAY102-F21BB220054F2541A7614E4A9FD0@phx.gbl>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 20:13:40 +1100
Message-Id: <1162631621.28571.26.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-04 at 08:52 +0000, M Ptich wrote:
> Documentation mentions that the only dependencies between 2.6 Kernel and 
> bootloader are:
> 
> 1. 5 input parameters (bd_t pointer, start and end of command line, start 
> and end of ram disk)
> 2. bd_t pointer and command line must with within 16MB of Kernel
> 3. Initial TLB1 entry must have IPROT=1

This is for arch/ppc, which is sort-of deprecated. You should seriously
think about porting over to arch/powerpc instead.

> Slowly, we are finding that this list is not complete. For example, address 
> calculation at the start of platform_init (r3 + ...) assumes that Kernel has 
> been initially loaded at 0-base virtual address.

For which CPU core ? 6xx/7xx/7xxx/G2 cores don't assume such a thing,
the kernel can be loaded anywhere as long as the virtual and physical
addresses are the same.

> And now we are stuck with apparently another dependency: our Kernel fails to 
> advance beyond time calibration because jiffies are not getting incremented, 
> so we are not getting timer interrupts. Is it true that Kernel relies on 
> EPIC timer set in Uboot ? If not - where the timer insterrupts are 
> configured ?

I'm not familiar about which core family the 85xx is. Doesn't it use the
decrementer ?

Ben.
