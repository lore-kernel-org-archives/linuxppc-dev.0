Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654D6606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijLedmC4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSs320Ppdz2xL5;
	Tue, 17 Nov 2026 02:19:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794842349;
	cv=none; b=MMoIWKox3XDmqqBbbJV8ecTQNzh3LgG2dhIXiFqE/YqjiDHN26VsWxet15J9qxeUJup1W71nH7xuBr/rqHz6hxEHkez4IAAJk6yV8s7s5eLMfxg5kvMm/3NGWt0HHWKKXjnStVb0J9vOI+Ih64KqW1F1IzJYJpXMV3yLY0klJ5bNKqMR4+Dh/YafkuvoWpwa/wxL2DFAJFpwRpY+Bj1VXJ3c34o2COHRwla4w84MdBebBfRD4J7Si769PUopD4NQa/sf8Ep/sWN9OmqQsjRGPgUjh8UBydyPQaZnkBOWM+DwhlxQ51NBwMSe/vZCHuWDWpGyESagCcxskRQLkRcsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794842349; c=relaxed/relaxed;
	bh=/p62E+DsKjzO1De2gJ8rQ5MNrD/NGRcm69PVIh9Cv50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfyfjyG6Xkxjxx4wlrrWJk4KJOhGmRJzwWLTWS6ZYwUVVBGZ2wr4jyWW2omWERofut0s7JVbVB/M6XAGMVCnXNu/g7Y1c2J4PKDo6wXvopSvUeigXkGt3vC66VY6CevMyoRS70eALfpgZAM/eEWYDsZICFBNjwJlPZZw+ks5fY0TBBbaTqaZB5epi0abgWsO5bobOo8hmEPcR+P6byeyQRISPPKKFSlPRy3Gk0jGW2dYnhrrJMelc1toW3wTr++jlKSMs8v58AQ9dlhwrLiMlMMd9AwMRLVJyx0w2VZ5nI7Hu+PlW9QDtfe5nLIT7HnrdjRfObNmxYaHVQiHyLaO4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijLedmC4; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijLedmC4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSs311H3Rz2xL3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 02:19:09 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C0E526062F;
	Mon, 16 Nov 2026 15:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347121F000C5;
	Mon, 16 Nov 2026 15:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794842346;
	bh=/p62E+DsKjzO1De2gJ8rQ5MNrD/NGRcm69PVIh9Cv50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ijLedmC4e/AV4AikvMBJden6BFBPZQls+wJGdv+EStcb3m5+CTqQeb822zSStxKbo
	 smU+pjbuacxEvPOJGcadkFo9qZLRJInmE5dYZpk8Qdo7Ha62R0/Byn7t5PJiAuzXNN
	 uEFTvnRFYp9NoA2KOVBWcVUYyWgF8azlq28jXRFDXsaZN5QYOeE3jeikXZIoOOyIVx
	 59pvx+jG8IGxCBc5qgqflb1sZkO7EPWfGBDsKwUa/zOTDc4YfEKXVp/iowKpup44px
	 tI/RNDg2wNig/cWxqAb6TRa6+Dall1tZTOFoAvyqWZSukBw14c3RpGXoWcbVZl/TQw
	 4GEnixsjMWgrw==
Message-ID: <120f301f-5359-4f56-8b21-87ef6470ffa4@kernel.org>
Date: Mon, 16 Nov 2026 16:19:01 +0100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/32: Use HAVE_PREEMPT_DYNAMIC_CALL instead of
 HAVE_PREEMPT_DYNAMIC_KEY
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <d26da63caddc52de7894c763304ec7ecb23909a8.1781866685.git.chleroy@kernel.org>
 <763622c4-d2fc-4e84-8474-fdd72a64b5e6@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <763622c4-d2fc-4e84-8474-fdd72a64b5e6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 19/06/2026 à 14:32, Shrikanth Hegde a écrit :
> Hi Christophe.
> 
> On 6/19/26 4:28 PM, Christophe Leroy (CS GROUP) wrote:
>> powerpc/32 has HAVE_STATIC_CALL_INLINE, so
>> HAVE_PREEMPT_DYNAMIC_CALL has to be selected instead of
>> HAVE_PREEMPT_DYNAMIC_KEY for less overhead.
>>
> 
> Do you have any way to quantify this overhead?
> 
> 
>> Fixes: 6ad7751537e8 ("powerpc: enable dynamic preemption")
>> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Finally HAVE_PREEMPT_DYNAMIC_CALL was removed by commit 5b9a28eeed37 
("sched: dynamic: Remove HAVE_PREEMPT_DYNAMIC_{CALL,KEY}").

So droping this patch.

>> ---
>>   arch/powerpc/Kconfig | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 81642206f7de..7475907cef5b 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -281,7 +281,8 @@ config PPC
>>       select HAVE_PERF_EVENTS_NMI        if PPC64
>>       select HAVE_PERF_REGS
>>       select HAVE_PERF_USER_STACK_DUMP
>> -    select HAVE_PREEMPT_DYNAMIC_KEY
>> +    select HAVE_PREEMPT_DYNAMIC_CALL    if PPC32
>> +    select HAVE_PREEMPT_DYNAMIC_KEY        if PPC64
>>       select HAVE_RETHOOK            if KPROBES
>>       select HAVE_REGS_AND_STACK_ACCESS_API
>>       select HAVE_RELIABLE_STACKTRACE
> 
> Patch per se, looks good to me.
> 
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>


