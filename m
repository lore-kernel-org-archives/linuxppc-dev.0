Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 542B5DDDF7
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 04:33:34 +1000 (EST)
Message-ID: <4713B28A.2060004@ru.mvista.com>
Date: Mon, 15 Oct 2007 22:33:46 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
References: <20070921032603.0D3EA32C887@thor> <4713A616.3090103@ru.mvista.com>
In-Reply-To: <4713A616.3090103@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

>>@@ -797,6 +796,53 @@ void __init clocksource_init(void)
>> 	       clock->name, clock->mult, clock->shift);
>> }

>>+static int decrementer_set_next_event(unsigned long evt,
>>+				      struct clock_event_device *dev)
>>+{
>>+	set_dec(evt);

>     I'd use (evt - 1) since the interrupt gets generated at 0xffffffff count, 
> not 0 (on classic CPUs).  With you removing of the code that compensated for 
> the errors, they will accumulate.  And no, this wouldn't be enough anyway, 
> since on 40x and Book E you'll need to set it for evt anyway, since the 
> interrupt happens at 0 count...

    What that means is that the off-by-one-clock drift is introduced for 
classic CPUs (not 40x or Book E which interrupt at 0).  And this has dealt 
with months ago in the clockevent driver in the -rt patch.  So much for my 
efforts...

>     NAK the patch.

    It's too late for NAKs -- I should've given these patches more attention 
(yet I was in hospital for 1.5 months).

WBR, Sergei
