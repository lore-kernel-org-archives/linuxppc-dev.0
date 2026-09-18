Return-Path: <linuxppc-dev+bounces-27682-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA1DC88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 08:11:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmQLf3HsCz2y2W;
	Fri, 18 Sep 2026 18:11:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789719082;
	cv=none; b=ewIuWEEZEk7wYWPLAjpqmq2UswpZ7xNGB6OhEvCNNHYDQ6jnQ2Nu76JNY7KsocmoAWR0bGk9cDX7k0gyP2i/fpVF3/3j/tiH5GD2JHh6iFskmPKJSjoBfr6QGn8tbuvnIuUMfmK2DqnxtLMNRjbphlp19WN95fZGTXMmbmZIHgd86drzR/yNodfXynrtPkwxccummrhv8VrlFDK5o1eFyk9NIx+i9KK2529RfIIyg8qw1xRRWZLsnguFBncqU+jMfOe7/59zAD153XQYo/7PvQ8UnOWYYz30njlXg3WbHANMzgGW8VPyklH4UkbAndKXu6n3AvRbJJWD1mQyXPf2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789719082; c=relaxed/relaxed;
	bh=JLpvye1bSam9JLtEW3+oCv4l+5hdlWwyZCmpmcxXOCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCy2fs+XremGuc+mqLh7aFOtpSVx3w/IlerJT0MObNEiOlDrL1Fw8ctI+7q12Ue85o5r0RPg4eEt/aOrzhVeuSB93SZGDPBbr8wHg/zRNHZbsClgcGAupZUkt9gmzCCDk3Q3vjmTxr8sahU8OTtV/DxwRQWdgYCdYJoaKwpqHtSEbgx7E1VGuusqAVf05LFPOUBAaTwszs3o/CTQrXMjy6F+MGCPhOQEhByHAH18oHJXf4WRmU40UkcdToGS8uc9LjzTK6PTFm+8KWnF2oVwDsO18mg5NyKPv/2c8rDIPqOmczuQZb3CHp9smJPazDNEJ84Dg3TkJWxDfl2QKBRbng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYDQcaXv; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYDQcaXv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmQLd1Lcvz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 18:11:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C863A43463;
	Fri, 18 Sep 2026 08:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B085B1F000FF;
	Fri, 18 Sep 2026 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789719078;
	bh=JLpvye1bSam9JLtEW3+oCv4l+5hdlWwyZCmpmcxXOCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WYDQcaXvcs44SiduderPMgDzr8eQerfvEh2+HzuSb+sKMKGEZBFzNlPb2rUu1M8ph
	 +fzQKO9fzjJQtSBRi7hiVxMUDxRn8Sya+YACx/sYsV0KYWUFwWQhePDkjxDBCVkAKE
	 DJU69egLvioSnaZj8dNzllIdwmg5YKsxkJhgIW0CFQHfB7hibCSOwESFdnjMSrFvK/
	 zg5nHUQ5PFGa3Jl1bKu3X9FYlvyl/56+eViP3H0Ej0T6T+d2tGvrV5Bp6aY7xaEIW/
	 7eTdD+EfXCKEEfIBJ7tTusvl5lD3z4YciR9iPCG0kTp7J8MXW9poI2snq03Y4RQh9g
	 v4Y1yodW3umTg==
Message-ID: <093ca6ba-5585-40ec-9337-8621c6741d33@kernel.org>
Date: Fri, 18 Sep 2026 10:11:13 +0200
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
Subject: Re: [PATCH] powerpc: remove unused audit_32.h header
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20260918030810.420490-1-enelsonmoore@gmail.com>
 <1f44b5fa-0238-4412-8742-07f17c06cc04@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <1f44b5fa-0238-4412-8742-07f17c06cc04@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Shrikanth,

Le 18/09/2026 à 09:11, Shrikanth Hegde a écrit :
> 
> 
> On 9/18/26 8:38 AM, Ethan Nelson-Moore wrote:
>> The last use of arch/powerpc/kernel/audit_32.h was removed in
>> commit f26ad12356a2 ("powerpc/audit: Convert powerpc to
>> AUDIT_ARCH_COMPAT_GENERIC"), but it was left behind. Remove it.
>>
> 
> Does it need fixes tag, So that it can propagate correctly?

My understanding is that this patch is not a real bug fix so it doesn't 
qualify for -stable trees at the first place. Therefore it shouldn't 
contain a Fixes: tag.

See https://docs.kernel.org/process/stable-kernel-rules.html :

Rules on what kind of patches are accepted, and which ones are not, into 
the “-stable” tree:

     It or an equivalent fix must already exist in Linux mainline 
(upstream).

     It must be obviously correct and tested.

     It cannot be bigger than 100 lines, with context.

     It must follow the Documentation/process/submitting-patches.rst rules.

     It must either fix a real bug that bothers people or just add a 
device ID. To elaborate on the former:

         It fixes a problem like an oops, a hang, data corruption, a 
real security issue, a hardware quirk, a build error (but not for things 
marked CONFIG_BROKEN), or some “oh, that’s not good” issue.

         Serious issues as reported by a user of a distribution kernel 
may also be considered if they fix a notable performance or 
interactivity issue. As these fixes are not as obvious and have a higher 
risk of a subtle regression they should only be submitted by a 
distribution kernel maintainer and include an addendum linking to a 
bugzilla entry if it exists and additional information on the 
user-visible impact.

         No “This could be a problem...” type of things like a 
“theoretical race condition”, unless an explanation of how the bug can 
be exploited is also provided.

         No “trivial” fixes without benefit for users (spelling changes, 
whitespace cleanups, etc).


> 
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
>> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
>> ---
>>   arch/powerpc/kernel/audit_32.h | 7 -------
>>   1 file changed, 7 deletions(-)
>>   delete mode 100644 arch/powerpc/kernel/audit_32.h
>>
>> diff --git a/arch/powerpc/kernel/audit_32.h b/arch/powerpc/kernel/ 
>> audit_32.h
>> deleted file mode 100644
>> index c6c79c3041ab..000000000000
>> --- a/arch/powerpc/kernel/audit_32.h
>> +++ /dev/null
>> @@ -1,7 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -#ifndef __AUDIT_32_H__
>> -#define __AUDIT_32_H__
>> -
>> -extern int ppc32_classify_syscall(unsigned);
>> -
>> -#endif
> 


