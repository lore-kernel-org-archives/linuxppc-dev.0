Return-Path: <nvbolhuis@aimvalley.nl>
Received: from mika.eatserver.nl (mika.eatserver.nl [195.20.9.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D4DC9B6EEE
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2012 21:16:12 +1100 (EST)
Message-ID: <4F169BE3.30102@aimvalley.nl>
Date: Wed, 18 Jan 2012 11:16:03 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Cannot wake-up from standby with MPC8313
References: <4F047BF8.7090400@aimvalley.nl> <4F04BFEA.1050009@freescale.com>
 <4F05C8C2.9070401@aimvalley.nl> <4F05EA6B.9040902@freescale.com>
 <4F06FCBC.4090302@aimvalley.nl> <4F076187.2080308@freescale.com>
 <4F103C17.3080003@aimvalley.nl> <4F1486F1.7000406@freescale.com>
 <4F15A83C.7020805@aimvalley.nl> <4F15F17C.20202@freescale.com>
In-Reply-To: <4F15F17C.20202@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/17/12 23:09, Scott Wood wrote:

...

>>
>> If CPU is stuck in sleep, JTAG will send HRESET or SRESET (i'm nor sure
>> which one it is) and u-boot is needed to reconfigure CPU and DDR2 SDRAM
>> ctrl.
>
> Why is a reset needed in order to examine physical memory?
>


Because CPU is stuck in sleep and I use the CPU to dump the physical memory
(which contains the log entries made just before CPU got stuck).


>> SDRAM contents (for physical memory "unknown" to u-boot and linux) seems to
>> survive such a soft-reset.
>
> And all register and device state is as Linux left it?
>


Probably not, but at least the physical memory contents seems to survive
the soft-reset.


>>>> It looks like an interupt does occur, but do_IRQ seems to be stuck
>>>> in ppc_md.get_irq=ipic_get_irq where it reads SIVCR.
>>>
>>> Stuck as in the load never completes, or as in ipic_get_irq() gets
>>> called repeatedly?  If the latter, what value is it reading out?  Is the
>>> interrupt pending in SIPNR at this point?
>>>
>>
>>
>> I think I was wrong. I enabled tracing do_IRQ just a little bit too soon
>> (in suspend_enter). The interrupt I saw was probably one that occured
>> just before CPU entered sleep (mpc6xx_enter_standby).
>>
>> Right now I see no external interrupt happening, so that brings us back
>> where we were before: I'm not getting an interrupt regardless of
>> low-power state.
>> So now my main question is: how can JTAG and/or any other external signal
>> cause this ?
>
> I can't help you with the hardware side of it, other than to say that it
> sounds similar to an issue we had on early revs of mpc8313erdb.  Could
> you make sure that TRST (JTAG Test Reset) is not being asserted except
> while PORESET is asserted?
>
> If that's not it, I'm wondering what the relevant difference is on the
> software side to differentiate the case where you go through all the
> motions but don't set MSR[POW] from the case where you don't try to
> suspend at all (just take the interrupt during normal execution).  Are
> you sure that you're making it to mpc6xx_enter_standby, and that it's
> not hanging on a PMC register access?
>
>> Another weird thing I noticed is that whenever I dump CPU memmap
>> (which starts at 0xe0000000) under linux it always crashes with a "check
>> stop"
>> when it is displaying somewhere at 0xe0000800-0xe0001000
>> If I connect our JTAG debugger it never crashes and dumping CPU memmap
>> always works.
>
> Is it 0xe0000bXX?  A hang when accessing the PMC registers is what I saw
> with the mpc8313erdb bug.
>
> -Scott
>
>

Yes this is it!
You mentioned mpc8313erdb bug before, I guess you had to mention it twice before
I looked at mpc8313erdb bug description.

The mpc8313erdb bug is described as follows:

3.5 Power management control (PMC) registers cannot be
accessed?
The PMC registers range from IMMR + 0x0B00 to IMMR + 0x0BFF. When this
area is accessed in u-boot,
the RDB hangs up. It appears that the PMC block is related to the JTAG
interface; TRST must not be pulled
down for normal operation of the PMC block. Possible workarounds are as
follows:
• Attach a debugger to drive TRST high during normal operation.
• Remove the pull-down resistor (R37) for TRST. Although this tested on
some RDBs without any
problem, it violates the hardware specification. If it does not work on
your RDB, use another workaround.


I guess this is an MPC8313 problem rather than an MPC8313E-RDB problem ?
and I would expect it to be mentioned in MPC8313E Errata (which isn't the
case).

Anyway, thanks a lot for all help!

---
NvBolhuis
