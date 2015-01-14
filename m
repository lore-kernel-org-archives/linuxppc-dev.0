Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1B9D1A0C74
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 22:03:13 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 14 Jan 2015 16:33:10 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C72A31258056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 16:33:53 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0EB33UT19857560
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 16:33:04 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0EB30n2005496
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 16:33:01 +0530
Message-ID: <54B64CE4.6050806@linux.vnet.ibm.com>
Date: Wed, 14 Jan 2015 16:33:00 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: offlining cpus breakage
References: <54ACFE6D.3070308@ozlabs.ru>
In-Reply-To: <54ACFE6D.3070308@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 07 January 2015 03:07 PM, Alexey Kardashevskiy wrote:
> Hi!
> 
> "ppc64_cpu --smt=off" produces multiple error on the latest upstream kernel
> (sha1 bdec419):
> 
> NMI watchdog: BUG: soft lockup - CPU#20 stuck for 23s! [swapper/20:0]
> 
> or
> 
> INFO: rcu_sched detected stalls on CPUs/tasks: { 2 7 8 9 10 11 12 13 14 15
> 16 17 18 19 20 21 22 23 2
> 4 25 26 27 28 29 30 31} (detected by 6, t=2102 jiffies, g=1617, c=1616,
> q=1441)
> 
> and many others, all about lockups
> 
> I did bisecting and found out that reverting these helps:
> 
> 77b54e9f213f76a23736940cf94bcd765fc00f40 powernv/powerpc: Add winkle
> support for offline cpus
> 7cba160ad789a3ad7e68b92bf20eaad6ed171f80 powernv/cpuidle: Redesign idle
> states management
> 8eb8ac89a364305d05ad16be983b7890eb462cc3 powerpc/powernv: Enable Offline
> CPUs to enter deep idle states
> 
> btw reverting just two of them produces a compile error.
> 
> It is pseries_le_defconfig, POWER8 machine:
> timebase        : 512000000
> platform        : PowerNV
> model           : palmetto
> machine         : PowerNV palmetto
> firmware        : OPAL v3
> 
> 

The bug scenario is as follows:

In fastsleep decrementer state is not maintained, thus a cpu entering
fastsleep offloads its timer to a different cpu (lets call this
broadcast cpu). Now in the event that this broadcast cpu is offlined, it
assigns a new cpu with the task to handle broadcasting.

If this new cpu is one of the cpus which had entered fastsleep, its
decrementer will have been in an invalid state. This cpu has been woken
up by a need resched ipi (to take up the task of broadcasting) as
opposed to a broadcast ipi. The decrementer state is fixed only on a
broadcast ipi and not on a need resched ipi. Because of this, its timers
don't fire. Consequently it cannot wake up any cpu relying on broadcast ipi.

This scenario of a cpu that takes up the task of broadcasting being in
fastsleep is a corner case. This almost never happens on machines with
more number of cores. This explains why Alexey was able to hit it easily
on palmetto.

We'll be posting out a fix for this soon.

Thanks,
Shreyas
