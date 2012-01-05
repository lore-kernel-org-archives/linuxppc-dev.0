Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 796771007D6
 for <linuxppc-dev@ozlabs.org>; Fri,  6 Jan 2012 05:22:41 +1100 (EST)
Message-ID: <4F05EA6B.9040902@freescale.com>
Date: Thu, 5 Jan 2012 12:22:35 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: Re: Cannot wake-up from standby with MPC8313
References: <4F047BF8.7090400@aimvalley.nl> <4F04BFEA.1050009@freescale.com>
 <4F05C8C2.9070401@aimvalley.nl>
In-Reply-To: <4F05C8C2.9070401@aimvalley.nl>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/05/2012 09:58 AM, Norbert van Bolhuis wrote:
> thanks for your response.
> 
> not setting MSR_POW gives same result.

OK, so you're not getting an interrupt regardless of low-power state.

Check whether the interrupt is getting masked during standby preparation.

Does the interrupt handler run when you're not trying to enter standby?

> if I set kernel.powersave-nap=1 it works fine,

What is "it"?  Do you mean that powersave-nap doesn't break things, or
that standby works when you specify that?

> so apparently NAP/DOZE mode does work (if CPU is idle). This saves almost no
> power though. Standby mode saves about 300-500 mW.
> 
> The problem could well be our board though, today I learned it does
> work by connecting an (inactive) JTAG debugger.
> Also, on another board it always works.

You mean connecting a JTAG but not doing anything with it made
wake-from-standby work?

There was a bug like that on early revisions of the mpc8313erdb board --
though in that case if you had a bad board the system would hang
whenever you access any PMC register.  I'm not sure what the mechanism
of failure was; IIRC the fix was adding a resistor.

-Scott
