Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9246467C01
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 03:24:04 +1100 (EST)
Date: Mon, 4 Dec 2006 17:23:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t
	in	latency_trace.c (take 3)
Message-ID: <20061204162300.GA23800@elte.hu>
References: <200611132252.58818.sshtylyov@ru.mvista.com>
	<457326A2.2020402@ru.mvista.com> <20061204095131.GE7872@elte.hu>
	<4574149B.5070602@ru.mvista.com> <20061204153949.GA9350@elte.hu>
	<45744AF5.2040508@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45744AF5.2040508@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



* Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

> > 	/* check for buggy clocks, handling wrap for 32-bit clocks */
> >-	if (TYPE_EQUAL(cycles_t, unsigned long)) {
> >+	if (TYPE_EQUAL(cycle_t, unsigned long)) {
> > 		if (time_after((unsigned long)T1, (unsigned long)T2))
> > 			printk("bug: %08lx < %08lx!\n",
> > 				(unsigned long)T2, (unsigned long)T1);
> 
>    This earlier fix by Kevin woulnd't have sense anymore with cycle_t...

yeah, indeed - i've zapped this one too.

basically, what i'd like is the 32-bit clocks/cycles be handled 
intelligently, and not adding to the cruft that already is in 
kernel/latency_tracing.c.

	Ingo
