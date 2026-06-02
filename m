Return-Path: <linuxppc-dev+bounces-21895-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4AECD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 10:35:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV6fJ1vpBz2xy3;
	Tue, 02 Jun 2026 20:35:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780396504;
	cv=none; b=To4XCNkUnNxS8i2r8Qh5wQkzhsLhXgJtPVpdo3/F0RhxWHP2hiCVPJDwve1LNd53CUb7pPE3dxNPpGL/m+rzhEAun9vLAK9AT8Iw/DU0AXxywRm4nQzRUuN+wESrfOOS9su9ax/kA6dcu+puL+5576LFY3Oat+Gt4GFAzQR0NoY983hNA7a5Q0/PT85GfajVHokAGLzzav89xUSjWXPElPBUXJ5fhYV9dCScp5rOcxq0DbG8zhwRKlAH1YIy0RkgrW7EXjQL7+aXrxyWXcpjqBBCDSzmQVw0gLgRhohK2eokRAX92pc7eT8z6vky7Quh0YRVi4SEEAhYETfX2PZfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780396504; c=relaxed/relaxed;
	bh=NHXix/NGhOLLtCdUv2aad3HZZ/2TZlL5M+MCPpjSxAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7WgTvd2UnkEqWGBsie+dqUgy5pzIYntJRCvgSEKKxaXdVhK7a0BcC+c+ixdnhkRyIClaO12NaGI1rCZ2oQ9Mcblsc9XxGmwwTf9vFfJSErBPVONhlCvmO+LtGw8ZVgeXQSegyRxA2KI+Tvl98SP4HmazX8mpvWwhyi93jl2sWaQS+BoJsVjrqSo/pBia0/cJs6kHSx2uflEnun1xVMX7Er+akbRwKJ0S849uhS8YBOArFdk8yyRL2p+0TGBWuj9vRx2luhP9RauIGWfxv4n5sDdmkL4QetLINSyIxw4xSMvDIFic/NvttBO46X/xlqKtfVxxYn/3qu5k4rlHlAeiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1QPNacF; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1QPNacF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=osalvador@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV6fH3qb1z2xmX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 20:35:03 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5ECD460123;
	Tue,  2 Jun 2026 10:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9728A1F00893;
	Tue,  2 Jun 2026 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780396501;
	bh=NHXix/NGhOLLtCdUv2aad3HZZ/2TZlL5M+MCPpjSxAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A1QPNacFkmg/7zJxu6QOoX2GLYdw8tN33sDhuF92H1qLfcTPze8uiEv4QVMkInXcc
	 p9pu34+MWZbcdPFg+NR/XlWuMXNpzYreR3Z3Vy13x9TyTxX1wOL4KAu/35VBLtKoBU
	 TZc4gZLNF0b9luIcu02EYrIcomeY+Tg5+pJ4lglUn14MxH8riPDALVgjqdj73Z269B
	 cqEHsLPfk/lTVJu/4H6gr7Z5o6jTnxyrJfv+/rUVctLv+Yd5h5I5RDvcLqKk71Pj1f
	 trWavw/23hF66wXucjmfX+h/dpFh7Dtyuum8smZ2OghhDhLGP2EioJab2DJwURImTf
	 eWBZ+7zJk6KQA==
Date: Tue, 2 Jun 2026 12:34:53 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3 00/19] mm: Refactor bootmem gigantic hugepage
 allocation
Message-ID: <ah6xzZBh8IysNXpI@localhost.localdomain>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
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
In-Reply-To: <20260602101039.1867613-1-songmuchun@bytedance.com>

On Tue, Jun 02, 2026 at 06:10:20PM +0800, Muchun Song wrote:
> This series is split out from the earlier larger series "mm: Generalize
> HVO for HugeTLB and device DAX" [1]. It collects the first 19 patches of
> that series as a standalone set of fixes and preparatory cleanups around
> bootmem HugeTLB handling, sparse initialization ordering, and related
> vmemmap setup.

Thanks Munchun, this split out really helps easing the review.
I think not so many patches from this series scaped review, but I shall
get back ot it later this week.

 

-- 
Oscar Salvador
SUSE Labs

