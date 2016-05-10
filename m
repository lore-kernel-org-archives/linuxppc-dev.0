Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3gQJ00clzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 10:40:23 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 10 May 2016 10:40:22 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 483BD2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 10:40:19 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4A0eBFv10092810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 10:40:19 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4A0dkRT031785
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 10:39:47 +1000
Date: Tue, 10 May 2016 10:38:51 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc/mm: Remove duplicated check in do_page_fault()
Message-ID: <20160510003851.GA17823@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1456446386-28619-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <3r3Hyt6KL9z9t0r@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3r3Hyt6KL9z9t0r@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 09, 2016 at 08:03:50PM +1000, Michael Ellerman wrote:
>On Fri, 2016-26-02 at 00:26:25 UTC, Gavin Shan wrote:
>> When the page fault happened in user space, we need check it's
>> caused by stack frame pointer update instruction and update
>> local variable @flag with FAULT_FLAG_USER. Currently, the code
>> has two separate check for the same condition. That's unnecessary.
>> 
>> This removes one of the duplicated check. No functinal changes
>> introduced.
>
>It's possible though that store_updates_sp() changes regs, and causes
>user_mode(regs) to change, which would mean the second check is necessary.
>That's not true with the current code, but you should mention that you confirmed
>that in the change log.
>

Thanks for review. Yeah, store_updates_sp() checks the failing instruction
is the one updating stack frame pointer (stdu and the variable). The info
is used to expand the stack later. All of it should have been documented
in the commit log.

>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index a67c6d7..935f386 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -294,11 +294,10 @@ int __kprobes do_page_fault(struct pt_regs *regs, unsigned long address,
>>  	 * can result in fault, which will cause a deadlock when called with
>>  	 * mmap_sem held
>>  	 */
>> -	if (user_mode(regs))
>> -		store_update_sp = store_updates_sp(regs);
>> -
>> -	if (user_mode(regs))
>> +	if (user_mode(regs)) {
>>  		flags |= FAULT_FLAG_USER;
>> +		store_update_sp = store_updates_sp(regs);
>> +	}
>
>It doesn't really matter in this case, but it would be better to keep the
>ordering of the two statements the same as before.
>

Yep, It should have two checks in order as before here if store_updates_sp()
can alter MSR[PR] bit in future as you explained above :-)

Thanks,
Gavin

>cheers
>
