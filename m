Return-Path: <fche@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id DFA54B70CB
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 07:46:29 +1100 (EST)
To: divya <dipraksh@linux.vnet.ibm.com>
Subject: Re: Oops while running systemtap on the p6 machine against the kernel
	version 2.6.36-rc7-git3
References: <4CB704AC.4070203@linux.vnet.ibm.com>
From: fche@redhat.com (Frank Ch. Eigler)
Date: Thu, 14 Oct 2010 16:46:25 -0400
In-Reply-To: <4CB704AC.4070203@linux.vnet.ibm.com>
	(dipraksh@linux.vnet.ibm.com's message of "Thu,
	14 Oct 2010 18:55:00 +0530")
Message-ID: <y0mmxqgec4e.fsf@fche.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, systemtap@sources.redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


divya <dipraksh@linux.vnet.ibm.com> writes:

> While running systemtap tests on the p6 machine , against the kernel
> version 2.6.36-rc7-git3 Oops occured , here are the call trace

Did the oops happen during a systemtap module startup vs. operation
vs. shutdown?  stap -V version string?

>  BUG: spinlock bad magic on CPU#6, stapio/20398
> -- 0:conmux-control -- time-stamp -- Oct/13/10  2:49:18 --res
>  lock: c000000000fcfa18, .magic: 00000000, .owner:<none>/-1, .owner_cpu: 0
> Call Trace:
> [c0000001effbfab0] [c000000000011934] .show_stack+0x6c/0x16c (unreliable)
> [c0000001effbfb60] [c0000000002c9274] .spin_bug+0xb0/0xd4
> [c0000001effbfbf0] [c0000000002c953c] .do_raw_spin_lock+0x48/0x184
> [c0000001effbfc90] [c00000000054af78] ._raw_spin_lock+0x10/0x24
> [c0000001effbfd00] [d000000003015908] .__stp_time_timer_callback+0x94/0x13c [stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798]
> [...]
> kernel BUG at kernel/timer.c:681!
> Oops: Exception in kernel mode, sig: 5 [#1]
> SMP NR_CPUS=1024 NUMA pSeries
> [...]
> [c0000001effbfc50] [c0000001effbfd00] 0xc0000001effbfd00 (unreliable)
> [c0000001effbfd00] [d00000000301597c] .__stp_time_timer_callback+0x108/0x13c [stap_75ce6f84d34f8665c9a6b8e27fb9ea95_818798]
> [c0000001effbfdc0] [c00000000009c2f8] .run_timer_softirq+0x1d8/0x2a8


We have had occasional problems in the past with something like this:
http://sourceware.org/PR10651, but it never was tracked down to a
systemtap bug per se, as opposed to suspicions that the kernel was not
satisfying one of its guarantees w.r.t. del_timer_sync().

- FChE
