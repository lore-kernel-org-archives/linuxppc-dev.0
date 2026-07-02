Return-Path: <linuxppc-dev+bounces-23399-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B99C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 13:22:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grcx53ZxMz2yd7;
	Thu, 02 Jul 2026 23:22:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.186
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782998521;
	cv=none; b=amPQeICMMVv23NIOZRA2uZF41o3Z5Cq4XZWodV7RPm1Px1quBu/5MqP7p1DsFM01yaBc2eVU73OV/GqmnKw3IISt9+OL9qIFw+WgAnw7jNGOnV9knNAWsltawpw6fJbVntCKuSEI9CPQpc2VHEVruvOA9IE08G5HGMmIEtpmprVXtIJJCXUpCFEPOvWCx3EKvYxk4EYR/LgXzWH0ecJ4JE+lHpbaJ8xMr6idbVsJRKa7cykOjY8hphDTRCdfqhB9AcARxe7VZDjx6Tx77SD2unGq1WRi8Umy/5T6kB4nHe0Gi6H/QFpkyFHbH7KskdooTLJoY9ZrwlKDKsaki08eiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782998521; c=relaxed/relaxed;
	bh=JUypSg4x3H5Npdac5Q/QNTHcczAl9LnBdMVXVWinEec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uhes2LERcz/M6wmYmacvVVzp8Gq39LV7Iia1AJuSoufXaKO/Xczrm2smxQUi0zPNglp70266jenOPL6sFTSv1ZGXCy4mJpgmnuM/fLLuyWJLSuDhuYDc3RoZzLBEt2t3mJ/dMznXoCA0V3j017sclCcAPZVzS5cjHIBJx2P689r3vkhEPnzE+f/9FzcDEGyvzh06qD/kUV/6l+omlHz5Th6EG1mTwzaSZ9jlBF2HY+WJnWG0IoPWtpbobtY644ywvLwhDZRAMHtaHdBepS5I+DLwtVDdtE4TQxyQn20hlcudntmxZ2greN7VwjXlOH5+XYLLCM/HhXYny0ZTaQRAUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lItd+RyL; dkim-atps=neutral; spf=pass (client-ip=91.218.175.186; helo=out-186.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lItd+RyL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.186; helo=out-186.mta0.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grcx4499bz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 23:22:00 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782998499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUypSg4x3H5Npdac5Q/QNTHcczAl9LnBdMVXVWinEec=;
	b=lItd+RyL3jRAHkpl0dxrPEWed2AY0HWUHX4RwICujMLfpbUgWjWjW+ARImTVfb6PHm9Sny
	y6V8i67fWjOA8LCWLGCzxRy43+gvonIsLNLIP4rLaMNI+LWR2I1BadswAi+4/7c6z/eUrS
	IlFVPIdu28UO/M5UjVs/++abx0FKfS4=
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
Subject: Re: [PATCH 11/13] mm/mlock: convert mlock code to use vma_flags_t
Date: Thu,  2 Jul 2026 21:21:07 +0800
Message-Id: <20260702132107.73727-1-lance.yang@linux.dev>
In-Reply-To: <2db16db81538355ca65f778c246d2381c673cad4.1782760670.git.ljs@kernel.org>
References: <2db16db81538355ca65f778c246d2381c673cad4.1782760670.git.ljs@kernel.org>
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


On Mon, Jun 29, 2026 at 08:25:34PM +0100, Lorenzo Stoakes wrote:
>Replace use of the legacy vm_flags_t flags with vma_flags_t values
>throughout the mlock logic.
>
>Additionally update comments to reflect the changes to be consistent.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
>---

Nothing scary jumped out at me. Just one tiny nit below ;)

[...]
>@@ -466,24 +466,23 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
>  */
> static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
> 	       struct vm_area_struct **prev, unsigned long start,
>-	       unsigned long end, vm_flags_t newflags)
>+	       unsigned long end, vma_flags_t *new_vma_flags)
> {
>-	vma_flags_t new_vma_flags = legacy_to_vma_flags(newflags);
> 	const vma_flags_t old_vma_flags = vma->flags;
> 	struct mm_struct *mm = vma->vm_mm;
> 	int nr_pages;
> 	int ret = 0;
> 
>-	if (vma_flags_same_pair(&old_vma_flags, &new_vma_flags) ||
>+	if (vma_flags_same_pair(&old_vma_flags, new_vma_flags) ||
> 	    vma_is_secretmem(vma) || !vma_supports_mlock(vma)) {
> 		/*
>-		 * Don't set VM_LOCKED or VM_LOCKONFAULT and don't count.
>+		 * Don't set VMA_LOCKED_BIT or VM_LOCKONFAULT and don't count.

s/VM_LOCKONFAULT/VMA_LOCKONFAULT_BIT/

Otherwise LGTM. Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>

> 		 * For secretmem, don't allow the memory to be unlocked.
> 		 */
> 		goto out;
> 	}
> 
>-	vma = vma_modify_flags(vmi, *prev, vma, start, end, &new_vma_flags);
>+	vma = vma_modify_flags(vmi, *prev, vma, start, end, new_vma_flags);
> 	if (IS_ERR(vma)) {
> 		ret = PTR_ERR(vma);
> 		goto out;
[...]

