Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zG4060bftzF0dn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 18:44:05 +1100 (AEDT)
Message-ID: <1515483825.541.40.camel@kernel.crashing.org>
Subject: Re: Sleep in preempt_disable on powernv with 'cat /proc/cpuinfo' on
 v4.15
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Sperbeck <jsperbeck@google.com>, Shriya <shriyak@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 09 Jan 2018 18:43:45 +1100
In-Reply-To: <CAFNjLiW4Dc9J_Q6L0zOT1f+AyNYOLWFPk1iXb7JNTPaqpozkCQ@mail.gmail.com>
References: <CAFNjLiW4Dc9J_Q6L0zOT1f+AyNYOLWFPk1iXb7JNTPaqpozkCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-01-08 at 21:30 -0800, John Sperbeck wrote:
> The pnv_get_proc_freq() function was recently changed to call
> cpufreq_get(), instead of cpufreq_quick_get(), in order to fetch
> a more up-to-date value for the CPU frequency:
> 
>    cd77b5ce208c153260ed7882d8910f2395bfaabd
>    powerpc/powernv/cpufreq: Fix the frequency read by /proc/cpuinfo
> 
> Unfortunately, this function is called from show_cpuinfo() in
> arch/powerpc/kernel/setup-common.c with preemption disabled.  The
> cpufreq_get() function might do a down_read(), which can sleep.
> 
> With CONFIG_DEBUG_KERNEL and CONFIG_DEBUG_ATOMIC_SLEEP set, a warning
> like the following is generated when running 'cat /proc/cpuinfo':

We could just either remove the preempt_disable completely like
x86 and keep it racy, or stick a cpus_read_lock around it. I dont think
we need that preempt_disable, it's definitely overkill.

Michael, what do you think ? I'm keen on sync'ing with x86 here...

Cheers,
Ben.

>     BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:23
>     in_atomic(): 1, irqs_disabled(): 0, pid: 16939, name: cat
>     CPU: 33 PID: 16939 Comm: cat Tainted: G        W        4.15.0-smp-DEV #1
>     Call Trace:
>     [c000000fef07bab0] [c000000000a32c30] dump_stack+0xb0/0xf0 (unreliable)
>     [c000000fef07baf0] [c0000000001343a8] ___might_sleep+0x178/0x1b0
>     [c000000fef07bb70] [c000000000a50f58] down_read+0x38/0x90
>     [c000000fef07bba0] [c0000000008287d0] cpufreq_get+0x50/0xc0
>     [c000000fef07bbf0] [c000000000097a08] pnv_get_proc_freq+0x28/0x60
>     [c000000fef07bc20] [c00000000002c554] show_cpuinfo+0x194/0x450
>     [c000000fef07bcb0] [c00000000039c848] seq_read+0x1f8/0x590
>     [c000000fef07bd40] [c00000000040d1d4] proc_reg_read+0xb4/0x180
>     [c000000fef07bd90] [c00000000035d6a0] vfs_read+0x100/0x220
>     [c000000fef07bde0] [c00000000035dc6c] SyS_read+0x6c/0x110
>     [c000000fef07be30] [c00000000000b220] system_call+0x58/0x6c
> 
