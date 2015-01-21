Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3DCC1A0D95
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 19:45:37 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 21 Jan 2015 14:15:34 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 942CDE0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 14:16:45 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0L8jUS7655826
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 14:15:30 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0L8jTuM015178
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 14:15:30 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Add trace point for tracking hash pte fault
In-Reply-To: <1421809627.4900.1.camel@ellerman.id.au>
References: <1421753750-17135-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1421809627.4900.1.camel@ellerman.id.au>
Date: Wed, 21 Jan 2015 14:15:09 +0530
Message-ID: <87d268v7xm.fsf@linux.vnet.ibm.com>
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

> On Tue, 2015-01-20 at 17:05 +0530, Aneesh Kumar K.V wrote:
>> This enables us to understand how many hash fault we are taking
>> when running benchmarks.
>> 
>> For ex:
>> -bash-4.2# ./perf stat -e  powerpc:hash_fault -e page-faults /tmp/ebizzy.ppc64 -S 30  -P -n 1000
>> ...
>> 
>>  Performance counter stats for '/tmp/ebizzy.ppc64 -S 30 -P -n 1000':
>> 
>>        1,10,04,075      powerpc:hash_fault
>>        1,10,03,429      page-faults
>> 
>>       30.865978991 seconds time elapsed
>
> Looks good.
>
> Can you attach some test results that show it's not hurting performance when
> it's disabled.
>

ebizzy with -S 30 -t 1 -P gave
13627 records/s -> Without patch
13546 records/s -> With patch with tracepoint disabled
12408 records/s -> With patch with tracepoint enabled.

perf stat gave the below data for the above run.

 22,38,284      page-faults                                                 
 22,38,291      powerpc:hash_fault

I also used random_access_bench that Anton wrote, it actually
create lots of hash fault. A simple run gives.
(random_access_bench -o load -g -i -t 10 16G)

1,888      page-faults                                                 
2,64,283   powerpc:hash_fault                                          

random_access_bench gave:
1435.979 MB/s -> Without patch
1435.29  MB/s -> With patch with tracepoint disabled
1434.75  MB/s -> With patch with tracepoint enabled.

-aneesh
