Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84CFC1A0038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 19:04:17 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 58D96140D17
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 19:04:17 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 19:04:16 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 713382CE8054
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 19:04:14 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U941J435324134
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 19:04:10 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U93etD003202
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 19:03:41 +1000
Message-ID: <560BA55A.70309@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 14:33:22 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
CC: mikey@neuling.org, sukadev@linux.vnet.ibm.com, dja@axtens.net
Subject: Re: [1/5] powerpc/perf: Drop the branch sample when 'from' cannot
 be fetched
References: <20150727041915.63106140326@ozlabs.org>
 <55B6F225.4070902@linux.vnet.ibm.com>
In-Reply-To: <55B6F225.4070902@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/28/2015 08:38 AM, Anshuman Khandual wrote:
> On 07/27/2015 09:49 AM, Michael Ellerman wrote:
>> > On Tue, 2015-30-06 at 08:20:27 UTC, Anshuman Khandual wrote:
>>> >> BHRB (Branch History Rolling Buffer) is a rolling buffer. Hence we
>>> >> might end up in a situation where we have read one target address
>>> >> but when we try to read the next entry indicating the from address
>>> >> of the target address, the buffer just overflows. In this case, the
>>> >> captured from address will be zero which indicates the end of the
>>> >> buffer.
>> > 
>> > Right. But with SMT8 the size of the buffer is very small, so we will actually
>> > hit this case somewhat often. When we originally wrote this we decided it was
>> > better to get some information, ie. the from address, than no information at
>> > all.
> You are right. But practically as of now we are not using this kind of
> (from, 0) branch entries any where as a special case. More over for
> certain kind of workloads which has a small code and a few branches,
> the chances of getting this kind of branch (from, 0) increases a lot
> making them probably one of the highest percentage entries in the final
> perf report. Now with this change of code, the workload session might
> have overall less number of branch entries, but in my opinion represents
> more accurate branch profile of the given workload in percentage wise.
> 
>> > 
>>> >> 	This patch drops the entire branch record which would have
>>> >> otherwise confused the user space tools.
>> > 
>> > Does it confuse the tools? Can you show me before/after output from perf?
> The word 'confuse' might be little misleading. But the point as
> explained above that the relative branch percentage profile of
> certain workloads might be distorted and that I believe is true.
> Also branch entries like "from ----> 0" in the perf report might
> be confusing to users who dont expect to see this kind of entries
> in the final perf report and will never get into "perf report -D"
> to figure out what really happened.

Hey Michael,

As I had explained earlier, is not it a good idea to drop these
kind of branch records from the final output ? I will request
consideration of this patch along with others in the series.

I have dropped the following patch as you had pointed out.

[3/5] powerpc/perf: Replace last usage of get_cpu_var with this_cpu_ptr

Also did not receive any comments or thoughts on the V10 of the
BHRB SW branch filter patch series posted couple of months back.
Does it look good ?

http://comments.gmane.org/gmane.linux.ports.ppc.embedded/83206

After dropping the above patch and excluding the one which
had already merged mainline, rebased the entire series and
it still works fine on LE and BE kernel as of today. I will
be sending them soon.
