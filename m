Return-Path: <linuxppc-dev+bounces-23382-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5B6C43602
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 11:16:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grZ83449gz2xdb;
	Thu, 02 Jul 2026 21:16:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.177
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782990979;
	cv=none; b=fuPow/6gRqxda4RChxRyoG5H3fjTebqsomTvJ6v7VhsyapfGH1qb+oETYdibPm0Pm6M1qx4fk/AS6DmrEGEXzgKMl5WuAhCgntiVYaxdvMEQtv9JWlKQCO7bCiW21G5rynGVIp9lWON9twpC+cLoh6swCfKs2w89IXr17NSJKXXPiAsx/qZSNoYixj3WVGK5Lfp1Gn3SzgEdk7+Qu/BStv+t3DyNIeIvHtu8RO6P4A7GuITkcOzZ/DxiIe0vA0gzLEREUtGSD5y8K2Nq0SE7ILAbDqEb5XzK1MoTZBCvXTtg8hOttSdtghWNASYqYzlCiCBos7BE2qFOFnC3bBv2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782990979; c=relaxed/relaxed;
	bh=MXoiAeiZxppUV0bbr36tbNoILtIVkAZHXOhXlmlq9aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L63AF34xXMdX8pVVNSd1dxxiR0Ta57WvKrmNRhisKRcK6AFjwtm4srLxeGeVZ6VUmSGgPzOgFTCeGs2PfrasRRPDOzY3CRwatinHWT1FJRFLTSjDero0ADNpr2RMDAw2EtPH5EjTuSDCV8OZvzD1AlK3LWhBW3KcPvNzk9OBbCRkQiA0dN3Bw06MJbzMV0yg4GJNsipTSyrzDd2OSHSLEw5ofwooq5elVtsJvh3Frquk8h2gJUYjuwI4LaOQojz0Pd+eadFWxUTggB7oY3CuoYXsmbys8ykGlKwb05s4xGEfTgc2S34PCVJjqMBoqWFQJWlvuPJu+4gYqp3+fArmKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SNO+TI3y; dkim-atps=neutral; spf=pass (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SNO+TI3y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.177; helo=out-177.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 68768 seconds by postgrey-1.37 at boromir; Thu, 02 Jul 2026 21:16:16 AEST
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grZ801gWvz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 21:16:14 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782990951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXoiAeiZxppUV0bbr36tbNoILtIVkAZHXOhXlmlq9aE=;
	b=SNO+TI3ysBG4+DhR3hPTF1SvhO32c4IR52yjAPmkR78MakGGmD/cQOYIcE8MmMX2BXfJ/B
	PngJwUk8MPDHueMWfaVQgxbOjSa6VTjHZniUa88SClGCvA5JNzJYRen32CdMAokXiIgXtC
	8TVZTPLK3UhpO1X2vjoT/Jd84+uq0gc=
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	tsbogend@alpha.franken.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	l.stach@pengutronix.de,
	inki.dae@samsung.com,
	sw0312.kim@samsung.com,
	kyungmin.park@samsung.com,
	krzk@kernel.org,
	peter.griffin@linaro.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	robin.clark@oss.qualcomm.com,
	lumag@kernel.org,
	lyude@redhat.com,
	dakr@kernel.org,
	tomi.valkeinen@ideasonboard.com,
	hjc@rock-chips.com,
	heiko@sntech.de,
	andy.yan@rock-chips.com,
	thierry.reding@kernel.org,
	mperttunen@nvidia.com,
	jonathanh@nvidia.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	zack.rusin@broadcom.com,
	matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	oleksandr_andrushchenko@epam.com,
	deller@gmx.de,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	hughd@google.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jannh@google.com,
	pfalcato@suse.de,
	kees@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org,
	xen-devel@lists.xenproject.org,
	linux-fbdev@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 02/13] mm/vma: update do_mmap() to use vma_flags_t
Date: Thu,  2 Jul 2026 19:15:31 +0800
Message-Id: <20260702111531.64883-1-lance.yang@linux.dev>
In-Reply-To: <e0ac58ad2b88ff7e2f0024e3286b2e786f79ca32.1782760670.git.ljs@kernel.org>
References: <e0ac58ad2b88ff7e2f0024e3286b2e786f79ca32.1782760670.git.ljs@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, Jun 29, 2026 at 08:25:25PM +0100, Lorenzo Stoakes wrote:
>The core do_mmap() function accepts a vm_flags_t parameter which it then
>manipulates before passing to mmap_region() to do the heavy lifting of the
>memory mapping.
>
>Update do_mmap() to instead accept a vma_flags_t parameter, and adjust all
>the logic within do_mmap() to manipulate this instead.
>
>This is as part of the ongoing effort to convert VMA flags from a system
>word size to a bitmap type which allows us to unrestrict the number of VMA
>flags, as well as gain control over how VMA flag manipulation occurs.
>
>We do not cascade these changes to all functions which accept vm_flags_t,
>but rather use vma_flags_to_legacy() where necessary, specifically
>deferring converting calc_vm_prot_bits(), calc_vm_flag_bits() and
>__get_unmapped_area() to vma_flags_t.
>
>Also utilise the new vma_flags_can_grow() predicate which correctly handles
>the case of architectures without upward growing stacks.
>
>As part of this change, introduce VMA_SHADOW_STACK so we can correctly
>handle the case of the shadow stack not being defined.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---

Not exactly a small one :) I stared at this patch for a while, hopefully
don't miss anythig ...

Just one tiny nit below. Overall, LGTM, feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

[...]
>diff --git a/mm/mmap.c b/mm/mmap.c
>index 46174e706bbe..547352183214 100644
>--- a/mm/mmap.c
>+++ b/mm/mmap.c
[...]
>@@ -488,23 +496,27 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> 		 * Check to see if we are violating any seals and update VMA
> 		 * flags if necessary to avoid future seal violations.
> 		 */
>-		err = memfd_check_seals_mmap(file, &vm_flags);
>+		err = memfd_check_seals_mmap(file, &vma_flags);
> 		if (err)
> 			return (unsigned long)err;
> 	} else {
> 		switch (flags & MAP_TYPE) {
> 		case MAP_SHARED:
>-			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
>+			if (vma_flags_can_grow(&vma_flags))
> 				return -EINVAL;
> 			/*
> 			 * Ignore pgoff.
> 			 */
> 			pgoff = 0;
>-			vm_flags |= VM_SHARED | VM_MAYSHARE;
>+			vma_flags_set(&vma_flags, VMA_SHARED_BIT, VMA_MAYSHARE_BIT);
> 			break;
>-		case MAP_DROPPABLE:
>-			if (VM_DROPPABLE == VM_NONE)
>+		case MAP_DROPPABLE: {
>+			vma_flags_t droppable = VMA_DROPPABLE;
>+
>+			if (vma_flags_empty(&droppable))
> 				return -EOPNOTSUPP;
>+			vma_flags_set_mask(&vma_flags, droppable);
>+
> 			/*
> 			 * A locked or stack area makes no sense to be droppable.
> 			 *
>@@ -515,23 +527,24 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> 			 */
> 			if (flags & (MAP_LOCKED | MAP_HUGETLB))
> 			        return -EINVAL;
>-			if (vm_flags & (VM_GROWSDOWN | VM_GROWSUP))
>+			if (vma_flags_can_grow(&vma_flags))
> 			        return -EINVAL;
> 
>-			vm_flags |= VM_DROPPABLE;

Old code checked VM_GROWSDOWN|VM_GROWSUP before seting VM_DROPPABLE. New
code flips that around. Hmm, shouldn't master, just made me look twice ;)

Maybe keep old order?

Cheers, Lance

>-
> 			/*
> 			 * If the pages can be dropped, then it doesn't make
> 			 * sense to reserve them.
> 			 */
>-			vm_flags |= VM_NORESERVE;
>+			vma_flags_set(&vma_flags, VMA_NORESERVE_BIT);
> 
> 			/*
> 			 * Likewise, they're volatile enough that they
> 			 * shouldn't survive forks or coredumps.
> 			 */
>-			vm_flags |= VM_WIPEONFORK | VM_DONTDUMP;
>+			vma_flags_set(&vma_flags, VMA_WIPEONFORK_BIT,
>+				      VMA_DONTDUMP_BIT);
>+
> 			fallthrough;
>+		}
> 		case MAP_PRIVATE:
> 			/*
> 			 * Set pgoff according to addr for anon_vma.
[...]

