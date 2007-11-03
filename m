Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2BD69DDE18
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 20:33:00 +1100 (EST)
Date: Sat, 3 Nov 2007 10:32:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Restore deterministic CPU accounting on powerpc
Message-ID: <20071103093240.GA22932@elte.hu>
References: <18218.44089.274628.680088@cargo.ozlabs.ibm.com>
	<20071103085420.GA14551@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071103085420.GA14551@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Ingo Molnar <mingo@elte.hu> wrote:

> * Paul Mackerras <paulus@samba.org> wrote:
> 
> > Since powerpc started using CONFIG_GENERIC_CLOCKEVENTS, the 
> > deterministic CPU accounting (CONFIG_VIRT_CPU_ACCOUNTING) has been 
> > broken on powerpc, because we end up counting user time twice: once in 
> > timer_interrupt() and once in update_process_times().
> > 
> > This fixes the problem by pulling the code in update_process_times 
> > that updates utime and stime into a separate function called 
> > account_process_tick.  If CONFIG_VIRT_CPU_ACCOUNTING is not defined, 
> > there is a version of account_process_tick in kernel/timer.c that 
> > simply accounts a whole tick to either utime or stime as before.  If 
> > CONFIG_VIRT_CPU_ACCOUNTING is defined, then arch code gets to 
> > implement account_process_tick.
> > 
> > This also lets us simplify the s390 code a bit; it means that the s390 
> > timer interrupt can now call update_process_times even when 
> > CONFIG_VIRT_CPU_ACCOUNTING is turned on, and can just implement a 
> > suitable account_process_tick().
> > 
> > Signed-off-by: Paul Mackerras <paulus@samba.org>
> 
> lets push this towards Linus via the scheduler tree, ok?

hm, i've removed it for now because it doesnt even build due toj:

+#ifndef CONFIG_VIRT_CPU_ACCOUNTING
+void account_process_tick(int user_tick)
+{
+       if (user_tick) {
+               account_user_time(p, jiffies_to_cputime(1));
+               account_user_time_scaled(p, jiffies_to_cputime(1));

	Ingo
