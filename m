Return-Path: <nvbolhuis@aimvalley.nl>
Received: from mika.eatserver.nl (mika.eatserver.nl [195.20.9.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4E508B6F62
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2012 03:56:37 +1100 (EST)
Message-ID: <4F15A83C.7020805@aimvalley.nl>
Date: Tue, 17 Jan 2012 17:56:28 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Cannot wake-up from standby with MPC8313
References: <4F047BF8.7090400@aimvalley.nl> <4F04BFEA.1050009@freescale.com>
 <4F05C8C2.9070401@aimvalley.nl> <4F05EA6B.9040902@freescale.com>
 <4F06FCBC.4090302@aimvalley.nl> <4F076187.2080308@freescale.com>
 <4F103C17.3080003@aimvalley.nl> <4F1486F1.7000406@freescale.com>
In-Reply-To: <4F1486F1.7000406@freescale.com>
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

On 01/16/12 21:22, Scott Wood wrote:
> On 01/13/2012 08:13 AM, Norbert van Bolhuis wrote:
>> I dumped SIPNR/SIMSR and uart IIR/EIR (since console triggers wake-up)
>> but they do not change just before entering standby (via
>> mpc6xx_enter_standby
>> which omits setting MSR_POW). uart IRQ is always enabled, unmasked and
>> not pending.
>>
>> I tried to log to physical memory to see what's going on whenever the
>> board fails to wake-up.
>> (I can examine physical memory after CPU is stuck in sleep, by connecting
>>   a JTAG debugger, start u-boot and stop after DDR2 SDRAM ctrl is
>>   re-configured)
>
> Are you sure this isn't going to disturb anything?  Why does U-Boot need
> to be involved, and the SDRAM reconfigured?
>


If CPU is stuck in sleep, JTAG will send HRESET or SRESET (i'm nor sure
which one it is) and u-boot is needed to reconfigure CPU and DDR2 SDRAM ctrl.
SDRAM contents (for physical memory "unknown" to u-boot and linux) seems to
survive such a soft-reset.


>> It looks like an interupt does occur, but do_IRQ seems to be stuck
>> in ppc_md.get_irq=ipic_get_irq where it reads SIVCR.
>
> Stuck as in the load never completes, or as in ipic_get_irq() gets
> called repeatedly?  If the latter, what value is it reading out?  Is the
> interrupt pending in SIPNR at this point?
>


I think I was wrong. I enabled tracing do_IRQ just a little bit too soon
(in suspend_enter). The interrupt I saw was probably one that occured
just before CPU entered sleep (mpc6xx_enter_standby).

Right now I see no external interrupt happening, so that brings us back
where we were before: I'm not getting an interrupt regardless of low-power state.
So now my main question is: how can JTAG and/or any other external signal
cause this ?

Another weird thing I noticed is that whenever I dump CPU memmap
(which starts at 0xe0000000) under linux it always crashes with a "check stop"
when it is displaying somewhere at 0xe0000800-0xe0001000
If I connect our JTAG debugger it never crashes and dumping CPU memmap
always works.


---
NvBolhuis
