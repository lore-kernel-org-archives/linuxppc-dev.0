Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00BE1DDD04
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 12:14:59 +1100 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A19B@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A19B@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <653893AD-CB60-4123-B4FC-FB9B886BD895@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Exception in kernel mode
Date: Thu, 15 Mar 2007 18:44:14 -0500
To: Charles Krinke <ckrinke@istor.com>
Cc: Chris Carlson <ccarlson@istor.com>, Kevin Smith <ksmith@istor.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 15, 2007, at 4:17 PM, Charles Krinke wrote:

> I ran a couple of more tests and the system did not Oops in the
> timer_interupt except for the first test this morning. The last two
> times, the NIP was
>
> Oops: Exception in kernel mode, sig: 4 [#1]
> PREEMPT
> NIP: C002CE68 LR: C002CEC8 CTR: 00003B25
> REGS: c3119a00 TRAP: 0700   Not tainted  (2.6.17.11)
> MSR: 00081032 <ME,IR,DR>  CR: 88022484  XER: 00000000
> TASK = c3ecd870[920] 'tar' THREAD: c3118000
>
> And
>
> Oops: Exception in kernel mode, sig: 4 [#1]
> PREEMPT
> NIP: C00DEE18 LR: C00DEDD8 CTR: 00000000
> REGS: c299dbc0 TRAP: 0700   Not tainted  (2.6.17.11)
> MSR: 00081032 <ME,IR,DR>  CR: 84022488  XER: 20000000
> TASK = c3e2b7d0[925] 'tar' THREAD: c299c000
>
> For comparision, this is the original one from this morning
>
> Oops: Exception in kernel mode, sig: 4 [#1]
> PREEMPT
> NIP: 00000900 LR: C00E579C CTR: 00003A55
> REGS: c37f3b00 TRAP: 0700   Not tainted  (2.6.17.11)
> MSR: 00081000 <ME>  CR: 24022484  XER: 00000000
> TASK = c3eaf810[940] 'tar' THREAD: c37f2000
>
> I have to conclude this is not necessarily a timer_interrupt problem.
> Also, commenting out the innards of the timer_interrupt causes the
> kernel to hang in its boot right after the message
>
> Memory: xxxK available
>
> So a properly functioning timer_interrupt is essential to the the  
> kernel
> booting.
>
> But, ... At this point, I really don't know which way to jump.

It this a system you are just bringing up or one that's been running  
for a while.  It really seems like memory corruption of some form.   
I'd suggest checking memory controller settings.

Also, what happens if you disassemble the kernel image and look at  
the addresses pointed to by NIP:
C00DEE18 & C002CE68.

- k
