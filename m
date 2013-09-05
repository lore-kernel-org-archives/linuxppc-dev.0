Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 036402C00EE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 22:35:19 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Sep 2013 22:31:57 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 610053578050
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2013 22:35:15 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r85CIxMJ3735862
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 22:18:59 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r85CZEmc022634
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Sep 2013 22:35:14 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix possible deadlock on page fault
In-Reply-To: <1378381835.4321.169.camel@pasglop>
References: <1378365422-25203-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130905095316.GA18222@iris.ozlabs.ibm.com>
 <87a9jrwkuc.fsf@linux.vnet.ibm.com> <1378381835.4321.169.camel@pasglop>
Date: Thu, 05 Sep 2013 18:05:12 +0530
Message-ID: <877gevwinz.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2013-09-05 at 17:18 +0530, Aneesh Kumar K.V wrote:
>> Paul Mackerras <paulus@samba.org> writes:
>> 
>> > On Thu, Sep 05, 2013 at 12:47:02PM +0530, Aneesh Kumar K.V wrote:
>> >
>> >> @@ -280,6 +280,13 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
>> >>  
>> >>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>> >>  
>> >> +	/*
>> >> +	 * We want to do this outside mmap_sem, because reading code around nip
>> >> +	 * can result in fault, which will cause a deadlock when called with
>> >> +	 * mmap_sem held
>> >> +	 */
>> >> +	store_update = store_updates_sp(regs);
>> >
>> > We should only call store_updates_sp() if user_mode(regs); that was
>> > the previous behaviour.
>> 
>> Updated to 
>> 
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 8726779..fad7af6 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -206,7 +206,7 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
>>  	int trap = TRAP(regs);
>>   	int is_exec = trap == 0x400;
>>  	int fault;
>> -	int rc = 0;
>> +	int rc = 0, store_update = 0;
>
> Keep the "sp", in the name, it's confusing otherwise. It's not just
> about "store update", it's about specifically recognizing instructions
> used to update the stack frame in order to let them and only them
> significantly lower the stack pointer.
>

Ok will do that. I posted a v2. So will wait for other feedback before i
post a new version.

-aneesh
