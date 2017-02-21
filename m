Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS8RG5jQXzDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 16:38:02 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L5Tkig129101
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:38:00 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r3ph98gm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:38:00 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 22:37:59 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 21 Feb 2017 11:10:38 +0530
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: fweisbec@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id,
 linux-kernel@vger.kernel.org, fbarrat@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, Linuxppc-dev
 <linuxppc-dev-bounces+abdhalee=linux.vnet.ibm.com@lists.ozlabs.org>, abdul
 <abdhalee@linux.vnet.ibm.com>
Subject: Re: next-20170220 failed to build on PowerPC
In-Reply-To: <ff521942-bf47-f9f7-4b43-4585c5d4c667@linux.vnet.ibm.com>
References: <ff521942-bf47-f9f7-4b43-4585c5d4c667@linux.vnet.ibm.com>
Message-Id: <8c472341719fe124b96de0f7cbfd1961@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017-02-20 16:25, abdul wrote:
> Hi,
> 
> next-20170220 fails to build on Power 8 (PowerVM LPAR) with these 
> errors.
> 
> with same config, next-20170215 builds fine.
> 
> the config file used is attached, by default
> CONFIG_VIRT_CPU_ACCOUNTING_NATIVE was not set.
> 
> (X) Simple tick based cputime accounting
> ( ) Deterministic task and CPU time accounting
> ( ) Full dynticks CPU time accounting
> 
> arch/powerpc/kernel/time.c: In function ‘running_clock’:
> arch/powerpc/kernel/time.c:712:25: error: implicit declaration of
> function ‘cputime_to_nsecs’
> [-Werror=implicit-function-declaration]
>    return local_clock() -
> cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);
> 		  ^
> cc1: all warnings being treated as errors
> make[1]: *** [arch/powerpc/kernel/time.o] Error 1
> make[1]: *** Waiting for unfinished jobs....,
> 
> Note*: Problem is not seen when CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is 
> enabled i.e
> 
> ( ) Simple tick based cputime accounting
> (X) Deterministic task and CPU time accounting
> ( ) Full dynticks CPU time accounting
> 

Bisecting resulted in below commit causing the build break.

commit f22d6df0b23e66b6d9058e2570402606a6ad069a
Author: Frederic Weisbecker <fweisbec@gmail.com>
Date:   Tue Jan 31 04:09:43 2017 +0100

     sched/cputime: Remove jiffies based cputime

     This cputime_t implementation is now unused, we can remove it.

     Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
     Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
     Cc: Fenghua Yu <fenghua.yu@intel.com>
     Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
     Cc: Linus Torvalds <torvalds@linux-foundation.org>
     Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
     Cc: Michael Ellerman <mpe@ellerman.id.au>
     Cc: Paul Mackerras <paulus@samba.org>
     Cc: Peter Zijlstra <peterz@infradead.org>
     Cc: Rik van Riel <riel@redhat.com>
     Cc: Stanislaw Gruszka <sgruszka@redhat.com>
     Cc: Thomas Gleixner <tglx@linutronix.de>
     Cc: Tony Luck <tony.luck@intel.com>
     Cc: Wanpeng Li <wanpeng.li@hotmail.com>
     Link: 
http://lkml.kernel.org/r/1485832191-26889-28-git-send-email-fweisbec@gmail.com
     Signed-off-by: Ingo Molnar <mingo@kernel.org>


Regard's
Abdul Haleem
IBM Linux Technology Center.
