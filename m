Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	by ozlabs.org (Postfix) with ESMTP id 13364679E1
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 12:47:39 +1000 (EST)
Received: from zcarhxs1.corp.nortel.com
	(zcarhxs1.corp.nort...s0.corp.nortel.com [47.129.230.89])
	by zcars04e.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id
	k68205U22453
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Jul 2006 22:00:05 -0400 (EDT)
Message-ID: <44AF12EE.9030008@nortel.com>
Date: Fri, 07 Jul 2006 20:05:34 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: help? baffled trying to figure out where time is being spent
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi guys,

I'm looking at the following instrumented code.  This is part of an 
instrumented version of scheduler_tick(), running on what is essentially 
a "maple" board.  Dual 970fx, 4GB of memory.  Modified 2.6.10.

Shortly after initial boot, on cpu1, it seems like somehow there is a 
huge time gap between where "c" gets assigned and where "d" gets 
assigned in the code below.

The time gap between "c" and "d" is about 4.2 seconds.
The time gap between "aj" and "bj" is about 6.17 seconds.

The next time through the loop, the printk() triggers with a complaint 
that it took 6381 ticks between scheduler_tick() calls.

I'm baffled as to where the gap is coming from.  Any ideas?

Interrupts are for certain disabled while this code runs.  The printk 
statement is not being reached, so the "sched_delta" check is failing.

The gethrtime() function simply reads the tbr on ppc64, so it maps to a 
single instruction.



b=gethrtime();
	sched_delta = schedtime - __get_cpu_var(last_sched_tick);
c=gethrtime();
aj=jiffies;
	if (sched_delta > SCHED_INTERVAL_THRESH) {
		/* disable exception history if specified */
		if (disable_hist_on_event)
			disable_history_buffer = 1;
		printk(KERN_WARNING "cpu%d: jiffies: %lu, hrtime: %llu, %lu ticks 
between scheduler_tick() calls\n",
			smp_processor_id(), schedtime, (unsigned long long) gethrtime(), 
sched_delta);
	}
d=gethrtime();
bj=jiffies;



Chris
