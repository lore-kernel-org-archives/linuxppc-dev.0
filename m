Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50385606A32F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRsQH68f
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMNdx71Vmz2xrC;
	Sun, 08 Nov 2026 04:41:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794073317;
	cv=none; b=UFSlmojRyqwwAV28kjaRScUrI9rT4Az10r1ZOeXBn9aVa2P1TPnY9+Mx2ATFq/PVCvj2FCKN4l8IaIYOMqWCiTB5234J19gA+N9sGNZ61KIw8j5wRNR9CqaUMkPv43uT2dlC5Y/c5idRGbRSFTMduoe89NKO8SYyd7Im8AzxNXvxWx/ZJDjrNn5aYySYU6RDK0JbcQCQO+F+iv38KsXtwQjKB6k1M30Zhjxa8qPHjHbY/QF8zFv1nvElY3GQLRVxuVdcgjHbefAtQK/BVA244kL4+xznU8Ijt30ar6SCwo1WQPc5P+KpXLHcTXFwjFn3OelPsL3GZQmMAO71j2bguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794073317; c=relaxed/relaxed;
	bh=2smR8h1VY8UC7VVz5oqEi+bHmSa6sUXSBdFSQ0jzot0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7D9dsea3HNPMpNMhQvlgwZh+T2q2WvMcFMRU2NnA74n+bKTkx0962kxDtobhdHmyk+0lEkrMe8M2X28NQFDrfb/QJVXkSI11tG3Uz4pz/3DvqBNUp7fASdlNxTqCI1ODNd/V/xFIvERn5pDaQbX62kT/DxGaEFAEhBp1u59PZ9Cb2yQpndOrqoGdy5c3lTAx6rnloRkDsooDMPUGmYjl0Me5EOIw7Lq/xj2ixmxCkFXXHGO3beT+YOQR5EJ4rBz3o4IDOjBZcvJtlcjtXoJmnD7MNVLM+KracTqMkpgs1hbfOIjtWZhxoGMmKZu6laDZuiBFmbhibcIX2FYdsExzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRsQH68f; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HRsQH68f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMNdx1RWlz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 04:41:57 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 27E4640086;
	Sat,  7 Nov 2026 17:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19951F0089F;
	Sat,  7 Nov 2026 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794073315;
	bh=2smR8h1VY8UC7VVz5oqEi+bHmSa6sUXSBdFSQ0jzot0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HRsQH68fYsmt/YqRKnGb7j9+ZUn/BT15BJaZIFXTUVXUP3ixFLBWVgTbJU6W8sJpS
	 b1fCpxzQFDVR2VJSr2R8zzA4uJoZdaIK0pmjvTM5lACaj4AJ7F874TXs2E62xNfRn9
	 L5SR2J84VJFqjLNK97AGzyBA0Ut29SeanbpUSwqtHzIqfGJ1wHFQCwrSmOOG0/hr64
	 1IfxE5CLwKht2cP+gI6KyqwZ4xjSA0Mx4E7dLsA3LP5pk3KX25TULgFopV3s/ukW5u
	 KabHjycL3hyF/UFtHzldk64LubWRNFGj7GoutJ/5UALUefJc+nTjsr7J1+bPnfoGCg
	 7ItmzA7G+8f3A==
Date: Sat, 7 Nov 2026 18:41:46 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Oscar Salvador <osalvador@suse.de>, Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
Message-ID: <au9i2uHBRVP27pbp@localhost.localdomain>
References: <20261107043122.25650-1-songmuchun@bytedance.com>
 <20261107043122.25650-3-songmuchun@bytedance.com>
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
In-Reply-To: <20261107043122.25650-3-songmuchun@bytedance.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 12:31:19PM +0800, Muchun Song wrote:
> Whether the optimized mapping can be used is now decided in the
> architecture-specific vmemmap_populate() path. When PowerPC has to fall
> back, such as on Hash MMU, it can disable optimization for the populated
> vmemmap range there.
> 
> Add section_vmemmap_optimization_disable() to centralize this fallback,
> use it in the Hash MMU path, and drop the radix-specific
> vmemmap_can_optimize() override.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

I was about to complain why you do not go ahead and drop vmemmap_can_optimize
but then I saw patch#4 :-)

 

-- 
Oscar Salvador
SUSE Labs

