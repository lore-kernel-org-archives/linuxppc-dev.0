Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (mta23.gyao.ne.jp [125.63.38.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9E3C5DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 15:06:29 +1000 (EST)
Date: Sat, 28 Jun 2008 14:03:45 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: monstr@seznam.cz
Subject: Re: [PATCH 29/60] microblaze_v4: traps support
Message-ID: <20080628050345.GH25492@linux-sh.org>
References: <1214483429-32360-21-git-send-email-monstr@seznam.cz>
	<1214483429-32360-22-git-send-email-monstr@seznam.cz>
	<1214483429-32360-23-git-send-email-monstr@seznam.cz>
	<1214483429-32360-24-git-send-email-monstr@seznam.cz>
	<1214483429-32360-25-git-send-email-monstr@seznam.cz>
	<1214483429-32360-26-git-send-email-monstr@seznam.cz>
	<1214483429-32360-27-git-send-email-monstr@seznam.cz>
	<1214483429-32360-28-git-send-email-monstr@seznam.cz>
	<1214483429-32360-29-git-send-email-monstr@seznam.cz>
	<1214483429-32360-30-git-send-email-monstr@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1214483429-32360-30-git-send-email-monstr@seznam.cz>
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

On Thu, Jun 26, 2008 at 02:29:58PM +0200, monstr@seznam.cz wrote:
> +static int kstack_depth_to_print = 24;
> +
x86 has a sysctl for this. It may be worth making this non-static and
generalizing the ifdef case. Plenty of other architectures could benefit
from this also.

> +void show_trace(struct task_struct *task, unsigned long *stack)
> +{
> +	unsigned long addr;
> +
> +	if (!stack)
> +		stack = (unsigned long *)&stack;
> +
> +	printk(KERN_INFO "Call Trace: ");
> +#ifdef CONFIG_KALLSYMS
> +	printk(KERN_INFO "\n");
> +#endif
> +	while (!kstack_end(stack)) {
> +		addr = *stack++;
> +		if (__kernel_text_address(addr)) {
> +			printk(KERN_INFO "[<%08lx>] ", addr);
> +			print_symbol("%s\n", addr);

Use print_ip_sym() here for future-proofing.

> +		}
> +	}
> +	printk(KERN_INFO "\n");

And here you can:

	if (!tsk)
		tsk = current;
	
	debug_show_held_locks(tsk);
> +}
> +

for when you get around to implementing lockdep.
