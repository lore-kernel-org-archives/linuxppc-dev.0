Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3VDw4ztDzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 15:47:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Sebastian Siewior <bigeasy@linutronix.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "David S. Miller" <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 05/13] powerpc/smp: Replace open coded task affinity logic
In-Reply-To: <20170412201042.518053336@linutronix.de>
References: <20170412200726.941336635@linutronix.de>
 <20170412201042.518053336@linutronix.de>
Date: Thu, 13 Apr 2017 15:47:44 +1000
Message-ID: <87fuhcamf3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Gleixner <tglx@linutronix.de> writes:

> Init task invokes smp_ops->setup_cpu() from smp_cpus_done(). Init task can
> run on any online CPU at this point, but the setup_cpu() callback requires
> to be invoked on the boot CPU. This is achieved by temporarily setting the
> affinity of the calling user space thread to the requested CPU and reset it
> to the original affinity afterwards.
>
> That's racy vs. CPU hotplug and concurrent affinity settings for that
> thread resulting in code executing on the wrong CPU and overwriting the
> new affinity setting.
>
> That's actually not a problem in this context as neither CPU hotplug nor
> affinity settings can happen, but the access to task_struct::cpus_allowed
> is about to restricted.
>
> Replace it with a call to work_on_cpu_safe() which achieves the same result.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/smp.c |   26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
