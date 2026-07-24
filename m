Return-Path: <linuxppc-dev+bounces-24778-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2710FC531F9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 13:39:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h68HM0w3Xz2yFg;
	Fri, 24 Jul 2026 23:39:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784900383;
	cv=none; b=E1wlb02Aw3MZ62VHDJfkSrBZgTpSnfMnp1gntTj1RAP2uK99Iu8yyojfaZC8VoOWucZ2RJuBcJB7fRyh1JBiO29CFkUqqcGluu36JpbjzpONPaneQQJ23+J+Zo49d5lPf3ToryKDiT6/EyqhdCiKd9d5/DdUXgRtOhOM9wZXA1Ol3chNLRRgPAc5If7CEeU8mqiROnL3hd04OnjwI+/CKaHddlESODW3RsgY84McR8RTojkwaIqMPMbYxWpdXlpHaxMV0T/fIxJmzDVFyhehLOZKngAT/rsWgsEfWjSKi4UFUhESFIzWZTfeHq1GjL6a+2E8mFP0Yo/ISarySzhTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784900383; c=relaxed/relaxed;
	bh=dtkHIMsEHxohdqGiQq6BVLpCvEimV8PjsiIPAtDV6MA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Oq0EhtP6GGAdbPongzYS+qsoH7hTQ4kMKDTtFpgxZnixcxEEs9zaE4WV747wVh2Wf8hLfZ4uABllsY9bqrNc0GWy+SrZALVoxXaRIoLUfdRt5J2S/WBsujKfXovbJlv5EK6/yrUWJkWqlth4cozkpNaFSgq7diUcmyN5Saf+ybB2kqM/lhKJHuJlRP6GOfZSXfMvMndrjRRxeSrin04lA70gArcogczMjEjvPARZoI2qrd0g4nRSi5GmfnMdA5JB6McxtBRG2v33KLcWY3I5hPtAOY6b0UximBXaHHjn+QOzS76Bp+kcjlYEgSNw3WwlfZnl7poo4Nkl+b3e1BmCnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eDTwShkh; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b4; helo=out-180.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eDTwShkh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b4; helo=out-180.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 121 seconds by postgrey-1.37 at boromir; Fri, 24 Jul 2026 23:39:40 AEST
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h68HJ22Fzz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 23:39:39 +1000 (AEST)
Message-ID: <d2e1d8ae-74d1-4f46-9871-5f7f3e69ccb2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784900360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dtkHIMsEHxohdqGiQq6BVLpCvEimV8PjsiIPAtDV6MA=;
	b=eDTwShkhPSDeT8mihmnbGk+NrbBCBLhM+nD1HZW+oBfEZrqFb6NjOtIaESZOxn77AzFWdg
	9LeWIw0KQXz1l4VXonWtM/pdvX0EyV+ApzI/ikSYzaE5jld3fucFcDwwx4pVOTJwrOXqOe
	MSEbodEKd6e5fXXMD4SFUOkiXzv7YrQ=
Date: Fri, 24 Jul 2026 14:39:08 +0100
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
Subject: Re: [PATCH 3/5] mm/parisc: constify ptep_get() argument
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
To: Pedro Falcato <pfalcato@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20260724102017.141532-1-pfalcato@suse.de>
 <20260724102017.141532-4-pfalcato@suse.de>
 <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>
Content-Language: en-US
In-Reply-To: <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 24/07/2026 14:36, Usama Arif wrote:
> 
> 
> On 24/07/2026 11:20, Pedro Falcato wrote:
>> ptep_get() does not need write access to the PTE.
>>
>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>> ---
>>  arch/parisc/include/asm/pgtable.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> hmm I think you might break build bisectibility if
> you separate out the patches, you should squash patch 3 and 4,
> with patch 1.

* squash patch 2, 3 and 4 with patch 1.

