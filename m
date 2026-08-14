Return-Path: <linuxppc-dev+bounces-25863-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B982C5CFDB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:30:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM1ll5bxDz2ykT;
	Fri, 14 Aug 2026 22:30:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786710627;
	cv=none; b=PJarSLcRtOjsdFlMHgX39v6q9zA/yngsB9yhZ6onRu88E9jet7ap5Amx2UkmeqPstl/uCzhUQfDFNjFgK6HLpqOG3JyiS51XyAZDCXag4JZY/6sRrvihzUaUmYtEgzLYWswGyJisPBMdivcyS3bfyY7wNICTjMNBFMF/qJGPEJMM3PfWRmctiXKYoqQreC53+5GW8Tsl6BvyRURCGd5/m6TIq5U91diJLU2nPZbirfYVDau8hT+yAemHrlbyeY5rFU2Q1Q9goJPbc+reW3/zZ3XQhs7tAPOi0IB/5PURqHbyCOtiAe6JAufkpk/eE2hlvvX/HWxASHzhEeYQ6pfmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786710627; c=relaxed/relaxed;
	bh=HKKsiOkispBHtadww+iXjd9Ra2guD/uOnDke3p6E2gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UtpsLuY8yZS3q2w8OV3YoH/ooRVLvOv5LyKjoJAPQVUXst3Lbik/g8a+qz3asGj1gpdNpVZiYBhDtewL8ws/zhqE5CtgjtWLzc6txJqBVwYt9qaq74qxnXpt114N7u1vC02kvndel6HmNeNEXuVBqFv1xpSy8X9JGm7WIvpwFZzYaNXuEcw3byS1KZLVoxPr6zWK8/L6HKSyEHnrTtxmvQqFcYvTu3x8yPj1VgtHflaBKeV76XrEuJep8ilgug1xh3FNPNTxBIthXL2JuZK3MfHwOmJhuxvEsZPxZEs2q6JA0op8TsgbnOBEbuuxSMFfLmDwHUVtOV0Q3B5182xlpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oegK3E0l; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oegK3E0l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM1lk5ncFz2yD8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 22:30:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4EB20600C3;
	Fri, 14 Aug 2026 12:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0311F000E9;
	Fri, 14 Aug 2026 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786710624;
	bh=HKKsiOkispBHtadww+iXjd9Ra2guD/uOnDke3p6E2gA=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=oegK3E0lTTkmx97gOV+4Y8Cbm4yAgDCYay9YB7MZlfoKvCp5UAx/+GXfVPD24Txo/
	 O4aaKBdgYHOQBV/8nWZNAKgZ5shM2Bn5gEhiROTzUM10AbMMr9Ur8Oy13e7pazs+5B
	 RJk2WLWn9NO31SO8fYlhQ2dRJN4/qZrwTlgQ8BTr4e+hMw4zE1R2u23u/Brf0IS9RF
	 WosA+H0u1dIN4MJXjvfUPdeFnKUVriQ3A4P39a/3Enc19JHMNABzip+Vkn3XsDy+nu
	 V7jbR22jhwRUg+4xrvnuHguQFB+CyscjH9HqQ9KasTDqcEAy7JxEgtBLjRZL+miTuN
	 AUX7vTxbgJdDA==
Message-ID: <1e28e2fb-36ac-4187-90c4-fc7dfea03f28@kernel.org>
Date: Fri, 14 Aug 2026 14:30:19 +0200
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
Subject: Re: [PATCH] powerpc/ptrace: Add offsetof check for exit_flags in
 pt_regs_check()
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 mkchauras@linux.ibm.com, sshegde@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260703074948.1668744-1-mkchauras@gmail.com>
 <20260703134456.2d291388-8b-amachhiw@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260703134456.2d291388-8b-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/07/2026 à 10:55, Amit Machhiwal a écrit :
> On 2026/07/03 01:19 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
>> pt_regs_check() verifies that fields shared between struct pt_regs and
>> struct user_pt_regs sit at the same offset, to catch any accidental
>> layout divergence between the kernel and uapi structures.
>>
>> Add the missing check for exit_flags, following the same pattern as the
>> existing checks for result, dsisr, dar and the other shared fields.
>>
>> Fixes: d7a6797e0bc1 ("powerpc: add exit_flags field in pt_regs")

This commit was almost reverted by commit 263e5159e00a ("powerpc: Fix 
exit_flags field placement in pt_regs for ptrace")

Dropping this patch.

Christophe

> 
> You may want to add below in order to get this patch backported:
> 
>    Cc: stable@vger.kernel.org
> 
>> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
>> ---
>>   arch/powerpc/kernel/ptrace/ptrace.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
>> index 316d4f5ead8e..fb3fec73f66a 100644
>> --- a/arch/powerpc/kernel/ptrace/ptrace.c
>> +++ b/arch/powerpc/kernel/ptrace/ptrace.c
>> @@ -235,6 +235,8 @@ void __init pt_regs_check(void)
>>   		     offsetof(struct user_pt_regs, dsisr));
>>   	BUILD_BUG_ON(offsetof(struct pt_regs, result) !=
>>   		     offsetof(struct user_pt_regs, result));
>> +	BUILD_BUG_ON(offsetof(struct pt_regs, exit_flags) !=
>> +		     offsetof(struct user_pt_regs, exit_flags));
> 
> At first, it appeared to be redundant as we already check
> 
> 	CHECK_REG(PT_EXIT_FLAGS, exit_flags);
> 
> which expands to:
> 
> 	#define CHECK_REG(_pt, _reg) \
> 		BUILD_BUG_ON(_pt != (offsetof(struct user_pt_regs, _reg) / \
> 				     sizeof(unsigned long)));
> 
> But looking closely, it turns out to be non-redundant. CHECK_REG only
> touches struct user_pt_regs — it validates the PT_EXIT_FLAGS constant
> against the uapi layout. It says nothing about struct pt_regs.
> 
> struct pt_regs (asm/ptrace.h) embeds struct user_pt_regs in a union
> alongside an anonymous struct that re-declares all the same fields with
> kernel-internal aliases (dear/dar, esr/dsisr). exit_flags lives in that
> anonymous struct. A field accidentally inserted there between result and
> exit_flags would silently break the union aliasing without CHECK_REG
> catching it. The new BUILD_BUG_ON closes that gap, consistent with how
> result, dar and dsisr are already protected in the same block.
> 
> Looks good to me.
> 
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> 
> Thanks,
> Amit
> 
>>   
>>   	BUILD_BUG_ON(sizeof(struct user_pt_regs) > sizeof(struct pt_regs));
>>   
>> -- 
>> 2.55.0
>>
>>


