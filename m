Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD45606A327
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFXT4w+R
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRjyc1lC5z3c7K;
	Sun, 15 Nov 2026 05:56:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794682584;
	cv=none; b=ZLKvWH9jAkaczmHhl1Cn/brBiTZUgIFM59QbDPgDo36s4Tt71HOhubDkdeVF774Mujak4mb1eHrg3Q2ItkOQMH5s5C6LyvDqECxa8CjFwMNiSNqLeG9tNHegJ/2WRySAteOApx2igZmsZk//MOy1oieLYq5cFCG+p5X94Pelr2pcqyCXYls+sarClPD1Vo5XR2AT8TnVrob/X3xiy2A9TJnOm9GXHNVzHQYnR+BiB36AaokEmLDjguQymD0npowoPICmt2fMjSjOYVBLBXyEVGMs/SRsDUQmJlq1jTKZ9GgZiABTlD8y8p3zqfE58u6qtHXik6HX/zJTqDzusqqU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794682584; c=relaxed/relaxed;
	bh=//GruLIthFISZCy43B0WDxoPfxAVchEQzL1ze90Ia1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYfywGhVf51qrDKotJrUWEP/xIi0YJB9iHQMK2P6l7ZkRZJJb4+XlfMcPxwBU3f4vpp4gpqww79zlmfBkUYv2IBnXpg6uAIIn3A0MNwalHcdIiAgxzxOUnn4TiWVGBCTf3yht0QhIak+TLnQOouroucrgicemqt4sHbDDOHUdZKzQXVLtomMtnXzBS+qfYBKDA0NRKaoS4JO657NINCgAAYek0W2uRDwo2i6uxzbh8Jaxurqofa/mSTNT8RxGxxC5n4DtjrbRU9WroRJrEt5RO0ShPRucBlP/SLBCG2ghU/Amdd/GttKbLTal2MTViJEKjScG+6XjlhMU1DzVFbp1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFXT4w+R; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hFXT4w+R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRjyb0Pptz3byk
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 05:56:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4E18561265;
	Sat, 14 Nov 2026 18:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC5C1F000C4;
	Sat, 14 Nov 2026 18:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682580;
	bh=//GruLIthFISZCy43B0WDxoPfxAVchEQzL1ze90Ia1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hFXT4w+RF00hYPkv+JLeIEZAjbBCTc5CY95xB7nG2ZeZC6xVNc/tyLfLCXLXXfzU/
	 0xwjpH4uqHfJv3b9jTPfEDI05f7epSGY7WNGrFU65nrM599kdWjAEstILA4u/ArbNH
	 FTR5pcJyhgtGykdCgnB9yTDQlTEGPmVB2LhUyMM/DydIocWWISlDCPO5SdDwgRJIHN
	 4wq5xnK84S73I5MUqu84dXHgKrRnMmjnl0JRhFS++dhSPVoIn0UZspmNkPF5QG60KR
	 Pr81J5yjOzly8Xwkbx+5AcxopvUR+FkweegBHOBezVZ17Bld0ubFOCo/dvixMRJFbK
	 Aqop4pp6GTflA==
Date: Sat, 14 Nov 2026 18:56:10 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chris Wilson <chris@chris-wilson.co.uk>, Matthew Auld <matthew.auld@intel.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Rik van Riel <riel@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: do not call vm_ops->access with FOLL_ANON
Message-ID: <aviukG1XPZw2Rja9@gremlin>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
 <20261112-access_shite-v1-1-988a5c470db2@kernel.org>
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
In-Reply-To: <20261112-access_shite-v1-1-988a5c470db2@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 11:08:57PM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
>
> Reading /proc/<pid>/cmdline or /proc/<pid>/environ can block in a device
> driver, or read device memory, if the virtual addresses point at a device
> mapping.
>
> Ever since commit 7f7ccc2ccc2e ("proc: do not access cmdline nor environ
> from file-backed areas") we use FOLL_ANON to only read from anonymous
> memory. While GUP properly handles FOLL_ANON, __access_remote_vm()
> will fall back on GUP errors to vma->vm_ops->access() without similarly
> considering the flag.
>
> Fix it by not calling vm_ops->access if FOLL_ANON was specified, to
> truly limit it to anonymous memory only.
>
> Fixes: 7f7ccc2ccc2e ("proc: do not access cmdline nor environ from file-backed areas")
> Signed-off-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org
> [ david: simplify description; slightly rework implementation ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/memory.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 1a0ec09c56fd7..d4370c1b331c9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7398,6 +7398,9 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  				continue;
>  			}
>
> +			if (gup_flags & FOLL_ANON)
> +				break;
> +
>  			/*
>  			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
>  			 * we can access using slightly different code.
>
> --
> 2.43.0
>

--
Cheers, Lorenzo

