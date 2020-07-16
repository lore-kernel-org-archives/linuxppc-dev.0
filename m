Return-Path: <SRS0=Exvj=A3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922F8C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 04:44:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A13F2071B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 04:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryAs+iuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A13F2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B6hW70Yz3zDqw1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2020 14:44:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::343;
 helo=mail-wm1-x343.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ryAs+iuZ; dkim-atps=neutral
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B6hSq1yM6zDqMk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2020 14:42:49 +1000 (AEST)
Received: by mail-wm1-x343.google.com with SMTP id l2so9349800wmf.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 21:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=H2BpV1NO2gkfKzjkmWzHPaGPeCD37jRbwAmzGUUvtvg=;
 b=ryAs+iuZxDdBOelrURzFuGPFnX8+vb2+bXhJ4s59n/Ar9hGvzuf9X3jxWHyxGP/wyR
 Gwkn1PMk2u7J3dKg9zBJm2Gk6xJnrP+UuJdgtqJ7Y8JTnC0oR4W185OFScTPgkOMKSBK
 rvygO506O+nKnk5TKi3WH4r/0yLcFhJsfm1FgsswH3HfhWjEzCk/AYt1xhSPAPYl0jIw
 staBiW4w2WFxKG2lxGc6VCXXh+20cX24dpx5c7qX9dW70KqbPbvxzHqjTRNmStHtm/kq
 LuxX7C2gVJSebBzp9gbJEN+rBoJQotkrXvTvBSK2S5XGlbcNlXW1WnV4UBbWk1pVOi2F
 S0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=H2BpV1NO2gkfKzjkmWzHPaGPeCD37jRbwAmzGUUvtvg=;
 b=cQK/Xqyo9WeSDuX6bfbs1NUUoK8VaykEb8bmyJDbyPfXWkG8IVwvjFFCbC4yUwaz7O
 bm8g1cEnNUNGTKhnGlNFnmx7HhUBE9am9Mx27HDUGPpysChSiy67Q66b5kCl0FFAD6eX
 m75+K67Kxq/QWUfknL7CdzfPTtHD+8sJ/bj2AFOsvX4KGB4XZdHC3vsBVpsDNiRWy1Ud
 Kn8ol8vMuQ05CNCShccs6K+eYacnwP9VN811nCaXizhR/x8jhwGthLaP2aYRz3sXW7mP
 RM9+J5hCc4GJLv/YSRVhEINnYEGsvV45PqgOygn82xdq8k9grs4DV6KtCwaIiuk7h2oO
 iWfg==
X-Gm-Message-State: AOAM531vdbvzunpZi68zwTzEd7YmR9nrqwR6jt5KFdlKgzRdrwApKTXY
 e6rmWlqj8Tl0+LlpIbNo0L4=
X-Google-Smtp-Source: ABdhPJxZFpknsFk/eMkruNKL2oh7ijvzs4MWCRKjDl9HjyAuxw8OINhQvEieltyeeDR+RweU1Cs74g==
X-Received: by 2002:a1c:1b0d:: with SMTP id b13mr2474312wmb.169.1594874566365; 
 Wed, 15 Jul 2020 21:42:46 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
 by smtp.gmail.com with ESMTPSA id 22sm6963529wmb.11.2020.07.15.21.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 21:42:45 -0700 (PDT)
Date: Thu, 16 Jul 2020 14:42:38 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20200710015646.2020871-1-npiggin@gmail.com>
 <20200710015646.2020871-5-npiggin@gmail.com>
 <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
 <1594613902.1wzayj0p15.astroid@bobo.none>
 <1594647408.wmrazhwjzb.astroid@bobo.none>
 <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
 <1594868476.6k5kvx8684.astroid@bobo.none>
In-Reply-To: <1594868476.6k5kvx8684.astroid@bobo.none>
MIME-Version: 1.0
Message-Id: <1594873644.viept6os6j.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Nicholas Piggin's message of July 16, 2020 2:15 pm:
> Excerpts from Mathieu Desnoyers's message of July 14, 2020 12:13 am:
>> ----- On Jul 13, 2020, at 9:47 AM, Nicholas Piggin npiggin@gmail.com wro=
te:
>>=20
>>> Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
>>>> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
>>>>> Also, as it stands, I can easily see in_irq() ceasing to promise to
>>>>> serialize.  There are older kernels for which it does not promise to
>>>>> serialize.  And I have plans to make it stop serializing in the
>>>>> nearish future.
>>>>=20
>>>> You mean x86's return from interrupt? Sounds fun... you'll konw where =
to
>>>> update the membarrier sync code, at least :)
>>>=20
>>> Oh, I should actually say Mathieu recently clarified a return from
>>> interrupt doesn't fundamentally need to serialize in order to support
>>> membarrier sync core.
>>=20
>> Clarification to your statement:
>>=20
>> Return from interrupt to kernel code does not need to be context seriali=
zing
>> as long as kernel serializes before returning to user-space.
>>=20
>> However, return from interrupt to user-space needs to be context seriali=
zing.
>=20
> Hmm, I'm not sure it's enough even with the sync in the exit_lazy_tlb
> in the right places.
>=20
> A kernel thread does a use_mm, then it blocks and the user process with
> the same mm runs on that CPU, and then it calls into the kernel, blocks,
> the kernel thread runs again, another CPU issues a membarrier which does
> not IPI this one because it's running a kthread, and then the kthread
> switches back to the user process (still without having unused the mm),
> and then the user process returns from syscall without having done a=20
> core synchronising instruction.
>=20
> The cause of the problem is you want to avoid IPI'ing kthreads. Why?
> I'm guessing it really only matters as an optimisation in case of idle
> threads. Idle thread is easy (well, easier) because it won't use_mm, so=20
> you could check for rq->curr =3D=3D rq->idle in your loop (in a suitable=20
> sched accessor function).
>=20
> But... I'm not really liking this subtlety in the scheduler for all this=20
> (the scheduler still needs the barriers when switching out of idle).
>=20
> Can it be improved somehow? Let me forget x86 core sync problem for now
> (that _may_ be a bit harder), and step back and look at what we're doing.
> The memory barrier case would actually suffer from the same problem as
> core sync, because in the same situation it has no implicit mmdrop in
> the scheduler switch code either.
>=20
> So what are we doing with membarrier? We want any activity caused by the=20
> set of CPUs/threads specified that can be observed by this thread before=20
> calling membarrier is appropriately fenced from activity that can be=20
> observed to happen after the call returns.
>=20
> CPU0                     CPU1
>                          1. user stuff
> a. membarrier()          2. enter kernel
> b. read rq->curr         3. rq->curr switched to kthread
> c. is kthread, skip IPI  4. switch_to kthread
> d. return to user        5. rq->curr switched to user thread
> 		         6. switch_to user thread
> 		         7. exit kernel
>                          8. more user stuff
>=20
> As far as I can see, the problem is CPU1 might reorder step 5 and step
> 8, so you have mmdrop of lazy mm be a mb after step 6.
>=20
> But why? The membarrier call only cares that there is a full barrier
> between 1 and 8, right? Which it will get from the previous context
> switch to the kthread.

I should be more complete here, especially since I was complaining
about unclear barrier comment :)


CPU0                     CPU1
a. user stuff            1. user stuff
b. membarrier()          2. enter kernel
c. smp_mb()              3. smp_mb__after_spinlock(); // in __schedule
d. read rq->curr         4. rq->curr switched to kthread
e. is kthread, skip IPI  5. switch_to kthread
f. return to user        6. rq->curr switched to user thread
g. user stuff            7. switch_to user thread
                         8. exit kernel
                         9. more user stuff

What you're really ordering is a, g vs 1, 9 right?

In other words, 9 must see a if it sees g, g must see 1 if it saw 9,
etc.

Userspace does not care where the barriers are exactly or what kernel=20
memory accesses might be being ordered by them, so long as there is a
mb somewhere between a and g, and 1 and 9. Right?
