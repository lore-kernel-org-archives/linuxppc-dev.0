Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A44606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D6Fh9qWC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXzWn1L7rz2xyj;
	Mon, 23 Nov 2026 19:24:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::67"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795422293;
	cv=none; b=hLYkktkw2XMfGmytqTsdpu6ycYluDdmOvDFGehyREDtXQ6D/I6VZ5/BQu73DCyhB/p3+EoJeMqbmkcZZn9MCvfAKFA6mfUyoCbq8UbcMvTdHwrval9vo4srgA2mUIzmQHpuVC4OMkPRE+jeBRv14jrSUhhVV8GIbzoi0V+h7p6Zdq3er9wW1rLXsQFU2zhY1rYj8Usq35aOKh3E+DDiWerFCacfpjj8VpDy6QP240hTNwdAsGvwqTNqVZGsSf5BiuTtxG2l9Gdu74tZDBuq+eEcG+k6OHZjn78tdHmCII5nL+03GBP8tNU9J+SFESJ+eC/xAp6yc0MRoZ0DrZnjtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795422293; c=relaxed/relaxed;
	bh=IQO4tn0OyPdxMhtPAGNESRuXYu8NbrwjcIpFVzP0og8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNdSnGE9AAsi9aeexCmaIHBMRHXjNGCd4KhRSK8BhASgYF3YC6Bkn0VhORU5QAbM+6Syo+iNN8iRFp7+SoAyC3sGMUaIx05NickvlvPgGh05L8SdkXHqJDDlGTXxlo0lF0pu2jsG0uvs8DsbRKAhTYcHlKXyX5G04KHSe5vFvGY+9gbZBEFfw8cr/he6vZ9JfYKnYCVqi7dwZpj57LVPyYiC09zj25rJUpnwxLf0V6gb+RkLan+aRUF10tXKYXMTAsbUhcWAWXJ4oS6GX6faLLd2us00SnuUl0o3DlTxkLWTryU3cYL4v7gnB7f3gydLsrp9BUxc14b9wywude6YuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D6Fh9qWC; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::67; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D6Fh9qWC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::67; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-103.mta1.migadu.com [IPv6:2001:41d0:203:375::67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXzWk31Svz2xQD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 19:24:48 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=HSUyFp+EYllNTrLsXxEGxRMBuqpbPPoIyuQ1COVxKsE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795422270; v=1; x=1796027070;
 b=D6Fh9qWCPEswhAg5emIFm6DBkMe74EM6ay3Mi3HuZUBJNeGqHpWo2PZ+RBhuA+TCw7/pdfYM
 fNbX7Sep8iwoCOQFiu1FXC9I/doZUWoDJV2AXczIR6+kywooOFjb3+eDPROR5/ViWJePvPi3DFO
 GXwYoS62jRK5yXqQteoZ2vmM=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 4f28e3a27007a1d5;
	Mon, 23 Nov 2026 08:24:29 +0000
X-Mizu-Trace-ID: 4f28e3a27007a1d5
X-Migadu-Flow: FLOW_OUT
Message-ID: <1e7d39f1-382c-49e2-b3ae-935f25b22a57@linux.dev>
Date: Mon, 23 Nov 2026 16:24:23 +0800
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
Subject: Re: [PATCH v5 04/11] mm/vmalloc: reject an unaligned range in
 __vunmap_range_noflush()
To: Suren Baghdasaryan <surenb@google.com>, Dev Jain <dev.jain@arm.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
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
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-5-hao.ge@linux.dev>
 <4c233641-15ad-4e5a-a106-423bc31f357c@arm.com>
 <CAJuCfpG5shRGvjHJyEOveSxkPE=x7nGTo4xmy0XLabV7NutrMQ@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpG5shRGvjHJyEOveSxkPE=x7nGTo4xmy0XLabV7NutrMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Suren and Dev

On 2026/11/21 06:13, Suren Baghdasaryan wrote:
> On Tue, Nov 17, 2026 at 6:05 AM Dev Jain <dev.jain@arm.com> wrote:
>>
>>
>>
>> On 16/11/26 12:43 pm, Hao Ge wrote:
>>> The PTE loop stops only at addr == end. An unaligned end is never
>>> reached, so the loop keeps clearing past the range. An unaligned
>>> start clears the page below the range first. Both are caller bugs,
>>> and the damage is hard to attribute afterwards.
>>>
>>> vmap only installs page aligned mappings, so an unaligned unmap
>>> request is never a legitimate teardown. Warn and bail out at the
>>> entry of __vunmap_range_noflush(), before any PTE is cleared.
>>>
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Closes: https://lore.kernel.org/all/sashiko-outbox-178439@kernel.org/
>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>> ---
>>>  mm/vmalloc.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index a168f6f20f4f..e2b63cb1592b 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -523,6 +523,9 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end,
>>>       pgtbl_mod_mask mask = 0;
>>>
>>>       BUG_ON(addr >= end);
>>
>> Nit: It is usually a practice to change the existing BUG_ON's to
>> WARN_ON's too, if you are changing around that part.

Ack.

>>
>>
>>> +     if (WARN_ON_ONCE(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end)))
>>> +             return;
> 
> nit: It's also better not to combine multiple conditions into one
> warning so that the generated report clearly shows which condition
> (code line) caused the warning. IOW:

Ack on applying the same to the previous patch in the series, "mm/vmalloc:
reject an unaligned range in vmap_page_range()", as well, it is done the
same way there now.  

Thanks
Best Regards
Hao

> 
> if (WARN_ON_ONCE(!PAGE_ALIGNED(addr))
>         return;
> 
> if (WARN_ON_ONCE(!PAGE_ALIGNED(end))
>         return;
> 
> 
>>
>> Reviewed-by: Dev Jain <dev.jain@arm.com>
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> 
>>
>>> +
>>>       pgd = pgd_offset_k(addr);
>>>       do {
>>>               next = pgd_addr_end(addr, end);
>>

