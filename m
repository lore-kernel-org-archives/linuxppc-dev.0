Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5FBFDDF0B
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 14:53:30 +1000 (EST)
Date: Sat, 28 Jun 2008 13:50:42 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: monstr@seznam.cz
Subject: Re: [PATCH 25/60] microblaze_v4: process and init task function
Message-ID: <20080628045042.GF25492@linux-sh.org>
References: <1214483429-32360-17-git-send-email-monstr@seznam.cz>
	<1214483429-32360-18-git-send-email-monstr@seznam.cz>
	<1214483429-32360-19-git-send-email-monstr@seznam.cz>
	<1214483429-32360-20-git-send-email-monstr@seznam.cz>
	<1214483429-32360-21-git-send-email-monstr@seznam.cz>
	<1214483429-32360-22-git-send-email-monstr@seznam.cz>
	<1214483429-32360-23-git-send-email-monstr@seznam.cz>
	<1214483429-32360-24-git-send-email-monstr@seznam.cz>
	<1214483429-32360-25-git-send-email-monstr@seznam.cz>
	<1214483429-32360-26-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1214483429-32360-26-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 02:29:54PM +0200, monstr@seznam.cz wrote:
> +void (*pm_power_off)(void) = NULL;
> +EXPORT_SYMBOL(pm_power_off);
> +
> +void cpu_idle(void)
> +{
> +	set_thread_flag(TIF_POLLING_NRFLAG);
> +
> +	while (1) {
> +		while (!need_resched())
> +			cpu_relax();
> +
> +		preempt_enable_no_resched();
> +		schedule();
> +		preempt_disable();
> +	}
> +}
> +
A couple things to note here. You have a pm_power_off, but no pm_idle.

You set TIF_POLLING_NRFLAG but don't have any explicit clearing and
resetting of it if the CPU is sleeping. In the cpu_relax() case this is
ok, but if you have a cpu_sleep() you will want to use in the SMP case,
you will need to handle it explicitly.

Beyond that, you may also want to stub in the
tick_nohz_stop_sched_tick()/tick_nohz_restart_sched_tick() calls, then
when you implement the generic clockevents you will already have the
tickless bits in place.

check_pgt_cache() is also helpful here for quicklist trimming, though you
may not care if you never plan to have an MMU.

You can look at arch/sh/kernel/process_32.c for examples.
