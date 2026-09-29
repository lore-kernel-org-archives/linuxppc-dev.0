Return-Path: <linuxppc-dev+bounces-28531-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFACCA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 21:32:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvWbm6Ssxz2ySj;
	Wed, 30 Sep 2026 07:32:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790717540;
	cv=none; b=RKcQ2TuVbzw8BLR1FkrAsWVLTWw6Fq3xDtmyqMjWpa2odybc4qotTAbvY3qFGvzLOT8r4/DZ/Z+z5tCxfX/Ha2XKwHfEZl9AUfkHVLj/TWchmoQJ+lX1UoiB970cJQ6Ps6o/ihNtytMEoX9DhBgMOFu6pE3t1OnlkmaAECdSxPtxi8oGBbQ+ygCv/5loBPZKSpFLXZKkbF+rvqXHKeSdBVYv/8uU3Xo8UyjdMkpjej4oNwiG68PlWOvKuWDk/D6Pu/AYVjtBaiOTBKcKznbkFewBge6xNWVoqk2oNjqUjFgeV87c/yZ/tS+I5GgkH8hTVBH7nAWiZ4G2+GFKJnWLug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790717540; c=relaxed/relaxed;
	bh=bV1wlokKdVHLqPHNGwe/7vIopeMXy+gYUFpopQWEIt4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K45zh/GKYkleSh1Cb3q636STdDQVB2vN6mrRmDkjtywJBQPHqpIPCvDRhSFB82Fc7a5u4jM4npcC4c24zhF2ONJzZomnUEVwISoh9YgF66F0+j5I2EPqIxxMAvqmQ4+Ey+zoPXe+iNnlgfaUMgqFIK+FgPK3zIoJGiyRReldIu9/8+22xE4LYjW3uJRVNuDCx9qq8VNiGBb+tlP/cJlnMIn8NHKeVT4cmZdFCIw3qpPQszOey93Jy9IuY3Jn2barhiRbOmmUS/IEZz7DA0ioUMgXswXVYdI23nwZBLtJfdNe7uaDUMqISxvEw41zagKAC8V7lk1piz2h968AvTAKLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=D3vyCbxH; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=D3vyCbxH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvWbl4sHpz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 07:32:18 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B8DB043D33;
	Tue, 29 Sep 2026 21:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068751F000FF;
	Tue, 29 Sep 2026 21:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790717535;
	bh=bV1wlokKdVHLqPHNGwe/7vIopeMXy+gYUFpopQWEIt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D3vyCbxHxJQ+aX1/mUxGlNGRXygGdhx3UDqmwRpHjeF9SrqNpUku1TQDoU18Eju+A
	 Uvj+PN6PuV8lgvO1Uo60ys6S+sVxEDTN6T7mEYU3V9canHRrMkOUhO9Qkzk7wqeFeb
	 v6vUPVcDn5zBCzMO6qK/hPO0ApMIFdNMFlbEMsgk=
Date: Tue, 29 Sep 2026 14:32:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport
 <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <chleroy@kernel.org>, Ritesh Harjani <ritesh.list@gmail.com>, Shrikanth
 Hegde <sshegde@linux.ibm.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Qi Zheng <qi.zheng@linux.dev>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, muchun.song@linux.dev
Subject: Re: [PATCH v3 0/6] mm: Unify device DAX and HugeTLB vmemmap
 population paths
Message-Id: <20260929143214.9061bcf284369163192968d1@linux-foundation.org>
In-Reply-To: <20260929053231.66085-1-songmuchun@bytedance.com>
References: <20260929053231.66085-1-songmuchun@bytedance.com>
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

On Tue, 29 Sep 2026 13:32:25 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> This v3 is based on mm-new commit 2ddb90ee544a, which contains v5 of
> "mm: Switch device DAX to section-based vmemmap optimization" [1].
> 
> This series is split out from the earlier, larger series "mm: Generalize
> HVO for HugeTLB and device DAX" [2]. While the parent series generalizes
> vmemmap optimization across HugeTLB and device DAX, this subset addresses
> a single, self-contained step: unifying their vmemmap population paths.
> 
> After the preceding Device DAX conversion, both HugeTLB and Device DAX
> describe optimized vmemmap mappings through memory-section metadata and
> use per-zone shared tail vmemmap pages. The generic code, however, still
> carries a Device DAX-specific population flag and compound-page population
> path, along with arguments and helpers needed only by that path.
> 
> This series first removes VMEMMAP_POPULATE_DAX and moves selection and
> reference handling for the shared tail page into the common vmemmap
> population path. It then removes the generic Device DAX-specific
> compound-page population path and routes section vmemmap population
> through vmemmap_populate(). The powerpc radix path continues to use its
> architecture-specific compound-page population implementation for
> optimizable sections.
> 
> The remaining patches remove the unused ptpfn argument, open-code
> vmemmap_populate_address() now that no caller needs its returned PTE, and
> add a warning for inconsistent zone initialization of shared tail vmemmap
> pages.
> 
> This is the fourth smaller step toward the broader HVO generalization.
> After this series, HugeTLB and Device DAX use the same population model
> instead of parallel generic paths, while powerpc keeps its
> architecture-specific implementation.

afaict the whole series is "no functional changes intended".  Apart
from [6/6]'s new WARN_ON.

And [3/6] is the one which could cause unintended fuctional changes!

Thanks.  I'll queue it.  Reluctantly.  We're up to 688 MM patches this
cycle and it's time to stop.


