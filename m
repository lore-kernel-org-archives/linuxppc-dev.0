Return-Path: <linuxppc-dev+bounces-19423-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB50DFB519C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 06:23:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqbk93lnyz2ygm;
	Tue, 07 Apr 2026 16:23:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775543025;
	cv=none; b=T+mCc/9XI/ygJfABU21+geW6Tvv33u/Yx4Q3qX6xOQN7L1pMTqRDy+QUulUP2RH0q3/6ABC9GOPG4AqmcsR+cmIUTQp+ArnThBsrMA1i4qpdfa+a/m8EE4qLwdvaMJBp9ic7/fNaGP81yY1TmHnoZyXWaUpP/Yv1b4SWf2Lu0wAKe1ubHs1DcF7zi4h06+lEdfmOSSKy7N91w/ER8Nmnyd2gid2Txrv7N+mo1BHptHIOc1KnfQLWvpqNzlONuiLR6zkr/ohCzaYbaaMQK+8pJNplNNcQ6pP0MgDbIllN+ij8S7J1Jk40l0+LZ25qzwpfqNQtMGigKMuk4lx+nJC4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775543025; c=relaxed/relaxed;
	bh=6CMtQUtwLNCZO96qDPJxNdbEJ+SZVWz86MVqoqQUYgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9wcwqtmo/0C6xG1t0shQurkU/KaYmjWu3xym8aQsjXJn9Ka9UsrM6DcEraMyWFfF6grJGAgwQ9zGqGHlhipFKJ6AKYThVVsMAiD57mRSGt/LfwF2rIVf54YU1VbcX6YQdeF2Ebe4mhpYvVlPEEoZPmsQnz2i2AMF2KLFtaPsUDLOJ/uQ6sw5LsCAFDzw2RToRZ8o+Na9Kmh3KIa15q8tEKcW288ib8fhn6HnqY6SrZMIHpKxnxXGA2oozcAmOUqwQkNdyqiFSEfGeJlWbzidwIIZMYwK9uIewNSHqNz2joyowSCUfNidQVftGK2e69iQ2zD08W0eUUUBgcv34G4bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iwl7gR3D; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iwl7gR3D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=baolin.wang@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqbk718wwz2ygf
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 16:23:41 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775543016; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6CMtQUtwLNCZO96qDPJxNdbEJ+SZVWz86MVqoqQUYgg=;
	b=iwl7gR3DqDgFOfIIipw/0NMXTg1u8xj5AisKNghwR4sxGC9eKNZgPHTJN7VP0QGPjHUgHaxZDIAXLhk85/fsU0jvufuhKDQBlf8z7++muqh0AgtVyfCQ3BBLLsswhCxfBX8Y5yBprTRJJOSjcnLFKOQTW0pVrzmy5OaWJCnJW+U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0albEE_1775543013;
Received: from 30.74.144.138(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X0albEE_1775543013 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 14:23:34 +0800
Message-ID: <2a216ee2-aebb-42ba-b2aa-826488448bbe@linux.alibaba.com>
Date: Tue, 7 Apr 2026 14:23:33 +0800
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
To: Sean Christopherson <seanjc@google.com>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, akpm@linux-foundation.org,
 david@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <545847c132da5d957cfc74ab19e849b16127aa8f.1773890510.git.baolin.wang@linux.alibaba.com>
 <67c670e2-c98f-490b-bbb9-2960f8175b5a@lucifer.local>
 <66e78b59-f96c-4277-b7d7-473b68ed413f@linux.alibaba.com>
 <adBJTXeE6G2vQNKX@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <adBJTXeE6G2vQNKX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/4/26 7:12 AM, Sean Christopherson wrote:
> On Fri, Mar 20, 2026, Baolin Wang wrote:
>>>> -static __always_inline int kvm_age_hva_range(struct mmu_notifier *mn,
>>>> -						unsigned long start,
>>>> -						unsigned long end,
>>>> -						gfn_handler_t handler,
>>>> -						bool flush_on_ret)
>>>> +static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
>>>> +					      unsigned long start,
>>>> +					      unsigned long end,
>>>> +					      gfn_handler_t handler,
>>>> +					      bool flush_on_ret)
>>>
>>> Can we please fix this terrrible indentation while we're here :)?
>>>
>>> static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
>>> 		unsigned long start, unsigned long end, gfn_handler_t handler,
>>> 		bool flush_on_ret)
>>>
>>> Would be nicer, thanks!
> 
> No, please keep this as-is.  KVM's preferred style is exactly this (and I personally
> find mm's style much harder to parse).

Um, Andrew has already queued v2[1] into the mm-stable branch. Do you 
want me to send a follow-up patch to restore the original KVM coding style?

[1] 
https://lore.kernel.org/all/cover.1774075004.git.baolin.wang@linux.alibaba.com/T/#u

