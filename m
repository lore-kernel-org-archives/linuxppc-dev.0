Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBE721A0313
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 03:12:38 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 2 Feb 2015 21:42:35 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 116241258060
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 21:43:34 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t12GCPY154460536
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Feb 2015 21:42:26 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t12GCOim001487
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Feb 2015 21:42:25 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/mm: Add trace point for tracking hash pte fault
In-Reply-To: <1422425467.11009.2.camel@ellerman.id.au>
References: <1421753750-17135-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1421809627.4900.1.camel@ellerman.id.au> <87d268v7xm.fsf@linux.vnet.ibm.com>
 <1422425467.11009.2.camel@ellerman.id.au>
Date: Mon, 02 Feb 2015 21:42:21 +0530
Message-ID: <87y4og70nu.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Wed, 2015-01-21 at 14:15 +0530, Aneesh Kumar K.V wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>> 
>> > On Tue, 2015-01-20 at 17:05 +0530, Aneesh Kumar K.V wrote:
>> >> This enables us to understand how many hash fault we are taking
>> >> when running benchmarks.
>> >> 
>> >> For ex:
>> >> -bash-4.2# ./perf stat -e  powerpc:hash_fault -e page-faults /tmp/ebizzy.ppc64 -S 30  -P -n 1000
>> >> ...
>> >> 
>> >>  Performance counter stats for '/tmp/ebizzy.ppc64 -S 30 -P -n 1000':
>> >> 
>> >>        1,10,04,075      powerpc:hash_fault
>> >>        1,10,03,429      page-faults
>> >> 
>> >>       30.865978991 seconds time elapsed
>> >
>> > Looks good.
>> >
>> > Can you attach some test results that show it's not hurting performance when
>> > it's disabled.
>> 
>> ebizzy with -S 30 -t 1 -P gave
>> 13627 records/s -> Without patch
>> 13546 records/s -> With patch with tracepoint disabled
>
> OK. So that's about -0.6%. Are we happy with that? I'm not sure.
>
> Can you do a few more runs and see if that's a stable result.

That is within the run variance for that test. Infact I found it
difficult to get a stable records/s with ebizzy run, even after fixing
the random state variable and forcing single thread. I ended up doing
a micro benchmark that allocate a large region and touch one byte per
page.

That resulted in
time perf stat -e page-faults -e powerpc:hash_fault  ./a.out

 Performance counter stats for './a.out':

         10,00,062      page-faults                                                 
         10,00,068      powerpc:hash_fault                                          

      12.414350121 seconds time elapsed


real    0m12.558s
user    0m0.577s
sys     0m11.932s

and with that test we have an average system time for 10 run
Without patch
sys: 0m11.2425

With patch:
sys: 0m11.3258

ie, a -0.7% impact 

If that impact is high we could possibly put that tracepoint within #ifdef
CONFIG_DEBUG_VM ?

-aneesh
