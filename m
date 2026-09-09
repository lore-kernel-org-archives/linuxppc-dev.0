Return-Path: <linuxppc-dev+bounces-26904-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D946C79FB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:57:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvnS4YH4z2yrL;
	Wed, 09 Sep 2026 18:57:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788944220;
	cv=none; b=aoAJLJBrOoJw3lYz/2BJQOVrPO5P3uPbaFh35IvlW5wL+yj8hJK5Y2Ei2Ps8HQ7/ervkNJ5z/ZWRIGMB6B2BQQ/HIqlcSJM+lUf5cCUgRNBrG6VHddNG0XhxP7dZeVKs+emIUpC3YUYw1IIw1kCml7Of3iWr8gU3Nny/Seg4iINc0m3Vmixi+5hKpafCQaHmaO9pixk2R0AyMh1yO+2020Tw7+qXGADlEh1UO5dcF9FSPv1tKbImUzTeWWpvzxIqlP0RUu0UgpAc1dA9nVcjrEIIVNcGD8ELaldIfwZye3/uNCdBGQQqS5iZVZ8ppySYY5lJ+VbIITXxUSAzSoRoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788944220; c=relaxed/relaxed;
	bh=84+nBQDm+o+S8DfCJAt/wL5E7ITLnnU0M/9KT4DLzOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaM8fs7Yjh+lTCK9I6G/lW73fEBCcj5cqoBdZSczG+20grKDRu/2byyiPEMtwAbicN2bKF9KeZLKDZVriPfJmTC+HZqTJ6wPCAuVBBzXfGk4rlBLGOtsjoFeKg4nzN3T03vLWkq3PltYSWLq7sF7qUqf5VJRTk3t+3xAJrTGwy+JI2G3x/cUjp/5iVHndrCT42NUIiiyqD8WzU8vI35v48Z/mRsB3ZrBw1T2FTM0LwEaH7GpcpITB9Q7Vkm+2tItHyQpBbqCgew0PEQkSfKWGb7srm7m9xirsVQ2syjyvVLG6IHE+AbeI27JEsRCnXiTfWMideukaV8CQGRrBidiMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbRTmd/g; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PbRTmd/g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvnR1CWPz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:56:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 271F96020C;
	Wed,  9 Sep 2026 08:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7B01F00A3A;
	Wed,  9 Sep 2026 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944215;
	bh=84+nBQDm+o+S8DfCJAt/wL5E7ITLnnU0M/9KT4DLzOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PbRTmd/gF2NsVAfbYrHPMTKkJ8cDe6j3PXtfVM9QxKPaSxDrgCza896pxXE+c02g5
	 UvAM/+cp9d3Bsb6WzKP8ng3m2uU3oao9lZxs36YrbB7tDRwwFuthV04n5evM3vv0HW
	 qfOLnV4p51IdokO9+nvDP5hy5Fuih4yzlufjlqe98ZCPyfy5zxElMP+sRu3ivAKKl/
	 dLGi26urGTgGuGVbr2ghLFkO7uRUlSIG75WH5vVybx1431cPayjOSZRU7/TeDDtbUp
	 P0rgRik3OqN8Pp1wMthSmFQBnqBdykrhHzQ/BI98RXH+nYUW9LrRTUD2gkj/FcHXGu
	 f8TkQr60PgOVQ==
Message-ID: <d80d892c-8505-4530-a23f-e3b6daf72d03@kernel.org>
Date: Wed, 9 Sep 2026 10:56:49 +0200
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
Subject: Re: [PATCH] selftests/powerpc/tm: Fix tcheck() reading uninitialised
 CR value
To: Venkat <venkat88@linux.ibm.com>,
 Thibault Ferrante <thibault.ferrante@canonical.com>
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260907215420.1258678-1-thibault.ferrante@canonical.com>
 <4206CE63-979B-4464-BECE-F89D0B1BDC91@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <4206CE63-979B-4464-BECE-F89D0B1BDC91@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 09/09/2026 à 07:28, Venkat a écrit :
> 
> 
>> On 8 Sep 2026, at 3:24 AM, Thibault Ferrante <thibault.ferrante@canonical.com> wrote:
>>
>> tcheck() is used to check the current transaction state (active,
>> suspended, doomed) via the "tcheck" instruction, which writes its
>> result into CR field 0. The inline asm declared a GPR output operand
>> for this result but never actually moved the CR into it.
>>
>> Every caller (tcheck_doomed(), tcheck_active(), tcheck_suspended(),
>> tcheck_transactional()) has effectively been testing bits of an unrelated,
>> arbitrary register value since this helper was introduced.
>> The "& 4" mask discards the TDOOMED and TS_lsb (suspended) bits before
>> they ever reach the callers, so tcheck_doomed() and tcheck_suspended()
>> can never return true, and tcheck_transactional() degrades to being
>> equivalent to tcheck_active().
>>
>> Fix tcheck() to actually move CR into the output register with mfcr,
>> and widen the mask from "& 4" to "& 0xf" so the full CR0 nibble
>> (TDOOMED | TS_msb | TS_lsb | reserved) is preserved for the callers.
>>
>> This bug has been present since tcheck() was introduced.
>>
>> Link: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugs.launchpad.net%2Fbugs%2F2107442&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C4805edfd01004fae88bf08df0e334066%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639245285430142903%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=ho9uy5Jyj7SnKtiSZibCDfMR22FhBIuUSkgmguhENts%3D&reserved=0
>> Fixes: 8e03bd4e70b6 ("selftests/powerpc: Add TM tcheck helpers in C")
>> Signed-off-by: Thibault Ferrante <thibault.ferrante@canonical.com>
>> ---
> 
>> tools/testing/selftests/powerpc/tm/tm.h | 8 ++++++--
>> 1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
>> index c03c6e778876..6024ce4ba6ff 100644
>> --- a/tools/testing/selftests/powerpc/tm/tm.h
>> +++ b/tools/testing/selftests/powerpc/tm/tm.h
>> @@ -105,8 +105,12 @@ static inline bool failure_is_nesting(void)
>> static inline int tcheck(void)
>> {
>> long cr;
>> - asm volatile ("tcheck 0" : "=r"(cr) : : "cr0");
>> - return (cr >> 28) & 4;
>> + asm volatile("tcheck 0;"

Why not use cr7 instead of using cr0 and doing cr >> 28 below ?

>> +     "mfcr %0;"
>> +     : "=r"(cr)
>> +     :
>> +     : "cr0");
>> + return (cr >> 28) & 0xf;
>> }
>>
>> static inline bool tcheck_doomed(void)
>> -- 
>> 2.55.0
>>
> 


