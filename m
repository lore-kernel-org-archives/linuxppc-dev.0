Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DCB606A33D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMkwiY6D
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRk2k4fQcz3cCt;
	Sun, 15 Nov 2026 05:59:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794682798;
	cv=none; b=Pb3URZ6MZrZqJsUsI6Y9lmo9HWRieZWoRsgCKmMPS/1m/NV9MX9qIXQ8KbDnPRbslD3W4cZVytT3TIAHqfQfP/nkLOc+OJ7tF6SGKjcenfvys0Sj64TeZ1PD63jyx/o0AI5XdnqjxlVdEsqRPVVc4rKUHCiykoDl6VO3ZpfQeVFNwNXO6dcpfBA5Ou2zpQPNGDD1IVVFVuxt+5NKJrMfY4MPAzRAKPv/Bol8+e9Bty9LUdF4AEps35hAA+4Jl1tjjLNJSRlj4pz8zOvn6zdIx+p7kv8xv45dUWH6VFsTc4SRNYcGhbJMPpxyZHqOb20zWo1SG4OHa7XwIAlj9jDFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794682798; c=relaxed/relaxed;
	bh=aaNFykkpcP0cS9Qocp3fy2eSJ2KoYeW3YHSZ5vyz1zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvQ4jOdxoooV0TCuNA8Icv+QYa3zCGnDMaMtBkrxApflZe5ggTOAX6wC83Rx2dfsph3kenKZXhrWh0wNQnPDUKIuji2GesK/s/Q5P9bHvTePoXu4Tdy9FcycMx4wuhIGEUPcSyQlwUioM/1q2NVwRcfenOlutLkKQWExfWTB58QAb7XEplyMVCdJHlaLsgJlxNQLGc4mgzTJTmOGLy+EoleBRSdulpvqzRMvYRqwSgFMJbEn7cbcmqnnjhYrrlP9g6+Xokc64tVl3OmuFYqCsYrwgUjUAPq4Un7o7UzTpmr5z8GKP42L73l6Z2cboHTxxDnWnQfIvORSXEmZYPD9QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMkwiY6D; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XMkwiY6D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRk2j6HYgz3cBT
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 05:59:57 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 39F2943B15;
	Sat, 14 Nov 2026 18:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D9E1F000C5;
	Sat, 14 Nov 2026 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682796;
	bh=aaNFykkpcP0cS9Qocp3fy2eSJ2KoYeW3YHSZ5vyz1zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XMkwiY6DpCIGsfriwGOqAWiPbK24F3D6OKfV/wHCov4+5BCJ1Wsj6VNzuk3cUkr4X
	 zqFlsrkAIPyHinsg2xIoVAroHyZRHs/937xwsCZMYzDt0j3vdA/aNN6AL4a7Ar1UIm
	 xWDZmQtLLMAX/3EzhkLpQva8U9TmOwg1uj+/DyTBWHgO4u2uypjXye5kITKh10eT4Q
	 mXWVM0MJ0Gqja2R0B3NAtgAPW5LNXakn+kjO8cjKvWyMGjP2b69i85RrE6V0+H6sD4
	 Vh4tyCRczjK0QAiDfPX9j729otk3VF/cGRqHlIYeL36JIC/Ihszo0adHvWQDm09JGM
	 rwfddaTkgm1Sw==
Date: Sat, 14 Nov 2026 18:59:46 +0000
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
	dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/5] powerpc/spufs: consider vm_pgoff in
 spufs_mem_mmap_access()
Message-ID: <avivjtM2rxpUAXDB@gremlin>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
 <20261112-access_shite-v1-4-988a5c470db2@kernel.org>
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
In-Reply-To: <20261112-access_shite-v1-4-988a5c470db2@kernel.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 11:09:00PM +0100, David Hildenbrand (Arm) wrote:
> spufs_mem_mmap_access() calculates the local store offset relative to the
> start of the VMA and ignores vm_pgoff. After VMA splits, debugger reads and
> writes access the wrong part of the local store. Mappings created with a
> nonzero file offset have the same problem.
>
> Properly take the vm_pgoff into account, just like spufs_mem_mmap_fault()
> already does.
>
> Fixes: a352894d0705 ("spufs: use new vm_ops->access to allow local state access from gdb")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Seems sensible for similar reasoning for previous patch so:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/powerpc/platforms/cell/spufs/file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
> index 98c47bafaf678..0a46d6f7178ab 100644
> --- a/arch/powerpc/platforms/cell/spufs/file.c
> +++ b/arch/powerpc/platforms/cell/spufs/file.c
> @@ -248,7 +248,8 @@ static int spufs_mem_mmap_access(struct vm_area_struct *vma,
>  				void *buf, int len, int write)
>  {
>  	struct spu_context *ctx = vma->vm_file->private_data;
> -	unsigned long offset = address - vma->vm_start;
> +	unsigned long offset = address - vma->vm_start +
> +			       (vma->vm_pgoff << PAGE_SHIFT);
>  	char *local_store;
>
>  	if (write && !(vma->vm_flags & VM_WRITE))
>
> --
> 2.43.0
>

--
Cheers, Lorenzo

