Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 65962DDEA2
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 22:39:04 +1000 (EST)
Message-ID: <464D9E7E.3090605@genesi-usa.com>
Date: Fri, 18 May 2007 13:39:26 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
References: <200705172142.26739.sshtylyov@ru.mvista.com>	<8E44DB06-767D-4864-8D2C-6132E4D4370B@kernel.crashing.org>	<464C99FF.8080404@ru.mvista.com>	<135307ED-7125-4859-8594-4B5B900D92D6@kernel.crashing.org>	<464C9E67.2020909@ru.mvista.com>	<6E0D5E13-C939-4FCE-81A3-F29DFA6436A2@kernel.crashing.org>
	<464CA222.8000407@ru.mvista.com>
In-Reply-To: <464CA222.8000407@ru.mvista.com>
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
> Kumar Gala wrote:
> 
>>> Kumar Gala wrote:
> 
>>>> I haven't looked at all the new clock/timer code, is there any   
>>>> utility in having support for more than one clock source?
> 
>>>    Of course, you may register as many as you like.
> 
>> Sure, but is there any utility in registering more than the  decrementer 
>> on PPC?
> 
>     Not yet. I'm not sure I know any other PPC CPU facility fitting for 
> clockevents. In theory, FIT could be used -- but its period is measured in 
> powers of 2, IIRC.

Wouldn't it be possible to use SoC timer functionality, too, and not limit
this to what is only present on the CPU die?

I guess the real question is, how high resolution does a high resolution
timer need to be, and how often do you want to be handling interrupts?

The 52XX has 8 general purpose timers and 2 slice timers. Both will
generate an interrupt once the clock hits a preset value, the timing
of which is determined by prescalers and the IPB clock..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
