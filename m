Return-Path: <linuxppc-dev+bounces-21389-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04707CD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 12:06:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMPBq49Pnz2xc2;
	Fri, 22 May 2026 22:06:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779451587;
	cv=none; b=kgEcQlp75E7Inc8+MZyIS3921fmX/CejJrCocg8zNZQMBZMpmKfofbSU+lkn6wog48QPwFQP5diboIkQsUQdnWqLVdRM/SpENrh3h/M8aA4QtsOJVFBksnjWHlrSIF1hdcpok9PPTgSRem3mlpX/YBt9ecKNKjRI/SKcgB1O8k3uXMoLcQz0SIyCrhSptSnibMV8txun0Aj9ngdXg4+vTte9eBT8y5fXNoi7kZ1olV4L5cF/EfaZRmjGToIwHxEku0/9VPOgSs4ZhsqoyMdCpUo7wlYpS+IXBwp2fKs9fXmcqH8Dam8XymsS68zaPKZI6TxhIJ0LtOla3xZCzZgDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779451587; c=relaxed/relaxed;
	bh=pQzQXIeWjqMa7IdV0rzy8ubj80MUX330eW83hx0Vygo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0M7oRImt8858AOVqCDKTckQDukiu3IV/AWDyRprdoAjHLrPAbTccehD0kEda723oN5nrREgPe+wnWKcTYuwfI317KqEqWKBkkzMnoe1G/F2bWDcFHsPgLUvEwMHrJyU2cPAr+H37qP050A4Sv66wmY9Qh3YtxHe3mjJV/2E8VchP5/w6GEwXqBYoYm4jHN/yuqSf+4w/ssmgDk96NmVVOBD5TvVSD+Rb72xSXywgpuQ7HYDQyMXmTsVnbQHPo7E+VHRuX1DVtFrh8CqJurHHdrggCdA4K5Mmchgp0Gw1Z8bJ0jIS4aM+APGdHwoBErSxmWlHSPWvK7/RM2vWhAXqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4Ldrqsg; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4Ldrqsg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMPBh5gHQz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 22:06:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3AB29601E8;
	Fri, 22 May 2026 12:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A39B1F000E9;
	Fri, 22 May 2026 12:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779451577;
	bh=pQzQXIeWjqMa7IdV0rzy8ubj80MUX330eW83hx0Vygo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y4LdrqsgyjpT87kj8en2m2OcJ4MCvQzbnjFl5kqoHqXQhCZMvoVcOI9mDiQecygNC
	 5E55GshJMV5eDnF9crkZ+vbliyzKiJmE4lYikj2/u0LCIWaiDY61FKeezxoA0XknZ1
	 JcPfAiVuCUWgTkbRBKGa5p73Z0lkx4W+jkfhYKjXOQmbPuuCkcPXEb3kymEypPdYFj
	 Ow/FvA16OBgS7XV66KVay95kY8s7lzmR/5JEFmJsBmO+VUI6i4KmN01jZ4e/GCLGiH
	 uJv1QEm3dk7UCLyLov6Kox4Urf+ORRT/yorXDCp4lmwAR17Sw4MJNiv51Pw7b/45/E
	 VVJdXXsYN2SrA==
Message-ID: <69bd69b1-97f7-41e2-934b-bed28dc2fef7@kernel.org>
Date: Fri, 22 May 2026 14:06:14 +0200
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
Subject: Re: [PATCH v1 2/8] powerpc/signal64: Untangle setup_tm_sigcontexts()
 and user_access_begin()
To: David Laight <david.laight.linux@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1779441786.git.chleroy@kernel.org>
 <7c83fe5a596514a02fde37da987a48d638d0d097.1779441786.git.chleroy@kernel.org>
 <20260522121237.3089276f@pumpkin>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260522121237.3089276f@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/05/2026 à 13:12, David Laight a écrit :
> On Fri, 22 May 2026 11:56:02 +0200
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:
> 
>> Call setup_tm_sigcontexts() before opening user access to avoid
>> having to close and open again.
>>
>> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>> ---
>>   arch/powerpc/kernel/signal_64.c | 22 +++++++++-------------
>>   1 file changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
>> index 86bb5bb4c143..3849af21e1d8 100644
>> --- a/arch/powerpc/kernel/signal_64.c
>> +++ b/arch/powerpc/kernel/signal_64.c
>> @@ -873,6 +873,15 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
>>   	if (!MSR_TM_ACTIVE(msr))
>>   		prepare_setup_sigcontext(tsk);
>>   
>> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>> +	if (MSR_TM_ACTIVE(msr))
> 
> Can't that be done without the ugly #ifdef?
> I assume MSR_TM_ACTIVE() will be zero - so it will all get optimised away.

Yes but struct rt_sigframe field uc_transact only exists when 
CONFIG_PPC_TRANSACTIONAL_MEM is defined.

And that would also require a stub setup_tm_sigcontexts()

Chistophe

> 
> -- David
> 
>> +		err |= setup_tm_sigcontexts(&frame->uc.uc_mcontext,
>> +					    &frame->uc_transact.uc_mcontext,
>> +					    tsk, ksig->sig, NULL,
>> +					    (unsigned long)ksig->ka.sa.sa_handler,
>> +					    msr);
>> +
>> +#endif
>>   	if (!user_write_access_begin(frame, sizeof(*frame)))
>>   		goto badframe;
>>   
>> @@ -889,19 +898,6 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
>>   		 * ucontext_t (for transactional state) with its uc_link ptr.
>>   		 */
>>   		unsafe_put_user(&frame->uc_transact, &frame->uc.uc_link, badframe_block);
>> -
>> -		user_write_access_end();
>> -
>> -		err |= setup_tm_sigcontexts(&frame->uc.uc_mcontext,
>> -					    &frame->uc_transact.uc_mcontext,
>> -					    tsk, ksig->sig, NULL,
>> -					    (unsigned long)ksig->ka.sa.sa_handler,
>> -					    msr);
>> -
>> -		if (!user_write_access_begin(&frame->uc.uc_sigmask,
>> -					     sizeof(frame->uc.uc_sigmask)))
>> -			goto badframe;
>> -
>>   #endif
>>   	} else {
>>   		unsafe_put_user(0, &frame->uc.uc_link, badframe_block);
> 


