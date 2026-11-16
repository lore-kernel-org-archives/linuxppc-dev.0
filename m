Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F9606A31F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=b6y5pjZT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSY0k2zSpz2x9N;
	Mon, 16 Nov 2026 14:16:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::c7"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794798966;
	cv=none; b=a+shapllhbW8bCymUzxDeCogLjAn+uBVMFDBww/IJSGnwQ33C6uOru39sumf9aRZNcWJUrodjjzVv88e1D+cYdozBI02NkrQ6WB6ykGDkCZAEpbA9++53xcTZNtqXoJ8V8aIm5ymDQB8L0RPRxXPwh83d+gnOF+EyRaS9h0l6+BwvpUC9jro1542olQVwviyP36bIABguY88nn3vAHN6llWTO0g8XxyH0vSOcUct8Q7Lmc/T5YvCIVLoreO3EJ7p23ho5DIEqg4u7l6VUtR+35pKFqPD9U2AQyhRgs9GcIQbMZrrFgn5qOueJGbgM//aQz9AQf7plzk5a5lYO1+gBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794798966; c=relaxed/relaxed;
	bh=61hA4pI6lWNHs1Ny06AZoS+2gE8bk9pfoV7wwfpwYLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVo0qcDGB/whwrZCz4zgHhUUS2bWvqYn3PAIXdfykHUvjEd9BwCsrODQsjFRd+vkRyBsuMUYssnM64QFTYNIz0l8lwXQ29yGwhkYmt1Uh+Z5mJpVArZ3tLFmPDnyCqUVSA85uYB9ngdRxx/s8yeXn/OuoPezlr4mwhsq1tZvwxPS3deNf0G6jVdjqRkcy+VctODkCg+P5QTjHgmPfKN1a6PhHesIUIp6otgbgIPYomQ5BCHkmrqA50Jjh7nNz2jXIg3mv2l7uGAaSa5TQ8b6EYbcBQIdHhauTKg9/cEBw8x/GKtqPAUMGZIflrMXkz5g8k/W14n9UefjMcxWHTJUGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=b6y5pjZT; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::c7; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=b6y5pjZT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::c7; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-199.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSY0f5HBKz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 14:16:00 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=RUdXcvQAkasOinh1aHVDzx5Sbf8dYEfIHFE+pPtSAf8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794798941; v=1; x=1795403741;
 b=b6y5pjZThx7DYDxGEYNfUyp+U3/xosaEMZmj2dCioSZXgrycZsMsMAUAuW/xB7bHrCC6ul7F
 9ajzKA3pNWSWmGKecb6G6We6VuI02BRbHXYzbgsLhXKuTqXrA9aqLfU8wfztFqNfoahP2KCso1W
 Xp6Tjkb4pnM2yywUCJeoV9ao=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 4346fe518fa13606;
	Mon, 16 Nov 2026 03:15:41 +0000
X-Mizu-Trace-ID: 4346fe518fa13606
X-Migadu-Flow: FLOW_OUT
Message-ID: <5d234178-7799-4603-82bf-40a70101f78a@linux.dev>
Date: Mon, 16 Nov 2026 11:15:24 +0800
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
Subject: Re: [PATCH v4 4/9] mm/vmalloc: BUG_ON() on an unaligned range in
 vmap_pages_range_noflush_walk()
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Dev Jain <dev.jain@arm.com>, Suren Baghdasaryan <surenb@google.com>,
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
 <20261110112546.261415-5-hao.ge@linux.dev> <avWtB-nWZUwLdQdP@milan>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <avWtB-nWZUwLdQdP@milan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ulad

On 2026/11/12 20:11, Uladzislau Rezki wrote:
> On Tue, Nov 10, 2026 at 07:25:41PM +0800, Hao Ge wrote:
>> The pte loop of vmap_pages_pte_range() maps whole pages and stops
>> only when addr lands exactly on end.  An unaligned end lets addr
>> jump over it and the loop keeps mapping into whatever follows the
>> range.  An unaligned start maps the page below the range with its
>> first pte.  That corruption is impossible to debug afterwards, so
>> bug out on addr and end at the entry of
>> vmap_pages_range_noflush_walk().
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/vmalloc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 27f2674a5556..86fbb1d2b27a 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -698,6 +698,8 @@ static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
>>  	pgtbl_mod_mask mask = 0;
>>  
>>  	BUG_ON(addr >= end);
>> +	BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));
>> +
>>
> But why do we add this? We used to live without it and as far i see
> we have not gotten any report about any unaligned addresses un-maping.
> 
> The vmap allocator grantees that va->va_start/end have to be page
> aligned.

You are right that no in-tree caller passes an unaligned range today.
This came about after looking at
commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not PAGE_SIZE aligned").
That commit only guards the ioremap family. vmap_pte_range() is reached
through vmap_page_range() only, so what it protects is ioremap_page_range(),
pci_remap_iospace() and friends, which map physically contiguous ranges.

vmap_pages_range_noflush_walk() has the same loop and serves the other half of the picture,
the virtually contiguous mappings, where the physical pages behind the range do not have to
be contiguous, and since functions like vmap_pages_range() take addr and end from the caller as
they are, the page alignment is the caller's contract in the first place, so this is the same idea
as a739e6b557af and the check just makes that contract visible.

That said, dropping this patch is also fine with me. Nobody can actually trigger it today, as I said at
the beginning, so I will drop it from the next version.

Thanks
Best Regards
Hao

> 
> --
> Uladzislau Rezki

