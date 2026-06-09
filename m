Return-Path: <linuxppc-dev+bounces-22386-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BF9CD8C90
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 04:45:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZtWL5p3Sz2y1Y;
	Wed, 10 Jun 2026 14:45:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.147.51.103
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781021383;
	cv=none; b=R3/SwT7yhM2xTK34W8EPKZwfn9trUFLyrKQWYh5tAKadcdyetb8FafeCwwXzlwUw0j7a9urucaC8CbtWZliqoBCcvYfED9OsZvS+MPD7KYWOhkvaDGCz8pBudAQIQeo3a1PheA3ZiXQSqW7jkKP3RGEsLE/Uj+SpjoDgf7YIHnbx0hdlk2d+7PykjYoHV51H2fCdfN1OTCNEY+MeVFNPfmj+Yq4jvFlXVQ72m3M8cUVYZWgnrVWV6jpc2IFvou8PHuLWMlwmk22LFxnZ9oakWOzlEsco3EnvjbSUMRrXBgb8wYard2olhcD4cCJmhGX5ajTe8xkK2yLk8e91T3HLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781021383; c=relaxed/relaxed;
	bh=h2xF6Dj7GyPRpT2EfkYWfpIBrdvTlK7OvEdoE1Wqr+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgvvYwQ2c0EUmz3P6BPpZei1QqsX9xNIxkCzN7gw2Y3XvOw1fE6NQzAUbaNv6MfoyBGt+/5EYFEF5TyuLShyGLYJwREYmlvzq+4mEjhq1OXZySqjbdJMAa+O2IeFR0sWjo/6gC846pNqs67clTHanBQbCHQ0bYN2Ci78j2wT9CBmwjZ4XKzHxWhUgtZwvLvHqgCh1KTuZsOyDkICFNGOFygQOtyZyTiU9F+iK8ibfbnQyzKQTF6DVHmeFD85YxnoFDcppAiPlXCPqIAXy4DAB+1Y26t/5t5VJh9HfwZD93PbsZt4k7pDoJiQewbNjsUWy9Q0/oCDNu6Ged6xyVOa9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass (client-ip=156.147.51.103; helo=lgeamrelo07.lge.com; envelope-from=youngjun.park@lge.com; receiver=lists.ozlabs.org) smtp.mailfrom=lge.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lge.com (client-ip=156.147.51.103; helo=lgeamrelo07.lge.com; envelope-from=youngjun.park@lge.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 897 seconds by postgrey-1.37 at boromir; Wed, 10 Jun 2026 02:09:39 AEST
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZYl741CKz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 02:09:39 +1000 (AEST)
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 10 Jun 2026 00:54:37 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Wed, 10 Jun 2026 00:54:36 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Subject: Re: [RFC 0/4] mm, swap: Enable THP SWAP for PowerPC Book3S64
Message-ID: <aig3PFm9jst8cHxn@yjaykim-PowerEdge-T330>
References: <cover.1781000840.git.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781000840.git.ritesh.list@gmail.com>

On Tue, Jun 09, 2026 at 06:49:30PM +0530, Ritesh Harjani (IBM) wrote:
> On PowerPC Book3S64, MMU is selected at runtime, so macros like PMD_SHIFT are
> effectively runtime variables in the Book3S64 code. THP swap code uses these
> macros for e.g. to size some of its array data structures based on PMD_ORDER.
> This patch series makes that usage dependent on the runtime variable.
> 
> Sayali did some performance runs of this on Book3S64 with Radix and it gives
> 40-50% performance improvement. We also plan to run it with Hash, will soon
> update the results.
> 
> Note that this patch series is based out of linux-next (next-20260608).
> 
> Ritesh Harjani (IBM) (4):
>   include/linux/swap.h: Remove unused leftovers
>   mm, swap: make SWAPFILE_CLUSTER runtime
>   mm, swap: make SWAP_NR_ORDERS runtime
>   powerpc: Kconfig: Enable THP_SWAP on Book3S64
> 
>  arch/powerpc/platforms/Kconfig.cputype |   1 +
>  include/linux/swap.h                   |  17 +---
>  mm/swap.h                              |   5 +-
>  mm/swap_table.h                        |   6 +-
>  mm/swapfile.c                          | 132 ++++++++++++++++++-------
>  5 files changed, 106 insertions(+), 55 deletions(-)
> 
> --
> 2.39.5
>
Hello!

Instead of making SWAP_NR_ORDERS fully runtime, could we set it to the max
PMD_ORDER possible on PowerPC Book3S64 as a compile-time constant in the
swap.h ifdef block? (My assumtion is PMD_ORDER max not too big.)

I think the general runtime version adds cost. It impacts all other archs.
percpu_swap_cluster needs a runtime alloc,
the si/offset and nonfull/frag arrays become separate pointers, and some
accesses get one more indirection. And for nr_orders=1, the allocation
itself is just waste. 

With a compile-time possible max constant, the only downside is some acceptable amount of
wasted bytes per CPU / per device on Book3S64 (the unused entries in the swap
offset cache and the nonfull/frag lists), with no perf impact. the perf
improvement comes from THP swap itself, right? Other arches see no
impact at all.

patch 2 looks fine as is. SWAPFILE_CLUSTER backs much bigger per-cluster
arrays, so runtime sizing makes sense there, and it looks like no impact to
other arches or the current code.

Thanks!
Youngjun Park

