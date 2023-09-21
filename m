Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF08E71094
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Sep 2023 16:31:25 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Sy+EhpEK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rs1B36wVwz3ccd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Sep 2023 02:31:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Sy+EhpEK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rs1972TDGz3cBx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2023 02:30:34 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id C89DCB82159;
	Thu, 21 Sep 2023 16:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD95C611AA;
	Thu, 21 Sep 2023 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1695313828;
	bh=Snl0TDHOoq+PcJkslOz6yzyz3jV/ILGMNVGDPT3ALVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sy+EhpEKmklRoXizWavrDSv+mOOfZ2nUh7nbNkMhlDLbnh4hSgBtM2DfmKEv4UzUL
	 Pv6q7E7wnTnnSz2jaiJSSK97ktzV1tSKKpfyQ3VEqmLQ/I+fVqkhoc6rt2Al+4iGM9
	 C9VSqdRkP4rrRuEL9YXgvk8jJTKJGqA4Ygoc1IFE=
Date: Thu, 21 Sep 2023 09:30:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v1 0/8] Fix set_huge_pte_at() panic on arm64
Message-Id: <20230921093026.230b2991be551093e397f462@linux-foundation.org>
In-Reply-To: <20230921162007.1630149-1-ryan.roberts@arm.com>
References: <20230921162007.1630149-1-ryan.roberts@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Peter Xu <peterx@redhat.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, linux-mm@kvack.org, sparclinux@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Helge Deller <deller@gmx.de>, Christoph Hellwig <hch@infradead.org>, Axel Rasmussen <axelrasmussen@google.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, Anshuman Khandual <anshuman.khandual@arm.com>, Heiko Carstens <hca@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Paul Walmsley <paul.walmsley@sifive.com>, linux-arm-kernel@lists.infradead.org, SeongJae Park <sj@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>, linux-parisc@vger.kernel.org, Greg Kroah-Hartman <gr
 egkh@linuxfoundation.org>, Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Sven Schnelle <svens@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, Mike Kravetz <mike.kravetz@oracle.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 21 Sep 2023 17:19:59 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> Hi All,
> 
> This series fixes a bug in arm64's implementation of set_huge_pte_at(), which
> can result in an unprivileged user causing a kernel panic. The problem was
> triggered when running the new uffd poison mm selftest for HUGETLB memory. This
> test (and the uffd poison feature) was merged for v6.6-rc1. However, upon
> inspection there are multiple other pre-existing paths that can trigger this
> bug.
> 
> Ideally, I'd like to get this fix in for v6.6 if possible? And I guess it should
> be backported too, given there are call sites where this can theoretically
> happen that pre-date v6.6-rc1 (I've cc'ed stable@vger.kernel.org).

This gets you a naggygram from Greg.  The way to request a backport is
to add cc:stable to all the changelogs.  I'll make that change to my copy.


> Ryan Roberts (8):
>   parisc: hugetlb: Convert set_huge_pte_at() to take vma
>   powerpc: hugetlb: Convert set_huge_pte_at() to take vma
>   riscv: hugetlb: Convert set_huge_pte_at() to take vma
>   s390: hugetlb: Convert set_huge_pte_at() to take vma
>   sparc: hugetlb: Convert set_huge_pte_at() to take vma
>   mm: hugetlb: Convert set_huge_pte_at() to take vma
>   arm64: hugetlb: Convert set_huge_pte_at() to take vma
>   arm64: hugetlb: Fix set_huge_pte_at() to work with all swap entries
> 
>  arch/arm64/include/asm/hugetlb.h              |  2 +-
>  arch/arm64/mm/hugetlbpage.c                   | 22 ++++----------
>  arch/parisc/include/asm/hugetlb.h             |  2 +-
>  arch/parisc/mm/hugetlbpage.c                  |  4 +--
>  .../include/asm/nohash/32/hugetlb-8xx.h       |  3 +-
>  arch/powerpc/mm/book3s64/hugetlbpage.c        |  2 +-
>  arch/powerpc/mm/book3s64/radix_hugetlbpage.c  |  2 +-
>  arch/powerpc/mm/nohash/8xx.c                  |  2 +-
>  arch/powerpc/mm/pgtable.c                     |  7 ++++-
>  arch/riscv/include/asm/hugetlb.h              |  2 +-
>  arch/riscv/mm/hugetlbpage.c                   |  3 +-
>  arch/s390/include/asm/hugetlb.h               |  8 +++--
>  arch/s390/mm/hugetlbpage.c                    |  8 ++++-
>  arch/sparc/include/asm/hugetlb.h              |  8 +++--
>  arch/sparc/mm/hugetlbpage.c                   |  8 ++++-
>  include/asm-generic/hugetlb.h                 |  6 ++--
>  include/linux/hugetlb.h                       |  6 ++--
>  mm/damon/vaddr.c                              |  2 +-
>  mm/hugetlb.c                                  | 30 +++++++++----------
>  mm/migrate.c                                  |  2 +-
>  mm/rmap.c                                     | 10 +++----
>  mm/vmalloc.c                                  |  5 +++-
>  22 files changed, 80 insertions(+), 64 deletions(-)

Looks scary but it's actually a fairly modest patchset.  It could
easily be all rolled into a single patch for ease of backporting. 
Maybe Greg has an opinion?

