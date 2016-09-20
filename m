Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdlfR1rYvzDsfk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 00:35:26 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8KERn3K062389
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 10:35:24 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25jua8hdgf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 10:35:24 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 20 Sep 2016 10:35:23 -0400
Subject: Re: [PATCH v6 4/7] perf annotate: Do not ignore call instruction with
 indirect target
To: Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1471611578-11255-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1471611578-11255-5-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20160919154413.GA14725@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, markus@trippelsdorf.de,
 chris.ryder@arm.com, pawel.moll@arm.com, mhiramat@kernel.org,
 rmk+kernel@arm.linux.org.uk, jolsa@kernel.org, mpe@ellerman.id.au,
 hemant@linux.vnet.ibm.com, namhyung@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 20 Sep 2016 20:05:03 +0530
MIME-Version: 1.0
In-Reply-To: <20160919154413.GA14725@kernel.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <57E14917.5070100@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnaldo,

On Monday 19 September 2016 09:14 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 19, 2016 at 06:29:35PM +0530, Ravi Bangoria escreveu:
>> Do not ignore call instruction with indirect target when its already
>> identified as a call. This is an extension of commit e8ea1561952b
>> ("perf annotate: Use raw form for register indirect call instructions")
>> to generalize annotation for all instructions with indirect calls.
>>
>> This is needed for certain powerpc call instructions that use address
>> in a register (such as bctrl, btarl, ...).
>>
>> Apart from that, when kcore is used to disassemble function, all call
>> instructions were ignored. This patch will fix it as a side effect by
>> not ignoring them. For example,
>>
>> Before (with kcore):
>>        mov    %r13,%rdi
>>        callq  0xffffffff811a7e70
>>      ^ jmpq   64
>>        mov    %gs:0x7ef41a6e(%rip),%al
>>
>> After (with kcore):
>>        mov    %r13,%rdi
>>      > callq  0xffffffff811a7e70
>>      ^ jmpq   64
>>        mov    %gs:0x7ef41a6e(%rip),%al
> Ok, makes sense, but then now I have the -> and can't press enter to go
> to that function, in fact for the case I'm using as a test, the
> vsnprintf kernel function, I get:
>
>        │ 56:   test   %al,%al                                                                                                                                ▒
>        │     ↓ je     81                                                                                                                                     ▒
>        │       lea    -0x38(%rbp),%rsi                                                                                                                       ▒
>        │       mov    %r15,%rdi                                                                                                                              ▒
>        │     → callq  0xffffffff993e3230 
>
> That 0xffffffff993e3230 should've been resolved to:
>
> [root@jouet ~]# grep ffffffff993e3230 /proc/kallsyms 
> ffffffff993e3230 t format_decode
>
> Trying to investigate why it doesn't...

I investigated this.

If this example is with kcore, then it's expected. Because, perf annotate does
not inspect kallsyms when it can't find symbol name from disassembly itself.

For example, disassembly of  finish_task_switch,

with kcore:

ffffffff810cf1b0:       mov    $0x1,%esi
ffffffff810cf1b5:       mov    $0x4,%edi
ffffffff810cf1ba:       callq  0xffffffff811aced0
ffffffff810cf1bf:       andb   $0xfb,0x4c4(%rbx)
ffffffff810cf1c6:       jmpq   0xffffffff810cf0e9
ffffffff810cf1cb:       mov    %rbx,%rsi
ffffffff810cf1ce:       mov    %r13,%rdi
ffffffff810cf1d1:       callq  0xffffffff811a7e70
ffffffff810cf1d6:       jmpq   0xffffffff810cf0e4

with debuginfo:

ffffffff810cf1b0:       mov    $0x1,%esi
ffffffff810cf1b5:       mov    $0x4,%edi
ffffffff810cf1ba:       callq  ffffffff811aced0 <___perf_sw_event>
ffffffff810cf1bf:       andb   $0xfb,0x4c4(%rbx)
ffffffff810cf1c6:       jmpq   ffffffff810cf0e9 <finish_task_switch+0x69>
ffffffff810cf1cb:       mov    %rbx,%rsi
ffffffff810cf1ce:       mov    %r13,%rdi
ffffffff810cf1d1:       callq  ffffffff811a7e70 <__perf_event_task_sched_in>
ffffffff810cf1d6:       jmpq   ffffffff810cf0e4 <finish_task_switch+0x64>

call__parse tries to find symbol from angle brackets which is not present
in case of kcore.

-Ravi


> - Arnaldo
>
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> [Suggested about 'bctrl' instruction]
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
>> ---
>> Changes in v6:
>>   - No change
>>
>>  tools/perf/util/annotate.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index ea07588..a05423b 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -81,16 +81,12 @@ static int call__parse(struct ins_operands *ops, const char *norm_arch)
>>  	return ops->target.name == NULL ? -1 : 0;
>>  
>>  indirect_call:
>> -	tok = strchr(endptr, '(');
>> -	if (tok != NULL) {
>> +	tok = strchr(endptr, '*');
>> +	if (tok == NULL) {
>>  		ops->target.addr = 0;
>>  		return 0;
>>  	}
>>  
>> -	tok = strchr(endptr, '*');
>> -	if (tok == NULL)
>> -		return -1;
>> -
>>  	ops->target.addr = strtoull(tok + 1, NULL, 16);
>>  	return 0;
>>  }
>> -- 
>> 2.5.5
