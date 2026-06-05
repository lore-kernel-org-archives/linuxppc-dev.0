Return-Path: <linuxppc-dev+bounces-22099-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CD7CD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 05:33:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWqpR6kZXz2xnK;
	Fri, 05 Jun 2026 15:33:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780637583;
	cv=none; b=VcM8OVunbMzlHV9g5Cd3lHOiKrcw99ZxfnJHlTmxCl5yXmpbFeby8FkFZ/s67YGUCyMiW8PYEiHjntMCczYtub6yNS3djw5HrSwfTaCmHYiNuZO8nY5JGLw37Lxjr0Kyc60C5cHz4cpqO4rVThZa0g5MDc0PPVyHYruDlc3L0fdIbOaVv5kadPwuvA/Zb/3ckvuOMRBO20xl0YiRCzhcrCZiVPVKi67AF2ensTMarXX5kJ+WER70zBDIuqQluxhTdyzdNgxWye88K/rIDm8AAo0EYQ6Xy85XvDbyujr7CwC1YF8vxLTHQeq1yYXBBEH69mn/9AGJj26+Y35p4zUzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780637583; c=relaxed/relaxed;
	bh=+15LqyKW7oN+8aRw0RrpOGOrbsH6bDAzSO3UrhshfFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPKwJk2NCcvjkm2JwLxWdd/HI1QPlPdE8REXiUp509dQPGbCVOcMWlKWgCP5F5+x958NtUg3rb/7yRLrAlYCdjepMwRHAP3LgKlQLYkzZMOHaNNo8l2OwgUIQeptPsJRV5zf+syErpxecrkTv4qMx7OqwMyu61CFaCatOTTrUL/5TgjgSqmSBFnKD/+Ny5hS0Momw/l2lGS8/x2WH41RqR69IHwsemRgE9oQbJtn+4Sr9+6T0RA0xU0FaHeooDWBnMrfy7UiKuFLnJ7z6sMYiWG8VYI7fN80UV4suTcTCj1EQsqv3p7221VAKwxqJ4/ML3eBQCCYNrH/EbVbR53NZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvj5st/C; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvj5st/C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWqpQ5jRYz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 15:33:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 73C9441A8C;
	Fri,  5 Jun 2026 05:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242B21F00893;
	Fri,  5 Jun 2026 05:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780637580;
	bh=+15LqyKW7oN+8aRw0RrpOGOrbsH6bDAzSO3UrhshfFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fvj5st/Cat+oMgwESpHrwQp79Mpdt5IyFrbV3ocFeXanWrkN4F7uk+IpRhKw6XOQG
	 V+QrB9LfdGjKml7cW2/QIzkgivFRMa0dpYHM/RpkYsLaHSWZ9w4Bf3GSdzl3OCvotJ
	 iOipl8cQ29knXnFOJwfuzl0F3IqBB7SEkX6QkxE8YNp3by+X/IQDAT3fk+DdM5OziV
	 J5LFZ7SLPH2TFsWTjY0Urd1NaEIzx7GyrdIBNBjXxOPwiDSLCQ90rI53yi7jnx2ZIi
	 WvGJxa5C02MQ0l+bCthxdlyir2wHdLeMpJR1E/vBW7zlsBgEovuoo6rDazYD5svSIJ
	 Oa9XPUQ8uvjhA==
Message-ID: <b9019b74-57ff-47ed-9215-c6bdca98b2ce@kernel.org>
Date: Fri, 5 Jun 2026 07:32:56 +0200
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
Subject: Re: [PATCH] powerpc/vtime: Initialize starttime at boot for native
 accounting
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: frederic@kernel.org
References: <20260604132429.297665-1-sshegde@linux.ibm.com>
 <e69ad352-6835-414b-845b-03f45fdd9a45@kernel.org>
 <644eed72-fe6b-4639-88d3-dcbba1f8209b@kernel.org>
 <d56bebd8-bd0e-4e3d-b44f-6c2ca27ab5a9@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <d56bebd8-bd0e-4e3d-b44f-6c2ca27ab5a9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Shrikanth,

Le 05/06/2026 à 05:03, Shrikanth Hegde a écrit :
> Hi Christophe. Thanks for taking a look and review.
> 
> On 6/4/26 8:42 PM, Christophe Leroy (CS GROUP) wrote:
>>
> 
>>>> Also, does this warrant Fixes tag? I found these two likely candidates.
>>>> Likely this issues exists since beginning.
>>>> c223c90386bc powerpc32: provide VIRT_CPU_ACCOUNTING
>>>
>>> You say system has 240 CPU so I suppose this is not ppc32. That 
>>> commit wsa not supposed to change anything for ppc64, did you 
>>> identify anything special in that commit related to ppc64 ?
> 
> Yes. this was ppc64.
> 
>>>
>>>> b38a181c11d0 powerpc/time: isolate scaled cputime accounting in 
>>>> dedicated functions.
>>>
>>> This one is also pure code re-organisation, unless you've been able 
>>> to spot a particular issue ?
>>
>> Maybe commit cf9efce0ce31 ("powerpc: Account time using timebase 
>> rather than PURR")
>>
>> It removed snapshot_timebases() and I can't see anything to replace it.
>>
> 
> Yes. But this patch is dependent on Frederic's series.
> backporting that is going to be difficult. So i am thinking to avoid 
> putting Fixes tag.

Even if automatic backport will fail, it shouldn't be difficult to 
perform a manual backport by just adding the missing vtime_reset().
So I would put the Fixes tag to make people award.

> 
> 
>>
>>>
>>>>
>>>>   arch/powerpc/kernel/time.c | 4 +++-
>>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>>>> index 3460d1a5a97c..11145c40183d 100644
>>>> --- a/arch/powerpc/kernel/time.c
>>>> +++ b/arch/powerpc/kernel/time.c
>>>> @@ -377,7 +377,6 @@ void vtime_task_switch(struct task_struct *prev)
>>>>       }
>>>>   }
>>>> -#ifdef CONFIG_NO_HZ_COMMON
>>>>   /**
>>>>    * vtime_reset - Fast forward vtime entry clocks
>>>>    *
>>>> @@ -394,6 +393,7 @@ void vtime_reset(void)
>>>>   #endif
>>>>   }
>>>> +#ifdef CONFIG_NO_HZ_COMMON
>>>>   /**
>>>>    * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
>>>>    *
>>>> @@ -933,6 +933,7 @@ static void __init set_decrementer_max(void)
>>>>   static void __init init_decrementer_clockevent(void)
>>>>   {
>>>>       register_decrementer_clockevent(smp_processor_id());
>>>> +    vtime_reset();
>>>>   }
>>>>   void secondary_cpu_time_init(void)
>>>> @@ -948,6 +949,7 @@ void secondary_cpu_time_init(void)
>>>>       /* FIME: Should make unrelated change to move snapshot_timebase
>>>>        * call here ! */
>>>>       register_decrementer_clockevent(smp_processor_id());
>>>> +    vtime_reset();
>>>>   }
>>>>   /*
>>>
>>
> 
> Sorry i should have put this earlier, But this applies on top of tip/ 
> timers/nohz
> at 6199f9999a9b (origin/timers/nohz) sched/cputime: Handle dyntick-idle 
> steal time correctly
> (In case anyone tried applying on powerpc tree, it would fail)


Yep, I first looked vtime_reset() into linus tree, then found it in 
linux-next.

Christophe

