Return-Path: <Tom.Ziomek@motorola.com>
Received: from mail119.messagelabs.com (mail119.messagelabs.com
	[216.82.241.179]) by ozlabs.org (Postfix) with SMTP id 186C1DDE0E
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 09:11:26 +1100 (EST)
Received: from az33exr04.mot.com (az33exr04.mot.com [10.64.251.234])
	by motgate4.mot.com (8.12.11/Motorola) with ESMTP id lAUMBNBQ005210
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 15:11:23 -0700 (MST)
Received: from az10vts02.mot.com (az10vts02.mot.com [10.64.251.243])
	by az33exr04.mot.com (8.13.1/Vontu) with SMTP id lAUMBMHj027249
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 16:11:22 -0600 (CST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by az33exr04.mot.com (8.13.1/8.13.0) with ESMTP id lAUMBKTC027241
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 16:11:21 -0600 (CST)
Date: Fri, 30 Nov 2007 16:11:20 -0600 (CST)
From: T Ziomek <ctz001@email.mot.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/24] powerpc: early debug forces console log level to max
In-Reply-To: <1196456185.13230.100.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0711301605540.5450@gauley.ddna.labs.mot.com>
References: <20071130061200.4BAF9DDFAE@ozlabs.org>
	<Pine.LNX.4.64.0711301306520.5450@gauley.ddna.labs.mot.com>
	<1196456185.13230.100.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 1 Dec 2007, Benjamin Herrenschmidt wrote:
>
> On Fri, 2007-11-30 at 13:10 -0600, T Ziomek wrote:
>>> This patch makes the early debug option force the console loglevel
>>> to the max. The early debug option is meant to catch messages very
>>> early in the kernel boot process, in many cases, before the kernel
>>> has a chance to parse the "debug" command line argument. Thus it
>>> makes sense when CONFIG_PPC_EARLY_DEBUG is set, to force the console
>>> log level to the max at boot time.
>>   . . .
>>> +#ifdef CONFIG_PPC_EARLY_DEBUG
>>> +     console_loglevel = 10;
>>> +#endif
>>> }
>>
>> The change makes sense, but wouldn't it also make sense to note it in
>> arch/powerpc/Kconfig.debug?  Otherwise it's really hard to figure out
>> why,
>> after bringing up a new board, removing "debug" from the kernel cmd
>> line
>> does, well, nothing.
>
> Possibly, though you aren't supposed to leave EARLY_DEBUG enabled
> once you are done debugging :-)

I'm probably not the only person that would turn it on when needed, think
"well, no harm in leaving it on for the rest of my development, and it
might be handy; just turn it off when we're done".

It's these kind of non-obvious but undocumented things that make a lot of
OSS code a pain to work with for non-experts [1].  What's the harm in
giving folks a heads-up?

[1] : And I don't just mean newbies...I mean anybody who doesn't live in
        the code on a daily basis year-round.

-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
