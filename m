Return-Path: <linuxppc-dev+bounces-22998-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29AACDE00C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 00:46:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmcS26pf9z2xn3;
	Fri, 26 Jun 2026 10:46:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782434786;
	cv=none; b=Izlh8rZ1sG0QqBGTy+rlszhPmi/oye1m+pGdk1GhoOkbmepxJ5y/4aXOkSJoNPn/lR7eCzaCg+CixaP63oF3SgASabvkOOefafubPv5zLcsya8JGo6N+TVrwVemkUvKFJmHxxuDC7jFJZdvtISi+u8i19L5pLkMBRO8NJk5GR6lXxF7VAluuCi8m8LUlxMSwSLEF4o4gPHi8tzdz8cVgAkBAB6yHocNmPTE1/q3x2NfXiTu0C9gQjrrvAKY+ERE0x1UwZNBvyk0yNGoYvsU3Klm0oSuai/lrnwLHhcaZqb7wsbGJ21RGQ1KeVGutwWIUWF28rTWMTZxm0sEYmi/Exg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782434786; c=relaxed/relaxed;
	bh=aVwnJDGi7HOXHyeM0jNjwmLxXliLE7L625+/NqaYxmg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZiLYMyXVg8ywEKuIbQCN/9g0I0a5T/d1XLFVlG6e/vrIYZCHglh/S6BPbQR65a/EGl01ipjP5nVSmaB+oPi3UhAykYjr8ggqc3skw0WurVc5spvfdz2oz3lK4lKD4Gc0tyi2MRzqBl3jlYzyutp5DI7zExiLsz3FprrFl8qcZY41MrVUKM0OYiLJ4GXtw8dUoCplktkpB8vAI/jBVQKYZzV45DVd8bZhhHclM+pBvvrtb/40ju3O+eJd6fJYswTz6m7mEmeLk6rYbtheTE8sGloSljhou2ORkzTEwEeImH6jaJb7VkmlbDjOlAi0go/QbpeU8Z4yBIjPMMkFkH37Zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ttuUkkW9; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=ttuUkkW9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmcS12zsjz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 10:46:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 746FE60098;
	Fri, 26 Jun 2026 00:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903801F000E9;
	Fri, 26 Jun 2026 00:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782434781;
	bh=aVwnJDGi7HOXHyeM0jNjwmLxXliLE7L625+/NqaYxmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ttuUkkW9XB6RuZTLYjeJ/3uTYeXRf6yq0egZXdrkILgAmZizyGc15vX5NyM2XHWzD
	 tb2k1YiKgsHTU9XgApnhlqlUXzoIYDtrltk0/8s1pLM+JAaHAVeY8PIo2wZL+iaNvF
	 qR60k0TTyAaXwmuUmEv88320MeMUOpwVNwW8AI7A=
Date: Thu, 25 Jun 2026 17:46:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>, David Hildenbrand
 <david@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, Mike
 Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Mike Kravetz
 <mike.kravetz@oracle.com>, Michal Clapinski ? <mclapinski@google.com>
Subject: Re: [PATCH v4 00/19] mm: Refactor bootmem gigantic hugepage
 allocation
Message-Id: <20260625174619.45d7b772b69b7b54b7f3bae1@linux-foundation.org>
In-Reply-To: <20260612035903.2468601-1-songmuchun@bytedance.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
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

On Fri, 12 Jun 2026 11:58:44 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> This series is split out from the earlier larger series "mm: Generalize
> HVO for HugeTLB and device DAX" [1]. It collects the first 19 patches of
> that series as a standalone set of fixes and preparatory cleanups around
> bootmem HugeTLB handling, sparse initialization ordering, and related
> vmemmap setup.
> 
> The first patches fix a few bugs found while reviewing the existing
> code, including incorrect bootmem HVO handling, wrong vmemmap
> registration arguments, a powerpc compound-vmemmap tracking bug, and
> too-late initialization of gigantic bootmem HugeTLB struct pages.
> 
> The rest of the series reorders early memory initialization so the
> relevant zone state is available before sparse and HugeTLB boot-time
> setup runs, then simplifies the remaining bootmem gigantic hugepage
> allocation path and removes code made obsolete by that rework.

Thanks, I added this to mm.git's mm-new branch.


As requested, I dropped Michal's "mm/hugetlb: init tails before
init_migratetype" from the mm-hotfixes-unstable branch.  Michal, can
you please review and perhaps test [01/19] "mm/hugetlb: fix boot panic
with CONFIG_DEBUG_VM and HVO bootmem pages"
(https://lore.kernel.org/20260612035903.2468601-2-songmuchun@bytedance.com)?
Thanks.


I added cc:stable to [01/19], as CONFIG_DEBUG_VM is not uncommon.


I added this series as-sent.  This means that the four cc:stable
patches won't be offered to -stable maintainers for 2+ months.  If you
feel that some/all of them should be upstreamed earlier than this,
please let me know and I'll make the necessary reorganizations.


And thanks for checking the Sashiko report.  Dang thing ;)


