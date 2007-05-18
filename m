Return-Path: <acahalan@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by ozlabs.org (Postfix) with ESMTP id 739D6DDE11
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 13:24:17 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so1420746nzf
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 20:24:16 -0700 (PDT)
Message-ID: <787b0d920705172024g723412b4n8f82d3cd78e0f702@mail.gmail.com>
Date: Thu, 17 May 2007 23:24:15 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: galak@kernel.crashing.org, tglx@linutronix.de, mingo@elte.hu,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	sshtylyov@ru.mvista.com
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov writes:
> Kumar Gala wrote:
>> [Sergei Shtylyov]
>>> Kumar Gala wrote:

>>>> I haven't looked at all the new clock/timer code, is there any
>>>> utility in having support for more than one clock source?
>>>
>>> Of course, you may register as many as you like.
>>
>> Sure, but is there any utility in registering more than the
>> decrementer on PPC?
>
> Not yet. I'm not sure I know any other PPC CPU facility fitting
> for clockevents. In theory, FIT could be used -- but its period
> is measured in powers of 2, IIRC.

I'd really like to have that as an option. It would allow oprofile
to safely use hardware events on the MPC74xx "G4" processors.
Alternately it would allow thermal events. It is safe to use at
most one of the three (decrementer,profiling,thermal) interrupts.
If two were to hit at the same time, badness happens.

It's possible to wrapper the interrupt in something that divides
down, calling the normal code only some of the time. I think one
of the FIT choices is about 4 kHz on my system, which would be OK.

Full oprofile functionality would be wonderful.
