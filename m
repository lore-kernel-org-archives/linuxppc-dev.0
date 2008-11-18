Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 858EDDDDED
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 21:14:45 +1100 (EST)
Date: Tue, 18 Nov 2008 02:11:32 -0800 (PST)
From: Trent Piepho <tpiepho@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Silence timebase sync code
In-Reply-To: <1226964501.8537.3.camel@localhost>
Message-ID: <Pine.LNX.4.64.0811180158400.11673@t2.domain.actdsltmp>
References: <1226959111-11221-1-git-send-email-tpiepho@freescale.com>
	<49889E01-9433-41BE-A6F1-66127856D482@kernel.crashing.org>
	<Pine.LNX.4.64.0811171421090.11673@t2.domain.actdsltmp>
	<1226964501.8537.3.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 18 Nov 2008, Michael Ellerman wrote:
> On Mon, 2008-11-17 at 14:22 -0800, Trent Piepho wrote:
>> On Mon, 17 Nov 2008, Kumar Gala wrote:
>>> On Nov 17, 2008, at 3:58 PM, Trent Piepho wrote:
>>>
>>>> It's over a dozen lines of output and doesn't appear to provide any useful
>>>> information.  Even after looking at the code, I'm in the dark about what
>>>> "score 299, offset 250" means.
>>>>
>>>> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
>>>> ---
>>>> +++ b/arch/powerpc/kernel/smp-tbsync.c
>>>> @@ -113,7 +113,7 @@ void __devinit smp_generic_give_timebase(void)
>>>> {
>>>>  int i, score, score2, old, min=0, max=5000, offset=1000;
>>>>
>>>> -	printk("Synchronizing timebase\n");
>>>> +	pr_info("Synchronizing timebase\n");
>>>
>>> I think its useful to leave this as a printk.
>>
>> #define pr_info(fmt, arg...) \
>>          printk(KERN_INFO fmt, ##arg)
>>
>> Isn't printk with no level tag the same as KERN_INFO?
>
> Stuff like this should IMHO be printk(KERN_DEBUG ..)
>
> That way it will show up in the log as long as you boot with 'debug' on
> your command line, it doesn't require a kernel recompile to turn on. And
> at the same time it doesn't spam the boot log for a normal boot.

Originally my patched changed it to debug, but Kumar requested I keep it at
info level.  The timebase sync code might hang or be slow, so it's nice to
give a status output before doing it.  It seems just as good as most of the
info printks during boot.
