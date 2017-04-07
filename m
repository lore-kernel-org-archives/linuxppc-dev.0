Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzzb60p6TzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 22:36:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: kselftest:lost_exception_test failure with 4.11.0-rc5
In-Reply-To: <2868072E-9D12-4BE0-94F6-FE9C33A3766F@linux.vnet.ibm.com>
References: <2868072E-9D12-4BE0-94F6-FE9C33A3766F@linux.vnet.ibm.com>
Date: Fri, 07 Apr 2017 22:36:10 +1000
Message-ID: <87r314gzt1.fsf@concordia.ellerman.id.au>
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

Sachin Sant <sachinp@linux.vnet.ibm.com> writes:

> I have run into few instances where the lost_exception_test from
> powerpc kselftest fails with SIGABRT. Following o/p is against
> 4.11.0-rc5. The failure is intermittent. 

What hardware are you on?

How long does it take to run when it fails? I assume ~2 minutes?

> When the test fails it is killed due to SIGABRT.

> # ./lost_exception_test 
> test: lost_exception
> tags: git_version:unknown
> Binding to cpu 8
> main test running as pid 9208
> EBB Handler is at 0x10003dcc
> !! killing lost_exception

This is the parent (test harness saying) it's about to kill the child,
because it took too long.

It sends SIGTERM, but the child catches that, prints all this info, and
then aborts() - so that's why you're seeing SIGABRT.

> ebb_state):
>   ebb_count    = 191529

The test usually runs until it's taken 1,000,000 EBBs, so it looks like
we got stuck.

>   spurious     = 0
>   negative     = 0
>   no_overflow  = 0
>   pmc[1] count = 0x0
>   pmc[2] count = 0x0
>   pmc[3] count = 0x0
>   pmc[4] count = 0x4c1b707

We use a varying sample period of between 400 and 600, and from above
we've taken 191,529 EBBs.

0x4c1b707 / 191,529 ~= 416

So that looks reasonable.

>   pmc[5] count = 0x0
>   pmc[6] count = 0x0
> HW state:
> MMCR0 0x0000000080000080 FC PMAO 

But this says we're stopped with counters frozen and an event pending.

> MMCR2 0x0000000000000000
> EBBHR 0x0000000010003dcc
> BESCR 0x8000000100000000 GE PMAE 

And that says we have global enable set and events enabled.


So I think there is a bug here somewhere. I don't really have time to
dig into it now, neither does Maddy I think. But we should try and get
to it at some point.

cheers
