Return-Path: <linuxppc-dev+bounces-20922-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCE7CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 17:46:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gG19d5h7Vz2xld;
	Thu, 14 May 2026 03:46:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778694405;
	cv=none; b=Ufb6xe/eE3QCFNDyfpb/GlDPmQ90fIguEGkuQITxSDcvb3szdQhumWFnpnWWMHZVMzrBuvb2syZH497lbViALVZD6W//2i/aia4lceS2H9ZA2inqGNmRqg2iFox0BDHXUt5c01kNu6v3LN9iFj1yz00O/Q/Jwbydz+2xH9gGKFW0BtjkLxqckHQLKfTJQYxVBHXDENaWMlbDbI96e8NcGoVr7wEFcoK9RNvkpvJx5rYruXbFINjp6ubneN8qgYvdLiLi2qLZ4PcCWzgya1ukBA1C14yICBon5F/O0OkVfncruyLb9WWLMzC6Dsuj5V0S0agTqb8cx7a+hw9xFf8rpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778694405; c=relaxed/relaxed;
	bh=AIr1xcqYq5Tl3HDmm7kwPWSRvEZ/6U01PUBrtWGLIxA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hSpPuVAvBRzr2Z1Vc7wpDEOlwGlhR3ws6qBQnpU2l4/tC0sFvK36jk85vmg9HMQY/r7GWxtoNRvpGBH+e8Z+Gh8HK6j1zUS48o0Nq/Ay6bD/+avzedtsN2ZFCOCAaWQT+ZSQAioDoSHz000T8maK1Ty/KJ8Ky/wyROzlPdxQ0gvMEyaQqyVpqtY5isrHFmwmui9Cs6GZDqIKZDZrwiLL84slBX+ob8Ws3Q15dvZTLj18vHBrW/tNIQZ7GhJUQx3DD3uhZKRmbfvf0J3KKxEqzcxbKujSJSi7xXRt671KZ8MiVrX1LRt/lYKAflgwRWAQ6PNsto3kVECsSpV+4t/OOw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=BsfZzrgC; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=BsfZzrgC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gG19c5hmyz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 03:46:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 32ABF60121;
	Wed, 13 May 2026 17:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37904C19425;
	Wed, 13 May 2026 17:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778694401;
	bh=EvrM3uz6EOhLIcr/NdISliy5/4+6NtJJVBVMpjRPn7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BsfZzrgCAKpVLGW+zLYqSFHcPyq87YZ8baXJG3nnULrm3Z+RuAAKdtgbdqYF/xcPp
	 LaIyzOwnzGxY2wcl2jy6+8nQwTZZV7ipeDmZATx+i3waJHlqutAHx5FH+Y8h+ipAOP
	 Cwxqkkec6wE+E4hm4PRn631DaNoGQYC3o/VkP+gc=
Date: Wed, 13 May 2026 10:46:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Michael
 Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <chleroy@kernel.org>, Ackerley Tng <ackerleytng@google.com>, Frank
 van der Linden <fvdl@google.com>, aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/69] mm: Generalize HVO for HugeTLB and device DAX
Message-Id: <20260513104640.b0f02b844c57f92bc954878e@linux-foundation.org>
In-Reply-To: <20260513130542.35604-1-songmuchun@bytedance.com>
References: <20260513130542.35604-1-songmuchun@bytedance.com>
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

On Wed, 13 May 2026 21:04:28 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> In this series, HVO is redefined as Hugepage Vmemmap Optimization: a
> general vmemmap optimization model for large hugepage-backed mappings,
> rather than a HugeTLB-only implementation detail.
> 
> The existing code grew around the original HugeTLB-specific HVO path,
> while device DAX developed similar but separate vmemmap optimization
> handling. As a result, the current implementation carries duplicated
> logic, boot-time special cases, and subsystem-specific interfaces around
> what is fundamentally the same sparse-vmemmap optimization.
> 
> This series generalizes that optimization into a common framework used
> by both HugeTLB and device DAX.
> 
> The first few patches include some minor bug fixes found during AI-aided
> review of the current code. These fixes are not the main goal of the
> series, but the later refactoring and unification work depends on them,
> so they are included here as preparatory changes.
> 
> The series then reworks the relevant early boot and sparse
> initialization paths, introduces a generic section-based sparse-vmemmap
> optimization infrastructure, switches HugeTLB and device DAX over to the
> shared implementation, and removes the old special-case code.
>
> ...
>
>  46 files changed, 743 insertions(+), 1812 deletions(-)

Gulp.

I think the first 15ish patches (little fixes and cleanups and
refactorings) are ready to go in immediately?

Perhaps you could prepare such things as a separate series.  Or tell me
which ones are suitable and I'll fudge up a [0/N]?


