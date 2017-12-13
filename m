Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxYQW0xm1zDrcw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 21:51:15 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id z5so771603plo.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 02:51:14 -0800 (PST)
Date: Wed, 13 Dec 2017 20:51:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 2/2] powernv/kdump: Fix cases where the kdump kernel
 can get HMI's
Message-ID: <20171213205101.2cc0c830@roar.ozlabs.ibm.com>
In-Reply-To: <20171213080828.2800-2-bsingharora@gmail.com>
References: <20171213080828.2800-1-bsingharora@gmail.com>
 <20171213080828.2800-2-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is looking pretty nice now...

On Wed, 13 Dec 2017 19:08:28 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> @@ -543,7 +543,25 @@ void smp_send_debugger_break(void)
>  #ifdef CONFIG_KEXEC_CORE
>  void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
>  {
> +	int cpu;
> +
>  	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, crash_ipi_callback, 1000000);
> +	if (kdump_in_progress() && crash_wake_offline) {
> +		for_each_present_cpu(cpu) {
> +			if (cpu_online(cpu))
> +				continue;
> +			/*
> +			 * crash_ipi_callback will wait for
> +			 * all cpus, including offline CPUs.
> +			 * We don't care about nmi_ipi_function.
> +			 * Offline cpus will jump straight into
> +			 * crash_ipi_callback, we can skip the
> +			 * entire NMI dance and waiting for
> +			 * cpus to clear pending mask, etc.
> +			 */
> +			do_smp_send_nmi_ipi(cpu);

Still a little bit concerned about using NMI IPI for this.

If you take an NMI IPI from stop, the idle code should do the
right thing and we would just return the system reset wakeup
reason in SRR1 here (which does not need to be cleared).

If you take the system reset anywhere else in the loop, it's
going to go out via system_reset_exception. I guess that
would end up doing the right thing, it probably gets to
crash_ipi_callback from crash_kexec_secondary?

It's just going to be a very untested code path :( What we
gain I suppose is better ability to handle a CPU that's locked
up somewhere in the cpu offline path. Assuming the uncommon
case works...

Actually, if you *always* go via the system reset exception
handler, then code paths will be shared. That might be the
way to go. So I would check for system reset wakeup SRR1 reason
and call replay_system_reset() for it. What do you think?

Thanks,
Nick
