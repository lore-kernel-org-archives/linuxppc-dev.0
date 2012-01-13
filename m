Return-Path: <nvbolhuis@aimvalley.nl>
Received: from mika.eatserver.nl (mika.eatserver.nl [195.20.9.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1B00FB6F6F
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2012 01:13:53 +1100 (EST)
Message-ID: <4F103C17.3080003@aimvalley.nl>
Date: Fri, 13 Jan 2012 15:13:43 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Cannot wake-up from standby with MPC8313
References: <4F047BF8.7090400@aimvalley.nl> <4F04BFEA.1050009@freescale.com>
 <4F05C8C2.9070401@aimvalley.nl> <4F05EA6B.9040902@freescale.com>
 <4F06FCBC.4090302@aimvalley.nl> <4F076187.2080308@freescale.com>
In-Reply-To: <4F076187.2080308@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/06/12 22:03, Scott Wood wrote:
 > On 01/06/2012 07:53 AM, Norbert van Bolhuis wrote:
 >> On 01/05/12 19:22, Scott Wood wrote:
 >>> On 01/05/2012 09:58 AM, Norbert van Bolhuis wrote:
 >>>> thanks for your response.
 >>>>
 >>>> not setting MSR_POW gives same result.
 >>>
 >>> OK, so you're not getting an interrupt regardless of low-power state.
 >>>
 >>> Check whether the interrupt is getting masked during standby preparation.
 >>>
 >>> Does the interrupt handler run when you're not trying to enter standby?
 >>>
 >>
 >>
 >> The GPIO/UART interrupt nor the PMC interrupt are being masked during
 >> standby
 >> preperation.
 >> The GPIO/UART interrupt works fine in "operational" mode.
 >> The PMC interrupt I do not know, is it possible to to get PMC interrupt
 >> without going to standby or deep-sleep ?
 >
 > The PMC interrupt is mainly of interest when running as a PCI agent, to
 > be notified when the host changed the desired suspend state in config space.
 >
 > What changes from operational mode to the test where you omit setting
 > MSR_POW?
 >
 > Try dumping SIPNR/SIMSR and GPIER/GPIMR/GPDAT at various points.
 >


I dumped SIPNR/SIMSR and uart IIR/EIR (since console triggers wake-up)
but they do not change just before entering standby (via mpc6xx_enter_standby
which omits setting MSR_POW). uart IRQ is always enabled, unmasked and
not pending.

I tried to log to physical memory to see what's going on whenever the
board fails to wake-up.
(I can examine physical memory after CPU is stuck in sleep, by connecting
  a JTAG debugger, start u-boot and stop after DDR2 SDRAM ctrl is
  re-configured)

It looks like an interupt does occur, but do_IRQ seems to be stuck
in ppc_md.get_irq=ipic_get_irq where it reads SIVCR.

I have no idea why, any more suggestions ?


---
NvBolhuis
