Return-Path: <nvbolhuis@aimvalley.nl>
Received: from mika.eatserver.nl (mika.eatserver.nl [195.20.9.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AE888B6FB4
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Jan 2012 02:59:03 +1100 (EST)
Message-ID: <4F05C8C2.9070401@aimvalley.nl>
Date: Thu, 05 Jan 2012 16:58:58 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Cannot wake-up from standby with MPC8313
References: <4F047BF8.7090400@aimvalley.nl> <4F04BFEA.1050009@freescale.com>
In-Reply-To: <4F04BFEA.1050009@freescale.com>
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

On 01/04/12 22:08, Scott Wood wrote:

...

> It's been a while since I've touched this, but IIRC the PMC events are
> mainly important for deep sleep, and for normal sleep (standby) you can
> wake from any interrupt other than core interrupts like timebase.  I'm
> not sure to what extent setting PMCCR[SLPEN] affects this -- I don't see
> where the documentation says what "system low power state" means.  I
> would be surprised if GPIO were affected, though, since it's supported
> as a wakeup source even in deep sleep.  I think I was able to wake from
> standby on a UART interrupt even with SLPEN set.
>
> Are you sure the GPIO block is asserting an interrupt, and that it
> hasn't been masked during the preparation for standby?
>
> What happens if you modify mpc6xx_enter_standby() to not actually set
> MSR_POW?
>


thanks for your response.

not setting MSR_POW gives same result.

if I set kernel.powersave-nap=1 it works fine, so apparently
NAP/DOZE mode does work (if CPU is idle). This saves almost no
power though. Standby mode saves about 300-500 mW.

The problem could well be our board though, today I learned it does
work by connecting an (inactive) JTAG debugger.
Also, on another board it always works.

And indeed wake-up occurs through GPIO interrupt or UART interrupt
(key press on console).


---
NvBolhuis
