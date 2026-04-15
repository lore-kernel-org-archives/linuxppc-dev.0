Return-Path: <linuxppc-dev+bounces-19771-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFE6F41986
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 11:27:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwf5T18Thz2yvY;
	Wed, 15 Apr 2026 21:27:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776252477;
	cv=none; b=aLF7SU6CIfkifXz6g4vkQFG1M8m8P9O84ReprQBVWOttFWJftRPXenGbcfA4VW5ujkxBfKuuLv15yBimef5WtrAncULiREZPBnlewGJ4AvjxQNj159mrAM96qKs4SzYWYUaGfZm92ooYpDtNRabUAB86psZmgeRQYswhQNcIgo10Ii86mXF4hq/HBdSO5BH4s1cxMn5K62a0VZImFM0zJbnjegMt0f5ElMgGyobh/hxhKB2M/k0h2gqun6QYGlNLgi5SQZ7wu7XtvWq/1npYvWZf5c84AoGQTuFYeJ8vhqv18rc+4lwEFsr4tOS7aBZRy5TqTtZDhfWiWW675Ia2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776252477; c=relaxed/relaxed;
	bh=W/nLB/pOMgjoGvlQGXIaocK5El7h3zMc3A4XsLzA8T8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=am+rg2At08oeTOB5fjiwxJ4DDHJjcJRygGs7ARKQGQIZPU6KVGShTQRYG0YzPVoWHKJAXC2ZHlKitJcaygKGXL9zhK0sF49QHRwPFQvXRJehQ/rDmPilK1Co6VEN7E3VkKG+D9fAobCLmv1A5mwmQllHPoqRork2aB0eemg52mUphTFpxr2he7N5xgfd+s5L3gRAPs3A1B49CXOqaSGsx3wTX/L/+2mvzUiQyaYgRo7oJyhhVQAk8izeK4ggB5PF+mpNwxWLUfRFC4fOt4BG/Cufg2Rk7SoEuv7K4NAewTD7LBIR9EZgs5ADqSv4O3nkXju9xp6lzbT+kXBl6FFddw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xJrY84Ru; dkim-atps=neutral; spf=pass (client-ip=95.215.58.182; helo=out-182.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xJrY84Ru;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.182; helo=out-182.mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwf5S2sj1z2yrM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 21:27:54 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776252455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/nLB/pOMgjoGvlQGXIaocK5El7h3zMc3A4XsLzA8T8=;
	b=xJrY84RuBgIzMfpV05/ao1QOksPa1LC3ottI+Y1uuNWVW70HEumJHngYbP3o5OEt/C56hI
	uMW9yrXZxypuR+c2t0uc5yyOqnLbnd/Nf8ksTgexH2Db8sypIHKqUu+glCUB9ga/1C3cLn
	ESgtvYFhLGm6TvsP2fq9gT/wvtp4TWI=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2 1/6] mm/sparse-vmemmap: Fix vmemmap accounting
 underflow
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260415111412.1003526-2-songmuchun@bytedance.com>
Date: Wed, 15 Apr 2026 19:26:48 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A5A00658-660F-4CAF-A2E9-61834A8A640A@linux.dev>
References: <20260415111412.1003526-1-songmuchun@bytedance.com>
 <20260415111412.1003526-2-songmuchun@bytedance.com>
To: Muchun Song <songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Apr 15, 2026, at 19:14, Muchun Song <songmuchun@bytedance.com> wrote:
> 
> In section_activate(), if populate_section_memmap() fails, the error
> handling path calls section_deactivate() to roll back the state. This
> causes a vmemmap accounting imbalance.
> 
> Since commit c3576889d87b ("mm: fix accounting of memmap pages"),
> memmap pages are accounted for only after populate_section_memmap()
> succeeds. However, the failure path unconditionally calls
> section_deactivate(), which decreases the vmemmap count. Consequently,
> a failure in populate_section_memmap() leads to an accounting underflow,
> incorrectly reducing the system's tracked vmemmap usage.
> 
> Fix this more thoroughly by moving all accounting calls into the lower
> level functions that actually perform the vmemmap allocation and freeing:
> 
>  - populate_section_memmap() accounts for newly allocated vmemmap pages
>  - depopulate_section_memmap() unaccounts when vmemmap is freed
>  - free_map_bootmem() handles early bootmem section accounting

Sorry, this line was forgotten to be deleted. The subsequent modification
of free_map_bootmem() is a separate cleanup.


