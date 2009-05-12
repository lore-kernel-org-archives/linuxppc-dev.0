Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8D8A4DDF91
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 01:18:34 +1000 (EST)
Message-ID: <4A09933B.8010606@nortel.com>
Date: Tue, 12 May 2009 09:18:19 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: question about softirqs
References: <18948.63755.279732.294842@cargo.ozlabs.ibm.com>
	<20090508.234815.127227651.davem@davemloft.net>
	<4A086DB2.8040703@nortel.com>
	<20090511.162436.193717082.davem@davemloft.net>
	<4A08C62F.1050105@nortel.com> <20090512081237.GA16403@elte.hu>
In-Reply-To: <20090512081237.GA16403@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, netdev@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo Molnar wrote:
> * Chris Friesen <cfriesen@nortel.com> wrote:

>>I think I see a possible problem with this. Suppose I have a 
>>SCHED_FIFO task spinning on recvmsg() with MSG_DONTWAIT set. Under 
>>the scenario above, schedule() would re-run the spinning task 
>>rather than ksoftirqd, thus preventing any incoming packets from 
>>being sent up the stack until we get a real hardware 
>>interrupt--which could be a whole jiffy if interrupt mitigation is 
>>enabled in the net device.

>>DaveM pointed out that if we're doing transmits we're likely to 
>>hit local_bh_enable(), which would process the softirq work.  
>>However, I think we may still have a problem in the above rx-only 
>>scenario--or is it too contrived to matter?

> This could occur, and the problem is really that task priorities do 
> not extend across softirq work processing.
> 
> This could occur in ordinary SCHED_OTHER tasks as well, if the 
> softirq is bounced to ksoftirqd - which it only should be if there's 
> serious softirq overload - or, as you describe it above, if the 
> softirq is raised in process context:

One of the reasons I brought up this issue is that there is a lot of
documentation out there that says "softirqs will be processed on return
from a syscall".  The fact that it actually depends on the scheduler
parameters of the task issuing the syscall isn't ever mentioned.

In fact, "Documentation/DocBook/kernel-hacking.tmpl" in the kernel
source still has the following:

    Whenever a system call is about to return to userspace, or a
    hardware interrupt handler exits, any 'software interrupts'
    which are marked pending (usually by hardware interrupts) are
    run (<filename>kernel/softirq.c</filename>).

If anyone is looking at changing this code, it might be good to ensure
that at least the kernel docs are updated.

Chris
