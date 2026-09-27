Return-Path: <linuxppc-dev+bounces-28342-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45836C98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 19:55:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htFXN3bL3z2yMn;
	Mon, 28 Sep 2026 05:55:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790538900;
	cv=none; b=chTZCDVNN81gEYyhDw5qUNlaXtdSkhDPDM7qoznz+NhPML9MOGHiuMiZ8CBIyt9B2Iu3G+3JSBXsRUUj/NsukFqbHzrAk9l+GpDxVjkP9+blDaF+Z15vA8SXdyNMEpg4qwh3jbXiEtABybU6HHAAbd6pt4H6JVKeC7M1AYhZUDSdrFq8S5Mt7eYpk5o1y//gYuPK41eDlNOtCM21dGuJOckr9B5+wlpYDJCynLk2nSmq/vxRjE+WE4IWBVUJabfZ4VwZmc42OLJo10qkyj7xnVqs1YdEYuTBitwnfhMpqr/QaY/FIrd/QAIJYezzVJyIU3bihVsPHjPuQA3OSMjUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790538900; c=relaxed/relaxed;
	bh=syrXrC34qOwYKtXT+0y34VtSNtk9nNOuE8xaaaEO4v8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E+mEnt/SDSOW/i5LS0Q0cqz0fyO4hJ+eaRqgPCMdkIvkMcgo/QVM1j6C1fDLXdBuyyt5Pg8sLE+tBk2XqG1kVBsQlpKYC0e459DYI9N3JueYy0lNQq9ihpQuG72errfo1mhKBG5MfU2sBWfHjjCHPeqW9LYZbWolUoQvzWO+GNG1iPnxnA8FmGclZENuC83n/HUA+FIg5bqoDTfcrUggOW5E+avZYeuhjDkQ6IL3DeimV+xmbFsSsp4Kmuub4n49iztDfcoXW2V0dmk6IU7K5ubWK2AvxoO8igKlpa3agVDfK1SJ5RYv4irsq8YiyZj71QuP6lmdgGifE1//LDZuLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=yX64huLr; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=yX64huLr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htFXK6gSsz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 05:54:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A246140F00;
	Sun, 27 Sep 2026 19:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAEC1F000FF;
	Sun, 27 Sep 2026 19:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790538893;
	bh=syrXrC34qOwYKtXT+0y34VtSNtk9nNOuE8xaaaEO4v8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=yX64huLrYBvawjHjNMziGPcDF408jVy97eCQhDGEdK9ruUIWtHuIYsE+mhNMfqt18
	 Nqxac4sU4f16KAf+zoUW04JYqXg33sc2tfOTTb0EWu8wdgVWka3mOOBCFT22odBp06
	 Fd3pMy/8/YX3DJSXlv/le88Lqf3alNmdUMlUep3Y=
Date: Sun, 27 Sep 2026 12:54:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>, David Hildenbrand
 <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Jonathan
 Corbet <corbet@lwn.net>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, Lorenzo Stoakes
 <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>, Qi Zheng
 <qi.zheng@linux.dev>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <chleroy@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Lance Yang
 <lance.yang@linux.dev>
Subject: Re: [PATCH v5 00/12] mm: Switch device DAX to section-based vmemmap
 optimization
Message-Id: <20260927125452.0c1ec382905482841a4faef7@linux-foundation.org>
In-Reply-To: <FB00943F-8DB1-4BEE-BF37-701785DE2DDE@linux.dev>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
	<20260926225105.a56f29d76b2f496c8dc2dac0@linux-foundation.org>
	<FB00943F-8DB1-4BEE-BF37-701785DE2DDE@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Sep 2026 18:51:15 +0800 Muchun Song <muchun.song@linux.dev> wrote:

> 
> 
> > On Sep 27, 2026, at 13:51, Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > On Sun, 27 Sep 2026 10:54:29 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> > 
> >> After the HugeTLB conversion, optimized vmemmap state is described by
> >> the memory section and the sparse-vmemmap population path can allocate or
> >> reuse shared tail vmemmap pages based on that metadata. Device DAX still
> >> uses the older DAX-specific population model, including a separate tail
> >> vmemmap page reservation and architecture-specific logic to locate or
> >> populate reusable tail pages.
> >> 
> >> This series makes device DAX use the same section-based model. Device DAX
> >> records the compound page order from pgmap->vmemmap_shift in section
> >> metadata before vmemmap population, uses the common per-zone shared tail
> >> vmemmap page, and drops the extra reserved tail page. The powerpc radix
> >> path is updated to use the same shared tail-page helper, so the generic
> >> and powerpc DAX paths follow the same reservation model.
> > 
> > Thanks, I've updated mm-unstable to this version.
> 
> Thanks.
> 
> > 
> > Sashiko asked a thing:
> > https://sashiko.dev/#/patchset/20260927025441.741633-1-songmuchun@bytedance.com
> 
> Sashiko said page->refcount can overflow by incrementing it over 2.14 billion
> times when mapping more than **524 TB** of DEV-DAX memory on a single NUMA
> node, where the pages share the same node, order, and zone.
> 
> I am not aware of any practical hardware configuration approaching this
> topology today.
> 
> Handling that theoretical limit would add non-trivial lifetime or
> architecture-specific teardown complexity. Without a concrete hardware
> requirement, I prefer not to over-engineer the current series. We can revisit
> it when such a system or use case becomes realistic.

OK.  Presumably it would be cheap to add a check for this craziness and
return ENOSOMETHING?

