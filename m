Return-Path: <bookjovi@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 997362C0099
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2012 11:02:45 +1000 (EST)
Received: by padfa1 with SMTP id fa1so715685pad.15
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2012 18:02:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <28857.1345091034@neuling.org>
References: <28857.1345091034@neuling.org>
Date: Thu, 27 Sep 2012 09:02:43 +0800
Message-ID: <CACV3sbKZ1B2qOFPC7WJ7k28FbcSV-cWk=OA4f7Fy5mdLRfZEhA@mail.gmail.com>
Subject: Re: powerpc/perf: hw breakpoints return ENOSPC
From: Jovi Zhang <bookjovi@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, Namhyung Kim <namhyung@kernel.org>,
 K Prasad <prasad@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 16, 2012 at 12:23 PM, Michael Neuling <mikey@neuling.org> wrote:
> Hi,
>
> I've been trying to get hardware breakpoints with perf to work on POWER7
> but I'm getting the following:
>
>   % perf record -e mem:0x10000000 true
>
>     Error: sys_perf_event_open() syscall returned with 28 (No space left on device).  /bin/dmesg may provide additional information.
>
>     Fatal: No CONFIG_PERF_EVENTS=y kernel support configured?
>
>   true: Terminated
>
> (FWIW adding -a and it works fine)
>
> Debugging it seems that __reserve_bp_slot() is returning ENOSPC because
> it thinks there are no free breakpoint slots on this CPU.
>
> I have a 2 CPUs, so perf userspace is doing two perf_event_open syscalls
> to add a counter to each CPU [1].  The first syscall succeeds but the
> second is failing.
>
> On this second syscall, fetch_bp_busy_slots() sets slots.pinned to be 1,
> despite there being no breakpoint on this CPU.  This is because the call
> the task_bp_pinned, checks all CPUs, rather than just the current CPU.
> POWER7 only has one hardware breakpoint per CPU (ie. HBP_NUM=1), so we
> return ENOSPC.
>
> The following patch fixes this by checking the associated CPU for each
> breakpoint in task_bp_pinned.  I'm not familiar with this code, so it's
> provided as a reference to the above issue.
>
> Mikey
>
> 1. not sure why it doesn't just do one syscall and specify all CPUs, but
> that's another issue.  Using two syscalls should work.
>
This problem let me recall what I reported several months ago.

https://lkml.org/lkml/2012/6/27/631

At that time, I thought it is caused by uses_mmap field in record sub
command which
added by commit d1cb9f(perf target: Add uses_mmap field).

In that testcase, it's fine to use stat sub command, but failed with
record sub command.

As Namhyung metioned in that thread, [perf record xxx] use
per-task-per-cpu for fix
scalability issues.
