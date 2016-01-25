Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A0D31A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 14:28:40 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 25 Jan 2016 08:58:37 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0P3SXe214156158
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 08:58:34 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0P3SWTC031433
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 08:58:33 +0530
Subject: Re: [PATCH V10 2/4] perf/powerpc: add support for sampling intr
 machine state
To: Michael Ellerman <mpe@ellerman.id.au>, Anju T <anju@linux.vnet.ibm.com>
References: <1452508104-16507-1-git-send-email-anju@linux.vnet.ibm.com>
 <1452508104-16507-3-git-send-email-anju@linux.vnet.ibm.com>
 <1453286426.14751.19.camel@ellerman.id.au>
Cc: hemant@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, acme@redhat.com, dsahern@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
 jolsa@redhat.com, khandual@linux.vnet.ibm.com
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Message-ID: <56A59651.6010903@linux.vnet.ibm.com>
Date: Mon, 25 Jan 2016 08:58:17 +0530
MIME-Version: 1.0
In-Reply-To: <1453286426.14751.19.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 20 January 2016 04:10 PM, Michael Ellerman wrote:
> On Mon, 2016-01-11 at 15:58 +0530, Anju T wrote:
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 9a7057e..c4ce60d 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -119,6 +119,7 @@ config PPC
>>  	select GENERIC_ATOMIC64 if PPC32
>>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>>  	select HAVE_PERF_EVENTS
>> +	select HAVE_PERF_REGS
>>  	select HAVE_REGS_AND_STACK_ACCESS_API
>>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
>>  	select ARCH_WANT_IPC_PARSE_VERSION
>> diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
>> new file mode 100644
>> index 0000000..d32581763
>> --- /dev/null
>> +++ b/arch/powerpc/perf/perf_regs.c
> ...
>> +
>> +u64 perf_reg_abi(struct task_struct *task)
>> +{
>> +	return PERF_SAMPLE_REGS_ABI_64;
> What is this value used for exactly?
>
> It seems like on 32-bit kernels we should be returning PERF_SAMPLE_REGS_ABI_32.

Yes. you are right. But even in 64bit kernel, based on the application
we need to return 32 to 64 abi. Damn my bad. missed 32bit part
all together.


Maddy
>
>> +}
>> +
>> +void perf_get_regs_user(struct perf_regs *regs_user,
>> +			struct pt_regs *regs,
>> +			struct pt_regs *regs_user_copy)
>> +{
>> +	regs_user->regs = task_pt_regs(current);
>> +	regs_user->abi  = perf_reg_abi(current);
>> +}
> cheers
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
