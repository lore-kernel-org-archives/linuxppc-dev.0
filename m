Return-Path: <linuxppc-dev+bounces-28492-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3278CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:43:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvHss64Nxz2yvy;
	Tue, 29 Sep 2026 22:43:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790685825;
	cv=none; b=F/NzmHnAb3881TA9MX94lwdh95S32dcHDcjrfdB1I6YwkhM8Ap4sMaeEX/+YWo3lDcuOCuYNbcVgK7C5AvOCmlQnyqo1mDHc4EZCk+xRHnZ4SFQ/3w5VS9g6phNZoR2ytaY6o1kEEMtBU/2ZELVagv7FehftjBsTn4hiuSd0EhwejFRflomMTT/tbIXWrqje7ey38fqhCut7Bakhg4KsGub81Qe/6y33JCy1RLirnNOcBbryoamu/NPNjBfsG5S1+JX/wa5xmYuadmIDmuuEG+gJRC3sfZC7exlfoMLm4YVdxS8eK41nHLmbVs+HUp53UUdc28WnBzd7z/X1wYU9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790685825; c=relaxed/relaxed;
	bh=N3pQBIPeU4kgfNPc2czVGyN9J1uJXh7phrPpqePrvUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPrisr8JEy6SfzWo7gyV10PN6uGnBrG7ai6X6hvtTuKMRUsJp5UrR3bvVZWLTm/bQJ2Fgpr9dXt0EVqdmJXxJaYXxVPsvesK6EWLo16NdxZp5Yv2VCYhiid8/xhojzI0BGBBQFFXllaJ/daaz/bqsMftFsnzgy64fyalNHxKOdEAGmYcSM7LKUcM/r+Bn+Krm5KV56v3x4dfYFO/9mF/nulT7lCBTfbj12nRTHoZqNNjRgJTTGbGMakA7f76dsxVc4/pnOGApfztzqAoHjcf2OPWeeVybL+aYTR7+h4WJoXxJNHwRt3yn//nNnGJpD5IVwMOD4txGFbSll1XyM6RlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcE6zQ2Q; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcE6zQ2Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvHsr44JTz2yft
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 22:43:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E8EBC600D1;
	Tue, 29 Sep 2026 12:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1041F000FF;
	Tue, 29 Sep 2026 12:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685820;
	bh=N3pQBIPeU4kgfNPc2czVGyN9J1uJXh7phrPpqePrvUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WcE6zQ2QvlWMrtJQUUEZxuamgp5A36S7HaP5MZB0g4eZ9uf2ae9YBaoQgyNavhmPr
	 7InOUoAncTnZO0lY6eJqtBIMTkplBiTSh5ju6aBC09cYVfQgoHdBU26Kq5yu+mdO6I
	 qQHW6N+635UPz5ZimUFjXpPb6emnvZCDfZR7M5JcA+tmjjGU8iZrOsqWMKUZiNHNPQ
	 S9quHn0QXa6tns7dhr5KMFIGyQuUeid3XeYJ/aSaFvO4mav/gBJ0pttuDuGsUFk8JD
	 efMOiYRGZr5e/z0XIs5R2HPCTO8eFY24MNoyi7g3HrvBGlLHvmEdAjkrco2dz3RfuB
	 fPssynLHZetUw==
Message-ID: <b5b736c3-badf-4ceb-a4b7-00415bed19fe@kernel.org>
Date: Tue, 29 Sep 2026 14:43:33 +0200
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
Subject: Re: [PATCH] powerpc/syscall: Avoid atomic test_and_clear_thread_flag
 on fast path
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 ritesh.list@gmail.com, ruanjinjie@huawei.com, tglx@kernel.org,
 mkchauras@linux.ibm.com, ryan.roberts@arm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260929071744.2965058-1-mkchauras@gmail.com>
 <84ceaa9a-79fb-4585-a571-7701750df5d1@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <84ceaa9a-79fb-4585-a571-7701750df5d1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/09/2026 à 11:50, Shrikanth Hegde a écrit :
> 
> 
> On 9/29/26 12:47 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
>> In system_call_exception(), test_and_clear_thread_flag(TIF_SYSCALL_RET)
>> performs an atomic bit test-and-clear operation on every system call 
>> entry.
>> This introduces an unnecessary performance regression on the syscall fast
>> path.
>>
> 
> Do you have numbers?
> 
>> Combine the TIF_SYSCALL_RET check with the unlikely error condition from
>> syscall_enter_from_user_mode_randomize_stack() using non-atomic
>> test_thread_flag(). If the flag is set or entry failed, only then 
>> clear the
>> flag via clear_thread_flag() and return the error value.
>>
> 
> It probably needs a fixes tag.

It is not a bug, unless we can figure out a quantified regression.

> 
>> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
>> ---
>>   arch/powerpc/kernel/syscall.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/ 
>> syscall.c
>> index fbefe1927b10..8529827d697f 100644
>> --- a/arch/powerpc/kernel/syscall.c
>> +++ b/arch/powerpc/kernel/syscall.c
>> @@ -18,14 +18,12 @@ notrace long system_call_exception(struct pt_regs 
>> *regs, unsigned long r0)
>>       long ret;
>>       syscall_fn f;
>> -    if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, 
>> &r0))) {
>> +    if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, 
>> &r0) ||
>> +            test_thread_flag(TIF_SYSCALL_RET))) {
>>           clear_thread_flag(TIF_SYSCALL_RET);
>>           return syscall_get_error(current, regs);
>>       }
>> -    if (unlikely(test_and_clear_thread_flag(TIF_SYSCALL_RET)))
> 
> I am bit surprised that test_and_clear_bit does
> atomic operations even when bit is not set.

It does (on ppc64 smp)

	sync
   1:	ldarx
	andc
	stdcx.
	bne 1b
	sync

It is optimised to clear a bit that is set. When the bit is already 
unset you still get the full sequence allthough it does nothing.

> 
>> -        return syscall_get_error(current, regs);
>> -
>>       if (unlikely(r0 >= NR_syscalls)) {
>>           if (unlikely(trap_is_unsupported_scv(regs))) {
>>               /* Unsupported scv vector */
> 


