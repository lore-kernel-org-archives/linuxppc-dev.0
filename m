Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F5021A0066
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 13:37:20 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 66C46140310
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 13:37:19 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 28 Jul 2015 09:07:16 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 0C551E004C
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 09:11:20 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6S3bBWV39911608
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 09:07:12 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6S3bAoJ019786
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 09:07:11 +0530
Message-ID: <55B6F8E4.2050007@linux.vnet.ibm.com>
Date: Tue, 28 Jul 2015 09:07:08 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net
Subject: Re: [3/5] powerpc/perf: Replace last usage of get_cpu_var with
 this_cpu_ptr
References: <20150727051530.325AE1402C6@ozlabs.org>
In-Reply-To: <20150727051530.325AE1402C6@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/27/2015 10:45 AM, Michael Ellerman wrote:
> On Tue, 2015-30-06 at 08:20:29 UTC, Anshuman Khandual wrote:
>> > The commit 69111bac42f5ce ("powerpc: Replace __get_cpu_var uses")
>> > replaced all usage of get_cpu_var with this_cpu_ptr inside core
>> > perf event handling on powerpc. But it skipped one of them which
>> > is being replaced with this patch.
> No it replaced all uses of __get_cpu_var(), not get_cpu_var(). The difference
> is important.

Hmm, I see. Was not aware about it. Daniel suggested on this and I
thought it made sense. Hence proposed the change.

> 
> get_cpu_var() disables preemption for you, so it's only safe to switch to
> this_cpu_ptr() if preemption is already disabled. Is it?

We dont disable preemption inside power_pmu_event_init neither inside
perf_try_init_event where it gets called from, I guess the answer is NO.
Will drop this patch next time around.
