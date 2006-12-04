Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 24D1E67BDA
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 04:08:24 +1100 (EST)
Message-ID: <45745664.5040404@ru.mvista.com>
Date: Mon, 04 Dec 2006 20:09:56 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t
	in	latency_trace.c (take 3)
References: <200611132252.58818.sshtylyov@ru.mvista.com>
	<457326A2.2020402@ru.mvista.com> <20061204095131.GE7872@elte.hu>
	<4574149B.5070602@ru.mvista.com> <20061204153949.GA9350@elte.hu>
	<45744AF5.2040508@ru.mvista.com> <20061204162300.GA23800@elte.hu>
In-Reply-To: <20061204162300.GA23800@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, khilman@mvista.com, linux-kernel@vger.kernel.org,
	dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Ingo Molnar wrote:

>>>	/* check for buggy clocks, handling wrap for 32-bit clocks */
>>>-	if (TYPE_EQUAL(cycles_t, unsigned long)) {
>>>+	if (TYPE_EQUAL(cycle_t, unsigned long)) {
>>>		if (time_after((unsigned long)T1, (unsigned long)T2))
>>>			printk("bug: %08lx < %08lx!\n",
>>>				(unsigned long)T2, (unsigned long)T1);

>>   This earlier fix by Kevin woulnd't have sense anymore with cycle_t...

> yeah, indeed - i've zapped this one too.

    Moreover, it was somewhat incorrect from the very start since 'unsigned 
long' is 64-bit on 64-bit machines, and cycles_t is 'unsigned long' on both 
PPC32 and PPC64, so else branch would've *never* be executed...

> basically, what i'd like is the 32-bit clocks/cycles be handled 
> intelligently, and not adding to the cruft that already is in 
> kernel/latency_tracing.c.

    Yeah, I've looked at 2.6.19-rt2 and saw the new approach. But what's left 
to fix there, only the case of using PPC32 raw cycles? I guess you only need 
to cast a result of get_cycles() to cycle_t... wait, it'll be explicitly cast 
in the return stmt, won't it?

> 	Ingo

WBR, Sergei
