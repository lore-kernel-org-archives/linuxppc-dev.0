Return-Path: <linuxppc-dev+bounces-23311-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58506C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 16:16:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gr4rq4ws1z2yfS;
	Thu, 02 Jul 2026 02:16:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782922587;
	cv=none; b=AnDZhHJKnh0/aDy+pD9t5aqVYM51ni0zP9KwY/RImP5HiEMUP/TDxPx+y6fv1caLvn7wNekhwtRDIUHAwARCO1aipqWChNryFfhJ3TCu8AK5rY30qkfwJ4++Jf75v33npifH7pbtnuTDBgL9T3/TozOMhCT8d74ZKcgLBj58PvMO0zpN4L1762tHwXJWjwC9vMYY34RzeNJ9clTh9PZOYua7GCfa6VHGGlv7+DsIBae6ClOmHeqxOyKYTF0Y2UMOfkygeDGSu4AYmJF8SdVl71cBX84oTI3+fY9KdRaV8hoc2cDxt7u06JNuxOCsE0Tk+FUecf0XNyomyQNmupCzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782922587; c=relaxed/relaxed;
	bh=32k3xy2qoDs5v558QiIXDOBJrw4XcLaI228zHYcvJQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAVt6U17N65bLmJjWbP3Xcm0O8e+Oe2QVxg495vLeIskxHZ7fXIcnbc1g5tjUtjLonqB7KMqvtIQGtUbVAAgtitB/dWup4kOPaKJVlmPCZvO9L68bsLGoyI3IOjBoQho8vOIN0sd/6G4vXTeKtaUi9sYaCHWBY42FE3qicfZ2nGGFFWnfUn0xg+Cfp8BeecVRdd0+h2gjuy2XtjPL+YZ2Vi+DZTaKWbhpexzGSDTBesqq/NOY5YE6Ua+XSj+xVfBLW0vqA3Q1acnJ890FtPAnDsiyyYn02XzFXBvlinkvckEyyF2s6YJMAERicZW3CW1NsOskSx/bBKtCd2nZe88Og==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GKsigi9j; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b4; helo=out-180.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GKsigi9j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b4; helo=out-180.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 365 seconds by postgrey-1.37 at boromir; Thu, 02 Jul 2026 02:16:21 AEST
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gr4rj4SVdz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 02:16:21 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782922180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=32k3xy2qoDs5v558QiIXDOBJrw4XcLaI228zHYcvJQI=;
	b=GKsigi9jw5iEZkRAOu0U35OCwwNX+WFYQBJnw1VnjqCFwAV1xkeG5HVPPXjVerUIFCpvkl
	1sYFG/+4cZNO5RnH+3ZGNEajZyzEn2vDXqeNcTTch6ZM0ZT3P4Eo/8D1DaouN8eSB+B2FA
	bvbtO9Gx6J4K8rZ0y4m06I1Z9Hu4ibM=
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
Subject: Re: [PATCH 12/13] mm/mprotect: convert mprotect code to use vma_flags_t
Date: Thu,  2 Jul 2026 00:09:17 +0800
Message-Id: <20260701160917.91435-1-lance.yang@linux.dev>
In-Reply-To: <7ef626d8a12dc742cfc09d080be5dc09850e873a.1782760670.git.ljs@kernel.org>
References: <7ef626d8a12dc742cfc09d080be5dc09850e873a.1782760670.git.ljs@kernel.org>
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


On Mon, Jun 29, 2026 at 08:25:35PM +0100, Lorenzo Stoakes wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values
>throughout the mprotect logic.
>
>Note that we retain the legacy vm_flags_t bit shifting code in
>do_mprotect_key(), deferring a vma_flags_t approach to this for the time
>being.
>
>Additionally update comments to reflect the changes to be consistent.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---
> mm/mprotect.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/mm/mprotect.c b/mm/mprotect.c
>index 9cbf932b028c..c9504b2a2525 100644
>--- a/mm/mprotect.c
>+++ b/mm/mprotect.c
>@@ -40,7 +40,7 @@
> 
> static bool maybe_change_pte_writable(struct vm_area_struct *vma, pte_t pte)
> {
>-	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
>+	if (WARN_ON_ONCE(!vma_test(vma, VMA_WRITE_BIT)))
> 		return false;
> 
> 	/* Don't touch entries that are not even readable. */
>@@ -97,7 +97,7 @@ static bool can_change_shared_pte_writable(struct vm_area_struct *vma,
> bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
> 			     pte_t pte)
> {
>-	if (!(vma->vm_flags & VM_SHARED))
>+	if (!vma_test(vma, VMA_SHARED_BIT))
> 		return can_change_private_pte_writable(vma, addr, pte);
> 
> 	return can_change_shared_pte_writable(vma, pte);
>@@ -194,7 +194,7 @@ static __always_inline void set_write_prot_commit_flush_ptes(struct vm_area_stru
> {
> 	bool set_write;
> 
>-	if (vma->vm_flags & VM_SHARED) {
>+	if (vma_test(vma, VMA_SHARED_BIT)) {
> 		set_write = can_change_shared_pte_writable(vma, ptent);
> 		prot_commit_flush_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes,
> 				       /* idx = */ 0, set_write, tlb);
>@@ -811,8 +811,8 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
> 		vm_unacct_memory(nrpages);
> 
> 	/*
>-	 * Private VM_LOCKED VMA becoming writable: trigger COW to avoid major
>-	 * fault on access.
>+	 * Private VMA_LOCKED_BIT VMA becoming writable: trigger COW to avoid
>+	 * major fault on access.
> 	 */
> 	if (vma_flags_test(&new_vma_flags, VMA_WRITE_BIT) &&
> 	    vma_flags_test(&old_vma_flags, VMA_LOCKED_BIT) &&
>@@ -886,7 +886,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
> 			goto out;
> 		start = vma->vm_start;
> 		error = -EINVAL;
>-		if (!(vma->vm_flags & VM_GROWSDOWN))
>+		if (!vma_test(vma, VMA_GROWSDOWN_BIT))
> 			goto out;
> 	} else {
> 		if (vma->vm_start > start)
>@@ -894,7 +894,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
> 		if (unlikely(grows & PROT_GROWSUP)) {
> 			end = vma->vm_end;
> 			error = -EINVAL;
>-			if (!(vma->vm_flags & VM_GROWSUP))
>+			if (!vma_test(vma, VMA_GROWSUP_BIT))

IIUC, should this be

if (!vma_test_single_mask(vma, VMA_GROWSUP))

instead?

#elif defined(CONFIG_PARISC)
#define VM_GROWSUP	INIT_VM_FLAG(GROWSUP)
...
#ifndef VM_GROWSUP
#define VM_GROWSUP	VM_NONE
...

VM_GROWSUP is only defined as GROWSUP on parisc and becomes VM_NONE
elsewhere. But VMA_GROWSUP_BIT is the raw ARCH_1 bit, which is also used
for other arch-specific VMA flags:

	DECLARE_VMA_BIT_ALIAS(SAO, ARCH_1),		/* Strong Access Ordering (powerpc) */
	DECLARE_VMA_BIT_ALIAS(GROWSUP, ARCH_1),		/* parisc */
	DECLARE_VMA_BIT_ALIAS(SPARC_ADI, ARCH_1),	/* sparc64 */
	DECLARE_VMA_BIT_ALIAS(ARM64_BTI, ARCH_1),	/* arm64 */
	DECLARE_VMA_BIT_ALIAS(ARCH_CLEAR, ARCH_1),	/* sparc64, arm64 */
	DECLARE_VMA_BIT_ALIAS(MAPPED_COPY, ARCH_1),	/* !CONFIG_MMU */

Other vma_test() changes look fine to me: just fixed INIT_VM_FLAG()
masks matching their VMA_*_BIT :)

Cheers, Lance

> 				goto out;
> 		}
> 	}
>@@ -918,7 +918,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
> 		}
> 
> 		/* Does the application expect PROT_READ to imply PROT_EXEC */
>-		if (rier && (vma->vm_flags & VM_MAYEXEC))
>+		if (rier && vma_test(vma, VMA_MAYEXEC_BIT))
> 			prot |= PROT_EXEC;
> 
> 		/*
>-- 
>2.54.0
>
>

