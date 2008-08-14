Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 5050DDDEE9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 14:41:09 +1000 (EST)
Received: from [192.168.1.37] (node119.78.251.72.1dial.com [72.251.78.119])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m7E4dXiD051230
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 21:40:59 -0700 (PDT)
Message-ID: <48A3B62C.90603@hypersurf.com>
Date: Wed, 13 Aug 2008 21:35:56 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: details, details ...
References: <48A2CD2A.5020107@hypersurf.com> <200808131500.51018.arnd@arndb.de>
	<48A33E6B.9010200@hypersurf.com> <200808132305.45507.arnd@arndb.de>
In-Reply-To: <200808132305.45507.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Wednesday 13 August 2008, Kevin Diggs wrote:
> 
> 
>>Arnd Bergmann wrote:
>>
>>>On Wednesday 13 August 2008, Kevin Diggs wrote:
>>>
>>>
>>>>In cpu exit function of a cpufreq driver:
>>>>
>>>>        while (test_bit(cf750gxmChangingPllBit, &cf750gxvStateBits))
>>>>                msleep(1);
>>>>
>>>>This bit will get cleared by a notifier callback.
>>>>
>>>>In module_exit function of a related module:
>>>>
>>>>        while (test_bit(PLL_LOCK_BIT, (unsigned long *)&boot_ratio)) {
>>>>                msleep(1);
>>>>        }
>>>>
>>>>This bit will get cleared by a timer. It will also fire the notifiers 
>>>>needed above.
>>>>
>>>>I don't think these are in interrupt context. The sleeps ok here?
>>>
>>>
>>>Technically ok, but not nice. Besides the coding style issues,
>>>it's still a busy loop that should be replaced by wait_for_completion().
>>>
>>
>>I took a brief look at wait_for_completion(). Looks kinda heavy weight. 
>>Just to be clear both of these code fragments are in code shutdown (i.e. 
>>exit) paths. Is the use of wait_for_completion() still preferred? I 
>>thought a "busy loop" used the delay routines?
> 
> 
> You should always write code that is easy to understand and tells the
> reader what you mean. If you want to wait for something to complete,
> use wait_for_completion. If you look at what msleep does internally,
> you will find that it isn't simpler than wait_for_completion either.
> 
> The loop doing msleep(1) is not as bad as a loop doing delays, but
> it can still cause unnecessary wakeups and on average will sleep
> one milisecond too long. Neither of these is a real problem, but
> if you can do it correctly, just do.
> 
Please forgive me. I'm not trying to be argumentative. I'm just trying 
to learn. I found a section in the O'Reilly Linux device driver guide on 
this completion stuff. If I understand it correctly, I initialize a 
completion thing. In the code that starts the task I do a complete(). In 
the exit code I'll do a wait_for_completion(). In my usage paradigm I 
will VERY rarely ever call wait_for_completion() and have it actually 
wait. This still match completion's intended use?
> 
>>Can you elaborate on the coding style issues? Variable names? Use of the 
>>bit stuff? Those brace thingies?
> 
> 
> Variables should be lower-case names, constants should be upper-case.
> Both should have names that tell you what they are used for.
> The case in the second code sample is either wrong, or redundant.
> You should leave out curly braces when you only have a single line
> in the basic block. Read Documentation/CodingStyle to learn about
> more things to consider.
> 
Can I post the 2 routines for RFC style comments? Or is that to much 
trouble?
> 
>>>Don't bother. Old gcc variants would put these variables into .data
>>>instead of .bss, but with a new (less than 5 years or so) gcc, both
>>>will result in .bss storage that is initialized to zero at boot time.
>>>
>>
>>??? So ... I can ignore the error? Or I should not be initializing 
>>variables to 0 (or NULL)?
> 
> 
> Either fix checkpatch.pl not to warn about these, or just don't initialize
> the variables. Initializing a variable at declaration time is frowned upon
> by some people, because it is redundant in case of static or global
> variables, and error-prone for automatic variables.
> 
When you say initializing is frowned upon, do you mean only when you are 
initializing to zero? Is the redundancy (for the case of 0?) a part of 
the C spec? Or is it gcc specific? error-prone for automatic variables?

kevin
> 	Arnd <><
> 
> 
