Return-Path: <linuxppc-dev+bounces-26782-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B09BC79FA0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 09:30:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfJZ02Yc9z2xlJ;
	Tue, 08 Sep 2026 19:30:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::93"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788859800;
	cv=none; b=bap8GaLEAst+DFEY+YMOKCm1CE5Iv7tEjgpa2JwnYVPKIRct3tRXDZI/j7atxcATV1oaHfTyN96jnEn3BYJtpQFzwCu/sciVncQ4V5LPXEakmQDAGln6FUdz9X8N6g7NhS4OmHlhzvDQuNPMgi/kn2p32Cs2+ab7nBp0iBr7nR4Q1eUIDa/4sgz0qqflYqHRW7yR2k31obOvruuI5XgRJ2SnvilOc3AFBNQ9ZY7+9I9R8DiwB4zpF/neiFfPHYlUTtfbJ9CbIML+g3XpoXXtGUVoT038VudzSn1rJBJQgx59504M9CCYzSc3xeOcxrTiZAcuL+3aoCGo59UI8EPzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788859800; c=relaxed/relaxed;
	bh=Ppl9VV+uiGLGl6RPtIL8FAMmwVJi/D2fN8+Nfz4OxG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvtNkekVKE9R22HflVFJky38U02HVHQM1I2tX7UZ9Yuwln4oCn2163aZgYwpbPgER8ojUw553tqNkhgQfUmcq809UWCffweFRyjfPBeOgISL/daMh3Qxd5+veZD8SE2FVhexVmCX+5FCQn4lbsHk8+W5FUp9Dsr0p1csycX8keSxRjzKty4TauijX/HqWNTo7FTiQoBvSQfT87STxIjBVbNMD92dg5GdnfDE9uV/TteVIuObxyzNn97GHUARqV5L+CRba04nZH9i8x7KrupKwcwntwDTsdpgL2gfXR9hlAdpX/7ce/S6jn8ZEneNqRgt0DTgKfIlMfEmAuEl9+OOgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NT4ngglp; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::93; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NT4ngglp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::93; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-147.mta0.migadu.com [IPv6:2001:41d0:1004:224b::93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfJYy707vz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 19:29:58 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=15IOOyKa+ijGmMxg7kwu9CI1MNJx0YkgAkPki5J/TZI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788859780; v=1; x=1789464580;
 b=NT4ngglpu+P1qCAwMpvi5skJVqMX/UTGMoDC8wwv+T+PdUQBVVmjF2FUVhdYdbO9TwQ0CvzN
 VImV7aNtVlKFs6JVQGKU8UHxprvBNk0VJgiTliDg1qEsPoHzunKUJDVQVQimHC01jnyUp+VmXla
 n3/GnnhU8bFZ68YQHQVjMam0=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id c1b4dc536328070e;
	Tue, 08 Sep 2026 09:29:39 +0000
X-Mizu-Trace-ID: c1b4dc536328070e
X-Migadu-Flow: FLOW_OUT
Message-ID: <cc7003c6-9be6-430e-a37b-e43a08402825@linux.dev>
Date: Tue, 8 Sep 2026 17:29:34 +0800
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
Subject: Re: [PATCH v2 11/11] Documentation/mm: update DAX vmemmap
 deduplication docs
To: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
References: <20260908030335.96549-1-songmuchun@bytedance.com>
 <20260908030335.96549-12-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260908030335.96549-12-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/26 11:03 AM, Muchun Song wrote:
> Device DAX now uses the common per-zone shared tail page for vmemmap
> deduplication. The old documentation still described a DAX-specific
> layout with a separately populated tail vmemmap page and half the HugeTLB
> savings.
> 
> Update the generic and powerpc documentation to describe the shared layout.
> In the powerpc document, keep the radix and 64K-specific details, drop the
> duplicated 4K PUD arithmetic, and replace the repeated device-dax diagrams
> with a single parameterized PMD/PUD diagram.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2:
> - Clarify the commit message to state that the 4K PUD arithmetic is
>    intentionally dropped reported by Sashiko.
> ---
>   Documentation/arch/powerpc/vmemmap_dedup.rst | 90 ++++----------------
>   Documentation/mm/vmemmap_dedup.rst           | 32 +------
>   2 files changed, 21 insertions(+), 101 deletions(-)

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi


