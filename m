Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 87578DDE1B
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 10:29:20 +1000 (EST)
Message-ID: <4A04CE4A.9080709@nortel.com>
Date: Fri, 08 May 2009 18:28:58 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: question about softirqs
References: <4A04B76D.20106@nortel.com>
	<18948.49541.735156.176919@cargo.ozlabs.ibm.com>
In-Reply-To: <18948.49541.735156.176919@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:

> If a soft irq is raised in process context, raise_softirq() in
> kernel/softirq.c calls wakeup_softirqd() to make sure that ksoftirqd
> runs soon to process the soft irq.  So what would happen is that we
> would see the TIF_RESCHED_PENDING flag on the current task in the
> syscall exit path and call schedule() which would switch to ksoftirqd
> to process the soft irq (if it hasn't already been processed by that
> stage).

I think I see a problem with this.  Suppose I have a SCHED_FIFO task 
spinning on recvmsg() with MSG_DONTWAIT set (and maybe doing other stuff 
if there are no messages).  Under the scenario you described, schedule() 
would re-run the spinning task, no?  This could prevent any incoming 
packets from actually being sent up the stack until we get a real 
hardware interrupt--which could be a whole jiffy if interrupt mitigation 
is enabled in the net device.

Chris
