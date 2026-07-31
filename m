Return-Path: <linuxppc-dev+bounces-25163-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31C8C55167
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:03:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBDV96xrJz2yYq;
	Fri, 31 Jul 2026 15:03:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785474193;
	cv=none; b=CsHKhDp4j+k5s4Ii9ZiGb7rPjdjxfROam17mWAiytzcvmuajJzNdtVtzfOYcW1AnHh1EkcnwahehhdB7JnVyNKiMfVRgX+cBACEvJaHa3VSM+VsnAKCYfSkWpWXgzG5iDDQ5uzBcEuBEDWLbywmJdcW8tZhdvgaxirHv8sybiqoTOGexSUQ+5ugkYmDoeoZ600gvkt6ttK57Y3fjgmBpTxh/Z01ZlvXsSWOlwXRc8kotn+knjjgbai7vRRWjFN4fZwFz5BWrQPcBkHt+SNmBuiyNOlu7wdtBf5BuOWVBrw2oUqm0A6cvI3r5HKSrgvVDm2VGttnFd+7npq3jdtsVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785474193; c=relaxed/relaxed;
	bh=uIZ1cliZy3dvKkIoul/3bmQkjTyvax6ZvAsutxtl2eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IoQweifh0LHvST6AZs/jKY92JQhy8wOalIBxecj34s/I6QG+H0awWZzryM4avRuNDX8rS+2GDSXyb4tD6Qa/Ek9IAzH64zF9sJPbLlhyPMMPtRw8GDTGCBW0mhIxIYXiS0a4Yz6JJsuzQgU/p+eUpW5RmBpg6ymL0woZHjtHD76ARGCvtlcplYPgifanvWGLQscuwnyp17GoMjY3uaS78AG/6MmzW6mjzx5G+N82rDAInbaggnqCOG47WMktP0VND3vquFtrZbUhDM7y+BWSs5uGdfBcZa75yuevVZogQGk2ZRSlmgiLjMY+bS43aCRzwnVSS9ZQezXMP63hiiDzXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZvR8IyB; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hZvR8IyB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBDV90gJVz2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 15:03:12 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5C7E8600C8;
	Fri, 31 Jul 2026 05:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2CD1F000E9;
	Fri, 31 Jul 2026 05:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785474188;
	bh=uIZ1cliZy3dvKkIoul/3bmQkjTyvax6ZvAsutxtl2eE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hZvR8IyB6Uw+RtP5vVqDZI3IdbuQx0NXYqCtMRST38obTXlJifbi498TO8Oq2cn9u
	 VC8ikqnuNglb4T3bhyDhf/GIJXQ4o4W5+fzhzkt/KhbPqtHW8XKWpLpIG1JHRcwzSJ
	 g2cESyGa/DepkOa5eWOo6Okzzy0YN/5pmrjbWYs08Y+QqwHIs2ZwRN/Vz/GAWFEFFY
	 vcCBmhg/UdVTU6NRj6YYZQa7P+O2fhVDwYPYyjcFRNJsqRVIesgFwU7/5bAHtGNi47
	 K3REu/QlCFwy39Tj2pgZad7+HT6LNajEftWLlYgLNRQ8n3+SXgayprK/JEDTAB778y
	 6rD5/kUXw8Yew==
Message-ID: <972db4f1-406b-477b-895e-59ffc643e384@kernel.org>
Date: Fri, 31 Jul 2026 07:03:02 +0200
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
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Jirka Hladky
 <jhladky@redhat.com>, paulmck@kernel.org
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 npiggin@gmail.com, bigeasy@linutronix.de, will@kernel.org,
 linux-kernel@vger.kernel.org
References: <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com>
 <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
 <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
 <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
 <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
 <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
 <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 30/07/2026 à 19:10, Shrikanth Hegde a écrit :
> Hi Jirka, Paul,
> 
> 
> +cc will
> 
> On 7/30/26 8:38 PM, Jirka Hladky wrote:
>> On Thu, Jul 30, 2026 at 4:53 PM Paul E. McKenney <paulmck@kernel.org> 
>> wrote:
>>> But is this really a fundamental RISC cost?  For example, does arm64
>>> see the same performance issues?
>>
>> We tested arm64 (Ampere Altra Max) with the same controlled
>> experiment -- two 6.18 kernels, both voluntary, differing only in
>> PREEMPT_DYNAMIC:
>>
>> Arch     PREEMPT_DYNAMIC   kill bogo-ops/sec   Delta
>> -------  ---------------   -----------------   -----
>> ppc64le  off               108,836
>> ppc64le  on                 68,197             -37.3%
>> aarch64  off                 5,538
>> aarch64  on                  5,082              -8.2%
>>
>> arm64 sees -8.2% vs ppc64le's -37.3%. So arm64 is affected but
>> much less severely.
> 
> Ouch!. But that's good to know.

Might be a stupid question, but what is your .config ?
Are you sure it doesn't contain CONFIG_DEBUG_PREEMPT ?

> 
>>
>>> In particular, I can see why the preempt_count() operations need to be
>>> interrupt-safe, but I don't see why you would need barriers.  And
>>> doesn't powerpc still use software interrupt disabling?  If so, why
>>> not use that to simply software-disable interrupts around the
>>> preempt_count() operations?
> 
> Barrier are in core implementation, not in arch specific.
> 
> #ifdef CONFIG_PREEMPT_COUNT
> #define preempt_disable() \
> do { \
>          preempt_count_inc(); \
>          barrier(); \
> } while (0)
> 
> 
> #ifdef CONFIG_PREEMPTION
> #define preempt_enable() \
> do { \
>          barrier(); \
>          if (unlikely(preempt_count_dec_and_test())) \
>                  __preempt_schedule(); \
> } while (0)
> 
> 
> 
>>>
>>> What am I missing here?
>>
>> That's a good question -- I don't know enough about the powerpc
>> preempt_count implementation to answer this. Shrikanth, could you
>> comment on whether removing the barriers or using software interrupt
>> disabling around preempt_count is feasible?
>>
>> Thank you
>> Jirka
>>
> 
> PowerPC currently uses asm-generic implementation which is probably sub- 
> optimal
> w.r.t to check of need_resched.
> 
> When i see ARM's implementation, i see there is trick of splitting it 
> into two.
> 
>          union {
>                  u64             preempt_count;  /* 0 => preemptible, <0 
> => bug */
>                  struct {
> #ifdef CONFIG_CPU_BIG_ENDIAN
>                          u32     need_resched;
>                          u32     count;
> #else
>                          u32     count;
>                          u32     need_resched;
> #endif
>                  } preempt;
>          };
> 
> 
> Seeing Will's changelog is on similar direction.
> 
> 396244692232 arm64: preempt: Provide our own implementation of asm/ 
> preempt.h
> "The asm-generic/preempt.h implementation doesn't make use of the
> PREEMPT_NEED_RESCHED flag, since this can interact badly with load/store
> architectures which rely on the preempt_count word being unchanged across
> an interrupt.
> 
> However, since we're a 64-bit architecture and the preempt count is
> only 32 bits wide, we can simply pack it next to the resched flag and
> load the whole thing in one go, so that a dec-and-test operation doesn't
> need to load twice. "
> 
> I am speculating this might help solve for ppc64 too. But i don't have a 
> system
> to try this right now, will get back once i do


