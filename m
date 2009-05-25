Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB791DDFD5
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 22:33:00 +1000 (EST)
Date: Mon, 25 May 2009 14:32:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH resend4 2/3] itimers: fix periodic tics precision
In-Reply-To: <20090525132814.442877e5@dhcp-lab-109.englab.brq.redhat.com>
Message-ID: <alpine.LFD.2.00.0905251423490.3582@localhost.localdomain>
References: <20090522154339.06d30f0a@dhcp-lab-109.englab.brq.redhat.com>
	<alpine.LFD.2.00.0905221611380.3570@localhost.localdomain>
	<20090525132814.442877e5@dhcp-lab-109.englab.brq.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 25 May 2009, Stanislaw Gruszka wrote:
> @@ -904,6 +905,7 @@ void __init time_init(void)
>  	tb_ticks_per_usec = ppc_tb_freq / 1000000;
>  	tb_to_us = mulhwu_scale_factor(ppc_tb_freq, 1000000);
>  	calc_cputime_factors();
> +	cputime_one = jiffies_to_cputime(1);

  1) The variable name is misleading.

  2) The patch breaks all powerpc platforms which have
  CONFIG_VIRT_CPU_ACCOUNTING=n and ia64 with
  CONFIG_VIRT_CPU_ACCOUNTING=y

Thanks,

	tglx
