Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1022ADDE23
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 00:27:51 +1000 (EST)
Message-ID: <464DB800.40702@genesi-usa.com>
Date: Fri, 18 May 2007 15:28:16 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
References: <200705172142.26739.sshtylyov@ru.mvista.com>	<8E44DB06-767D-4864-8D2C-6132E4D4370B@kernel.crashing.org>	<464C99FF.8080404@ru.mvista.com>	<135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>	<464C9E67.2020909@ru.mvista.com>	<6E0D5E13-C939-4FCE-81A3-F29DFA6436A2@kernel.crashing.org>
	<464CA222.8000407@ru.mvista.com> <464D9E7E.3090605@genesi-usa.com>
	<464DADFC.3080802@ru.mvista.com>
In-Reply-To: <464DADFC.3080802@ru.mvista.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, mingo@elte.hu,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Sergei Shtylyov wrote:
> Hello.
> 
>>>> Sure, but is there any utility in registering more than the 
>>>> decrementer on PPC?
> 
>>>    Not yet. I'm not sure I know any other PPC CPU facility fitting
>>> for clockevents. In theory, FIT could be used -- but its period is
>>> measured in powers of 2, IIRC.
> 
>> Wouldn't it be possible to use SoC timer functionality, too, and not
>> limit this to what is only present on the CPU die?
> 
>    If you have some SoC timers, you're welcome to add support for it. :-)

Well, that can't be that hard.. I just make a clock_event_device and
clockevents_register_device?

I'm still learning my way through making platform devices (it would be
a shame to write an oldskool module when I can tie it to the device
tree..) but this does look fairly easy.

>> I guess the real question is, how high resolution does a high resolution
>> timer need to be,
> 
>    In the order of microseconds.

I think both the MPC52xx GPT0-7 and the SLT0-1 fulfil this fairly
easily.

>> and how often do you want to be handling interrupts?
> 
>    That depends on a kind of functionality you need: HRT and/or dynamic
> tick...

To be honest I never understood how dynamic ticks works, I am just
kind of excited about the functionality it brings :)

High resolution timers, that I can do. It's fairly easy to see the
benefits to presenting the system with multiple timers that can fire
with giddy amounts of precision (slice timer is between 16ns and
508ms at least, this is perfectly good considering comments above).

If I add a clock_event_device for each MPC52xx GPT and the slice timers,
what then? Where do they get used, and how? :)

I'm just curious as to how the system picks up and what the current
users are. It would be a little bit of a non-starter to provide 10
new high resolution timers, and for there be very little use for them,
but I assume because Intel HPET is supported, there must be at least
some PLANNED users for at least 2 or 3 independant, high resolution
timer interrupt sources beyond dynticks and nanosleep, but perhaps it
is too early (hrtimers were only integrated 6 months? ago, dynticks
is still brand new in mainline?) and I am being a bit impatient?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
