Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505C606A321
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NA+Y8Lq+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQBsq4GqXz2yKn;
	Thu, 12 Nov 2026 18:31:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794468719;
	cv=none; b=IMZTpyTQ+cd7i3Yc/IwXmmagLh4xMKVsMpmjUw5O7DwZrnLBI2zcxdAQf0Yx2kdN8hX51UFKNDK7sfmNuu4U+Ox1D+QSSLgm3GaEjeBfP9e62gMdldqDmOwP8xlKYHMASbAFhrbolMPOT8RUOQp++dO4rfAqlV+oqXdmuOfjPN2+6AKvuzvVq+MTUI6Myrw7f/QziaUKbXQSGp4axZ/EOoj3Csr+LuNOWg2TikS1vuhZu1/D1mmqV5bi+uZdBxAPJGYdajz8gkGwGGn3LrvbCqPZ8vcnbqNzQL/PQdG9nmSWkcrxK2nEJ/ibB1DYQbOK/9LBDMbD/PaYJqo0Cz4S+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794468719; c=relaxed/relaxed;
	bh=YkSv46yCHtIqoXvtaUlGuoA5bkCcyG3dKOTi+O8s+8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTRhqkoWl8W9/3BAHbejfgHdy4MRvQ2Zs6zkoQumR3UvTm/afvFZFkqzz0z5LMPuGOSXNK6Pe0T+re9Mw4jaH6sDCMUisnBM1X6M6EU2BTz37bqXfq4M34wa7t8WQcY3dHviTSpufqnQvoE+TQxeMd4lztTkTAvvDjKj0hxTZMbbxZf4qEgzqAt4wSt2zreAdANzuXea4c/a7Kgd9dd54oGEK/bQ6dxLxhrxflmSn3N/xtcB1asOdMAXTMCS9rKQz2wCv0Wzi69m5a+OM76OPKeUhYzxbiwzanWTtryULZouvxTGRomqR5oCi0S0k0Lv9A/GDvLQ8LQz8qiH1Xk7rA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NA+Y8Lq+; dkim-atps=neutral; spf=pass (client-ip=95.215.58.16; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NA+Y8Lq+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.16; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-16.mta1.migadu.com [95.215.58.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQBsm03ljz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 18:31:54 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=c6rVmPURZ3DT+JjErkgtV1mxI38IznosT0ADdpGxR3o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794468695; v=1; x=1795073495;
 b=NA+Y8Lq+cDGqZtzw4xGR7Z+rYhlYc5kEZj9Wf2Hmn89XoCjPbSUTy0bPCgWjC3gyr6BdN93c
 dC2ocsMaJpeagEvb78VirV/+2BWUhRbdDe7rev1Y9Mb5hCh5YGA1p4FraGwo6qC7NQCIepltXUr
 MfBgol3hXaLgGn6MND2cWhuQ=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 13c0695ddd446293;
	Thu, 12 Nov 2026 07:31:35 +0000
X-Mizu-Trace-ID: 13c0695ddd446293
X-Migadu-Flow: FLOW_OUT
Message-ID: <7df44933-e92e-4f1c-9b26-22a1a298ca16@linux.dev>
Date: Thu, 12 Nov 2026 15:32:58 +0800
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
Subject: Re: [PATCH v4 2/9] mm/kmsan: skip vunmap_range_noflush when KMSAN is
 disabled
To: Suren Baghdasaryan <surenb@google.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20261110112546.261415-1-hao.ge@linux.dev>
 <20261110112546.261415-3-hao.ge@linux.dev>
 <CAJuCfpHneeqRFOXyzCPPPa66xfn7Oa1n5m2N67o_pVwJfNgeXg@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpHneeqRFOXyzCPPPa66xfn7Oa1n5m2N67o_pVwJfNgeXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Suren

On 2026/11/12 06:10, Suren Baghdasaryan wrote:
> On Tue, Nov 10, 2026 at 11:24 AM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> kmsan_vmap_pages_range_noflush() returns 0 when kmsan_enabled is
>> false.  The unmap side does not, so it still walks the shadow and
>> origin page tables even though KMSAN never installed any metadata
>> there.
> 
> Note that KMSAN_WARN_ON() can reset kmsan_enabled flag, so the fact
> that it's false does not mean that metadata was never installed. I
> think a proper bailout should depend on CONFIG_KMSAN, not on
> kmsan_enabled.

Sorry, I did not realize this logic.

I will go through the code again and will probably drop
this patch in the next version.

Thanks
Best Regards
Hao

> 
>>
>> Add the matching early return.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/kmsan/hooks.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
>> index a706666db097..107f66841274 100644
>> --- a/mm/kmsan/hooks.c
>> +++ b/mm/kmsan/hooks.c
>> @@ -138,6 +138,9 @@ static unsigned long vmalloc_origin(unsigned long addr)
>>
>>  void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
>>  {
>> +       if (!kmsan_enabled)
>> +               return;
>> +
>>         __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
>>         __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
>>         flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
>> --
>> 2.25.1
>>

