Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B371C67839
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 02:46:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5858920811
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 02:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5858920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43FdNF0zs9zDqTC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 13:46:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Fchs3BTyzDqbg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 13:15:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43Fchr3QmBz9s7T;
 Thu, 13 Dec 2018 13:15:24 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc/mm/hash: Hand user access of kernel address
 gracefully
In-Reply-To: <c6ef0f52-6cb9-d48c-c11e-51b7d5cf8a25@debian.org>
References: <20181126143504.30996-1-aneesh.kumar@linux.ibm.com>
 <c6ef0f52-6cb9-d48c-c11e-51b7d5cf8a25@debian.org>
Date: Thu, 13 Dec 2018 13:15:23 +1100
Message-ID: <87d0q6w4sk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Breno Leitao <leitao@debian.org> writes:

> hi Aneesh,
>
> On 11/26/18 12:35 PM, Aneesh Kumar K.V wrote:
>> With commit 2865d08dd9ea ("powerpc/mm: Move the DSISR_PROTFAULT sanity check")
>> we moved the protection fault access check before vma lookup. That means we
>> hit that WARN_ON when user space access a kernel address.  Before the commit
>> this was handled by find_vma() not finding vma for the kernel address and
>> considering that access as bad area access.
>> 
>> Avoid the confusing WARN_ON and convert that to a ratelimited printk.
>> With the patch we now get
>> 
>> for load:
>> [  187.700294] a.out[5997]: User access of kernel address (c00000000000dea0) - exploit attempt? (uid: 1000)
>> [  187.700344] a.out[5997]: segfault (11) at c00000000000dea0 nip 1317c0798 lr 7fff80d6441c code 1 in a.out[1317c0000+10000]
>> [  187.700429] a.out[5997]: code: 60000000 60420000 3c4c0002 38427790 4bffff20 3c4c0002 38427784 fbe1fff8
>> [  187.700435] a.out[5997]: code: f821ffc1 7c3f0b78 60000000 e9228030 <89290000> 993f002f 60000000 383f0040
>> 
>> for exec:
>> [  225.100903] a.out[6067]: User access of kernel address (c00000000000dea0) - exploit attempt? (uid: 1000)
>> [  225.100938] a.out[6067]: segfault (11) at c00000000000dea0 nip c00000000000dea0 lr 129d507b0 code 1
>> [  225.100943] a.out[6067]: Bad NIP, not dumping instructions.
>> 
>> Fixes: 2865d08dd9ea ("powerpc/mm: Move the DSISR_PROTFAULT sanity check")
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
> Tested-by: Breno Leitao <leitao@debian.org>

Thanks.

>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 1697e903bbf2..46f280068c45 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -342,8 +342,21 @@ static inline void cmo_account_page_fault(void) { }
>>  #endif /* CONFIG_PPC_SMLPAR */
>>  
>>  #ifdef CONFIG_PPC_STD_MMU
>> -static void sanity_check_fault(bool is_write, unsigned long error_code)
>> +static void sanity_check_fault(bool is_write, bool is_user,
>> +			       unsigned long error_code, unsigned long address)
>>  {
>> +	/*
>> +	 * userspace trying to access kernel address, we get PROTFAULT for that.
>> +	 */
>> +	if (is_user && address >= TASK_SIZE) {
>> +		printk_ratelimited(KERN_CRIT "%s[%d]: "
>> +				   "User access of kernel address (%lx) - "
>> +				   "exploit attempt? (uid: %d)\n",
>> +				   current->comm, current->pid, address,
>> +				   from_kuid(&init_user_ns, current_uid()));
>> +		return;
>
> Silly question: Is it OK to printk() and just return here? __do_page_fault
> will continue to execute independently of this return, right?

Yeah it is OK to just return.

I agree it's a bit of a strange way for the code to be structured, ie.
we detect a bad condition and print about it and then just return and
let it continue anyway.

I guess it's that way because it was added as an additional check, ie.
the code already handled those cases further down, but this was a check
in case anything weird happened.

If you look at the start of __do_page_fault() we have three separate
checks:

	if (unlikely(page_fault_is_bad(error_code))) {
		if (is_user) {
			_exception(SIGBUS, regs, BUS_OBJERR, address);
			return 0;
		}
		return SIGBUS;
	}

	/* Additional sanity check(s) */
	sanity_check_fault(is_write, is_user, error_code, address);

	/*
	 * The kernel should never take an execute fault nor should it
	 * take a page fault to a kernel address.
	 */
	if (unlikely(!is_user && bad_kernel_fault(is_exec, error_code, address)))
		return SIGSEGV;


It seems like maybe we could simplify that somewhat.

We need to be careful though that we return the right signal (SEGV or
BUS), and also that user faults get counted (see PERF_COUNT_SW_PAGE_FAULTS).

So it's not straight forward as usual :)

cheers
