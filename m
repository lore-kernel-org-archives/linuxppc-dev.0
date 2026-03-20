Return-Path: <linuxppc-dev+bounces-18472-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450AE1093170
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 03:18:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcST35jyfz2xnl;
	Fri, 20 Mar 2026 14:18:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773976727;
	cv=none; b=m5koVNiCEr2oQ/z5Cbsp33x4jWN5Heu8Mhe4fFlyQnwaHGZaNwt2OTPp6uXfwUh/BhGRq5ZoIw7suzn7V4Lh2tSL1acKgXt5BeiplhqsTMKh6A9njaIy2steQRBJKM+tC19cKiL/Tj1V4rE9+YCfCS9WeQu++UJ3BPwx+xArxVrhmzgNlcWG8xkZi26DSIh77NEI3tY1NbD+SqGQDRAsjjXI71VQPlOrXas5Gooewv3U53WmUgQajtBJruB80WYXiN4Dg3A7Gj88J3gSrfGjjQgWpn2bNdwGbdu5UOYcEuQTWpkTnMti1/qdfeYAE40sAdQbpb+Xia0EXlyKy0MdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773976727; c=relaxed/relaxed;
	bh=verEAb8WxJ+vPtV/pZpgjW0L13vr5gbh+nX57J5s9lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/0lV2bOomGQEAIXzgFYHiJOqkDubdKAnjOoanhttvFMHfVjsSb4pVtyKdZC3ewyA7R2FRxYMbla4vQ7Golhvn59d2T22QW/tGk8pGIexYWZzn6iBcx0DQmqrV+Gq6tyI6S96gkjAIMJr/oI8BRwFfl1J3/jbIfHzZL5CJYffBMKOuMXCfJnulcBBQKvuP+xVoRa7kqCggh2v1c33/ChOvf7TfwTRJg8XMrIweDJyKQQyPrBJvsSkCe2+yfHVJTv6r+ovgNy6yJSmRAMVPcPTsrrJoq3wZMV4cJG5vhPUSQSHE0eMWtZ13ZRup3HEiMo30c+YtDGHYHI7vDinFaVyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MAN43k5j; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MAN43k5j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcST10tL5z2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 14:18:43 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773976718; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=verEAb8WxJ+vPtV/pZpgjW0L13vr5gbh+nX57J5s9lM=;
	b=MAN43k5jP+HELA+PqN7vCywQfTbKEdjK4euvozMr8Mt9T+A2z0qLcArNdQ+JjewSU/Psc23Y3/Hm51VHdexdfIm3jCGeM5PxAiH51aS1XPjfPc02FEfZjxGEaTeNATaeg/VkFA9KeeE5v0ts+XXf4TJ31xezAdGIAutjh0adPt8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.K7m.g_1773976716;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.K7m.g_1773976716 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 11:18:36 +0800
Message-ID: <66e78b59-f96c-4277-b7d7-473b68ed413f@linux.alibaba.com>
Date: Fri, 20 Mar 2026 11:18:33 +0800
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mm: change to return bool for the MMU notifier's
 young flag check
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <545847c132da5d957cfc74ab19e849b16127aa8f.1773890510.git.baolin.wang@linux.alibaba.com>
 <67c670e2-c98f-490b-bbb9-2960f8175b5a@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <67c670e2-c98f-490b-bbb9-2960f8175b5a@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/26 7:39 PM, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Mar 19, 2026 at 11:24:05AM +0800, Baolin Wang wrote:
>> The MMU notifier young flag check related functions only return whether
>> the young flag was set. Change the return type to bool to make the
>> intention clearer.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> I can see KVM is the only user for the mmu_notifier_ops clear_flush_young,
> clear_young and test_young hooks, which map to
> kvm_mmu_notifier_[clear_flush,clear,test]_young() functions, and you have
> updated them all.

Yes.

> So this LGTM with nits below, and so (with nits addressed as per the other R-b
> tags :):
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> 
> Thanks for doing this! Int as bool is a pet peeve of mine :))

Thanks for reviewing.

>>   include/linux/mmu_notifier.h | 76 +++++++++++++++++-------------------
>>   mm/internal.h                | 16 ++++----
>>   mm/mmu_notifier.c            | 20 +++++-----
>>   virt/kvm/kvm_main.c          | 40 +++++++++----------
>>   4 files changed, 72 insertions(+), 80 deletions(-)
>>
>> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
>> index 3705d350c863..17f2cdc77dd5 100644
>> --- a/include/linux/mmu_notifier.h
>> +++ b/include/linux/mmu_notifier.h
>> @@ -97,20 +97,20 @@ struct mmu_notifier_ops {
>>   	 * Start-end is necessary in case the secondary MMU is mapping the page
>>   	 * at a smaller granularity than the primary MMU.
>>   	 */
>> -	int (*clear_flush_young)(struct mmu_notifier *subscription,
>> -				 struct mm_struct *mm,
>> -				 unsigned long start,
>> -				 unsigned long end);
>> +	bool (*clear_flush_young)(struct mmu_notifier *subscription,
>> +				  struct mm_struct *mm,
>> +				  unsigned long start,
>> +				  unsigned long end);
>>
>>   	/*
>>   	 * clear_young is a lightweight version of clear_flush_young. Like the
>>   	 * latter, it is supposed to test-and-clear the young/accessed bitflag
>>   	 * in the secondary pte, but it may omit flushing the secondary tlb.
>>   	 */
>> -	int (*clear_young)(struct mmu_notifier *subscription,
>> -			   struct mm_struct *mm,
>> -			   unsigned long start,
>> -			   unsigned long end);
>> +	bool (*clear_young)(struct mmu_notifier *subscription,
>> +			    struct mm_struct *mm,
>> +			    unsigned long start,
>> +			    unsigned long end);
>>
>>   	/*
>>   	 * test_young is called to check the young/accessed bitflag in
>> @@ -118,9 +118,9 @@ struct mmu_notifier_ops {
>>   	 * frequently used without actually clearing the flag or tearing
>>   	 * down the secondary mapping on the page.
>>   	 */
>> -	int (*test_young)(struct mmu_notifier *subscription,
>> -			  struct mm_struct *mm,
>> -			  unsigned long address);
>> +	bool (*test_young)(struct mmu_notifier *subscription,
>> +			   struct mm_struct *mm,
>> +			   unsigned long address);
>>
>>   	/*
>>   	 * invalidate_range_start() and invalidate_range_end() must be
>> @@ -376,14 +376,12 @@ mmu_interval_check_retry(struct mmu_interval_notifier *interval_sub,
>>
>>   extern void __mmu_notifier_subscriptions_destroy(struct mm_struct *mm);
>>   extern void __mmu_notifier_release(struct mm_struct *mm);
>> -extern int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
>> -					  unsigned long start,
>> -					  unsigned long end);
>> -extern int __mmu_notifier_clear_young(struct mm_struct *mm,
>> -				      unsigned long start,
>> -				      unsigned long end);
>> -extern int __mmu_notifier_test_young(struct mm_struct *mm,
>> -				     unsigned long address);
>> +bool __mmu_notifier_clear_flush_young(struct mm_struct *mm,
>> +		unsigned long start, unsigned long end);
>> +bool __mmu_notifier_clear_young(struct mm_struct *mm,
>> +		unsigned long start, unsigned long end);
>> +bool __mmu_notifier_test_young(struct mm_struct *mm,
>> +		unsigned long address);
>>   extern int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *r);
>>   extern void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *r);
>>   extern void __mmu_notifier_arch_invalidate_secondary_tlbs(struct mm_struct *mm,
> 
> I mean damn, at this point maybe it's legit to drop the surrounding externs here
> too? But maybe not :))

I prefer to leave the others as is:)

[snip]

>>
>> -static __always_inline int kvm_age_hva_range(struct mmu_notifier *mn,
>> -						unsigned long start,
>> -						unsigned long end,
>> -						gfn_handler_t handler,
>> -						bool flush_on_ret)
>> +static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
>> +					      unsigned long start,
>> +					      unsigned long end,
>> +					      gfn_handler_t handler,
>> +					      bool flush_on_ret)
> 
> Can we please fix this terrrible indentation while we're here :)?
> 
> static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
> 		unsigned long start, unsigned long end, gfn_handler_t handler,
> 		bool flush_on_ret)
> 
> Would be nicer, thanks!

Will do if KVM maintainers are also happy with this.

