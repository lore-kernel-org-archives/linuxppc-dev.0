Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 46F42DDF9E
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 09:34:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18948.49541.735156.176919@cargo.ozlabs.ibm.com>
Date: Sat, 9 May 2009 09:34:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: question about softirqs
In-Reply-To: <4A04B76D.20106@nortel.com>
References: <4A04B76D.20106@nortel.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Friesen writes:

> I'm trying to figure out where exactly softirqs are called on return 
> from a syscall in 64-bit powerpc.  I can see where they get called for a 
> normal interrupt via the irq_exit() path, but not for syscalls.

If a soft irq is raised in process context, raise_softirq() in
kernel/softirq.c calls wakeup_softirqd() to make sure that ksoftirqd
runs soon to process the soft irq.  So what would happen is that we
would see the TIF_RESCHED_PENDING flag on the current task in the
syscall exit path and call schedule() which would switch to ksoftirqd
to process the soft irq (if it hasn't already been processed by that
stage).

If the soft irq is raised in interrupt context, then the soft irq gets
run via the do_softirq() call in irq_exit(), as you saw.

The soft irq stuff is pretty much all generic code these days, except
for the code to switch to the softirq stack.

Paul.
