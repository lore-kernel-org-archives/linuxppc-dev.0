Return-Path: <linuxppc-dev+bounces-18469-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E011093168
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 03:05:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcS9t2b9Yz2xm5;
	Fri, 20 Mar 2026 14:05:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773975938;
	cv=none; b=FIb2vI1MwjjHgF/0BNojJ/vBy36iOxpNlYDs7TisPme1R7AtwgnEgjONrXrFSCv9K1sQX6R17GAcC3xwTXkbqeT6Q0O5/+RX37h8f7fof5XBvlDckKSj3XWMhMmIIq7Of3WTgzZJDcIH8mlSQILVHmmlCrxejTq6ZYmzacxq00pItLKT8rkRBnrpIrKTDwHBJSSAQsOv6MA2FPWN+rneEUnQRKiJUd+YdBoLEZG8+zVNQPQkfje2xd9qNicqfmEX9QCMsuBfaKc/+0n9j/gkQJo7VYZkedb//SwRGKQxr63/SW2VbK17tKCNkfoUTrwb8IK8+FpkCb+PKufJhG7nfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773975938; c=relaxed/relaxed;
	bh=VGXqSdrjifGxcMcDlLu7ZKp792LHAscB7o5xF4jfDt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYWgnaUuHZRvahqvWlfD+7QnaHp6pXLP2J9cx0owH9OXxGQ8gdEy9M9HwRJhvQik3hBhD42Aby961teyBrr9u6Guqsi1M7z5t2roSTMQ0JvXr1xJOU+F2+q0aCeq7PexbPu6VygQ1XyT7nea8ApcnGZ4GYqBD+zhrq6JaH8xLmoCzRqRVTdl8Xgyxquf/tDRPoowe3pc78mpZovQPIKFJZR5DGMXq0NyrWfkqw/g5+NsXStSAva++wzNaTM8iLNObex8HkPMOgr6OTMJI4TwiAp6XDR2M6bnR+wNlXyhfH1zzuski0Rhi6djyI/UHz+eGoDVbwHln7uLgzgNNNNcFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uhw262NK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uhw262NK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcS9r4F0rz2xN2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 14:05:34 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773975930; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VGXqSdrjifGxcMcDlLu7ZKp792LHAscB7o5xF4jfDt0=;
	b=uhw262NK6EdzoppId407nkloacTQw/p1dv1dwdz0cgOnRy3iLKUqTki0rzDX4c6ap5HoBQiD8iCtRB7NMWnM75Pgt4Du0cQMoa5C8dkDX1s3ytO4aU5yYLxnIFXftySSVW4JEeRNjbzioZ883Il6KJxwZLfUn/S8RoD1RD5/WFg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.KE0mj_1773975927;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X.KE0mj_1773975927 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Mar 2026 11:05:28 +0800
Message-ID: <f7831736-f48f-4b5f-908d-4acda5829403@linux.alibaba.com>
Date: Fri, 20 Mar 2026 11:05:27 +0800
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
Subject: Re: [PATCH 2/6] mm: change to return bool for
 ptep_clear_flush_young()/clear_flush_young_ptes()
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: akpm@linux-foundation.org, david@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <5d24b34d8b7860dc2188408b3fa530193bcc5caa.1773890510.git.baolin.wang@linux.alibaba.com>
 <46390a7c-164c-4ffb-a1b2-fad21e3829df@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <46390a7c-164c-4ffb-a1b2-fad21e3829df@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/26 7:30 PM, Lorenzo Stoakes (Oracle) wrote:
> On Thu, Mar 19, 2026 at 11:24:01AM +0800, Baolin Wang wrote:
>> The ptep_clear_flush_young() and clear_flush_young_ptes() are used to clear
>> the young flag and flush the TLB, returning whether the young flag was set.
>> Change the return type to bool to make the intention clearer.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Couple nits but LGTM, so:
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Thanks.

>> ---
>>   arch/arm64/include/asm/pgtable.h             | 15 +++++++--------
>>   arch/arm64/mm/contpte.c                      |  4 ++--
>>   arch/parisc/include/asm/pgtable.h            |  2 +-
>>   arch/parisc/kernel/cache.c                   |  8 ++++----
>>   arch/powerpc/include/asm/nohash/64/pgtable.h |  2 +-
>>   arch/riscv/include/asm/pgtable.h             |  4 ++--
>>   arch/s390/include/asm/pgtable.h              |  4 ++--
>>   arch/x86/include/asm/pgtable.h               |  4 ++--
>>   arch/x86/mm/pgtable.c                        |  4 ++--
>>   include/linux/pgtable.h                      |  8 ++++----
>>   mm/pgtable-generic.c                         |  7 ++++---
>>   11 files changed, 31 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 8c651695204c..393a9d1873f6 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -1299,10 +1299,10 @@ static inline bool __ptep_test_and_clear_young(struct vm_area_struct *vma,
>>   	return pte_young(pte);
>>   }
>>
>> -static inline int __ptep_clear_flush_young(struct vm_area_struct *vma,
>> -					 unsigned long address, pte_t *ptep)
>> +static inline bool __ptep_clear_flush_young(struct vm_area_struct *vma,
>> +					    unsigned long address, pte_t *ptep)
> 
> I mean this is subjective stuff but can we just put 2nd line 2 tabs indented
> underneath? Makes it easier for changes like this to not propagate.
> 
> Same comment for all of these!

I usually use 2 tabs for indentation in the mm subsystem, but for other 
subsystems, I try to follow the existing style since I'm unsure of other 
maintainers' preferences:)

Anyway, I can do this if no other objections.

