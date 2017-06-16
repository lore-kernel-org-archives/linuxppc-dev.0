Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpnJC23BnzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 14:21:47 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5G4JEcp008499
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 00:21:44 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b42v3abmr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 00:21:44 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Fri, 16 Jun 2017 00:21:43 -0400
Subject: Re: [PATCH v2] perf: libdw support for powerpc [ping]
To: Mark Wielaard <mark@klomp.org>, Milian Wolff <milian.wolff@kdab.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1496312681-20133-1-git-send-email-pbonzini@redhat.com>
 <1497354282.3755.201.camel@klomp.org> <59400ADD.4090709@linux.vnet.ibm.com>
 <3621613.kMnvz8Tm3d@milian-kdab2> <1497525392.3755.307.camel@klomp.org>
Cc: linux-kernel@vger.kernel.org, acme@kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Jun 2017 09:51:23 +0530
MIME-Version: 1.0
In-Reply-To: <1497525392.3755.307.camel@klomp.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <59435CC3.9080007@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Works like a charm with Milian's patch.

Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Note:
I still see very minor differences between libunwind and libdw. Also, second last
function gets repeated two times in every callchain but it can be fixed later on.
Otherwise all looks good!

Thanks,
-Ravi

On Thursday 15 June 2017 04:46 PM, Mark Wielaard wrote:
> On Thu, 2017-06-15 at 10:46 +0200, Milian Wolff wrote:
>> Just a quick question: Have you guys applied my recent patch:
>>
>> commit 5ea0416f51cc93436bbe497c62ab49fd9cb245b6
>> Author: Milian Wolff <milian.wolff@kdab.com>
>> Date:   Thu Jun 1 23:00:21 2017 +0200
>>
>>     perf report: Include partial stacks unwound with libdw
>>     
>>     So far the whole stack was thrown away when any error occurred before
>>     the maximum stack depth was unwound. This is actually a very common
>>     scenario though. The stacks that got unwound so far are still
>>     interesting. This removes a large chunk of differences when comparing
>>     perf script output for libunwind and libdw perf unwinding.
>>
>> If not, then this could explain the issue you are seeing.
> Thanks! No, I didn't have that patch (*) yet. It makes a huge
> difference. With that, Paolo's patch and the elfutils libdw powerpc64
> fallback unwinder patch, it looks like I get user stack traces for
> everything now on ppc64le.
>
> Cheers,
>
> Mark
>
> (*) It just this one-liner, but what a difference that makes:
>
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -224,7 +224,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
>  
>         err = dwfl_getthread_frames(ui->dwfl, thread->tid, frame_callback, ui);
>  
> -       if (err && !ui->max_stack)
> +       if (err && ui->max_stack != max_stack)
>                 err = 0;
>  
>         /*
>
