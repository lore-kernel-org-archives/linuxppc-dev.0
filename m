Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6F781A0F3A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 22:10:29 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 17C6014028F
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 22:10:28 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 17:40:27 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4D5F83940067
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:40:25 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5ACANn236831306
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:40:23 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5AC9JUP005039
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 17:39:19 +0530
Message-ID: <557828ED.9090803@linux.vnet.ibm.com>
Date: Wed, 10 Jun 2015 17:39:17 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V8 03/10] powerpc, perf: Re organize BHRB processing
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-3-git-send-email-khandual@linux.vnet.ibm.com>
 <1433910976.3096.26.camel@axtens.net>
In-Reply-To: <1433910976.3096.26.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2015 10:06 AM, Daniel Axtens wrote:
> 
>> +void update_branch_entry(struct cpu_hw_events *cpuhw,
>> +			int index, u64 from, u64 to, int pred)
>> +{
>> +	cpuhw->bhrb_entries[index].from = from;
>> +	cpuhw->bhrb_entries[index].to = to;
>> +	cpuhw->bhrb_entries[index].mispred = pred;
>> +	cpuhw->bhrb_entries[index].predicted = ~pred;
>> +}
> 
> I realise you're copying existing code, but:
>  - could you please rename pred? If we assign .mispred to pred
> and .predicted to ~pred, we should pick a different name for pred.

Agreed.

>  - I'm really uncomfortable with the bitwise inverting a signed integer.
> Can you explain what is going on here? Looking at
> include/uapi/linux/perf_event.h, this seems to be a single bit flag:
> shouldn't this then be a logical flip rather than a bitwise one?
> (Furthermore, looking at that header, why is pred an int at all? Why not
> a bool?)

Agreed.

> 
>> +
>>  /* Processing BHRB entries */
>>  static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
>>  {
>> -	u64 val;
>> -	u64 addr;
>> +	u64 val, addr, tmp;
> Please don't use 'tmp' here. As far as I can tell, you use this variable
> to compute the 'to' address. The name should reflect that.

Agreed but then it will be a new preparatory patch at the beginning
of this patch series.
