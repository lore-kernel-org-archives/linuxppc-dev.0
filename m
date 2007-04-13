Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id C4B03DDEFF
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 06:26:03 +1000 (EST)
Message-ID: <461FE771.2010908@mvista.com>
Date: Fri, 13 Apr 2007 13:26:25 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] add reg and stack dump to booke WD handler
References: <20070413173524.GA17890@blade.az.mvista.com>
	<461FCB6F.7010504@ru.mvista.com>
	<20070413200659.GA21588@blade.az.mvista.com>
	<B8CF9F53-9F51-4DD5-9CB6-16C69502A1CA@kernel.crashing.org>
In-Reply-To: <B8CF9F53-9F51-4DD5-9CB6-16C69502A1CA@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Apr 13, 2007, at 3:06 PM, Dave Jiang wrote:
>
>> Have the booke watchdog dump some useful information when triggered. 
>> Hopefully
>> that'll give the user some hint of what happened rather than just a 
>> mysterious
>> reboot.
>
> Forgot the signed-off-by again (git-commit -s)
>
I need to stop doing that! Grrrrr....

>> -- 
>>
>>  Ok here's try 2. Modified the watchdog driver instead per Sergei's 
>> suggestion.
>
> I'm against having a WatchdogHandler in booke_wdt.c.  The idea behind 
> the weak symbol in traps.c is to allow platform code to override the 
> behavior.  I'm ok if we put the spew in the generic case.
>
Ok, I will put it back in the generic handler.

> Also, how are you testing this?
I just stop the userland watchdog daemon and the watchdog timeout kicks 
in. Of course I could also write a kernel module that takes a spinlock 
and spin.... I tested on the MPC8548 and seems to work as expected.
