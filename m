Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C5606A33B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZJ9SvEV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYrNn1t3Kz2yCP;
	Wed, 25 Nov 2026 05:06:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795543609;
	cv=none; b=GdwKYFfh2673auGVSeiTA0fP0CPGEHEYBf1W6/ca1YPfvU56TCIbD9L4D+C1kOxhgaR4rUEqmSVFSTGuKHVTt2m1VyaT+uoFCy0q5dHxmyCVMC9UVnOiqz2jtALPKXn3sY5tPM7LU8jusoJgaLisgogA6pDhmM16ccHbaeOGiUCRdGUcfzS7fgW+LtFBkZxupt8+vRk40OaMn8ybMoeXvt3q9Sdj1AtGxxoAM8GZBlgLaik1px9GPZN0yn+0pEBSGkV+vWpA6MuOkopAadwjzHJ22oNbVr13q63MCArGd6i3zr7fSVnllEx7z4mjP2QczCGeM7FLm26eCXJZO0+wnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795543609; c=relaxed/relaxed;
	bh=Ayu9SEcoBtFGFpQCxXBxKliDMZcD8hThryx7/0AgLn0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d0aQXvm8uNwjH2kgYU3fFkphimTZEziAtrKzg8Iab8/ByLEaHdfcfyMPvx8nHIJJYPwyrmcB5h3LVw/cbYNqpH/WBBoA2KOqd0kIVL9RZb2sLN66KqPRMxjJEZXmYhrXQapFWw3Eeo9GIl0m6zsoLc+ojbYE7CbjiI5NARAptytHMBqL/NR+28yjGMBuVjB/IXEItWf2hN740Y2c2uQSqT1S9KfJAMojSy8R15h82I6yEIqy7RwUTIbvinCMpmv0mzkd4zWRkT60q+O4Q+KZT/gbdzWGF4dN3R5Uktl+PUC0g0jumb7MowX0mYV0nGkoe/Ulz8sC0/0oGYQnmySN2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZJ9SvEV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZJ9SvEV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYrNl738Vz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 05:06:47 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3C8566288C;
	Tue, 24 Nov 2026 18:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD2A1F000C6;
	Tue, 24 Nov 2026 18:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795543604;
	bh=Ayu9SEcoBtFGFpQCxXBxKliDMZcD8hThryx7/0AgLn0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=YZJ9SvEVHpWB/muhj0erDmHHkEyYzXupbkj5FyL1SoAkDPx5zISPe2dQ+RCXLZXSZ
	 K+EON/U/z8Y7hFYxQhHcnuBJPY1FQ0vSY0A1h7LR3KlYek83bdedqnN9iM0PaSoLNW
	 I9nOUQj/+86idCcCIpeZKy2H7NULtxMpAfD9YWH1RoGJoXvmal7TnZCqW19corwV+/
	 BSfJDsZFxbLGQYN/Qqk0/S3+93S6/8L6tktvWe462Ca4ucBq2BzKny1Qyw6wx5gZwN
	 Aan+FaGBeqQrHTrDhZ1LxvWldPx98iHtpwz21zlDEGOcXS0gFyS2oagZTOpgO6IuyD
	 BlpaOJHUK9pSA==
Message-ID: <5ab4fc02-b15b-4989-a92d-3e053e89ce51@kernel.org>
Date: Tue, 24 Nov 2026 19:06:39 +0100
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
Subject: Re: [PATCH] macintosh/smu: Fix BCD encoding of the RTC month
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Thorsten Blum <blum@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
References: <20261124132342.235824-2-blum@kernel.org>
 <e77c95c4-a01a-4d61-b137-509d72b8d7ed@kernel.org>
Content-Language: fr-FR
In-Reply-To: <e77c95c4-a01a-4d61-b137-509d72b8d7ed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 24/11/2026 à 16:46, Christophe Leroy (CS GROUP) a écrit :
> 
> 
> Le 24/11/2026 à 14:23, Thorsten Blum a écrit :
>> The SMU expects a one-based month encoded as BCD, while tm_mon is
>> zero-based. Adding 1 after converting tm_mon to BCD incorrectly encodes
>> October as 0x0a instead of 0x10.
>>
>> Add 1 to tm_mon before converting it to BCD.
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

The real origin is commit faa5ee3743ff ("[PATCH] ppc64: Add basic 
support for the SMU chip in iMac G5")

Found on repository https://github.com/mpe/linux-fullhistory.git

>> Signed-off-by: Thorsten Blum <blum@kernel.org>
> 
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> 
>> ---
>>   drivers/macintosh/smu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
>> index c463760710b6..fb93094ff608 100644
>> --- a/drivers/macintosh/smu.c
>> +++ b/drivers/macintosh/smu.c
>> @@ -374,7 +374,7 @@ static inline void smu_fill_set_rtc_cmd(struct 
>> smu_cmd_buf *cmd_buf,
>>       cmd_buf->data[3] = hex2bcd(time->tm_hour);
>>       cmd_buf->data[4] = time->tm_wday;
>>       cmd_buf->data[5] = hex2bcd(time->tm_mday);
>> -    cmd_buf->data[6] = hex2bcd(time->tm_mon) + 1;
>> +    cmd_buf->data[6] = hex2bcd(time->tm_mon + 1);
>>       cmd_buf->data[7] = hex2bcd(time->tm_year - 100);
>>   }
>> @@ -421,7 +421,7 @@ int smu_set_rtc_time(struct rtc_time *time, int 
>> spinwait)
>>                     hex2bcd(time->tm_hour),
>>                     time->tm_wday,
>>                     hex2bcd(time->tm_mday),
>> -                  hex2bcd(time->tm_mon) + 1,
>> +                  hex2bcd(time->tm_mon + 1),
>>                     hex2bcd(time->tm_year - 100));
>>       if (rc)
>>           return rc;
> 


