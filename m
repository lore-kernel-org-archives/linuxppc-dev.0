Return-Path: <sgruszka@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id B2F58DE100
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 22:58:27 +1000 (EST)
Date: Mon, 25 May 2009 14:51:32 +0200
From: Stanislaw Gruszka <sgruszka@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH resend4 2/3] itimers: fix periodic tics precision
Message-ID: <20090525145132.03915e19@dhcp-lab-109.englab.brq.redhat.com>
In-Reply-To: <alpine.LFD.2.00.0905251423490.3582@localhost.localdomain>
References: <20090522154339.06d30f0a@dhcp-lab-109.englab.brq.redhat.com>
	<alpine.LFD.2.00.0905221611380.3570@localhost.localdomain>
	<20090525132814.442877e5@dhcp-lab-109.englab.brq.redhat.com>
	<alpine.LFD.2.00.0905251423490.3582@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Ingo, Peter Zijlstra <a.p.zijlstra@chello.nl>, linuxppc-dev@ozlabs.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nesterov <oleg@redhat.com>, Oleg, Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 25 May 2009 14:32:14 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 25 May 2009, Stanislaw Gruszka wrote:
> > @@ -904,6 +905,7 @@ void __init time_init(void)
> >  	tb_ticks_per_usec = ppc_tb_freq / 1000000;
> >  	tb_to_us = mulhwu_scale_factor(ppc_tb_freq, 1000000);
> >  	calc_cputime_factors();
> > +	cputime_one = jiffies_to_cputime(1);
> 
>   1) The variable name is misleading.

What about cputime_one_jiffy ?

>   2) The patch breaks all powerpc platforms which have
>   CONFIG_VIRT_CPU_ACCOUNTING=n and ia64 with
>   CONFIG_VIRT_CPU_ACCOUNTING=y

Stupid me, in asm-generic/cputime.h should be 
#define cputime_one jiffies_to_cputime(1)

Thanks
Stanislaw
