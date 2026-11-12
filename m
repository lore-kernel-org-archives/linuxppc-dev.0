Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B227E606A885
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 11:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JShWTYBw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQJhY2WZSz2xmV;
	Thu, 12 Nov 2026 22:54:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794484461;
	cv=none; b=M9h1xXn2aNUcN9Guld5lZtHqalwuKFMyfTknuhF3xfmSvxtjiRBrz6pAF1xJXslbHLvHvugRwMjFTqoEVbyTXp+83e3vEumA64a4t1ZuamosVpGTFYQVko3DZI5RhfjiDvMPl3WuLDAETQMS27Ao7YvzzDXOdG90mrQeqSvAIrb3NaOkEq+nXVSjooQVVRwHThbVEro0drVpEc4mcPog2bnRWfDMEHuc9+e5KnrOjIs7uFUK0wZ/ewnBlbVS6Z+vpjJAzMoxQVUk5CwHOolV7k9oR0HQC4vn9ybeQi+ZtJBrm/3mM19f7pYIO/tOb5lhpbmnUFQKFZS8vBbuY2SFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794484461; c=relaxed/relaxed;
	bh=AXwEBWpVcpvZcrV+jXWqjYnIWZkbHRe6QYcaP4OKLgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6huESY5mFGEismziIrM89I8xjvJkIDkYG6dE9mowbuNVsmFD/W30WGhFOdUUGi6M4CvS0e0jHgqiAL3H2wTXwXwLLfntaEajrcDW4gvQBMpdWumsX4muPv0DiWZFjhFujV6chO/pMaexAkyoF+XA6XC1CJ1gtikY2JoqCogVOPMQq99315FOO7UgJAFVsCZeI7j0GMjoiwQprwPIb23B6brNYWF5+KkfB7VWJt4vKOzN5i6twCVHAF3grgU26PN83fzleYm4tnoEf6aSdmyYr63915H6BA1b5GBIaCeea3hTWX0pZyPjHpAgVGsqFd8q2nQ2mGcX9K9maulBzeUvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JShWTYBw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JShWTYBw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQJhX1Lkdz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 22:54:19 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CAA5361CEA;
	Thu, 12 Nov 2026 11:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A951F00A05;
	Thu, 12 Nov 2026 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484457;
	bh=AXwEBWpVcpvZcrV+jXWqjYnIWZkbHRe6QYcaP4OKLgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JShWTYBwz3T1m0D+gMlzyAXZUOV5lZTEdKWEmPLNzsIRW+v6wGYjzrWz/3a+qlIIh
	 uHEBwZWTzfI+8nM1pcwM53SGkhGVtDsLBHshuYSxtzNG61JCXbS2MprM5hV/RW220H
	 EL1fsA/x1UUGroAbYZBw+qSGfyZB4AOspBYFjnzgVnaVolzaeMfQXuiyzSNiu/Vp5y
	 FZk8uOr8DWU5XDcsKIwXsglFSq2MXx57+zvKA08GWuWTcIghT/EEC8a7yprTEzE1K1
	 C3sWmvVFn06QL/mupd6DGhe9ParugCE3t4qUWqqEJB1lwXJ/5dePwtcAucWejA+WvE
	 v93jIoibDc7rw==
Date: Thu, 12 Nov 2026 13:54:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 4/6] mm: drop HIGHPTE support altogether
Message-ID: <avWo4NrAPX8BisCY@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-5-arnd@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112112528.1116405-5-arnd@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 12:25:26PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With both x86 and arm having dropped CONFIG_HIGHPTE support, no
> architecture is left using it, so remove the remnants in common code.
> 
> It is likely that further cleanups are possible in the page table
> code but those are not obvious from the config options.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/hugetlb.h | 5 +----
>  include/linux/mm.h      | 1 -
>  include/linux/pgtable.h | 9 ---------
>  3 files changed, 1 insertion(+), 14 deletions(-)

With this and arm HIGHPTE patches applied there are still a few leftovers:

$ git grep  HIGHPTE
arch/arm/configs/vt8500_v6_v7_defconfig:CONFIG_HIGHPTE=y
mm/memory.c:     * Dumping the PTE would be nice, but it's tricky with CONFIG_HIGHPTE,
mm/pgtable-generic.c: * kmapped if necessary (when CONFIG_HIGHPTE), and locked against concurrent
mm/userfaultfd.c:        * index ordering when CONFIG_HIGHPTE is enabled. We mapped dst_pte

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

