Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CFC8BDDF71
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 20:16:59 +1100 (EST)
Date: Wed, 7 Mar 2007 10:16:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
Subject: Re: [RFC] [patch 4/6 -rt] powerpc 2.6.20-rt8: fix a runtime warnings
	for xmon
Message-ID: <20070307091638.GC1783@elte.hu>
References: <yyi8xe925vg.wl@toshiba.co.jp> <yyi3b4h25jj.wl@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yyi3b4h25jj.wl@toshiba.co.jp>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Tsutomu OWA <tsutomu.owa@toshiba.co.jp> wrote:

> @@ -342,6 +342,7 @@ static int xmon_core(struct pt_regs *reg
>  
>  	msr = mfmsr();
>  	mtmsr(msr & ~MSR_EE);	/* disable interrupts */
> +	preempt_disable();

i'm not an xmon expert, but maybe it might make more sense to first 
disable preemption, then interrupts - otherwise you could be preempted 
right after having disabled these interrupts (and be scheduled to 
another CPU, etc.). What is the difference between local_irq_save() and 
the above 'disable interrupts' sequence? If it's not the same and 
xmon_core() relied on having hardirqs disabled then it might make sense 
to do a local_irq_save() there, instead of a preempt_disable().

	Ingo
