Return-Path: <nvbolhuis@aimvalley.nl>
Received: from mika.eatserver.nl (mika.eatserver.nl [195.20.9.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DED9BB6FB9
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Jan 2012 00:53:08 +1100 (EST)
Message-ID: <4F06FCBC.4090302@aimvalley.nl>
Date: Fri, 06 Jan 2012 14:53:00 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Cannot wake-up from standby with MPC8313
References: <4F047BF8.7090400@aimvalley.nl> <4F04BFEA.1050009@freescale.com>
 <4F05C8C2.9070401@aimvalley.nl> <4F05EA6B.9040902@freescale.com>
In-Reply-To: <4F05EA6B.9040902@freescale.com>
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

On 01/05/12 19:22, Scott Wood wrote:
> On 01/05/2012 09:58 AM, Norbert van Bolhuis wrote:
>> thanks for your response.
>>
>> not setting MSR_POW gives same result.
>
> OK, so you're not getting an interrupt regardless of low-power state.
>
> Check whether the interrupt is getting masked during standby preparation.
>
> Does the interrupt handler run when you're not trying to enter standby?
>


The GPIO/UART interrupt nor the PMC interrupt are being masked during standby
preperation.
The GPIO/UART interrupt works fine in "operational" mode.
The PMC interrupt I do not know, is it possible to to get PMC interrupt
without going to standby or deep-sleep ?
In anyway there is no PMC interrupt for NAP mode (if kernel.powersave-nap=1).


>> if I set kernel.powersave-nap=1 it works fine,
>
> What is "it"?  Do you mean that powersave-nap doesn't break things, or
> that standby works when you specify that?
>


I mean powersave-nap itself seems to work and does not break things.


>> so apparently NAP/DOZE mode does work (if CPU is idle). This saves almost no
>> power though. Standby mode saves about 300-500 mW.
>>
>> The problem could well be our board though, today I learned it does
>> work by connecting an (inactive) JTAG debugger.
>> Also, on another board it always works.
>
> You mean connecting a JTAG but not doing anything with it made
> wake-from-standby work?
>
> There was a bug like that on early revisions of the mpc8313erdb board --
> though in that case if you had a bad board the system would hang
> whenever you access any PMC register.  I'm not sure what the mechanism
> of failure was; IIRC the fix was adding a resistor.
>


yes, connecting a JTAG but not doing anything with it makes
wake-from-standby work.

I don't know what's wrong with (some of) our boards... it looks
like external interrupts are blocked and/or core stays in reset..

I doubt there's a SW PMC race/deadlock that causes this.


---
NvBolhuis
