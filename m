Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E2606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPk2Chlf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZyGD6N5Fz2xl0;
	Fri, 27 Nov 2026 00:35:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795700100;
	cv=none; b=cXE7TownzAaQw26KcucfHN/hHSELKk4/J6puDwaIPKe1o/HitQwcQr9BdBzBGawJezV9pi4IJpkn4N0MaOTnEJgLCp+qjYW/WnQQ6vFGvHOCiho7evYLEJY/9boYMtiBiJhkY/sOCVBXcd329xa5tCc05RrsLJtQvQJdN3Culv/n/COey7NYVLLHTeZgGICgF58PuCtnFlaeKbb221XcfhE8eEyCTXy++j/TYZrt+TOjsOXkRtO3uKZJtEPZFKQtpn1PEIWIKdfq9Lk+a/K5lldAJ9eZ1KPD/YG05H0wHVjqWyIGg009xo/7B4eCmdrWSUAbY/TPzhDLCHauKJKhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795700100; c=relaxed/relaxed;
	bh=DOZLBVC8e5T2seSjbwKw7gp2SlRqgI2Mm69LObxIeMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Cj1kX8xRIuflKqWKQtijnffAg6dItvNeF9EplfWFb9t3CxFsbKOG5j5AiyGhuWajB3LOEsiH66XhR9NWUZ41SAptUgmYXNF/nUFOPVSRekTC1iQc2abluzOPqQZJ0rfNzaP9r6zCn+u2O23JxkwrxsbFlbjWDReZU//v9oGortQPx9auyOKfp6/T0hwBc8W99ZuIAZ27D0oFWTJ8I8BMNqFlIO629/jVkR+5KatG6Cn7AM+9dD/wXl7hYJg3zHdgZ0k9TdAeTTZzxuY6lP4G/bjKqYKhe2JlRNDAw8nMlbYK6XPJ/fXAv5jOZ5UCtfi6m570zo8cCbtFHLlkR/Cz4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPk2Chlf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPk2Chlf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZyGD0nVKz2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 00:34:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B157F61F63;
	Thu, 26 Nov 2026 13:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4DD1F000CF;
	Thu, 26 Nov 2026 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795700097;
	bh=DOZLBVC8e5T2seSjbwKw7gp2SlRqgI2Mm69LObxIeMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jPk2Chlfcc+IlMa6Se9qcdVl2MRCZbIG269JsvJ0CbIPZDz1JU66TuQAA+AdJsV1l
	 EGBJzAt2tG/NXMaeDYV5+L1mbNwUYHX79mfAL7PFBE1yOI9FXZMu5ZnJpALpNFlspo
	 PhQElUGVk9bMqYQYZNxJfEMMT/u+h/gDiw4JtJEB9uyQ9SLhjcjEiS/69Nk/tBchK4
	 CeMAzFSbcQhGowxJ3XYiefjwuQBdtmlXkn2cSgsGEv047zb/vAEEySltSxicUCiGFv
	 H2dljJBG7iaK6A798ZvQHvmgTXoD6t+GSL1+JrBDQiahVEzAdecunEzQXBcnCrgfWH
	 2ee3yQ7ER6sGA==
From: David Hildenbrand <david@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Willy Tarreau <w@1wt.eu>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linuxppc-dev@lists.ozlabs.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
References: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
Subject: Re: [PATCH v2 0/4] mm,drm/i915,powerpc/spufs: vm_ops->access
 related fixes
Message-Id: <179570008611.16270.17870262980565551144.b4-ty@b4>
Date: Thu, 26 Nov 2026 14:34:46 +0100
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 18:55:17 +0100, David Hildenbrand (Arm) wrote:
> While working on vm_ops->access related fixes in core code for FOLL_ANON
> and VMA access permission + size handling, I stumbled over two driver
> issues.
> 
> Fixing it all in this series, because it's all intertwined. Only allow
> FOLL_FORCE to bypass VMA permissions, similar to what GUP does for other
> VMAs.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: core-7.5.access

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/4] mm: do not call vm_ops->access with FOLL_ANON
      https://git.kernel.org/mm/core/c/775abaa4
[2/4] drm/i915: consider vm_pgoff in vm_access()
      https://git.kernel.org/mm/core/c/95553038
[3/4] powerpc/spufs: consider vm_pgoff in spufs_mem_mmap_access()
      https://git.kernel.org/mm/core/c/50df2688
[4/4] mm: check permissions and bounds for vm_ops->access
      https://git.kernel.org/mm/core/c/8ef1926a

-- 
Cheers,

David


