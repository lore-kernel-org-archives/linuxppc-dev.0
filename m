Return-Path: <cjashfor@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2EEDDDF54
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 08:05:41 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4DM5cDF021529
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 18:05:38 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4DM5aUW141086
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 16:05:36 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4DM5amO013834
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 16:05:36 -0600
Message-ID: <482A10AF.6040205@us.ibm.com>
Date: Tue, 13 May 2008 15:05:35 -0700
From: Corey Ashford <cjashfor@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, eranian@googlemail.com
Subject: Feedback requested on switching the exception wrapper used for the
	PMU interrupt on ppc64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

One of the things I've been working on is porting perfmon2 to ppc64. 
We've made a fair amount of progress on it, and support is available in 
libpfm and the perfmon2 kernel patch.

One of the things we had to work around was the "lazy interrupt 
disabling" mechanism in ppc64 Linux.  The problem was that the PMU 
exception handler (0xf00) uses the STD_EXCEPTION_PSERIES wrapper, which 
does not support lazy interrupt disabling.

This is desirable for Oprofile's use of the PMU since its handler is 
fairly simple and being able to profile interrupt protected code is 
desirable.  However, it causes problems for perfmon2, since the 
operations it performs on the thread of its PMU interrupt handler can 
cause a deadlock condition (it can end up calling spin_lock, for example).

Initially, to work around this, we created special spin_lock_irqsave and 
spin_unlock_irqrestore macros for perfmon2 which we could override for 
POWER to define them as functions which do hard disables and restores.

However, not all of the places that we need to disable interrupts were 
occurring from within the perfmon2 code.  Specifically, getting PMU 
interrupts in the middle of a schedule() call (where interrupts were 
expected to be disabled) was causing kernel hangs.

To fix this, I've gone back and removed the special spin_lock macros we 
defined in perfmon2 and have ifdef'd arch/powerpc/kernel/head_64.S file 
as follows:

/*** pSeries interrupt support ***/

         /* moved from 0xf00 */
+ #ifdef CONFIG_PERFMON
+         MASKABLE_EXCEPTION_PSERIES(., performance_monitor)
+ #else
         STD_EXCEPTION_PSERIES(., performance_monitor)
+ #endif

/*
  * An interrupt came in while soft-disabled; clear EE in SRR1,
  * clear paca->hard_enabled and return.

The downside of this change is that if someone is using Oprofile and 
they have enabled perfmon in their kernel, they will not get profile 
samples that occur in interrupt-protected regions of the kernel. 
However, they still can by configuring perfmon out of their kernel.

What do you think of this idea?  Is this something that you would object 
to when perfmon2 does go upstream to LKML?  I think we'd want to add 
some documentation somewhere that describes this side-effect of enabling 
perfmon in the ppc64 Linux kernel.  Do you have suggestions on where 
that should go?  I'm thinking perhaps in both the basic_profiling.txt 
and perfmon2.txt files in the Documentation subdirectory.

Thanks for your consideration,

- Corey

-- 
Corey Ashford
Software Engineer
IBM Linux Technology Center, Linux Toolchain
Beaverton, OR
503-578-3507
cjashfor@us.ibm.com
