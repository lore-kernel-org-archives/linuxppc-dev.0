Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E7606A326
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A8an7A/F
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLjRC0lvJz2xJR;
	Sat, 07 Nov 2026 02:15:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::38"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793978119;
	cv=none; b=cVh0sxOY5Oq2hLIP0mRb7OvQbSnO+TeryMkV2kJWv1PrpcPJVrj81jvnkuWZ+jSsrk71KlxSlqbZMb+snlsOpyq1RmzA+EiL5qdMHXoP8FAun+xwMJMx7qc1EXHDUUMzGCguFnili0YELDjmhLEalE2hcvAjYAvVOccPGCmDr/jVlcReDgiEmzRFvYjWzxvXjuJUsEjbq3EPP82CjW7z9ozeMXl48QYbCllrPRTsMx23ESe0RxsPpg4CtNLRYgIqP8oIlRh1S9X8++TYi23Xin3g7a1D8Ps0p9xI47q61rDdRQuaVmC+rWbHhHlyA3PIHPVAZdEmTlFt+zjbghJQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793978119; c=relaxed/relaxed;
	bh=I3wp7qZYECIMcLIbecPScf0AL3+m3VhUgC3UInyHpmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VT3EjQu8fR0khjEPKuuD+BtX8UsZE5BPv8KPxFyj4K/6dO+CH3wyJBf6klR+dFpAz+C3ApoGj3DzaIMLxGBOX9absqGxL27RfGlskPTZUngDZi5pWc+Oc0oGtp00X+Fwh4kbb0h3fvaf04P/C1UdeWDJ6DQFANWR2sDSLobPj4xFXuo3O3OF+yKKECiLABfXfg+hSt45tETFD+ltU/z6H2itKje3KvV46LxTGPsKYOjHWCHhhXD4AqBPrjbI+xEcFr3ZiI9AfXMg6fDfFSeDYm+1sw3s5yH7dpzhIEgLh94TyOx4+WpB4YVjQIMioE6a4TPWPb1m87e76sT/y7SA0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A8an7A/F; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::38; helo=mta1.migadu.com; envelope-from=luiz.capitulino@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A8an7A/F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::38; helo=mta1.migadu.com; envelope-from=luiz.capitulino@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 79 seconds by postgrey-1.37 at boromir; Sat, 07 Nov 2026 02:15:14 AEDT
Received: from mta1.migadu.com (out-56.mta1.migadu.com [IPv6:2001:41d0:203:375::38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLjR60CDBz2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 02:15:13 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=S98NWqfawDspOLsHyYFeHgv0i8tOS6SEV87Z5cSSl7k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793978096; v=1; x=1794582896;
 b=A8an7A/FxpUWZhYzd4S7XhbsJkHfsb8sONDZYAm00lhfJDSouVIyIHL2IWgmF8ZnVG1rXctR
 DjGYIAao1dpK90AX9Q12ououRZLhI18JJmifBP/LKqr5NuRhrdHMWDGnv4DAv2OcS2xpkJfiC+o
 fErx9Ni4nZFsk7mXVfJoQE2I=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id bad491a0b969e37d;
	Fri, 06 Nov 2026 15:13:32 +0000
X-Mizu-Trace-ID: bad491a0b969e37d
X-Migadu-Flow: FLOW_OUT
Message-ID: <cb06b1b9-fed4-4071-964d-90ae44803440@linux.dev>
Date: Fri, 6 Nov 2026 10:13:26 -0500
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
Subject: Re: [PATCH] powerpc/watchdog: disable watchdog when watchdog_thresh=0
To: Michael Ellerman <mpe@tenstorrent.com>, maddy@linux.ibm.com,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org
Cc: chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20261104034018.2676750-1-luiz.capitulino@linux.dev>
 <9fada7bf-11b5-45b6-858d-4c6b79d6a507@kernel.org>
Content-Language: en-US
From: "Luiz Capitulino (Red Hat)" <luiz.capitulino@linux.dev>
In-Reply-To: <9fada7bf-11b5-45b6-858d-4c6b79d6a507@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/6/26 5:26 AM, Michael Ellerman wrote:
> On 4/11/26 2:40 pm, Luiz Capitulino (Red Hat) wrote:
>> On powerpc, trying to disable the hardlockup detector with:
>>
>>   # echo 0 > /proc/sys/kernel/watchdog_thresh
>>
>> causes an immediate and endless hardlockup detection, eventually leading
>> to an unusable system (splat example below).
> 
> ...
>> This condition is already checked in __lockup_detector_reconfigure() for
>> the soft lockup detector and the arch-independent hardlockup detector,
>> what's missing is powerpc performing the same check in start_watchdog().
> 
> Arguably setting watchdog_thresh to 0 should mean watchdog_enabled becomes false.
> Then there wouldn't need to be extra checks for thresh == 0 anywhere.
> 
> But if the existing code already checks for thresh == 0 then this is fine.

Yes, the common code in kernel/watchdog.c actually checks for both.

Thanks for the review.

> 
>> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Luiz Capitulino (Red Hat) <luiz.capitulino@linux.dev>
>> ---
>> Notes:
>> - This issue was not discovered by AI. We have a new test-case in our CI that
>>    sets watchdog_thresh=0, when running on powerpc we get the described issue
>> - This issue was initially reproduced on Power10, but I developed the fix
>>    on Power9 (which is what I have access now)
>>
>>   arch/powerpc/kernel/watchdog.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
>> index 582ee3fd71c1..44f178e07531 100644
>> --- a/arch/powerpc/kernel/watchdog.c
>> +++ b/arch/powerpc/kernel/watchdog.c
>> @@ -487,6 +487,9 @@ static void start_watchdog(void *arg)
>>       if (!(watchdog_enabled & WATCHDOG_HARDLOCKUP_ENABLED))
>>           return;
>> +    if (!watchdog_thresh)
>> +        return;
>> +
>>       if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
>>           return;
> 
> 
> Fix looks good to me.
> 
> Reviewed-by: Michael Ellerman <mpe@kernel.org>
> 
> cheers

