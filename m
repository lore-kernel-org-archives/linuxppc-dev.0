Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8A121A0729
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 13:08:31 +1000 (AEST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CD38A140D30
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 13:08:30 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 28 Jul 2015 08:38:28 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 67193E0058
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 08:42:31 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6S38NXm35258440
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 08:38:23 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6S1l18u031562
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 07:17:02 +0530
Message-ID: <55B6F225.4070902@linux.vnet.ibm.com>
Date: Tue, 28 Jul 2015 08:38:21 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net
Subject: Re: [1/5] powerpc/perf: Drop the branch sample when 'from' cannot
 be fetched
References: <20150727041915.63106140326@ozlabs.org>
In-Reply-To: <20150727041915.63106140326@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/27/2015 09:49 AM, Michael Ellerman wrote:
> On Tue, 2015-30-06 at 08:20:27 UTC, Anshuman Khandual wrote:
>> BHRB (Branch History Rolling Buffer) is a rolling buffer. Hence we
>> might end up in a situation where we have read one target address
>> but when we try to read the next entry indicating the from address
>> of the target address, the buffer just overflows. In this case, the
>> captured from address will be zero which indicates the end of the
>> buffer.
> 
> Right. But with SMT8 the size of the buffer is very small, so we will actually
> hit this case somewhat often. When we originally wrote this we decided it was
> better to get some information, ie. the from address, than no information at
> all.

You are right. But practically as of now we are not using this kind of
(from, 0) branch entries any where as a special case. More over for
certain kind of workloads which has a small code and a few branches,
the chances of getting this kind of branch (from, 0) increases a lot
making them probably one of the highest percentage entries in the final
perf report. Now with this change of code, the workload session might
have overall less number of branch entries, but in my opinion represents
more accurate branch profile of the given workload in percentage wise.

> 
>> 	This patch drops the entire branch record which would have
>> otherwise confused the user space tools.
> 
> Does it confuse the tools? Can you show me before/after output from perf?

The word 'confuse' might be little misleading. But the point as
explained above that the relative branch percentage profile of
certain workloads might be distorted and that I believe is true.
Also branch entries like "from ----> 0" in the perf report might
be confusing to users who dont expect to see this kind of entries
in the final perf report and will never get into "perf report -D"
to figure out what really happened.

> 
> I'm not opposed to changing this but we need to be 100% sure it's the best
> option.
